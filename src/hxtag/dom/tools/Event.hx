//
// HxTag - Custom Elements for Haxe-JS
// https://github.com/porfirioribeiro/HxTag/blob/master/LICENSE

package hxtag.dom.tools;

// typedef TConnection={e:hxtag.dom.Element,eventType:String,eventListener:js.html.EventListener};

// abstract Connection(TConnection) from TConnection{
// 	public inline function connect(){
// 		this.e._.addEventListener(this.eventType,this.eventListener);
// 	}
// 	public inline function disconnect(){
// 		this.e._.removeEventListener(this.eventType,this.eventListener);
// 	}
// }

using hxtag.DomTools;
import hxtag.tools.StringTools;
import hxtag.Dom;
import js.html.Element;


typedef TLiveCon={selector:String,eventType:String,eventListener:js.html.EventListener};

abstract LiveCon(TLiveCon) from TLiveCon to TLiveCon{
	public inline function die()
		Event.removeLiveEvent(this.selector,this.eventType,this.eventListener);
}


class Event{
	function new(){
		
	}

	public static inline function on(e:js.html.EventTarget,eventType:String,eventListener:js.html.EventListener):Void
		e.addEventListener(eventType,eventListener);

	public static inline function off(e:js.html.EventTarget,eventType:String,eventListener:js.html.EventListener):Void
		e.removeEventListener(eventType,eventListener);
	
	public static function one(e:js.html.EventTarget,eventType:String,eventListener:js.html.EventListener):haxe.Constraints.Function{
		var fn=null;
		fn=function (event){
			eventListener(event);
			e.off(eventType,fn);
		}
		e.on(eventType,fn);
		return fn;
	}

	public static inline function fireCustomEvent(e:js.html.EventTarget, eventType:String, detail:Dynamic=null) {
		e.dispatchEvent(untyped __new__("CustomEvent",eventType,{ detail:detail } ));
	}
	
	public static inline function live(selector:String,eventType:String,eventListener:js.html.EventListener):LiveCon{
		return addLiveEvent(selector,eventType,eventListener);
	}

	public static inline function die(selector:String,eventType:String,eventListener:js.html.EventListener):Void{
		removeLiveEvent(selector,eventType,eventListener);
	}
	
	

// Live Events	
	static var registedLiveEvents:Array<String>=[];
	static var liveEvents:Map<String,Array<TLiveCon>>=new Map();

	public static function handleLiveEvent(event:js.html.Event):Void{
		var evt=liveEvents[event.type];
		if (evt!=null){
			for (evs in evt){
				if (cast(event.target,Element).matches(evs.selector))
					evs.eventListener(event);
			}
		}
	}

	public static function addLiveEvent(selector:String,eventType:String,eventListener:js.html.EventListener):LiveCon{
		if (untyped registedLiveEvents.indexOf(eventType)==-1){
			Dom.document.on(eventType,Event.handleLiveEvent);
			registedLiveEvents.push(eventType);
		}
		if (liveEvents[eventType]==null)
			liveEvents[eventType]=[];
		var con:LiveCon={selector:selector,eventType:eventType,eventListener:eventListener};
		liveEvents[eventType].push(con);
		return con;
	}

	public static function removeLiveEvent(selector:String,eventType:String,eventListener:js.html.EventListener):Void{
		if (untyped registedLiveEvents.indexOf(eventType)==-1 || liveEvents[eventType]==null)
			return;
		for (evo in liveEvents[eventType])
			if (evo.selector==selector && evo.eventListener==eventListener)
				liveEvents[eventType].remove(evo);
		if (liveEvents[eventType].length==0){
			Dom.document.off(eventType,Event.handleLiveEvent);
			registedLiveEvents.remove(eventType);
		}
	}

}