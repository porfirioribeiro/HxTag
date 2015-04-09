//
// HxTag - Custom Elements for Haxe-JS
// https://github.com/porfirioribeiro/HxTag/blob/master/LICENSE

package hx;

import hxtag.Tag;
import hxtag.Dom;
import hxtag.tools.Log;
using hxtag.DomTools;


class Meta extends Tag {
	//                      type       id
	static var metaData:Map<String,Map<String,Meta>> = new Map();

	public static function byId(type:String, id:String) {
		if (!metaData.exists(type))
			return null;
		return metaData[type][id];
	}

	public static function list(type:String = "default") {
		if (!metaData.exists(type))
			return null;
		var meta = metaData[type];

		return [for (i in meta) i];
	}

	@:Attribute	public var type:String; //="default";

	public function createdCallback() {
		var _type = type;
		if (_type == null) {
			_type = "default";
			type = _type;
		}

		if (!metaData.exists(_type))
			metaData.set(_type, new Map());

		var meta = metaData.get(_type);

		if (id == "") id = "id_" + Math.round((Math.random()*Math.random()*1000));

		meta.set(id, this);
	}
}
