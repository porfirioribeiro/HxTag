//
// HxTag - Custom Elements for Haxe-JS
// https://github.com/porfirioribeiro/HxTag/blob/master/LICENSE

package hx;
import hxtag.dom.tools.Traversing;
import js.html.Element;
import js.html.MouseEvent;
import js.html.DivElement;
import js.html.SpanElement;
import js.html.DocumentFragment;
import hxtag.Tag;

import hxtag.Dom;
import hxtag.tools.Log;
using hxtag.DomTools;

//Tags
import hx.MenuItem;
import hx.MenuBar;

@:noTag
class MenuBase extends Tag{
	@:Attribute
	public var text:String;

	@:Attribute
	public var iconSrc:String;

	@:Attribute
	public var iconClass:String;


	public function createdCallback(){
// 		trace("menubase: "+text);
	}


}

@:stylus
class Menu extends MenuBase {

	var item:SpanElement;
	var _visible:Bool;

	var _menuBar:MenuBar;
	var _menu:Menu;

	var _parent:js.html.DOMElement;
	override public function createdCallback() {
		//Log.v('created Menu',this);
	}

	var count = 0;
	public function attachedCallback() {
		if (this.parentElement == _parent)
			return;
		_parent = this.parentElement;
		//Log.v('attached Menu', this, this.parentElement);
		_menuBar=this.parentElement.as2(MenuBar,true);
		_menu=this.parentElement.as2(Menu,true);
		if (_menu!=null){
			//trace('Item $text is on menu');
		}else if (_menuBar != null) {
			this.style.zIndex = "100";

			item = Dom.document.createSpanElement();
			item.tabIndex = 0;
			item.innerHTML = text;

			parentElement.insertBefore(item,this);
			item.on("mouseenter",item_mouseenter);
			item.on("mouseleave",item_mouseleave);
			item.on("mousedown", item_mousedown);
			item.on("focus", item_focus);
			item.on("blur", item_blur);

			Dom.document.on("mousedown", document_mousedown);




			//Log.v('Item $text is on menubar',item);
		}else{

		}
	}

	public function detachedCallback() {
			Log.i("Dettach");
	}
	function document_mousedown(e:MouseEvent) {
		//var el:Element = cast e.target;
		//Dom.console.log(el.parentElement==this,el);
		//if (_visible)
			//close();
	}

	function item_focus(e:MouseEvent) {
		//Dom.console.log("focus", this);
		showAtElement(item);
	}
	function item_blur(e:MouseEvent) {
		//Dom.console.log("blur", this);
		close();
	}

	function item_mouseenter(e:MouseEvent){
		//if (_menuBar!=null && _menuBar.isMenuOpen){
			//if (_menuBar.openedMenu!=null)
				//_menuBar.openedMenu.close();
			//_menuBar.openedMenu=this;
			//showAtElement(item);
		//}
		if (_menuBar!=null && _menuBar.isMenuOpen){
			if (_menuBar.openedMenu!=null)
				_menuBar.openedMenu.item.blur();
			_menuBar.openedMenu=this;
			item.focus();
		}
	}
	function item_mouseleave(e:MouseEvent){
				//trace("mouseleave");
// 				this.toggle();
	}
	function item_mousedown(e:MouseEvent) {
		//if (_visible)
			//close();
		//else
			//showAtElement(item);
		//e.stopPropagation();
	}


	//functions

	public function showAtPos(x:Int,y:Int) {
		_visible=true;
		if (_menuBar!=null){
			_menuBar.isMenuOpen=true;
			_menuBar.openedMenu=this;
		}

		if (item!=null)
			item.classList.toggle("opened",true);
		this.moveTo(x,y);
		this.classList.toggle("show",true);
		this.classList.toggle("hide",false);
	}

	public function showAtElement(e:Element){
		//TODO support diferent sides
		showAtPos(e.offsetLeft,e.offsetTop+e.offsetHeight);
	}

	public function close(){
		_visible=false;
		if (item!=null)
			item.classList.toggle("opened",false);
		if (_menuBar!=null)
			_menuBar.isMenuOpen=false;
		this.classList.toggle("show",false);
		this.classList.toggle("hide",true);
	}

}
