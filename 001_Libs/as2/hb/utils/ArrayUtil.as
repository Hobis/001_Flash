/**
	@name: Array Util
	@author: Hobis Jung
	@blog: http://blog.naver.com/jhb0b
	@date: 2011-01-03
*/
class hb.utils.ArrayUtil
{
	public function ArrayUtil()
	{
	}

	// :: Elements Match Find
	public static function findLoop(target:Array, o:Object):Number
	{
		var t_rv:Number = -1;
		var t_len:Number = target.length;
		var i:Number = 0;

		while (i < t_len)
		{
			if (target[i] === o)
			{
				t_rv = i;
				return;
			}

			i ++;
		}

		return t_rv;
	}

	// :: Element Contains
	public static function arrayContainsValue(target:Array, o:Object):Boolean
	{
		var t_rv:Boolean = (target.indexOf(o) != -1);
		return t_rv;
	}

	// :: Copy Array
	public static function copyArray(target:Array):Array
	{
		return target.slice();
	}

	// :: Element Remove
	public static function removeValueFromArray(target:Array, o:Object):Array
	{
		var t_index:Number = findLoop(target, o);
		var t_rv:Array = null;

		if (t_index != -1)
		{
			t_rv = target.splice(t_index, 1);
		}

		return t_rv;
	}

	// :: Shuffle Array
	public static function shuffle(target:Array):Void
	{
		var t_len:Number = target.length;
		var t_obj:Object = null;
		var t_ranIndex:Number;

		for (var i:Number = 0; i < t_len; i++)
		{
			t_obj = target[i];
			t_ranIndex = random(t_len);
			target[i] = target[t_ranIndex];
			target[t_ranIndex] = t_obj;
		}
	}
}