//
// HxTag - Custom Elements for Haxe-JS
// https://github.com/porfirioribeiro/HxTag/blob/master/LICENSE

package hxtag.builder;

@:forward
abstract CmdOption(Array<String>) from Array<String> to Array<String> {
    public inline function add(opt:String, value:String=null) {
        this.push(opt);
        if (value!=null)
            this.push(value);
    }
}
