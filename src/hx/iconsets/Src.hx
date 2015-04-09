//
// HxTag - Custom Elements for Haxe-JS
// https://github.com/porfirioribeiro/HxTag/blob/master/LICENSE

package hx.iconsets;

import hxtag.IconSet;

/**
 * ...
 * @author Porfirio
 */
class Src extends IconSet{

	public function new() {
		super();
	}

	override public function applyIcon(icon:Icon, name:String) {
		trace('Applying icon: $name');

		icon.textContent = '';
		icon.setAttribute('fit', '');
		icon.style.backgroundImage = 'url($name)';
		icon.style.backgroundPosition = 'center';
		icon.style.backgroundSize = '100%';
	}

}
