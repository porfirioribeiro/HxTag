//
// HxTag - Custom Elements for Haxe-JS
// https://github.com/porfirioribeiro/HxTag/blob/master/LICENSE

package hxtag.dom.tools;


#if macro
import haxe.macro.Expr;
#else
// import hxtag.dom.Element;
import js.html.Element;
import js.html.Node;
import hxtag.dom.ElementList;
using hxtag.DomTools;
#end


class Traversing {
	// public static function find(e:ExprOf<Element>,query:String){

	// }

	macro public static function find(e:ExprOf<Element>,query:ExprOf<String>)
		return macro hxtag.Dom.find($e,$query);
	
	// macro public static function findAll(e:ExprOf<Element>,query:String)
	// 	return hxtag.Dom._query(e,query,true);

	#if !macro
	public static function add(e:Element){
		trace("add element"+e.className);
	}

	public static inline function is<T:Node>(e:Node,t:Class<T>):Bool
		return untyped __instanceof__(e,t);	

	public static inline function as<T:Node>(e:Node, t:Class<T>, check = false):T {
		if (check)
			return (untyped if (__instanceof__(e, t)) e );
		else
			return cast e;
		//return is(e,t)?cast e:null;
	}

	public static function parent(e:Element,selector:String=null):Element{
		var parent:Element = cast e.parentNode;
		if (selector!=null )
			return (parent!=null && parent.nodeType==Node.ELEMENT_NODE && parent.matches(selector))? parent:null;
		return (parent!=null && parent.nodeType != Node.DOCUMENT_FRAGMENT_NODE ) ? parent : null;
	}

	public static inline function parentT<T:Element>(e:Element,t:Class<T>):T
		return (untyped if (__instanceof__(e.parentNode, t)) e.parentNode );

	public static function parents(e:Element,selector:String=null):Element{
		return null;
	}
	public static function closest(e:Element,selector:String):Element{
		while(e!=null){
			if (e.nodeType==Node.ELEMENT_NODE && e.matches(selector))
				return e;
			e=cast e.parentNode;
		}
		return null;
	}
	public static function closestT<T:Element>(e:Element,t:Class<T>):T{
		while(e!=null){
			if (untyped __instanceof__(e, t))
				return cast e;
			e=cast e.parentNode;
		}
		return null;		
	}
	#end
}

class TraversingList{
	// public static function find(e:ExprOf<ElementList>,query:String){

	// }	
	macro public static function find(el:ExprOf<ElementList>,query:String){
		var qs=query.substr(1);
		var q= if (~/^\.[a-zA-Z]*$/.match(query)) macro hxtag.dom.TraversingList.findByClass(el,$v{qs});
		else   if (~/^[a-zA-Z]*$/  .match(query)) macro findByTag(el,$v{query});
		else 							          macro hxtag.dom.Traversing.TraversingList.findByQuery($v{query});
		return macro ($q : hxtag.dom.ElementList);
	}
	#if macro
	#else
	public static function add(el:ElementList){
		trace("add elementlist");
		el.each(function(e) Traversing.add(e));
	}

	public static function findByTag(el:ElementList,tag:String):ElementList{
		var r:ElementList=[];
		el.each(function (e) untyped __js__("Array.prototype.push.apply")(r, e.getElementsByTagName(tag)));
		return r;
	}	
	public static function findByClass(el:ElementList,tag:String):ElementList{
		var r:ElementList=[];
		el.each(function (e) untyped __js__("Array.prototype.push.apply")(r, e.getElementsByClassName(tag)));
		return r;
	}	
	public static function findByQuery(el:ElementList,tag:String):ElementList{
		var r:ElementList=[];
		el.each(function (e) untyped __js__("Array.prototype.push.apply")(r, e.querySelectorAll(tag)));
		return r;
	}
	#end
}