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

        //constructor handling
		var fnew = fields.find(function(f) return f.name=="new");

		if (fnew!=null)
			Context.warning("Custom Tag's should not have a constructor, 'new' function",fnew.pos);

		fields.push({
			name:"new",
			pos:Context.currentPos(),
			kind:FFun({
				expr:macro {super();},
				ret: macro : Void,
				args:[]
			})
		});
		

		//tag
		
		var noTagMeta =klass.meta.getMeta(":noTag");
		if (noTagMeta==null){
			var tagMeta =klass.meta.getMeta(":tag");
			var tag = if (tagMeta!=null && tagMeta.length==1) tagMeta[0].getValue();
				else klass.pack.join("-")+"-"+klass.name.uncamelize();

			klass.meta.add(":keepInit",[],klass.pos);



			fields.push({
				name:"TAG",
				access:[APublic,AStatic,AInline],
				kind:FVar(macro : String,macro $v{tag}),
				pos:Context.currentPos()
			});		
		
			fields.push({
				name:"create",
				pos:pos,
				access:[APublic,AStatic,AInline],
				kind:FFun( {
					expr:macro return untyped js.Browser.document.createElement($v{tag}),
					ret:type,
					args:[]
				})
			});		

			fields.push({
				name:"Element",
				pos:pos,
				access:[AStatic, APublic],
				meta:[{name:":keep",pos:pos}],
				kind:FVar(type, macro untyped js.Browser.document.registerElement($v{tag},{prototype:$i{className}.prototype}))
			});
		}



		

		for (f in fields) {
			switch(f.kind) {
				case FFun(_) if (~/(creat|attach|detach|attributeChang)edCallback/g.match(f.name)):
					f.meta.add(":keep",[],f.pos);
				case _:
			}
		}
		for (f in fields.copy()){
			var fname=f.name;
			switch (f.kind) {
				case FVar(t,e):
					var fw=f.meta.getMeta(":Attribute");
					if (fw!=null){
 						f.kind=FProp("get","set",t,e);
						var eget,eset;
						if (t.unify(macro :Bool)){
							eget=macro return this.hasAttribute($v{fname});
							eset=macro return hxtag.dom.tools.Attribute.toggleAtt(this, $v{fname},v);
						}else if (t.unify(macro :String)){
							eget=macro return this.getAttribute($v{fname});
							eset=macro return cast this.setAttribute($v{fname},v);							
						}

						var get={
							name:'get_$fname',
							kind:FFun({
								expr: eget,
								ret: t,
								args: []
							}),
							access: [AInline],
							pos:f.pos,
							meta:[]
						};
						var set={
							name:'set_$fname',
							kind:FFun({
								expr: eset,
								ret: t,
								args: [{name:"v",type: t}]
							}),
							access: [AInline],
							pos:f.pos,
							meta:[]
						}
						fields.push(get);						
						fields.push(set);
					}else{

					}
					
				case FProp(get,set,t,e):
				case FFun(f):
			}
		}
		return fields;
	}
	


}