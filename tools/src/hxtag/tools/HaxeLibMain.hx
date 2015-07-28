//
// HxTag - Custom Elements for Haxe-JS
// https://github.com/porfirioribeiro/HxTag/blob/master/LICENSE

package hxtag.tools;

using StringTools;
/**
 * ...
 * @author Porfírio
 */
class HaxeLibMain
{

	public static function main()
	{
		var args = Sys.args();
		var libDir = Sys.getCwd();

		var hc = new HaxeCompiler();
		hc.runDir = args.pop();
		
		//var rundir = args.pop();

		//var address:String="";
		//var useServer = false;
//
		//var hxml = "build.hxml";
//
		//var hxArgs = [];
		var fArgs = [];
		var i = 0;
		while (i < args.length) {
			var arg = args[i];
			switch(arg) {
				case "-c":
					hc.useServer = true;
					i++;
				case "--connect":
					var address = args[i + 1];
					Sys.println("Connecting to Haxe server at adress: " + address);
					hc.connect(address);
					//hxArgs.push('--connect');
					//hxArgs.push(address);
					i += 2;
				case "-debug" | "debug":
					hc.mode = HaxeCompiler.Mode.Debug;
					//hxArgs.push("-debug");
					i++;
				case "-release" | "release":
					//hxArgs.push("-D");
					//hxArgs.push("release");
					hc.mode = HaxeCompiler.Mode.Release;
					i++;
				case "-hx-args":
					//hxArgs = hxArgs.concat(args.slice(i + 1));
					hc.addArgs(args.slice(i + 1));
					i = args.length;
				case a if (a!=null && a.endsWith(".hxml")):
					hc.hxml = a;
					//hxml = a;
					i++;
				case a:
					fArgs.push(a);
					i++;
			}
		}

		var fnArgs = fArgs.length > 0?'[\'' + fArgs.join('\',\'') + '\']':"[]";
		
		hc.addArg("--macro", 'hxtag.Builder.buildCmd($fnArgs)');

		//var runArgs = [
			//hxml/*, "-lib", "hxtag", "-D", "no-macro-cache", "--macro", 'hxtag.Builder.buildCmd($fnArgs)'*/
			////hxml, "-lib", "hxtag", "-D", "no-macro-cache", "--macro", 'hxtag.Builder.buildCmd($fnArgs)'
		//].concat(hxArgs);

		Sys.exit(hc.run());
		//Sys.setCwd(rundir);
		//Sys.exit(Sys.command("haxe", runArgs));
	}

}
