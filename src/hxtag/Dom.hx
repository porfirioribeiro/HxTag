//
// HxTag - Custom Elements for Haxe-JS
// https://github.com/porfirioribeiro/HxTag/blob/master/LICENSE

package hxtag;



#if (macro || display)
import haxe.macro.Expr;
import haxe.macro.Context;
using macrox.Tools;
#end
using hxtag.tools.StringTools;

class Dom {

	#if !macro
	public static var window(get, never):js.html.Window;
	inline static function get_window() return untyped __js__("window");

	public static var document(get, never):js.html.HTMLDocument;
	inline static function get_document() return untyped __js__("window.document");

	public static var console(get, never):js.html.Console;
	inline static function get_console() return untyped __js__("console");
	#end

	/**
	 * Query the DOM for one matching element
	 * @param	query
	 * @param	t Optional infered type. Warning: no cast check is done!
	 */
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
			Context.getType(t.toString()).aType();
		return macro (cast $q : $type);
	}
	
	/**
	 * Query the DOM for all matching elements
	 * @param	query
	 */
	macro public static function qA(query:String){
		var qs=query.substr(1);
		var q= if (~/^#[a-zA-Z]*$/ .match(query)) macro [hxtag.Dom.document.getElementById($v{qs})];
		else   if (~/^\.[a-zA-Z]*$/.match(query)) macro hxtag.Dom.document.getElementsByClassName($v{qs});
		else   if (~/^[a-zA-Z]*$/  .match(query)) macro hxtag.Dom.document.getElementsByTagName($v{query});
		else 							          macro hxtag.Dom.document.querySelectorAll($v{query});
		return macro ($q : hxtag.dom.ElementList);
	}

	/**
	 * Query the DOM, on the specified context, for all matching elements
	 * @param	ctx
	 * @param	query
	 */
	macro public static function find(ctx:Expr,query:String){
		var qs=query.substr(1);
		var q= if (~/^\.[a-zA-Z]*$/.match(query)) macro $ctx.getElementsByClassName($v{qs});
		else   if (~/^[a-zA-Z]*$/  .match(query)) macro $ctx.getElementsByTagName($v{query});
		else 							          macro $ctx.querySelectorAll($v{query});
		return macro ($q : hxtag.dom.ElementList);
	}

	/**
	 * Shortcut to document.createElement(name) that try to return the correct type for the tag name specified
	 * @param	name The tag name
	 * @param	t Optional infered type. Warning: no cast check is done!
	 */
	macro public static function create<T>(name:String,t:Expr=null):ExprOf<T>{
		var ts = t.toString();
		var type=if (ts == "null")
			try{
				Context.getType(tagToClass(name)).aType();
			}catch(e:Dynamic){
				macro : js.html.Element;
			}
		else
			Context.getType(ts).aType();
		return macro (cast hxtag.Dom.document.createElement($v{name}) : $type);
	}

	static function tagToClass(tag:String){
		return switch (tag){
			case 'a':'js.html.AnchorElement';
			case 'br': 'js.html.BRElement';
			case t if (t.indexOf("-") != -1):
				var p = t.split("-");
				var k = p.pop();
				p.join(".") + '.' + k.capitalize();
			case t : 'js.html.'+t.capitalize()+'Element';
		};
	}
}
