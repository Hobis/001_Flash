/**
	@Name: SliderLogicFrame
	@Author: HobisJung(jhb0b@naver.com)
	@Blog: http://blog.naver.com/jhb0b
	@Date: 2013-04-24
	@Using:
	{
		// # 본 클래스는 슬라이더바를 프래임방식으로 처리합니다.

		this.body_mc.d_mask = this.mask_mc;
		this.body_mc.d_basePos = this.mask_mc.y;
		this.body_mc.d_scrollSize = this.body_mc.height - this.mask_mc.height;
		this.body_mc.d_sliderLogic = new SliderLogicFrame(this.slider_1, null, SliderLogicFrame.TYPE_VERTICAL);
		this.body_mc.mask = this.body_mc.d_mask;
	}
*/
package hbworks.uilogics
{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	//import hb.utils.DebugUtil;
	import hb.utils.ObjectUtil;

	public final class SliderLogicFrame
	{
		// - 슬라이더 세로방향
		public static const TYPE_HORIZONTAL:String = 'horizontal';
		// - 슬라이더 가로방향
		public static const TYPE_VERTICAL:String = 'vertical';

		// - 슬라이더 업데이트
		public static const EVENT_TYPE_UPDATE:String = 'update';
		// - 슬라이더 마우스업
		public static const EVENT_TYPE_MOUSE_UP:String = 'mouseUp';
		// - 슬라이더 마우스다운
		public static const EVENT_TYPE_MOUSE_DOWN:String = 'mouseDown';

		// :: 생성자
		public function SliderLogicFrame(
								targetCont:MovieClip,
								rect:MovieClip = null,
								type:String = null,
								name:String = null)
		{
			this.m_targetCont = targetCont;
			this.m_rect = (rect == null) ?  this.m_targetCont.rect_mc : rect;
			this.m_type = type;
			this.m_name = name;
			this.m_stage = this.m_targetCont.stage;
			this.p_init_once();
		}

		// :: 마우스 무브 핸들러
		private function p_stage_mouseMove(event:MouseEvent):void
		{
			var t_v:Number;
			var t_ratio:Number;
			if (this.m_type == TYPE_HORIZONTAL)
			{
				t_v = this.m_targetCont.mouseX - this.m_rect.x;
				t_ratio = t_v / this.m_rect.width;
			}
			else if (this.m_type == TYPE_VERTICAL)
			{
				t_v = this.m_targetCont.mouseY - this.m_rect.y;
				t_ratio = t_v / this.m_rect.height;
			}

			if (t_ratio < 0)
			{
				t_ratio = 0;
			}
			else if (t_ratio > 1)
			{
				t_ratio = 1;
			}

			var t_frame:int = int(Math.round(t_ratio * (this.m_targetCont.totalFrames - 1))) + 1;
			this.m_targetCont.gotoAndStop(t_frame);

			event.updateAfterEvent();

			ObjectUtil.dispatchCallBack(this, {type: EVENT_TYPE_UPDATE});
		}

		// :: 마우스 업 핸들러
		private function p_stage_mouseUp(event:MouseEvent):void
		{
			this.m_stage.removeEventListener(MouseEvent.MOUSE_UP, this.p_stage_mouseUp);
			this.m_stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.p_stage_mouseMove);

			ObjectUtil.dispatchCallBack(this, {type: EVENT_TYPE_MOUSE_UP});
		}

		// :: 마우스 다운 핸들러
		private function p_mouseDown(event:MouseEvent):void
		{
			this.m_stage.addEventListener(MouseEvent.MOUSE_UP, this.p_stage_mouseUp);
			this.m_stage.addEventListener(MouseEvent.MOUSE_MOVE, this.p_stage_mouseMove);
			this.p_stage_mouseMove(new MouseEvent(MouseEvent.MOUSE_MOVE));

			ObjectUtil.dispatchCallBack(this, {type: EVENT_TYPE_MOUSE_DOWN});
		}

		// :: 초기화
		private function p_init_once():void
		{
			this.m_targetCont.gotoAndStop(1);
			this.m_targetCont.mouseChildren = false;
			this.m_targetCont.buttonMode = true;
			this.m_targetCont.addEventListener(MouseEvent.MOUSE_DOWN, this.p_mouseDown);
		}

		// - 슬라이더 타겟 무비클립 컨테이너
		private var m_targetCont:MovieClip = null;
		// ::
		public function get_targetCont():MovieClip
		{
			return this.m_targetCont;
		}

		// - 슬라이더 사각형 드래그 영역 무비클립
		private var m_rect:MovieClip = null;
		// ::
		public function get_rect():MovieClip
		{
			return this.m_rect;
		}

		// - 스테이지 참조
		private var m_stage:Stage = null;

		// - 슬라이더 타입
		private var m_type:String = null;
		// :: 슬라이더 타입 반환
		public function get_type():String
		{
			return this.m_type;
		}

		// - 객체 이름 설정
		private var m_name:String = null;
		// :: 객체 이름 반환
		public function get_name():String
		{
			return this.m_name;
		}

		// - 콜백 함수 선언 (eventObj:Object 인자 사용)
		public var onCallBack:Function = null;

		// :: 슬라이더 비율 반환
		public function get_ratio():Number
		{
			var t_rv:Number = (this.m_targetCont.currentFrame - 1) / (this.m_targetCont.totalFrames - 1);
			return t_rv;
		}
		// :: 슬라이더 비율 설정
		public function set_ratio(v:Number):void
		{
			if (v < 0)
			{
				v = 0;
			}
			else if (v > 1)
			{
				v = 1;
			}

			var t_frame:int = int(Math.round(v * (this.m_targetCont.totalFrames - 1))) + 1;
			this.m_targetCont.gotoAndStop(t_frame);
		}
	}

}
