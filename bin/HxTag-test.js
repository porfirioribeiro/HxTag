function $extend(from, fields) {
	function Inherit() {} Inherit.prototype = from; var proto = new Inherit();
	for (var name in fields) proto[name] = fields[name];
	if( fields.toString !== Object.prototype.toString ) proto.toString = fields.toString;
	return proto;
}
var Std = function() { };
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
		this.on2("click",$bind(this,this._clicked));
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
		console.log(this.checked);
	}},
	on2:{value: function(eventType,eventListener) {
		if(eventType == "click:") this.addEventListener("click",eventListener); else if(eventType == "change") this.addEventListener("change",eventListener); else this.addEventListener(eventType,eventListener);
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
if(!hxtag.dom) hxtag.dom = {};
if(!hxtag.dom.tools) hxtag.dom.tools = {};
hxtag.dom.tools.Polyfill = function() { };
var test = test || {};
test.Main = function() { };
test.Main.main = function() {
};
var $_, $fid = 0;
function $bind(o,m) { if( m == null ) return null; if( m.__id__ == null ) m.__id__ = $fid++; var f; if( o.hx__closures__ == null ) o.hx__closures__ = {}; else f = o.hx__closures__[m.__id__]; if( f == null ) { f = function(){ return f.method.apply(f.scope, arguments); }; f.scope = o; f.method = m; o.hx__closures__[m.__id__] = f; } return f; }
;
;
test.Main.main();
