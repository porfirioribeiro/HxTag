//
// HxTag - Custom Elements for Haxe-JS
// https://github.com/porfirioribeiro/HxTag/blob/master/LICENSE

package hxtag.dom;

import js.html.EventTarget;
import js.html.Node;
import js.html.Element;
typedef HElement=js.html.Element;

/**
 * ...
 * @author Porfirio
 */
@:forward
abstract Element(ElementOf<js.html.Element>){
	@:from static public inline function fromNode(node:Node): Element
		return cast node;

	@:to public inline function toNode():Node
		return cast this;
}
@:forward
abstract ElementOf<T:js.html.Element>(T) from T to T{
	@:from static public inline function fromNode(node:Node): Element
		return cast node;

	@:to public inline function toNode():Node
		return cast this;
}