//
// HxTag - Custom Elements for Haxe-JS
// https://github.com/porfirioribeiro/HxTag/blob/master/LICENSE

package hxtag;

import haxe.macro.Expr;
import hxtag.tools.UID;
@:autoBuild(hxtag.macro.TagBuilder.build())
@:remove
class Tag #if !macro extends js.html.Element #end{
	macro public function on(ethis:Expr,eventType:Expr,eventListener:Expr){
		trace(eventType);
		return macro hxtag.dom.tools.Event.on($ethis,$eventType,$eventListener);
	}

	inline function uid(name:String=""){
		return name+UID.next;
	}
}