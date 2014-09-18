//
// HxTag - Custom Elements for Haxe-JS
// https://github.com/porfirioribeiro/HxTag/blob/master/LICENSE

package hxtag.tools;

#if !js

#end
#if macro
import haxe.macro.Expr;
import haxe.macro.Context;
#end

class StringTools {

	macro public static function matchRE(string:ExprOf<String>, e:ExprOf<EReg>){
		switch (e.expr) {
			case EConst(c):
				switch (c) {
					case CRegexp(re,opt):
					var myJSCode="/"+re+"/"+opt+".exec";
					return macro untyped __js__($v{myJSCode})($string); 
					case _:
				}
			case _:
		}
		Context.error("function StringTools.matchRE only works with regexp passed in arg like: StringTools.matchRE(str,~/ereg/)",Context.currentPos());
		return macro null;
	}
	/**
	 * Check the string againts the passed string
	 */
	public static inline function equals(string:String, text:String, insensitive:Bool=false):Bool
		return string == text;	
	/**
	 * Check the string againts the passed string, case insensitive
	 */
	public static inline function iequals(string:String, text:String):Bool
		return string.toLowerCase() == text.toLowerCase();
	/**
	 * Check if the string contains other string
	 */
	public static inline function contains(string:String,text:String):Bool
		return (string.indexOf(text) > -1);
	/**
	 * Check if the string starts with the other string
	 */
	public static inline function startsWith(string:String,text:String)
		return string.indexOf(text) == 0;
	/**
	 * Check if the string ends with the other string
	 */
	public static inline function endsWith(string:String,text:String)
		return string.indexOf(text) == (string.length - text.length);
	/**
	 * check if the string is empty
	 */
	public static inline function empty(string:String)
		return equals(string,"");
	/**
	 * check if the string is blank
	 */
	public static inline function blank(string:String)
		return untyped __js__("/^\\s*$/.test")(string);
	/**
	 * Check if the string is uppercased
	 */
	public static inline function isUpperCase(string:String)
		return string.toUpperCase() == string;
	/**
	 * Check if the string is lowercased
	 */
	public static inline function isLowerCase(string:String)
		return string.toLowerCase() == string;
	/**
	 * Make the first letter uppercase
	 */
	public static inline function capitalize(string:String)
		return string.charAt(0).toUpperCase() + string.substring(1).toLowerCase();
	/**
	 * Converts a css style to its Javascript name eg.: border-left-color to borderLeftColor
	 */
	public static /*inline*/ function camelize(string:String){
		var arr=string.split("-");
		for (i in 1...arr.length)
			arr[i]=capitalize(arr[i]);
		return arr.join("");
	}


	public static inline function uncamelize(string:String){
		#if js
		return untyped string.replace(__js__("/((?!^)[A-Z])/g"), "-$1").toLowerCase();
		#else
			return ~/((?!^)[A-Z])/g.replace(string,"-$1").toLowerCase();
		#end
	}
		

	public static inline function replace(string:String, sub : String, by : String)
		return string.split(sub).join(by);

	public static inline function ltrim(string:String)
		return untyped string.replace(untyped __js__("/(^\\s+)/g"),"");	

	public static inline function rtrim(string:String)
		return untyped string.replace(untyped __js__("/(\\s+$)/g"),"");	

	public static inline function trim(string:String)
		return untyped string.replace(untyped __js__("/((^\\s+)|(\\s+$))/g"),"");

	public static inline function toInt(string:String,radix:Int=10):Int
		return untyped __js__("parseInt")(string,radix);
	public static inline function toFloat(string:String):Float
		return untyped __js__("parseFloat")(string);

}