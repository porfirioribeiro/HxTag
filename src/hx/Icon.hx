//
// HxTag - Custom Elements for Haxe-JS
// https://github.com/porfirioribeiro/HxTag/blob/master/LICENSE

package hx;

import hxtag.IconSet;
import hxtag.Tag;
import hxtag.Dom;
import hxtag.tools.Log;

/**
 * ...
 * @author ...
 */
@:stylus
class Icon extends Tag
{
	//@:Attribute public var src:String;
	@:Attribute public var icon:String;
	public var iconset(default, null):IconSet;

	var _icon:hxtag.dom.Element;

	public function createdCallback() {
		if (this.hasAttribute("icon"))
			_setIcon(icon);
	}

	function attributeChangedCallback(attrName:String, oldVal:String, newVal:String){
		switch (attrName) {
			case "icon": _setIcon(newVal);
		}
	}

	function _setIcon(_icon:String) {
		var parts = _icon.split(":");
		Log.e_if(parts.length != 2, "Icon should be in the form of 'iconset:icon-name'");
		var iconSet = parts.shift();
		var icon = parts.join(":");
		if (!IconSet.has(iconSet)) {
			Log.w('IconSet: \'$iconSet\' does not exis or is nor resgisted');
			return;
		}
		iconset=IconSet.get(iconSet);
		iconset.applyIcon(this, icon);
	}
}
