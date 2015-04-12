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
		if(this.hasAttribute("icon")) this._setIcon(this.getAttribute("icon"));
	}
	,attributeChangedCallback: function(attrName,oldVal,newVal) {
		switch(attrName) {
		case "icon":
			this._setIcon(newVal);
			break;
		}
	}
	,_setIcon: function(_icon) {
		var parts = _icon.split(":");
		if(parts.length != 2) console.error("Icon should be in the form of 'iconset:icon-name'");
		var iconSet = parts.shift();
		var icon = parts.join(":");
		if(!(iconSet in hxtag_IconSet.__iconSets)) {
			console.warn("IconSet: '" + iconSet + "' does not exis or is nor resgisted");
			return;
		}
		this.iconset = hxtag_IconSet.__iconSets[iconSet];
		this.iconset.applyIcon(this,icon);
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
		console.log("Applying icon: " + name);
		icon.textContent = "";
		icon.setAttribute("fit","");
		icon.style.backgroundImage = "url(" + name + ")";
		icon.style.backgroundPosition = "center";
		icon.style.backgroundSize = "100%";
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
		icon.style.backgroundColor = name;
	}
});
var hxtag_test_Main = function() { };
hxtag_test_Main.main = function() {
	hxtag_dom_tools_Event.on(window.document,"DOMContentLoaded",hxtag_test_Main.ready);
	console.log(("color" in hxtag_IconSet.__iconSets));
	console.log(("src" in hxtag_IconSet.__iconSets));
	console.log(hxtag_IconSet.__iconSets.color);
	console.log(hxtag_IconSet.__iconSets.src);
};
hxtag_test_Main.ready = function(e) {
};
var tags_Other = function() { };
tags_Other.__super__ = hxtag_Tag;
tags_Other.prototype = $extend(hxtag_Tag.prototype,{
	createdCallback: function() {
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