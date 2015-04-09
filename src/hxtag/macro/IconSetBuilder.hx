//
// HxTag - Custom Elements for Haxe-JS
// https://github.com/porfirioribeiro/HxTag/blob/master/LICENSE

package hxtag.macro;
import haxe.macro.Type.ClassType;
#if (macro || display)
import haxe.macro.Context;
import haxe.macro.Expr;

using hxtag.macro.Tools;
using StringTools;
/**
 * ...
 * @author Porfirio
 */
class IconSetBuilder{

	public static function build():Array<Field> {
		var fields = Context.getBuildFields();
		var klass = Context.getLocalClass().get();
		var className = Context.getLocalClass().toString();
		var type:AType = Context.getLocalType();
		var pos = Context.currentPos();
		return fields;
	}
	public static function autoBuild():Array<Field> {
		var fields = Context.getBuildFields();
		var klass = Context.getLocalClass().get();
		var className = Context.getLocalClass().toString();
		var type:AType = Context.getLocalType();
		var pos = Context.currentPos();
		var name = getName(klass);
		//trace(name);

		klass.meta.add(':keepInit', [], pos);
		fields.push({
			name:"__init__",
			pos:pos,
			access:[APublic, AStatic, AInline],
			meta:[{
				name:":keep",
				pos:pos
			}],
			kind:FFun( {
				expr:macro untyped hxtag.IconSet.__iconSets[$v{name}]=new $type(),
				ret:macro : Void,
				args:[]
			})
		});	
	
		return fields;
	}
	
	public static function getName(klass:ClassType):String {
		var nameMeta = klass.meta.extract(":name_");
		if (nameMeta.length > 0)
			if (nameMeta[0].params.length > 0)
				return nameMeta[0].params[0].getValue();
		return klass.name.replace("IconSet", "").toLowerCase();
	}
	
}
#end