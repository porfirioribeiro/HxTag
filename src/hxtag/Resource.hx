//
// HxTag - Custom Elements for Haxe-JS
// https://github.com/porfirioribeiro/HxTag/blob/master/LICENSE

package hxtag;

/**
 * ...
 * @author Porfírio
 */
class Resource
{

    public static function importHtml(href:String) {
        var link = Dom.document.createLinkElement();
        link.rel = "import";
        link.href = href;
        Dom.document.head.appendChild(link);
        return link;
    }

}
