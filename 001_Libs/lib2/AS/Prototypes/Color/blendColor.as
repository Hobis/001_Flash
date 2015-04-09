/**
 * @name blendColor() - blends color between two Color objects
 * @author senocular: www.senocular.com
 * @date 1899-12-31T00:26:06.600
 * @doc
<span style="font-size:larger;">Color <b>BLENDCOLOR</b>: takes two color objects and sets the
color of this color object to a blend of those two colors
based on the 3rd argument t</span>
 
<b>Arguments:</b>
- <i>c1, c2</i>: (Color 1 and Color 2 (optional)) Color objectts with the colors to blend. If only
one color and t is passed, the color is blended with the current color of the color object.
- <i>t</i>: a value between -1 and 1 which blends the passed colors together.  The range is
actually 0 to 1 <i>or</i> 0 to -1.  Using negative numbers just reverses the blend from
color 1 to color 2 to color 2 to color 1.  However, in any case, a 't' of 0 is color 1.
 
<b>Returns:</b>
- the new color transform object.
 
<b>Example:</b>
colorObj.blendColor(color1, color2, t);
...
Going from a t of 0 to 1 will go from color1 to color2.
Going from 0 to -1 will go from color2 to color1 (though 0 itself is still color1)

 * @example
// from blue to red over 100 frames with a mouse down
onClipEvent(load){
	// make a new color object (col) for this clip
	col = new Color(this);
	// color objects of other movieclips
	a = new Color(_parent.clip1_mc);
	b = new Color(_parent.clip2_mc);
	// set doBlend variable to 0
	doBlend = 0;
}

onClipEvent(enterFrame){
	// if doBlend is true or non 0
	if (doBlend) {
		// call the colors new blendColor method.  Make the color
		// a range between clip1_mc's color and clip2_mc's color
		// based on doBlend
		col.blendColor(a, b, doBlend);

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

Color.prototype.blendColor = function(c1,c2,t){
	if (arguments.length == 2){
		t = c2;
		c2 = this;
	}
	if (t<-1) t=-1;
	else if (t>1) t=1;
	if (t<0) t=1+t;
	var ct = {};
	c1 = c1.getTransform();
	c2 = c2.getTransform();
	for (p in c1) ct[p] = c1[p]+(c2[p]-c1[p])*t;
	this.setTransform(ct);
	return ct;
}