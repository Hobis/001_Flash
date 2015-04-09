/**
 * @name invertRGB() - inverts color
 * @author senocular: www.senocular.com
 * @date 1899-12-31T00:02:20.700
 * @doc
<span style="font-size:larger;">Color <b>INVERTRGB</b>: inverts a color object color.  </span>

 * @example
// interts the color of this clip when the mouse is down
onClipEvent(load){
	col = new Color(this);
	col.setRGB(0xff8822);
}
onClipEvent(mouseDown){
	col.invertRGB(); //invert
}
onClipEvent(mouseUp){
	col.invertRGB(); // unvert ;)
}
 */

Color.prototype.invertRGB = function(){
	this.setRGB(0xffffff-this.getRGB());
}