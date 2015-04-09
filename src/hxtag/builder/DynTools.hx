//
// HxTag - Custom Elements for Haxe-JS
// https://github.com/porfirioribeiro/HxTag/blob/master/LICENSE

package hxtag.builder;

class DynTools {
    public static inline function _or<T>(b:T, def:T): T return (b == null) ? def : b;
}
