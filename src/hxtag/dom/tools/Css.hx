//
// HxTag - Custom Elements for Haxe-JS
// https://github.com/porfirioribeiro/HxTag/blob/master/LICENSE

package hxtag.dom.tools;

#if !macro
import js.html.Element;

import hxtag.Dom.*;
import hxtag.dom.css.Color;

using hxtag.DomTools;
#else
using tink.macro.Exprs;
import haxe.macro.Expr;
using StringTools;
#end

class Css {

	
	/**
	 * Get a single style from the element
	 */
	macro public static inline function getStyle(e:ExprOf<js.html.Element>,name:String){
		var ename=name.toExpr();
		if (name.endsWith("-color") || name=="color"){

			return macro hxtag.dom.tools.Css.getColor($e,$ename);
		}
			
		return macro hxtag.dom.tools.Css.getComputedStyle($e,$ename);
	}	
		
	#if !macro
	public static inline function getComputedStyle(e:Element,name:String){
		return window.getComputedStyle(e).getPropertyValue(name);
	}

	static inline function getColor(e:Element,name:String):Color{
		return ColorTools.parseRGBA(getComputedStyle(e,name));
	}

	#end

}