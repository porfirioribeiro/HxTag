package tags;

using hxtag.DomTools;
import hxtag.Dom.*;
import hxtag.Tag;

@:stylus
@:res("ic_attachment_24px.svg","otherFile.ext",{copyFile:"file.ext",copyFiles:["one","two"]})

@:htmlImport("res/ic_attachment_24px.svg")
class Other extends Tag {
	
	public function createdCallback() {
        //this.innerHTML = "Other Tag";
        
    }

}
