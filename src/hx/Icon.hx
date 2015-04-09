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
class Icon extends Tag
{
	//@:Attribute public var src:String;
	@:Attribute public var icon:String;
	public var iconset(default, null):String;

	public function createdCallback()
	{
		//if (this.hasAttribute("src"))
			//_setSrc(src);

		if (this.hasAttribute("icon"))
			_setIcon(icon);
	}

	function attributeChangedCallback(attrName:String, oldVal:String, newVal:String){
		switch (attrName) {
			//case "src": _setSrc(newVal);
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
		IconSet.get(iconSet).applyIcon(this, icon);
	}
	//function _setSrc(src:String) {
		////trace('icon: set src to: $src');
		//this.textContent = '';
		//this.setAttribute('fit', '');
		//this.style.backgroundImage = 'url(' + this.src + ')';
		//this.style.backgroundPosition = 'center';
		//this.style.backgroundSize = '100%';
	//}
}
