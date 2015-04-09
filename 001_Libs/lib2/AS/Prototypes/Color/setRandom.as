/**
 * @name setRandom() - converts color to random hex color and returns that value
 * @author senocular: www.senocular.com
 * @date 1899-12-31T00:17:01.900
 * @doc
<span style="font-size:larger;">Color <b>SETRANDOM</b>: changes the color to a random
color (RGB hex) and returns that color in hex value.</span>
 
<b>Returns</b>:
- returns a number between 1 and 16777215 (which is 000000 - ffffff) representing
the color this color object was set to.


 * @example
col = new Color(_root.clip);
randCol = col.setRandom(); // sets clip to random color
col.setRGB(0xFFFFFF); // sets clip to white
col.setRGB(randCol); // returns clip to old random color
 */

Color.prototype.setRandom = function(){
	var ran = Math.floor(Math.random()*0xFFFFFF);
	this.setRGB(ran);
	return ran;
}