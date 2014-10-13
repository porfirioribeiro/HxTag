(function () { "use strict";
var console = (1,eval)('this').console || {log:function(){}};
var StringBuf = function() { };
var haxe = {};
haxe.IMap = function() { };
haxe.ds = {};
haxe.ds.StringMap = function() {
	this.h = { };
};
haxe.ds.StringMap.__interfaces__ = [haxe.IMap];
haxe.ds.StringMap.prototype = {
	set: function(key,value) {
		this.h["$" + key] = value;
	}
	,get: function(key) {
		return this.h["$" + key];
	}
	,exists: function(key) {
		return this.h.hasOwnProperty("$" + key);
	}
};
var js = {};
js.node = {};
js.node.NodeJS = function() { };
js.node.NodeJS.require = function(lib) {
	return require(lib);
};
var hxtag = {};
hxtag.tools = {};
hxtag.tools.Main = function() { };
hxtag.tools.Main.main = function() {
	if(!js.node.Fs.existsSync("hxtag.json")) {
		console.error("Missing file hxtag.json on current directory!");
		process.exit(1);
	}
	var args = process.argv.slice(2);
	while(args.length > 0) {
		var arg = args.shift();
		var c = arg;
		switch(arg) {
		case "--help":case "-h":
			console.log("Help");
			break;
		default:
			if(hxtag.tools.Main.commands.exists(c)) hxtag.tools.Main.command = hxtag.tools.Main.commands.get(c); else {
			}
		}
	}
	if(hxtag.tools.Main.command != null) hxtag.tools.Main.command();
};
hxtag.tools.Main.buildStylus = function() {
	var stylus = js.node.NodeJS.require("stylus");
	console.log("stylus command");
};
js.node.Buffer = require("buffer").Buffer;
js.node.events = {};
js.node.events.EventEmitter = require("events").EventEmitter;
js.node.Fs = require("fs");
js.node.stream = {};
js.node.stream.Readable = require("stream").Readable;
js.node.stream.Writable = require("stream").Writable;
hxtag.tools.Main.commands = (function($this) {
	var $r;
	var _g = new haxe.ds.StringMap();
	_g.set("stylus",hxtag.tools.Main.buildStylus);
	$r = _g;
	return $r;
}(this));
hxtag.tools.Main.main();
})();
