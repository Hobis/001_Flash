/**
	@Name: Debug Trace Tool
	@Author: HobisJung(jhb0b@naver.com)
	@Blog: http://blog.naver.com/jhb0b
	@Date: 2013-02-18
*/
package hb.utils
{
	import flash.system.Capabilities;

	public final class DebugUtil
	{
		public function DebugUtil()
		{
		}

		public static function test(str:String):void
		{
			if (Capabilities.isDebugger)
			{
				if (isDebug)
				{
					trace(fontMsg + str);
				}
			}
		}

		public static var isDebug:Boolean = true;
		public static var fontMsg:String = '# [hb] ';
	}
}
