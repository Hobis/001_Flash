/**
	@Name: IContainerObserver
	@Author: HobisJung(jhb0b@naver.com)
	@Blog: http://blog.naver.com/jhb0b
	@Date: 2013-04-17
*/
package hbworks.uilogics.core
{
	import flash.display.DisplayObjectContainer;

	public interface IContainerObserver
	{
		function get_container():DisplayObjectContainer;
		//function set_container(container:DisplayObjectContainer):void;

		function get_name():String;
		function set_name(name:String):void;
	}
}
