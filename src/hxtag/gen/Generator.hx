//
// HxTag - Custom Elements for Haxe-JS
// https://github.com/porfirioribeiro/HxTag/blob/master/LICENSE

package hxtag.gen;
import haxe.macro.Compiler;
import haxe.macro.Context;
import haxe.macro.Type;
import haxe.macro.Expr;
import haxe.macro.JSGenApi;
using haxe.macro.Tools;
using Lambda;
using StringTools;

class Generator  {

	var api : JSGenApi;
	var buf : StringBuf;
	var inits : List<TypedExpr>;
	var statics : List<{ c : ClassType, f : ClassField }>;
	var packages : haxe.ds.StringMap<Bool>;
	var forbidden : haxe.ds.StringMap<Bool>;
	var jsModern:Bool;
	var jsFlatten:Bool;
	var dce:Bool;
	var indentLevel=0;
	var genExtend=false;
	var genExpose=false;

	var iRE=~/^(.*)$/gm;

	public function new(api) {
		this.api = api;
		buf = new StringBuf();
		inits = new List();
		statics = new List();
		packages = new haxe.ds.StringMap();
		forbidden = new haxe.ds.StringMap();
		jsModern=!Context.defined("js-classic");
		jsFlatten=Context.defined("js-flatten");
		dce=Context.definedValue("dce")!="no";
		for( x in ["prototype", "__proto__", "constructor"] )
			forbidden.set(x, true);
		api.setTypeAccessor(getType);

		for (t in api.types){
			switch (t) {
				case TInst(c,_): 
					if (!c.get().isExtern && c.get().superClass!=null)
						genExtend=true;
					if (c.get().meta.has(":expose"))
						genExpose=true;
					if (genExtend && genExpose) break;
				case _:
			}
		}
	}

	function getType( t : Type ) {
		return switch(t) {
			case TInst(c, _): getPath(c.get());
			case TEnum(e, _): getPath(e.get());
			case TAbstract(a, _): getPath(a.get());
			default: throw "assert";
		};
	}
	inline function indent(str:String,level=0,notFirst=false):String{
		var first=true;
		var lines=str.split("\n");
		var nstr="";
		for (i in 0...lines.length){
			var s=lines[i];
			var line=s;
			if (first && notFirst){
				first=false;
			}else{
				for (a in 0...level){
					line='\t'+line;
				}
			}				
			if (i<lines.length-1)
				line+="\n";
			nstr+=line;
		}
		return nstr;
	}

	inline function print(str) 
		printi(str,indentLevel);
	inline function printi(str,level=0,notFirst=false) 		
		buf.add(indent(str,level,notFirst));
	inline function println(s:String="")
		print('$s;\n');
	inline function printn(s:String="")
		buf.add(indent(s,indentLevel)+"\n");
	inline function printin(str,level=0,notFirst=false) 
		buf.add(indent(str,level,notFirst)+"\n");

	inline function newline() 
		buf.add(";\n");
	

	function field(p, staticField=true) {
		if (staticField)
			return api.isKeyword(p) ? '["$p"]' : '.$p';
		else
			return api.isKeyword(p) ? '\'$p\'' : p;
	}

	function genPackage( p : Array<String> ) {
		if (jsFlatten)
			return print("var ");
		if (p.length==0)
			print("var ");
		var full = null;
		for( x in p ) {
			var prev = full;
			if( full == null ) full = x else full += "." + x;
			if( packages.exists(full) )
				continue;
			packages.set(full, true);
			if( prev == null )
				println('var $x = '+(jsModern?"{}":'$x || {}') );
			else {
				var p = prev + field(x);
				println((jsModern?'':'if(!$p) ')+'$p = {}');
			}
		}
	}

	function getPath( t : BaseType ) {
		return packClass(t.pack,t.name);
	}
	function getDotPath( t : BaseType ) {
		return (t.pack.length == 0) ? t.name : t.pack.join('.') + '.' + t.name;
	}

	function packClass(p:Array<String>,name:String){
		if (jsFlatten){
			var r='';
			for (i in p){
				r+=i.replace("_","_$")+'_';
			}
			return r+name.replace("_","_$");
		}
		return (p.length == 0) ? name : p.join('.') + '.' + name;		
	}
	function resolveClassOptions(c:ClassType):ClassOptions{
		var has_class = api.hasFeature("js.Boot.getClass") && (c.superClass != null || c.fields.get().length > 0 || c.constructor != null);
		return {
			c:c,
			path: getPath(c),
			dotPath: getDotPath(c),
			hasHxClasses: api.hasFeature("Type.resolveClass"),
			hasExpose: c.meta.has(":expose"),
			hasPropertyReflection: api.hasFeature("Reflect.getProperty") || api.hasFeature("Reflect.setProperty"),
			hasClass: has_class,
			hasPrototype: has_class || c.superClass != null || c.fields.get().length > 0
		}		
	}
	function checkFieldName( c : ClassType, f : ClassField ) {
		if( forbidden.exists(f.name) )
			Context.error("The field " + f.name + " is not allowed in JS", c.pos);
	}

