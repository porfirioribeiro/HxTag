//
// HxTag - Custom Elements for Haxe-JS
// https://github.com/porfirioribeiro/HxTag/blob/master/LICENSE

package hxtag.test;

using hxtag.DomTools;
import hxtag.Dom.*;
import hxtag.Resource;
import js.html.LinkElement;

@:tag("my-tag")
@:stylus
class MyTag extends hxtag.Tag {

	public function createdCallback(){
        this.innerHTML = "My Tag";
        var si = imports[0];
        var doc:js.html.Document = untyped si['import'];
        document.body.appendChild(doc.querySelector("svg").cloneNode(true));
        trace(doc.querySelector("#attachment"));
    }
    @:keep
    static var imports:Array<LinkElement>=[Resource.importHtml("../res/ic_attachment_24px.svg")];
    static function __init__() {
        //imports=[Resource.importHtml("../res/ic_attachment_24px.svg")];
    }
}
