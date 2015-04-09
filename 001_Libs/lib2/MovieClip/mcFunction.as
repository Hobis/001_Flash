/* ######################################################################
	MovieClip Function
	code by : Jung Hee Bum
	date : 060523
###################################################################### */
/* =================================================================
	- 무비클립 부드러운 이동 단방향
================================================================= */
function sMoveTo(mc, xyP, num, spNum) {
	mc.onEnterFrame = function() {
		if(Math.round(this[xyP]) == num) {
			delete this.onEnterFrame;
			this[xyP] = num;
			trace("Last : "+this[xyP]);
			return true;
		}
		this[xyP] = this[xyP]+((num-this[xyP])*spNum);
		//trace(this[xyP]);
	}	
}//end function
/* =================================================================
	- 무비클립 부드러운 XY 이동
================================================================= */
function sMoveToXY(mc, xnum, ynum, spNum) {
	mc.onEnterFrame = function() {
		if(Math.round(this._x) == xnum && Math.round(this._y) == ynum) {
			delete this.onEnterFrame;
			this._x = xnum;
			this._y = ynum;
			trace("Last _x : "+this._x);
			trace("Last _y : "+this._y);
			return true;
		}
		this._x = this._x+((xnum-this._x)*spNum);
		this._y = this._y+((ynum-this._y)*spNum);
	}
}//end function
/* =================================================================
	- 무비클립 부드러운 이동 단방향 (곡선이동)
	- ex : sArcMoveToXY(mc, 300, 300, "_x", 0.3);
================================================================= */
function sArcMoveToXY(mc, xnum, ynum, xyS, spNum) {
	var ratioNum = mc[xyS];
	var xyNumS = xyS=="_x" ? (xnum) : (xyS=="_y" ? (ynum) : (null));
	if(xyS == "_x") {
		mc.onEnterFrame = function() {
			if(Math.round(this._x) == xnum && Math.round(this._y) == ynum) {
				delete this.onEnterFrame;
				this._x = xnum;
				this._y = ynum;
				trace("Last _x : "+this._x);
				trace("Last _y : "+this._y);
				return true;
			}
			ratioNum = ratioNum+((xyNumS-ratioNum)*spNum);
			this._x = this._x+((ratioNum-this._x)*spNum);
			this._y = this._y+((ynum-this._y)*spNum);
		};
	} else if(xyS == "_y") {
		mc.onEnterFrame = function() {
			if(Math.round(this._x) == xnum && Math.round(this._y) == ynum) {
				delete this.onEnterFrame;
				this._x = xnum;
				this._y = ynum;
				trace("Last _x : "+this._x);
				trace("Last _y : "+this._y);
				return true;
			}
			ratioNum = ratioNum+((xyNumS-ratioNum)*spNum);
			this._x = this._x+((xnum-this._x)*spNum);
			this._y = this._y+((ratioNum-this._y)*spNum);
		};
	}//end if
}//end function
/* =================================================================
	- 무비클립 패이드 아웃 (알파 빠짐)
	- ex : mcFadeOut(mc, 10)
================================================================= */
function mcFadeOut(mc, num) {
	mc.onEnterFrame = function() {
		if(this._alpha > num) this._alpha -= num;
		else {
			delete this.onEnterFrame;
			this._alpha = 0;
			this._visible = false;
			trace("Last : "+this._visible);
		}//end if
	};
}//end function
/* =================================================================
	- 무비클립 패이드 인 (알파 들어감)
	- ex : mcFadeIn(mc, 10)
================================================================= */
function mcFadeIn(mc, num) {
	var toNum = 100 - num;
	mc.onEnterFrame = function() {
		if(this._visible == false) this._visible = true;
		if(this._alpha < toNum) this._alpha += num;
		else {
			delete this.onEnterFrame;
			this._alpha = 100;
			trace("Last : "+this._visible);
		}//end if
	};
}//end function
/* =================================================================
	- 무비클립 프래임 끝으로.
	- ex : mcFrameOver(mc)
================================================================= */
function mcFrameOver(mc) {
	var doat = mc._currentframe;
	mc.onEnterFrame = function() {
		if(doat == this._totalframes) {
			delete this.onEnterFrame;
			trace("Last : "+doat);
			return true;
		}
		doat = doat + 1;
		this.gotoAndStop(doat);
	};
}//end function
/* =================================================================
	- 무비클립 프래임 처음으로.
	- ex : mcFrameOut(mc)
================================================================= */
function mcFrameOut(mc) {
	var doat = mc._currentframe;
	mc.onEnterFrame = function() {
		if(doat == 1) {
			delete this.onEnterFrame;	
			trace("Last : "+doat);
			return true;
		}
		doat = doat - 1;
		this.gotoAndStop(doat);
	};		
}//end function
/* =================================================================
	- 무비클립 프래임 끝으로.
	- ex : mcFrameNext(mc)
================================================================= */
function mcFrameNext(mc) {
	mc.onEnterFrame = function() {
		if(mc._currentframe == mc._totalframes) {
			delete this.onEnterFrame;
			trace("Last Frame : "+mc._currentframe);
			return true;
		}
		mc.nextFrame();
	};
}
/* =================================================================
	- 무비클립 프래임 처음으로.
	- ex : mcFramePrev(mc)
================================================================= */
function mcFramePrev(mc) {
	mc.onEnterFrame = function() {
		if(mc._currentframe == 1) {
			delete this.onEnterFrame;
			trace("Last Frame : "+mc._currentframe);
			return true;
		}
		mc.prevFrame();
	};
}
/* =================================================================
	- 무비클립 특정 프래임으로 이동.
	- ex : mcFrameGoto(mc, 30);
================================================================= */
function mcFrameGoto(mc, fn) {
	var doat = mc._currentframe;
	if(doat < fn) var pm = 1;
	else if(doat > fn) var pm = -1;
	mc.onEnterFrame = function() {
		if(doat == fn) {
			delete this.onEnterFrame;	
			trace("Last : "+doat);
			return true;
		}
		doat = doat + pm;
		this.gotoAndStop(doat);
	};		
}//end function
/* =============================================================================
	MovieClip Loading Processing
	
	- 주의 !! 메인무비의 첫번째 프래임에서는 프리로딩이 걸리지 않는다.
	- ex) mcLoadProcs(target_mc);
============================================================================= */
function mcLoadProcs(tmc) {
	var firstN = tmc.getBytesTotal();
	var totalN = 0, nowN = 0, perN = 0;
	var interID = setInterval(function() {
		if(nowN >= totalN && nowN > firstN) {
			clearInterval(interID);
			trace("Last :: "+perN);
			load_p._visible = false;
			return true;
		}
		totalN = tmc.getBytesTotal();
		nowN = tmc.getBytesLoaded();
		perN = Math.round((nowN/totalN)*100);
		// - 로딩과정에 필요한 무비클립 연결
		//this.loader.bar._xscale = this.percent;
		//this.loader.parcent.text = this.percent + "%";
		if(nowN > firstN) load_p.gotoAndStop(perN);
		trace("Ing :: "+perN);
	}, 100)
}//end function
function mcLoader(tmc:MovieClip, mcStr:String):Void {
	tmc.loadMovie(mcStr);
	mcLoadProcs(tmc);
}
/*
function mcLoadProcs(tmc) {
	var bef_mc = this.createEmptyMovieClip("_bef_mc", 995693);
	var firstN = tmc.getBytesTotal();
	var totalN = 0, nowN = 0, perN = 0;
	bef_mc.onEnterFrame = function() {
		if(nowN >= totalN && nowN > firstN) {
			delete this.onEnterFrame;
			trace("Last :: "+perN);
			load_p._visible = false;
			this.removeMovieClip();
			return true;
		}
		totalN = tmc.getBytesTotal();
		nowN = tmc.getBytesLoaded();
		perN = Math.round((nowN/totalN)*100);
		// - 로딩과정에 필요한 무비클립 연결
		//this.loader.bar._xscale = this.percent;
		//this.loader.parcent.text = this.percent + "%";
		load_p.gotoAndStop(perN);
		trace("Ing :: "+perN);
	};
}//end function
*/
/* ============================================================== */

