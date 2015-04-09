/**
 * @name ifElse() - returns first parameter if true, second if false
 * @author senocular: www.senocular.com
 * @date 1899-12-31T00:59:27.200
 * @doc
<span style="font-size:larger;">Boolean <b>ifElse</b>: returns one of 2 statements based on value of
boolean. A form of ?: which can be inserted directly into strings.</span>
 
<b>Arguments</b>
- <i>a</i>: statement 1 - returned value if boolean is true
- <i>b</i>: statement 2 - returned value if boolean is false

 * @example
answer = new Boolean(true);
response = "You said "+ answer.ifElse("yes","no") +" to dating my sister?";
trace(response); // traces You said yes to dating my sister?
 */

Boolean.prototype.ifElse = function(a,b){
	return (this.valueOf()) ? a : b;
}