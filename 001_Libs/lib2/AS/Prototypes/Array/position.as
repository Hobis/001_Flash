/**
 * @name _position, current(), next(), previous() a constant reference for a position in an array
 * @author senocular: www.senocular.com
 * @date 1899-12-31T00:42:55.600
 * @doc
<span style="font-size:larger;">Array <b>_POSITION</b>: A property and a group of
methods for array objects which allow you to walk or
cycle through an array given its _position within
that array.  Every array's _position starts at 0 and
can be changed at any time either manually or through using
the next() or previous() methods, both of which, as is
also true with current, retrieves/sets that _position in 
the array, with next() and previous() also moving it.</span>

<b>myArray._position</b>
- array property referencing the current position of an array objects... position.

<b>myArray.current(newValue);
myArray.next(newValue);
myArray.previous(newValue);

Arguments:</b>
- <i>newValue</i>: (optional) a new value to be placed in the desired position of the array.
For current() the array index is myArray._position.  For next, its myArray._position+1 and
for previous() its myArray._position-1 - this, however, unless the index surpasses the
bounds of the array, at which point the _position is placed on the other side of the
array, ie. 0 for next if it goes beyond the length of the array and myArray.length-1
for previous() in case _postion goes below 0.

<b>Returns:</b>
- returns the element currently existing at that array position.  If a new Value is added,
the old value is returned. 

<b>next() </b>moves the _position of the array to the next element
<b>previous() </b>moves the _position of the array to the previous element

 * @example
// cycle through an array with length 10 adding
// the time which the mouse was clicked using
// getTimer().  once the end is reached, the 
// _position is back to 0 and it repeats the
// cycle starting with the 'front' of the array
clickArray = new Array(10);
clickArray.current(getTimer());

this.onMouseDown = function(){
	clickArray.previous(getTimer());
	trace("["+clickArray+"]");
}
 */

Array.prototype._position = 0;
Array.prototype.current = function(newVal){
	if (!this.length) return undefined;
	if (!this._position) this._position = 0;
	else if (this._position >= this.length) this._position = this.length-1;
	if (newVal == undefined) return this[this._position];
	var orig = this[this._position];
	this[this._position] = newVal;
	return orig;
};
Array.prototype.next = function(newVal){
	if (!this.length) return undefined;
	if (this._position <= 0) this._position = 1;
	else if (this._position >= this.length-1) this._position = 0;
	else ++this._position;
	if (newVal == undefined) return this[this._position];
	var orig = this[this._position];
	this[this._position] = newVal;
	return orig;
};
Array.prototype.previous = function(newVal){
	if (!this.length) return undefined;
	if (this._position <= 0 || this._position >= this.length) this._position = this.length-1
	else --this._position;
	if (newVal == undefined) return this[this._position];
	var orig = this[this._position];
	this[this._position] = newVal;
	return orig;
};