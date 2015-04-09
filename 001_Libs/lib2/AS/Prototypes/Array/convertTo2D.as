/**
 * @name convertTo2D/ 2D-Array.toString - convert an array to a 2D array
 * @author senocular: www.senocular.com
 * @date 1899-12-31T00:56:43.500
 * @doc
<span style="font-size:larger;">Array <b>CONVERTTO2D</b>: Creates a 2 dimensional array out of
a 'normal' single dimensional array. This new array gets a
 new property .is2D (set to true) specifying that the array
is 2 dimensional and has a new .toString method written for
it to show the array in 2D.</span>

<b>myArray.convertTo2D(rows, columns [, retain]);

Arguments:</b>
- <i>rows</i>: (number) number of rows for the new 2D array.
- <i>columns</i>: (number) number of columns for the new 2D array
- <i>retain</i>: (boolean, optional) dictates whether or not the current array is converted to a
2Darray (true) or a new 2D array is created from the current array (false). Default: true.

<b>Returns</b>:
- if the array is retained, the array is returned. If not retained, the new array is
returned.  If the call lacks the correct number of arguments or the array was already
converted to a 2D array by this method.

 * @example
var a = [1,2,3,4,5,6];
trace(a);
trace("=========");
trace(a.convertTo2D(2,3, false));
trace("=========");
trace(a.convertTo2D(3,2, false));
trace("=========");
trace(a.convertTo2D(1,6, false));
trace("=========");
a.convertTo2D(6,1);
trace(a);
trace("=========");
trace(a.convertTo2D(2,3));

// OUTPUT:
1,2,3,4,5,6
=========
[1,2,3]
[4,5,6]
=========
[1,2]
[3,4]
[5,6]
=========
[1,2,3,4,5,6]
=========
[1]
[2]
[3]
[4]
[5]
[6]
=========
false
 */

Array.prototype.toString2D = function(){
	for (var r,out="",c=0; c<this.length; ++c){
		for (r=0; r<this[c].length; ++r) out += (r) ? ","+this[c][r] : "["+this[c][r];
		out +=  "]\n";
	};
	return out.slice(0,-1);
};
Array.prototype.convertTo2D = function(rows, cols, retain){
	if (this.is2D || !(rows > 0 && cols > 0)) return false;
	var a = this.slice(), me = (retain == false) ? [] : this;
	for (me.length=0; me.length<rows;) me[me.length] = (a.length) ? a.splice(0,cols) : [];
	me.toString = this.toString2D;
	me.is2D = true;
	return me;
};