(function () { "use strict";
function $extend(from, fields) {
	function Inherit() {} Inherit.prototype = from; var proto = new Inherit();
	for (var name in fields) proto[name] = fields[name];
	if( fields.toString !== Object.prototype.toString ) proto.toString = fields.toString;
	return proto;
}
var hxtag_Res = function() { };
var hxtag_Tag = function() { };
hxtag_Tag.__interfaces__ = [hxtag_Res];
hxtag_Tag.__super__ = HTMLElement;
hxtag_Tag.prototype = $extend(HTMLElement.prototype,{
});
var hx_Btn = function() { };
hx_Btn.__super__ = hxtag_Tag;
hx_Btn.prototype = $extend(hxtag_Tag.prototype,{
	createdCallback: function() {
		if(this.hasAttribute("icon")) this.icon_changed(null,this.getAttribute("icon"));
	}
	,attachedCallback: function() {
		this.buttonGroup = (this.parentNode instanceof hx_BtnGroup)?this.parentNode:null;
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
		if(attrName == "icon") this.icon_changed(oldVal,newVal);
	}
	,icon_changed: function(o,icon) {
		if(this._icon == null) {
			this._icon = window.document.createElement("hx-icon");
			this.appendChild(this._icon);
		}
		this._icon.setAttribute("icon",icon);
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
	,attributeChangedCallback: function(name,o,n) {
	}
});
var hx_Icon = function() { };
hx_Icon.__super__ = hxtag_Tag;
hx_Icon.prototype = $extend(hxtag_Tag.prototype,{
	icon_changed: function(_,newIcon) {
		var parts = newIcon.split(":");
		if(parts.length != 2) console.error("Icon should be in the form of 'iconset:icon-name'");
		var iconSet = parts.shift();
		var icon = parts.join(":");
		if(!(iconSet in hxtag_IconSet.__iconSets)) {
			console.warn("IconSet: '" + iconSet + "' does not exis or is not resgisted");
			return;
		}
		var _iconset = hxtag_IconSet.__iconSets[iconSet];
		_iconset.applyIcon(this,icon);
		this.iconset = _iconset;
	}
	,reset: function(el) {
		if(this.element != null) this.removeChild(this.element);
		if(el == null) return;
		this.element = el;
		this.appendChild(this.element);
	}
	,createdCallback: function() {
		if(this.hasAttribute("icon")) this.icon_changed(null,this.getAttribute("icon"));
	}
	,attributeChangedCallback: function(name,o,n) {
		if(name == "icon") this.icon_changed(o,n);
	}
});
var hxtag_IconSet = function() {
};
hxtag_IconSet.prototype = {
	applyIcon: function(icon,name) {
	}
};
var hx_iconsets_Src = function() {
	hxtag_IconSet.call(this);
};
hx_iconsets_Src.__super__ = hxtag_IconSet;
hx_iconsets_Src.prototype = $extend(hxtag_IconSet.prototype,{
	applyIcon: function(icon,name) {
		console.log("Applying icon: " + name + " ");
		if(!(icon.iconset instanceof hx_iconsets_Src)) {
			icon.reset(window.document.createElement("div"));
			icon.element.textContent = "";
			icon.element.setAttribute("fit","");
			icon.element.style.backgroundPosition = "center";
			icon.element.style.backgroundSize = "100%";
			icon.element.style.height = "100%";
		}
		icon.element.style.backgroundImage = "url(" + name + ")";
	}
});
var hxtag_dom_tools_Attribute = function() { };
hxtag_dom_tools_Attribute.toggleAtt = function(e,name,v) {
	if(v) return e.setAttribute(name,""); else return e.removeAttribute(name);
};
var hxtag_dom_tools_Event = function() { };
hxtag_dom_tools_Event.on = function(e,eventType,eventListener) {
	e.addEventListener(eventType,eventListener);
};
var hxtag_dom_tools_Polyfill = function() { };
var hxtag_test_ColorIconSet = function() {
	hxtag_IconSet.call(this);
};
hxtag_test_ColorIconSet.__super__ = hxtag_IconSet;
hxtag_test_ColorIconSet.prototype = $extend(hxtag_IconSet.prototype,{
	applyIcon: function(icon,name) {
		console.log("Applying icon: " + name);
		if(!(icon.iconset instanceof hxtag_test_ColorIconSet)) {
			icon.reset(window.document.createElement("div"));
			icon.element.textContent = "";
			icon.element.setAttribute("fit","");
			icon.element.style.backgroundPosition = "center";
			icon.element.style.backgroundSize = "100%";
			icon.element.style.height = "100%";
		}
		icon.element.style.backgroundColor = name;
	}
});
var hxtag_test_Main = function() { };
hxtag_test_Main.main = function() {
	hxtag_dom_tools_Event.on(window.document,"DOMContentLoaded",hxtag_test_Main.ready);
};
hxtag_test_Main.ready = function(e) {
	var testBtn = window.document.querySelector("#test-btn");
	testBtn.setAttribute("icon","color:blue");
	testBtn.setAttribute("icon","color:green");
	window.document.createElement("hx-btn");
};
var tags_Other = function() { };
tags_Other.__super__ = hxtag_Tag;
tags_Other.prototype = $extend(hxtag_Tag.prototype,{
	createdCallback: function() {
	}
	,attributeChangedCallback: function(name,o,n) {
	}
});
var $_, $fid = 0;
function $bind(o,m) { if( m == null ) return null; if( m.__id__ == null ) m.__id__ = $fid++; var f; if( o.hx__closures__ == null ) o.hx__closures__ = {}; else f = o.hx__closures__[m.__id__]; if( f == null ) { f = function(){ return f.method.apply(f.scope, arguments); }; f.scope = o; f.method = m; o.hx__closures__[m.__id__] = f; } return f; }
hxtag_IconSet.__iconSets = { };
hxtag_IconSet.__iconSets.src = new hx_iconsets_Src();
hxtag_IconSet.__iconSets.color = new hxtag_test_ColorIconSet();
hx_Btn.Element = window.document.registerElement("hx-btn",{ prototype : hx_Btn.prototype});
hx_BtnGroup.Element = window.document.registerElement("hx-btn-group",{ prototype : hx_BtnGroup.prototype});
hx_Icon.Element = window.document.registerElement("hx-icon",{ prototype : hx_Icon.prototype});
tags_Other.Element = window.document.registerElement("tags-other",{ prototype : tags_Other.prototype});
hxtag_test_Main.main();
})();

//# sourceMappingURL=HxTag-test.js.map