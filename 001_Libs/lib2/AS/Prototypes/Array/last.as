/**
 * @name last() The last element of the array, get, set or overwrite
 * @author senocular: www.senocular.com
 * @date 1899-12-31T00:52:28.200
 * @doc
<span style="font-size:larger;">Array <b>LAST</b>:  Simple, but at times useful - last acts as
a type of push alternative as well as a method for 
retrieving the last element of an array.</span>

<b>myArray.last(toAdd, overwrite);

Arguments:</b>
- toAdd: (optional) value to add to as the last element of the array.
- overwrite: (optional, boolean) a true or false value specifying whether or not the
toAdd value should replace the current last element or not. default false (meaning
it will not be replaced and toAdd will be pushed).

<b>Returns:</b>
- the last element of the array.  If a new element is added, the original 'last'
element is returned.

 * @example
myArray = [1,2,3,4,5];
trace(myArray.last()); // 5
myArray.last(6);
trace(myArray); // 1,2,3,4,5,6
myArray.last(0, true);
trace(myArray); // 1,2,3,4,5,0
 */

Array.prototype.last = function(toAdd, overwrite){
	if (toAdd != undefined){
		var old = this[this.length-1];
		this[this.length-overwrite] = toAdd;
		return old;
	}
	return this[this.length-1];
};