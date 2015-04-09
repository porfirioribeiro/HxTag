//
// HxTag - Custom Elements for Haxe-JS
// https://github.com/porfirioribeiro/HxTag/blob/master/LICENSE

package hx;

import hxtag.Tag;

import hxtag.Dom;
using hxtag.DomTools;

class MenuBar extends Tag{
	public var isMenuOpen:Bool=false;
	public var openedMenu:Menu;
}
