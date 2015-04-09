/**
	@name: TextField Util
	@author: Hobis Jung
	@blog: http://blog.naver.com/jhb0b
	@date: 2011-01-03
*/
class hb.utils.TextFieldUtil
{
	public function TextFieldUtil()
	{
	}

	// :: Text Cutting
	public static function cutting(target:TextField, str:String, maxLength:Number, tailStr:String):Void
	{
		tailStr = (tailStr == undefined) ? '...' : tailStr;

		var i:Number, t_len:Number = str.length;
		var t_pushText:String = '';

		for (i = 0; i < t_len; i ++)
		{
			t_pushText = t_pushText + str.charAt(i);
			target.text = t_pushText;

			if (target.textWidth >= maxLength)
			{
				target.text += tailStr;

				break;
			}

		}
	}

}
