//
// HxTag - Custom Elements for Haxe-JS
// https://github.com/porfirioribeiro/HxTag/blob/master/LICENSE

package test;


import hxtag.Dom;
//import hxtag.DomTools;
using hxtag.DomTools;
//
import js.Browser.*;
//
//using haxe.macro.Tools;


class Main
{
	function new() {trace("new");}
	static function main() 
	{
		Dom.document.on("DOMContentLoaded",ready);

	}
	static function ready(e){
		trace("ready");

		var els=Dom.qA("hx-btn");
		els.each(function(el) el.on("changed",function(e) trace(e.target.checked)));
		

	}
	
}