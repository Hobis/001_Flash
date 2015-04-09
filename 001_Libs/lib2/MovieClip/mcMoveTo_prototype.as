/* ######################################################################
	mcMoveTo_prototype
	code by : Kobalt60 - Jung Hee Bum
	date : 060504
	ex : 
		//mc.rotationMoveTo(0, 0, 82, 82, 0.3);
		this.onMouseDown = function() {
		 trace(_xmouse);
		 mc.elasticMoveTo(_xmouse, _ymouse, 0.78);
		};
	
	Comment : 무비클립을 움직이게 하는 프로토타입.
	※ 메서드와 프로토타입의 중복을 피하기 위하여 복사하여 사용
	하시기 바립니다.
###################################################################### */
/* =============================================================================
	- mcRotationMoveTo
	- ex : mc.mcRotationMoveTo(200, 100, 100, 100, 0.1);
============================================================================= */
MovieClip.prototype.mcRotationMoveTo = function(xN, yN, wN, hN, spN) {
	var tN = 0;
	this.onEnterFrame = function() {
		this._x = xN+wN*Math.cos(tN);
		this._y = yN+hN*Math.sin(tN);
		tN = tN+spN;
		trace(tN);
		if(tN > 5) {
			delete this.onEnterFrame
			trace("end");
			return;
		};
	};
};
/* =============================================================================
	- mcElasticMove
	- ex : mc.mcElasticMove(200, 200, 0.78);
============================================================================= */
MovieClip.prototype.mcElasticMove = function(txN, tyN, frN) {
	var iLoop = 1;
	var xrN = 0;
	var yrN = 0;
	var spN = 0.2;
	this.onEnterFrame = function() {
		if(iLoop > 50) {
			delete this.onEnterFrame;
			this._x = Math.round(this._x);
			this._y = Math.round(this._y);
			trace("Last : "+this._x);
			return;
		}
		xrN = frN*xrN+(txN-this._x)*spN;
		yrN = frN*yrN+(tyN-this._y)*spN;
		this._x = this._x+xrN;
		this._y = this._y+yrN;
		iLoop++;
		trace(this._x);
	};
};
/* =============================================================================
	- mcElasticScale
	- ex : mc.mcElasticScale(300, 300, 0.78);
============================================================================= */
// ---- 탄성스케일 -------------------------------------------- //
MovieClip.prototype.mcElasticScale = function(xsN, ysN, frN) {
	var iLoop = 1;
	var xrN = 0;
	var yrN = 0;
	var spN = 0.2;
	this.onEnterFrame = function() {
		if(iLoop > 50) {
			delete this.onEnterFrame;
			this._xscale = Math.round(this._xscale);
			this._yscale = Math.round(this._yscale);
			trace("Last this._xscale : "+this._xscale);
			trace("Last this._yscale : "+this._yscale);
			return;
		}
		xrN = frN*xrN+(xsN-this._xscale)*spN;
		yrN = frN*yrN+(ysN-this._yscale)*spN;
		this._xscale = this._xscale+xrN;
		this._yscale = this._yscale+yrN;
		iLoop++;
		//trace(this._xscale);
	};
};
/* =============================================================================
	- mcRotateTo
	- ex : mc.mcRotateTo(this._xmouse, this._ymouse);
============================================================================= */
MovieClip.prototype.mcRotateTo = function(targetx, targety) {
	var diffx = targetx-this._x;
	var diffy = targety-this._y;
	this._rotation = Math.atan2(diffy, diffx)*180/Math.PI;
};
/* =============================================================================
	- elasticMove
	- ex :
		var preP = 0;		
		mc.onEnterFrame = function() {
			//this.elaM(-0.9, 0.78, 0.2);
			this.elasticMove(400, 0.78, 0.2);
			//trace(eVal);
		};
============================================================================= */
MovieClip.prototype.elasticMove = function (tpn, friction, spNum) {
	if(Math.floor(this._x) == tpn) {
		this._x = tpn;
		preP = 0;
		trace("_x : "+this._x);
		trace("eVa;");
		delete this.onEnterFrame;
	} else {
		preP = preP * friction + (preP - this._x) * spNum;
		this._x = this._x + preP;
	}
	//trace(this._x);
	trace(preP);
};