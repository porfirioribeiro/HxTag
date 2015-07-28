(function () { "use strict";
function $extend(from, fields) {
	function Inherit() {} Inherit.prototype = from; var proto = new Inherit();
	for (var name in fields) proto[name] = fields[name];
	if( fields.toString !== Object.prototype.toString ) proto.toString = fields.toString;
	return proto;
}
var hxtag_Tag = function() { };
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
});
var hx_Icon = function() { };
hx_Icon.__super__ = hxtag_Tag;
hx_Icon.prototype = $extend(hxtag_Tag.prototype,{
	reset: function(el) {
		if(this.element != null) this.removeChild(this.element);
		if(el == null) return;
		this.element = el;
		this.appendChild(this.element);
	}
});
var hxtag_IconSet = function() { };
var hx_iconsets_Src = function() {
	this.iconSize = 24;
};
hx_iconsets_Src.prototype = {
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
};
var hxtag_Resource = function() { };
hxtag_Resource.importHtml = function(href) {
	var link;
	var _this = window.document;
	link = _this.createElement("link");
	link.rel = "import";
	link.href = href;
	window.document.head.appendChild(link);
	return link;
};
var hxtag_dom_tools_Attribute = function() { };
hxtag_dom_tools_Attribute.toggleAttTo = function(e,name,v) {
	if(v) e.setAttribute(name,""); else e.removeAttribute(name);
};
hxtag_dom_tools_Attribute.toggleAtt = function(e,name) {
	if(e.hasAttribute(name)) e.removeAttribute(name); else e.setAttribute(name,"");
};
var hxtag_dom_tools_Event = function() { };
hxtag_dom_tools_Event.on = function(e,eventType,eventListener) {
	e.addEventListener(eventType,eventListener);
};
var hxtag_test_ColorIconSet = function() {
	this.iconSize = 24;
};
hxtag_test_ColorIconSet.prototype = {
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
};
var hxtag_test_Main = function() { };
hxtag_test_Main.main = function() {
	hxtag_dom_tools_Event.on(window.document,"DOMContentLoaded",hxtag_test_Main.ready);
};
hxtag_test_Main.ready = function(e) {
	var testBtn = window.document.querySelector("#test-btn");
	testBtn.setAttribute("icon","color:blue");
	testBtn.setAttribute("icon","color:green");
};
var hxtag_test_MyTag = function() { };
hxtag_test_MyTag.__super__ = hxtag_Tag;
hxtag_test_MyTag.prototype = $extend(hxtag_Tag.prototype,{
	createdCallback: function() {
		this.innerHTML = "My Tag";
		var si = hxtag_test_MyTag.imports[0];
		var doc = si["import"];
		window.document.body.appendChild(doc.querySelector("svg").cloneNode(true));
		console.log(doc.querySelector("#attachment"));
	}
});
var tags_Other = function() { };
tags_Other.__super__ = hxtag_Tag;
tags_Other.prototype = $extend(hxtag_Tag.prototype,{
	createdCallback: function() {
	}
});
var $_, $fid = 0;
function $bind(o,m) { if( m == null ) return null; if( m.__id__ == null ) m.__id__ = $fid++; var f; if( o.hx__closures__ == null ) o.hx__closures__ = {}; else f = o.hx__closures__[m.__id__]; if( f == null ) { f = function(){ return f.method.apply(f.scope, arguments); }; f.scope = o; f.method = m; o.hx__closures__[m.__id__] = f; } return f; }
var __iconSets = { }
__iconSets.src=new hx_iconsets_Src();
__iconSets.color=new hxtag_test_ColorIconSet();
hx_Btn.Element = window.document.registerElement("hx-btn",{ prototype : hx_Btn.prototype});
hx_BtnGroup.Element = window.document.registerElement("hx-btn-group",{ prototype : hx_BtnGroup.prototype});
hx_Icon.Element = window.document.registerElement("hx-icon",{ prototype : hx_Icon.prototype});
hxtag_test_MyTag.imports = [hxtag_Resource.importHtml("img/ic_attachment_24px.svg")];
hxtag_test_MyTag.Element = window.document.registerElement("my-tag",{ prototype : hxtag_test_MyTag.prototype});
tags_Other.Element = window.document.registerElement("tags-other",{ prototype : tags_Other.prototype});
hxtag_test_Main.main();
})();
