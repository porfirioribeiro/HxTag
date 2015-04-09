//
// HxTag - Custom Elements for Haxe-JS
// https://github.com/porfirioribeiro/HxTag/blob/master/LICENSE

package hxtag.test;

import hx.Icon;
import hxtag.IconSet;

/**
 * ...
 * @author Porfirio
 */
@:name("color")
class ColorIconSet extends IconSet{
	public function new() {
		super();
	}

	override public function applyIcon(icon:Icon, name:String) {
		trace('Applying icon: $name');
		icon.style.backgroundColor = name;
	}

}
