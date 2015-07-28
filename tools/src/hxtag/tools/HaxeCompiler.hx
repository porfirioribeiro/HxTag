package hxtag.tools;
import sys.net.Host;
import sys.net.Socket;

enum Mode {
	Debug;
	Release;
}

class HaxeCompiler {
	public var host:String = "localhost";
	public var port:Int = 6000;
	public var hxml:String = "build.hxml";
	var args:Array<String>;
	
	
	public var useServer = false;
	public var runDir = '.';
	public var mode:Mode = Mode.Release;
	
	public function new() { args = []; }
	
	public function addArg(arg:String, set:String=null) {
		args.push(arg);
		if (set != null)
			args.push(set);
	}
	
	public function addArgs(nargs:Array<String>) {
		args = args.concat(nargs);
	}
	
	public function addDefine(def:String, val:String = null) {
		addArg("-D", def + ((val == null) ? '' : '=$val'));
	}	
	
	public function addLib(lib:String) {
		addArg("-lib", lib);
	}
	
	public function connect(addr:String) {
		useServer = true;
		var a = addr.split(":");
		if (a.length == 2) {
			host = a[0];
			port = Std.parseInt(a[1]);
		}else
			port = Std.parseInt(addr);
	}
	
	public function run() {
		switch(mode) {
			case Debug: addArg("-debug");
			case Release: addDefine("release");
		}
		
		addArg(hxml);
		
		if (useServer)
			return runServer();
			
		Sys.setCwd(runDir);
		return Sys.command("haxe", args);
	}
	
	function runServer() {
		log("run server");

		var s:Socket;
		try {
			s = new Socket();
			s.connect(new Host(host), port);
			log('Connected to ' + host + ':' + port);
		} catch (z:Dynamic) {
			error('Could not connect to ' + host + ':' + port);
			error("Please check if the server is running on the specified host:port");
			error("Run the server on the target machine with the command:");
			error("\thaxe --wait 0.0.0.0:" + port);
			return 1;
		}
		
		// haxe -v --connect 192.168.1.65:8081 --cwd  /media/Data/Dev/Haxe/AgroGest AgroGest.hxml  
		s.write("--cwd " + runDir + "\n");
		s.write(args.join("\n"));
		s.write("\n\000");
		
		s.waitForRead();

		var str:String = s.input.readAll().toString();
				
        var hasError = false;
		var lines:Array<String> = str.split("\n");
				
        for ( line in lines )
            switch( line.charCodeAt(0) ) {
				case 0x01: Sys.print(line.substr(1).split("\x01").join("\n"));
				case 0x02: hasError = true;
				default: {
					if (line.length>0)
						Sys.stderr().writeString(line+"\n");
				}
            }
        if ( hasError ) {
			return 1;
		}
		
		log("Compile with success!");
		return 0;
	}
	
	public inline function log(msg:Dynamic) {
		#if debug
			trace(msg);
		//#else
			//Sys.println(msg);
		#end
	}

	public inline function error(msg:Dynamic) {
		Sys.stderr().writeString(msg + "\n");
	}
}