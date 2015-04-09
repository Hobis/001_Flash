/**
 * @name clearRGB() - clears any color set by setRGB (or setTransform)
 * @author senocular: www.senocular.com
 * @date 1899-12-31T00:33:15.300
 * @doc
<span style="font-size:larger;">Color <b>CLEARRGB</b>: Removes a Color Object set color</span>

<b>colorObjectInstance.clearRGB();

Arguments:</b>
- None

<b>Returns:</b>
- Nothing

 * @example
myCol = new Color(clipA);
clipA.onPress = function(){
	// turn red
	myCol.setRGB(0xff0000);
}
clipA.onRelease = clipA.onReleaseOutside = function(){
	// restore to original coloring
	myCol.clearRGB();
}
 */

Color.prototype.clearRGB = function(){
	this.setTransform({ra:100, rb:0,ga:100,gb:0,ba:100,bb:0,aa:100,ab:0});
}