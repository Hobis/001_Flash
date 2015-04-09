/**
	@Name: CheckListEvent
	@Author: Hobis Jung
	@Data: 2011-01-04
	@Using:
	{
	}
*/
package hbworks.uilogics.events
{
	import flash.events.Event;

	public class CheckListEvent extends Event
	{
		public function CheckListEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}

		public static const CHANGE:String = Event.CHANGE;
		
		public var selectedIndex:int;
		public var yetIndex:int;
	}

}
