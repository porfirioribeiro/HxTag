//
// HxTag - Custom Elements for Haxe-JS
// https://github.com/porfirioribeiro/HxTag/blob/master/LICENSE

package hxtag.dom.tools;

#if macro
import haxe.macro.Context;
import haxe.macro.Expr;
#else
//import js.html.Element;
import hxtag.dom.Element;
#end

@:keepInit
class Polyfill {

	@:noUsing
	macro public static function getVendorFn(o:Dynamic,name:String,def:String=null){
		var pos=Context.currentPos();
		if (def==null)
			def=name;
		name=name.charAt(0).toUpperCase()+name.substr(1);
		var webkit="webkit"+name;
		var moz="moz"+name;
		var ms="ms"+name;
		var op="o"+name;
		return macro untyped ($o.$def || $o.$webkit || $o.$moz || $o.$ms || $o.$op);
	}


	#if !macro
	static function __init__()  {	
	  	untyped __feature__("Polyfill.matches",Element.prototype.matches=getVendorFn(Element.prototype,"matchesSelector","matches"));
	}


	public static inline function matches(e:Element,selector:String):Bool
		return untyped __define_feature__("Polyfill.matches",e.matches(selector));
	

	#end
}