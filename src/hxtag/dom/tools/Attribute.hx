package hxtag.dom.tools;

//typedef Element = js.html.DOMElement;
import hxtag.dom.Element;
/**
 * ...
 * @author ...
 */
class Attribute {
	
	public static function toggleAtt(e:Element, name:String, v:Bool):Bool 
		return (v)?cast e.setAttribute(name, ""):cast e.removeAttribute(name);
	
	public static inline function getAtt(e:Element, name:String):String 
		return e.getAttribute(name);	
		
	public static inline function setAtt(e:Element, name:String, v:String):Void 
		e.setAttribute(name, v);
	
	
}