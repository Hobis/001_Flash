class MovieClipProxy extends MovieClip {
	
	/******* Internal MovieClipProxy *******/
	private var _mc = new Object();
	
	function MovieClipProxy(a,b,c,d) {
		var mc;
		if (arguments.length == 3) mc = __initEmpty(a,b,c);
		else mc = __initAttached(a,b,c,d);
		__applyPrototyped(mc);
	}
	public function valueOf():MovieClip {
		return _mc;
	}
	public function toString():String {
		return _mc.toString();
	}
	private function __initAttached(timeline:MovieClip, id:String, name:String, depth:Number):MovieClip {
		 return timeline.attachMovie(id,name,depth);
	}
	private function __initEmpty(timeline:MovieClip, name:String, depth:Number):MovieClip {
		return  timeline.createEmptyMovieClip(name,depth);
	}
	private function __applyPrototyped(mc:MovieClip):Void {
		_mc.__proto__ = null;
		for (var e in _mc) mc[e] = _mc[e];
		_mc = mc;
		_mc.__o = this;
	}
	
	/******* PROPERTIES *******/
	function get useHandCursor():Boolean { return _mc.useHandCursor; }
	function set useHandCursor(v:Boolean):Void { _mc.useHandCursor = v; }
	function get enabled():Boolean { return _mc.enabled; }
	function set enabled(v:Boolean):Void { _mc.enabled = v; }
	function get focusEnabled():Boolean { return _mc.focusEnabled; }
	function set focusEnabled(v:Boolean):Void { _mc.focusEnabled = v; }
	function get tabChildren():Boolean { return _mc.tabChildren; }
	function set tabChildren(v:Boolean):Void { _mc.tabChildren = v; }
	function get tabEnabled():Boolean { return _mc.tabEnabled; }
	function set tabEnabled(v:Boolean):Void { _mc.tabEnabled = v; }
	function get tabIndex():Number { return _mc.tabIndex; }
	function set tabIndex(v:Number):Void { _mc.tabIndex = v; }
	function get hitArea():Object { return _mc.hitArea; }
	function set hitArea(v:Object):Void { _mc.hitArea = v; }
	function get trackAsMenu():Boolean { return _mc.trackAsMenu; }
	function set trackAsMenu(v:Boolean):Void { _mc.trackAsMenu = v; }
	
	function get _x():Number { return _mc._x; }
	function set _x(v:Number):Void { _mc._x = v; }
	function get _y():Number { return _mc._y; }
	function set _y(v:Number):Void { _mc._y = v; }
	function get _xmouse():Number { return _mc._xmouse; }
	function get _ymouse():Number { return _mc._ymouse; }
	function get _yscale():Number { return _mc._yscale; }
	function set _yscale(v:Number):Void { _mc._yscale = v; }
	function get _xscale():Number { return _mc._xscale; }
	function set _xscale(v:Number):Void { _mc._xscale = v; }
	function get _width():Number { return _mc._width; }
	function set _width(v:Number):Void { _mc._width = v; }
	function get _height():Number { return _mc._height; }
	function set _height(v:Number):Void { _mc._height = v; }
	function get _alpha():Number { return _mc._alpha; }
	function set _alpha(v:Number):Void { _mc._alpha = v; }
	function get _lockroot():Boolean { return _mc._lockroot; }
	function set _lockroot(v:Boolean):Void { _mc._lockroot = v; }
	function get _visible():Boolean { return _mc._visible; }
	function set _visible(v:Boolean):Void { _mc._visible = v; }
	function get _target():String { return _mc._target; }
	function get _rotation():Number { return _mc._rotation; }
	function set _rotation(v:Number):Void { _mc._rotation = v; }
	function get _name():String { return _mc._name; }
	function set _name(v:String):Void { _mc._name = v; }
	function get _droptarget():String { return _mc._droptarget; }
	function get _currentframe():Number { return _mc._currentframe; }
	function get _totalframes():Number { return _mc._totalframes; }
	function get _quality():String { return _mc._quality; }
	function get _focusrect():Boolean { return _mc._focusrect; }
	function get _soundbuftime():Number { return _mc._soundbuftime; }
	function get _url():String { return _mc._url; }
	function get _parent():MovieClip { return _mc._parent; }
	
	
	/******* METHODS *******/
	function getURL(url:String,window:String,method:String):Void {
		_mc.getURL(url,window,method);
	}
	function unloadMovie():Void {
		_mc.unloadMovie();
	}
	function loadVariables(url:String,method:String):Void {
		_mc.loadVariables(url,method);
	}
	function loadMovie(url:String,method:String):Void {
		_mc.loadMovie(url,method);
	}
	function attachMovie(id:String,name:String,depth:Number,initObject:Object):MovieClip {
		return _mc.attachMovie(id,name,depth,initObject);
	}
	function swapDepths(mc:Object):Void {
		_mc.swapDepths(mc);
	}
	function localToGlobal(pt:Object):Void {
		_mc.localToGlobal(pt);
	}
	function globalToLocal(pt:Object):Void {
		_mc.globalToLocal(pt);
	}
	function hitTest():Boolean {
		return _mc.hitTest();
	}
	function getBounds(bounds):Object {
		return _mc.getBounds(bounds);
	}
	function getBytesLoaded():Number {
		return _mc.getBytesLoaded();
	}
	function getBytesTotal():Number {
		return _mc.getBytesTotal();
	}
	function attachAudio(id:Object):Void {
		_mc.attachAudio(id);
	}
	function attachVideo(id:Object):Void {
		_mc.attachVideo(id);
	}
	function getDepth():Number {
		return _mc.getDepth();
	}
	function getInstanceAtDepth(depth:Number):MovieClip {
		return _mc.getInstanceAtDepth(depth);
	}
	function getNextHighestDepth():Number {
		return _mc.getNextHighestDepth();
	}
	function setMask(mc:Object):Void {
		_mc.setMask(mc);
	}
	function play():Void {
		_mc.play();
	}
	function stop():Void {
		_mc.stop();
	}
	function nextFrame():Void {
		_mc.nextFrame();
	}
	function prevFrame():Void {
		_mc.prevFrame();
	}
	function gotoAndPlay(frame:Object):Void {
		_mc.gotoAndPlay(frame);
	}
	function gotoAndStop(frame:Object):Void {
		_mc.gotoAndStop(frame);
	}
	function duplicateMovieClip(name:String,depth:Number,initObject:Object):MovieClip {
		return _mc.duplicateMovieClip(name,depth,initObject);
	}
	function removeMovieClip():Void {
		_mc.removeMovieClip();
	}
	function startDrag(lockCenter:Boolean,left:Number,top:Number,right:Number,bottom:Number):Void {
		_mc.startDrag(lockCenter,left,top,right,bottom);
	}
	function stopDrag():Void {
		_mc.stopDrag();
	}
	function createEmptyMovieClip(name:String,depth:Number):MovieClip {
		return _mc.createEmptyMovieClip(name,depth);
	}
	function beginFill(rgb:Number,alpha:Number):Void {
		_mc.beginFill(rgb,alpha);
	}
	function beginGradientFill(fillType:String,colors:Array,alphas:Array,ratios:Array,matrix:Object):Void {
		_mc.beginGradientFill(fillType,colors,alphas,ratios,matrix);
	}
	function moveTo(x:Number,y:Number):Void {
		_mc.moveTo(x,y);
	}
	function lineTo(x:Number,y:Number):Void {
		_mc.lineTo(x,y);
	}
	function curveTo(controlX:Number,controlY:Number,anchorX:Number,anchorY:Number):Void {
		_mc.curveTo(controlX,controlY,anchorX,anchorY);
	}
	function lineStyle(thickness:Number,rgb:Number,alpha:Number):Void {
		_mc.lineStyle(thickness,rgb,alpha);
	}
	function endFill():Void {
		_mc.endFill();
	}
	function clear():Void {
		_mc.clear();
	}
	function createTextField(instanceName:String,depth:Number,x:Number,y:Number,width:Number,height:Number):Void {
		_mc.createTextField(instanceName,depth,x,y,width,height);
	}
	function getTextSnapshot():TextSnapshot {
		return _mc.getTextSnapshot();
	}

	/******* EVENTS *******/
	function get onData():Function { return _mc.onData; }
	function set onData(f:Function):Void { _mc.onData = function() { f.call(this.__o); } }
	function get onDragOut():Function { return _mc.onDragOut; }
	function set onDragOut(f:Function):Void { _mc.onDragOut = function() { f.call(this.__o); } }
	function get onDragOver():Function { return _mc.onDragOver; }
	function set onDragOver(f:Function):Void { _mc.onDragOver = function() { f.call(this.__o); } }
	function get onEnterFrame():Function { return _mc.onEnterFrame; }
	function set onEnterFrame(f:Function):Void {  _mc.onEnterFrame = function() { f.call(this.__o); } }
	/****Only as Key listener; not native to MovieClip****\
	function get onKeyDown():Function { return _mc.onKeyDown; }
	function set onKeyDown(f:Function):Void { _mc.onKeyDown = function() { f.call(this.__o); } }
	function get onKeyUp():Function { return _mc.onKeyUp; }
	function set onKeyUp(f:Function):Void { _mc.onKeyUp = function() { f.call(this.__o); } }
	\*****************************************************/
	function get onKillFocus():Function { return _mc.onKillFocus; }
	function set onKillFocus(f:Function):Void { _mc.onKillFocus = function(newFocus:Object) { f.call(this.__o,newFocus); } }
	function get onLoad():Function { return _mc.onLoad; }
	function set onLoad(f:Function):Void { _mc.onLoad = function() { f.call(this.__o); } }
	function get onMouseDown():Function { return _mc.onMouseDown; }
	function set onMouseDown(f:Function):Void { _mc.onMouseDown = function() { f.call(this.__o); } }
	function get onMouseMove():Function { return _mc.onMouseMove; }
	function set onMouseMove(f:Function):Void { _mc.onMouseMove = function() { f.call(this.__o); } }
	function get onMouseUp():Function { return _mc.onMouseUp; }
	function set onMouseUp(f:Function):Void { _mc.onMouseUp = function() { f.call(this.__o); } }
	function get onPress():Function { return _mc.onPress; }
	function set onPress(f:Function):Void { _mc.onPress = function() { f.call(this.__o); } }
	function get onRelease():Function { return _mc.onRelease; }
	function set onRelease(f:Function):Void { _mc.onRelease = function() { f.call(this.__o); } }
	function get onReleaseOutside():Function { return _mc.onReleaseOutside; }
	function set onReleaseOutside(f:Function):Void { _mc.onReleaseOutside = function() { f.call(this.__o); } }
	function get onRollOut():Function { return _mc.onRollOut; }
	function set onRollOut(f:Function):Void { _mc.onRollOut = function() { f.call(this.__o); } }
	function get onRollOver():Function { return _mc.onRollOver; }
	function set onRollOver(f:Function):Void { _mc.onRollOver = function() { f.call(this.__o); } }
	function get onSetFocus():Function { return _mc.onSetFocus; }
	function set onSetFocus(f:Function):Void { _mc.onSetFocus = function(oldFocus:Object) { f.call(this.__o,oldFocus); } }
	function get onUnload():Function { return _mc.onUnload; }
	function set onUnload(f:Function):Void { _mc.onUnload = function() { f.call(this.__o); } }
}