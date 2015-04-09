/**
	@Name: UILogic Object
	@Author: HobisJung(jhb0b@naver.com)
	@Blog: http://blog.naver.com/jhb0b
	@Date: 2013-04-17
*/
package hbworks.uilogics.core
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.events.EventDispatcher;

	public class UILogicObject extends EventDispatcher implements IContainerObserver
	{
		public function UILogicObject(container:DisplayObjectContainer, name:String = null)
		{
			if (container.stage == null)
			{
				throw new Error('UILogicObject::(This container is not added in stage.)');
			}
			else
			{
				this.m_container = container;

				if
				(
					(this.m_container != null) &&
					(this.m_container.stage != null)
				)
				{
					this.m_stage = this.m_container.stage;
				}

				this.set_name(name);
			}
		}

		// ----------------------------------------------------------------------------------------------------
		//	 IContainerObserver implements
		// ----------------------------------------------------------------------------------------------------
		// :: UI객체에 사용된 전체 컨테이너
		public function get_container():DisplayObjectContainer
		{
			return this.m_container;
		}

		// :: 네임 반환
		public function get_name():String
		{
			return this.m_name;
		}

		// :: 네임 설정
		public function set_name(name:String):void
		{
			this.m_name = name;
		}
		// ----------------------------------------------------------------------------------------------------


		// - Container
		protected var m_container:DisplayObjectContainer = null;
		// - Stage
		protected var m_stage:Stage = null;
		// - Name
		protected var m_name:String = null;
		// - Ready
		protected var m_isReady:Boolean = false;
		// - Work
		protected var m_isWork:Boolean = false;
	}

}
