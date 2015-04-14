//
// HxTag - Custom Elements for Haxe-JS
// https://github.com/porfirioribeiro/HxTag/blob/master/LICENSE

package hxtag;
import hx.Icon;

/**
 * ...
 * @author Porfírio
 */
@:autoBuild(hxtag.macro.IconSetBuilder.autoBuild())
@:build(hxtag.macro.IconSetBuilder.build())
@:keepInit
class IconSet {
	@:noCompletion
	public static var __iconSets:Dynamic;
	static function __init__() {
		__iconSets = { };
	}
	public static var ID:String;

	public static inline function has(name:String) : Bool{
		return untyped __js__("({0} in {1})",name,__iconSets);
	}

	/**
	 * Get the IconSet registed with the specified name 
	 * @param	name IconSet name
	 * @return The required IconSet or null if it's not found
	 */
	public static inline function get(name:String) : Null<IconSet>{
		return untyped __iconSets[name];
	}

	public function new() {}

	public var iconSize:Int;

	/**
	 * Apply the icon of this IconSet in the target Icon
	 * @param	icon Target Icon element
	 * @param	name Name of the icon in this IconSet
	 */
	public function applyIcon(icon:Icon, name:String) {

	}


}
