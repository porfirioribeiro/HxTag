//
// HxTag - Custom Elements for Haxe-JS
// https://github.com/porfirioribeiro/HxTag/blob/master/LICENSE

package hx;



using hxtag.DomTools;
import hxtag.Dom.*;


@:stylus("hx-btn")
class BtnGroup extends hxtag.Tag {

	@:Attribute
	public var exclusive:Bool;
	@:Attribute
	public var checkable:Bool;

	@:allow(hx)
	var exclusiveCheckedBtn:Btn;

	public function createdCallback(){}

	public function attachedCallback() {
// 		trace("attached");
	}
	public function detachedCallback() {
// 		trace("detached");
	}

	public function testIt(){
// 		trace('btn-group:test');
	}
}
