/**
	@Name: FrameControl
	@Author: HobisJung(jhb0b@naver.com)
	@Blog: http://blog.naver.com/jhb0b
	@Date: 2012-12-25
	@Using:
	{
	}
*/
package hb.controls
{
	import flash.events.Event;
	import flash.display.MovieClip;

	public final class FrameControl
	{
		public function FrameControl(target:MovieClip)
		{
			this.m_target = target;
		}

		private function p_enterFrame(event:Event):void
		{
			var t_b:Boolean = false;

			if (this.m_valueDirection == 1)
				t_b = (this.m_nowValue >= this.m_endValue);
			else if (this.m_valueDirection == -1)
				t_b = (this.m_nowValue <= this.m_endValue);

			if (t_b)
			{
				this.stop();

				this.m_nowValue = this.m_endValue;
				this.p_update();

				// CallBack End
				if (this.onCallBack != null)
					this.onCallBack({type: 'end'});
			}
			else
			{
				this.m_nowValue = int(this.m_nowValue + (this.valueGap * this.m_valueDirection));
				this.p_update();

				// CallBack Update
				if (this.onCallBack != null)
					this.onCallBack({type: 'update'});
			}

			//trace('p_enterFrame');
		}

		private function p_update():void
		{
			this.m_target.gotoAndStop(this.m_nowValue);
		}

		public function to(endValue:int):void
		{
			this.m_endValue = endValue;
			this.m_nowValue = this.m_target.currentFrame;

			if (this.m_endValue < this.m_nowValue)
				this.m_valueDirection = -1;
			else if (this.m_endValue > this.m_nowValue)
				this.m_valueDirection = 1;
			else if (this.m_endValue == this.m_nowValue)
				return;

			ControlsProxy.useSprite.addEventListener(Event.ENTER_FRAME, this.p_enterFrame);
		}

		public function stop():void
		{
			ControlsProxy.useSprite.removeEventListener(Event.ENTER_FRAME, this.p_enterFrame);
		}

		public function get_target():MovieClip
		{
			return this.m_target;
		}

		public function get_endValue():int
		{
			return this.m_endValue;
		}

		public function get_nowValue():int
		{
			return this.m_nowValue;
		}


		private var m_target:MovieClip = null;

		private var m_endValue:int;
		private var m_nowValue:int;
		private var m_valueDirection:int;
		public var valueGap:int = 1;

		public var onCallBack:Function = null;
	}

}