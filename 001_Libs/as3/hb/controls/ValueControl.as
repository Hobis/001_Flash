/**
	@Name: ValueControl
	@Author: HobisJung(jhb0b@naver.com)
	@Date: 2012-12-24
	@Using:
	{
		// :: ValueControl Init
		var p_ValueControl_init:Function = function():void
		{
			var t_mc:MovieClip = null;
			var t_vc:ValueControl = null;

			t_mc = owner.vct_1;
			t_mc.mouseChildren = false;
			t_mc.buttonMode = true;
			t_mc.alpha = .3;
			t_vc = new ValueControl(t_mc, 'alpha');
			t_vc.valueGap = .1;
			t_vc.onCallBack = function(eventObj:Object):void
			{
				trace('eventObj.type: ' + eventObj.type);
				trace('this.get_endValue(): ' + this.get_endValue());
				trace('this.get_nowValue(): ' + this.get_nowValue());
			};
			t_mc.d_vc = t_vc;
			t_mc.addEventListener(MouseEvent.ROLL_OUT,
				function(event:Event):void
				{
					var t_mc:MovieClip = event.currentTarget as MovieClip;
					var t_vc:ValueControl = t_mc.d_vc;
					t_vc.to(.1);
				}
			);
			t_mc.addEventListener(MouseEvent.ROLL_OVER,
				function(event:Event):void
				{
					var t_mc:MovieClip = event.currentTarget as MovieClip;
					var t_vc:ValueControl = t_mc.d_vc;
					t_vc.to(1);
				}
			);

			t_mc = owner.vct_2;
			t_mc.mouseChildren = false;
			t_mc.buttonMode = true;
			t_vc = new ValueControl(owner.vct_3, 'x', 316, 172);
			t_vc.valueGap = 13;
			t_vc.onCallBack = function(eventObj:Object):void
			{
				if (eventObj.type == 'end')
					trace('eventObj.type: ' + eventObj.type);
			};
			t_mc.d_vc = t_vc;
			t_mc.addEventListener(MouseEvent.ROLL_OUT,
				function(event:Event):void
				{
					var t_mc:MovieClip = event.currentTarget as MovieClip;
					var t_vc:ValueControl = t_mc.d_vc;
					t_vc.to(t_vc.get_minValue());
				}
			);
			t_mc.addEventListener(MouseEvent.ROLL_OVER,
				function(event:Event):void
				{
					var t_mc:MovieClip = event.currentTarget as MovieClip;
					var t_vc:ValueControl = t_mc.d_vc;
					t_vc.to(t_vc.get_maxValue());
				}
			);
		};
	}
*/
package hb.controls
{
	import flash.events.Event;

	public final class ValueControl
	{
		public function ValueControl(target:Object, prop:String,
										maxValue:Number = 1, minValue:Number = 0)
		{
			this.m_target = target;
			this.m_prop = prop;
			this.m_maxValue = maxValue;
			this.m_minValue = minValue;
		}

		private function p_enterFrame(event:Event):void
		{
			var t_dist:Number = this.m_endValue - this.m_nowValue;

			if (Math.abs(t_dist) < this.valueGap)
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
				this.m_nowValue  = this.m_nowValue + (this.valueGap * this.m_valueDirection);
				this.p_update();

				// CallBack Update
				if (this.onCallBack != null)
					this.onCallBack({type: 'update'});
			}

			//trace('p_enterFrame');
		}

		private function p_update():void
		{
			this.m_nowValue = this.p_correctValue(this.m_nowValue);
			this.m_target[this.m_prop] = this.m_nowValue;
		}

		private function p_correctValue(v:Number):Number
		{
			var t_rv:Number = v;

			if (t_rv > this.m_maxValue)
				t_rv = this.m_maxValue;
			else if (t_rv < this.m_minValue)
				t_rv = this.m_minValue;

			return t_rv;
		}

		public function to(endValue:Number):void
		{
			this.m_endValue = this.p_correctValue(endValue);
			this.m_nowValue = this.m_target[this.m_prop];

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

		public function get_target():Object
		{
			return this.m_target;
		}

		public function get_prop():String
		{
			return this.m_prop;
		}

		public function get_maxValue():Number
		{
			return this.m_maxValue;
		}

		public function get_minValue():Number
		{
			return this.m_minValue;
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

		private var m_maxValue:Number = 1;
		private var m_minValue:Number = 0;

		private var m_endValue:Number;
		private var m_nowValue:Number;
		private var m_valueDirection:int;
		public var valueGap:Number = .2;

		public var onCallBack:Function = null;
	}

}
