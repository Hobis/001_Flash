/*  =============================================================
	Object Smooth Move Manager Class Ver 1.0
	Code By : jung hee bum [http://blog.naver.com/jhb0b]
	Date : 061015
	
	EX :
			var mySMM:Object = new $SMM();
			mySMM.move(mc, "_x", 300, 0.2);

============================================================= */
_global.$SMM = function() {
	this.initialize();
};
//
$SMM.prototype.initialize = function() {
	// -------------------------------------------
	// - Private Property
	// -------------------------------------------
	// - ef_mc depth 998991
	this._ef_mc_depth = 998991;
	this._propArr = null;
	this._ef_mc = null;
	this.procInit();
};
// - Not Used Property "_alpha"
$SMM.prototype.move = function(tmc:MovieClip, prop:String, cpN:Number, spN:Number, co:Object):Void {
	if(arguments.length == undefined) {
		trace("Parameter miss match");
		return;
	}
	if(prop == "_alpha") {
		trace("_alpha Not Used");
		return;
	}
	if(co == undefined) var co:Object = null;
	if(this.isFloat(cpN)) cpN = Math.round(cpN);
	this._propArr[this.matchFinder(tmc, prop)] = {
		tmc:tmc, prop:prop, cpN:cpN, spN:spN, co:co
	};
};
//
$SMM.prototype.setDepth = function(n:Number):Void {
	// - set _ef_mc_depth
	this._ef_mc_depth = n;
	_ef_mc.swapDepths(this._ef_mc_depth);
};
//
$SMM.prototype.procInit = function():Void {
	// - add Objectarray Type
	this._propArr = [];
	this._ef_mc = _root.createEmptyMovieClip("_ef_mc__", this._ef_mc_depth);
	//this._ef_mc.onEnterFrame = this.enterFrameExe;
	var owner:Object = this;
	this._ef_mc.onEnterFrame = function() {
		for(var i:Number=0;i<owner._propArr.length;i++) {
			with(owner._propArr[i]) {
				if(Math.round(tmc[prop]) == cpN) {
					tmc[prop] = cpN;
					if(owner._propArr[i].co != null) {						
						var _co:Object = owner._propArr[i].co;
						_co.func.call(_co.scope, _co.arg);
					}
					owner._propArr.splice(i, 1)
					trace(" End : "+tmc+"."+prop+" :: "+tmc[prop]);
				}
				tmc[prop] += (cpN-tmc[prop])*spN;
				//trace(" Ing : "+tmc+"."+prop+" :: "+tmc[prop]);
			}
		}//end for
	};//end onEnterFrame
};//end function
//
// - Blank EnterFrame Enabled
$SMM.prototype.disabled = function():Void {
	delete this._ef_mc.onEnterFrame;
	this._ef_mc.removeMovieClip();			
	delete this._ef_mc;
	delete this._propArr;
};
//
/*
$SMM.prototype.enterFrameExe = function():Void {	
	for(var i:Number=0;i<this._propArr.length;i++) {
		with(this._propArr[i]) {
			if(Math.round(tmc[prop]) == cpN) {
				tmc[prop] = cpN;
				if(this._propArr[i].co != null) {						
					var _co:Object = this._propArr[i].co;
					_co.func.call(_co.scope, _co.arg);
				}
				this._propArr.splice(i, 1)
				//trace(tmc+" End : "+tmc[prop]);
			}
			tmc[prop] += (cpN-tmc[prop])*spN;
			//trace(tmc+" Ing : "+tmc[prop]);
		}
	}
};
*/
//
$SMM.prototype.isFloat = function(n):Boolean {	
	if((n%1) != 0) return true;
	else return false;
};
//
$SMM.prototype.matchFinder = function(tmc, prop):Number {		
	for(var i:Number=0;i<this._propArr.length;i++) {
		if(this._propArr[i].tmc == tmc && 
			this._propArr[i].prop == prop) return i;
	}
	// - not Maching~
	return i;
};
//