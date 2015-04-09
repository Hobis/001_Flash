/**
 * @name // equals() - array comparison
 * @author senocular: www.senocular.com
 * @date 1899-12-31T00:39:08.100
 * @doc
I thought this one should have been here... theres a 2D compare but not a simple 
single dimensional compare.

- checks to see if the values of the elements in 2 different arrays are the same or not
if so, true is returned, if not false.

 * @example
a = [1,2,3,4];
b = [1,2,3,4];
c = [1,2,3,5];
d = a;

trace(a.equals(b)); // true
trace(a.equals(c)); // false
trace(a.equals(d)); // true
 */

Array.prototype.equals = function(a){
	if (this == a) return true;
	var i = this.length;
	if (i != a.length) return false;
	while(i--) if (this[i] != a[i]) return false;
	return true;
}