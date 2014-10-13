package hxtag.tools;
import js.node.Console;
import js.node.Fs;
import js.node.NodeJS;



/**
 * ...
 * @author Porfírio
 */

class Main 
{
	static var commands = [
		"stylus"=>buildStylus
	];
	static var command:Void->Void=null;
	static function main() 
	{
		if (!Fs.existsSync("hxtag.json")) {
			NodeJS.console.error("Missing file hxtag.json on current directory!");
			NodeJS.process.exit(1);
		}
			
		var args = NodeJS.process.argv.slice(2);
		
		while (args.length>0)	{
			var arg = args.shift();
			switch (arg) {
				case "--help" | "-h":
					trace("Help");
				case c if (commands.exists(c)):
					command=commands[c];
				default:
					
			}
		}

		if (command!=null)
			command();
	}
	
	static function buildStylus() {
		var stylus = NodeJS.require("stylus");
		trace("stylus command");
	}
}