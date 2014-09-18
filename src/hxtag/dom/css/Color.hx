//
// HxTag - Custom Elements for Haxe-JS
// https://github.com/porfirioribeiro/HxTag/blob/master/LICENSE
package hxtag.dom.css;


using hxtag.tools.StringTools;

class ColorTools {
	public static function parseRGBA(rgbStr:String):RGBA{
		var rgba:RGBA={r:0,g:0,b:0,a:0};
		var match:Array<String> = rgbStr.matchRE(~/^(rgb|rgba)\((\d{1,3}),\s*(\d{1,3}),\s*(\d{1,3})(?:,\s*([0-1]{1}\.?[0-9]{1,2}))?\)$/i);
		if (match != null) {
			rgba.r = match[2].toInt();
			rgba.g = match[3].toInt();
			rgba.b = match[4].toInt();
			if (match[1].equals("rgba",true))
			rgba.a = match[5].toFloat();
		}
		return rgba;
	}	

	//Adapted from https://gist.github.com/mjijackson/5311256
	/**
	* Converts an RGB color value to HSL. Conversion formula
	* adapted from http://en.wikipedia.org/wiki/HSL_color_space.
	* Assumes r, g, and b are contained in the set [0, 255] and
	* returns h, s, and l in the set [0, 1].
	*
	* @param Number r The red color value
	* @param Number g The green color value
	* @param Number b The blue color value
	* @return Array The HSL representation
	*/
	public static function rgbToHsl(rgba:RGBA):HSLA {
		var r:Float = rgba.r / 255;
		var g:Float = rgba.g / 255;
		var b:Float = rgba.b / 255;

		var max:Float = untyped __js__("Math.max")(r, g, b), min:Float = untyped __js__("Math.min")(r, g, b);
		var h:Float = (max + min) / 2, s:Float = (max + min) / 2, l:Float = (max + min) / 2;

		if (max == min) {
			h = s = 0; // achromatic
			} else {
				var d:Float = max - min;
				s = l > 0.5 ? d / (2 - max - min) : d / (max + min);

				if  (r==max) h = (g - b) / d + (g < b ? 6 : 0); 
				if  (g==max) h = (b - r) / d + 2; 
				if  (b==max) h = (r - g) / d + 4; 	 
				h /= 6;
			}
			return { h:h, s:s, l:l, a:rgba.a };
		}

	/**
	* Converts an HSL color value to RGB. Conversion formula
	* adapted from http://en.wikipedia.org/wiki/HSL_color_space.
	* Assumes h, s, and l are contained in the set [0, 1] and
	* returns r, g, and b in the set [0, 255].
	*
	* @param Number h The hue
	* @param Number s The saturation
	* @param Number l The lightness
	* @return Array The RGB representation
	*/
	public static function hslToRgb(hsla:HSLA):RGBA {
		var h=hsla.h, s=hsla.s, l=hsla.l;
		var r, g, b;

		if (s == 0) {
			r = g = b = l; // achromatic
			} else {
				function hue2rgb(p:Float, q:Float, t:Float) {
					if (t < 0) t += 1;
					if (t > 1) t -= 1;
					if (t < 1/6) return p + (q - p) * 6 * t;
					if (t < 1/2) return q;
					if (t < 2/3) return p + (q - p) * (2/3 - t) * 6;
					return p;
				}

				var q = l < 0.5 ? l * (1 + s) : l + s - l * s;
				var p = 2 * l - q;

				r = hue2rgb(p, q, h + 1/3);
				g = hue2rgb(p, q, h);
				b = hue2rgb(p, q, h - 1/3);
			}

			return {r: Std.int(r * 255),g: Std.int(g * 255),b: Std.int(b * 255), a:hsla.a} ;
		}

	/**
	* Converts an RGB color value to HSV. Conversion formula
	* adapted from http://en.wikipedia.org/wiki/HSV_color_space.
	* Assumes r, g, and b are contained in the set [0, 255] and
	* returns h, s, and v in the set [0, 1].
	*
	* @param Number r The red color value
	* @param Number g The green color value
	* @param Number b The blue color value
	* @return Array The HSV representation
	*/
	public static function rgbToHsv(rgba:RGBA):HSVA {
		var r:Float = rgba.r / 255;
		var g:Float = rgba.g / 255;
		var b:Float = rgba.b / 255;

		var max:Float = untyped __js__("Math.max")(r, g, b), min:Float = untyped __js__("Math.min")(r, g, b);
		var h=max, s=max, v = max;

		var d = max - min;
		s = max == 0 ? 0 : d / max;

		if (max == min) {
			h = 0; // achromatic
			} else {
				if  (r==max) h = (g - b) / d + (g < b ? 6 : 0); 
				if  (g==max) h = (b - r) / d + 2; 
				if  (b==max) h = (r - g) / d + 4; 	
				h /= 6;
			}

			return { h:h, s:s, v:v, a:rgba.a };
		}

