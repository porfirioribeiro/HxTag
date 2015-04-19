(function () { "use strict";
function $extend(from, fields) {
	function Inherit() {} Inherit.prototype = from; var proto = new Inherit();
	for (var name in fields) proto[name] = fields[name];
	if( fields.toString !== Object.prototype.toString ) proto.toString = fields.toString;
	return proto;
}
var demos_empty_Main = function() { };
demos_empty_Main.main = function() {
};
var hxtag_Tag = function() { };
hxtag_Tag.__super__ = HTMLElement;
hxtag_Tag.prototype = $extend(HTMLElement.prototype,{
});
var hx_Btn = function() { };
hx_Btn.__super__ = hxtag_Tag;
hx_Btn.prototype = $extend(hxtag_Tag.prototype,{
	createdCallback: function() {
		if(this.hasAttribute("icon")) this.icon_changed(null,this.getAttribute("icon"));
		if(this.hasAttribute("checked")) this.checked_changed(null,this.hasAttribute("checked"));
	}
	,attachedCallback: function() {
		this.buttonGroup = (this.parentNode instanceof hx_BtnGroup)?this.parentNode:null;
		if(this.buttonGroup != null) {
			this.buttonGroup.testIt();
			if(this.buttonGroup.hasAttribute("checkable")) hxtag_dom_tools_Attribute.toggleAttTo(this,"checkable",true);
			if(this.buttonGroup.hasAttribute("exclusive")) {
				if(this.hasAttribute("checked")) this.buttonGroup.exclusiveCheckedBtn = this;
			}
		}
		if(this.hasAttribute("checked")) hxtag_dom_tools_Attribute.toggleAttTo(this,"checkable",true);
		if(this.hasAttribute("checkable")) this.addEventListener("click",$bind(this,this._clicked));
	}
	,detachedCallback: function() {
	}
	,attributeChangedCallback: function(attrName,oldVal,newVal) {
		if(attrName == "icon") this.icon_changed(oldVal,newVal);
		if(attrName == "checked") this.checked_changed(oldVal,newVal);
	}
	,icon_changed: function(o,icon) {
		if(this._icon == null) {
			this._icon = window.document.createElement("hx-icon");
			this.appendChild(this._icon);
		}
		this._icon.setAttribute("icon",icon);
	}
	,checked_changed: function(old,n) {
	}
	,_clicked: function(e) {
		hxtag_dom_tools_Attribute.toggleAtt(this,"checked");
		this.dispatchEvent(new Event("change"));
		if(this.buttonGroup != null) {
			if(this.buttonGroup.hasAttribute("exclusive")) {
				if(this.buttonGroup.exclusiveCheckedBtn != null && this.buttonGroup.exclusiveCheckedBtn != this) hxtag_dom_tools_Attribute.toggleAttTo(this.buttonGroup.exclusiveCheckedBtn,"checked",false);
				this.buttonGroup.exclusiveCheckedBtn = this;
			}
			this.buttonGroup.dispatchEvent(new CustomEvent("change",{ detail : { button : this}}));
		}
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
	,attributeChangedCallback: function(name,o,n) {
	}
});
var hx_Icon = function() { };
hx_Icon.__super__ = hxtag_Tag;
hx_Icon.prototype = $extend(hxtag_Tag.prototype,{
	icon_changed: function(_,newIcon) {
		var parts = newIcon.split(":");
		var iconSet = parts.shift();
		var icon = parts.join(":");
		if(!(iconSet in __iconSets)) return;
		var _iconset = __iconSets[iconSet];
		_iconset.applyIcon(this,icon);
		this.iconset = _iconset;
	}
	,createdCallback: function() {
		if(this.hasAttribute("icon")) this.icon_changed(null,this.getAttribute("icon"));
	}
	,attributeChangedCallback: function(name,o,n) {
		if(name == "icon") this.icon_changed(o,n);
	}
});
var hxtag_IconSet = function() { };
var hxtag_dom_tools_Attribute = function() { };
hxtag_dom_tools_Attribute.toggleAttTo = function(e,name,v) {
	if(v) e.setAttribute(name,""); else e.removeAttribute(name);
};
hxtag_dom_tools_Attribute.toggleAtt = function(e,name) {
	if(e.hasAttribute(name)) e.removeAttribute(name); else e.setAttribute(name,"");
};
var $_, $fid = 0;
function $bind(o,m) { if( m == null ) return null; if( m.__id__ == null ) m.__id__ = $fid++; var f; if( o.hx__closures__ == null ) o.hx__closures__ = {}; else f = o.hx__closures__[m.__id__]; if( f == null ) { f = function(){ return f.method.apply(f.scope, arguments); }; f.scope = o; f.method = m; o.hx__closures__[m.__id__] = f; } return f; }
var __iconSets = { }
hx_Btn.Element = window.document.registerElement("hx-btn",{ prototype : hx_Btn.prototype});
hx_BtnGroup.Element = window.document.registerElement("hx-btn-group",{ prototype : hx_BtnGroup.prototype});
hx_Icon.Element = window.document.registerElement("hx-icon",{ prototype : hx_Icon.prototype});
demos_empty_Main.main();
})();
