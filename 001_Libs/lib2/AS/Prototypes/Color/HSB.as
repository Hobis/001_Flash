/**
 * @name HSB: setHSB() and getHSB() (hue, saturation and brightness)
 * @author senocular: www.senocular.com
 * @date 1899-12-31T00:41:56.800
 * @doc
<span style="font-size:larger;">Color <b>setHSB </b>and <b>getHSB</b>: sets color and retrieves a color
object. Color based on HUE (0-360), SATURATION (0-100) and
BRIGHTNESS (0-100)</span>
 
[<b><span style="font-size:larger;">setHSB</span></b>]
<b>Arguments</b>:
- <i>HSB object</i>: {s,h,b} h = Hue, from scale 0-360. 0 is red, 120 is green, 240 is blue
s = Saturation - the "grey" of a color from scale 0-100, 0 is grey/white, 100 is pure
b = Brightness, from scale 0-100, 0 is black, 100 is pure color.
 
[<b><span style="font-size:larger;">getHSB</span></b>]
<b>Returns</b>:
- <i>Object</i>: generic object with properties h (hue), s (saturation), and b (brightness)
 
<b>Warnings</b>:
- There MAY be some differences in setting HSB and then immediately retrieving
them again based on fraction inconsistencies.  I havent played around enough
with it to know yet.

<b>Update</b>:
- changed ranges of saturation and brightness from 0-255 to 0-100.
- changed argument of setHSB to be the hsb object returned from getHSB

 * @example
col = new Color(_root.circle);
col.setRGB(0xff00ff); // set color to magenta
colhsb = col.getHSB(); // retrieves HSB  (of magenta), colhsb = { h: 300, s: 255, b: 255 }
col.setHSB({s:120, h:255, b:127}); // sets _root.circle to be a pure green of "middle darkness"
colrgb = col.getRGB(); // colrgb gets equivalent of 0x007f00, the set HSB as hex
 */

Color.prototype.setHSB = function(HSB){
	var RGB = {ra:0, ga:0, ba:0};
	HSB.s *= 2.55; HSB.b *= 2.55; 
	if(!HSB.h  && !HSB.s){
		RGB.rb = RGB.gb = RGB.bb = HSB.b;
		this.setTransform(RGB);
	}else{
		var diff = (HSB.b * HSB.s)/255;
		var low = HSB.b - diff;
		if(HSB.h > 300 || HSB.h <= 60){
			RGB.rb = HSB.b;
			if(HSB.h > 300){
				RGB.gb = Math.round(low);
				HSB.h = (HSB.h-360)/60;
				RGB.bb = -Math.round(HSB.h*diff - low);
			}else{
				RGB.bb = Math.round(low);
				HSB.h = HSB.h/60;
				RGB.gb = Math.round(HSB.h*diff + low);
			}
		}else if(HSB.h > 60 && HSB.h < 180){
			RGB.gb = HSB.b;
			if(HSB.h < 120){
				RGB.bb = Math.round(low);
				HSB.h = (HSB.h/60 - 2) * diff;
				RGB.rb = Math.round(low - HSB.h);
			}else{
				RGB.rb = Math.round(low);
				HSB.h = (HSB.h/60 - 2) * diff;
				RGB.bb = Math.round(low + HSB.h);
			}
		}else{
			RGB.bb = HSB.b;
			if(HSB.h < 240){
				RGB.rb = Math.round(low);
				HSB.h = (HSB.h/60 - 4) * diff;
				RGB.gb = Math.round(low - HSB.h);
			}else{
				RGB.gb = Math.round(low);
				HSB.h = (HSB.h/60 - 4) * diff;
				RGB.rb = Math.round(low + HSB.h);
			}
		}
		this.setTransform(RGB);
	}
}
Color.prototype.getHSB = function(){
	var RGB = this.getTransform();
	var r = RGB.rb, g = RGB.gb, b = RGB.bb;
	var low = Math.min(r,Math.min(g,b));
	var high = Math.max(r,Math.max(g,b));
	var HSB = {b: high*100/255};
	var diff = high-low;
	if (diff){
		HSB.s = Math.round(100*(diff/high));
		if(r == high) HSB.h = Math.round(((g-b)/diff)*60);
		else if(g == high) HSB.h = Math.round((2 + (b-r)/diff)*60);
		else HSB.h = Math.round((4 + (r-g)/diff)*60);
		if (HSB.h > 360) HSB.h -= 360;
		else if (HSB.h < 0) HSB.h += 360;
	}else HSB.h = HSB.s = 0;
	return HSB;
}