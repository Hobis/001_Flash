/*  =============================================================
	Object Smooth Move Class Ver 1.0
	Code By : jung hee bum [http://blog.naver.com/jhb0b]
	Date : 061030
	
	EX :

============================================================= */
_global.$SMove = function():Void {};
//
// - "Prop"
$SMove.moveTo = function(tmc:MovieClip, prop:String, cpN:Number, spN:Number):Void {
	tmc.onEnterFrame = function() {
		if(Math.round(this[prop]) == cpN) {
			delete this.onEnterFrame;
			this[prop] = cpN;
			//trace("Last : "+this[prop]);
			return;
		}
		this[prop] = this[prop]+((cpN-this[prop])*spN);
		//trace(this[prop]);
	}	
};
//
// - XY Move
$SMove.moveToXY = function(tmc:MovieClip, cpNX:Number, cpNY:Number, spN:Number):Void {
	tmc.onEnterFrame = function() {
		if(Math.round(this._x) == cpNX && Math.round(this._y) == cpNY) {
			delete this.onEnterFrame;
			this._x = cpNX;
			this._y = cpNY;
			//trace("Last _x : "+this._x);
			//trace("Last _y : "+this._y);
			return;
		}
		this._x = this._x+((cpNX-this._x)*spN);
		this._y = this._y+((cpNY-this._y)*spN);
	}
};
//
// - XY ArcMove
$SMove.arcMoveToXY = function(tmc:MovieClip, cpNX:Number, cpNY:Number, xys:String, spN:Number):Void {
	var tempNum:Number = tmc[xys];
	var xcpNYS:String = (xys == "_x") ? (cpNX) : ((xys=="_y") ? (cpNY) : (null));
	if(xys == "_x") {
		tmc.onEnterFrame = function() {
			if(Math.round(this._x) == cpNX && Math.round(this._y) == cpNY) {
				delete this.onEnterFrame;
				this._x = cpNX;
				this._y = cpNY;
				trace("Last _x : "+this._x);
				trace("Last _y : "+this._y);
				return true;
			}
			tempNum = tempNum+((xcpNYS-tempNum)*spN);
			this._x = this._x+((tempNum-this._x)*spN);
			this._y = this._y+((cpNY-this._y)*spN);
		};
	} else if(xys == "_y") {
		mc.onEnterFrame = function() {
			if(Math.round(this._x) == cpNX && Math.round(this._y) == cpNY) {
				delete this.onEnterFrame;
				this._x = cpNX;
				this._y = cpNY;
				trace("Last _x : "+this._x);
				trace("Last _y : "+this._y);
				return true;
			}
			tempNum = tempNum+((xcpNYS-tempNum)*spN);
			this._x = this._x+((cpNX-this._x)*spN);
			this._y = this._y+((tempNum-this._y)*spN);
		};
	}//end if
};