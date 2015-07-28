//
// HxTag - Custom Elements for Haxe-JS
// https://github.com/porfirioribeiro/HxTag/blob/master/LICENSE

package hxtag.builder;
import macrox.AType;


/**
 * ...
 * @author ...
 */
interface BaseBuilder {
	function start(options:BuildOptions):Void;
	function shouldProcess():Bool;
	function processType(t:AType):Void;
	function finish():Void;
	function toString():String;
}
