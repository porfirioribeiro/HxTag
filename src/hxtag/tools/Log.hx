//
// HxTag - Custom Elements for Haxe-JS
// https://github.com/porfirioribeiro/HxTag/blob/master/LICENSE

package hxtag.tools;

import haxe.macro.Expr;
import haxe.macro.Context;

/**
 * ...
 * @author Porfírio
 */
class Log
{
	#if macro
	static function _ifd(e:Expr) {
		if (Context.defined("debug"))
			return e;
		return macro { };
	}
	//macro public static function v(args:Array<Expr>)
		//return _ifd(macro haxe.macro.Context.warning(${args[0]},haxe.macro.Context.currentPos()));
	#end
	//#if (js )
	macro public static function v(args:Array<Expr>)
		return _ifd(macro hxtag.Dom.console.log($a{args}));

	macro public static function e(args:Array<Expr>)
		return _ifd(macro hxtag.Dom.console.error($a{args}));

	macro public static function w(args:Array<Expr>)
		return _ifd(macro hxtag.Dom.console.warn($a{args}));

	macro public static function i(args:Array<Expr>)
		return _ifd(macro hxtag.Dom.console.info($a{args}));

	macro public static function v_if(expr:Expr,args:Array<Expr>)
		return _ifd(macro if ($expr) hxtag.Dom.console.log($a { args } ));

	macro public static function e_if(expr:Expr,args:Array<Expr>)
		return _ifd(macro if ($expr) hxtag.Dom.console.error($a { args } ));

	macro public static function w_if(expr:Expr,args:Array<Expr>)
		return _ifd(macro if ($expr) hxtag.Dom.console.warn($a { args } ));

	macro public static function i_if(expr:Expr,args:Array<Expr>)
		return _ifd(macro if ($expr) hxtag.Dom.console.info($a { args } ));
	//#end
}