	function genClassField( c : ClassType, p : String, f : ClassField , first:Bool) {
		checkFieldName(c, f);
		var field = field(f.name,false);
		var e=f.expr();
		if (e!=null){
			printin((first?"":",")+'$field: '+api.generateValue(e) ,indentLevel,false);
			return false;
		}else if (!dce && (f.kind.match(FVar(AccNormal, AccNormal) | FMethod(_)) || f.meta.has(":isVar"))){
			printin((first?"":",")+'$field: null' ,indentLevel,false);
			return false;
		}
		return first;
	}


	function genStaticField( c : ClassType, p : String, f : ClassField ) {
		checkFieldName(c, f);
		var field = field(f.name);
		var e = f.expr();
		if( e != null ) {
			switch( f.kind ) {
			case FMethod(_):
				print('$p$field = ');
				println(api.generateValue(e));
			default:
				statics.add( { c : c, f : f } );
			}
		} else{
			if (!dce && (f.kind.match(FVar(AccNormal, AccNormal)  | FMethod(_)) || f.meta.has(":isVar")))
				println('$p$field = null');
		}
	}

	function getProperties(fields:Array<ClassField>):String{
		var properties=[];
		for (f in fields){
			switch (f.kind) {
				case FVar(g,s):{
					if (g==AccCall)
						properties.push('get_${f.name}:"get_${f.name}"');
					if (s==AccCall)
						properties.push('set_${f.name}:"set_${f.name}"');
				}
				case _:
			}
		}
		return (properties.length>0)?('{'+properties.join(",")+'}'):"";
	}

	function getClassConstructor(c: ClassType){
		if( c.constructor != null )
			return api.generateValue(c.constructor.get().expr());
		else
			return "function() { }";		
	}

	function genClass__name__(op:ClassOptions){
		var p=op.path;
		var name = op.dotPath.split(".").map(api.quoteString).join(",");
		if (api.hasFeature("js.Boot.isClass")){
			if (api.hasFeature("Type.getClassName"))
				println('$p.__name__ = [$name]');
			else
				println('$p.__name__ = true');			
		}		
	}

	function genClass( c : ClassType ) {
		api.setCurrentClass(c);
		var op:ClassOptions=resolveClassOptions(c);

		var p = op.path;
		var pn= op.dotPath;

		genPackage(c.pack);

		if (op.hasHxClasses && !jsModern)
			print('$p = $$hxClasses["$pn"] = ');
		else
			print('$p = '+(op.hasExpose?'$$hx_exports.$p = ':''));
		println(getClassConstructor(c));
		if (op.hasHxClasses && jsModern)
			println('$$hxClasses["$pn"] = $p');

		genClass__name__(op);

		if( c.interfaces.length > 0 ) {
			var me = this;
			var inter = c.interfaces.map(function(i) return me.getPath(i.t.get())).join(",");
			println('$p.__interfaces__ = [$inter]');
		}

		if (op.hasPropertyReflection){
			var staticProperties=getProperties(c.statics.get());
			if (staticProperties.length>0)
				printn('$p.__properties__ = $staticProperties');
		}
		for( f in c.statics.get() )
			genStaticField(c, p, f);


		if (op.hasPrototype){
			if( c.superClass != null ) {
				var psup = getPath(c.superClass.t.get());
				println('$p.__super__ = $psup');
				printn('$p.prototype = $$extend($psup.prototype,{');
			}else{
				printn('$p.prototype = {');
			}
			indentLevel++;
			var first=true;
			for( f in c.fields.get() ) {
				switch( f.kind ) {
				case FVar(r, _):
					if( r == AccResolve ) continue;
				default:
				}
				first=genClassField(c, p, f, first);
			}
			if (op.hasClass){
				if(!first)
					print(",");
				printi('__class__: $p\n');
			}
			if (op.hasPropertyReflection){
				var properties=getProperties(c.fields.get());
				if (properties.length>0)
					if( c.superClass != null ) {
						var psup = getPath(c.superClass.t.get());
						printn((first?"":",")+'__properties__: $$extend($psup.prototype.__properties__,$properties)');
					} else
						printn((first?"":",")+'__properties__: $properties');
			}
			indentLevel--;
			if( c.superClass != null )
				printin("});",0);
			else
				printin("};",0);
		}


	}

