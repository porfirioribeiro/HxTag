//
// HxTag - Custom Elements for Haxe-JS
// https://github.com/porfirioribeiro/HxTag/blob/master/LICENSE

package hxtag.macro;

import haxe.macro.Expr;
import haxe.macro.Context;
import haxe.macro.Type;
import haxe.macro.TypeTools;

/**
 * ...
 * @author Porfirio
 */
abstract Type(haxe.macro.Type) from haxe.macro.Type to haxe.macro.Type {
	@:from public static inline function fromComplex(ct:ComplexType) : Type
		return haxe.macro.ComplexTypeTools.toType(ct);
		
	@:to public inline function toComplexType() : ComplexType
		return Context.toComplexType(this);
		
	@:to public inline function toString() : String 
		return TypeTools.toString(this);
		
	@:to public inline function getClass() : ClassType
		return TypeTools.getClass(this);

	@:to public inline function getEnum() : EnumType
		return TypeTools.getEnum(this);

	public inline function applyTypeParameters(typeParameters:Array<TypeParameter>, concreteTypes:Array<Type>):Type
		return TypeTools.applyTypeParameters(this,typeParameters,concreteTypes);

	public inline function map(f:Type -> Type) : Type 
		return TypeTools.map(this,f);

	public inline function follow(?once : Bool ) : Type
		return Context.follow(this, once);
		
	public inline function unify( type:Type ) : Bool
		return Context.unify(this, type);
		
	public inline function findField(name:String, isStatic:Bool = false):Null<ClassField> 
		return TypeTools.findField(getClass(), name, isStatic);
}