/* =============================================================
	Driller Ver .1b
	code by :: jhb0b [jhb0b@naver.com]
	date :: 070129
	ps :: {
		아직까지 mc의 영역안의 자표에서만 로테이션 된다.
		이상하게 _ymouse가 음수일때 위치 오류가 발생하는데...
		아직 잘 모르겠다. ㅠㅠ
	}
============================================================= */
_global.$Driller = function(tmc):Void {
	this.init(tmc);
};

$Driller.prototype.init = function(tmc):Void 
{
	
	this.mc = tmc;
	
	this.yet_x = this.mc._x;
	this.yet_y = this.mc._y;
	this.yet_r = this.mc._rotation;
	
	this.tx = this.mc._x;
	this.ty = this.mc._y;
	
	this.tr = this.mc._rotation;
	//this.tw = this.mc._width;
	//this.th = this.mc._height;
	//
	this.cx = 0, this.cy = 0;
	this.distance = 0;
	this.px = 0, this.py = 0;
	
	this.firstRadian = 0;
	//
	this.rx = 0, this.ry = 0;
	//
	//////////////////////////////////////////////////////////////////
	// - Mouse Wheel 
	this.nowRadian = (this.tr/180)*Math.PI;
	//////////////////////////////////////////////////////////////////
	
	
	this.localPos = {x:0, y:0};
	
};

//$Driller.prototype.setPosition = function(x, y, x1, y1):Void 
$Driller.prototype.setPosition = function(x, y):Void 
{
	
	trace([x, y, x1, y1]);
	
	this.rx = x;
	this.ry = y;
	//this.cx = x1;
	//this.cy = y1;
	//this.cx = this.rx-this.tx;
	//this.cy = this.ry-this.ty;
	
	// ++++++++++++++++++++++++++++++++++++++
	//	globalToLocal로 처리
	// ++++++++++++++++++++++++++++++++++++++
	this.localPos.x = this.rx;
	this.localPos.y = this.ry;
	this.mc.globalToLocal(this.localPos);
	this.cx = this.localPos.x;
	this.cy = this.localPos.y;
	// ++++++++++++++++++++++++++++++++++++++
	
	//this.distance = Math.sqrt(Math.pow(this.cx, 2)+Math.pow(this.cy, 2));
	this.distance = Math.sqrt(this.cx*this.cx+this.cy*this.cy);
	
	trace('● this.distance :: '+this.distance);
	
	var tempRad:Number = (this.cy == 0) ? 0 : Math.atan(this.cx/this.cy);
	
	this.firstRadian = -(tempRad+(Math.PI/2));
	//this.firstRadian = -0.254368058553266
	
	trace('● this.firstRadian :: '+this.firstRadian);
	
};

$Driller.prototype.rotate = function(radian):Void 
{
	
	this.nowRadian = this.nowRadian+radian;
	
	this.tr = (this.nowRadian*180)/Math.PI;
	
	this.circleMove(this.nowRadian);
	this.ok();
	
};

$Driller.prototype.circleMove = function(radian):Void 
{
	
	this.px = this.distance*Math.cos(radian+this.firstRadian);
	this.py = this.distance*Math.sin(radian+this.firstRadian);
	if(this.cy<0) {
		this.px = this.px*-1;
		this.py = this.py*-1;
	}
	this.tx = this.px+this.rx;
	this.ty = this.py+this.ry;
	
	trace('● this.tx, this.ty :: '+[this.tx, this.ty]);
	trace('● this.px, this.py :: '+[this.px, this.py]);
	
};
$Driller.prototype.ok = function():Void {
	
	this.mc._rotation = this.tr;
	
	// - 타겟mc 위치 설정
	this.mc._x = this.tx;
	this.mc._y = this.ty;	
	
};

$Driller.prototype.firstInit = function():Void {
	
	this.mc._x = this.yet_x;
	this.mc._y = this.yet_y;
	this.mc._rotation = this.yet_r;
	
};