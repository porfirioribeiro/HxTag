package hx;

import hxtag.Dom.*;
using hxtag.DomTools;
import js.html.Event;

class Btn extends hxtag.Tag{
	
	@:Attribute
	public var checked:Bool;	
	@:Attribute
	public var checkable:Bool;
	

	public function createdCallback(){
		on("click",_clicked);		
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
		dispatchEvent(new Event("changed"));
	}
}