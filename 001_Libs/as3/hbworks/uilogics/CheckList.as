/**
	@Name: CheckList
	@Author: HobisJung(jhb0b@naver.com)
	@Blog: http://blog.naver.com/jhb0b
	@Date: 2013-02-18
	@Using:
	{
	}
*/
package hbworks.uilogics
{
	import flash.display.MovieClip;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	import hb.utils.DebugUtil;
	import hb.utils.StringUtil;
	import hbworks.uilogics.ButtonLogic;
	import hbworks.uilogics.events.CheckListEvent;

	public class CheckList extends EventDispatcher
	{
		// :: 생성자
		public function CheckList(targets:Array, selectedIndex:int = -1)
		{
			this.p_item_setting(targets);
			this.p_setEnabled(true);
			this.p_setSelectedIndex(selectedIndex);
		}

		// :: 아이템 초기 설정
		private function p_item_setting(targets:Array):void
		{
			var t_bl:ButtonLogic = null;
			var t_la:uint = targets.length;
			var i:uint;
			this.m_items = new Array();

			for (i = 0; i < t_la; i ++)
			{
				t_bl = new ButtonLogic(targets[i], true);
				t_bl.isListMode = true;
				t_bl.name = 'bl_' + i;
				t_bl.addEventListener(MouseEvent.CLICK, this.p_item_click);
				this.m_items.push(t_bl);
			}
		}

		// :: 아이템 클릭
		private function p_item_click(event:MouseEvent):void
		{
			var t_bl:ButtonLogic = event.currentTarget as ButtonLogic;
			var t_blIndex:int = StringUtil.getLastIndex2(t_bl.name);

			this.p_setSelectedIndex(t_blIndex, true);

			//DebugUtil.test('p_item_click');
			//DebugUtil.test('t_blIndex: ' + t_blIndex);
		}

		// :: 객체 활성화 설정
		private function p_setEnabled(b:Boolean):void
		{
			if (b != this.m_enabled)
			{
				this.m_enabled = b;


				var t_bl:ButtonLogic = null;
				var t_la:uint = this.m_items.length;
				var i:uint;

				for (i = 0; i < t_la; i ++)
				{
					t_bl = this.m_items[i];
					t_bl.enabled = this.m_enabled;
				}
			}
		}

		// :: 버튼 타겟들 반환
		public function get items():Array
		{
			return this.m_items;
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

		// :: SelectedIndex Setter
		public function get selectedIndex():int
		{
			return this.m_selectIndex;
		}

		// :: UnSetSelectedIndex
		private function p_unSelectedIndex():void
		{
			if (this.m_selectIndex > -1)
			{
				var t_item:ButtonLogic = this.m_items[this.m_selectIndex];
				t_item.selected = false;
				this.m_selectIndex = -1;
			}
		}

		// :: SetSelectedIndex
		private function p_setSelectedIndex(index:int, isEvent:Boolean = false):void
		{
			if (this.m_items != null)
			{
				var t_yetIndex:int = this.m_selectIndex;

				// - Selected
				if
				(
					(index > -1) &&
					(index < this.m_items.length)
				)
				{
					var t_item:ButtonLogic = null;

					if (index != this.m_selectIndex)
					{
						this.p_unSelectedIndex();

						this.m_selectIndex = index;
						t_item = this.m_items[this.m_selectIndex];
						t_item.selected = true;
					}
					else
					{
						if (this.isToggleMode)
							this.p_unSelectedIndex();
						else
							isEvent = false;
					}
				}

				// - UnSelected
				else if (index == -1)
				{
					if (this.isToggleMode)
						this.p_unSelectedIndex();
				}

				if (isEvent)
				{
					var t_event:CheckListEvent = new CheckListEvent(CheckListEvent.CHANGE);
					t_event.selectedIndex = this.m_selectIndex;
					t_event.yetIndex = t_yetIndex;
					this.dispatchEvent(t_event);
				}
			}
		}

		// :: SelectedIndex Setter
		public function set selectedIndex(index:int):void
		{
			this.p_setSelectedIndex(index);
		}

		// :: Selected후 이벤트 발생시키기
		public function set selectedIndexDispatch(index:int):void
		{
			this.p_setSelectedIndex(index, true);
		}

		// :: 특정 인덱스에 아이템 반환
		private function p_getItemAt(index:int):ButtonLogic
		{
			var t_rv:ButtonLogic = null;

			if (this.m_items != null)
			{
				if
				(
					(index > -1) &&
					(index < this.m_items.length)
				)
				{
					t_rv = this.m_items[index];
				}

			}

			return t_rv;
		}

		// :: 선택된 객체 번환
		public function get selectedItem():ButtonLogic
		{
			return this.p_getItemAt(this.m_selectIndex);
		}

		// ::
		public function getItemAt(index:int):ButtonLogic
		{
			return this.p_getItemAt(index);
		}

		// :: 객체제거
		public function dispose():void
		{
			this.p_setEnabled(false);

			if (this.m_items != null)
			{
				var t_bl:ButtonLogic = null;
				var t_la:uint = this.m_items.length;
				var i:uint;

				for (i = 0; i < t_la; i ++)
				{
					t_bl = this.m_items[i];
					t_bl.dispose();
				}

				this.m_items = null;
			}
		}


		private var m_items:Array = null;
		private var m_selectIndex:int = -1;

		private var m_enabled:Boolean = false;

		public var isToggleMode:Boolean = false;
		public var name:String = null;
	}
}
