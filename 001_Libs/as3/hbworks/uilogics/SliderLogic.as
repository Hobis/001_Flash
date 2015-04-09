/**
	@Name: SliderLogic
	@Author: HobisJung(jhb0b@naver.com)
	@Blog: http://blog.naver.com/jhb0b
	@Date: 2013-07-23
	@Using:
	{

		import flash.events.Event;
		import hbworks.uilogics.SliderLogic;
		import hbworks.uilogics.events.SliderLogicEvent;

		var m_slider:SliderLogic = null;


		this.m_slider = new SliderLogic(this.slider_mc);
		this.m_slider.set_track(this.slider_mc.track_mc);
		this.m_slider.set_thumb(this.slider_mc.thumb_mc);
		this.m_slider.set_type(SliderLogic.TYPE_HORIZONTAL);
		this.m_slider.set_work(true);
		this.m_slider.ready();
		this.m_slider.addEventListener(SliderLogicEvent.THUMB_MOUSE_MOVE,
			function(event:SliderLogicEvent):void
			{
				trace(m_slider.get_ratio());
			}
		);


		this.m_slider = SliderLogic.acceptAuto(this.slider_mc);

	}
*/
package hbworks.uilogics
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import hb.utils.DebugUtil;
	import hbworks.uilogics.events.SliderLogicEvent;
	import hbworks.uilogics.core.IUILogic;
	import hbworks.uilogics.core.ISliderLogic;
	import hbworks.uilogics.core.UILogicObject;
	import hbworks.uilogics.subClasses.RectArea;

	public class SliderLogic extends UILogicObject implements IUILogic, ISliderLogic
	{
		// ----------------------------------------------------------------------------------------------------
		//	 Constructor
		// ----------------------------------------------------------------------------------------------------
		public function SliderLogic(container:DisplayObjectContainer, name:String = null)
		{
			super(container, name);
		}
		// ----------------------------------------------------------------------------------------------------


		// ----------------------------------------------------------------------------------------------------
		//	 Private Functions
		// ----------------------------------------------------------------------------------------------------
		// :: First drag info input
		private function p_rectAreaInput():void
		{
			// 한번만 생성
			if (this.m_rectArea == null)
			{
				this.m_rectArea = new RectArea();
				this.m_rectArea.thumbFirstX = this.m_thumb.x;
				this.m_rectArea.thumbFirstY = this.m_thumb.y;
			}

			this.m_rectArea.thumbX = this.m_rectArea.thumbFirstX;
			this.m_rectArea.thumbY = this.m_rectArea.thumbFirstY;
			this.m_rectArea.thumbWidth = this.m_thumb.width;
			this.m_rectArea.thumbHeight = this.m_thumb.height;
			this.m_rectArea.trackWidth = this.m_track.width;
			this.m_rectArea.trackHeight = this.m_track.height;
		}

		// :: First drag info update
		private function p_rectAreaUpdate(isInput:Boolean = false):void
		{
			if (isInput)
				this.p_rectAreaInput();

			this.m_rectArea.left = this.m_rectArea.thumbX;
			this.m_rectArea.width = this.m_rectArea.trackWidth -
				(this.m_rectArea.left + this.m_rectArea.thumbWidth + this.m_rectArea.left);
			this.m_rectArea.right = this.m_rectArea.left + this.m_rectArea.width;
			this.m_rectArea.top = this.m_rectArea.thumbY;
			this.m_rectArea.height = this.m_rectArea.trackHeight -
				(this.m_rectArea.top + this.m_rectArea.thumbHeight + this.m_rectArea.top);
			this.m_rectArea.bottom = this.m_rectArea.top + this.m_rectArea.height;
		}

		// :: Items Setting
		private function p_itemsSetting():void
		{
			this.m_thumb.addEventListener(MouseEvent.MOUSE_DOWN, this.p_thumbMouseDown);
			this.m_track.addEventListener(MouseEvent.MOUSE_DOWN, this.p_trackMouseDown);

			if (this.isButtonMode)
			{
				if (this.m_thumb is DisplayObjectContainer)
					DisplayObjectContainer(this.m_thumb).mouseChildren = false;
				if (this.m_track is DisplayObjectContainer)
					DisplayObjectContainer(this.m_track).mouseChildren = false;
				if (this.m_thumb is Sprite)
					Sprite(this.m_thumb).buttonMode = false;
				if (this.m_track is Sprite)
					Sprite(this.m_track).buttonMode = false;
			}
		}
		public var isButtonMode:Boolean = true;

		// :: Items Dispose
		private function p_itemsDispose():void
		{
			this.m_thumb.removeEventListener(MouseEvent.MOUSE_DOWN, this.p_thumbMouseDown);
			this.m_track.removeEventListener(MouseEvent.MOUSE_DOWN, this.p_trackMouseDown);

			this.m_stage.removeEventListener(MouseEvent.MOUSE_UP, this.p_stageMouseUp);
			this.m_stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.p_stageMouseMove);
		}

		// :: thumb 포지션 보정하기
		private function p_thumbPositionCorrection():void
		{
			if (this.m_type == TYPE_HORIZONTAL)
			{
				if (this.m_rectArea.thumbX < this.m_rectArea.left)
					this.m_rectArea.thumbX = this.m_rectArea.left;
				else if (this.m_rectArea.thumbX > this.m_rectArea.right)
					this.m_rectArea.thumbX = this.m_rectArea.right;
			}

			else if (this.m_type == TYPE_VERTICAL)
			{
				if (this.m_rectArea.thumbY < this.m_rectArea.top)
					this.m_rectArea.thumbY = this.m_rectArea.top;
				else if (this.m_rectArea.thumbY > this.m_rectArea.bottom)
					this.m_rectArea.thumbY = this.m_rectArea.bottom;
			}
		}

		// :: thumb 포지션 업데이트
		private function p_thumbPositionUpdate():void
		{
			if (this.m_type == TYPE_HORIZONTAL)
			{
				this.m_thumb.x = this.m_rectArea.thumbX;
			}
			else if (this.m_type == TYPE_VERTICAL)
			{
				this.m_thumb.y = this.m_rectArea.thumbY;
			}
		}
		// ----------------------------------------------------------------------------------------------------


		// ----------------------------------------------------------------------------------------------------
		//	 Internal Handlers
		// ----------------------------------------------------------------------------------------------------
		// :: Thumb 마우스 업
		private function p_stageMouseUp(event:MouseEvent):void
		{
			this.m_stage.removeEventListener(MouseEvent.MOUSE_UP, this.p_stageMouseUp);
			this.m_stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.p_stageMouseMove);

			var t_sle:SliderLogicEvent = new SliderLogicEvent(SliderLogicEvent.THUMB_MOUSE_UP);
			this.dispatchEvent(t_sle);
		}

		// :: Thumb 마우스 무브
		private function p_stageMouseMove(event:MouseEvent):void
		{
			if (this.m_type == TYPE_HORIZONTAL)
			{
				this.m_rectArea.thumbX = this.m_container.mouseX - this.m_rectArea.thumbMouseDownX;
			}
			else if (this.m_type == TYPE_VERTICAL)
			{
				this.m_rectArea.thumbY = this.m_container.mouseY - this.m_rectArea.thumbMouseDownY;
			}

			this.p_thumbPositionCorrection();
			this.p_thumbPositionUpdate();

			var t_sle:SliderLogicEvent = new SliderLogicEvent(SliderLogicEvent.THUMB_MOUSE_MOVE);
			this.dispatchEvent(t_sle);

			event.updateAfterEvent();
		}

		// ::
		private function p_thumbMouseDown(event:MouseEvent):void
		{
			// 컨텐트가 있을때만 실행
			if (this.m_isWork)
			{
				if (this.m_type == TYPE_HORIZONTAL)
				{
					//this.m_rectArea.thumbMouseDownX = this.m_thumb.mouseX;
					this.m_rectArea.thumbMouseDownX = this.m_container.mouseX - this.m_rectArea.thumbX;
				}
				else if (this.m_type == TYPE_VERTICAL)
				{
					//this.m_rectArea.thumbMouseDownY = this.m_thumb.mouseY;
					this.m_rectArea.thumbMouseDownY = this.m_container.mouseY - this.m_rectArea.thumbY;
				}

				this.m_stage.addEventListener(MouseEvent.MOUSE_UP, this.p_stageMouseUp);
				this.m_stage.addEventListener(MouseEvent.MOUSE_MOVE, this.p_stageMouseMove);

				var t_sle:SliderLogicEvent = new SliderLogicEvent(SliderLogicEvent.THUMB_MOUSE_DOWN);
				this.dispatchEvent(t_sle);
			}

		}

		private function p_trackMouseDown(event:MouseEvent):void
		{
			// 컨텐트가 있을때만 실행
			if (this.m_isWork)
			{
				if (this.m_type == TYPE_HORIZONTAL)
				{
					this.m_rectArea.thumbX = this.m_container.mouseX - Math.round(this.m_rectArea.thumbWidth / 2);
				}
				else if (this.m_type == TYPE_VERTICAL)
				{
					this.m_rectArea.thumbY = this.m_container.mouseY - Math.round(this.m_rectArea.thumbHeight / 2);
				}

				this.p_thumbPositionCorrection();
				this.p_thumbPositionUpdate();

				this.m_thumb.addEventListener(MouseEvent.MOUSE_DOWN, this.p_thumbMouseDown);
				this.p_thumbMouseDown(null);
				this.p_stageMouseMove(event);
			}
		}
		// ----------------------------------------------------------------------------------------------------


		// ----------------------------------------------------------------------------------------------------
		//	 Public Functions
		// ----------------------------------------------------------------------------------------------------
		// :: 간단한 사용 UI
		public static function acceptAuto(container:DisplayObjectContainer,
									trackName:String = 'track_mc',
									thumb:String = 'thumb_mc',
									name:String = null,
									type:String = null):SliderLogic
		{
			var t_sl:SliderLogic = new SliderLogic(container, name);
			t_sl.set_track(container[trackName]);
			t_sl.set_thumb(container[thumb]);
			t_sl.set_type((type == null) ? SliderLogic.TYPE_HORIZONTAL : type);
			t_sl.set_work(true);
			t_sl.ready();

			return t_sl;
		}
		// ----------------------------------------------------------------------------------------------------


		// ----------------------------------------------------------------------------------------------------
		//	 IUILogic implements
		// ----------------------------------------------------------------------------------------------------
		// :: 로직 작동준비 여부
		public function get_ready():Boolean
		{
			return this.m_isReady;
		}

		// :: 로직 작동중인지 여부
		public function get_work():Boolean
		{
			return this.m_isWork;
		}

		// :: 로직 작동유무 설정
		public function set_work(b:Boolean):void
		{
			this.m_isWork = b;
		}

		// :: 로직 리셋
		public function reset():void
		{
			if (this.m_type == TYPE_HORIZONTAL)
			{
				this.m_rectArea.thumbX = this.m_rectArea.thumbFirstX;
			}
			else if (this.m_type == TYPE_VERTICAL)
			{
				this.m_rectArea.thumbY = this.m_rectArea.thumbFirstY;
			}

			this.p_thumbPositionUpdate();
		}

		// :: 로직 작동준비
		public function ready():void
		{
			if (!this.m_isReady)
			{
				if
				(
					(this.m_stage != null) &&
					(this.m_container != null) &&
					(this.m_thumb != null) &&
					(this.m_track != null)
				)
				{
					this.p_rectAreaUpdate(true);
					this.p_itemsSetting();
					this.m_isReady = true;
				}
			}
			else
			{
				//DebugUtil.test('ready 중복 호출 무시됨');
			}
		}

		// :: 로직 객체 완전히 제거하기
		public function dispose():void
		{
			if (this.m_isReady)
			{
				this.reset();
				this.p_itemsDispose();

				this.m_type = null;
				this.m_container = null;
				this.m_stage = null;
				this.m_thumb = null;
				this.m_track = null;
				this.m_rectArea = null;
				this.m_isWork = false;
				this.m_isReady = false;
			}
			else
			{
				//DebugUtil.test('dispose 중복 호출 무시됨');
			}
		}
		// ----------------------------------------------------------------------------------------------------


		// ----------------------------------------------------------------------------------------------------
		//	 ISliderLogic implements
		// ----------------------------------------------------------------------------------------------------
		// :: 로직 타입 반환
		public function get_type():String
		{
			return this.m_type;
		}

		// :: 로직 타입 설정
		public function set_type(type:String):void
		{
			this.m_type = type;
		}

		// :: 로직에서 사용중인 썸네일객체 반환
		public function get_thumb():DisplayObject
		{
			return this.m_thumb;
		}

		// :: 로직에서 사용할 썸네일객체 설정
		public function set_thumb(thumb:DisplayObject):void
		{
			this.m_thumb = thumb;
		}

		// :: 로직에서 사용할 트랙 반환
		public function get_track():DisplayObject
		{
			return this.m_track;
		}

		// :: 로직에서 사용할 트랙 설정
		public function set_track(track:DisplayObject):void
		{
			this.m_track = track;
		}

		// :: 로직 슬라이더 비율값 반환
		public function get_ratio():Number
		{
			var t_rv:Number;

			if (this.m_type == TYPE_HORIZONTAL)
				t_rv = (this.m_rectArea.thumbX - this.m_rectArea.left) / this.m_rectArea.width;
			else if (this.m_type == TYPE_VERTICAL)
				t_rv = (this.m_rectArea.thumbY - this.m_rectArea.top) / this.m_rectArea.height;

			return t_rv;
		}

		// :: 로직 슬라이더 비율값 설정
		public function set_ratio(v:Number):void
		{
			if (this.m_isWork)
			{
				if (v < 0)
					v = 0;
				else if (v > 1)
					v = 1;


				var t_pos:Number;

				if (this.m_type == TYPE_HORIZONTAL)
				{
					t_pos = Math.round(this.m_rectArea.left + (v * this.m_rectArea.width));
					this.m_rectArea.thumbX = t_pos;
				}
				else if (this.m_type == TYPE_VERTICAL)
				{
					t_pos = Math.round(this.m_rectArea.top + (v * this.m_rectArea.height));
					this.m_rectArea.thumbY = t_pos;
				}

				this.p_thumbPositionUpdate();
			}
		}

		// :: 로직 슬라이더 영역 업데이트
		public function rectAreaUpdate():void
		{
			this.p_rectAreaUpdate(true);
		}
		// ----------------------------------------------------------------------------------------------------


		// ----------------------------------------------------------------------------------------------------
		//	Member Vars
		// ----------------------------------------------------------------------------------------------------
		public static const TYPE_HORIZONTAL:String = 'horizontal';
		public static const TYPE_VERTICAL:String = 'vertical';


		// - 슬라이더 타입 (스크롤 방향)
		private var m_type:String = null;
		// - 슬라이더 트랙
		private var m_track:DisplayObject = null;
		// - 슬라이더 썸네일
		private var m_thumb:DisplayObject = null;

		// - 슬라이더 작동 영역
		private var m_rectArea:RectArea = null;
		// ----------------------------------------------------------------------------------------------------
	}

}
