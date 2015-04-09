/**
	@name: String Util
	@author: Hobis Jung
	@blog: http://blog.naver.com/jhb0b
	@date: 2011-01-03
*/
class hb.utils.StringUtil
{
	public function StringUtil()
	{
	}

	// :: String is last number
	public static function lastNumber(str:String, lastIndex:Number):String
	{
		var t_len:Number = str.length;
		var t_rv:String = str.substring(t_len - lastIndex, t_len);

		return t_rv;
	}

	// :: Is String
	public static function getIsEmpty(str:String):Boolean
	{
		var t_rv:Boolean = false;

		if ((str == null) || (str == '') || (str.split(' ').join('').length < 1))
		{
			t_rv = true;
		}

		return t_rv;
	}

	// :: Replace
	public static function replace(str:String, replaceFrom:String, replaceTo:String):String
	{
		return str.split(replaceFrom).join(replaceTo);
	}

	// :: Not Norewhitespace
	public static function notNoreWhite(sp:String):String
	{
		return sp.split(' ').join('');
	}

	// :: Make Number
	public static function makeNumber(str:String, num:Number, tokken:String):String
	{
		tokken = (tokken == undefined) ? '0' : tokken;

		var t_len:Number = num - str.length;
		var i:Number = 0;

		while (i < t_len)
		{
			str = tokken + str;

			i ++;
		}

		return str;
	}

	// :: Get price format number
	public static function priceFormat(str:String, unit:Number, transStr:String):String
	{
		unit = (unit == undefined) ? 3 : unit;
		transStr = (transStr == undefined) ? ',' : transStr;

		var t_rv:String = null;
		var t_len:Number = str.length;
		var i:Number = 0;

		while (i < t_len)
		{
			if (t_rv == null)
				t_rv = '';

			t_rv = str.charAt((t_len - 1) - i) + t_rv;

			if
			(
				(i < (t_len - 1)) &&
				((i % unit) == (unit - 1))
			)
				t_rv = transStr + t_rv;

			i ++;
		}

		return t_rv;
	}

	// :: Get Bytes
	public static function getBytes(str:String):Number
	{
		var t_rv:Number = 0;
		var t_len:Number = str.length;

		for (var i:Number = 0; i < t_len; i++)
		{
			t_rv = t_rv + ((escape(str.charAt(i)).length > 4) ? 2 : 1);
		}

		return t_rv;
	}
}