/* =================================================================
	- 무비클립 패이드 인 (알파빠짐)
	- ex : mcFadeOut(mc, 10)
================================================================= */
MovieClip.prototype.mcFadeOut = function(num) {
	this.onEnterFrame = function() {
		if(this._alpha > num) this._alpha -= num;
		else {
			delete this.onEnterFrame;
			this._alpha = 0;
			this._visible = false;
			trace("Last : "+this._visible);
		}//end if
	};
};//end function
/* =================================================================
	- 무비클립 패이드 인 (알파 들어감)
	- ex : mcFadeIn(mc, 10)
================================================================= */
MovieClip.prototype.mcFadeIn = function(num) {
	var toNum = 100 - num;
	this.onEnterFrame = function() {
		if(this._visible == false) this._visible = true;
		if(this._alpha < toNum) this._alpha += num;
		else {
			delete this.onEnterFrame;
			this._alpha = 100;
			trace("Last : "+this._visible);
		}//end if
	};
};//end function
/* =================================================================
	- 무비클립 프래임 끝으로.
	- ex : mcFrameNext(mc)
================================================================= */
MovieClip.prototype.mcFrameNext = function() {
	this.onEnterFrame = function() {
		if(this._currentframe == this._totalframes) {
			delete this.onEnterFrame;
			trace("Last Frame : "+this._currentframe);
			return true;
		}
		this.nextFrame();
	};
};
/* =================================================================
	- 무비클립 프래임 처음으로.
	- ex : mcFramePrev(mc)
================================================================= */
MovieClip.prototype.mcFramePrev = function() {
	this.onEnterFrame = function() {
		if(this._currentframe == 1) {
			delete this.onEnterFrame;
			trace("Last Frame : "+this._currentframe);
			return true;
		}
		this.prevFrame();
	};
};
MovieClip.prototype.mcWidthTo = function(num) {
	this.onEnterFrame = function() {
		if(Math.round(this._width) == num) {
			delete this.onEnterFrame;
			this._width = num;
			trace("Last Frame : "+this._width);
			return true;
		}
		this._width += (num-this._width)*0.2;
		//trace("ING : "+this._width);
	};
};