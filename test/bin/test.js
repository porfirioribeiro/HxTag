(function () { "use strict";
var console = (1,eval)('this').console || {log:function(){}};
function $extend(from, fields) {
	function Inherit() {} Inherit.prototype = from; var proto = new Inherit();
	for (var name in fields) proto[name] = fields[name];
	if( fields.toString !== Object.prototype.toString ) proto.toString = fields.toString;
	return proto;
}
var HxOverrides = function() { };
HxOverrides.__name__ = true;
HxOverrides.indexOf = function(a,obj,i) {
	var len = a.length;
	if(i < 0) {
		i += len;
		if(i < 0) i = 0;
	}
	while(i < len) {
		if(a[i] === obj) return i;
		i++;
	}
	return -1;
};
HxOverrides.remove = function(a,obj) {
	var i = HxOverrides.indexOf(a,obj,0);
	if(i == -1) return false;
	a.splice(i,1);
	return true;
};
HxOverrides.iter = function(a) {
	return { cur : 0, arr : a, hasNext : function() {
		return this.cur < this.arr.length;
	}, next : function() {
		return this.arr[this.cur++];
	}};
};
Math.__name__ = true;
var Std = function() { };
Std.__name__ = true;
Std.string = function(s) {
	return js.Boot.__string_rec(s,"");
};
var StringBuf = function() { };
StringBuf.__name__ = true;
StringBuf.prototype = {
	__class__: StringBuf
};
var haxe = {};
haxe.IMap = function() { };
haxe.IMap.__name__ = true;
haxe.ds = {};
haxe.ds.StringMap = function() {
	this.h = { };
};
haxe.ds.StringMap.__name__ = true;
haxe.ds.StringMap.__interfaces__ = [haxe.IMap];
haxe.ds.StringMap.prototype = {
	set: function(key,value) {
		this.h["$" + key] = value;
	}
	,get: function(key) {
		return this.h["$" + key];
	}
	,__class__: haxe.ds.StringMap
};
var hxtag = {};
hxtag.Tag = function() {
};
hxtag.Tag.__name__ = true;
hxtag.Tag.__super__ = Element;
hxtag.Tag.prototype = $extend(Element.prototype,{
	__class__: hxtag.Tag
});
var hx = {};
hx.Btn = function() {
	hxtag.Tag.call(this);
};
hx.Btn.__name__ = true;
hx.Btn.create = function() {
	return window.document.createElement("hx-btn");
};
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
	,get_checked: function() {
		return this.hasAttribute("checked");
	}
	,set_checked: function(v) {
		return hxtag.dom.tools.Attribute.toggleAtt(this,"checked",v);
	}
	,get_checkable: function() {
		return this.hasAttribute("checkable");
	}
	,set_checkable: function(v) {
		return hxtag.dom.tools.Attribute.toggleAtt(this,"checkable",v);
	}
	,__class__: hx.Btn
});
hx.BtnGroup = function() {
	hxtag.Tag.call(this);
};
hx.BtnGroup.__name__ = true;
hx.BtnGroup.create = function() {
	return window.document.createElement("hx-btn-group");
};
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
	,get_exclusive: function() {
		return this.hasAttribute("exclusive");
	}
	,set_exclusive: function(v) {
		return hxtag.dom.tools.Attribute.toggleAtt(this,"exclusive",v);
	}
	,get_checkable: function() {
		return this.hasAttribute("checkable");
	}
	,set_checkable: function(v) {
		return hxtag.dom.tools.Attribute.toggleAtt(this,"checkable",v);
	}
	,__class__: hx.BtnGroup
});
hxtag.Dom = function() { };
hxtag.Dom.__name__ = true;
hxtag.Dom.get_window = function() {
	return window;
};
hxtag.Dom.get_document = function() {
	return window.document;
};
hxtag.DomTools = function() { };
hxtag.DomTools.__name__ = true;
hxtag.dom = {};
hxtag.dom._ElementList = {};
hxtag.dom._ElementList.ElementList_Impl_ = function() { };
hxtag.dom._ElementList.ElementList_Impl_.__name__ = true;
hxtag.dom._ElementList.ElementList_Impl_.fromNodeList = function(list) {
	return list;
};
hxtag.dom._ElementList.ElementList_Impl_.fromNodeList2 = function(list) {
	return list;
};
hxtag.dom._ElementList.ElementList_Impl_.fromHTMLCollection = function(list) {
	return list;
};
hxtag.dom._ElementList.ElementList_Impl_.fromNodeArray = function(list) {
	return list;
};
hxtag.dom._ElementList.ElementList_Impl_.toNodeArray = function(this1) {
	return Array.prototype.slice.call(this1);
};
hxtag.dom._ElementList.ElementList_Impl_.arrayAccess = function(this1,i) {
	return this1[i];
};
hxtag.dom._ElementList.ElementList_Impl_.getById = function(id) {
	return [window.document.getElementById(id)];
};
hxtag.dom._ElementList.ElementList_Impl_.getByTagName = function(tag) {
	return window.document.getElementsByTagName(tag);
};
hxtag.dom._ElementList.ElementList_Impl_.getByClassName = function(name) {
	return window.document.getElementsByClassName(name);
};
hxtag.dom._ElementList.ElementList_Impl_.getByQuery = function(query) {
	return window.document.querySelectorAll(query);
};
hxtag.dom._ElementList.ElementList_Impl_.each = function(this1,callback) {
	var _g1 = 0;
	var _g = this1.length;
	while(_g1 < _g) {
		var e = _g1++;
		callback(this1[e]);
	}
};
hxtag.dom._ElementList.ElementList_Impl_.forEach = function(this1,e,ethis) {
	Array.prototype.forEach.call(this1,e,ethis);
};
hxtag.dom._ElementList.ElementList_Impl_.filter = function(this1,e) {
	return Array.prototype.filter.call(this1,e);
};
hxtag.dom._ElementList.ElementList_Impl_.concat = function(this1,el) {
	return Array.prototype.concat.apply(this1,el);
};
hxtag.dom._ElementList.ElementList_Impl_.get_length = function(this1) {
	return this1.length;
};
hxtag.dom.css = {};
hxtag.dom.css.ColorTools = function() { };
hxtag.dom.css.ColorTools.__name__ = true;
hxtag.dom.css.ColorTools.parseRGBA = function(rgbStr) {
	var rgba = { r : 0, g : 0, b : 0, a : 0};
	var match = /^(rgb|rgba)\((\d{1,3}),\s*(\d{1,3}),\s*(\d{1,3})(?:,\s*([0-1]{1}\.?[0-9]{1,2}))?\)$/i.exec(rgbStr);
	if(match != null) {
		rgba.r = parseInt(match[2],10);
		rgba.g = parseInt(match[3],10);
		rgba.b = parseInt(match[4],10);
		if(match[1] == "rgba") rgba.a = parseFloat(match[5]);
	}
	return rgba;
};
hxtag.dom.css.ColorTools.rgbToHsl = function(rgba) {
	var r = rgba.r / 255;
	var g = rgba.g / 255;
	var b = rgba.b / 255;
	var max = Math.max(r,g,b);
	var min = Math.min(r,g,b);
	var h = (max + min) / 2;
	var s = (max + min) / 2;
	var l = (max + min) / 2;
	if(max == min) h = s = 0; else {
		var d = max - min;
		if(l > 0.5) s = d / (2 - max - min); else s = d / (max + min);
		if(r == max) h = (g - b) / d + (g < b?6:0);
		if(g == max) h = (b - r) / d + 2;
		if(b == max) h = (r - g) / d + 4;
		h /= 6;
	}
	return { h : h, s : s, l : l, a : rgba.a};
};
hxtag.dom.css.ColorTools.hslToRgb = function(hsla) {
	var h = hsla.h;
	var s = hsla.s;
	var l = hsla.l;
	var r;
	var g;
	var b;
	if(s == 0) r = g = b = l; else {
		var hue2rgb = function(p,q,t) {
			if(t < 0) t += 1;
			if(t > 1) t -= 1;
			if(t < 0.166666666666666657) return p + (q - p) * 6 * t;
			if(t < 0.5) return q;
			if(t < 0.66666666666666663) return p + (q - p) * (0.66666666666666663 - t) * 6;
			return p;
		};
		var q1;
		if(l < 0.5) q1 = l * (1 + s); else q1 = l + s - l * s;
		var p1 = 2 * l - q1;
		r = hue2rgb(p1,q1,h + 0.333333333333333315);
		g = hue2rgb(p1,q1,h);
		b = hue2rgb(p1,q1,h - 0.333333333333333315);
	}
	return { r : r * 255 | 0, g : g * 255 | 0, b : b * 255 | 0, a : hsla.a};
};
hxtag.dom.css.ColorTools.rgbToHsv = function(rgba) {
	var r = rgba.r / 255;
	var g = rgba.g / 255;
	var b = rgba.b / 255;
	var max = Math.max(r,g,b);
	var min = Math.min(r,g,b);
	var h = max;
	var s = max;
	var v = max;
	var d = max - min;
	if(max == 0) s = 0; else s = d / max;
	if(max == min) h = 0; else {
		if(r == max) h = (g - b) / d + (g < b?6:0);
		if(g == max) h = (b - r) / d + 2;
		if(b == max) h = (r - g) / d + 4;
		h /= 6;
	}
	return { h : h, s : s, v : v, a : rgba.a};
};
hxtag.dom.css.ColorTools.hsvToRgb = function(hsva) {
	var h = hsva.h;
	var s = hsva.s;
	var v = hsva.v;
	var r = 0.0;
	var g = 0.0;
	var b = 0.0;
	var i = Math.floor(h * 6);
	var f = h * 6 - i;
	var p = v * (1 - s);
	var q = v * (1 - f * s);
	var t = v * (1 - (1 - f) * s);
	var _g = i % 6;
	switch(_g) {
	case 0:
		r = v;
		g = t;
		b = p;
		break;
	case 1:
		r = q;
		g = v;
		b = p;
		break;
	case 2:
		r = p;
		g = v;
		b = t;
		break;
	case 3:
		r = p;
		g = q;
		b = v;
		break;
	case 4:
		r = t;
		g = p;
		b = v;
		break;
	case 5:
		r = v;
		g = p;
		b = q;
		break;
	}
	return { r : r * 255 | 0, g : g * 255 | 0, b : b * 255 | 0, a : hsva.a};
};
hxtag.dom.css.ColorTools.saturateHSL = function(c,amount) {
	return { h : c.h, s : hxtag.dom.css.ColorTools.clamp(c.s += amount), l : c.l, a : c.a};
};
hxtag.dom.css.ColorTools.desaturateHSL = function(c,amount) {
	return { h : c.h, s : hxtag.dom.css.ColorTools.clamp(c.s -= amount), l : c.l, a : c.a};
};
hxtag.dom.css.ColorTools.lightenHSL = function(c,amount) {
	return { h : c.h, s : c.s, l : hxtag.dom.css.ColorTools.clamp(c.l += amount), a : c.a};
};
hxtag.dom.css.ColorTools.darkenHSL = function(c,amount) {
	return { h : c.h, s : c.s, l : hxtag.dom.css.ColorTools.clamp(c.l -= amount), a : c.a};
};
hxtag.dom.css.ColorTools.fadeinHSL = function(c,amount) {
	return { h : c.h, s : c.s, l : c.l, a : hxtag.dom.css.ColorTools.clamp(c.a += amount)};
};
hxtag.dom.css.ColorTools.fadeoutHSL = function(c,amount) {
	return { h : c.h, s : c.s, l : c.l, a : hxtag.dom.css.ColorTools.clamp(c.a -= amount)};
};
hxtag.dom.css.ColorTools.fadeHSL = function(c,amount) {
	return { h : c.h, s : c.s, l : c.l, a : Math.min(1,Math.max(0,amount))};
};
hxtag.dom.css.ColorTools.clamp = function(val) {
	return Math.min(1,Math.max(0,val));
};
hxtag.dom.css._Color = {};
hxtag.dom.css._Color.Color_Impl_ = function() { };
hxtag.dom.css._Color.Color_Impl_.__name__ = true;
hxtag.dom.css._Color.Color_Impl_.log = function(this1) {
	console.log(this1);
};
hxtag.dom.css._Color.Color_Impl_.fromString = function(str) {
	return hxtag.dom.css.ColorTools.parseRGBA(str);
};
hxtag.dom.css._Color.Color_Impl_.rgb = function(this1) {
	return this1;
};
hxtag.dom.css._Color.Color_Impl_.hsl = function(this1) {
	return hxtag.dom.css.ColorTools.rgbToHsl(this1);
};
hxtag.dom.css._Color.Color_Impl_.hsv = function(this1) {
	return hxtag.dom.css.ColorTools.rgbToHsv(this1);
};
hxtag.dom.css._Color.Color_Impl_.toString = function(this1) {
	return "rgba(" + this1.r + "," + this1.g + "," + this1.b + "," + this1.a + ")";
};
hxtag.dom.css._Color.Color_Impl_.saturate = function(this1,amount) {
	var this2;
	var this3 = hxtag.dom.css.ColorTools.rgbToHsl(this1);
	this2 = hxtag.dom.css.ColorTools.saturateHSL(this3,amount);
	return hxtag.dom.css.ColorTools.hslToRgb(this2);
};
hxtag.dom.css._Color.Color_Impl_.desaturate = function(this1,amount) {
	var this2;
	var this3 = hxtag.dom.css.ColorTools.rgbToHsl(this1);
	this2 = hxtag.dom.css.ColorTools.desaturateHSL(this3,amount);
	return hxtag.dom.css.ColorTools.hslToRgb(this2);
};
hxtag.dom.css._Color.Color_Impl_.greyscale = function(this1) {
	var this2;
	var this3 = hxtag.dom.css.ColorTools.rgbToHsl(this1);
	this2 = hxtag.dom.css.ColorTools.desaturateHSL(this3,1);
	return hxtag.dom.css.ColorTools.hslToRgb(this2);
};
hxtag.dom.css._Color.Color_Impl_.lighten = function(this1,amount) {
	var this2;
	var this3 = hxtag.dom.css.ColorTools.rgbToHsl(this1);
	this2 = hxtag.dom.css.ColorTools.lightenHSL(this3,amount);
	return hxtag.dom.css.ColorTools.hslToRgb(this2);
};
hxtag.dom.css._Color.Color_Impl_.darken = function(this1,amount) {
	var this2;
	var this3 = hxtag.dom.css.ColorTools.rgbToHsl(this1);
	this2 = hxtag.dom.css.ColorTools.darkenHSL(this3,amount);
	return hxtag.dom.css.ColorTools.hslToRgb(this2);
};
hxtag.dom.css._Color.Color_Impl_.fadein = function(this1,amount) {
	var this2;
	var this3 = hxtag.dom.css.ColorTools.rgbToHsl(this1);
	this2 = hxtag.dom.css.ColorTools.fadeinHSL(this3,amount);
	return hxtag.dom.css.ColorTools.hslToRgb(this2);
};
hxtag.dom.css._Color.Color_Impl_.fadeout = function(this1,amount) {
	var this2;
	var this3 = hxtag.dom.css.ColorTools.rgbToHsl(this1);
	this2 = hxtag.dom.css.ColorTools.fadeoutHSL(this3,amount);
	return hxtag.dom.css.ColorTools.hslToRgb(this2);
};
hxtag.dom.css._Color.Color_Impl_.fade = function(this1,amount) {
	var this2;
	var this3 = hxtag.dom.css.ColorTools.rgbToHsl(this1);
	this2 = hxtag.dom.css.ColorTools.fadeHSL(this3,amount);
	return hxtag.dom.css.ColorTools.hslToRgb(this2);
};
hxtag.dom.css._Color.HSLAColor_Impl_ = function() { };
hxtag.dom.css._Color.HSLAColor_Impl_.__name__ = true;
hxtag.dom.css._Color.HSLAColor_Impl_.fromColor = function(c) {
	return hxtag.dom.css.ColorTools.rgbToHsl(c);
};
hxtag.dom.css._Color.HSLAColor_Impl_.rgb = function(this1) {
	return hxtag.dom.css.ColorTools.hslToRgb(this1);
};
hxtag.dom.css._Color.HSLAColor_Impl_.hsl = function(this1) {
	return this1;
};
hxtag.dom.css._Color.HSLAColor_Impl_.hsv = function(this1) {
	var this2 = hxtag.dom.css.ColorTools.hslToRgb(this1);
	return hxtag.dom.css.ColorTools.rgbToHsv(this2);
};
hxtag.dom.css._Color.HSLAColor_Impl_.toString = function(this1) {
	return "hsla(" + this1.h * 360 + "," + this1.s * 100 + "%," + this1.l * 100 + "%," + this1.a + ")";
};
hxtag.dom.css._Color.HSLAColor_Impl_.saturate = function(this1,amount) {
	return hxtag.dom.css.ColorTools.saturateHSL(this1,amount);
};
hxtag.dom.css._Color.HSLAColor_Impl_.desaturate = function(this1,amount) {
	return hxtag.dom.css.ColorTools.desaturateHSL(this1,amount);
};
hxtag.dom.css._Color.HSLAColor_Impl_.greyscale = function(this1) {
	return hxtag.dom.css.ColorTools.desaturateHSL(this1,1);
};
hxtag.dom.css._Color.HSLAColor_Impl_.lighten = function(this1,amount) {
	return hxtag.dom.css.ColorTools.lightenHSL(this1,amount);
};
hxtag.dom.css._Color.HSLAColor_Impl_.darken = function(this1,amount) {
	return hxtag.dom.css.ColorTools.darkenHSL(this1,amount);
};
hxtag.dom.css._Color.HSLAColor_Impl_.fadein = function(this1,amount) {
	return hxtag.dom.css.ColorTools.fadeinHSL(this1,amount);
};
hxtag.dom.css._Color.HSLAColor_Impl_.fadeout = function(this1,amount) {
	return hxtag.dom.css.ColorTools.fadeoutHSL(this1,amount);
};
hxtag.dom.css._Color.HSLAColor_Impl_.fade = function(this1,amount) {
	return hxtag.dom.css.ColorTools.fadeHSL(this1,amount);
};
hxtag.dom.css._Color.HSVAColor_Impl_ = function() { };
hxtag.dom.css._Color.HSVAColor_Impl_.__name__ = true;
hxtag.dom.css._Color.HSVAColor_Impl_.fromColor = function(c) {
	var this1 = hxtag.dom.css.ColorTools.rgbToHsl(c);
	var this2 = hxtag.dom.css.ColorTools.hslToRgb(this1);
	return hxtag.dom.css.ColorTools.rgbToHsv(this2);
};
hxtag.dom.css._Color.HSVAColor_Impl_.rgb = function(this1) {
	return hxtag.dom.css.ColorTools.hsvToRgb(this1);
};
hxtag.dom.css._Color.HSVAColor_Impl_.hsl = function(this1) {
	var this2 = hxtag.dom.css.ColorTools.hsvToRgb(this1);
	return hxtag.dom.css.ColorTools.rgbToHsl(this2);
};
hxtag.dom.css._Color.HSVAColor_Impl_.hsv = function(this1) {
	return this1;
};
hxtag.dom.tools = {};
hxtag.dom.tools.Attribute = function() { };
hxtag.dom.tools.Attribute.__name__ = true;
hxtag.dom.tools.Attribute.toggleAtt = function(e,name,v) {
	if(v) return e.setAttribute(name,""); else return e.removeAttribute(name);
};
hxtag.dom.tools.Attribute.getAtt = function(e,name) {
	return e.getAttribute(name);
};
hxtag.dom.tools.Attribute.setAtt = function(e,name,v) {
	e.setAttribute(name,v);
};
hxtag.dom.tools.Css = function() { };
hxtag.dom.tools.Css.__name__ = true;
hxtag.dom.tools.Css.getComputedStyle = function(e,name) {
	return window.getComputedStyle(e).getPropertyValue(name);
};
hxtag.dom.tools.Css.getColor = function(e,name) {
	return hxtag.dom.css.ColorTools.parseRGBA(window.getComputedStyle(e).getPropertyValue(name));
};
hxtag.dom.tools.Css.show = function(e) {
	e.style.display = "block";
};
hxtag.dom.tools.Css.hide = function(e) {
	e.style.display = "none";
};
hxtag.dom.tools.Css.toggle = function(e) {
	if(window.getComputedStyle(e).getPropertyValue("display") == "none") e.style.display = "block"; else e.style.display = "none";
};
hxtag.dom.tools.Css.moveTo = function(e,x,y) {
	e.style.left = x + "px";
	e.style.top = y + "px";
};
hxtag.dom.tools.Data = function() { };
hxtag.dom.tools.Data.__name__ = true;
hxtag.dom.tools.Data.hasData = function(e,key) {
	return !(!e.dataset[key]);
};
hxtag.dom.tools.Data.getData = function(e,key) {
	return e.dataset[key];
};
hxtag.dom.tools.Data.setData = function(e,key,value) {
	return e.dataset[key] = value;
};
hxtag.dom.tools._Event = {};
hxtag.dom.tools._Event.LiveCon_Impl_ = function() { };
hxtag.dom.tools._Event.LiveCon_Impl_.__name__ = true;
hxtag.dom.tools._Event.LiveCon_Impl_.die = function(this1) {
	hxtag.dom.tools.Event.removeLiveEvent(this1.selector,this1.eventType,this1.eventListener);
};
hxtag.dom.tools.Event = function() {
};
hxtag.dom.tools.Event.__name__ = true;
hxtag.dom.tools.Event.on = function(e,eventType,eventListener) {
	e.addEventListener(eventType,eventListener);
};
hxtag.dom.tools.Event.off = function(e,eventType,eventListener) {
	e.removeEventListener(eventType,eventListener);
};
hxtag.dom.tools.Event.one = function(e,eventType,eventListener) {
	var fn = null;
	fn = function(event) {
		eventListener(event);
		e.removeEventListener(eventType,fn);
	};
	e.addEventListener(eventType,fn);
	return fn;
};
hxtag.dom.tools.Event.fireCustomEvent = function(e,eventType,detail) {
	e.dispatchEvent(new CustomEvent(eventType,{ detail : detail}));
};
hxtag.dom.tools.Event.live = function(selector,eventType,eventListener) {
	return hxtag.dom.tools.Event.addLiveEvent(selector,eventType,eventListener);
};
hxtag.dom.tools.Event.die = function(selector,eventType,eventListener) {
	hxtag.dom.tools.Event.removeLiveEvent(selector,eventType,eventListener);
};
hxtag.dom.tools.Event.handleLiveEvent = function(event) {
	var evt = hxtag.dom.tools.Event.liveEvents.get(event.type);
	if(evt != null) {
		var _g = 0;
		while(_g < evt.length) {
			var evs = evt[_g];
			++_g;
			if(hxtag.dom.tools.Polyfill.matches(js.Boot.__cast(event.target , Element),evs.selector)) evs.eventListener(event);
		}
	}
};
hxtag.dom.tools.Event.addLiveEvent = function(selector,eventType,eventListener) {
	if(HxOverrides.indexOf(hxtag.dom.tools.Event.registedLiveEvents,eventType,0) == -1) {
		hxtag.dom.tools.Event.on(window.document,eventType,hxtag.dom.tools.Event.handleLiveEvent);
		hxtag.dom.tools.Event.registedLiveEvents.push(eventType);
	}
	if(hxtag.dom.tools.Event.liveEvents.get(eventType) == null) {
		var v = [];
		hxtag.dom.tools.Event.liveEvents.set(eventType,v);
		v;
	}
	var con = { selector : selector, eventType : eventType, eventListener : eventListener};
	hxtag.dom.tools.Event.liveEvents.get(eventType).push(con);
	return con;
};
hxtag.dom.tools.Event.removeLiveEvent = function(selector,eventType,eventListener) {
	if(HxOverrides.indexOf(hxtag.dom.tools.Event.registedLiveEvents,eventType,0) == -1 || hxtag.dom.tools.Event.liveEvents.get(eventType) == null) return;
	var _g = 0;
	var _g1 = hxtag.dom.tools.Event.liveEvents.get(eventType);
	while(_g < _g1.length) {
		var evo = _g1[_g];
		++_g;
		if(evo.selector == selector && evo.eventListener == eventListener) {
			var _this = hxtag.dom.tools.Event.liveEvents.get(eventType);
			HxOverrides.remove(_this,evo);
		}
	}
	if(hxtag.dom.tools.Event.liveEvents.get(eventType).length == 0) {
		hxtag.dom.tools.Event.off(window.document,eventType,hxtag.dom.tools.Event.handleLiveEvent);
		HxOverrides.remove(hxtag.dom.tools.Event.registedLiveEvents,eventType);
	}
};
hxtag.dom.tools.Event.prototype = {
	__class__: hxtag.dom.tools.Event
};
hxtag.dom.tools.Polyfill = function() { };
hxtag.dom.tools.Polyfill.__name__ = true;
hxtag.dom.tools.Polyfill.matches = function(e,selector) {
	return e.matches(selector);
};
hxtag.dom.tools.Traversing = function() { };
hxtag.dom.tools.Traversing.__name__ = true;
hxtag.dom.tools.Traversing.add = function(e) {
	console.log("add element" + e.className);
};
hxtag.dom.tools.Traversing["is"] = function(e,t) {
	return (e instanceof t);
};
hxtag.dom.tools.Traversing.parent = function(e,selector) {
	var parent = e.parentNode;
	if(selector != null) if(parent != null && parent.nodeType == 1 && parent.matches(selector)) return parent; else return null;
	if(parent != null && parent.nodeType != 11) return parent; else return null;
};
hxtag.dom.tools.Traversing.parentT = function(e,t) {
	if((e.parentNode instanceof t)) return e.parentNode;
};
hxtag.dom.tools.Traversing.parents = function(e,selector) {
	return null;
};
hxtag.dom.tools.Traversing.closest = function(e,selector) {
	while(e != null) {
		if(e.nodeType == 1 && e.matches(selector)) return e;
		e = e.parentNode;
	}
	return null;
};
hxtag.dom.tools.Traversing.closestT = function(e,t) {
	while(e != null) {
		if((e instanceof t)) return e;
		e = e.parentNode;
	}
	return null;
};
hxtag.dom.tools.TraversingList = function() { };
hxtag.dom.tools.TraversingList.__name__ = true;
hxtag.dom.tools.TraversingList.add = function(el) {
	console.log("add elementlist");
	var _g1 = 0;
	var _g = el.length;
	while(_g1 < _g) {
		var e = _g1++;
		hxtag.dom.tools.Traversing.add(el[e]);
	}
};
hxtag.dom.tools.TraversingList.findByTag = function(el,tag) {
	var r = [];
	var _g1 = 0;
	var _g = el.length;
	while(_g1 < _g) {
		var e = _g1++;
		Array.prototype.push.apply(r,el[e].getElementsByTagName(tag));
	}
	return r;
};
hxtag.dom.tools.TraversingList.findByClass = function(el,tag) {
	var r = [];
	var _g1 = 0;
	var _g = el.length;
	while(_g1 < _g) {
		var e = _g1++;
		Array.prototype.push.apply(r,el[e].getElementsByClassName(tag));
	}
	return r;
};
hxtag.dom.tools.TraversingList.findByQuery = function(el,tag) {
	var r = [];
	var _g1 = 0;
	var _g = el.length;
	while(_g1 < _g) {
		var e = _g1++;
		Array.prototype.push.apply(r,el[e].querySelectorAll(tag));
	}
	return r;
};
hxtag.test = {};
hxtag.test.Main = function() {
	console.log("new");
};
hxtag.test.Main.__name__ = true;
hxtag.test.Main.main = function() {
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
	hxtag.dom.tools.Event.on(window.document,"DOMContentLoaded",hxtag.test.Main.ready);
};
hxtag.test.Main.ready = function(e) {
	var btn = window.document.createElement("hx-btn");
	btn.innerHTML = "btn";
	window.document.body.appendChild(btn);
	window.document.body.removeChild(btn);
	var el = window.document.querySelector("#hx-btn-ong");
};
hxtag.test.Main.prototype = {
	__class__: hxtag.test.Main
};
hxtag.tools = {};
hxtag.tools.StringTools = function() { };
hxtag.tools.StringTools.__name__ = true;
hxtag.tools.StringTools.equals = function(string,text,insensitive) {
	if(insensitive == null) insensitive = false;
	return string == text;
};
hxtag.tools.StringTools.iequals = function(string,text) {
	return string.toLowerCase() == text.toLowerCase();
};
hxtag.tools.StringTools.contains = function(string,text) {
	return string.indexOf(text) > -1;
};
hxtag.tools.StringTools.startsWith = function(string,text) {
	return string.indexOf(text) == 0;
};
hxtag.tools.StringTools.endsWith = function(string,text) {
	return string.indexOf(text) == string.length - text.length;
};
hxtag.tools.StringTools.empty = function(string) {
	return string == "";
};
hxtag.tools.StringTools.blank = function(string) {
	return /^\s*$/.test(string);
};
hxtag.tools.StringTools.isUpperCase = function(string) {
	return string.toUpperCase() == string;
};
hxtag.tools.StringTools.isLowerCase = function(string) {
	return string.toLowerCase() == string;
};
hxtag.tools.StringTools.capitalize = function(string) {
	return string.charAt(0).toUpperCase() + string.substring(1).toLowerCase();
};
hxtag.tools.StringTools.camelize = function(string) {
	var arr = string.split("-");
	var _g1 = 1;
	var _g = arr.length;
	while(_g1 < _g) {
		var i = _g1++;
		arr[i] = hxtag.tools.StringTools.capitalize(arr[i]);
	}
	return arr.join("");
};
hxtag.tools.StringTools.uncamelize = function(string) {
	return string.replace(/((?!^)[A-Z])/g,"-$1").toLowerCase();
};
hxtag.tools.StringTools.replace = function(string,sub,by) {
	return string.split(sub).join(by);
};
hxtag.tools.StringTools.ltrim = function(string) {
	return string.replace(/(^\s+)/g,"");
};
hxtag.tools.StringTools.rtrim = function(string) {
	return string.replace(/(\s+$)/g,"");
};
hxtag.tools.StringTools.trim = function(string) {
	return string.replace(/((^\s+)|(\s+$))/g,"");
};
hxtag.tools.StringTools.toInt = function(string,radix) {
	if(radix == null) radix = 10;
	return parseInt(string,radix);
};
hxtag.tools.StringTools.toFloat = function(string) {
	return parseFloat(string);
};
var js = {};
js.Boot = function() { };
js.Boot.__name__ = true;
js.Boot.getClass = function(o) {
	if((o instanceof Array) && o.__enum__ == null) return Array; else {
		var cl = o.__class__;
		if(cl != null) return cl;
		var name = js.Boot.__nativeClassName(o);
		if(name != null) return js.Boot.__resolveNativeClass(name);
		return null;
	}
};
js.Boot.__string_rec = function(o,s) {
	if(o == null) return "null";
	if(s.length >= 5) return "<...>";
	var t = typeof(o);
	if(t == "function" && (o.__name__ || o.__ename__)) t = "object";
	switch(t) {
	case "object":
		if(o instanceof Array) {
			if(o.__enum__) {
				if(o.length == 2) return o[0];
				var str2 = o[0] + "(";
				s += "\t";
				var _g1 = 2;
				var _g = o.length;
				while(_g1 < _g) {
					var i1 = _g1++;
					if(i1 != 2) str2 += "," + js.Boot.__string_rec(o[i1],s); else str2 += js.Boot.__string_rec(o[i1],s);
				}
				return str2 + ")";
			}
			var l = o.length;
			var i;
			var str1 = "[";
			s += "\t";
			var _g2 = 0;
			while(_g2 < l) {
				var i2 = _g2++;
				str1 += (i2 > 0?",":"") + js.Boot.__string_rec(o[i2],s);
			}
			str1 += "]";
			return str1;
		}
		var tostr;
		try {
			tostr = o.toString;
		} catch( e ) {
			return "???";
		}
		if(tostr != null && tostr != Object.toString) {
			var s2 = o.toString();
			if(s2 != "[object Object]") return s2;
		}
		var k = null;
		var str = "{\n";
		s += "\t";
		var hasp = o.hasOwnProperty != null;
		for( var k in o ) {
		if(hasp && !o.hasOwnProperty(k)) {
			continue;
		}
		if(k == "prototype" || k == "__class__" || k == "__super__" || k == "__interfaces__" || k == "__properties__") {
			continue;
		}
		if(str.length != 2) str += ", \n";
		str += s + k + " : " + js.Boot.__string_rec(o[k],s);
		}
		s = s.substring(1);
		str += "\n" + s + "}";
		return str;
	case "function":
		return "<function>";
	case "string":
		return o;
	default:
		return String(o);
	}
};
js.Boot.__interfLoop = function(cc,cl) {
	if(cc == null) return false;
	if(cc == cl) return true;
	var intf = cc.__interfaces__;
	if(intf != null) {
		var _g1 = 0;
		var _g = intf.length;
		while(_g1 < _g) {
			var i = _g1++;
			var i1 = intf[i];
			if(i1 == cl || js.Boot.__interfLoop(i1,cl)) return true;
		}
	}
	return js.Boot.__interfLoop(cc.__super__,cl);
};
js.Boot.__instanceof = function(o,cl) {
	if(cl == null) return false;
	switch(cl) {
	case Int:
		return (o|0) === o;
	case Float:
		return typeof(o) == "number";
	case Bool:
		return typeof(o) == "boolean";
	case String:
		return typeof(o) == "string";
	case Array:
		return (o instanceof Array) && o.__enum__ == null;
	case Dynamic:
		return true;
	default:
		if(o != null) {
			if(typeof(cl) == "function") {
				if(o instanceof cl) return true;
				if(js.Boot.__interfLoop(js.Boot.getClass(o),cl)) return true;
			} else if(typeof(cl) == "object" && js.Boot.__isNativeObj(cl)) {
				if(o instanceof cl) return true;
			}
		} else return false;
		if(cl == Class && o.__name__ != null) return true;
		if(cl == Enum && o.__ename__ != null) return true;
		return o.__enum__ == cl;
	}
};
js.Boot.__cast = function(o,t) {
	if(js.Boot.__instanceof(o,t)) return o; else throw "Cannot cast " + Std.string(o) + " to " + Std.string(t);
};
js.Boot.__nativeClassName = function(o) {
	var name = js.Boot.__toStr.call(o).slice(8,-1);
	if(name == "Object" || name == "Function" || name == "Math" || name == "JSON") return null;
	return name;
};
js.Boot.__isNativeObj = function(o) {
	return js.Boot.__nativeClassName(o) != null;
};
js.Boot.__resolveNativeClass = function(name) {
	if(typeof window != "undefined") return window[name]; else return global[name];
};
js.Browser = function() { };
js.Browser.__name__ = true;
var $_, $fid = 0;
function $bind(o,m) { if( m == null ) return null; if( m.__id__ == null ) m.__id__ = $fid++; var f; if( o.hx__closures__ == null ) o.hx__closures__ = {}; else f = o.hx__closures__[m.__id__]; if( f == null ) { f = function(){ return f.method.apply(f.scope, arguments); }; f.scope = o; f.method = m; o.hx__closures__[m.__id__] = f; } return f; }
if(Array.prototype.indexOf) HxOverrides.indexOf = function(a,o,i) {
	return Array.prototype.indexOf.call(a,o,i);
};
String.prototype.__class__ = String;
String.__name__ = true;
Array.__name__ = true;
var Int = { __name__ : ["Int"]};
var Dynamic = { __name__ : ["Dynamic"]};
var Float = Number;
Float.__name__ = ["Float"];
var Bool = Boolean;
Bool.__ename__ = ["Bool"];
var Class = { __name__ : ["Class"]};
var Enum = { };
Element.prototype.matches = Element.prototype.matches || Element.prototype.webkitMatchesSelector || Element.prototype.mozMatchesSelector || Element.prototype.msMatchesSelector || Element.prototype.oMatchesSelector;
hx.Btn.TAG = "hx-btn";
hx.Btn.Element = window.document.registerElement("hx-btn",{ prototype : hx.Btn.prototype});
hx.BtnGroup.TAG = "hx-btn-group";
hx.BtnGroup.Element = window.document.registerElement("hx-btn-group",{ prototype : hx.BtnGroup.prototype});
hxtag.dom.tools.Event.registedLiveEvents = [];
hxtag.dom.tools.Event.liveEvents = new haxe.ds.StringMap();
js.Boot.__toStr = {}.toString;
hxtag.test.Main.main();
})();
