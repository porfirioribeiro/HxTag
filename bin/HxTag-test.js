function $extend(from, fields) {
	function Inherit() {} Inherit.prototype = from; var proto = new Inherit();
	for (var name in fields) proto[name] = fields[name];
	if( fields.toString !== Object.prototype.toString ) proto.toString = fields.toString;
	return proto;
}
Math.__name__ = true;
var Std = function() { };
Std.__name__ = true;
Std.string = function(s) {
	return js.Boot.__string_rec(s,"");
};
var StringBuf = function() { };
StringBuf.__name__ = true;
var hxtag = hxtag || {};
hxtag.Tag = function() { };
hxtag.Tag.__name__ = true;
hxtag.Tag.__super__ = Element;
hxtag.Tag.prototype = $extend(Element.prototype,{
});
var hx = hx || {};
hx.Btn = function() { };
hx.Btn.__name__ = true;
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
		console.log(this);
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
hx.BtnGroup.__name__ = true;
hx.BtnGroup.__super__ = hxtag.Tag;
hx.BtnGroup.prototype = $extend(hxtag.Tag.prototype,{
	createdCallback: function() {
	}
	,attachedCallback: function() {
		console.log("attached");
	}
	,detachedCallback: function() {
		console.log("detached" + Std.string(this));
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
hxtag.Dom.__name__ = true;
if(!hxtag.dom) hxtag.dom = {};
if(!hxtag.dom._ElementList) hxtag.dom._ElementList = {};
hxtag.dom._ElementList.ElementList_Impl_ = function() { };
hxtag.dom._ElementList.ElementList_Impl_.__name__ = true;
if(!hxtag.dom.tools) hxtag.dom.tools = {};
hxtag.dom.tools.Event = function() { };
hxtag.dom.tools.Event.__name__ = true;
hxtag.dom.tools.Event.on = function(e,eventType,eventListener) {
	e.addEventListener(eventType,eventListener);
};
hxtag.dom.tools.Polyfill = function() { };
hxtag.dom.tools.Polyfill.__name__ = true;
var js = js || {};
js.Boot = function() { };
js.Boot.__name__ = true;
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
js.Browser = function() { };
js.Browser.__name__ = true;
var test = test || {};
test.Main = function() { };
test.Main.__name__ = true;
test.Main.main = function() {
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
	hxtag.dom.tools.Event.on(window.document,"DOMContentLoaded",test.Main.ready);
};
test.Main.ready = function(e) {
	console.log("ready");
	var btn = window.document.createElement("hx-btn");
	btn.innerHTML = "btn";
	window.document.body.appendChild(btn);
	window.document.body.removeChild(btn);
	var el = window.document.querySelector("#hx-btn-ong");
};
var $_, $fid = 0;
function $bind(o,m) { if( m == null ) return null; if( m.__id__ == null ) m.__id__ = $fid++; var f; if( o.hx__closures__ == null ) o.hx__closures__ = {}; else f = o.hx__closures__[m.__id__]; if( f == null ) { f = function(){ return f.method.apply(f.scope, arguments); }; f.scope = o; f.method = m; o.hx__closures__[m.__id__] = f; } return f; }
String.__name__ = true;
Array.__name__ = true;
hx.Btn.Element = window.document.registerElement("hx-btn",{ prototype : hx.Btn.prototype});
hx.BtnGroup.Element = window.document.registerElement("hx-btn-group",{ prototype : hx.BtnGroup.prototype});
test.Main.main();
