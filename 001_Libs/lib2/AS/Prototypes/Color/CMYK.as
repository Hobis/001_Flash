/**
 * @name CMYK: setCMYK() and getCMY() (cyan, magenta, yellow, (black))
 * @author senocular: www.senocular.com
 * @date 1899-12-31T00:47:52.600
 * @doc
<span style="font-size:larger;">Color <b>setCMYK</b> and <b>getCMY</b>: sets color and retrieves a color
object. Color based on CYAN (0-100), MAGENTA (0-100), YELLOW (0-100)
and BLACK (0-100).</span>
 
[<b><span style="font-size:larger;">setCMYK</span></b>]
<b>Arguments</b>:
- <i>CMY object</i>: {c,m,y} c = cyan, from scale 0-100. m = magenta, from scale 0-100.
y = Yellow, from scale 0-100
- <i>k</i>: (optional) black component (0-100) to be figured on top of the CMY object colors
Default is 0.
 
[<b><span style="font-size:larger;">setCMY</span></b>]
<b>Returns</b>:
- <i>Object</i>: generic object with properties c (cyan), y (yellow), and m (magenta).


 * @example
col = new Color(_root.circle);
col.setRGB(0xff00ff); // set color to magenta
colcmy = col.getCMY(); // retrieves HSB  (of magenta), colcmy = { c:0, m:100, y:0 }
col.setCMYK({c:0, m:100, y:100},0); // sets _root.circle to be red
colrgb = col.getRGB(); // colrgb gets equivalent of 0xff0000, the set CMYK as hex
 */

Color.prototype.setCMYK = function(CMY, k){
	if (arguments.length == 2) k = 1-k/100;
	else k = 1;
	this.setTransform({ra:0, rb:(255-CMY.c*2.55)*k, ga:0, gb:(255-CMY.m*2.55)*k, ba:0, bb:(255-CMY.y*2.55)*k});
}
Color.prototype.getCMY = function(){
	var RGB = this.getTransform();
	var ratio = 100/255;
	var c = Math.round(100 - RGB.rb*ratio);
	var m = Math.round(100 - RGB.gb*ratio);
	var y = Math.round(100 - RGB.bb*ratio);
	return {c:c, m:m, y:y};
}