package hxtag.dom.tools;

//typedef Element = js.html.DOMElement;
import hxtag.dom.Element;
/**
 * ...
 * @author ...
 */
class Attribute {
	public static function toggleAttTo(e:Element, name:String, v:Bool) 
		(v)? e.setAttribute(name, ""):e.removeAttribute(name);
	
	public static function toggleAtt(e:Element, name:String) 
		e.hasAttribute(name)? e.removeAttribute(name) : e.setAttribute(name, "");
	
	public static inline function getAtt(e:Element, name:String):String 
		return e.getAttribute(name);	
		
	public static inline function setAtt(e:Element, name:String, v:String):Void 
		e.setAttribute(name, v);
}