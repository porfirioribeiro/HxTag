//
// HxTag - Custom Elements for Haxe-JS
// https://github.com/porfirioribeiro/HxTag/blob/master/LICENSE

package hxtag.macro;

import haxe.macro.Expr;
import haxe.macro.Type;
import haxe.macro.TypeTools;
import haxe.macro.Context;
import hxtag.macro.AType;
using Lambda;

typedef Tools={};
typedef TExprTools = haxe.macro.ExprTools;
typedef TComplexTypeTools = haxe.macro.ComplexTypeTools;
typedef TMacroStringTools = haxe.macro.MacroStringTools;
typedef TTypedExprTools = haxe.macro.TypedExprTools;
typedef TPositionTools = haxe.macro.PositionTools;

class MyTypeTools {
    static public inline function type(t:AType):AType return t;    
    static public inline function follow(t:AType, ?once : Bool ) : AType return Context.follow(t, once);
    static public inline function unify(t1:AType, t2:AType):Bool return Context.unify(t1, t2);
    static public inline function nullable(t : AType) : AType return macro : Null<$t>;  
    static public inline function isNullable(t : AType) : Bool return t.toType().match(TType(_.get().name => "Null", _));
	static public inline function getClass(t : AType) : ClassType return TypeTools.getClass(t);
	static public inline function getEnum(t : AType) : EnumType return TypeTools.getEnum(t);
	static public inline function map(t:AType, f:Type -> Type) : AType return TypeTools.map(t, f);
	static public inline function getTypePath(t:AType):TypePath {
		return switch(t.toComplexType()) {
			case TPath(p): p;
			case _: null;
		}
	}
	static public inline function findField(t:AType,name:String, isStatic:Bool = false):Null<ClassField> 
        return TypeTools.findField(t, name, isStatic);
}

class ClassTypeTools {
	public static inline function type(ct:ClassType):AType
		return TPath({pack:ct.pack,name:ct.name});

	public static inline function unify(ct:ClassType,t:AType):Bool
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
	public static inline function type(e:Expr) : AType	
		return Context.typeof(e);
	
	public static inline function typeUnify(e:Expr, type:AType):Bool 
		return Context.unify(Context.typeof(e), type);
		
	public static inline function at(expr:ExprDef, pos:Position):Expr
		return { expr:expr, pos:pos };

	public static inline function typeExpr(e:Expr) : haxe.macro.Type.TypedExpr	
		return Context.typeExpr(e);	
        
    public static inline function isNull(e:Expr):Bool
        return e == null || e.expr.match(EConst(CIdent("null")));
    
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