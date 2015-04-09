//
// HxTag - Custom Elements for Haxe-JS
// https://github.com/porfirioribeiro/HxTag/blob/master/LICENSE

package hx;

import hxtag.Tag;

import hxtag.Dom;
using hxtag.DomTools;

import hx.Menu.MenuBase;

class MenuItem extends Menu.MenuBase{

	override public function createdCallback(){
		super.createdCallback();
		this.innerHTML=text;
	}

}

class MenuSeparator extends Menu.MenuBase{}
