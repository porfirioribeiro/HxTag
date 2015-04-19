package hxtag;

import hx.Icon;

/**
 * @author Porfirio
 */
@:remove
//@:keepInit
@:autoBuild(hxtag.macro.IconSetBuilder.autoBuild())
//@:build(hxtag.macro.IconSetBuilder.build())
interface IconSet {
	//static function __init__() :Void {
		//untyped __js__('var __iconSets = { }');
	//}
	
	public var iconSize:Int;

	/**
	 * Apply the icon of this IconSet in the target Icon
	 * @param	icon Target Icon element
	 * @param	name Name of the icon in this IconSet
	 */
	public function applyIcon(icon:Icon, name:String):Void;

}