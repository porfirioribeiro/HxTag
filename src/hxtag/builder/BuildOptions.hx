//
// HxTag - Custom Elements for Haxe-JS
// https://github.com/porfirioribeiro/HxTag/blob/master/LICENSE

package hxtag.builder;

/**
 * @author Porfírio
 */

typedef Stylus = {
    ?cmd:String,
	?files:Array<String>,
    ?stylus:String,
    ?noCompile:Bool,
    ?keepStylus:Bool,

    //-u, --use <path>        Utilize the Stylus plugin at <path>
    ?uses:Array<String>,
    //-U, --inline            Utilize image inlining via data URI support
    ?inlineImages:Bool,
    //-w, --watch             Watch file(s) for changes and re-compile
    ?whatch:Bool,
    //-o, --out <dir>         Output to <dir> when passing files
    ?out:String,
    //-C, --css <src> [dest]  Convert CSS input to Stylus
    ?css:String,
    //-I, --include <path>    Add <path> to lookup paths
    ?includes:Array<String>,
    //-c, --compress          Compress CSS output
    ?compress:Bool,
    //-d, --compare           Display input along with output
    //-f, --firebug           Emits debug infos in the generated CSS that can be used by the FireStylus Firebug plugin
    ?firebug:Bool,
    //-l, --line-numbers      Emits comments in the generated CSS indicating the corresponding Stylus line
    ?lineNumbers:Bool,
    //-m, --sourcemap         Generates a sourcemap in sourcemaps v3 format
    ?sourcemap:Bool,
    //--sourcemap-inline      Inlines sourcemap with full source text in base64 format
    ?sourcemapInline:Bool,
    //--sourcemap-root <url>  "sourceRoot" property of the generated sourcemap
    ?sourcemapRoot:String,
    //--sourcemap-base <path> Base <path> from which sourcemap and all sources are relative
    ?sourcemapBase:String,
    //-P, --prefix [prefix]   prefix all css classes
    //-p, --print             Print out the compiled CSS
    ?prefix:String,
    //--import <file>         Import stylus <file>
    ?imports:Array<String>,
    //--include-css           Include regular CSS on @import
    //-D, --deps              Display dependencies of the compiled file
    //--disable-cache         Disable caching
    ?disableCache:Bool
}

typedef Resources = {
    ?out:String
}

typedef BuildOptions = {
    ?outDir:String,
	//?js:String,
	?debug:Bool,
	//?dce:String,
	//?main:String,
    //?imports:Array<String>,
    //?cp:Array<String>,
    //?libs:Array<String>,
	//?defines:Array<String>,
	?stylus:Stylus,
    ?res:Resources
    //dependencies:Array<Dependency>

}
