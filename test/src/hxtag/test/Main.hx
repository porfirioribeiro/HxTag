//
// HxTag - Custom Elements for Haxe-JS
// https://github.com/porfirioribeiro/HxTag/blob/master/LICENSE

package hxtag.test;


import hx.Btn;
import hxtag.Dom;
using hxtag.DomTools;
//



class Main
{
	function new() {trace("new");}
	static function main() 
	{
		var observer=new js.html.MutationObserver(function(records:Array<js.html.MutationRecord>) {
			for (r in records) {
				for (e in r.addedNodes) 
					untyped	if (e.attachedCallback)	e.attachedCallback();
				//for (e in r.removedNodes) 
					//untyped	if (e.detachedCallback)	e.detachedCallback();				
			}
		});
		observer.observe(Dom.document, { childList:true, attributes:true, subtree:true } );
		Dom.document.on("DOMContentLoaded",ready);

	}
	static function ready(e){
// 		trace("ready");

		var btn = Btn.create();
		btn.innerHTML = "btn";

		
		Dom.document.body.appendChild(btn);
		Dom.document.body.removeChild(btn);
		//var els=Dom.qA("hx-btn");
		//els.each(function(el) el.on("changed",function(e) trace(e.target.checked)));
		
		var el =	Dom.q("#hx-btn-ong", Btn);
	
		//el.on("change", function(e) trace(e));
		//el.onchange = function(e) trace("whoa");
		//el.buttonGroup.onchange = function(e:js.html.CustomEvent) {
			//trace(e.detail.button);
		//}

	}
	
}