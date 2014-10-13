package hx;

import hxtag.Tag;

/**
 * ...
 * @author ...
 */
class Icon extends Tag
{
	@:Attribute public var src:String;
	@:Attribute public var icon:String;

	public function createdCallback() 
	{
		if (this.hasAttribute("src"))
			_setSrc(src);		
	}
	
	function attributeChangedCallback(attrName:String, oldVal:String, newVal:String){
		switch (attrName) {
			case "src": _setSrc(newVal);
		}
	}
	
	function _setSrc(src:String) {
		trace('icon: set src to: $src');
		this.textContent = '';
		this.setAttribute('fit', '');
		trace(this.style);
		this.style.backgroundImage = 'url(' + this.src + ')';
		this.style.backgroundPosition = 'center';
		this.style.backgroundSize = '100%';
		trace(this);
	}
}