var MCLoadProc:Function = function():Void {
	this.init();
};
MCLoadProc.prototype.mcLoadProcs = function(tmc:MovieClip, callBack:Function):Void {
	var firstN:Number = tmc.getBytesTotal();
	var totalN:Number = 0, nowN:Number = 0, perN:Number = 0;
	/*
	var befMC:MovieClip = _root.createEmptyMovieClip("befMC__", 999998);
	befMC.onEnterFrame = function() {
		if(nowN >= totalN && nowN > firstN) {
			delete this.onEnterFrame;
			this.removeMovieClip;
			if(callBack != undefined) callBack();
			trace("Last % :: "+perN);
			return true;
		}
		totalN = tmc.getBytesTotal();
		nowN = tmc.getBytesLoaded();
		perN = Math.round((nowN/totalN)*100);
		//trace("Ing % :: "+perN);
	};
	*/
	clearInterval(_global.$__loadID);
	_global.$__loadID = setInterval(function() {
		if(nowN >= totalN && nowN > firstN) {
			clearInterval(_global.$__loadID);
			delete _global.$__loadID;
			if(callBack != undefined) callBack();
			trace("Last % :: "+perN);
			return true;
		}
		totalN = tmc.getBytesTotal();
		nowN = tmc.getBytesLoaded();
		perN = Math.round((nowN/totalN)*100);
		//trace("Ing % :: "+perN);
	}, 20);

};//end mcLoadProcs