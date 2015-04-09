/**
	@name: External Util
	@author: Hobis Jung
	@blog: http://blog.naver.com/jhb0b
	@date: 2011-01-03
*/

import flash.external.ExternalInterface;

class hb.utils.ExternalUtil
{
	public function ExternalUtil()
	{
	}

	public static function takeURL(funcName:String, args:Array):Void
	{
		if (funcName == undefined) return;
		if (args == undefined) args = null;
		if (ExternalInterface.available)
		{
			ExternalInterface.call.apply(null, [funcName, args]);
		}
		else
		{
			var t_str:String = null;

			if (funcName == 'alert')
			{
				t_str = 'javascript:' + funcName + '(\'' + args + '\');';
			}
			else
			{
				t_str = 'javascript:' + funcName + '.apply(null, \'' + args + '\');';
			}

			getURL(t_str, '_self');
			//getURL('javascript:alert.apply(\'!!!\');', '_self');
		}
	}

/*
	public static function getSaillerList():Array {
		return saillerList;
	}
	public static function setSaillerList(funcName:String):Void {
		saillerList.push(funcName);
	}
	public static function removeSailler(funcName:String):Void {
		saillerList.push(funcName);
	}

	private var saillerList:Array = [];*/


}