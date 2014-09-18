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
	#end

	macro public static function q(query:String){
		var qs=query.substr(1);
		var q= if (~/^#[a-zA-Z]*$/ .match(query)) macro js.Browser.document.getElementById($v{qs});
		else   if (~/^\.[a-zA-Z]*$/.match(query)) macro js.Browser.document.getElementsByClassName($v{qs})[0];
		else   if (~/^[a-zA-Z]*$/  .match(query)) macro js.Browser.document.getElementsByTagName($v{query})[0];
		else 							          macro js.Browser.document.querySelectorAll($v{query})[0];
		return macro (cast $q : js.html.Element);
	}

	macro public static function qA(query:String){
		var qs=query.substr(1);
		var q= if (~/^#[a-zA-Z]*$/ .match(query)) macro [js.Browser.document.getElementById($v{qs})];
		else   if (~/^\.[a-zA-Z]*$/.match(query)) macro js.Browser.document.getElementsByClassName($v{qs});
		else   if (~/^[a-zA-Z]*$/  .match(query)) macro js.Browser.document.getElementsByTagName($v{query});
		else 							          macro js.Browser.document.querySelectorAll($v{query});
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