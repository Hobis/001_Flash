/**
 * @name blendRGB() - blends color between two hex numbers
 * @author senocular: www.senocular.com
 * @date 1899-12-31T00:09:45.800
 * @doc
<span style="font-size:larger;">Color <b>BLENDRGB</b>: takes two hex colors and sets the color
of the color object to a blend of those two colors
based on the 3rd argument t</span>
 
<b>Arguments:</b>
- <i>c1, c2</i>: (Color 1 and Color 2 (optional)) Hex values of the colors to blend. If only one
color and t is passed, the color is blended with the current color of the color object.
- <i>t</i>: a value between -1 and 1 which blends the passed colors together.  The range is
actually 0 to 1 <i>or</i> 0 to -1.  Using negative numbers just reverses the blend from
color 1 to color 2 to color 2 to color 1.  However, in any case, a 't' of 0 is color 1.
 
<b>Returns:</b>
- the new HEX value of the color blend
 
<b>Example:</b>
red = 0xFF0000;
blue = 0x0000FF;
colorObj.blendRGB(red, blue, t);
...
Going from a t of 0 to 1 will go from red to blue.
Going from 0 to -1 will go from blue to red (though 0 itself is still red)

 * @example
// from blue to red over 100 frames with a mouse down
onClipEvent(load){
	// make a new color object (col) for this clip
	col = new Color(this);
	// set doBlend variable to 0
	doBlend = 0;
}

onClipEvent(enterFrame){
	// if doBlend is true or non 0
	if (doBlend) {
		// call the colors new blendRGB method.  Make the color a
		// range between red and blue based on doBlend
		col.blendRGB(0xFF0000, 0x0000FF, doBlend);

		// decrement doBlend everyframe, thereby going from 1
		// to 0 and shifting the colors accordingly. Once doBlend
		// is 0, the shifting will stop (from the if statement)
		doBlend -= .01; // for 100 frames: 1/100 = .01

		// check to make sure doBlend stops after reaching 0 
		//(just in case it goes past zero from the decrement)
		if (doBlend < 0) doBlend = 0;
	}
}

onClipEvent(mouseDown){
	// when the mouse is pressed, set doBlend to 1
	doBlend = 1;
}
 */

// blendRGB uses this Number prototype
// converts a (hex) number to r,g, and b.
Number.prototype.HEXtoRGB = function(){
	return {rb:this >> 16, gb:(this >> 8) & 0xff, bb:this & 0xff};
}
Color.prototype.blendRGB = function(c1,c2,t){
	if (arguments.length == 2){
		t = c2;
		c2 = this.getRGB();
	}
	if (t<-1) t=-1;
	else if (t>1) t=1;
	if (t<0) t=1+t;
	c1 = c1.HEXtoRGB();
	c2 = c2.HEXtoRGB();
	var ct = (c1.rb+(c2.rb-c1.rb)*t) << 16 | (c1.gb+(c2.gb-c1.gb)*t) << 8 | (c1.bb+(c2.bb-c1.bb)*t);
	this.setRGB(ct);
	return ct;
}