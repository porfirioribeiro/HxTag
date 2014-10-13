(function () { "use strict";
function $extend(from, fields) {
	function Inherit() {} Inherit.prototype = from; var proto = new Inherit();
	for (var name in fields) proto[name] = fields[name];
	if( fields.toString !== Object.prototype.toString ) proto.toString = fields.toString;
	return proto;
}
var StringBuf = function() { };
var hxtag_Tag = function() { };
hxtag_Tag.__super__ = Element;
hxtag_Tag.prototype = $extend(Element.prototype,{
});
var hx_Btn = function() { };
hx_Btn.__super__ = hxtag_Tag;
hx_Btn.prototype = $extend(hxtag_Tag.prototype,{
	createdCallback: function() {
	}
	,attachedCallback: function() {
		if((this.parentNode instanceof hx_BtnGroup)) this.buttonGroup = this.parentNode;
		if(this.buttonGroup != null) {
			this.buttonGroup.testIt();
			if(this.buttonGroup.hasAttribute("checkable")) hxtag_dom_tools_Attribute.toggleAtt(this,"checkable",true);
			if(this.buttonGroup.hasAttribute("exclusive")) {
				if(this.hasAttribute("checked")) this.buttonGroup.exclusiveCheckedBtn = this;
			}
		}
		if(this.hasAttribute("checked")) hxtag_dom_tools_Attribute.toggleAtt(this,"checkable",true);
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
				if(this.buttonGroup.exclusiveCheckedBtn != null && this.buttonGroup.exclusiveCheckedBtn != this) hxtag_dom_tools_Attribute.toggleAtt(this.buttonGroup.exclusiveCheckedBtn,"checked",false);
				this.buttonGroup.exclusiveCheckedBtn = this;
			}
			this.buttonGroup.dispatchEvent(new CustomEvent("change",{ detail : { button : this}}));
		}
	}
	,set_checked: function(v) {
		return hxtag_dom_tools_Attribute.toggleAtt(this,"checked",v);
	}
});
var hx_BtnGroup = function() { };
hx_BtnGroup.__super__ = hxtag_Tag;
hx_BtnGroup.prototype = $extend(hxtag_Tag.prototype,{
	createdCallback: function() {
	}
	,attachedCallback: function() {
	}
	,detachedCallback: function() {
	}
	,testIt: function() {
	}
});
var hx_Icon = function() { };
hx_Icon.__super__ = hxtag_Tag;
hx_Icon.prototype = $extend(hxtag_Tag.prototype,{
	createdCallback: function() {
		if(this.hasAttribute("src")) this._setSrc(this.getAttribute("src"));
	}
	,attributeChangedCallback: function(attrName,oldVal,newVal) {
		switch(attrName) {
		case "src":
			this._setSrc(newVal);
			break;
		}
	}
	,_setSrc: function(src) {
		console.log("icon: set src to: " + src);
		this.textContent = "";
		this.setAttribute("fit","");
		console.log(this.style);
		this.style.backgroundImage = "url(" + this.getAttribute("src") + ")";
		this.style.backgroundPosition = "center";
		this.style.backgroundSize = "100%";
		console.log(this);
	}
});
var hx_MenuBase = function() { };
hx_MenuBase.__super__ = hxtag_Tag;
hx_MenuBase.prototype = $extend(hxtag_Tag.prototype,{
	createdCallback: function() {
	}
});
var hx_Menu = function() { };
hx_Menu.__super__ = hx_MenuBase;
hx_Menu.prototype = $extend(hx_MenuBase.prototype,{
	createdCallback: function() {
	}
	,attachedCallback: function() {
		if((this.parentElement instanceof hx_MenuBar)) this._menuBar = this.parentElement;
		if((this.parentElement instanceof hx_Menu)) this._menu = this.parentElement;
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
var hx_MenuBar = function() {
	this.isMenuOpen = false;
};
hx_MenuBar.__super__ = hxtag_Tag;
hx_MenuBar.prototype = $extend(hxtag_Tag.prototype,{
});
var hx_MenuItem = function() { };
hx_MenuItem.__super__ = hx_MenuBase;
hx_MenuItem.prototype = $extend(hx_MenuBase.prototype,{
	createdCallback: function() {
		hx_MenuBase.prototype.createdCallback.call(this);
		this.innerHTML = this.getAttribute("text");
	}
});
var hx_MenuSeparator = function() { };
hx_MenuSeparator.__super__ = hx_MenuBase;
hx_MenuSeparator.prototype = $extend(hx_MenuBase.prototype,{
});
var hx_Meta = function() { };
hx_Meta.__super__ = hxtag_Tag;
hx_Meta.prototype = $extend(hxtag_Tag.prototype,{
	createdCallback: function() {
		this.querySelectorAll("hx-meta-item");
	}
});
var hxtag_Dom = function() { };
var hxtag_dom__$ElementList_ElementList_$Impl_$ = function() { };
var hxtag_dom_tools_Attribute = function() { };
hxtag_dom_tools_Attribute.toggleAtt = function(e,name,v) {
	if(v) return e.setAttribute(name,""); else return e.removeAttribute(name);
};
var hxtag_dom_tools_Event = function() { };
hxtag_dom_tools_Event.on = function(e,eventType,eventListener) {
	e.addEventListener(eventType,eventListener);
};
var hxtag_dom_tools_Polyfill = function() { };
var hxtag_test_Main = function() { };
hxtag_test_Main.main = function() {
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
	hxtag_dom_tools_Event.on(window.document,"DOMContentLoaded",hxtag_test_Main.ready);
};
hxtag_test_Main.ready = function(e) {
	var btn = window.document.createElement("hx-btn");
	btn.innerHTML = "btn";
	window.document.body.appendChild(btn);
	window.document.body.removeChild(btn);
	var el = window.document.querySelector("#hx-btn-ong");
};
var js_Browser = function() { };
var $_, $fid = 0;
function $bind(o,m) { if( m == null ) return null; if( m.__id__ == null ) m.__id__ = $fid++; var f; if( o.hx__closures__ == null ) o.hx__closures__ = {}; else f = o.hx__closures__[m.__id__]; if( f == null ) { f = function(){ return f.method.apply(f.scope, arguments); }; f.scope = o; f.method = m; o.hx__closures__[m.__id__] = f; } return f; }
hx_Btn.Element = window.document.registerElement("hx-btn",{ prototype : hx_Btn.prototype});
hx_BtnGroup.Element = window.document.registerElement("hx-btn-group",{ prototype : hx_BtnGroup.prototype});
hx_Icon.Element = window.document.registerElement("hx-icon",{ prototype : hx_Icon.prototype});
hx_Menu.Element = window.document.registerElement("hx-menu",{ prototype : hx_Menu.prototype});
hx_MenuBar.Element = window.document.registerElement("hx-menu-bar",{ prototype : hx_MenuBar.prototype});
hx_MenuItem.Element = window.document.registerElement("hx-menu-item",{ prototype : hx_MenuItem.prototype});
hx_MenuSeparator.Element = window.document.registerElement("hx-menu-separator",{ prototype : hx_MenuSeparator.prototype});
hx_Meta.Element = window.document.registerElement("hx-meta",{ prototype : hx_Meta.prototype});
hxtag_test_Main.main();
})();

//# sourceMappingURL=HxTag-test.js.map