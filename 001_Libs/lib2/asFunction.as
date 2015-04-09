/* #####################################################################
	Common Functions
	Written : Kobalt60 - Jung Hee Bum
	Date : 060502

	Comment : {
		유용하게 사용할수 있는 타임라인 함수
		※ 함수 중복을 피하기 위하여 #include보단 드래그 해서 사용하자.
	}
##################################################################### */
function hb_getMean(tArr:Array):Number {
	var sum:Number = 0;;
	var tArrLen:Number = tArr.length;
	var i:Number = 0;
	while(i<tArrLen) {
		sum = sum+tArr[i];
		i++;
	}
	return sum/tArrLen;
}
function hb_getBrightness():Number {
	var p = tt.colorTransform;
	var mmn:Number = hb_getMean([p.redMultiplier, p.greenMultiplier, p.blueMultiplier]);
	var mon:Number = hb_getMean([p.redOffset, p.greenOffset, p.blueOffset]);
	trace(p);
	var temp_bn:Number = (mon > 0) ? 1-mmn : mmn-1;
	return Math.round(temp_bn*100)/100;
}

/* =================================================================
	- 현제 날짜 구하기.
================================================================= */
function getNowDate() {
    var myDate = new Date();
	var totalDate = String(myDate.getFullYear());
	var nowMonth = String(myDate.getMonth()+1);
	var nowDate = String(myDate.getDate());
	if(nowMonth < 10) totalDate += "0"+nowMonth;
	else totalDate += nowMonth;
	if(nowDate < 10) totalDate += "0"+nowDate;
	else totalDate += nowDate;
	return Number(totalDate);
}//end function
/* =================================================================
	- 현제 시간 구하기.
================================================================= */
function getNowTime() {
	var myTime = new Date();
	var totalTime = String(myTime.getHours());
	var nowMin = String(myTime.getMinutes());
	var nowSec = String(myTime.getSeconds());
	if(nowMin < 10) totalTime += "0"+nowMin;
	else totalTime += nowMin;
	if(nowSec < 10) totalTime += "0"+nowSec;
	else totalTime += nowSec;
	return Number(totalTime);
}//end function
/* =================================================================
	- 현제 날짜&시간 구하기.
================================================================= */
function getNowDateTime() {
	return Number(String(getNowDate())+String(getNowTime()));
}
/* =================================================================
	- 모든 무비클립 정지.
================================================================= */
function stopAllMc(tmc) {
    tmc.stop();
    for (var i in tmc) {
        if (tmc[i] instanceof MovieClip) {
            tmc[i].stopAllMc();
        }
    }
}
/* =================================================================
	- 모든 무비클립 시작.
================================================================= */
function PlayAllMc() {
    this.play();
    for (var i in tmc) {
        if (tmc[i] instanceof MovieClip) {
            tmc[i].PlayAllMc();
        }
    }
}
/* =================================================================
	- MC Finder 특정경로에서 무비클립 찾아 이름바꾸기
	- Use : trace(MovieClipNamed(this, "myMC"));
================================================================= */
function MovieClipNamed(mc, reNameMC) {
	var count = 0;
	for(var i in mc) {
		if(typeof (mc[i]) == "movieclip") {
			mc[i]._name = String(reNameMC+count);
			//trace(this[reNameMC+count]);
			count++;
		}
	}
	return mc+" In MovieClip : "+count;
}//end function
/* =================================================================
	- swf실행되는 환경을 검사한다.
	- Use : trace(local_ServerJudgment(this, "variableName"));
================================================================= */
function local_ServerJudgment(to:MovieClip, varStr:String):String {
	var cp:String = System.capabilities.playerType;
	if(cp == "External" || cp == "StandAlone") {
		to[varStr] = "xml_data/my_viewer.xml";
		return "This Movie In Local SWF";
	} else if(cp == "PlugIn" || cp == "ActiveX") {
		to[varStr] = "/flash/xml_data/my_viewer.xml";
		return "This Movie In Server SWF";
	}
}//end local_ServerJudgment
/* =================================================================
	- 무비클립 밝기설정
	- Color.setBrightness method
	- April 17, 2002
	- made by Moreal (sand@postech.edu) convert AS2.0
	- b: brightness(0-100)
	- Use : setBrightness(mc, 100);
================================================================= */
function setBrightness(tMC:MovieClip, bn:Number):Void {
	var brightness = bn;
	var target = new Color(tMC);
	var offset = 0xFF*(brightness>0 ? brightness : 0)/100;
	var percent = brightness>=0 ? 100-brightness : 100+brightness;
	target.setTransform({ra:percent, rb:offset, ga:percent, gb:offset, ba:percent, bb:offset});
}
/* =================================================================
	- 16비트 색상코드를 r,g,b로 나눈 오브젝트를 리턴한다.
	- Use :
		trace(colorRGB_Division(0xffeeaa).r.toString(16));
		trace(colorRGB_Division(0xffeeaa).g.toString(16));
		trace(colorRGB_Division(0xffeeaa).b.toString(16));
================================================================= */
function colorRGB_Division(colorN) {
	var pcN = colorN;
	var bN = pcN & 255;
	//trace(bN.toString(16));
	pcN = pcN >> 8;
	var gN = pcN & 255;
	pcN = pcN >> 8;
	var rN = pcN & 255;
	var rgbObj = {r:rN, g:gN, b:bN};
	return rgbObj;
}
/* =================================================================
	- 오브젝트의 밝기를 변화시킨다.
	- Use :
		var myColor = new Color(mc);
		var iLoop = 0;
		this.onEnterFrame = function() {
			if(iLoop > 99) {
				delete this.onEnterFrame;
				return;
			}
			var pN = cngBrightness(0x000000, iLoop);
			trace(pN.toString(16));
			myColor.setRGB(pN);
			iLoop++;
		};
================================================================= */
function changeBrightness(colorN:Number, brightN:Number):Number {
	if(brightness<-100 || brightness>100) {
		trace("brightness InputNumber -100 ~ 100");
	} else {
		var r:Number = Math.floor(color/Math.pow(256, 2));
		var g:Number = Math.floor(color%Math.pow(256, 2)/256);
		var b:Number = colorN%256;
		if (brightness>0) {
			r = Math.round(r+(255-r)/100*brightN);
			g = Math.round(g+(255-g)/100*brightN);
			b = Math.round(b+(255-b)/100*brightN);
		} else {
			r = Math.round(r+r/100*brightN);
			g = Math.round(g+g/100*brightN);
			b = Math.round(b+b/100*brightN);
		}
		var returnColor:Number = r*Math.pow(256, 2)+g*256+b;
		return returnColor;
	}
}
/* =================================================================
	- 인스턴스에 마지막 번호 얻기
	- 끝에서 두번째 까지의 번호 얻기
	- Use : trace(getNumber("001133", 2));
================================================================= */
function getNumber(obj, num) {
    return(obj.substr(obj.length - num));
}
/* =================================================================
	- 배열안에서 특정 요소의 번호 반환하기.
	- Use :
		var myArr = ["jhb", "jhb", "jhb", 150];
		trace(getArrIndex(myArr, 150));
================================================================= */
function getArrIndex(arrName, Value) {
	var i = 0;
    var nameArr = arrName.length;
	while (i<nameArr) {
        if (arrName[i] == Value) {
            return i;
        }
        i++;
    }
}
/* =================================================================
	- 현제 실행중인 함수의 이름 알아내기.
	- Use : trace(findFuncName());
================================================================= */
function findFuncName() {
    for(var i in this) {
        if(this[i] == arguments.callee) {
			return i;
		}
    }
}
/* =================================================================
    arrayCombination function
    code by : Jung Hee Bum
    blog : http://blog.naver.com/jhb0b
    site : http://arigatto.ivyro.net
    date : 060516
================================================================= */
function arrayCombination():Void {
    var nowNum:Number = 0;
    myObj[myArr[nowNum]] = 0;
    for(var i:Number=0;i<myArrLen;i++) {
        if(myArr[nowNum] == myArr[i]) {
            myObj[myArr[nowNum]]++;
        } else {
            nowNum = i;
            if(myObj[myArr[nowNum]] == undefined) {
                myObj[myArr[nowNum]] = 0;
            }
        myObj[myArr[nowNum]]++;
        }
    }
}
var myArr:Array = [];
trace(typeof myArr);
myArr = ["Inmingun", "Inmingun", "007", "007", "Inmingun", "Jung", "Jung"];
var myArrLen:Number = myArr.length;
var myObj:Object = {};
arrayCombination();
/* =================================================================
    arrayCombination function_2
    code by : Jung Hee Bum
    blog : http://blog.naver.com/jhb0b
    site : http://arigatto.ivyro.net
    date : 060516
================================================================= */
function arrayCombination(tmc:MovieClip, objStr:String):Object {
	if(tmc[objStr] == undefined) {
		return null;
	}
    var nowNum:Number = 0;
	var myArrLen:Number = tmc[objStr].length;
	var myObj:Object = {};
    myObj[tmc[objStr][nowNum]] = 0;
    for(var i:Number=0;i<myArrLen;i++) {
        if(tmc[objStr][nowNum] == tmc[objStr][i]) {
            myObj[tmc[objStr][nowNum]]++;
        } else {
            nowNum = i;
            if(myObj[tmc[objStr][nowNum]] == undefined) {
                myObj[tmc[objStr][nowNum]] = 0;
            }
        myObj[tmc[objStr][nowNum]]++;
        }
    }
	return myObj;
}
/* Using
var myArr:Array = [
	"Inmingun", "Jung", "Hee", "Bum", "longtime", "Inmingun", "Jung", "Hee", "bum",
	"apple", "pineapple", "lion", "bus", "phone", "TV", "Room", "Water", "Movie",
	"Flash", "PhotoShop", "Dreamweaver", "AfterEffect", "Windows", "good", "naver",
	"Inmingun", "Jung", "Hee", "Bum", "longtime", "Inmingun", "Jung", "Hee", "bum",
	"apple", "pineapple", "lion", "bus", "phone", "TV", "Room", "Water", "Movie",
	"Flash", "PhotoShop", "Dreamweaver", "AfterEffect", "Windows", "good", "naver",
	"Inmingun", "Jung", "Hee", "Bum", "longtime", "Inmingun", "Jung", "Hee", "bum",
	"apple", "pineapple", "lion", "bus", "phone", "TV", "Room", "Water", "Movie",
	"Flash", "PhotoShop", "Dreamweaver", "AfterEffect", "Windows", "good", "naver",
	"Inmingun", "Jung", "Hee", "Bum", "longtime", "Inmingun", "Jung", "Hee", "bum",
	"apple", "pineapple", "lion", "bus", "phone", "TV", "Room", "Water", "Movie",
	"Flash", "PhotoShop", "Dreamweaver", "AfterEffect", "Windows", "good", "naver",
	"Inmingun", "Jung", "Hee", "Bum", "longtime", "Inmingun", "Jung", "Hee", "bum",
	"apple", "pineapple", "lion", "bus", "phone", "TV", "Room", "Water", "Movie",
	"Flash", "PhotoShop", "Dreamweaver", "AfterEffect", "Windows", "good", "naver",
	"Inmingun", "Jung", "Hee", "Bum", "longtime", "Inmingun", "Jung", "Hee", "bum",
	"apple", "pineapple", "lion", "bus", "phone", "TV", "Room", "Water", "Movie",
	"Flash", "PhotoShop", "Dreamweaver", "AfterEffect", "Windows", "good", "naver",
	"Inmingun", "Jung", "Hee", "Bum", "longtime", "Inmingun", "Jung", "Hee", "bum",
	"apple", "pineapple", "lion", "bus", "phone", "TV", "Room", "Water", "Movie",
	"Flash", "PhotoShop", "Dreamweaver", "AfterEffect", "Windows", "good", "naver",
	"Inmingun", "Jung", "Hee", "Bum", "longtime", "Inmingun", "Jung", "Hee", "bum",
	"apple", "pineapple", "lion", "bus", "phone", "TV", "Room", "Water", "Movie",
	"Flash", "PhotoShop", "Dreamweaver", "AfterEffect", "Windows", "good", "naver",
	"Inmingun", "Jung", "Hee", "Bum", "longtime", "Inmingun", "Jung", "Hee", "bum",
	"apple", "pineapple", "lion", "bus", "phone", "TV", "Room", "Water", "Movie",
	"Flash", "PhotoShop", "Dreamweaver", "AfterEffect", "Windows", "good", "naver",
	"Inmingun", "Jung", "Hee", "Bum", "longtime", "Inmingun", "Jung", "Hee", "bum",
	"apple", "pineapple", "lion", "bus", "phone", "TV", "Room", "Water", "Movie",
	"Flash", "PhotoShop", "Dreamweaver", "AfterEffect", "Windows", "good", "naver",
	"Inmingun", "Jung", "Hee", "Bum", "longtime", "Inmingun", "Jung", "Hee", "bum",
	"apple", "pineapple", "lion", "bus", "phone", "TV", "Room", "Water", "Movie",
	"Flash", "PhotoShop", "Dreamweaver", "AfterEffect", "Windows", "good", "naver",
	"Inmingun", "Jung", "Hee", "Bum", "longtime", "Inmingun", "Jung", "Hee", "bum",
	"apple", "pineapple", "lion", "bus", "phone", "TV", "Room", "Water", "Movie",
	"Flash", "PhotoShop", "Dreamweaver", "AfterEffect", "Windows", "good", "naver"
];
var myObj:Object = arrayCombination(this, "myArr");
*/
/* =================================================================
    shuffleArray function
	- usage
		var myArr:Array = [0,1,2,3,4,5,6,8];
		shuffleArray(myArr);
		trace(myArr);
================================================================= */
function shuffleArray(ao:Array):Void {
	var aoLen:Number = ao.length;
	for(var i:Number=0;i<aoLen;i++){
		var tmp = ao[i];
		var randomNum = random(aoLen);
		ao[i] = ao[randomNum];
		ao[randomNum] = tmp;
	}
}
/* =================================================================
    getBytes function
	- usage
		getBytes("안녕하세요.");
================================================================= */
function getBytes(str:String):Number {
	var totalCount:Number = 0;
	for(var i:Number = 0; i<str.length; i++) {
		totalCount += escape(str.charAt(i)).length>4 ? 2 : 1;
	}
	return totalCount;
}
/* =========================================================
	- 일정프래임 진행 후 함수 실행
========================================================= */
var delayExcute:Function = function(num:Number, scope:Object, func:String):Void {
	var i:Number = 0;
	var bef_mc:MovieClip = _root.createEmptyMovieClip("$_bef_mc", 999998);
	bef_mc.onEnterFrame = function() {
		if(i > num) {
			delete this.onEnterFrame;
			bef_mc.removeMovieClip();
			scope[func]();
			trace("Last :: "+i);
			return true;
		}
		i++;
		trace("Ing :: "+i);
	};
};
/* =========================================================
	- 평션하고 파리미터 정의 타입. 지금까지 가장 쓸만함.
========================================================= */
var delayExcute:Function = function(delayNum:Number, scope:Object, exeFunc:Function, paraObj:Object):Void {
	var iLoop:Number = 0;
	var befMC:MovieClip;
	befMC = _root.createEmptyMovieClip("befMC__$", 999998);
	befMC.onEnterFrame = function() {
		if(iLoop >= delayNum) {
			delete this.onEnterFrame;
			this.removeMovieClip();
			exeFunc.call(scope, paraObj);
			return true;
		}
		iLoop++;
		trace(iLoop);
	};
};
/* =========================================================
	plusZero
	Use : trace(plusZero(1, 3));
========================================================= */
function plusZero(v:Object, num:Number):String {
	var tempStr:String, strLen:Number, i:Number;
	tempStr = String(v);
	strLen = tempStr.length;
	i = 1;
	while(i<=(num-strLen)) {
		tempStr = "0"+tempStr;
		i++;
	}
	return tempStr;
}// end function
/* =========================================================
	minusZero
	Use : trace(minusZero("000000000000000011"));
========================================================= */
function minusZero(v:Object):String {
	var tempStr:String, strLen:Number, i:Number;
	tempStr = String(v);
	strLen = tempStr.length;
	i = 1;
	while(i<=strLen) {
		if(tempStr.charAt(0) == "0") {
			tempStr = tempStr.substring(1, strLen);
		} else break;
		i++;
	}
	if(i == "") tempStr = "0";
	return tempStr;
}// end function
/* =========================================================
	make10Num
	Use : trace(make10Num(6));
========================================================= */
function make10Num(num:Number):String {
	var proc:String = String(num);
	return (proc.length == 1) ? "0"+proc : proc;
}



/* =========================================================
	@name : 콤마 찍기
	@using : {
		trace(hb_addComma(String(1000000000)));
	}
========================================================= */
function hb_addComma(str:String, num:Number):String {
    var len:Number = str.length;
    var temp:String = '';
	if(!num) num = 3;
    for(var i:Number=0;i<=len;i++) {
        temp = str.charAt(len-i)+temp;
        if(((i%num) == 0) && (i>0) && (i<len)) {
            temp = ','+temp;
        }
    }
    return temp;
}
