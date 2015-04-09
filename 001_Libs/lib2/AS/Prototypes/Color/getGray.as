/**
 * @name getGray() - gets gray color of current color
 * @author senocular: www.senocular.com
 * @date 1899-12-31T00:53:53.800
 * @doc
<span style="font-size:larger;">Color <b>GETGRAY</b>: returns a color object of the gray 
equivalent of the objects current color.</span>
 
<b>Returns</b>:
- returns a color object (of only rb, gb and bb) all with similar values, which give
the gray of the current color.
 
<b>Note</b>:
- this will NOT return a color that can change a colored raster Image into grayscale.

 * @example 
col = new Color(_root.circle);
col2 = new Color(_root.circle2);
col.setTransform({rb:40, gb:255, bb:40}); // col is a greenish color
col2.setTransform(col.getGray()); // col2 is the gray of that greenish color
 */

Color.prototype.getGray = function(){
	var RGB = this.getTransform();
	var gray = Math.round(.3*RGB.rb + .59*RGB.gb + .11*RGB.bb);
	return {rb:gray, gb:gray, bb:gray};
}