//
// HxTag - Custom Elements for Haxe-JS
// https://github.com/porfirioribeiro/HxTag/blob/master/LICENSE

package hxtag.tools;

class UID 
{

	static function __init__(){
		untyped __js__("window.uid_next=0");
	}
	public static var next(get,never):Int;

	static inline function get_next() return untyped (window.uid_next++); 

}