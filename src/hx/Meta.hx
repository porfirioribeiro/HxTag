package hx;

import hxtag.Tag;
import hxtag.Dom;
using hxtag.DomTools;


class Meta extends Tag {
	@:Attribute	public var type:String;	
	@:Attribute	public var label:String;
	
	public function createdCallback() {
		this.querySelectorAll("hx-meta-item");
	}	
}