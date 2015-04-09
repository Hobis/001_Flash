/**
	@Name: FPSTimer
	@Author: HobisJung(jhb0b@naver.com)
	@Blog: http://blog.naver.com/jhb0b
	@Date: 2013-07-23
	@Using:
	{

import hb.frame.FPSTimer;

function p_timer_onCallBack(eventObj:Object):void
{
	switch (eventObj.type)
	{
		case FPSTimer.EVENT_TYPE_UPDATE:
		{
			trace('this.m_timer.currentCount: ' + this.m_timer.get_currentCount());

			break;
		}

		case FPSTimer.EVENT_TYPE_UPDATE_END:
		{
			//trace('this.m_timer.currentCount: ' + this.m_timer.get_currentCount());

			//this.m_timer.reset();
			//this.m_timer.start();

			break;
		}
	}

	trace('this.m_timer.onCallBack');
	trace('eventObj.type: ' + eventObj.type);
}
var m_timer:FPSTimer = new FPSTimer(17, 20);
this.m_timer.onCallBack = this.p_timer_onCallBack;
this.m_timer.start();

	}
*/
package hb.frame
{
	import flash.display.Sprite;
	import flash.events.Event;
	import hb.utils.ObjectUtil;

	// 상속해서 쓰지마 ㅠㅠ
	public final class FPSTimer
	{
		// :: 생성자
		public function FPSTimer(delayFrame:int, repeatCount:int = 0)
		{
			this.set_delayFrame(delayFrame);
			this.set_repeatCount(repeatCount);
		}

		// :: 엔터프래임
		private function p_enterFrame(event:Event):void
		{
			if (this.m_nowFrame >= this.m_delayFrame)
			{
				this.m_nowFrame = 0;

				if
				(
					(this.m_repeatCount == 0) ||
					(this.m_currentCount < this.m_repeatCount)
				)
				{
					this.m_currentCount++;

					ObjectUtil.dispatchCallBack(this, {type: EVENT_TYPE_UPDATE});

					if
					(
						(this.m_repeatCount > 0) &&
						(this.m_currentCount >= this.m_repeatCount)
					)
					{
						this.stop();

						ObjectUtil.dispatchCallBack(this, {type: EVENT_TYPE_UPDATE_END});
					}
				}
				else
				{

				}
			}
			else
			{
				this.m_nowFrame++;
			}
		}

		// :: 리셋
		public function reset():void
		{
			this.stop();

			this.m_nowFrame = 0;
			this.m_currentCount = 0;
		}

		// :: 시작
		public function start():void
		{
			if (!this.m_running)
			{
				if
				(
					(this.m_repeatCount == 0) ||
					(this.m_currentCount < this.m_repeatCount)
				)
				{
					_USE_SPRITE.addEventListener(Event.ENTER_FRAME, this.p_enterFrame);

					this.m_running = true;
				}
			}
		}

		// :: 정지
		public function stop(frameReset:Boolean = false):void
		{
			if (this.m_running)
			{
				_USE_SPRITE.removeEventListener(Event.ENTER_FRAME, this.p_enterFrame);

				if (frameReset)
					this.m_nowFrame = 0;

				this.m_running = false;
			}
		}

		// :: 현재 진행중 여부
		public function get_running():Boolean
		{
			return this.m_running;
		}

		// :: 딜레이 프래임 반환
		public function get_delayFrame():int
		{
			return this.m_delayFrame;
		}
		// :: 딜레이 프래임 설정
		public function set_delayFrame(v:int):void
		{
			this.m_delayFrame = (v < 1) ? 1 : v;
		}

		// :: 현재 프래임 반환
		public function get_nowFrame():int
		{
			return this.m_nowFrame;
		}

		// :: 반복 카운트 반환
		public function get_repeatCount():int
		{
			return this.m_repeatCount;
		}
		// :: 반복 카운트 설정
		public function set_repeatCount(v:int):void
		{
			this.m_repeatCount = (v < 0) ? 0 : v;
		}

		// :: 현재 카운트 반환
		public function get_currentCount():int
		{
			return this.m_currentCount;
		}


		private static const _USE_SPRITE:Sprite = new Sprite();

		private var m_running:Boolean = false;

		private var m_delayFrame:int;
		private var m_nowFrame:int = 0;

		private var m_repeatCount:int;
		private var m_currentCount:int = 0;

		public var name:String = null;


		public static const EVENT_TYPE_UPDATE:String = 'update';
		public static const EVENT_TYPE_UPDATE_END:String = 'updateEnd';

		// - 콜백함수 참조 eventObj:Object = {type: '', ...} 를 인자로 넘김
		public var onCallBack:Function = null;

	}

}