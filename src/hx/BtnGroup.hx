
package hx;



using hxtag.DomTools;
import hxtag.Dom.*;

// @:tag("hx-btn-group")
class BtnGroup extends hxtag.Tag {

	@:Attribute
	public var exclusive:Bool;
	@:Attribute
	public var checkable:Bool;
	
	@:allow(hx)
	var exclusiveCheckedBtn:Btn;
	
	//public function createdCallback(){}

	public function testIt(){
		trace('btn-group:test');
	} 
}
