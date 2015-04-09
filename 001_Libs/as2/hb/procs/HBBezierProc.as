/**
	@name : HBBezierProc
	@author : jungheebum(jhb0b@naver.com)
	@blog : http://blog.naver.com/jhb0b
	@date : 2009-04-02
*/
class hb.procs.HBBezierProc
{
	public function HBBezierProc()
	{
	}

	private static function p_ProcsNum(p0:Object, p1:Object, v:Number):Object
	{
		var tx:Number = p0.x + ((p1.x - p0.x) * v);
		var ty:Number = p0.y + ((p1.y - p0.y) * v);

		return {x: tx, y: ty};
	}

	private static function p_MultiplierLoop(points:Array, v:Number):Array
	{
		var ppArr:Array = [];
		var i:Number = 0;
		var total:Number = points.length-1;

		while (i < total)
		{
			ppArr.push(p_ProcsNum(points[i], points[(i + 1)], v));
			i++;
		}

		if (total > 1)
		{
			ppArr = p_MultiplierLoop(ppArr, v);
		}

		return ppArr;
	}

	public static function getValue(points:Array, v:Number):Object
	{
		var rv:Object = null;
		var t_arr:Array = p_MultiplierLoop(points, v);

		if (t_arr.length > 0)
		{
			rv = t_arr[0];
		}

		return rv;
	}

}