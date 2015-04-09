/**
 * @name listenTo() - make listener listen to multiple broadcasters
 * @author senocular: www.senocular.com
 * @date 1899-12-31T00:44:16.500
 * @doc
<span style="font-size:larger;">Object <b>LISTENTO</b> (for ASBroadcaster uses): When used on a 
listener, it lets you specify more than one broadcaster for
that object to listen to (it adds this object as a listener
to the passed objects)</span>
 
<b>Arguments:</b>
- <i>objs</i>: any number of objects for which the current object is to be a listener
of.  If any of the passed objects were not initialized with ASB initialize (or internally
dont have an addlisteners handler) then the object will be initialized before this as a
listener is added.

 * @example
Admiral = {};
General = {};

Troop = {};
Troop.yelling = function(){ trace("Sir, yes SIR!"); }
Troop.listenTo(Admiral, General);

Admiral.broadcastMessage("yelling");
General.broadcastMessage("yelling");

// traces:
Sir, yes SIR!
Sir, yes SIR!
 */

// since broadcasting objects arent instances of the broadcaster
// object and are just general objects themselves, Object.prototype
// is used for initiated ASB objects (and listeners)
Object.prototype.listenTo = function(objs){
	var i = 0; l = arguments.length;
	for (i=0; i<l; i++){
		if (!arguments[i].addListener) ASBroadcaster.initialize(arguments[i]);
		arguments[i].addListener(this);
	}
}