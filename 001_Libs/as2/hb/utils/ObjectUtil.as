/**
	@name: Object Util
	@author: Hobis Jung
	@blog: http://blog.naver.com/jhb0b
	@date: 2011-01-03
*/
class hb.utils.ObjectUtil
{
	public function ObjectUtil()
	{
	}

	public static function getElementsLength(target:Object):Number
	{
		var t_rv:Number = 0;

		for (var t_s:String in target)
		{
			t_rv ++;
		}

		return t_rv;
	}

	public static function toArray(target:Object):Array
	{
		var t_rv:Array = null;

		for (var t_s:String in target)
		{
			if (t_rv == null)
				t_rv = [];

			t_rv.push(target[t_s]);
		}

		if (t_rv.length > 1)
			t_rv.reverse();

		return t_rv;
	}

	public static function copy(target:Object):Object
	{
		var t_rv:Object = new Function(target.__proto__.constructor)();
		p_copyProperties(t_rv, target);

		return t_rv;
	}

	private static function p_copyProperties(dstObj:Object, srcObj:Object):Void
	{
		var to:String = null;

		for (var i:String in srcObj)
		{
			to = typeof(srcObj[i]);

			if (to != 'function')
			{
				if (to == 'object')
				{
					if (srcObj[i] instanceof Array)
					{
						var p:Array = [];
						var q:Array = srcObj[i];

						var t_len:Number = q.length;

						for (var j:Number = 0; j < t_len; j++)
							p[j]= q[j];

						dstObj[i] = p;
					}
					else
					{
						if (srcObj[i] instanceof String)
						{
							dstObj[i] = new String(srcObj[i]);
						}
						else
						{
							if (srcObj[i] instanceof Number)
							{
								dstObj[i] = new Number(srcObj[i]);
							}
							else
							{
								if(srcObj[i] instanceof Boolean)
									dstObj[i] = new Boolean(srcObj[i]);
								else
									dstObj[i] = copy(srcObj[i]);
							}
						}
					}
				}

				else
				{
					dstObj[i] = srcObj[i];
				}

			} // if not a function
		} // for
	}
}