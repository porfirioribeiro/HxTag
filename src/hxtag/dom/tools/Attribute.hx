package hxtag.dom.tools;

/**
 * ...
 * @author ...
 */
class Attribute {
	
	public static function toggleAtt(e:js.html.Element, name:String, v:Bool):Bool 
		return (v)?cast e.setAttribute(name, ""):cast e.removeAttribute(name);
	
	public static inline function getAtt(e:js.html.Element, name:String):String 
		return e.getAttribute(name);	
		
	public static inline function setAtt(e:js.html.Element, name:String, v:String):Void 
		e.setAttribute(name, v);
	
	
}