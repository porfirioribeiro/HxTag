/**
 * ...
 * @author Porfirio
 */


function w_get(k){
	return window.localStorage["window."+k] ;
}
function w_set(k,v){
	window.localStorage["window."+k]=v;
}
 
var winStorage={

	init:function(win){
		winStorage.restoreState(win);
		if (w_get("maximized")=="true")
			win.maximize();
		
		win.on('maximize', function () {
			w_set("maximized",true);
		});

		win.on('unmaximize', function () {
			w_set("maximized",false);
		});
		var resizeTimeout=null;
		win.window.addEventListener('resize', function () {
			clearTimeout(resizeTimeout);
			resizeTimeout = setTimeout(function () {
				w_set("x",win.x);
				w_set("y",win.y);
				w_set("width",win.width);
				w_set("height",win.height);
			}, 500);
		}, false);	
		
	},
	restoreState:function(win){
		var x=w_get("x");
		var y=w_get("y");
		var width=w_get("width");
		var height=w_get("height");
		if (width && height)
			win.window.resizeTo(width, height);
		if (x && y)
			win.window.moveTo(x, y);
	}
}

var initialized=false;
exports.init=function(){
	var gui=window.require('nw.gui');
	var win = gui.Window.get();
	
	if (!initialized){
		initialized=true;
		init_singleInstance();
		init_watcher();
		if (gui.App.manifest["show-dev-tools"])
			win.showDevTools();
		if (gui.App.manifest["save-window-state"])
			winStorage.init(win);
	}else{
		//console.log("reload");
	}		
	//Always executed code
	window.addEventListener("keydown",function(e){
		if (e.ctrlKey){
			switch (String.fromCharCode(e.which)){
				case 'R': 
					window.location.reload(true);
					break;
				case 'W':
				case 'Q':
					gui.App.quit();
					break;
				case 'D':
					win.showDevTools();
					break;
			}
		}
		
	});
}


function init_singleInstance(){
	'use strict';
	//Single instance
	var http = require('http');
	var nwWindow = window.require('nw.gui').Window.get();

	var port = 9064; //some random port that is unlikely to be used by other apps

	//Try to create server
	var server = http.createServer(function (req, res) {
		res.writeHead(200, {'Content-Type': 'text/plain'});
		res.end('Prepros App');
		//Show and maximize window on request
		
		nwWindow.show();
		nwWindow.focus();
		nwWindow.requestAttention(true);
	}).listen(port, '127.0.0.1', function(){
		nwWindow.show();
	});

	//Error means another instance is running
	//So request the server to show previous instance
	server.on('error', function(){
		http.get('http://127.0.0.1:' + port, function() {
			nwWindow.close(true);
		});
	});	
}

function init_watcher(){
	'use strict';
	
	var path = './';
	var fs = require('fs');
	
	fs.watch(path, function(event, filename) {
		if (filename) {
			window.location.reload();
		} 
	});
}


