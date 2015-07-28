//
// HxTag - Custom Elements for Haxe-JS
// https://github.com/porfirioribeiro/HxTag/blob/master/LICENSE

package hxtag.macro;

#if (macro || display)

@:enum @:forward
abstract Metas(macrox.Metas) to macrox.Metas{
	//class Metas
	var Tag = ":tag";
	var NoTag = ":noTag";
	var Stylus = ":stylus";
	var Res = ":res";
	//var Metas
	var Attribute = ":Attribute";
	//function Metas
	var Test = ":Test";
}
#end