/**
	@Name: UILogic Interface
	@Author: HobisJung(jhb0b@naver.com)
	@Blog: http://blog.naver.com/jhb0b
	@Date: 2013-04-17
*/
package hbworks.uilogics.core
{
	public interface IUILogic
	{
		function get_ready():Boolean;

		function get_work():Boolean;
		function set_work(b:Boolean):void;

		function reset():void;

		function ready():void;

		function dispose():void;
	}
}
