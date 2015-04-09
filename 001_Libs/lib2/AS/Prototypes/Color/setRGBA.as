/**
 * @name setRGBA() - set RGB with alpha
 * @author senocular: www.senocular.com
 * @date 1899-12-31T00:50:12.900
 * @doc
<span style="font-size:larger;">Color <b>SETRGBA</b>: sets rgb (hex) and alpha (-100 to 100)
similar to that of setRGB only with an alpha argument.</span>

<b>Arguments</b>:
- <i>hex</i>: basic RGB hex color as added in setRGB
- <i>a</i>: alpha.  transparency value -100 to 100 where 0 is transparent and 100 is opaque.

<b>Returns</b>:
nothing

 * @example
var col = new Color(my_mc);
col.setRGBA(0xFF0000, 50); // red with 50% transparency
 */

Color.prototype.setRGBA = function(hex, a){
	this.setRGB(hex);
	this.setTransform({aa:a})
}
