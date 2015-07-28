package demos.attributes;


//Tags
//import hx.Btn;
//import hx.Menu;
import demos.attributes.MyTag;

@:build(demos.attributes.Macros.test())
@:stylus
class Main 
{
	@:Attribute
	public var test:String;
	
	static function main() {

	}
	
}