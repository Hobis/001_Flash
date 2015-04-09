/* ######################################################
	@ name : MovieClip Motions
	@ author : jungheebum
	@ date : 070509
##################################################### */
_global.$MM = function() {};
$MM.frameNext = function(mc:MovieClip):Void {
	mc.onEnterFrame = function() {
		if(mc._currentframe == mc._totalframes) {
			delete this.onEnterFrame;
			//trace("Last Frame : "+mc._currentframe);
			return true;
		}
		mc.nextFrame();
	};
};
$MM.framePrev = function(mc:MovieClip):Void {
	mc.onEnterFrame = function() {
		if(mc._currentframe == 1) {
			delete this.onEnterFrame;
			//trace("Last Frame : "+mc._currentframe);
			return true;
		}
		mc.prevFrame();
	};
};
$MM.frameTo = function(mc:MovieClip, fn:Number):Void {
	if(fn == undefind || fn == mc._currentframe) return;
	if(fn <= 0) return;
	if(fn > mc._currentframe) var tfn:Number = 1;
	else if(fn < mc._currentframe) var tfn:Number = -1;
	//
	mc.onEnterFrame = function() {
		if(mc._currentframe == fn) {
			delete this.onEnterFrame;
			//trace("Last Frame : "+this._currentframe);
			return true;
		}
		this.gotoAndStop(this._currentframe+tfn);
	};
};
$MM.fadeOut = function(mc:MovieClip, num:Number):Void {
	mc.onEnterFrame = function() {
		if(this._alpha <= num) {
			delete this.onEnterFrame;
			this._alpha = 0;
			this._visible = false;
			//trace("Last : "+this._visible);
		}//end if
		this._alpha -= num;
	};
};
$MM.fadeIn = function(mc:MovieClip, num:Number):Void {
	var toNum:Number = 100-num;
	if(!mc._visible) mc._visible = true;
	mc.onEnterFrame = function() {
		if(this._alpha >= toNum) {
			delete this.onEnterFrame;
			this._alpha = 100;
			//trace("Last : "+this._visible);
		}//end if
		this._alpha += num;
	};
};
$MM.alphaDownTo = function(mc:MovieClip, num:Number):Void {
	var transAlphaNum:Number = (arguments[2] == undefined) ? 4 : arguments[2];
	mc.onEnterFrame = function() {
		if(this._alpha <= num) {
			delete this.onEnterFrame;
			this._alpha = num;
			trace("Last : "+this._alpha);
		}
		this._alpha -= transAlphaNum;
	};
};
$MM.alphaUpTo = function(mc:MovieClip, num:Number):Void {
	var transAlphaNum:Number = (arguments[2] == undefined) ? 4 : arguments[2];
	mc.onEnterFrame = function() {
		if(this._alpha >= num) {
			delete this.onEnterFrame;
			this._alpha = num;
			trace("Last : "+this._alpha);
		}
		this._alpha += transAlphaNum;
	};
};
ASSetPropFlags(_global, "$MM", 1, 0);