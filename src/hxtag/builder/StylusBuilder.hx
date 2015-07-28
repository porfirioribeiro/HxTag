//
// HxTag - Custom Elements for Haxe-JS
// https://github.com/porfirioribeiro/HxTag/blob/master/LICENSE

package hxtag.builder;
import hxtag.macro.Metas;
#if macro
import haxe.io.Eof;
import haxe.io.Path;
import haxe.macro.Context;
import hxtag.builder.BuildOptions;
import macrox.AType;
import sys.FileSystem;
import sys.io.File;
import sys.io.Process;


using macrox.Tools;
using hxtag.builder.DynTools;

class StylusBuilder implements BaseBuilder
{

	var options:BuildOptions;
	var cmds:CmdOption;
	var stylusFiles = [];

	public function new() {}

	/* INTERFACE hxtag.builder.BaseBuilder */

	public function start(options:BuildOptions):Void {
		this.options = options;
        if (options.stylus == null)
            Builder.die('Missing stylus object in hxtag.hxon');
        if (options.stylus.css == null && options.stylus.stylus == null)
            Builder.die('Error building task stylus, please define stylus or css file');

        //css and styl file

        if (options.stylus.stylus == null) {
            options.stylus.css = Builder.relPath(options.outDir, options.stylus.css);
            options.stylus.stylus = Path.withExtension(options.stylus.css, "styl");
            options.stylus.keepStylus = options.stylus.keepStylus._or(false);
        }else {
            options.stylus.stylus=Builder.relPath(options.outDir, options.stylus.stylus);
            options.stylus.noCompile = true;
            options.stylus.keepStylus = true;
        }

        options.stylus.out = Path.directory(options.stylus.stylus);

        var uses = ["nib"];

        cmds = if (options.stylus.cmd != null)
            options.stylus.cmd.split(" ");
        else [];

        //-u, --use <path>        Utilize the Stylus plugin at <path>
        if (options.stylus.uses!=null)
            uses = uses.concat(options.stylus.uses);
        for (u in uses)                             cmds.add("--use", u);
        //-U, --inline            Utilize image inlining via data URI support
        if (options.stylus.inlineImages._or(false)) cmds.add("--inline");
        //-w, --watch             Watch file(s) for changes and re-compile
        if (options.stylus.whatch._or(false))       cmds.add("--watch");
        //-o, --out <dir>         Output to <dir> when passing files
        cmds.add("--out", options.stylus.out);
        //-C, --css <src> [dest]  Convert CSS input to Stylus
        //-I, --include <path>    Add <path> to lookup paths
        if (options.stylus.includes != null && options.stylus.includes.length > 0)
            for (i in options.stylus.includes)      cmds.add("--include", i);
        //-c, --compress          Compress CSS output
        if (options.stylus.compress)                cmds.add("--compress");
        //-d, --compare           Display input along with output
        //-f, --firebug           Emits debug infos in the generated CSS that can be used by the FireStylus Firebug plugin
        if (options.stylus.firebug)                 cmds.add("--firebug");
        //-l, --line-numbers      Emits comments in the generated CSS indicating the corresponding Stylus line
        if (options.stylus.lineNumbers)             cmds.add("--line-numbers");
        //-m, --sourcemap         Generates a sourcemap in sourcemaps v3 format
        if (options.stylus.sourcemap || options.debug) cmds.add("--sourcemap");
        //--sourcemap-inline      Inlines sourcemap with full source text in base64 format
        if (options.stylus.sourcemapInline)         cmds.add("--sourcemap-inline");
        //--sourcemap-root <url>  "sourceRoot" property of the generated sourcemap
        if (options.stylus.sourcemapRoot != null)   cmds.add("--sourcemap-root", options.stylus.sourcemapRoot);
        //--sourcemap-base <path> Base <path> from which sourcemap and all sources are relative
        if (options.stylus.sourcemapBase != null)   cmds.add("--sourcemap-base", options.stylus.sourcemapBase);
        //-P, --prefix [prefix]   prefix all css classes
        if (options.stylus.prefix != null)          cmds.add("--prefix", options.stylus.prefix);
        //-p, --print             Print out the compiled CSS
        //--import <file>         Import stylus <file>
        if (options.stylus.imports != null && options.stylus.imports.length > 0)
            for (i in options.stylus.imports)       cmds.add("--import", i);
        //--include-css           Include regular CSS on @import
        //-D, --deps              Display dependencies of the compiled file
        //--disable-cache         Disable caching
        if (options.stylus.disableCache)            cmds.add("--sourcemap-inline");

	}

