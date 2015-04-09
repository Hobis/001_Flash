/**
	@Name: ThumbListLogic
	@Author: HobisJung(jhb0b@naver.com)
	@Blog: http://blog.naver.com/jhb0b
	@Date: 2013-08-09
	@Using:
	{
	}
*/
package hbworks.uilogics
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	import hb.utils.DebugUtil;
	import hbworks.uilogics.ButtonLogic;
	import hbworks.uilogics.core.LogicCore;
	import hbworks.uilogics.events.ThumbListLogicEvent;
	import hbworks.uilogics.subClasses.AlignInfo;


	public class ThumbListLogic extends LogicCore
	{
		public function ThumbListLogic(
									container:DisplayObjectContainer,
									name:String = null,
									thumbProtoName:String = null,
									alignInfo:AlignInfo = null)
		{
			super(container, name);

			if (thumbProtoName == null)
			{
				thumbProtoName = 'ti_proto';
			}

			var t_mc:MovieClip = this.m_container[thumbProtoName];
			this.m_thumbProto = t_mc.constructor;
			this.m_thumbProto_w = t_mc.width;
			this.m_thumbProto_h = t_mc.height;
			this.m_container.removeChild(t_mc);


			if (alignInfo == null)
			{
				this.m_alignInfo = new AlignInfo(914, 10, 10);
			}
			else
			{
				this.m_alignInfo = alignInfo;
			}
		}

		// - 썸네일 아이템의 프로토클립
		private var m_thumbProto:Class = null;
		// - 썸네일 아이템의 넓이
		private var m_thumbProto_w:Number;
		// - 썸네일 아이템의 높이
		private var m_thumbProto_h:Number;

		// -
		private var m_alignInfo:AlignInfo = null;
		// ::
		public function get_alignInfo():AlignInfo
		{
			return this.m_alignInfo;
		}
		// ::
		public function set_alignInfo(alignInfo:AlignInfo):void
		{
			this.m_alignInfo = alignInfo;
		}


		// - 썸네일 아이템 배열
		private var m_thumbInfos:Array = null;
		// ::
		public function get_thumbInfos():Array
		{
			return this.m_thumbInfos;
		}

		// :: 생성하기
		public function create(thumbInfos:Array, pageThumbLen:int = 6):void
		{
			this.clear();
			this.m_thumbInfos = thumbInfos;
			this.m_pageThumbLen = pageThumbLen;
			this.p_pages_create();
		}

		// :: 클리어
		public function clear():void
		{
			if (this.m_thumbInfos != null)
			{
				this.p_thumbs_cont_clear();
				this.m_thumbInfos = null;

				this.m_thumbTotalLen = 0;
				this.m_pageThumbLen = 0;
				this.m_pageLen = 0;
				this.m_pageIndex = -1;
			}
		}


		// - 썸네일의 전채 총 개수
		private var m_thumbTotalLen:int;
		// ::
		public function get_thumbTotalLen():int
		{
			return this.m_thumbTotalLen;
		}

		// - 한페이지에 보여지는 썸네일의 총 개수
		private var m_pageThumbLen:int;
		// ::
		public function get_pageThumbLen():int
		{
			return this.m_pageThumbLen;
		}

		// - 페이지 전체 길이
		private var m_pageLen:int;
		// ::
		public function get_pageLen():int
		{
			return this.m_pageLen;
		}

		// - 페이지 현재 인덱스
		private var m_pageIndex:int = -1;
		// ::
		public function get_pageIndex():int
		{
			return this.m_pageIndex;
		}

		// -
		private var m_referIndex:Dictionary = null;

		// :: 현재 페이지 업데이트 후 페이지가 바뀐 여부 반환
		private function p_pages_update(pageIndex:int):Boolean
		{
			var t_rv:Boolean = false;

			if (this.m_thumbInfos != null)
			{
				if (pageIndex < 0)
				{
					pageIndex = 0;
				}
				else if (pageIndex >= this.m_pageLen)
				{
					pageIndex = this.m_pageLen - 1;
				}

				if (pageIndex != this.m_pageIndex)
				{
					this.dispatchEvent(new ThumbListLogicEvent(
										ThumbListLogicEvent.PAGE_UPDATE_START));

					this.m_pageIndex = pageIndex;

					//DebugUtil.test('p_pages_update');
					//DebugUtil.test('this.m_pageLen: ' + this.m_pageLen);
					//DebugUtil.test('this.m_pageIndex: ' + this.m_pageIndex);

					this.p_thumbs_create();

					this.dispatchEvent(new ThumbListLogicEvent(
										ThumbListLogicEvent.PAGE_UPDATE_END));

					t_rv = true;
				}
			}

			return t_rv;
		}

		// :: 썸네일 리스트 페이지와 섬네일 선택
		public function selectPage(pageIndex:int, thumbIndex:int = -1):void
		{
			if (this.m_thumbInfos != null)
			{
				if (this.p_pages_update(pageIndex))
				{
					this.selectThumb(thumbIndex);
				}
			}
		}

		// :: 썸네일 리스트 이전 페이지
		public function prevPage():void
		{
			if (this.m_thumbInfos != null)
			{
				if (this.p_pages_update(this.m_pageIndex - 1))
				{
					this.selectThumb(this.m_thumbLen - 1);
				}
			}
		}

		// :: 다음 페이지
		public function nextPage():void
		{
			if (this.m_thumbInfos != null)
			{
				if (this.p_pages_update(this.m_pageIndex + 1))
				{
					this.selectThumb(0);
				}
			}
		}

		// :: 전체 페이지 구성
		private function p_pages_create():void
		{
			if (this.m_thumbInfos != null)
			{
				this.m_thumbTotalLen = this.m_thumbInfos.length;
				this.m_pageLen = int(Math.ceil(this.m_thumbTotalLen / this.m_pageThumbLen));

//				DebugUtil.test('p_pages_create');
//				DebugUtil.test('this.m_thumbTotalLen: ' + this.m_thumbTotalLen);
//				DebugUtil.test('this.m_pageThumbLen: ' + this.m_pageThumbLen);
//				DebugUtil.test('this.m_pageLen: ' + this.m_pageLen);

				if (this.p_pages_update(0))
				{
					this.selectThumb(0);
				}
			}
		}

		// - 현재 페이지에 썸네일 개수
		private var m_thumbLen:int;
		// ::
		public function get_thumbLen():int
		{
			return this.m_thumbLen;
		}

		// - 현재 페이지에 선택한 썸네일 인덱스
		private var m_thumbIndex:int = -1;
		// :: 현재 페이지에 썸네일 인덱스 반환
		public function get_thumbIndex():int
		{
			return this.m_thumbIndex;
		}

		// :: 썸네일의 전체 인덱스 반환
		public function get_index():int
		{
			var t_rv:int = -1;
			if (this.m_thumbInfos != null)
			{
				t_rv = (this.m_pageThumbLen * this.m_pageIndex) + this.m_thumbIndex;
			}
			return t_rv;
		}

		// :: 썸네일의 전체 넘버 반환
		public function get_num():int
		{
			return this.get_index() + 1;
		}

		// :: 현재 페이지에 썸네일들 참조 반환
		public function get_thumbs():Array
		{
			var t_rv:Array = null;

			if (this.m_thumbInfos != null)
			{
				var t_la:uint = uint(this.m_container.numChildren), i:uint;
				for (i = 0; i < t_la; i++)
				{
					var t_mc:MovieClip = this.m_container.getChildAt(i) as MovieClip;
					if (t_mc != null)
					{
						if (t_rv == null)
							t_rv = [];

						t_rv.push(t_mc);
					}
				}
			}

			return t_rv;
		}

		// :: 현재 컨테이너에 썸네일 아이템 제거
		private function p_thumbs_cont_clear():void
		{
			var t_la:uint = uint(this.m_container.numChildren), i:uint;
			for (i = 0; i < t_la; i++)
			{
				var t_mc:MovieClip = this.m_container.getChildAt(0) as MovieClip;
				if (t_mc != null)
				{
					try
					{
						var t_bl:ButtonLogic = t_mc.d_bl;
						t_bl.removeEventListener(MouseEvent.CLICK, this.p_thumbs_item_click);
						t_bl.dispose();
						t_mc.d_bl = undefined;
					}
					catch (e:Error) {}

					this.m_container.removeChild(t_mc);
				}
			}

			this.m_thumbLen = 0;
			this.m_thumbIndex = -1;
		}

		// :: 썸네일 리스트 선택해제
		public function unselectThumb():void
		{
			if (this.m_thumbInfos != null)
			{
				if (this.m_thumbIndex > -1)
				{
					var t_mc:MovieClip = this.m_container.getChildAt(this.m_thumbIndex) as MovieClip;
					if (t_mc != null)
					{
						try
						{
							var t_bl:ButtonLogic = t_mc.d_bl;
							t_bl.selected = false;
							t_bl.enabled = true;
						}
						catch (e:Error) {}
					}

					this.m_thumbIndex = -1;
				}
			}
		}

		// :: 썸네일 리스트 썸네일 선택
		public function selectThumb(thumbIndex:int):void
		{
			if (this.m_thumbInfos != null)
			{
				if (thumbIndex < 0)
				{
					thumbIndex = 0;
				}
				else if (thumbIndex >= this.m_thumbLen)
				{
					thumbIndex = this.m_thumbLen - 1;
				}

				if (thumbIndex != this.m_thumbIndex)
				{
					var t_mc:MovieClip = this.m_container.getChildAt(thumbIndex) as MovieClip;
					if (t_mc != null)
					{
						this.unselectThumb();
						this.m_thumbIndex = thumbIndex;

						try
						{
							var t_bl:ButtonLogic = t_mc.d_bl;
							t_bl.selected = true;
							t_bl.enabled = false;
						}
						catch (e:Error) {}
					}

					this.dispatchEvent(new ThumbListLogicEvent(ThumbListLogicEvent.THUMBS_SELECT));
				}
			}
		}

		// :: 썸네일 리스트 전체에서 선택
		public function selectTotal(index:int):void
		{
			if (this.m_thumbInfos != null)
			{
				if (index < 0)
				{
					index = 0;
				}
				else if (index >= this.m_thumbTotalLen)
				{
					index = this.m_thumbTotalLen - 1;
				}


				var t_pageIndex:int = int(Math.floor(index / this.m_pageThumbLen));
				var t_thumbIndex:int = int(index % this.m_pageThumbLen);

//				DebugUtil.test('selectTotal');
//				DebugUtil.test('t_pageIndex: ' + t_pageIndex);
//				DebugUtil.test('t_thumbIndex: ' + t_thumbIndex);

				this.p_pages_update(t_pageIndex);
				this.selectThumb(t_thumbIndex);
			}
		}

		// :: 썸네일 리스트 이전 썸네일 선택
		public function prevThumb():void
		{
			this.selectTotal(this.get_index() - 1);
		}

		// :: 썸네일 리스트 다음 썸네일 선택
		public function nextThumb():void
		{
			this.selectTotal(this.get_index() + 1);
		}

		// ::
		private function p_thumbs_item_click(event:MouseEvent):void
		{
			var t_bl:ButtonLogic = event.currentTarget as ButtonLogic;
			var t_mc:MovieClip = t_bl.target;
			var t_index:int = t_mc.d_index;

			this.selectThumb(t_index);
		}

		// ::
		private function p_thumbs_create():void
		{
			this.p_thumbs_cont_clear();

			if (this.m_pageIndex < (this.m_pageLen - 1))
			{
				this.m_thumbLen = this.m_pageThumbLen;
			}
			else
			{
				this.m_thumbLen = this.m_thumbTotalLen % this.m_pageThumbLen;
				if (this.m_thumbLen == 0)
				{
					this.m_thumbLen = this.m_pageThumbLen;
				}
			}

			var t_hl:uint = uint(Math.floor(this.m_alignInfo.width / this.m_thumbProto_w));
			//trace(t_hl);
			for (var i:int = 0; i < this.m_thumbLen; i++)
			{
				var t_mc:MovieClip = (new m_thumbProto()) as MovieClip;
				t_mc.d_index = i;

				var t_bl:ButtonLogic = new ButtonLogic(t_mc, true);
				t_bl.addEventListener(MouseEvent.CLICK, this.p_thumbs_item_click);
				t_mc.d_bl = t_bl;

				t_mc.x = Math.round((this.m_thumbProto_w + this.m_alignInfo.marginX) * (i % t_hl));
				t_mc.y = Math.round((this.m_thumbProto_h + this.m_alignInfo.marginY) * Math.floor(i / t_hl));

				this.m_container.addChild(t_mc);
			}
		}
	}

}
