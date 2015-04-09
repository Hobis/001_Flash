/**
	@Name: SliderLogicEvent
	@Author: Hobis Jung
	@Data: 2011-01-04
	@Using:
	{
	}
*/
package hbworks.uilogics.events
{
	import flash.events.Event;

	public class SliderLogicEvent extends Event
	{
		public function SliderLogicEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}

		public static const THUMB_MOUSE_UP:String = 'thumbMouseUp';
		public static const THUMB_MOUSE_DOWN:String = 'thumbMouseDown';
		public static const THUMB_MOUSE_MOVE:String = 'thumbMouseMove';
		public static const RESIZE:String = Event.RESIZE;
	}

}
