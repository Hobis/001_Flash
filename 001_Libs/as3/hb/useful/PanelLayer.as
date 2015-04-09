/**
	@Name: PanelLayer 선택하는 로직 단순화
	@Author: HobisJung
	@Date: 2013-08-29
	@Comment:
	{
	}
	@Using:
	{
	}
*/
package hb.useful
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import hb.utils.DisplayObjectContainerUtil;
	import hb.utils.StringUtil;
	

	public final class PanelLayer
	{
		// :: 생성자
		public function PanelLayer(cont:MovieClip, searchStr:String):void
		{
			this.m_cont = cont;
			this.m_searchStr = searchStr;
			this.m_panelLen = 0;
			DisplayObjectContainerUtil.contLoop(this.m_cont, searchStr, this.p_contLoop);
		}

		// :: 아이템들 반환
		public function get_cont():MovieClip
		{
			return this.m_cont;
		}
		// :: 아이템들
		private var m_cont:MovieClip = null;
		
		// :: 검색문자 반환
		public function get_searchStr():String
		{
			return this.m_searchStr;
		}
		// :: 검색문자
		private var m_searchStr:String = null;
		
		// :: 검색후 아이템 설정
		private function p_contLoop(cdo:DisplayObject, index:int):void
		{
			var t_mc:MovieClip = cdo as MovieClip;
			if (t_mc != null)
			{				
				try
				{
					t_mc.d_close();
				}
				catch (e:Error)
				{
					t_mc.visible = false;
				}
				
				try
				{
					t_mc.d_pause();
				}
				catch (e:Error) {}
				
				this.m_panelLen++;
			}
		}
		
		// - 패널 개수 반환
		public function get_panelLen():uint
		{
			return this.m_panelLen;
		}
		// - 패널 개수
		private var m_panelLen:uint;

		// :: 선택 해제
		public function unselect():void
		{
			if (this.m_nowPanel != null)
			{
				try
				{
					this.m_nowPanel.d_close();
				}
				catch (e:Error)
				{
					this.m_nowPanel.visible = false;
				}
				
				try
				{
					this.m_nowPanel.d_pause();
				}
				catch (e:Error) {}
				
				try
				{
					this.m_nowPanel.d_reset();
				}
				catch (e:Error) {}
				
				this.m_nowPanel = null;
			}
		}

		// :: 선택
		public function select(num:int):void
		{
			var t_nowPanel:MovieClip = this.m_cont[this.m_searchStr + num];
			if (t_nowPanel != null)
			{
				if (t_nowPanel != this.m_nowPanel)
				{
					this.unselect();
					
					this.m_nowPanel = t_nowPanel;					
					try
					{
						this.m_nowPanel.d_resume();
					}
					catch (e:Error) {}
					
					try
					{
						this.m_nowPanel.d_open();
					}
					catch (e:Error)
					{
						this.m_nowPanel.visible = true;
					}
				}
			}
		}
		
		// - 현재 선택중인 패널 번호 반환
		public function get_nowPanelNum():int
		{
			var t_num:int = -1;
			
			if (this.m_nowPanel != null)
			{
				t_num = StringUtil.getLastIndex(this.m_nowPanel.name);
			}
			
			return t_num;
		}
		// - 현재 선택중인 패널 반환
		public function get_nowPanel():MovieClip
		{
			return this.m_nowPanel;
		}
		// - 현재 선택중인 패널
		private var m_nowPanel:MovieClip = null;
		
		
		// :: 이전 패널 활성화
		public function prev():void
		{
			if (this.m_nowPanel != null)
			{
				var t_num:int = StringUtil.getLastIndex(this.m_nowPanel.name);
				this.select(t_num - 1);
			}
		}		
		// :: 다음 패널 활성화
		public function next():void
		{
			if (this.m_nowPanel != null)
			{
				var t_num:int = StringUtil.getLastIndex(this.m_nowPanel.name);
				this.select(t_num + 1);
			}			
		}
	}
}
