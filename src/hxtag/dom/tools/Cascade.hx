//
// HxTag - Custom Elements for Haxe-JS
// https://github.com/porfirioribeiro/HxTag/blob/master/LICENSE

package hxtag.dom.tools;

#if macro
import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Type;
 
import haxe.macro.Tools;
import tink.MacroApi;
using tink.macro.Exprs;
using tink.macro.Types;
#else
import js.html.Element;
#end

/**
 * ...
 * @author ...
 */
class Cascade
{

	macro public static function _set<T>(e:ExprOf<T>, o:Expr):ExprOf<T> {

		var tmpVar = MacroApi.tempName();
		var exprs = new Array<Expr>();
		exprs.push(macro var $tmpVar = $e );
		switch(o.expr) {
				case EObjectDecl(fields):
						for (f in fields) {
							var fname = f.field;
							var expr = f.expr;
							exprs.push(macro $i{tmpVar}.$fname = $expr );
							//trace(f.field);
						}
				default:
						Context.error('expression should be an object literal', o.pos);
		}
	
		exprs.push(macro $i{tmpVar});
		var e={expr:EBlock(exprs),pos:Context.currentPos()}; 
		trace(e.toString());
		return macro $e{e};   
	}
	
	macro public static function _set2<T>(e:ExprOf<T>, o:Expr):ExprOf<T> {

		trace(e.toString());
		var exprs = new Array<Expr>();
		switch(o.expr) {
				case EObjectDecl(fields):
						for (f in fields) {
							var fname = f.field;
							var expr = f.expr;
							exprs.push(macro $e.$fname = $expr );
						}
				default:
						Context.error('expression should be an object literal', o.pos);
		}
	
		var e={expr:EBlock(exprs),pos:Context.currentPos()}; 
		trace(e.toString());
		return macro $e{e};   
	}
}