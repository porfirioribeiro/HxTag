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
			if(this.buttonGroup.get_checkable()) this.set_checkable(true);
			if(this.buttonGroup.get_exclusive()) {
				if(this.get_checked()) this.buttonGroup.exclusiveCheckedBtn = this;
			}
		}
		if(this.get_checked()) this.set_checkable(true);
		if(this.get_checkable()) this.addEventListener("click",$bind(this,this._clicked));
	}
	,detachedCallback: function() {
	}
	,attributeChangedCallback: function(attrName,oldVal,newVal) {
	}
	,_clicked: function(e) {
		this.set_checked(!this.get_checked());
		this.dispatchEvent(new Event("change"));
		if(this.buttonGroup != null) {
			if(this.buttonGroup.get_exclusive()) {
				if(this.buttonGroup.exclusiveCheckedBtn != null && this.buttonGroup.exclusiveCheckedBtn != this) this.buttonGroup.exclusiveCheckedBtn.set_checked(false);
				this.buttonGroup.exclusiveCheckedBtn = this;
			}
			this.buttonGroup.dispatchEvent(new CustomEvent("change",{ detail : { button : this}}));
		}
	}
	,get_checked: function() {
		return this.hasAttribute("checked");
	}
	,set_checked: function(v) {
		if(v) this.setAttribute("checked",""); else this.removeAttribute("checked");
		return v;
	}
	,get_checkable: function() {
		return this.hasAttribute("checkable");
	}
	,set_checkable: function(v) {
		if(v) this.setAttribute("checkable",""); else this.removeAttribute("checkable");
		return v;
	}
});
hx.BtnGroup = function() { };
hx.BtnGroup.__super__ = hxtag.Tag;
hx.BtnGroup.prototype = $extend(hxtag.Tag.prototype,{
	createdCallback: function() {
	}
	,testIt: function() {
		console.log("btn-group:test");
	}
	,get_exclusive: function() {
		return this.hasAttribute("exclusive");
	}
	,get_checkable: function() {
		return this.hasAttribute("checkable");
	}
});
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
	var el = window.document.querySelector("#hx-btn-ong");
	el.buttonGroup.onchange = function(e1) {
		console.log(e1.detail.button);
	};
};
var $_, $fid = 0;
function $bind(o,m) { if( m == null ) return null; if( m.__id__ == null ) m.__id__ = $fid++; var f; if( o.hx__closures__ == null ) o.hx__closures__ = {}; else f = o.hx__closures__[m.__id__]; if( f == null ) { f = function(){ return f.method.apply(f.scope, arguments); }; f.scope = o; f.method = m; o.hx__closures__[m.__id__] = f; } return f; }
hx.Btn.Element = window.document.registerElement("hx-btn",{ prototype : hx.Btn.prototype});
hx.BtnGroup.Element = window.document.registerElement("hx-btn-group",{ prototype : hx.BtnGroup.prototype});
test.Main.main();
