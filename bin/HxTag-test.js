function $extend(from, fields) {
	function Inherit() {} Inherit.prototype = from; var proto = new Inherit();
	for (var name in fields) proto[name] = fields[name];
	if( fields.toString !== Object.prototype.toString ) proto.toString = fields.toString;
	return proto;
}
var StringBuf = function() { };
var hxtag = hxtag || {};
hxtag.Tag = function() { };
hxtag.Tag.__super__ = Element;
hxtag.Tag.prototype = $extend(Element.prototype,{
});
var hx = hx || {};
hx.Btn = function() { };
hx.Btn.__super__ = hxtag.Tag;
hx.Btn.prototype = $extend(hxtag.Tag.prototype,{
	createdCallback: function() {
	}
	,attachedCallback: function() {
		if((this.parentNode instanceof hx.BtnGroup)) this.buttonGroup = this.parentNode;
		if(this.buttonGroup != null) {
			this.buttonGroup.testIt();
			if(this.buttonGroup.hasAttribute("checkable")) hxtag.dom.tools.Attribute.toggleAtt(this,"checkable",true);
			if(this.buttonGroup.hasAttribute("exclusive")) {
				if(this.hasAttribute("checked")) this.buttonGroup.exclusiveCheckedBtn = this;
			}
		}
		if(this.hasAttribute("checked")) hxtag.dom.tools.Attribute.toggleAtt(this,"checkable",true);
		if(this.hasAttribute("checkable")) this.addEventListener("click",$bind(this,this._clicked));
	}
	,detachedCallback: function() {
	}
	,attributeChangedCallback: function(attrName,oldVal,newVal) {
	}
	,_clicked: function(e) {
		this.set_checked(!this.hasAttribute("checked"));
		this.dispatchEvent(new Event("change"));
		if(this.buttonGroup != null) {
			if(this.buttonGroup.hasAttribute("exclusive")) {
				if(this.buttonGroup.exclusiveCheckedBtn != null && this.buttonGroup.exclusiveCheckedBtn != this) hxtag.dom.tools.Attribute.toggleAtt(this.buttonGroup.exclusiveCheckedBtn,"checked",false);
				this.buttonGroup.exclusiveCheckedBtn = this;
			}
			this.buttonGroup.dispatchEvent(new CustomEvent("change",{ detail : { button : this}}));
		}
	}
	,set_checked: function(v) {
		return hxtag.dom.tools.Attribute.toggleAtt(this,"checked",v);
	}
});
hx.BtnGroup = function() { };
hx.BtnGroup.__super__ = hxtag.Tag;
hx.BtnGroup.prototype = $extend(hxtag.Tag.prototype,{
	createdCallback: function() {
	}
	,attachedCallback: function() {
	}
	,detachedCallback: function() {
	}
	,testIt: function() {
	}
});
hx.MenuBase = function() { };
hx.MenuBase.__super__ = hxtag.Tag;
hx.MenuBase.prototype = $extend(hxtag.Tag.prototype,{
	createdCallback: function() {
	}
});
hx.Menu = function() { };
hx.Menu.__super__ = hx.MenuBase;
hx.Menu.prototype = $extend(hx.MenuBase.prototype,{
	createdCallback: function() {
	}
	,attachedCallback: function() {
		if((this.parentElement instanceof hx.MenuBar)) this._menuBar = this.parentElement;
		if((this.parentElement instanceof hx.Menu)) this._menu = this.parentElement;
		if(this._menu != null) console.log("Item " + this.getAttribute("text") + " is on menu"); else if(this._menuBar != null) {
			var _this = window.document;
			this.item = _this.createElement("span");
			this.item.innerHTML = this.getAttribute("text");
			this.parentElement.insertBefore(this.item,this);
			this.item.addEventListener("mouseenter",$bind(this,this.item_mouseenter));
			this.item.addEventListener("mouseleave",$bind(this,this.item_mouseleave));
			this.item.addEventListener("mousedown",$bind(this,this.item_mousedown));
			console.log("Item " + this.getAttribute("text") + " is on menubar");
		} else {
		}
	}
	,item_mouseenter: function(e) {
		if(this._menuBar != null && this._menuBar.isMenuOpen) {
			if(this._menuBar.openedMenu != null) this._menuBar.openedMenu.close();
			this._menuBar.openedMenu = this;
			this.showAtElement(this.item);
		}
	}
	,item_mouseleave: function(e) {
		console.log("mouseleave");
	}
	,item_mousedown: function(e) {
		if(this._visible) this.close(); else this.showAtElement(this.item);
	}
	,showAtPos: function(x,y) {
		this._visible = true;
		if(this._menuBar != null) {
			this._menuBar.isMenuOpen = true;
			this._menuBar.openedMenu = this;
		}
		if(this.item != null) this.item.classList.toggle("opened",true);
		this.style.left = x + "px";
		this.style.top = y + "px";
		this.classList.toggle("show",true);
		this.classList.toggle("hide",false);
	}
	,showAtElement: function(e) {
		this.showAtPos(e.offsetLeft,e.offsetTop + e.offsetHeight);
	}
	,close: function() {
		this._visible = false;
		if(this.item != null) this.item.classList.toggle("opened",false);
		if(this._menuBar != null) this._menuBar.isMenuOpen = false;
		this.classList.toggle("show",false);
		this.classList.toggle("hide",true);
	}
});
hx.MenuBar = function() {
	this.isMenuOpen = false;
};
hx.MenuBar.__super__ = hxtag.Tag;
hx.MenuBar.prototype = $extend(hxtag.Tag.prototype,{
});
hx.MenuItem = function() { };
hx.MenuItem.__super__ = hx.MenuBase;
hx.MenuItem.prototype = $extend(hx.MenuBase.prototype,{
	createdCallback: function() {
		hx.MenuBase.prototype.createdCallback.call(this);
		this.innerHTML = this.getAttribute("text");
	}
});
hx.MenuSeparator = function() { };
hx.MenuSeparator.__super__ = hx.MenuBase;
hx.MenuSeparator.prototype = $extend(hx.MenuBase.prototype,{
});
hxtag.Dom = function() { };
if(!hxtag.dom) hxtag.dom = {};
if(!hxtag.dom._ElementList) hxtag.dom._ElementList = {};
hxtag.dom._ElementList.ElementList_Impl_ = function() { };
if(!hxtag.dom.tools) hxtag.dom.tools = {};
hxtag.dom.tools.Attribute = function() { };
hxtag.dom.tools.Attribute.toggleAtt = function(e,name,v) {
	if(v) return e.setAttribute(name,""); else return e.removeAttribute(name);
};
hxtag.dom.tools.Event = function() { };
hxtag.dom.tools.Event.on = function(e,eventType,eventListener) {
	e.addEventListener(eventType,eventListener);
};
hxtag.dom.tools.Polyfill = function() { };
var js = js || {};
js.Browser = function() { };
var test = test || {};
test.Main = function() { };
test.Main.main = function() {
	var observer = new MutationObserver(function(records) {
		var _g = 0;
		while(_g < records.length) {
			var r = records[_g];
			++_g;
			var _g1 = 0;
			var _g2 = r.addedNodes;
			while(_g1 < _g2.length) {
				var e = _g2[_g1];
				++_g1;
				if(e.attachedCallback) e.attachedCallback();
			}
		}
	});
	observer.observe(window.document,{ childList : true, attributes : true, subtree : true});
	hxtag.dom.tools.Event.on(window.document,"DOMContentLoaded",test.Main.ready);
};
test.Main.ready = function(e) {
	var btn = window.document.createElement("hx-btn");
	btn.innerHTML = "btn";
	window.document.body.appendChild(btn);
	window.document.body.removeChild(btn);
	var el = window.document.querySelector("#hx-btn-ong");
};
var $_, $fid = 0;
function $bind(o,m) { if( m == null ) return null; if( m.__id__ == null ) m.__id__ = $fid++; var f; if( o.hx__closures__ == null ) o.hx__closures__ = {}; else f = o.hx__closures__[m.__id__]; if( f == null ) { f = function(){ return f.method.apply(f.scope, arguments); }; f.scope = o; f.method = m; o.hx__closures__[m.__id__] = f; } return f; }
hx.Btn.Element = window.document.registerElement("hx-btn",{ prototype : hx.Btn.prototype});
hx.BtnGroup.Element = window.document.registerElement("hx-btn-group",{ prototype : hx.BtnGroup.prototype});
hx.Menu.Element = window.document.registerElement("hx-menu",{ prototype : hx.Menu.prototype});
hx.MenuBar.Element = window.document.registerElement("hx-menu-bar",{ prototype : hx.MenuBar.prototype});
hx.MenuItem.Element = window.document.registerElement("hx-menu-item",{ prototype : hx.MenuItem.prototype});
hx.MenuSeparator.Element = window.document.registerElement("hx-menu-separator",{ prototype : hx.MenuSeparator.prototype});
test.Main.main();
