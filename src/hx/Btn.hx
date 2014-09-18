
package hx;

import hxtag.Dom.*;
import js.html.Element;
using hxtag.DomTools;

@:enum
abstract BtnType(String) to String {
    var Button = "button";
    var Toggle = "checkbox";
    var Radio = "radio";
}

// @:tag("hx-btn")
class Btn extends hxtag.Tag{
	
	@:Attribute
	public var checked:Bool;	
	@:Attribute
	public var checkable:Bool;
	

	//createdCallback
	public function createdCallback(){
// 		trace("created");
// 		trace(getAttribute("checked"));
// 		removeAttribute("checked");
		// trace(checked);
		this.on2("click",_clicked);
// 		checked=true;
		
	}
	function attachedCallback(){
		var p=parentT(BtnGroup);
		if (p!=null)
			p.testIt();
	}	
	function detachedCallback(){}	
	function attributeChangedCallback(attrName:String, oldVal:String, newVal:String){}

	function _clicked(e:js.html.Event){
		checked=!checked;
		trace(checked);
	}

	public inline function on2(eventType:String,eventListener:js.html.EventListener){
		if (eventType=="click:") this.addEventListener("click",eventListener);
		else if (eventType=="change") this.addEventListener("change",eventListener);
		else			this.addEventListener(eventType,eventListener);
		// switch (eventType) {
		// 	case "click": 
		// 		return this.input.addEventListener("click",eventListener);
		// 	// case "change": return hxtag.dom.Tools.Event.on(this.input,"change",eventListener);
		// 	// case "mouseover": return hxtag.dom.Tools.Event.on(this.label,"mouseover",eventListener);
		// 	// case _: return hxtag.dom.Tools.Event.on(this,eventType,eventListener);
		// 	case _: return this.addEventListener(eventType,eventListener);
		// }
	}
}