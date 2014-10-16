//
// HxTag - Custom Elements for Haxe-JS
// https://github.com/porfirioribeiro/HxTag/blob/master/LICENSE

package hxtag;



#if (macro || display)
import haxe.macro.Expr;
import haxe.macro.Context;
using haxe.macro.Tools;
#end

class Dom {

	#if !macro
	public static var window(get, never):js.html.DOMWindow;
	inline static function get_window() return untyped __js__("window");

	public static var document(get, never):js.html.Document;
	inline static function get_document() return untyped __js__("window.document");
	
	public static var console(get, never):js.html.Console;
	inline static function get_console() return untyped __js__("console");
	#end

	macro public static function q(query:String, t:Expr=null){
		var qs=query.substr(1);
		var q= if (~/^#[a-zA-Z]*$/ .match(query)) macro hxtag.Dom.document.getElementById($v{qs});
		else   if (~/^\.[a-zA-Z]*$/.match(query)) macro hxtag.Dom.document.getElementsByClassName($v{qs})[0];
		else   if (~/^[a-zA-Z]*$/  .match(query)) macro hxtag.Dom.document.getElementsByTagName($v{query})[0];
		else 							          macro hxtag.Dom.document.querySelector($v{query});
		var ts = t.toString();
		var type=if (ts == "null")
			macro : js.html.Element;
		else
			Context.getType(t.toString()).toComplexType();
		return macro (cast $q : $type);
	}

	macro public static function qA(query:String){
		var qs=query.substr(1);
		var q= if (~/^#[a-zA-Z]*$/ .match(query)) macro [hxtag.Dom.document.getElementById($v{qs})];
		else   if (~/^\.[a-zA-Z]*$/.match(query)) macro hxtag.Dom.document.getElementsByClassName($v{qs});
		else   if (~/^[a-zA-Z]*$/  .match(query)) macro hxtag.Dom.document.getElementsByTagName($v{query});
		else 							          macro hxtag.Dom.document.querySelectorAll($v{query});
		return macro ($q : hxtag.dom.ElementList);
	}

	macro public static function find(ctx:Expr,query:String){
		var qs=query.substr(1);
		var q= if (~/^\.[a-zA-Z]*$/.match(query)) macro $ctx.getElementsByClassName($v{qs});
		else   if (~/^[a-zA-Z]*$/  .match(query)) macro $ctx.getElementsByTagName($v{query});
		else 							          macro $ctx.querySelectorAll($v{query});
		return macro ($q : hxtag.dom.ElementList);
	}


}