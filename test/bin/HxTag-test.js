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
		var iconSet = parts.shift();
		var icon = parts.join(":");
		if(!(iconSet in hxtag_IconSet.__iconSets)) return;
		hxtag_IconSet.__iconSets[iconSet].applyIcon(this,icon);
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
hxtag_IconSet.__iconSets = { };
hxtag_IconSet.__iconSets.src = new hx_iconsets_Src();
hxtag_IconSet.__iconSets.color = new hxtag_test_ColorIconSet();
hx_Icon.Element = window.document.registerElement("hx-icon",{ prototype : hx_Icon.prototype});
hxtag_test_Main.main();
})();
