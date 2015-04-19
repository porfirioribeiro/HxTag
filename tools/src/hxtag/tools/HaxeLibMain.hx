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

		var rundir = args.pop();

		var address:String="";
		var useServer = false;

		var hxml = "build.hxml";

		var hxArgs = [];
		var fArgs = [];
		var i = 0;
		while (i < args.length) {
			var arg = args[i];
			switch(arg) {
				case "--connect":
					address = args[i + 1];
					Sys.println("Connecting to Haxe server at adress: "+address);
					hxArgs.push('--connect');
					hxArgs.push(address);
					i += 2;
				case "-debug" | "debug":
					hxArgs.push("-debug");
					i++;
				case "-release" | "release":
					hxArgs.push("-D");
					hxArgs.push("release");
					i++;
				case "-hx-args":
					hxArgs = hxArgs.concat(args.slice(i + 1));
					i = args.length;
				case a if (a!=null && a.endsWith(".hxml")):
					hxml = a;
					i++;
				case a:
					trace("push ", a);
					fArgs.push(a);
					i++;
			}
		}

		var fnArgs = fArgs.length > 0?'[\'' + fArgs.join('\',\'') + '\']':"[]";
		trace(fnArgs);

		var runArgs = [
			hxml, "-lib", "hxtag", "-D", "no-macro-cache", "--macro", 'hxtag.Builder.buildCmd($fnArgs)'
		].concat(hxArgs);

		Sys.setCwd(rundir);
		Sys.exit(Sys.command("haxe", runArgs));
	}

}
