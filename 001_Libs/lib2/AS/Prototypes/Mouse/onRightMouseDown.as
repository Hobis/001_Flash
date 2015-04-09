/**
 * @name onRightMouseDown, onRightMouseUp [MX]
 * @author senocular: www.senocular.com
 * @date 1899-12-31T00:02:10.200
 * @doc
<span style="font-size:larger;">Mouse Events <b>onRightMouseDown, onRightMouseUp:</b>
event handlers for right mouse button clicks.  Checks
for these clicks happen every 40 milliseconds.</span>

- In order for these to be recognized, be sure to add your movieclip/object as a listener
of the mouse object: Mouse.addListener(myObject);

 * @example
var mouseListener = new Object();
Mouse.addListener(mouseListener);
mouseListener.onRightMouseUp = function(){
	trace("Right mouse released");
}
 */

setInterval(function(){if(Mouse.rightMouseDown^(Mouse.rightMouseDown=Key.isDown(2))) Mouse.rightMouseDown ? Mouse.broadcastMessage("onRightMouseDown") : Mouse.broadcastMessage("onRightMouseUp");},40);
