//
// HxTag - Custom Elements for Haxe-JS
// https://github.com/porfirioribeiro/HxTag/blob/master/LICENSE

package hxtag;
import hxtag.builder.BaseBuilder;
import hxtag.builder.ResBuilder;
import hxtag.builder.StylusBuilder;




#if macro
import haxe.io.Eof;
import haxe.macro.Compiler;
import hxtag.macro.Hxon;
import sys.io.File;
import sys.io.Process;
using StringTools;
using Lambda;
import haxe.macro.Expr;
import haxe.macro.Context;
import haxe.macro.Type;
using hxtag.macro.Tools;

import sys.FileSystem;
import haxe.io.Path;
import hxtag.builder.BuildOptions;
using hxtag.builder.DynTools;
#end




#if macro
/**
 * ...
 * @author Porfírio
 */
class Builder
{
    static inline var FILE = "hxtag.hxon";

    public static inline function die(error:String) {
        //Context.error(error,Context.makePosition( { min: 0, max: 0, file: FILE } ));
        Sys.println(error);
        Sys.exit(1);
    }
	public static inline function out(msg:String) {
		Sys.println(' > $msg');
	}
    public static function getBaseDir(c:ClassType):String {
        var p = Path.directory(FileSystem.fullPath(c.pos.getInfos().file));
        return p.substring(0, p.lastIndexOf(Path.join(c.pack)) - 4);
    }

    static var relExp = ~/^(\.{0,2}\/|\w:)/;
    public static function relPath(outDir:String, path:String) {
        return if (!relExp.match(path))
            Path.join([outDir, path]);
        else
            Path.normalize(path);
    }

    public static function checkFile(file:String, paths:Array<String> = null, global = true):Null<String> {
		if (global || paths == null) //Global file exists
			if (FileSystem.exists(file))
				return file;
		for (p in paths) {
			var f = Path.join([p, file]);
			if (FileSystem.exists(f))
				return f;
		}
		//trace("not found");
		return null;
	}


	static var TARGET = "hxtag_target";

	static var targets:Array<String> = [];
	static var builders:Array<BaseBuilder> = [];
	
	static var buildCalled = false;
	
	public static function buildCmd(args:Array<String> = null) {
		if (args != null)
			targets=targets.concat(args);
	}

	

    public static function build() {
		if (Context.defined("display"))
			return;
		out('HxTag: Start Building');
        if (!FileSystem.exists(FILE)) {
            die('File "$FILE" not found in project root');
        }
        var options:BuildOptions;
        try{
            options = Hxon.parseFile(FILE, macro : hxtag.builder.BuildOptions);
        } catch (e:Error) {
            Sys.println('Error parsing $FILE, see errors bellow');
            throw e;
        }
        if (options.outDir == null)
			options.outDir = "bin";


        FileSystem.createDirectory(options.outDir);

		if (Context.defined("debug"))
			options.debug = true;

			
		var t = Context.definedValue(TARGET);
		if (t != null) {
			targets=targets.concat(t.split(';'));
		}
		
		for (i in 0...targets.length) {
			var arg = targets[i];
			switch (arg) {
				case "stylus":
					builders.push(new StylusBuilder());
				case "res":
					builders.push(new ResBuilder());
				case "all":
					builders.push(new StylusBuilder());
					builders.push(new ResBuilder());
					break;
				case "none":
					builders = [];
					break;
				case x:
					Sys.println('Argument $x not valid');
					Sys.exit(1);
			}
		}





		var shouldProcess = builders.fold(function (b,should) {return should || b.shouldProcess();} , false);

		for (b in builders) {
			out('Starting $b');
			b.start(options);
		}

		if (shouldProcess) {
			Context.onGenerate(function(types) {
				//trace("onGenerate: stylus");
				for (_t in types) {
					var t = _t.type();
					if (!t.unify(macro : hxtag.Res))
						continue;
					out('Processing $t');
					for (b in builders)
						b.processType(t);
				}
				finish(builders);
			});
		}else
			finish(builders);



    }

	static function finish(builders:Array<BaseBuilder>) {
		for (b in builders) {
			out('Finishing $b');
			b.finish();
		}
		out('All done');
	}

}

#end
