//
// HxTag - Custom Elements for Haxe-JS
// https://github.com/porfirioribeiro/HxTag/blob/master/LICENSE

package hx.iconsets;

import hxtag.IconSet;
import hxtag.tools.JS.*;
import hxtag.Dom;
/**
 * ...
 * @author Porfirio
 */
class Src extends IconSet{

	public function new() {
		super();
	}

	override public function applyIcon(icon:Icon, name:String) {
		trace('Applying icon: $name ');
		if (!instanceOf(icon.iconset,Src)){
			icon.reset(Dom.create("div"));
			icon.element.textContent = '';
	      	icon.element.setAttribute('fit', '');
	      	icon.element.style.backgroundPosition = 'center';
	      	icon.element.style.backgroundSize = '100%';
	      	icon.element.style.height = '100%';
		}
		icon.element.style.backgroundImage = 'url($name)';
		// icon.textContent = '';
		// icon.setAttribute('fit', '');
		// icon.style.backgroundPosition = 'center';
		// icon.style.backgroundSize = '100%';
	}

}
