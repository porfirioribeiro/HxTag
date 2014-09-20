package hx;

import hxtag.Dom.*;
using hxtag.DomTools;
import js.html.Event;

class Btn extends hxtag.Tag{
	
	@:Attribute
	public var checked:Bool;	
	@:Attribute
	public var checkable:Bool;
	
	public var buttonGroup(default,null):BtnGroup;
	

	public function createdCallback() {
		on("click",_clicked);		
	}
	public function attachedCallback() {
		buttonGroup=parentT(BtnGroup);
		if (buttonGroup!=null)
			buttonGroup.testIt();
	}	
	function detachedCallback(){}	
	function attributeChangedCallback(attrName:String, oldVal:String, newVal:String){}

	function _clicked(e:js.html.Event){
		checked=!checked;
		dispatchEvent(new Event("changed"));
	}
}