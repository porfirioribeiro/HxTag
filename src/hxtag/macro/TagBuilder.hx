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
		var type:AType = Context.getLocalType();
		var pos = Context.currentPos();

		if (klass.superClass==null || !klass.superClass.t.get().unify(macro : js.html.Element))
			Context.fatalError('Class $className don\'t extends js.html.Element',klass.pos);

        //constructor handling
		var fnew = fields.find(function(f) return f.name=="new");

		if (fnew!=null)
			Context.warning("Custom Tag's should not have a constructor, 'new' function",fnew.pos);

		fields.push({
			name:"new",
			pos:pos,
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
			var tag = klass.pack.join("-")+"-"+klass.name.uncamelize();
            if (tagMeta != null && tagMeta.length == 1)
                tag=tagMeta[0].getValue();
			else
                klass.meta.add(":tag", [macro $v{tag}],klass.pos);

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
					expr:macro return untyped hxtag.Dom.document.createElement($v{tag}),
					ret:type,
					args:[]
				})
			});

			var jsClassName = if (!Context.defined("js-unflatten")) className.replace(".", "_") else className;
			fields.push({
				name:"Element",
				pos:pos,
				access:[AStatic, APublic],
				meta:[{name:":keep",pos:pos}],
				kind:FVar(type, macro untyped hxtag.Dom.document.registerElement($v{tag},{prototype:$i{jsClassName}.prototype}))
			});
		}

		var createdCallback;
		var attributeChangedCallback;

		for (f in fields) {
			switch(f.kind) {
				// case FFun(_) if (~/(creat|attach|detach|attributeChang)edCallback/g.match(f.name)):
				// 	f.meta.add(":keep",[],f.pos);
				case FFun(fn):
					if (~/(creat|attach|detach|attributeChang)edCallback/g.match(f.name))
						f.meta.add(":keep",[],f.pos);
					if (f.name=="createdCallback"){
						createdCallback=fn;
					} else if (f.name=="attributeChangedCallback")
						attributeChangedCallback=fn;
				case _:
			}
		}
		var createdCallbackExprs:Array<Expr>=[];
		var attributeChangedCallbackExprs:Array<Expr>=[];
		var observers:Array<String>=[];
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
							eset=macro return cast hxtag.dom.tools.Attribute.toggleAttTo(this, $v{fname},v);
						}else if (t.unify(macro :String)){
							eget=macro return this.getAttribute($v{fname});
							eset=macro return cast this.setAttribute($v{fname},v);
						}
						var changedFnName=fname+'_changed';
						//TODO maybe validate arguments
						var changedFn=fields.find(function(f) return f.name==changedFnName && f.kind.match(FFun(_)));
						if (changedFn!=null){
							observers.push(f.name);						}
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
		var createdCallbackExpr:Expr=macro {};
		for (name in observers){
			createdCallbackExpr=macro {if (this.hasAttribute($v{name})) $i{name+"_changed"}(null,$i{name});$createdCallbackExpr; };
		}
		if (createdCallback!=null){
			createdCallback.expr=macro {$createdCallbackExpr; ${createdCallback.expr}};
		} else {
			fields.push({
				name:"createdCallback",
				meta:[{"name":":keep",pos:pos}],
				pos:pos,
				access:[],
				kind:FFun( {
					expr:createdCallbackExpr,
					ret:macro : Void,
					args:[]
				})
			});
		}
		var attributeChangedCallbackExpr:Expr=macro {};
		var aCC=attributeChangedCallback;
		var arg_name=(aCC!=null)?aCC.args[0].name:"name";
		var arg_old =(aCC!=null)?aCC.args[1].name:"o";
		var arg_new =(aCC!=null)?aCC.args[2].name:"n";
		for (name in observers){
			attributeChangedCallbackExpr=macro {if ($i{arg_name}==$v{name}) $i{name+"_changed"}($i{arg_old},$i{arg_new});$attributeChangedCallbackExpr;};
		}
		if (aCC!=null){
			attributeChangedCallback.expr=macro {$attributeChangedCallbackExpr; ${attributeChangedCallback.expr}};
		}else{
			fields.push({
				name:"attributeChangedCallback",
				meta:[{"name":":keep",pos:pos}],
				pos:pos,
				access:[],
				kind:FFun( {
					expr:attributeChangedCallbackExpr,
					ret:macro : Void,
					args:[
						{name:arg_name,type:macro : String},
						{name:arg_old ,type:macro : String},
						{name:arg_new ,type:macro : String}
					]
				})
			});
		}
		return fields;
	}



}
