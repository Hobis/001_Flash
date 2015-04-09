/**
 * @name isBroadcaster() - determines if object has been initiated by ASBroadcaster and has listeners
 * @author senocular: www.senocular.com
 * @date 1899-12-31T00:29:04.700
 * @doc
<span style="font-size:larger;">Object <b>ISBROADCASTER</b> (for ASBroadcaster uses): Checks an
Object for the _listeners property and sees if it has at least one
element within, if so, true is returned.</span>
 
<b>Returns:</b>
- true if the object is considered a broadcaster (has atleast 1 listener) and
false if not.

 * @example
General = {};
Troop = {};
trace(General.isBroadcaster()); // false
ASBroadcaster.initialize(General);
trace(General.isBroadcaster()); // false
General.addListener(Troop);
trace(General.isBroadcaster()); // true
 */
 

// since broadcasting objects arent instances of the broadcaster
// object and are just general objects themselves, Object.prototype
// is used for initiated ASB objects
Object.prototype.isBroadcaster = function(){
	return (this._listeners.length) ? true : false;
}