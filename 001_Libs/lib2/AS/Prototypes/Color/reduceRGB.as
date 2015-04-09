/**
 * @name reduceRGB() - reduces tint set by setRGB()
 * @author senocular: www.senocular.com
 * @date 1899-12-31T00:09:07.800
 * @doc
<span style="font-size:larger;">Color <b>REDUCERGB</b>: reduces 'tint' set from the use of setRGB, being
able to bring a clip back to its original color as done similarly
in the tint color settings</span>
 
<b>Arguments</b>:
- <i>p</i>: (percent) the percent of reduction for your RGB color.  100 is the clip's original
color, while 0 is full RGB.
 
<b>Tips</b>:
- If you wanted, you could make a tintRGB prototype using this one combining it with the
setRGB prevent the need to use setRGB and reduceRGB in succession as shown in the
example above:
 
Color.prototype.tintRGB = function(hex, p){
	this.setRGB(hex);
	this.reduceRGB(p);
}
// usage
col = new Color(this); // make a new color for this movieclip
col.tintRGB(0xFF0000, 50); // turn the clip 50% red

<b>Note</b>:
- robert penner has a tint prototype using seperate r, b, and g values here:
http://www.layer51.com/proto/d.aspx?f=143
this one just works well in conjunction with setRGB

<b>Update</b>:
- fixed a stupid bug DOH! ;)

 * @example
col = new Color(this); // make a new color for this movieclip
col.setRGB(0xFF0000); // turn the clip red
col.reduceRGB(50); // change the red to only be a 50% tint of red
 */

Color.prototype.reduceRGB = function(p){
	var t = this.getTransform(), r = (100-p)/100;
	this.setTransform({ra:p,rb:t.rb*r,ga:p,gb:t.gb*r,ba:p,bb:t.bb*r});
}