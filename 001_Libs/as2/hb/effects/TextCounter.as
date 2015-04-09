/**
	@name:TextCounter
	@author:Hobis Jung
	@date:2010-01-11
	@use:
	{
	}
*/
class hb.effects.TextCounter
{
	public function TextCounter() {}
	private static function p_shuffleArray(arr:Array):Void
	{
		var t_len:Number = arr.length;
		var t_obj:Object;
		var t_num:Number;
		var i:Number;
		for (i = 0; i < t_len; i ++)
		{
			t_obj = arr[i];
			t_num = random(t_len);
			arr[i] = arr[t_num];
			arr[t_num] = t_obj;
		}
	}
	public static function start(target:MovieClip, varStr:String, targetStr:String, transStr:String,
		isTransShuffle:Boolean):Void
	{
		var t_targetStrArr:Array = targetStr.split('');
		var t_targetStrArrLen:Number = t_targetStrArr.length;
		var t_transStrArr:Array = transStr.split('');
		var t_transStrArrLen:Number = t_transStrArr.length;
		var tempStr:String = '', realStr:String = '', falseStr:String = '';
		var i:Number = 0, a:Number = 0, b:Number = 1, d:Number = 0;
		var is_12:Boolean = false;
		var procNum:Number = 0;

		if (isTransShuffle == undefined) isTransShuffle = true;

		if (isTransShuffle) p_shuffleArray(t_transStrArr);

		target.onEnterFrame = function():Void
		{
			if (realStr == targetStr)
			{
				delete this.onEnterFrame;
				return;
			}

			realStr = '';

			while (a < b)
			{
				if (a < d)
				{
					realStr += t_targetStrArr[a];
				}
				else
				{
					procNum = (i - a) % t_transStrArrLen;
					realStr += t_transStrArr[random(t_transStrArrLen)];
				}
				a ++;
			}

			this[varStr] = realStr;

			a = 0;
			if (i < (t_targetStrArrLen - 1)) b ++;
			if (i >= t_transStrArrLen) d ++;

			i++;
		};
	}
}