	function genEnum( e : EnumType ) {
		var p = getPath(e);
		var pn= getDotPath(e);
		var names = pn.split(".").map(api.quoteString).join(",");
		var constructs = e.names.map(api.quoteString).join(",");
		var hxClasses=api.hasFeature("Type.resolveEnum");

		genPackage(e.pack);

		if (hxClasses)
			print('$p = $$hxClasses["$pn"] = {');
		else
			print('$p = {');

		if (api.hasFeature("js.Boot.isEnum"))
			if (api.hasFeature("Type.getEnumName"))
				print(' __ename__ : [$names],');
			else
				print(' __ename__ : true,');
		println(' __constructs__ : [$constructs] }');
		for( c in e.constructs.keys() ) {
			var c = e.constructs.get(c);
			var f = field(c.name);
			print('$p$f = ');
			switch( c.type ) {
			case TFun(args, _):
				var sargs = args.map(function(a) return a.name).join(",");
				print('function($sargs) { var $$x = ["${c.name}",${c.index},$sargs]; $$x.__enum__ = $p; $$x.toString = $$estr; return $$x; }');
			default:
				println("[" + api.quoteString(c.name) + "," + c.index + "]");
				if (api.hasFeature("may_print_enum"))
					println('$p$f.toString = $$estr');
				print('$p$f.__enum__ = $p');
			}
			newline();
		}
		if (api.hasFeature("Type.allEnums")){
			var ec=Lambda.fold(e.constructs, function(c:EnumField, r:Array<String>) {
				if (!c.type.match(TFun(_,_)))
					r.push('$p.${c.name}');
			    return r; 
			}, []); 
			if (ec.length>0)
				println('$p.__empty_constructs__ = ['+ec.join(",")+']');
		}
		var meta = api.buildMetaData(e);
		if( meta != null ) {
			print('$p.__meta__ = ');
			println(api.generateValue(meta));
		}
	}

	function genType( t : Type ) {
		switch( t ) {
		case TInst(c, _):
			var c = c.get();
			if( c.init != null )
				inits.add(c.init);
			if( !c.isExtern ) genClass(c);
		case TEnum(r, _):
			var e = r.get();
			if( !e.isExtern ) genEnum(e);
		default:
		}
	}

	public function generate() {
		if (jsModern)
			println('(function ('+(genExpose?"$hx_exports":"")+') { "use strict"');

		var vars = [];
		if (api.hasFeature("Type.resolveClass") || api.hasFeature("Type.resolveEnum"))
			vars.push("$hxClasses = " + (jsModern? "{}" : "$hxClasses || {}"));
		if (api.hasFeature("may_print_enum"))
			vars.push("$estr = function() { return "+packClass(["js"],"Boot")+".__string_rec(this,''); }");
		if (vars.length>0)
			println("var "+vars.join(","));

		if(genExtend)
			print("function $extend(from, fields) {
	function Inherit() {} Inherit.prototype = from; var proto = new Inherit();
	for (var name in fields) proto[name] = fields[name];
	if( fields.toString !== Object.prototype.toString ) proto.toString = fields.toString;
	return proto;
}\n");

		for( t in api.types )
			genType(t);

		if (api.hasFeature("use.$iterator")){
			api.addFeature("use.$bind");
			printn("function $iterator(o) { if( o instanceof Array ) return function() { return HxOverrides.iter(o); }; return typeof(o.iterator) == 'function' ? $bind(o,o.iterator) : o.iterator; }");
		}		
		if (api.hasFeature("use.$bind")){
			println("var $_, $fid = 0");
			printn("function $bind(o,m) { if( m == null ) return null; if( m.__id__ == null ) m.__id__ = $fid++; var f; if( o.hx__closures__ == null ) o.hx__closures__ = {}; else f = o.hx__closures__[m.__id__]; if( f == null ) { f = function(){ return f.method.apply(f.scope, arguments); }; f.scope = o; f.method = m; o.hx__closures__[m.__id__] = f; } return f; }");
		}
		for( e in inits ) 
			genInit(e);
		for( s in statics ) 
			println(getPath(s.c)+field(s.f.name)+' = '+api.generateValue(s.f.expr()));
		if( api.main != null ) 
			println(api.generateValue(api.main));
		if (jsModern)
			print('})('+(genExpose?'typeof window != "undefined" ? window : exports':'')+');\n');
		sys.io.File.saveContent(api.outputFile, buf.toString());
	}

	function genInit(e:TypedExpr){
		var code=api.generateStatement(e);
		var colon=';';
		for (l in code.split('\n')){
			if (l=="{" || l=="}") {
				colon='';
				continue;
			}
			printn(l.replace("\t","")+colon);
		}
	}

	static function use()
		Compiler.setCustomJSGenerator(function(api) new Generator(api).generate());
}

typedef TypeOptions={
	path:String,
	dotPath:String,
	hasHxClasses:Bool,
	hasExpose:Bool
}
typedef ClassOptions={>TypeOptions,
	c:ClassType,
	hasPropertyReflection:Bool,
	hasClass:Bool,
	hasPrototype:Bool
}