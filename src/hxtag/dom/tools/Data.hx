//
// HxTag - Custom Elements for Haxe-JS
// https://github.com/porfirioribeiro/HxTag/blob/master/LICENSE

package hxtag.dom.tools;

using hxtag.DomTools;
import hxtag.dom.Element;
//import js.html.Element;

class Data {

	public static inline function hasData(e:Element, key:String): Bool
		return untyped !!e.dataset[key];

	public static inline function getData(e:Element, key:String): String
		return untyped e.dataset[key];	

	public static inline function setData(e:Element, key:String, value:String): String
		return untyped e.dataset[key]=value;
	


}