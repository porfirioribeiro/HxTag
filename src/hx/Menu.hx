package hx;
import js.html.Element;
import js.html.MouseEvent;
import js.html.DivElement;
import js.html.SpanElement;
import js.html.DocumentFragment;
import hxtag.Tag;

import hxtag.Dom;
using hxtag.DomTools;

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

class Menu extends MenuBase {
	
	var item:SpanElement;
	var _visible:Bool;
	
	var _menuBar:MenuBar;
	var _menu:Menu;
	
	override public function createdCallback() {
		
	}
	
	public function attachedCallback(){
		_menuBar=this.parentElement.as2(MenuBar,true);
		_menu=this.parentElement.as2(Menu,true);
		if (_menu!=null){
			trace('Item $text is on menu');
		}else if (_menuBar!=null){
			
			item=Dom.document.createSpanElement();
			item.innerHTML=text;
			parentElement.insertBefore(item,this);
			item.on("mouseenter",item_mouseenter);
			item.on("mouseleave",item_mouseleave);
			item.on("mousedown",item_mousedown);
			trace('Item $text is on menubar');
		}else{

		}
	}
	
	function item_mouseenter(e:MouseEvent){
		if (_menuBar!=null && _menuBar.isMenuOpen){
			if (_menuBar.openedMenu!=null)
				_menuBar.openedMenu.close();
			_menuBar.openedMenu=this;
			showAtElement(item);
		}
	}	
	function item_mouseleave(e:MouseEvent){
				trace("mouseleave");
// 				this.toggle();		
	}	
	function item_mousedown(e:MouseEvent){
		if (_visible)
			close();
		else
			showAtElement(item);	
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
		this.show();
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
		this.hide();
	}

}