	public function shouldProcess() return true;

	public function processType(t:AType):Void {

		var c = t.getClass();
		var stylusMeta = Metas.Stylus.getAllExprFrom(c);
		//var stylusMeta = c.meta.getMeta(":stylus");
		if (stylusMeta == null)
			return;

		var basedir = Builder.getBaseDir(c);
		var stylusDir = Path.join([basedir,"stylus"]);

		if (stylusMeta.length > 0) {
			for (i in stylusMeta) {
				var file = Path.withExtension(i.getValue(), "styl");
				var paths = [basedir, stylusDir];
				var f = Builder.checkFile(file, paths, true);
				//Sys.println('Stylus: $file');
				if (f != null)
					stylusFiles.push(f);
				else
					Context.error('Stylus file: $file not found on $stylusDir, $basedir or absolute path!', c.pos);
			}
			return;
		}

		var tagMeta = Metas.Tag.getAllExprFrom(c);
		//var tagMeta = c.meta.getMeta(":tag");
		if (tagMeta != null && tagMeta.length == 1) {
			var file = Path.withExtension(tagMeta[0].getValue(), "styl");
			var fileOnStylusDir = Path.join([stylusDir, file]);
			if (FileSystem.exists(fileOnStylusDir)) {
				stylusFiles.push(fileOnStylusDir);
				//Sys.println('Tag: $fileOnStylusDir');
				return;
			}
		}
		var file = Path.join(c.pack.concat([c.name+".styl"])) ;
		var fileOnStylusDir = Path.join([stylusDir, file]);
		if (FileSystem.exists(fileOnStylusDir)) {
			//Sys.println('Class: $fileOnStylusDir');
			stylusFiles.push(fileOnStylusDir);
			return;
		}
		Context.error('Could not find a stylus file for this class', c.pos);
	}

	public function finish():Void
	{
		if (options.stylus.css !=null && FileSystem.exists(options.stylus.css))
			FileSystem.deleteFile(options.stylus.css);

		if (options.stylus.out!="" && !FileSystem.isDirectory(options.stylus.out))
			FileSystem.createDirectory(options.stylus.out);

		var sfile = File.write(options.stylus.stylus);

		if (options.stylus.files != null)
			for (f in options.stylus.files) {
				if (FileSystem.exists(f))
					stylusFiles.push(FileSystem.absolutePath(f));
				else
					Builder.die('Stylus file not found: $f');
			}
			//stylusFiles = stylusFiles.concat(options.stylus.files);

		for (f in stylusFiles) {
			sfile.writeString('@require "$f"\n');
			//trace(f);
		}
		sfile.close();

		if (!options.stylus.noCompile._or(false)) {
			var args = cmds.concat([options.stylus.stylus]);
			var exe = "stylus";
			if (Sys.systemName() == "Windows")
				exe+= ".cmd";
			var proc = new Process(exe, args);
			try {
				while (true) {
					Sys.sleep(0.01);
					neko.Lib.println(proc.stdout.readLine());
				}
			} catch (e:Eof) {}

			if (proc.exitCode()!=0)
				Context.fatalError('Stylus compiling error ' + proc.stderr.readAll(), Context.currentPos());
		}
		if (!options.stylus.keepStylus)
			FileSystem.deleteFile(options.stylus.stylus);
	}
	public function toString() return "[StylusBuilder]";
}
#end
