/**
	@Name: SmoothControl
	@Author: HobisJung(jhb0b@naver.com)
	@Date: 2012-12-24
	@Using:
	{
		// :: SmoothControl Init
		var p_SmoothControl_init:Function = function():void
		{
			var t_mc:MovieClip = null;
			var t_sc:SmoothControl = null;

			t_mc = owner.sct_1;
			t_mc.mouseChildren = false;
			t_mc.buttonMode = true;
			t_sc = new SmoothControl(owner.sct_2, 'x');
			t_sc.onCallBack = function(eventObj:Object):void
			{
				trace('eventObj.type: ' + eventObj.type);
				trace('this.get_endValue(): ' + this.get_endValue());
				trace('this.get_nowValue(): ' + this.get_nowValue());
			};
			t_mc.d_sc = t_sc;
			t_mc.addEventListener(MouseEvent.ROLL_OUT,
				function(event:Event):void
				{
					var t_mc:MovieClip = event.currentTarget as MovieClip;
					var t_sc:SmoothControl = t_mc.d_sc;
					t_sc.to(88);
				}
			);
			t_mc.addEventListener(MouseEvent.ROLL_OVER,
				function(event:Event):void
				{
					var t_mc:MovieClip = event.currentTarget as MovieClip;
					var t_sc:SmoothControl = t_mc.d_sc;
					t_sc.to(172);
				}
			);
		};
	}
*/
package hb.controls
{
	import flash.events.Event;

	public final class SmoothControl
	{
		public function SmoothControl(target:Object, prop:String)
		{
			this.m_target = target;
			this.m_prop = prop;
		}

		private function p_enterFrame(event:Event):void
		{
			var t_dist:Number = this.m_endValue - this.m_nowValue;

			if (Math.abs(t_dist) < 1)
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
				this.m_nowValue = this.m_nowValue + (t_dist * this.speed);
				this.p_update();

				// CallBack Update
				if (this.onCallBack != null)
					this.onCallBack({type: 'update'});
			}

			//trace('p_enterFrame');
		}

		private function p_update():void
		{
			this.m_target[this.m_prop] = this.m_nowValue;
		}

		public function to(endValue:Number):void
		{
			this.m_endValue = endValue;
			this.m_nowValue = this.m_target[this.m_prop];

			ControlsProxy.useSprite.addEventListener(Event.ENTER_FRAME, this.p_enterFrame);
		}

		public function stop():void
		{
			ControlsProxy.useSprite.removeEventListener(Event.ENTER_FRAME, this.p_enterFrame);
		}

		public function get_target():Object
		{
			return this.m_target;
		}

		public function get_prop():String
		{
			return this.m_prop;
		}

		public function get_endValue():Number
		{
			return this.m_endValue;
		}

		public function get_nowValue():Number
		{
			return this.m_nowValue;
		}


		private var m_target:Object = null;
		private var m_prop:String = null;

		private var m_endValue:Number;
		private var m_nowValue:Number;
		public var speed:Number = .6;

		public var onCallBack:Function = null;
	}

}
