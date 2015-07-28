//
// HxTag - Custom Elements for Haxe-JS
// https://github.com/porfirioribeiro/HxTag/blob/master/LICENSE

package hxtag.builder;
import hxtag.macro.Metas;
#if macro
import haxe.io.Path;
import sys.io.File;
import sys.FileSystem;
import haxe.macro.Context;
import hxtag.Builder;
import hxtag.builder.BuildOptions;
import macrox.AType;
using macrox.Tools;

#end
typedef ResDef = {
	?copyFile:String,
	?copyDir:String,
	?copyFiles:Array<String>,
	?copyDirs:Array<String>,
	?to:String
}
typedef FileCopyInfo = {
	from:String,
	to:String
}
#if macro

class ResBuilder implements BaseBuilder
{
	var options:BuildOptions;
	// var resources:Array<ResDef>;
	var filesToCopy:Array<FileCopyInfo>;

	public function new() {

	}

	/* INTERFACE hxtag.builder.BaseBuilder */

	public function start(options:BuildOptions) {
		this.options = options;
		this.filesToCopy = [];
		if (options.res==null)
			options.res={out:options.outDir};
		else if (options.res.out==null)
			options.res.out=options.outDir;
		else
			options.res.out=Path.join([options.outDir,options.res.out]);
	}

	public function shouldProcess() return true;

	public function processType(t:AType) {
                var c = t.getClass();
                var resMetas = Metas.Res.getAllExprFrom(c);
                //var resMetas = c.meta.getMeta(":res");
                if (resMetas == null)
                    return;

                var basedir = Builder.getBaseDir(c);
                var resDir = Path.join([basedir,"res"]);
				var packDir = Path.directory(FileSystem.fullPath(c.pos.getInfos().file));
				c.pack.unshift(resDir);
				var packOnResDir=Path.join(c.pack);
				var paths= [basedir, resDir, packDir, packOnResDir];

                if (resMetas.length > 0) {
                    for (resMeta in resMetas) {
						var r:ResDef;
						if (resMeta.typeUnify(macro : String))
							r = { copyFiles: [resMeta.getValue()] }
						else if (resMeta.typeUnify(macro : hxtag.builder.ResBuilder.ResDef))
							r = resMeta.getValue();
						else
							Context.error("Malformed resource declaration", resMeta.pos);

						r.to= (r.to==null) ? options.res.out : Path.join([options.res.out,r.to]);

						if (r.copyFile != null)
							if (r.copyFiles == null) r.copyFiles = [r.copyFile];
							else					 r.copyFiles.push(r.copyFile);
						for (file in r.copyFiles){
							var from = Builder.checkFile(file, paths, true);
							if (from==null)
								Builder.die('Could not find the file $file on paths: $paths');
							var to=Path.join([r.to,file]);
							// trace('from $from to $to');
							filesToCopy.push({from:from,to:to});
						}
						if (r.copyDir != null)
							if (r.copyDirs == null)	 r.copyDirs = [r.copyDir];
							else    				 r.copyDirs.push(r.copyDir);

						// resources.push(r);
                    }
                }

	}

	public function finish() {
		for (fi in filesToCopy){
			//trace('Copying file ${fi.from} to ${fi.to}');
			File.copy(fi.from,fi.to);
		}
	}

	public function toString() return "[ResBuilder]";

}
#end
