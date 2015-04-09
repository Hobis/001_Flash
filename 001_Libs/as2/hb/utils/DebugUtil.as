/**
	@name: Debug trace tool
	@author: Hobis Jung (jhb0b@naver.com)
	@blog: http://blog.naver.com/jhb0b
	@date: 2011-01-03
*/
class hb.utils.DebugUtil
{
	public function DebugUtil()
	{
	}

	public static function test(str:String):void
	{
		if (isDebug)
		{
			trace(fontMsg + str);
		}
	}

	public static var isDebug:Boolean = true;
	public static var fontMsg:String = '# [hb] ';

}
