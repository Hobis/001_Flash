/* ===================================================================================
	네모형태 무비클립을 생성한다.
		
	ex) 
		var mc:MovieClip = drawRect(10, 10, 100, 100, 0x000000, 100);
	
=================================================================================== */
function drawRect(xN:Number, yN:Number, wN:Number, hN:Number, colorN:Number, alphaN:Number):MovieClip {
	var xNArr:Array = [xN+wN, xN+wN, xN, xN];
	var yNArr:Array = [yN, yN+hN, yN+hN, yN];
	//trace(xNArr.length);
	//trace(yN);
	// - 현제무비클립 뎁스 참조
	var depthNum:Number = this.getNextHighestDepth();
	var tmc:MovieClip = this.createEmptyMovieClip("$_rectMC"+depthNum, depthNum);
	with(tmc) {
		moveTo(xN, yN)
		lineStyle(1, 0xff00ff, 100);
		beginFill(colorN, alphaN);		
		var iLoop = 0;
		while(iLoop<xNArr.length) {
			lineTo(xNArr[iLoop], yNArr[iLoop]);
			iLoop++;
		}
		endFill();
	}
	trace(tmc._name+" : "+tmc);
	return mc;
}
//var mc:MovieClip = drawRect(10, 10, 100, 100, 0x000000, 100);

/* ===================================================================================
	두께가 있는 네모형태 무비클립을 생성한다.
	code by : jhb0b
		
	ex) 
		var mcRect = drawRectWid(this, 10, 10, 200, 200, 0x000000, 100, 10);
	
=================================================================================== */
function drawRectWid(tmc, xN, yN, wN, hN, colorN, alphaN, rectWidth) {
	var xNArr = [xN+wN, xN+wN, xN, xN, xN+rectWidth, xN+wN-rectWidth, xN+wN-rectWidth, xN+rectWidth, xN+rectWidth];
	var yNArr = [yN, yN+hN, yN+hN, yN, yN+rectWidth, yN+rectWidth, yN+hN-rectWidth, yN+hN-rectWidth, yN+rectWidth];
	//trace(xNArr.length);
	//trace(yN);
	// - 현제무비클립 뎁스 참조
	var depthNum = tmc.getNextHighestDepth();
	var mc = tmc.createEmptyMovieClip("$_rectMC"+depthNum, depthNum);
	with(mc) {
		moveTo(xN, yN)
		//lineStyle(2, 0xff00ff, 100);
		beginFill(colorN, alphaN);		
		var iLoop = 0;
		var xNArrLen = xNArr.length;
		while(iLoop<xNArrLen) {
			lineTo(xNArr[iLoop], yNArr[iLoop]);
			iLoop++;
		}
		endFill();
	}
	//trace(tmc._name+" : "+tmc);
	return mc;
}
//var mcRect = drawRectWid(this, 10, 10, 200, 200, 0x000000, 100, 10);

