package hb.utils
{
	import flash.text.TextField;
/**
	@Name: TextFieldUtil
	@Author: HobisJung(jhb0b@naver.com)
	@Blog: http://blog.naver.com/jhb0b
	@Date: 2012-11-24
*/
	public final class TextFieldUtil
	{
		public function TextFieldUtil()
		{
		}

		// :: Text Cutting
		public static function lastCut(target:TextField, str:String,
										gan:Number, lastTakeStr:String = null):void
		{
			if (lastTakeStr == null)
				lastTakeStr = '...';

			var t_str:String = '';
			var t_la:Number = str.length;
			var i:uint;
			for (i = 0; i < t_la; i++)
			{
				t_str = t_str + str.charAt(i);
				target.text = t_str;

				if (target.textWidth >= gan)
				{
					target.appendText(lastTakeStr);
					break;
				}
			}
		}

	}
}
