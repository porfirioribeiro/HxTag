//
// HxTag - Custom Elements for Haxe-JS
// https://github.com/porfirioribeiro/HxTag/blob/master/LICENSE

package hxtag.builder;

import haxe.io.Path;
import haxe.macro.Context;
import hxtag.Builder;
import hxtag.builder.BuildOptions;
import hxtag.macro.AType;

using hxtag.macro.Tools;


typedef ResDef = {
	?copyFile:String,
	?copyDir:String,
	?copyFiles:Array<String>,
	?copyDirs:Array<String>,
	?to:String
}


class ResBuilder implements BaseBuilder
{
	var options:BuildOptions;
	var resources:Array<ResDef>;

	public function new() {

	}

	/* INTERFACE hxtag.builder.BaseBuilder */

	public function start(options:BuildOptions) {
		this.options = options;
		this.resources = [];
	}

	public function shouldProcess() return true;

	public function processType(t:AType) {
                var c = t.getClass();
                var resMetas = c.meta.getMeta(":res");
                if (resMetas == null)
                    return;

                var basedir = Builder.getBaseDir(c);
                var resDir = Path.join([basedir,"res"]);


                if (resMetas.length > 0) {
                    for (resMeta in resMetas) {
						var r:ResDef;
						if (resMeta.typeUnify(macro : String))
							r = { copyFiles: [resMeta.getValue()] }
						else if (resMeta.typeUnify(macro : hxtag.builder.ResBuilder.ResDef))
							r = resMeta.getValue();
						else
							Context.error("Malformed resource declaration", resMeta.pos);


						// if (r.copyFile != null)
						// 	if (r.copyFiles == null)
						// 		r.copyFiles = [r.copyFile];
						// 	else
						// 		r.copyFiles.push(r.copyFile);
						// if (r.copyDir != null)
						// 	if (r.copyDirs == null)
						// 		r.copyDirs = [r.copyDir];
						// 	else
						// 		r.copyDirs.push(r.copyDir);

						resources.push(r);
                    }
                }

	}

	public function finish() {
		for (r in resources) {
			if (r.to==null)
				r.to=options.res.out;
			trace(r.to);
			// for (i in 0...r.copyFiles.length)
			// 	trace(r.copyFiles[i]);
		}
	}

	public function toString() return "[ResBuilder]";

}
