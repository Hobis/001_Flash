/**
	@Name: CountTask 넘버 카운팅 하기
	@Author: HobisJung
	@Date: 2013-12-09
	@Comment:
	{
	}
	@Using:
	{
	}
*/
package hb.useful
{
	public final class CountTask
	{
		// :: 생성자
		public function CountTask(countBegin:uint, countEnd:uint, plusValue:uint = 1):void
		{
			this.m_countBegin = countBegin;
			this.m_countEnd = countEnd;
			this.m_count = this.m_countBegin;
			this.m_plusValue = plusValue;
		}

		// :: 카운트 엔드
		public function get_countBegin():uint
		{
			return this.m_countBegin;
		}
		// - 카운트 시작
		private var m_countBegin:uint;

		// :: 카운트 엔드
		public function get_countEnd():uint
		{
			return this.m_countEnd;
		}
		// - 카운트 엔드
		private var m_countEnd:uint;

		// :: 카운트
		public function get_count():uint
		{
			return this.m_count;
		}
		// - 카운트
		private var m_count:uint;

		// :: 증가값 반환
		public function get_plusValue():uint
		{
			return this.m_plusValue;
		}
		// - 증가값
		private var m_plusValue:uint;


		// :: 리셋
		public function reset():void
		{
			this.m_count = this.m_countBegin;
		}

		// :: 다음 계산
		public function isLast():Boolean
		{
			var t_rv:Boolean = false;

			if (this.m_count < this.m_countEnd)
			{
				this.m_count += this.m_plusValue;
				if (this.m_count >= this.m_countEnd)
				{
					t_rv = true;
				}
			}
			else
			{
				t_rv = true;
			}

			//trace('this.m_countBegin: ' + this.m_countBegin);
			//trace('this.m_countEnd: ' + this.m_countEnd);
			//trace('this.m_count: ' + this.m_count);
			//trace('this.m_plusValue: ' + this.m_plusValue);

			return t_rv;
		}

	}
}
