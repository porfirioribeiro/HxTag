//
// HxTag - Custom Elements for Haxe-JS
// https://github.com/porfirioribeiro/HxTag/blob/master/LICENSE

package hx;

import hxtag.IconSets;
import hxtag.IconSet;
import hxtag.Tag;
import hxtag.Dom;
import hxtag.tools.Log;
import hxtag.dom.Element;
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

	public var element:Element;

	// public function createdCallback() {
	// 	if (this.hasAttribute("icon"))
	// 		_setIcon(icon);
	// }
	//
	// function attributeChangedCallback(attrName:String, oldVal:String, newVal:String){
	// 	switch (attrName) {
	// 		case "icon": _setIcon(newVal);
	// 	}
	// }

	function icon_changed(_,newIcon:String) {
		var parts = newIcon.split(":");
		Log.e_if(parts.length != 2, "Icon should be in the form of 'iconset:icon-name'");
		var iconSet = parts.shift();
		var icon = parts.join(":");
		if (!IconSets.has(iconSet)) {
			Log.w('IconSet: \'$iconSet\' does not exis or is not resgisted');
			return;
		}
		var _iconset = IconSets.get(iconSet);
		_iconset.applyIcon(this, icon);
		iconset=_iconset;
	}

	public inline function reset(el:Element=null){
		if (element!=null)
			this.removeChild(element);
		if (el==null) return;
		element=el;
		appendChild(element);
	}
}
