/* =================================================================
	Compact Tween Prototype Object
	Recode By : jhb0b@naver.com [061218]
	
	- Event  
	
			onTweenStart : 처음실행할때 발생.			
			onTweenUpdate : 실행중 계속 발생.			
			onTweenEnd : 실행이 끝나면 발생.

	- EX		
	
			#include "com/Tween.as"
			// --------------------------- //
			#include "com/easing.as"
			// --------------------------- //
			
			var myTween:Object = new $Tween(mc, "_x", $Ease.easeOutElastic, 0, 400, 30);
			myTween.onTweenEnd = function(to:Object) {
				delete this.onTweenEnd;
				this._begin = 0;
				this._prop = "_y";
				this.change = 300;
				this.start();	
			};
			
================================================================= */
// ------------------------------------------------------------------------------------------------- //
//#include "easing.as"
// ------------------------------------------------------------------------------------------------- //
_global.$Tween = function(to, prop, func, bpN, cpN, drN):Void {
	if(!arguments.length) return;
	this.init(to, prop, func, bpN, cpN, drN);
};
/***
*	to : Target Object
*	prop : Properties
*	func : Easing
*	bpN : Start Point
*	cpN : Change Point
*	dpN : Duration Number(fps)
*
***/
$Tween.prototype.init = function(to, prop, func, bpN, cpN, drN):Void {
	// -- enterFrame
	this.init_ef();
	//
	this._time = 0, this._obj = to, this._prop = prop, this._begin = bpN;
	this.change = 0;
	//
	this.setPosition(this._begin);
	this._duration = drN;
	if(func) this._func = func;
	else this._func = function(t, b, c, d) {return c*t/d+b;};
	// - 변화값.
	this.change = cpN - this._begin;
	this._listeners = [];
	this.addListener(this);
	// - auto start Not
	this.start();
};
//
$Tween.prototype.init_ef = function():Void {
	if(!_root.__bef_mc) {
		_global.$MovieClip = {};
		ASSetPropFlags(_global, "$MovieClip", 5, 0);
		AsBroadcaster.initialize(_global.$MovieClip);
		var mc:MovieClip = _root.createEmptyMovieClip("__bef_mc", 999898);
		mc.onEnterFrame = function() {
			_global.$MovieClip.broadcastMessage("onEnterFrame");
		};
	}
};
$Tween.prototype.unabled_ef = function():Void {
	delete _root.__bef_mc.onEnterFrame;
	delete _root.__bef_mc;
	delete _global.$MovieClip
};
//
$Tween.prototype.setPosition = function(pn:Number):Void {
	this._obj[this._prop] = pn;
	//this.broadcastMessage("onTweenUpdate", this, pn);
	this.onTweenUpdate(this._obj, pn);
	//trace("onTweenUpdate");
	//updateAfterEvent();
};
//
$Tween.prototype.getPosition = function(t:Number):Number {
	if(t == undefined) t = this._time;
	return this._func(t, this._begin, this.change, this._duration);
};
//
$Tween.prototype.start = function():Void {
	this._time = 0;
	_global.$MovieClip.addListener(this);
	//this.broadcastMessage("onTweenStart", this);
	this.onTweenStart(this._obj);
	//trace("onTweenStart");
};
//
$Tween.prototype.stop = function():Void {
	_global.$MovieClip.removeListener(this);
	//this.broadcastMessage("onTweenEnd", this);
	this.onTweenEnd(this._obj);
	//trace("onTweenEnd");
};
//
$Tween.prototype.onEnterFrame = function():Void {
	if(this._time >= this._duration) {
		this.stop();
		return;
	}
	this._time++;
	this.setPosition(this.getPosition(this._time));
};
//
ASSetPropFlags(_global, "$Tween", 7, true);
_global.$tweenGo = function(obj, prop, func, cpN, drN):Void {
	new _global.$Tween(obj, prop, func, obj[prop], cpN, drN);
};
ASSetPropFlags(_global, "$tweenGo", 7, true);
//AsBroadcaster.initialize(_global.$Tween.prototype);

/* -- using
	this.onMouseDown = function() {
		$tweenGo(circle_mc, "_x", $myTween.easeInQuad, this._xmouse, 40);
		$tweenGo(circle_mc, "_y", $myTween.easeInQuad, this._ymouse, 40);
	};
*/