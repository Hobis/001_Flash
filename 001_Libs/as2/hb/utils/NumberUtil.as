/**
	@name: Number Util
	@author: Hobis Jung
	@blog: http://blog.naver.com/jhb0b
	@date: 2011-01-03
*/
class hb.utils.NumberUtil
{
	public function NumberUtil()
	{
	}

	public function getIsFloat(v:Number):Boolean
	{
		var t_rv:Boolean = false;

		if ((v % 1) != 0) t_rv = true;

		return t_rv;
	}

	public function getIsMinus(v:Number):Boolean
	{
		var t_rv:Boolean = false;

		if (v < 0) t_rv = true;

		return t_rv;
	}

	// :: random
	public static function random(vn:Number):Number
	{
		return Math.round(Math.random() * (vn - 1));
	}

	// :: random min max
	public static function randRange(min:Number, max:Number):Number
	{
		return Math.floor(Math.random() * (max - min + 1)) + min;
	}

	// :: random min max Not Math.floor
	public static function getRandom(min:Number, max:Number):Number
	{
		return (Math.random() * (max - min)) + min;
	}

}