/**
 * @name align() - aligns movieclips tops, bottoms, left, rights and/or centers.
 * @author senocular: www.senocular.com
 * @date 1899-12-31T00:56:24.000
 * @doc
<span style="font-size:larger;">MovieClip <b>ALIGN</b>: Aligns clips to this clip as done through the
align panel.  You can align left sides, right sides, bottoms,
tops, and centers either horizontally or vertically.</span>
 
<b>Arguments</b>:
- <i>h</i>: (horizontal align) alignment horizontally.  This can be any one of three strings, "left",
"right", "center", or null (or anything other than those 3) for no alignment.
- <i>v</i>: (vertical align) alignment vertically.  This can be any one of three strings, "top",
"bottom", "center", or null (or anything other than those 3) for no alignment.
- <i>mcs</i>: (moveiclips) any number of sequentially added movieclips which are to be aligned
to this clip.
 
<b>Note</b>:
- alignment is done through any scope.

 * @example
// align clips a, b and c to this clip when the mouse is pressed
// aligns all clips to the left of this.
onClipEvent(mouseDown){
	this.align("left", null, _root.a, b, _parent.container.c);
}
 
// align clips a, b and c to this clip when the mouse is pressed
// aligns all clips to the center vertically (along x axis)
onClipEvent(mouseDown){
	this.align(null, "center", _root.a, b, _parent.container.c);
}
 */

MovieClip.prototype.align = function(h,v, mcs){
	var i, l = arguments.length, b, coords;
	var tb = this.getBounds(_root);
	for (i=2; i<l; i++){
		ab = arguments[i].getBounds(_root);
		if (h=="left") arguments[i]._x += tb.xmin - ab.xmin;		// left align
		else if (h=="right") arguments[i]._x += tb.xmax - ab.xmax;	// right align
		else if (h=="center") arguments[i]._x += tb.xmin + this._width/2 - ab.xmin - arguments[i]._width/2;	// center align y axis
		if (v=="top") arguments[i]._y += tb.ymin - ab.ymin;		// top align
		else if (v=="bottom") arguments[i]._y += tb.ymax - ab.ymax;	// bottom align
		else if (v=="center") arguments[i]._y += tb.ymin + this._height/2 - ab.ymin - arguments[i]._height/2; // center align x axis
	}	
}