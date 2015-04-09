/**
 * @name plus() - adds 2 arrays by value;
 * @author senocular: www.senocular.com
 * @date 1899-12-31T00:25:43.700
 * @doc
<span style="font-size:larger;">Array <b>PLUS </b>- adds values of 2 arrays by index (ie. index 1 of
each array is added together followed by index 2, etc.) and returns
as a new array</span>

<b>Arguments</b>:
<i>a</i> - the array to add to the current array.
<i>trim</i> - (optional) boolean determining whether or not the returned array is cut off to be the
length of the shorter array.  If trim is not passed or is set to false, the returned array
is the length of the larger array and those values have no operation imposed on them

<b>Note</b>:
- you can easily convert this proto to use any type of operation such as minus, divide, or
multiply (among others) ex:
<code>
Array.prototype.<b>multiply </b>= function(a, trim){
	var i=this.length, j=a.length, r=[];
	r = (trim ^ (i > j)) ? r = this.slice() : a.slice();
	i = Math.min(i,j);
	while(i--) r[i] = this[i] <b><span style="font-size:larger;">*</span></b> a[i];
	return r;
}
</code>
 

 * @example
a = [1,2,3,4,5,6];
b = [1,2,3,4];
trace(a.plus(b)); // 2,4,6,8,5,6
trace(a.plus(b, true)); // 2,4,6,8
 */

Array.prototype.plus = function(a, trim){
	var i=this.length, j=a.length, r=[];
	r = (trim ^ (i > j)) ? r = this.slice() : a.slice();
	i = Math.min(i,j);
	while(i--) r[i] = this[i] + a[i];
	return r;
}