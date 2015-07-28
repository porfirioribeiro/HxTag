package demos.attributes;
import haxe.macro.Context;

//Todo remove this class...

#if macro
import haxe.macro.Expr;
import haxe.macro.Type;

import hxtag.macro.Metas;

using hxtag.macro.Tools;
#end

class Macros
{

	public function new() 
	{
		
	}
	
	public static macro function test():Array<Field> {
		var fields = Context.getBuildFields();
		var k = Context.getLocalClass().get();
		var t = Context.getLocalType().type();
		
		//var m = k.meta.get();
		
		//trace(Metas.Stylus.getMeta(k));
		//trace(Metas.Res.getMeta(k));
		trace(Metas.Stylus.existsOn(k));
		trace(Metas.Res.existsOn(k));
		
		
		
		for (f in fields) {
			trace(f.name,Metas.Attribute.check(f),f.meta);
		}
		return fields;
	}
	
}
