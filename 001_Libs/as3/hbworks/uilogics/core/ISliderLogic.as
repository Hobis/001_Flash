/**
	@Name: SliderLogic Interface
	@Author: HobisJung(jhb0b@naver.com)
	@Blog: http://blog.naver.com/jhb0b
	@Date: 2013-04-17
*/
package hbworks.uilogics.core
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	public interface ISliderLogic
	{
		function get_type():String;
		function set_type(type:String):void;

		function get_thumb():DisplayObject;
		function set_thumb(thumb:DisplayObject):void;

		function get_track():DisplayObject;
		function set_track(track:DisplayObject):void;

		function get_ratio():Number;
		function set_ratio(v:Number):void;

		function rectAreaUpdate():void;
	}
}
