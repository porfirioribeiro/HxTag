//
// HxTag - Custom Elements for Haxe-JS
// https://github.com/porfirioribeiro/HxTag/blob/master/LICENSE

package hxtag;

/**
 * ...
 * @author Porfirio
 */
@:keepInit
class IconSets
{
	function new(){}
	//static function __init__() {
		//untyped __js__('var __iconSets = { }');
	//}
	public static inline function has(name:String) : Bool{
		return untyped __js__("({0} in __iconSets)",name);
	}

	/**
	 * Get the IconSet registed with the specified name 
	 * @param	name IconSet name
	 * @return The required IconSet or null if it's not found
	 */
	public static inline function get(name:String) : Null<IconSet>{
		return untyped __js__('__iconSets[{0}]',name);
	}
	
	public static inline function register(name:String, iconset:IconSet) {
		untyped __js__('__iconSets.{0}={1}', name, iconset);
	}
}