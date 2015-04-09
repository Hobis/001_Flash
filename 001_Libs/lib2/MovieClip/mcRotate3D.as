/* #####################################################################
	mcRotate3D
	Written : Kobalt60 - Jung Hee Bum
	Date : 060515
	
	Comment : {		
		MovieClip 3D Rotate prototype
		※ 함수 중복을 피하기 위하여 #include보단 드래그 해서 사용하자.
		ex : 
			function mcRotate3D(tmc) {
				var cxN = 0;
				var cyN = 0;
				var czN = 0;
				var fN = 200;
				var tN = 0.05;
				tmc.xN = 0;
				tmc.yN = 0;
				tmc.zN = 100;
				tmc.onEnterFrame = function() {
					// - 마우스의 y좌표에 따라 회전할 각도 설정.
					//var xAngle = this._parent._ymouse/2000;
					//this.rotateX(xAngle, cyN, czN);
					// - x축을 중신으로 t만큼 회전.
					//this.rotateX(tN, cyN, czN);
					// - y축을 중신으로 t만큼 회전.
					this.rotateY(tN, czN, cxN);
					// - z축을 중신으로 t만큼 회전.
					//this.rotateZ(tN, cxN, cyN);
					// - 원근 효과가 나도록 plot3d 메서드 호출.
					this.plot3d(fN);
				};
			}
			mcRotate3D(circle_mc);
	}
##################################################################### */
/* ======================================================================
	x축 회전 메서드
====================================================================== */
MovieClip.prototype.rotateX = function(tN, cyN, czN) {
	var tempy = cyN+(this.yN-cyN)*Math.cos(tN)-(this.zN-czN)*Math.sin(tN);
	this.zN = czN+(this.yN-cyN)*Math.sin(tN)+(this.zN-czN)*Math.cos(tN);
	this.yN = tempy;
};
/* ======================================================================
	y축 회전 메서드
====================================================================== */
MovieClip.prototype.rotateY = function(tN, czN, cxN) {
	var tempz = czN+(this.zN-czN)*Math.cos(tN)-(this.xN-cxN)*Math.sin(tN);
	this.xN = cxN+(this.zN-czN)*Math.sin(tN)+(this.xN-cxN)*Math.cos(tN);
	this.zN = tempz;
};
/* ======================================================================
	z축 회전 메서드
====================================================================== */
MovieClip.prototype.rotateZ = function(tN, cxN, cyN) {
	var tempx = cxN+(this.xN-cxN)*Math.cos(tN)-(this.yN-cyN)*Math.sin(tN);
	this.yN = cyN+(this.xN-cxN)*Math.sin(tN)+(this.yN-cyN)*Math.cos(tN);
	this.xN = tempx;
};
/* ======================================================================
	3d 원근 표시 메서드
====================================================================== */
MovieClip.prototype.plot3d = function(fN, vP) {
	// - z좌표가 -f보다 작으면 무비클립이 보이지 않게 함.
	if(this.zN <- fN) {
		this._visible = false;
	} else {
		this._visible = true;
		// - z값에 따른 scale값을 구함.
		var scaleN = fN/(fN+this.zN);
		this._xscale = this._yscale = scaleN*100;
		// - 회전한 좌표를 무비클립 속성으로 설정.
		this._x = this.xN*scaleN;
		this._y = this.yN*scaleN - vP*this.zN;
		// z값에 따른 depths 설정.
		this.swapDepths(50000-100*this.zN);
	}
};
/* ======================================================================
	원운동할때 특정각도 고정.
====================================================================== */
MovieClip.prototype.rotateTo = function(tX, tY) {
	var diffX = tX-this._x;
	var diffY = tY-this._y;
	this._rotation = Math.atan2(diffY, diffX)*180/Math.PI;
};






































/*
// EX : mc.mcRotateY(200, 100);
MovieClip.prototype.mcRotateY = function(fN, zN) {
	var cxN = 0;
	var cyN = 0;
	var czN = 0;
	var tN = 0.05;
	this.xN = 0;
	this.yN = 0;
	this.zN = zN;
	this.onEnterFrame = function() {
		var xAngle = this._parent._xmouse/2000;
		this.rotateY(xAngle, czN, cxN);
		this.plot3d(fN);
	};
};
// EX : mc.mcRotateX(200, 100);
MovieClip.prototype.mcRotateX = function(fN, zN) {
	var cxN = 0;
	var cyN = 0;
	var czN = 0;
	var tN = 0.05;
	this.xN = 0;
	this.yN = 0;
	this.zN = zN;
	this.onEnterFrame = function() {
		var yAngle = this._parent._ymouse/2000;
		this.rotateX(yAngle, cyN, czN);
		this.plot3d(fN);
	};
};
// EX : mc.mcRotateX(200, 100);
MovieClip.prototype.mcRotateZ = function(fN, xyN) {
	var cxN = 0;
	var cyN = 0;
	var czN = 0;
	var tN = 0.05;
	this.xN = xyN;
	this.yN = xyN;
	this.zN = 0;
	this.onEnterFrame = function() {
		var xAngle = this._parent._xmouse/100;
		this.rotateZ(xAngle, cxN, cyN);
		this.plot3d(fN);
	};
};
*/