/**
	@Name: ButtonLogic
	@Author: HobisJung(jhb0b@naver.com)
	@Blog: http://blog.naver.com/jhb0b
	@Date: 2013-02-18
	@Using:
	{
		// 	타겟이 되는 MovieClip의 프래임 정보
		//	#_0: Unselect_Out
		//	#_1: Unselect_Over
		//	#_2: Unselect_Down
		//	#_3: Unselect_Out
		//	#_4: Unselect_Over
		//	#_5: Unselect_Down

		import hbworks.uilogics.ButtonLogic;
		import flash.events.MouseEvent;

		function p_init():void
		{
			var t_bl:ButtonLogic = new ButtonLogic(this.rect_mc, true);
			t_bl.enabled = false;
			t_bl.addEventListener(MouseEvent.CLICK,
				function(event:Event):void
				{
					t_bl2.selected = !t_bl2.selected;
				}
			);

			var t_bl2:ButtonLogic = new ButtonLogic(this.check_mc, true);
			//t_bl2.isListMode = true;
			t_bl2.addEventListener(MouseEvent.CLICK,
				function(event:Event):void
				{
					t_bl.selected = t_bl2.selected;
				}
			);
		}

		this.p_init();
	}
*/
package hbworks.uilogics
{
	import flash.display.MovieClip;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import hb.utils.DebugUtil;
	import hb.utils.StringUtil;

	public class ButtonLogic extends EventDispatcher
	{
		// ----------------------------------------------------------------------------------------------------
		//	 Initialize
		// ----------------------------------------------------------------------------------------------------
		// :: 생성자
		public function ButtonLogic(target:MovieClip, isUseToggle:Boolean = false)
		{
			this.m_target = target;
			this.m_isUseToggle = isUseToggle;
			this.p_setEnabled(true);
		}

		// :: 객체 활성화 설정
		private function p_setEnabled(b:Boolean):void
		{
			if (b != this.m_enabled)
			{
				this.m_enabled = b;

				if (this.m_enabled)
				{
					this.m_target.mouseChildren = false;
					this.m_target.buttonMode = true;
					this.m_target.addEventListener(MouseEvent.ROLL_OVER, this.p_target_moodc);
					this.m_target.addEventListener(MouseEvent.ROLL_OUT, this.p_target_moodc);
					this.m_target.addEventListener(MouseEvent.MOUSE_DOWN, this.p_target_moodc);
					this.m_target.addEventListener(MouseEvent.MOUSE_UP, this.p_target_moodc);
					this.m_target.addEventListener(MouseEvent.CLICK, this.p_target_moodc);
				}
				else
				{
					this.m_target.mouseChildren = true;
					this.m_target.buttonMode = false;
					this.m_target.removeEventListener(MouseEvent.ROLL_OVER, this.p_target_moodc);
					this.m_target.removeEventListener(MouseEvent.ROLL_OUT, this.p_target_moodc);
					this.m_target.removeEventListener(MouseEvent.MOUSE_DOWN, this.p_target_moodc);
					this.m_target.removeEventListener(MouseEvent.MOUSE_UP, this.p_target_moodc);
					this.m_target.removeEventListener(MouseEvent.CLICK, this.p_target_moodc);
					this.p_stage_mu(null);
				}
			}
		}
		// ----------------------------------------------------------------------------------------------------


		// ----------------------------------------------------------------------------------------------------
		//	 Private Functions
		// ----------------------------------------------------------------------------------------------------
		// :: Target MouseEvent Handler(out, over, down, click)
		private function p_target_moodc(event:MouseEvent):void
		{
			switch (event.type)
			{
				case MouseEvent.ROLL_OUT:
				{
					this.p_gotoFrame(this.m_baseFrame + 0);

					break;
				}
				case MouseEvent.ROLL_OVER:
				{
					if (this.m_isDown)
						this.p_gotoFrame(this.m_baseFrame + 2);
					else
						this.p_gotoFrame(this.m_baseFrame + 1);

					break;
				}
				case MouseEvent.MOUSE_UP:
				{

					break;
				}
				case MouseEvent.MOUSE_DOWN:
				{
					this.m_isDown = true;
					this.target.stage.addEventListener(MouseEvent.MOUSE_UP, this.p_stage_mu);
					this.p_gotoFrame(this.m_baseFrame + 2);

					break;
				}
				case MouseEvent.CLICK:
				{
					if (this.isListMode)
					{
					}
					else
					{
						if (this.m_isUseToggle)
							this.p_setToggle(!this.m_selected);
					}

					this.p_gotoFrame(this.m_baseFrame + 1);

					break;
				}
			}


			this.dispatchEvent(event);

			event.updateAfterEvent();

			//DebugUtil.test('p_target_moodc');
			//DebugUtil.test('event.type: ' + event.type);
		}

		// :: Stage Mouse (Up, Down)
		private function p_stage_mu(event:MouseEvent):void
		{
			this.target.stage.removeEventListener(MouseEvent.MOUSE_UP, this.p_stage_mu);
			this.m_isDown = false;
		}

		// :: 타겟 프래임 이동
		private function p_gotoFrame(frame:int):void
		{
			const t_FIRST_STR:String = '#_';
			var t_label:String = t_FIRST_STR + frame;

			try
			{
				this.m_target.gotoAndStop(t_label);
			}
			catch (e:Error) {}

			//DebugUtil.test('t_label: ' + t_label);
		};

		// :: 토글버튼 설정
		private function p_setToggle(b:Boolean):void
		{
			this.m_selected = b;

			if (this.m_selected)
			{
				this.m_baseFrame = _TOGGLE_FRAME_UINT;
			}
			else
			{
				this.m_baseFrame = 0;
			}
		}
		// ----------------------------------------------------------------------------------------------------


		// ----------------------------------------------------------------------------------------------------
		//	 Public Functions
		// ----------------------------------------------------------------------------------------------------
		// :: 버튼 타겟 반환
		public function get target():MovieClip
		{
			return this.m_target;
		}

		// :: 객체 활성화 상태 반환
		public function get enabled():Boolean
		{
			return this.m_enabled;
		}

		// :: 객체 활성화 설정
		public function set enabled(b:Boolean):void
		{
			this.p_setEnabled(b);
		}

		// :: Selected Getter
		public function get selected():Boolean
		{
			var t_rv:Boolean = false;

			if (this.m_isUseToggle)
			{
				t_rv = this.m_selected;
			}

			return t_rv;
		}

		// :: SetSelectedIndex
		private function p_setSelected(b:Boolean, isEvent:Boolean = false):void
		{
			if (this.m_isUseToggle)
			{
				if (b != this.m_selected)
				{
					this.p_setToggle(b);

					var t_v:int = StringUtil.getLastIndex2(this.target.currentFrameLabel) % _TOGGLE_FRAME_UINT;
					this.p_gotoFrame(this.m_baseFrame + t_v);

					if (isEvent)
						this.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
				}
			}
		}

		// :: Selected Setter
		public function set selected(b:Boolean):void
		{
			this.p_setSelected(b);
		}

		// :: Selected후 이벤트 발생시키기
		public function set selectedDispatch(b:Boolean):void
		{
			this.p_setSelected(b, true);
		}

		// :: 객체제거
		public function dispose():void
		{
			this.p_setEnabled(false);
			this.m_target.gotoAndStop(1);
			this.m_target = null;
		}
		// ----------------------------------------------------------------------------------------------------


		// ----------------------------------------------------------------------------------------------------
		//	Member Vars
		// ----------------------------------------------------------------------------------------------------
		private var m_target:MovieClip = null;
		private var m_enabled:Boolean = false;

		private var m_isUseToggle:Boolean = false;
		private var m_isDown:Boolean = false;

		private static const _TOGGLE_FRAME_UINT:int = 3;
		private var m_baseFrame:int = 0;

		private var m_selected:Boolean = false;

		public var isListMode:Boolean = false;
		public var name:String = null;
		// ----------------------------------------------------------------------------------------------------
	}

}
