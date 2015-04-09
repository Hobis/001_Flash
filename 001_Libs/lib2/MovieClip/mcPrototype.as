/* ######################################################################

	MovieClip Prototype Library
	
	Written : Kobalt60 - Jung Hee Bum
	Date : 060314
	
	Comment : 
	
		- 무비클립 관련 제어를 위한 프로토타입 모음
		- 메서드 중복을 피하기 위하여 #include보단 드래그 해서 사용하자.
		
###################################################################### */
/* =============================================================================
	MovieClip Loading Processing
	
	- 주의 !! 메인무비의 첫번째 프래임에서는 프리로딩이 걸리지 않는다.
	- ex) mcName.mcLoadProcs();
============================================================================= */
MovieClip.prototype.mcLoadProcs = function() {
	this.onEnterFrame = function () {
		var totalN = this.getBytesTotal();
		var nowN = this.getBytesLoaded();
		var perN = Math.round((nowN/totalN)*100);
		// ---- 로딩과정에 필요한 무비클립 연결 ----
		//this.loader.bar._xscale = this.percent;
		//this.loader.parcent.text = this.percent + "%";
		//trace(perN);
		if(nowN >= totalN) {
			delete this.onEnterFrame;
			//nextExcutive();
		}
	};
};//end function
/* =============================================================================
	MovieClip Color Changed
	
	- mc에 틴트컬러를 부여할때 사용
	- ex)
	
		mcName.mcColorTo();
		this.onMouseDown = function() {
			mc.mcColorTo("#000000");	
		};
		this.onMouseDown = function() {
			mc.mcColorTo("#CC0000");	
		};		
============================================================================= */
MovieClip.prototype.mcColorChange = function(cStr) {
	if(cStr.charAt(0) == "#") {
		cStr = cStr.slice(1, 7);
	} else return;
	var colorValue = "0x" + cStr;
	var myColor = new Color(this);
	myColor.setRGB(colorValue);
};

/* =============================================================================
	모든 무비클립 시작
============================================================================= */
MovieClip.prototype.mcPlayAll = function() {
	for(var i in this) {
		if(this[i] instanceof MovieClip) {
			trace(i);
			this[i].play();
		}
	}
};

/* =============================================================================
	모든 무비클립 정지
============================================================================= */
MovieClip.prototype.mcStopAll = function() {
	this.stop();
	for(var i in this) {
		if(this[i] instanceof MovieClip) {
			this[i].stop();
		}
	}
};

/* =============================================================================
	무비클립 프래임제어
============================================================================= */
MovieClip.prototype.frameOO = function(type:String):Void {	
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

/* =============================================================================
	프래임을 반복순환
============================================================================= */
MovieClip.prototype.autoFrame = function(totalFrame) {
	this.gotoAndStop(this._currentframe%totalFrame+1);
};