package hxtag.tools;
import sys.io.Process;

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
		args.unshift(libDir + "tools/bin/tools.js");
		Sys.setCwd(rundir);
		
		Sys.exit(Sys.command("node",args));
		//var node = new Process("node", args);
		//neko.Lib.print(node.stdout.readAll().toString());
		//neko.Lib.print(node.stderr.readAll().toString());
		//Sys.exit(node.exitCode());
	}
	
}