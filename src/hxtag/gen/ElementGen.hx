//
// HxTag - Custom Elements for Haxe-JS
// https://github.com/porfirioribeiro/HxTag/blob/master/LICENSE

package hxtag.gen;
import hxtag.macro.Tools;
import haxe.macro.Expr;
import haxe.macro.Type;
import haxe.macro.Compiler;
import haxe.macro.Context;
import hxtag.gen.Generator;

using hxtag.macro.Tools;
using Lambda;

class ElementGen extends Generator {

	override function genClass(c : ClassType){

		var meta=c.meta.get().find(function (m) return m.name==":registerElement");
		if (meta==null)
			return super.genClass(c);
		var className = c.toString();


		var tag=try{
			meta.params[0].getValue();
		}catch(e:Dynamic){
			Context.fatalError("Missing or bad parameter, should be in the form of @:registerElement(\"tag\")",meta.pos);
		}
			

		if (c.superClass==null)
			Context.fatalError("Class should extends js.html.Element",c.pos);

		api.setCurrentClass(c);
		var op:ClassOptions=resolveClassOptions(c);
		if (!op.hasPrototype)
			Context.fatalError("Class must have prototype",c.pos);
		var p=op.path;
		var pn=op.dotPath;
		var sup=c.superClass.t;
		genPackage(c.pack);
		var proto='${p}__prototype';

		printn('$proto=Object.create($sup.prototype, {');

		indentLevel++;
		var first=true;
		var code=[];
		var fields =c.fields.get();
		for( f in fields) {
			checkFieldName(c, f);
			var field = field(f.name,false);
			switch( f.kind ) {
				case FVar(_ => AccResolve, _): continue;
				case FMethod(_):
					if (!f.meta.has(':_field_accessorof'))
						code.push('$field:{value: '+api.generateValue(f.expr())+'}');
				case FVar(g,s):
					var pcode=[];
					var value=f.meta.getFirst(":_field_value");
//					trace(value);
					if (value!=null){							
						var v=api.generateValue(value.typeExpr());
						pcode.push("\tvalue: "+v);
					}
					if (f.meta.hasMeta(":_field_writable"))
						pcode.push('\twritable: true');
					if (f.meta.hasMeta(":_field_get")){
						var _get =fields.find(function(f) return f.name=='get_$field');
						pcode.push('\tget: ' + api.generateValue(_get.expr()));
					}						
					if (f.meta.hasMeta(":_field_set")){
						var _set =fields.find(function(f) return f.name=='set_$field');
						pcode.push('\tset: ' + api.generateValue(_set.expr()));
					}
					if (pcode.length>0)
						code.push('$field: {\n'+pcode.join(',\n')+'\n}'); 

				default:
			} 
			// first=genClassField(c, p, f, first);
		}
		printn(code.join(',\n'));
		indentLevel--; 
		printn('})');


		genPackage(c.pack); 

		if (op.hasHxClasses && !jsModern)
			print('$p = $$hxClasses["$pn"] = ');
		else
			print('$p = '+(op.hasExpose?'$$hx_exports.$p = ':''));

		printn('document.registerElement("$tag",{');
		indentLevel++;

		
		printn('prototype: $proto');
		
	
		// printn(',"extends":"input"');
		indentLevel--;
		printn('});');
		//Workarround for firefox created object don't have prototype property, so we can't use instanceof
		println('if (!${p}.prototype) ${p}.prototype=$proto');

		if( c.superClass != null ) {
			var psup = getPath(c.superClass.t.get());
			println('$p.__super__ = $psup');
		}
		if (op.hasHxClasses && jsModern)
			println('$$hxClasses["$pn"] = $p');

		genClass__name__(op);
	}

	static function use(){
		Compiler.setCustomJSGenerator(function(api) new ElementGen(api).generate());
	}
		
}