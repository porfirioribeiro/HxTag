function $extend(from, fields) {
	function Inherit() {} Inherit.prototype = from; var proto = new Inherit();
	for (var name in fields) proto[name] = fields[name];
	if( fields.toString !== Object.prototype.toString ) proto.toString = fields.toString;
	return proto;
}
var Std = function() { };
var StringBuf = function() { };
StringBuf.prototype = {
};
var hxtag = hxtag || {};
hxtag.Tag = function() { };
hxtag.Tag.__super__ = Element;
hxtag.Tag.prototype = $extend(Element.prototype,{
});
var hx = hx || {};
hx.Btn__prototype=Object.create(hxtag.Tag.prototype, {
	checked: {
		get: function() {
		return this.hasAttribute("checked");
	},
		set: function(v) {
		if(v) this.setAttribute("checked",""); else this.removeAttribute("checked");
		return v;
	}
	},
	checkable: {
		get: function() {
		return this.hasAttribute("checkable");
	},
		set: function(v) {
		if(v) this.setAttribute("checkable",""); else this.removeAttribute("checkable");
		return v;
	}
	},
	createdCallback:{value: function() {
		this.addEventListener("click",$bind(this,this._clicked));
	}},
	attachedCallback:{value: function() {
		var p;
		if((this.parentNode instanceof hx.BtnGroup)) p = this.parentNode;
		if(p != null) p.testIt();
	}},
	detachedCallback:{value: function() {
	}},
	attributeChangedCallback:{value: function(attrName,oldVal,newVal) {
	}},
	_clicked:{value: function(e) {
		this.checked = !this.checked;
		this.dispatchEvent(new Event("changed"));
	}}
})
hx.Btn = document.registerElement("hx-btn",{
	prototype: hx.Btn__prototype
});
if (!hx.Btn.prototype) hx.Btn.prototype=hx.Btn__prototype;
hx.Btn.__super__ = hxtag.Tag;
hx.BtnGroup__prototype=Object.create(hxtag.Tag.prototype, {
	createdCallback:{value: function() {
	}},
	testIt:{value: function() {
		console.log("btn-group:test");
	}}
})
hx.BtnGroup = document.registerElement("hx-btn-group",{
	prototype: hx.BtnGroup__prototype
});
if (!hx.BtnGroup.prototype) hx.BtnGroup.prototype=hx.BtnGroup__prototype;
hx.BtnGroup.__super__ = hxtag.Tag;
hxtag.Dom = function() { };
if(!hxtag.dom) hxtag.dom = {};
if(!hxtag.dom._ElementList) hxtag.dom._ElementList = {};
hxtag.dom._ElementList.ElementList_Impl_ = function() { };
if(!hxtag.dom.tools) hxtag.dom.tools = {};
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
	hxtag.dom.tools.Event.on(window.document,"DOMContentLoaded",test.Main.ready);
};
test.Main.ready = function(e) {
	console.log("ready");
	var els;
	var list = window.document.querySelectorAll("hx-btn");
	els = list;
	var _g1 = 0;
	var _g = els.length;
	while(_g1 < _g) {
		var e1 = _g1++;
		(function(el) {
			el.addEventListener("changed",function(e2) {
				console.log(e2.target.checked);
			});
		})(els[e1]);
	}
};
var $_, $fid = 0;
function $bind(o,m) { if( m == null ) return null; if( m.__id__ == null ) m.__id__ = $fid++; var f; if( o.hx__closures__ == null ) o.hx__closures__ = {}; else f = o.hx__closures__[m.__id__]; if( f == null ) { f = function(){ return f.method.apply(f.scope, arguments); }; f.scope = o; f.method = m; o.hx__closures__[m.__id__] = f; } return f; }
;
;
test.Main.main();
