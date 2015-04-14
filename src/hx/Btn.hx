//
// HxTag - Custom Elements for Haxe-JS
// https://github.com/porfirioribeiro/HxTag/blob/master/LICENSE

package hx;

import hxtag.Dom.*;
using hxtag.DomTools;
import js.html.Event;

//Tags
import hx.Icon;

@:stylus
class Btn extends hxtag.Tag{

	@:Attribute
	public var checked:Bool;
	@:Attribute
	public var checkable:Bool;
	@:Attribute
	public var icon:String;

	public var buttonGroup(default,null):BtnGroup;

	var _icon:Icon;

	public function createdCallback() {

	}
	public function attachedCallback() {
		buttonGroup=parentT(BtnGroup);
		if (buttonGroup != null) {
			buttonGroup.testIt();
			if (buttonGroup.checkable)
				checkable = true;
			if (buttonGroup.exclusive)
				if (checked)
					buttonGroup.exclusiveCheckedBtn = this;
		}
		if (checked)
			checkable = true;
		if (checkable)
			on("click",_clicked);
	}
	public function detachedCallback() {
// 		trace(this);
	}
	function attributeChangedCallback(attrName:String, oldVal:String, newVal:String){}

	function icon_changed(o:String,icon:String){
		if (_icon==null){
			_icon=Icon.create();
			this.appendChild(_icon);
		}
		_icon.icon=icon;
	}
	function _clicked(e:js.html.Event){
		checked=!checked;
		dispatchEvent(new Event("change"));
		if (buttonGroup != null) {
			if (buttonGroup.exclusive) {
				if (buttonGroup.exclusiveCheckedBtn!=null && buttonGroup.exclusiveCheckedBtn!=this)
					buttonGroup.exclusiveCheckedBtn.checked = false;
				buttonGroup.exclusiveCheckedBtn = this;
			}
			//var e = new js.html.CustomEvent("change",{});
			//e.detail = { button:this };
			buttonGroup.fireCustomEvent("change", {button:this} );
		}

	}
}