/* ===================================================================================
	모서리가 둥근 사각형 그리기 (위방향)
	ex : var myRect = roundersRectTop(10, 10, 400, 30, 10, 0x006600, 100);
		   trace(myRect);
	parameters : 
	xN, yN -  그려질 무비클립의 위치좌표
	wN, hN - 그려질 무비클립의 폭과 높이
	colorN - 도형의 채움색
	alphaN - 채움색의 알파
	
	그라디언트를 사용할때 Matrix를 사용한다.
=================================================================================== */
// - Matrix객체를 사용하기 때문에 필요한 import
//import flash.geom.Matrix;
function roundersRectTop(xN, yN, wN, hN, rN, colorN, alphaN):MovieClip {
	// - 그라디언트를 사용할때
	//var myMat = new Matrix();
	//myMat.createGradientBox(wN, hN, (90/180)*Math.PI, 0, 0);
	//var colorArr = [0xfafafa, 0xe4e4e4];
	//var alphaArr = [100, 100];
	//var ratioArr = [0, 255];
	var depthNum = this.getNextHighestDepth();
	var tmc = this.createEmptyMovieClip("$_rectMC", depthNum);
	with(tmc) {
		beginFill(colorN, alphaN);
		//beginGradientFill("linear", colorArr, alphaArr, ratioArr, myMat);
		moveTo(xN+rN, yN);
		lineStyle(1, 0x006600, 100, true, "none", "none");
		lineTo(xN+wN-rN, yN);
		curveTo(xN+wN, yN, xN+wN, yN+rN);
		lineTo(xN+wN, yN+hN);
		lineTo(xN, yN+hN);
		lineTo(xN, yN+rN);
		curveTo(xN, yN, xN+rN, yN);
		endFill();
		cacheAsBitmap = true;
	}
	trace(tmc);
	return tmc;
}
/* ===================================================================================
	모서리가 둥근 사각형 그리기
	ex : var myRect = roundersRect(10, 10, 50, 50, 10, 0x006600, 100);
		   trace(myRect);
	parameters : 
	xN, yN -  그려질 무비클립의 위치좌표
	wN, hN - 그려질 무비클립의 폭과 높이
	colorN - 도형의 채움색
	alphaN - 채움색의 알파
	
	그라디언트를 사용할때 Matrix를 사용한다.
=================================================================================== */
// - Matrix객체를 사용하기 때문에 필요한 import
//import flash.geom.Matrix;
function roundersRect(xN, yN, wN, hN, rN, colorN, alphaN):MovieClip {
	// - 그라디언트를 사용할때
	//var myMat = new Matrix();
	//myMat.createGradientBox(wN, hN, (90/180)*Math.PI, 0, 0);
	//var colorArr = [0xfafafa, 0xe4e4e4];
	//var alphaArr = [100, 100];
	//var ratioArr = [0, 255];
	var depthNum = this.getNextHighestDepth();
	var tmc = this.createEmptyMovieClip("$_rectMC", depthNum);
	with(tmc) {
		beginFill(colorN, alphaN);
		//beginGradientFill("linear", colorArr, alphaArr, ratioArr, myMat);
		moveTo(xN+rN, yN);
		lineStyle(1, 0x000000, 100, true, "none", "none");
		lineTo(xN+wN-rN, yN);
		curveTo(xN+wN, yN, xN+wN, yN+rN);
		lineTo(xN+wN, yN+hN-rN);
		curveTo(xN+wN, yN+hN, xN+wN-rN, yN+hN);
		lineTo(xN+rN, yN+hN);
		curveTo(xN, yN+hN, xN, yN+hN-rN);
		lineTo(xN, yN+rN);
		curveTo(xN, yN, xN+rN, yN);
		endFill();
		cacheAsBitmap = true;
	}
	trace(tmc);
	return tmc;
}
/* ===================================================================================
	- 정원그리기 -
	from April 17. 2002, to April 17. 2003 
	Moreal (sand@postech.edu) 
	
        Arguments :                                        [] means range! 

                x, y                positions of center 
                r                radius 
                c                color                        [0xRRGGBB] 
                a                alpha                        [0, 100] 

        Description : 
                  MovieClip.drawCircle method draws a circle-like curve 
                with 8 points. Actually, it DO NOT make a perfect circle, 
                but make a really similar circle as flash do. 
                This method is relatively fast, because there are no 
                loop statments and heavy math functions. 

        Examples : 
                1. drawing a circle of radius 10 with a blue outline and a cyan fill 
                        this.lineStyle(1, 0x0000FF, 100);
                        this.drawCircle(100, 100, 10, 0x00FFFF, 100);
                2. drawing an empty (not filled) circle
                        this.lineStyle(1, 0x0000FF, 100); 
                        this.drawCircle(100, 100, 10);
                3. drawing a circle of radius 10 without outline 
                        this.lineStyle(); 
                        this.drawCircle(100, 100, 10, 0x00FFFF, 100);
						
	ex : var myCircle = drawCircle(10+50, 10+50, 50, 0x000000, 100);
		trace(myCircle);
	   
		parameters : 
			xN, yN -  그려질 무비클립의 위치좌표
			wN, hN - 그려질 무비클립의 폭과 높이
			colorN - 도형의 채움색
			alphaN - 채움색의 알파
=================================================================================== */
// - Matrix객체를 사용하기 때문에 필요한 import
//import flash.geom.Matrix;
function drawCircle(xN, yN, rN, colorN, alphaN):MovieClip {
	var depthNum = this.getNextHighestDepth();
	var tmc = this.createEmptyMovieClip("$_rectMC", depthNum);
	var hN = rN*(Math.SQRT2-1);
	var mN = rN*Math.SQRT2*.5;
	with(tmc) {
		moveTo(xN+rN, yN);
		beginFill(colorN, alphaN);
		curveTo(xN+rN, yN+hN, xN+mN, yN+mN);
		curveTo(xN+hN, yN+rN, xN, yN+rN);
		curveTo(xN-hN, yN+rN, xN-mN, yN+mN);
		curveTo(xN-rN, yN+hN, xN-rN, yN);
		curveTo(xN-rN, yN-hN, xN-mN, yN-mN);
		curveTo(xN-hN, yN-rN, xN, yN-rN);
		curveTo(xN+hN, yN-rN, xN+mN, yN-mN);
		curveTo(xN+rN, yN-hN, xN+rN, yN);
		endFill();
	}
	trace(tmc);
	return tmc;
}
//var myCircle = drawCircle(10+50, 10+50, 50, 0x000000, 100);
/* ===================================================================================
	다각형 그리기
	ex : drawPolygon(0, 0, 100, 0x000000, 100);
=================================================================================== */
function drawPolygon(xN:Number, yN:Number, wN:Number, colorN:Number, alphaN:Number):MovieClip {
	var theta_60 = (60*180)/Math.PI;
	var theta_30 = (30*180)/Math.PI;
	var h_2 = Math.round(wN*Math.sin(theta_60));
	var w_2 = Math.round(wN*-Math.sin(theta_30));
	var depthNum:Number = this.getNextHighestDepth();
	var xArr = [xN, xN+w_2, xN+w_2+wN, xN+w_2+wN+w_2, xN+w_2+wN, xN+w_2, xN];
	var yArr = [yN+h_2, yN, yN, yN+h_2, yN+h_2*2, yN+h_2*2, yN+h_2];
	var tmc:MovieClip = this.createEmptyMovieClip("$_polygon"+depthNum, depthNum);
	with(tmc) {
		beginFill(colorN, alphaN);
		lineStyle(1, 0x000000, 100);
		moveTo(xN, yN+h_2);
		for(var i=1;i<xArr.length;i++) {
			lineTo(xArr[i], yArr[i]);
		}
		endFill();
	}
	return tmc;
}
//var mc = drawPolygon(100, 100, 100, 0x000000, 100);