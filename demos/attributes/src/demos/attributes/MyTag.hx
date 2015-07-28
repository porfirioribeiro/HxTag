package demos.attributes;

import hxtag.Tag;
import hxtag.tools.JS;
import js.html.CustomEvent;

/**
 * ...
 * @author Porfirio
 */

@:tag("my-tag")
class MyTag extends Tag {
	@:Attribute
	public var done:String;
	
	public function createdCallback() {
		innerHTML = "My Tag";
		addEventListener('done:changed', doneChanged);
		done = "ok";
		//trace("created");
	}
	
	@:observe(done,df)
	function doneChanged() {
		trace("done:changed");
	}
	
	@:on(click)
	function onClick() {
		
	}
	
	public function attributeChangedCallback(name:String, old:String, value:String) {
		
		//dispatchEvent(new js.html.CustomEvent(name+':changed',{ detail:{oldValue:o,newValue:n }} ));
		//dispatchEvent(untyped __new__("CustomEvent",'$name:changed',{ detail:{oldValue:o,newValue:n }} ));
		trace('changed $name');
	}
}