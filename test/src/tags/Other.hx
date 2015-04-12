package tags;

using hxtag.DomTools;
import hxtag.Dom.*;
import hxtag.Tag;

@:stylus
@:res("img/ic_attachment_24px.svg")
// @:res("ic_attachment_24px.svg","Other.hxs",{copyFile:"file.ext",copyFiles:["one","two"],to:"otherdir"})

@:htmlImport("bin/img/ic_attachment_24px.svg")
class Other extends Tag {

	public function createdCallback() {
        //this.innerHTML = "Other Tag";

    }

}
