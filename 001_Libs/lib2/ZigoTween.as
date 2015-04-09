/*  =============================================================
	ZigoTween Ver 0.1b
	Code By : jhb0b [http://blog.naver.com/jhb0b]
	Code Assistance By : {
		class tweenManager for tweening prototypes
		version 1.2.0
		Ladislav Zigo,lacoz@web.de
		Moses Gunesch
	}
	Date : 061218
	
	EX :

			#include "com/ZigoTween.as"
			//
			var easeOutQuad = function (t, b, c, d) {
				return -c*(t/=d)*(t-2)+b;
			};
			var myZT:Object = new $ZigoTween();
			myZT.tween(rect_mc, "_x", easeOutQuad, 0, 400, 30, null);
			myZT.tween(rect_mc, "_y", easeOutQuad, 0, 300, 120, null);
			this.onMouseDown = function() {
				myZT.tween(rect_mc, "_x", easeOutQuad, 0, 400, 30, null);
			};

============================================================= */
_global.$ZigoTween = function() {
	this.init();
};
$ZigoTween.prototype.init = function():Void {
	if(_root.__bef_mc) {
		//trace("Only Single Instance");
		return;
	}
	// : Blank EnterFrame MovieClip
	this._bef_mc = null;
	// : Propertie Array
	this._propArr = [];
	//
	// ------------------------------------------------------------------------ //
	this.made_bef_mc();
};
$ZigoTween.prototype.made_bef_mc = function():Void {
	this._bef_mc = _root.createEmptyMovieClip("__bef_mc", 989999);
};
$ZigoTween.prototype.made_ef = function():Void {
	var owner = this;
	this._bef_mc.onEnterFrame = function() {
		owner.process();
	};
};
$ZigoTween.prototype.delete_ef = function():Void {
	delete this._bef_mc.onEnterFrame;
};
$ZigoTween.prototype.reSet = function():Void {
// :: Prototype Object Reset //
	delete this._bef_mc.onEnterFrame;
	this._bef_mc.removeMovieClip();
	this._bef_mc = null;
	this._propArr = [];
};
$ZigoTween.prototype.tween_ = function(to, prop, func, cpN, drN, co):Void {
	this.tween(to, prop, func, to[prop], cpN, drN, co);
};
$ZigoTween.prototype.tween = function(to, prop, func, bpN, cpN, drN, co):Void {
// :: AddTween Start //
	if(arguments.length == undefined) {
		//trace("Parameter miss match");
		return;
	}
	if(!this._bef_mc.onEnterFrame) {
		//trace("is EnterFrame ? :: "+this._bef_mc.onEnterFrame);;
		this.made_ef();
	}
	if(this.isFloat(cpN)) cpN = Math.round(cpN);
	// --------------------------------------------------- //
	//	Override Chacking...
	// --------------------------------------------------- //
	var tempMN:Number = this.matchFinder(to, prop);
	//
	if(tempMN != -1) {
		this._propArr[tempMN] = {
			_timeN:0, 
			_to:to,
			_prop:prop,
			_func:func, 
			_bpN:bpN, 
			_cpN:(cpN-bpN), 
			_drN:drN, 
			_co:co
		};		
	} else {
		this._propArr.push({
			_timeN:0, 
			_to:to,
			_prop:prop, 
			_func:func, 
			_bpN:bpN, 
			_cpN:(cpN-bpN), 
			_drN:drN, 
			_co:co
		});
	}
	// --------------------------------------------------- //
};
$ZigoTween.prototype.setPosition = function(tObj:Object):Number {
	with(tObj) {
		return _func(_timeN, _bpN, _cpN, _drN);
	}
};
$ZigoTween.prototype.process = function():Void {
	if(!this._propArr.length) {
		this.delete_ef();
		return;
	}
	var tObj:Object;
	for(var i:Number=0;i<this._propArr.length;i++) {
		
		tObj = this._propArr[i];
		
		with(tObj) {
			if(_timeN>_drN) {
				this._propArr.splice(i, 1)				
				if(_co != undefined) {
					_co.func.apply(_co.scope, _co.arg);
				}
				//trace("Last : "+_to[_prop]);
				return;
			}		
			_to[_prop] = _func(_timeN, _bpN, _cpN, _drN);
			_timeN++;
		}//end with
		//
		
		//trace("Ing : "+tObj._to[tObj._prop]);
	}//end for
	//
};//end function
$ZigoTween.prototype.isFloat = function(n):Boolean {	
	if((n%1) != 0) return true;
	else return false;
};
$ZigoTween.prototype.matchFinder = function(to, prop):Number {	
	for(var i:Number=0;i<this._propArr.length;i++) {
		//trace(this._propArr[i]._prop == prop);
		if(this._propArr[i]._to == to && this._propArr[i]._prop == prop) {
			return i;
		}
	}
	// - not Maching~ -1을 리턴한다.	
	return -1;
};