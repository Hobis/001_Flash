/**
	@Name: NumberUtil
	@Author: HobisJung(jhb0b@naver.com)
	@Blog: http://blog.naver.com/jhb0b
	@Date: 2013-02-18
	@Using:
	{
	}
*/
package hb.utils
{
	public final class NumberUtil
	{
		public function NumberUtil()
		{
		}

		// :: 실수인지 여부
		public function getIsFloat(v:Number):Boolean
		{
			var rv:Boolean = false;

			if ((v % 1) != 0) rv = true;

			return rv;
		}

		// :: 음수인지 여부
		public function getIsMinus(v:Number):Boolean
		{
			var rv:Boolean = false;

			if (v < 0) rv = true;

			return rv;
		}

		// :: 0부터 v-1까지의 난수를 반환
		public static function random(v:Number):Number
		{
			return Math.round(Math.random() * (v - 1));
		}

		// :: min에서 max사이의 난수를 발생
		public static function randRange(min:Number, max:Number):Number
		{
			return min + Math.round(Math.random() * (max - min));
		}

		// :: 홀수인지 여부
		public static function getIsOddEven(v:Number):Boolean
		{
			return ((v % 2) > 0);
		}

	}
}
