//
// HxTag - Custom Elements for Haxe-JS
// https://github.com/porfirioribeiro/HxTag/blob/master/LICENSE

package hxtag.macro;
import haxe.macro.Expr;
// import haxe.macro.Type;
import haxe.macro.Context;
import haxe.macro.Type.ClassType;
using Lambda;
/**
 * @author Porfirio
 */
typedef Tools={};
typedef TExprTools = haxe.macro.ExprTools;
typedef TComplexTypeTools = haxe.macro.ComplexTypeTools;
// typedef TTypeTools = TypeTools;
typedef TMacroStringTools = haxe.macro.MacroStringTools;
typedef TTypedExprTools = haxe.macro.TypedExprTools;
typedef TPositionTools = haxe.macro.PositionTools;


class TypeTools {
	public static inline function type(t:haxe.macro.Type) : Type
		return t;
}

class ComplexTypeTools {
	public static inline function type(t:ComplexType) : Type
		return t;	
	public static inline function unify(ct:ComplexType,t:Type):Bool
		return type(ct).unify(t);
	
	public static function getTypePath(t:ComplexType):TypePath {
		return switch(t) {
			case TPath(p): p;
			case _: null;
		}
	}
}

class ClassTypeTools {
	public static inline function type(ct:ClassType):Type
		return TPath({pack:ct.pack,name:ct.name});

	public static inline function unify(ct:ClassType,t:Type):Bool
		return type(ct).unify(t);
	
		
	public static function hasInterface(ct:ClassType, intf:String) :Bool{
		for (i in ct.interfaces) 
			if (i.t.toString() == intf)
				return true;
		if (ct.superClass != null) 
			if (hasInterface(ct.superClass.t.get(),intf))
				return true;
		return false;
	}
	public static function toString(ct:ClassType):String{
		return ct.pack.concat([ct.name]).join('.');
	}
}

class ExprTools {
	public static inline function type(e:Expr) : Type	
		return Context.typeof(e);
	
	public static inline function typeUnify(e:Expr, type:Type):Bool 
		return Context.unify(Context.typeof(e), type);
		
	public static inline function at(expr:ExprDef, pos:Position):Expr
		return { expr:expr, pos:pos };

	public static inline function typeExpr(e:Expr) : haxe.macro.Type.TypedExpr	
		return Context.typeExpr(e);	
}

class MetaDataTools{
	public static function add(metas:Metadata, name : String, params : Array<Expr>, pos : Position ) : Void{
		metas.push({name:name,params:params,pos:pos});
	}
	public static function hasMeta(metas:Metadata, name):Bool {
		if (metas==null) return false;
		for (meta in metas) 
			if (meta.name == name) 
				return true;	
		return false;
	}	
	public static function removeMeta(metas:Metadata, name) {
		if (metas==null) return;
		for (meta in metas) 
			if (meta.name == name) 
				metas.remove(meta);			
	}
	public static function getMeta(metas:Metadata, name, def:Array<Expr>=null):Array<Expr> {
		if (metas==null) return def;
		for (meta in metas) 
			if (meta.name == name) 
				return meta.params;	
		return def;
	}
	public static function getFirst(metas:Metadata, name, def:Expr=null):Expr{
		var m=getMeta(metas,name);
		if (m!=null && m.length>0)
			return m[0];
		else 
			return def;
	}
}
class MetaAccessTools{
	public static function hasMeta(metas:haxe.macro.Type.MetaAccess, name):Bool 
		return metas.has(name);	
	
	public static function removeMeta(metas:haxe.macro.Type.MetaAccess, name) 
		return metas.remove(name);
	
	public static function getMeta(metas:haxe.macro.Type.MetaAccess, name, def:Array<Expr>=null):Array<Expr>
		return MetaDataTools.getMeta(metas.get(),name,def);	
	
	public static function getFirst(metas:haxe.macro.Type.MetaAccess, name, def:Expr=null):Expr
		return MetaDataTools.getFirst(metas.get(),name,def);
	
}