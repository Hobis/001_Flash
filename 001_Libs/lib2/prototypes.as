/* ######################################################
	@ name : prototype functions
	@ author : jungheebum
	@ date : 070509
##################################################### */

/* ++++++++++++++++++++++++++++++++++++++++++++++++++
	Color FadeTo Method ColorObject Version
	ex : mc.hbColorFadeTo(colorHexTo:Number, durationFPS:Number);
++++++++++++++++++++++++++++++++++++++++++++++++++ */
MovieClip.prototype.hb_colorFadeTo = function(hexTo:Number, drN:Number):Void {
	// - Color : 0 ~16777215
	var _colorFrom:Object, _colorTo:Object;
	var _remains:Number, _total:Number;
	var t:Number;
	var myColor:Color = new Color(this);
	var bRGB:Number = myColor.getRGB();
	//
	_colorFrom = {r:bRGB>>16, g:(bRGB >> 8)&0xff, b:bRGB&0xff, hex:bRGB};
	_colorTo = {r:hexTo>>16, g:(hexTo >> 8)&0xff, b:hexTo&0xff, hex:hexTo};
	_remains = _total = drN;

	this.onEnterFrame = function() {
		if(!_remains) {
			myColor.setRGB(_colorTo.hex);
			delete this.onEnterFrame;
			return;
		}
		_remains--;
		t = 1 - _remains/_total;
		myColor.setRGB(
			(_colorFrom.r+(_colorTo.r-_colorFrom.r)*t) << 16 |
			(_colorFrom.g+(_colorTo.g-_colorFrom.g)*t) << 8 |
			(_colorFrom.b+(_colorTo.b-_colorFrom.b)*t)
		);

		//trace(t);
	};
};


MovieClip.prototype.hb_frameToC = function(fn:Number, co:Object):Void {
	if(fn == undefined || fn == this._currentframe) return;
	if(fn <= 0) return;
	if(fn > this._currentframe) var tfn:Number = 1;
	else if(fn < this._currentframe) var tfn:Number = -1;
	this.onEnterFrame = function() {
		if(this._currentframe == fn) {
			delete this.onEnterFrame;
			if(co != undefined) co.func.apply(co.scope, co.arg);
			trace("¡Ü frameToC Last Frame :: "+this._currentframe);
			return;
		}
		this.gotoAndStop(this._currentframe+tfn);
	};
};


MovieClip.prototype.hb_frameOOC = function(type:String, co:Object):Void {
	if(type == "over") {
		var ef:Function = function() {
			if(this._currentframe >= this._totalframes) {
				delete this.onEnterFrame;
				if(co != undefined) co.func.apply(co.scope, co.arg);
				return;
			}
			this.nextFrame();
		};
	} else if(type == "out") {
		var ef:Function = function() {
			if(this._currentframe <= 1) {
				delete this.onEnterFrame;
				if(co != undefined) co.func.apply(co.scope, co.arg);
				return;
			}
			this.prevFrame();
		};
	}
	this.onEnterFrame = ef;
};


MovieClip.prototype.hb_frameOO = function(type:String):Void {
	if(type == "over") {
		var ef:Function = function() {
			if(this._currentframe >= this._totalframes) {
				delete this.onEnterFrame;
				return;
			}
			this.nextFrame();
		};
	} else if(type == "out") {
		var ef:Function = function() {
			if(this._currentframe <= 1) {
				delete this.onEnterFrame;
				return;
			}
			this.prevFrame();
		};
	}
	this.onEnterFrame = ef;
};


MovieClip.prototype.hb_fadeIOCTo = function(mode:String, num:Number, cpN:Number, co:Object):Void {
	var transN:Number = (num == undefined) ? 4 : num;
	if(mode == "out") {
		this.onEnterFrame = function() {
			if(this._alpha <= cpN) {
				delete this.onEnterFrame;
				this._alpha = cpN;
				if(co != undefined) {
						co.func.apply(co.scope, co.arg);
				}
				trace("Last : "+this._alpha);
				return;
			}
			this._alpha = this._alpha-transN;
		};
	} else if(mode == "in") {
		this.onEnterFrame = function() {
			if(this._alpha >= cpN) {
				delete this.onEnterFrame;
				this._alpha = cpN;
				if(co != undefined) {
						co.func.apply(co.scope, co.arg);
				}
				trace("Last : "+this._alpha);
				return;
			}
			this._alpha = this._alpha+transN;
		};
	}
};


MovieClip.prototype.hb_fadeIOC = function(mode:String, num:Number, co:Object):Void {
        if(mode == "out") {
                this.onEnterFrame = function() {
                        if(this._alpha < num) {
                                delete this.onEnterFrame;
                                this._alpha = 0;
                                this._visible = false;
                                if(co != undefined) {
                                        co.func.apply(co.scope, co.arg);
                                }
                                return;
                        }
                        this._alpha -= num;
                };
        } else if(mode == "in") {
                if(!this._visible) this._visible = true;
                var toNum:Number = 100 - num;
                this.onEnterFrame = function() {
                        if(this._alpha > toNum) {
                                delete this.onEnterFrame;
                                this._alpha = 100;
                                if(co != undefined) {
                                        co.func.apply(co.scope, co.arg);
                                }
                                return;
                        }
                        this._alpha += num;
                };
        }//end if
};


MovieClip.prototype.hb_smoothToC = function(prop, cpN, spN, co):Void {
	this.onEnterFrame = function() {
		if(Math.round(this[prop]) == cpN) {
			delete this.onEnterFrame;
			this[prop] = cpN;
			if(co != undefined) co.func.apply(co.scope, co.arg);
			trace("¡Ü smoothToC Last :: "+this[prop]);
			return;
		}
		this[prop] = this[prop]+((cpN-this[prop])*spN);
	}
};