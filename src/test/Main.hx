//
// HxTag - Custom Elements for Haxe-JS
// https://github.com/porfirioribeiro/HxTag/blob/master/LICENSE

package test;


//import hxtag.Dom;
//import hxtag.DomTools;
//using hxtag.DomTools;
//
//import js.Browser.*;
//
//using haxe.macro.Tools;


class Main
{
	function new() {trace("new");}
	static function main() 
	{
//		Dom.document.on("DOMContentLoaded",ready);


	}
	static function ready(e){
		trace("ready");

		// var el=q("#hxbtn");
		// // $type(el);
		// trace(el.is(Btn));
		// trace(el.matches("hx-btn"));
		// trace(untyped el.constructor);
		// trace(untyped hx.Button.create().constructor);
		// trace(untyped  __js__("new hx.Button.Element()").constructor);

		// var xb=document.createElement("x-btn");
		// xb.innerHTML="WTF";
		// document.body.appendChild(xb);
		// // trace(untyped __instanceof__(xb,Btn));
		// trace(Type.createEmptyInstance(Btn));
	}
	
}