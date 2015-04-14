//
// HxTag - Custom Elements for Haxe-JS
// https://github.com/porfirioribeiro/HxTag/blob/master/LICENSE

package hxtag.test;

import js.html.MutationObserver;

import hxtag.Dom;
import hxtag.tools.Log;
using hxtag.DomTools;

//Tags
import hx.Btn;
//import hx.Menu;
//import hxtag.test.MyTag;
import tags.Other;

import hx.Icon;

//IconSets
import hx.iconsets.Src;
import hxtag.test.ColorIconSet;

class Main
{
	function new() {trace("new");}
	static function main()
	{
		//var observer=new MutationObserver(function(records:Array<js.html.MutationRecord>,o:MutationObserver) {
			//for (r in records) {
				//for (e in r.addedNodes)
					//untyped	if (e.attachedCallback)	e.attachedCallback();
				////for (e in r.removedNodes)
					////untyped	if (e.detachedCallback)	e.detachedCallback();
			//}
		//});
		//observer.observe(Dom.document, { childList:true, attributes:true, subtree:true } );

		Dom.document.on("DOMContentLoaded",ready);

		// trace(IconSet.has("color"));
		// trace(IconSet.has("src"));
		// trace(IconSet.get("color"));
		// trace(IconSet.get("src"));
	}
	static function ready(e){
// 		trace("ready");

		var testBtn =	Dom.q("#test-btn", Btn);
		// trace(testBtn.icon);
		// testBtn.icon="src:blue";
		testBtn.icon="color:blue";
		testBtn.icon="color:green";

		$type(Dom.create("hx-btn"));
		//var btn = Btn.create();
		//btn.innerHTML = "btn";
		//
		////btn.getStyle("color");
//
		////Log.v(Meta.byId("iconset", "silk"));
		//Dom.document.body.appendChild(btn);
		//Dom.document.body.removeChild(btn);
		//var els=Dom.qA("hx-btn");
		//els.each(function(el) el.on("changed",function(e) trace(e.target.checked)));

		//var el =	Dom.q("#hx-btn-ong", Btn);

		//el.on("change", function(e) trace(e));
		//el.onchange = function(e) trace("whoa");
		//el.buttonGroup.onchange = function(e:js.html.CustomEvent) {
			//trace(e.detail.button);
		//}

	}

}
