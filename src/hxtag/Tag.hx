//
// HxTag - Custom Elements for Haxe-JS
// https://github.com/porfirioribeiro/HxTag/blob/master/LICENSE

package hxtag;

import haxe.macro.Expr;
@:autoBuild(hxtag.macro.TagBuilder.build())
class Tag #if !macro extends js.html.Element #end{
	macro public function on(ethis:Expr,eventType:Expr,eventListener:Expr){
		return macro hxtag.dom.tools.Event.on($ethis,$eventType,$eventListener);
	}

	macro function uid(ethis:Expr,name:String="id_"){
		var uid:String=name+Std.string(_UID++);
		return macro $v{uid}
	}
	#if macro
	static var _UID=0;
	#end
}