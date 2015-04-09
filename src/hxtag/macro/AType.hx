//
// HxTag - Custom Elements for Haxe-JS
// https://github.com/porfirioribeiro/HxTag/blob/master/LICENSE

package hxtag.macro;

import haxe.extern.EitherType;
import haxe.macro.Expr;
import haxe.macro.Type;
import haxe.macro.TypeTools;
import haxe.macro.ComplexTypeTools;
import hxtag.macro.Tools;


private typedef TEType = EitherType<Type,ComplexType>;

abstract AType(TEType) from TEType {
    @:to public inline function toType():Type 
        return if (Std.is(this, Type)) this; else ComplexTypeTools.toType(this);
    @:to public inline function toComplexType():ComplexType 
        return if (Std.is(this, ComplexType)) this; else TypeTools.toComplexType(this);
    @:to public inline function toString():String 
        return if (Std.is(this, Type)) TypeTools.toString(this) else if (Std.is(this, ComplexType)) ComplexTypeTools.toString(this) else "null";
	@:to public inline function getClass() : ClassType return MyTypeTools.getClass(this);
	@:to public inline function getEnum() : EnumType return MyTypeTools.getEnum(this);
	public inline function map(f:Type -> Type) : AType  return MyTypeTools.map(this, f);
    public inline function follow( ?once : Bool ) : AType return MyTypeTools.follow(this, once);
    public inline function unify( t:AType ) : Bool return MyTypeTools.unify(this, t);
    public inline function nullable() : AType return MyTypeTools.nullable(this);
    public inline function isNullable() : Bool return MyTypeTools.isNullable(this);
    @:to public inline function getTypePath() : TypePath return MyTypeTools.getTypePath(this);
	public inline function findField(name:String, isStatic:Bool = false):Null<ClassField> return MyTypeTools.findField(this, name, isStatic);
}