	/**
	* Converts an HSV color value to RGB. Conversion formula
	* adapted from http://en.wikipedia.org/wiki/HSV_color_space.
	* Assumes h, s, and v are contained in the set [0, 1] and
	* returns r, g, and b in the set [0, 255].
	*
	* @param Number h The hue
	* @param Number s The saturation
	* @param Number v The value
	* @return Array The RGB representation
	*/
	public static function hsvToRgb(hsva:HSVA):RGBA  {
		var h=hsva.h, s=hsva.s, v=hsva.v;
		var r=0.0, g=0.0, b=0.0;

		var i = Math.floor(h * 6);
		var f = h * 6 - i;
		var p = v * (1 - s);
		var q = v * (1 - f * s);
		var t = v * (1 - (1 - f) * s);

		switch (i % 6) {
			case 0: r = v; g = t; b = p; 
			case 1: r = q; g = v; b = p;
			case 2: r = p; g = v; b = t; 
			case 3: r = p; g = q; b = v;
			case 4: r = t; g = p; b = v; 
			case 5: r = v; g = p; b = q; 
		}

		return {r: Std.int(r * 255),g: Std.int(g * 255),b: Std.int(b * 255), a:hsva.a} ;
	}

	public static function saturateHSL(c:HSLA,amount:Float):HSLA 
		return {h:c.h,s:clamp(c.s += amount),l:c.l,a:c.a};

	public static function desaturateHSL(c:HSLA,amount:Float):HSLA 
		return {h:c.h,s:clamp(c.s -= amount),l:c.l,a:c.a};

	public static function lightenHSL(c:HSLA,amount:Float):HSLA 
		return {h:c.h,s:c.s,l:clamp(c.l += amount),a:c.a};

	public static function darkenHSL(c:HSLA,amount:Float):HSLA 
		return {h:c.h,s:c.s,l:clamp(c.l -= amount),a:c.a};

	public static function fadeinHSL(c:HSLA,amount:Float):HSLA 
		return {h:c.h,s:c.s,l:c.l,a:clamp(c.a += amount)};    

	public static function fadeoutHSL(c:HSLA,amount:Float):HSLA 
		return {h:c.h,s:c.s,l:c.l,a:clamp(c.a -= amount)};  

	public static function fadeHSL(c:HSLA,amount:Float):HSLA 
		return {h:c.h,s:c.s,l:c.l,a:clamp(amount)};  

	static inline function clamp(val) 
		return Math.min(1, Math.max(0, val));

}
@:forward
abstract Color(RGBA) from RGBA to RGBA {
	public inline function log()
	trace(this);

	@:from public static inline function fromString(str:String):Color
		return ColorTools.parseRGBA(str);

	@:to public inline function rgb():Color
		return this;
	
	@:to public inline function hsl():HSLAColor 
		return ColorTools.rgbToHsl(this);	

	@:to public inline function hsv():HSVAColor 
		return ColorTools.rgbToHsv(this);

	@:to public inline function toString():String
		return 'rgba(${this.r},${this.g},${this.b},${this.a})';

	public inline function saturate(amount:Float):Color 
		return hsl().saturate(amount).rgb();
	public inline function desaturate(amount:Float):Color 
		return hsl().desaturate(amount).rgb();
	public inline function greyscale():Color 
		return desaturate(1);
	public inline function lighten(amount:Float):Color 
		return hsl().lighten(amount).rgb();   
	public inline function darken(amount:Float):Color 
		return hsl().darken(amount).rgb();
	public inline function fadein(amount:Float):Color 
		return hsl().fadein(amount).rgb();   
	public inline function fadeout(amount:Float):Color 
		return hsl().fadeout(amount).rgb(); 
	public inline function fade(amount:Float):Color 
		return hsl().fade(amount).rgb();
}


@:forward
abstract HSLAColor(HSLA) from HSLA to HSLA{
	@:from public static inline function fromColor(c:Color):HSLAColor
		return c.hsl();
	@:to public inline function rgb():Color
		return ColorTools.hslToRgb(this);
	@:to public inline function hsl():HSLAColor
		return this;
	@:to public inline function hsv():HSVAColor
		return rgb().hsv();
	@:to public inline function toString():String
		return 'hsla(${this.h*360},${this.s*100}%,${this.l*100}%,${this.a})';

	public inline function saturate(amount:Float):HSLAColor 
		return ColorTools.saturateHSL(this,amount);
	public inline function desaturate(amount:Float):HSLAColor 
		return ColorTools.desaturateHSL(this,amount);
	public inline function greyscale():HSLAColor 
		return desaturate(1);  
	public inline function lighten(amount:Float):HSLAColor 
		return ColorTools.lightenHSL(this,amount);    
	public inline function darken(amount:Float):HSLAColor 
		return ColorTools.darkenHSL(this,amount);    
	public inline function fadein(amount:Float):HSLAColor 
		return ColorTools.fadeinHSL(this,amount);    
	public inline function fadeout(amount:Float):HSLAColor 
		return ColorTools.fadeoutHSL(this,amount);  
	public inline function fade(amount:Float):HSLAColor 
		return ColorTools.fadeHSL(this,amount);

}

@:forward
abstract HSVAColor(HSVA) from HSVA to HSVA{
	@:from public static inline function fromColor(c:Color):HSVAColor
		return c.hsl();
	@:to public inline function rgb():Color
		return ColorTools.hsvToRgb(this);
	@:to public inline function hsl():HSLAColor
		return rgb().hsl();
	@:to public inline function hsv():HSVAColor
		return this;
}

typedef RGBA = {
	r:Int,
	g:Int,
	b:Int,
	a:Float
}

typedef HSLA = {
	h:Float,
	s:Float,
	l:Float,
	a:Float
}

typedef HSVA = {
	h:Float,
	s:Float,
	v:Float,
	a:Float
}