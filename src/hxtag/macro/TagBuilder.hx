//
// HxTag - Custom Elements for Haxe-JS
// https://github.com/porfirioribeiro/HxTag/blob/master/LICENSE

package hxtag.macro;

import haxe.macro.Expr;
import haxe.macro.Context;

using hxtag.macro.Tools;
using Lambda;
using StringTools;
using hxtag.tools.StringTools;

class TagBuilder 
{

	public static function build(){
		
		var fields = Context.getBuildFields();
		var klass = Context.getLocalClass().get();
		var className = Context.getLocalClass().toString();
		var type:Type = Context.getLocalType();
		var pos = Context.currentPos();
		
		if (klass.superClass==null || !klass.superClass.t.get().unify(macro : js.html.Element))
			Context.fatalError('Class $className don\'t extends js.html.Element',klass.pos);


		//tag
		
		var tagMeta =klass.meta.getMeta(":tag");
		var tag = if (tagMeta!=null && tagMeta.length==1) tagMeta[0].getValue();
            else klass.pack.join("-")+"-"+klass.name.uncamelize();

		klass.meta.add(":keep",[],klass.pos);
		klass.meta.add(":registerElement",[macro $v{tag}],klass.pos);


        fields.push({
        	name:"TAG",
        	access:[APublic,AStatic,AInline],
        	kind:FVar(macro : String,macro $v{tag}),
        	pos:Context.currentPos()
        });

        //constructor handling
		var fnew = fields.find(function(f) return f.name=="new");

		if (fnew!=null)
			Context.warning("Custom Tag's should not have a constructor, 'new' function",fnew.pos);

		fields.push({
			name:"new",
			pos:Context.currentPos(),
			kind:FFun({
				expr:macro {},
				ret: macro : Void,
				args:[]
			})
		});
		
		fields.push({
			name:"create",
			pos:pos,
			access:[APublic,AStatic],
			kind:FFun( {
				expr:macro return untyped js.Browser.document.createElement($v{tag}),
				ret:type,
				args:[]
			})
		});		
		
		fields.push({
			name:"Element",
			pos:pos,
			access:[AStatic],
			kind:FVar(type, macro untyped js.Browser.document.registerElement($v{tag},{prototype:$i{className}.prototype}))
		});
		
		for (f in fields.copy()){
			var fname=f.name;
			switch (f.kind) {
				case FVar(t,e):
					var fw=f.meta.getMeta(":Attribute");
					if (fw!=null && t.unify(macro :Bool)){
 						f.kind=FProp("get","set",t,e);
						var get={
							name:'get_$fname',
							kind:FFun({
								expr: macro return this.hasAttribute($v{fname}),
								ret: macro : Bool,
								args: []
							}),
							access: [/*AInline*/],
							pos:f.pos,
							meta:[]
						};
						var set={
							name:'set_$fname',
							kind:FFun({
								expr: macro {if (v) this.setAttribute($v{fname},""); else this.removeAttribute($v{fname}); return v;},
								ret: macro : Bool,
								args: [{name:"v",type: macro : Bool}]
							}),
							pos:f.pos,
							meta:[]
						}
						markFieldAccessorOf(get,fname);
						markFieldAccessorOf(set,fname);
						fields.push(get);						
						fields.push(set);
						addMeta(f,":_field_get");
						addMeta(f,":_field_set");
					}else{
						addMeta(f,":_field_writable");
						if (e!=null)
							addMeta(f,":_field_value",[e]);
					}
					
				case FProp(get,set,t,e):
					if (f.meta.hasMeta(":isVar"))
						Context.fatalError("@:isVar variables are not supported in this generator!",f.pos);
					if (e!=null)
						addMeta(f,":_field_value",[e]);
					

					if (get=="get"){
						addMeta(f,":_field_get");
						var fi=fields.find(function(f) return f.name=='get_$fname');
						markFieldAccessorOf(fi,fname);
					}					
					if (set=="set"){
						addMeta(f,":_field_set");
						var fi=fields.find(function(f) return f.name=='set_$fname');
						markFieldAccessorOf(fi,fname);
					}
					f.kind=FVar(t,e);
				case FFun(f):
			}
		}
		return fields;
	}
	
	static function addMeta(o:{meta:Metadata,pos:Position},name:String, params:Array<Expr>=null){
		if (o.meta==null) o.meta=[];
		if (params==null) params=[];
		o.meta.push({name:name,params:params,pos:o.pos});
	}
		
	static function markFieldAccessorOf(fi:Field,fname:String){
		fi.meta.push({name:":_field_accessorof",params:[macro $v{fname}],pos:fi.pos});
		fi.meta.push({name:":noUsing",params:[],pos:fi.pos});
		fi.meta.push({name:":noDoc",params:[],pos:fi.pos});
	}

}