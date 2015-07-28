//
// HxTag - Custom Elements for Haxe-JS
// https://github.com/porfirioribeiro/HxTag/blob/master/LICENSE

package hxtag.macro;

#if macro
import haxe.macro.Expr;
import haxe.macro.Type;
import haxe.extern.EitherType;
import haxe.macro.Context;
#end
@:enum
abstract Metas(String) to String {
	//class Metas
	var Tag = ":tag";
	var NoTag = ":noTag";
	var Stylus = ":stylus";
	var Res = ":res";
	//var Metas
	var Attribute = ":Attribute";
	//function Metas
	var Test = ":Test";
	
	#if macro
	public function check(metas:AMetadata) {
		for (m in metas) {
			if (m.name == this)
				return true;
		}
		return false;
	}
	public inline function existsOn(meta:AMetadata) return meta.hasMeta(this);	
	public inline function getFrom(meta:AMetadata, def:Array<Expr> = null) 	return meta.getMeta(this, def);
	
	public function addToType(type:BaseType, params : Array<Expr> = null, pos : Position = null) {
		if (params == null) params = [];
		if (pos == null) pos = Context.currentPos();
		type.meta.add(this, params, pos);
	}
	#end
}
#if macro
@:forward
abstract AMetadata(Metadata) from Metadata to Metadata{
	@:from static function fromMetaAccess(metaAccess:MetaAccess) return cast metaAccess.get();	
	@:from static function fromBaseType(baseType:BaseType) return cast baseType.meta.get();	
	@:from static function fromField(field:Field) return cast field.meta;
	
	public function hasMeta(name):Bool {
		if (this==null) return false;
		for (meta in this) 
			if (meta.name == name) 
				return true;	
		return false;
	}	
	public function removeMeta(name) {
		if (this==null) return;
		for (meta in this) 
			if (meta.name == name) 
				this.remove(meta);			
	}
	public function getMeta(name, def:Array<Expr>=null):Array<Expr> {
		if (this==null) return def;
		for (meta in this) 
			if (meta.name == name) 
				return meta.params;	
		return def;
	}
	public function getFirst(name, def:Expr=null):Expr{
		var m=getMeta(name);
		if (m!=null && m.length>0)
			return m[0];
		else 
			return def;
	}
}
#end

typedef AttributeDef = {
	name:String
}