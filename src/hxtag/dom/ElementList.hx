//
// HxTag - Custom Elements for Haxe-JS
// https://github.com/porfirioribeiro/HxTag/blob/master/LICENSE

package hxtag.dom;
#if macro
import haxe.macro.Expr;
typedef Node= {};
#else
import js.html.HTMLCollection;
import js.html.NodeList;
import js.html.Node;
import js.html.Element;
#end

/**
 * ...
 * @author Porfirio
 */
//@:arrayAccess
abstract ElementList(ArrayAccess<Node>)  {
	#if !macro
	@:from static public inline function fromNodeList(list:NodeList): ElementList 
		return cast list;
		
	static public inline function fromNodeList2(list:NodeList): ElementList 
		return cast list;
	
	@:from static public inline function fromHTMLCollection(list:HTMLCollection): ElementList 
		return cast list;
	
	@:from static public inline function fromNodeArray(list:Array<Node>): ElementList 
		return cast list;
	
	@:to public inline function toNodeArray(): Array<Node>
		return untyped untyped __js__("Array.prototype.slice.call")(this);
		
	@:arrayAccess public inline function arrayAccess(i:Int):Element
        return cast this[i];

    static public inline function getById(id:String): ElementList
		return cast [hxtag.Dom.document.getElementById(id)];
	static public inline function getByTagName(tag:String): ElementList
		return cast hxtag.Dom.document.getElementsByTagName(tag);
	static public inline function getByClassName(name:String): ElementList
		return cast hxtag.Dom.document.getElementsByClassName(name);
	static public inline function getByQuery(query:String): ElementList
		return cast hxtag.Dom.document.querySelectorAll(query);
		
	public inline function each(callback:Element -> Void)
		for (e in 0...length) callback(untyped this[e]);//Todo fix this untyped!!!

	public inline function forEach(e:Element -> Void, ethis:Dynamic=null): Void 
		untyped __js__("Array.prototype.forEach.call")(this, e, ethis);

	public inline function filter(e:Element -> Bool): ElementList 
		return untyped __js__("Array.prototype.filter.call")(this, e);

	public inline function concat(el:ElementList): ElementList 
		return untyped __js__("Array.prototype.concat.apply")(this, el);


	public var length(get,never):Int;
	inline function get_length(){
		return untyped this.length;
	}
	


	#else

	#end
	
}