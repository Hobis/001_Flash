// :: Name에서 라스트 인덱트 찾기 str
var hb_getLastIndex_str:Function = function(name:String, step:uint = 0, token:String = '_'):String
{
	var t_rv:String = null;

	var t_fi:int = name.length - 1;
	var t_ti:int;
	var t_bi:int;
	var t_len:int;

	for (var i:uint = 0; i <= step; i ++)
	{
		t_ti = name.lastIndexOf(token, t_fi);

		if (t_ti > -1)
		{
			t_bi = t_ti + token.length;
			t_len = (t_fi - t_bi) + 1;

			//trace('t_fi: ' + t_fi);
			//trace('t_bi: ' + t_bi);
			//trace('t_len: ' + t_len);

			t_fi = t_ti - 1;
		}
		else
		{
			t_bi = -1;
			break;
		}
	}

	if (t_bi > -1)
	{
		t_rv = name.substr(t_bi, t_len);
	}

	return t_rv;
};

// :: Name에서 라스트 인덱트 찾기 2
var hb_getLastIndex2:Function = function(name:String, step:uint = 0, token:String = '_'):int
{
	var t_rv:int = -1;

	var t_fi:int = name.length - 1;
	var t_ti:int;
	var t_bi:int;
	var t_len:int;

	for (var i:uint = 0; i <= step; i ++)
	{
		t_ti = name.lastIndexOf(token, t_fi);

		if (t_ti > -1)
		{
			t_bi = t_ti + token.length;
			t_len = (t_fi - t_bi) + 1;

			//trace('t_fi: ' + t_fi);
			//trace('t_bi: ' + t_bi);
			//trace('t_len: ' + t_len);

			t_fi = t_ti - 1;
		}
		else
		{
			t_bi = -1;
			break;
		}
	}

	if (t_bi > -1)
	{
		var t_numStr:String = name.substr(t_bi, t_len);
		var t_check:Number = Number(t_numStr);

		if (!isNaN(t_check))
		{
			t_rv = int(t_check);
		}
	}

	return t_rv;
};
//trace('0123456789'.substr(7, 2));

// :: Name에서 라스트 인덱트 찾기
var hb_getLastIndex:Function = function(name:String, step:uint = 0, token:String = '_'):int
{
	var t_arr:Array = name.split(token);
	var t_cn:Number = Number(t_arr[t_arr.length - (step + 1)]);
	var t_rv:int = isNaN(t_cn) ? -1 : int(t_cn);

	return t_rv;
};
// :: LoaderInfo.url에서 절대 경로 반환하기
var hb_getBaseUrl:Function = function(url:String):String
{
	// hb_getBaseUrl(this.loaderInfo.url)
	var t_rv:String = url;
	var t_li:int = t_rv.lastIndexOf('/') + 1;
	t_rv = t_rv.substring(0, t_li);

	return t_rv;
};
// :: 현재 파일 이름만 반환
var hb_getThisName:Function = function(url:String, extStr:String = 'swf'):String
{
	var t_rv:String = null;
	var t_si:int = url.lastIndexOf('/') + 1;
	var t_ei:int = url.lastIndexOf('.' + extStr);
	t_rv = url.substring(t_si, t_ei);

	return t_rv;
};
// :: random min max
var hb_number_RandRange:Function = function(min:Number, max:Number):Number
{
	return Math.floor(Math.random() * (max - min + 1)) + min;
};
// :: 배열 요소가 순서대로 같은지 여부 (1차원배열만, 길이도 같아야 됨)
var hb_array_IsEquals:Function = (aa:Array, ab:Array):Boolean
{
	var t_rv:Boolean = false;

	if (aa == ab)
		t_rv = true;
	else
	{
		if (aa.length == ab.length)
		{
			var t_la:uint = aa.length, i:uint;
			for (i = 0; i < t_la; i ++)
			{
				if (aa[i] == ab[i])
				{
					t_rv = true;
				}
				else
				{
					t_rv = false;
					break;
				}
			}
		}
	}

	return t_rv;
};
// :: Shuffle Array
var hb_array_Shuffle:Function = function(target:Array):void
{
	var t_len:uint = target.length;
	var t_obj:Object = null;
	var t_ranIndex:uint;

	for (var i:uint = 0; i < t_len; i ++)
	{
		t_obj = target[i];
		t_ranIndex = uint(hb_number_RandRange(0, t_len - 1));

		target[i] = target[t_ranIndex];
		target[t_ranIndex] = t_obj;
	}
};

// :: 무비클립 비활성화 (채도 죽이기, 살리기)
var hb_mc_setDesat:Function = function(target:DisplayObject, isDesat:Boolean = true):void
{
	//- 무비클립 무채색 적용
	const t_CMF_DESAT:ColorMatrixFilter = new ColorMatrixFilter
	(
		[
			0.308600008487701, 0.609399974346161, 0.0820000022649765, 0, 0,
			0.308600008487701, 0.609399974346161, 0.0820000022649765, 0, 0,
			0.308600008487701, 0.609399974346161, 0.0820000022649765, 0, 0,
			0, 0, 0, 1, 0
		]
	);
	//- 무비클립 무채색 제거
	const t_CMF_NORMAL:ColorMatrixFilter = new ColorMatrixFilter
	(
		[
			1, 0, 0, 0, 0,
			0, 1, 0, 0, 0,
			0, 0, 1, 0, 0,
			0, 0, 0, 1, 0
		]
	);

	if (isDesat)
		target.filters = [t_CMF_DESAT];
	else
		target.filters = [t_CMF_NORMAL];
};

/*
this.stop();
MovieClip(this.root).subCall(this);


*/