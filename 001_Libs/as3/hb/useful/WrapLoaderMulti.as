/**
	@Name: WrapLoaderMulti
	@Author: HobisJung
	@Date: 2013-08-28
	@Comment:
	{
		연속 로더
	}
	@Using:
	{

		import flash.net.URLRequest;
		import hb.useful.WrapLoader;
		import hb.useful.WrapLoaderMulti;


		var t_wlm:WrapLoaderMulti =
			new WrapLoaderMulti([
				new WrapLoader(this, new URLRequest('WrapLoader_Sub_1.swf')),
				new WrapLoader(this, new URLRequest('WrapLoader_Sub_2.swf')),
				new WrapLoader(this, new URLRequest('WrapLoader_Sub_1.swf')),
				new WrapLoader(this, new URLRequest('WrapLoader_Sub_2.swf')),
				new WrapLoader(this, new URLRequest('WrapLoader_Sub_1.swf')),
				new WrapLoader(this, new URLRequest('WrapLoader_Sub_2.swf')),
				new WrapLoader(this, new URLRequest('WrapLoader_Sub_1.swf')),
				new WrapLoader(this, new URLRequest('WrapLoader_Sub_2.swf')),
				new WrapLoader(this, new URLRequest('WrapLoader_Sub_1.swf')),
				new WrapLoader(this, new URLRequest('WrapLoader_Sub_2.swf'))
			]);
		t_wlm.onCallBack = function(eventObj:Object):void
		{
			trace('eventObj.type: ' + eventObj.type);
			trace('t_wlm.get_countEnd(): ' + t_wlm.get_countEnd());
			trace(numChildren);
		};
		t_wlm.load();
		trace(numChildren);

		HB_Proxy.hb_frame_delayExcute(this,
			function():void
			{
				t_wlm.dispose();
				t_wlm = null;

				trace(numChildren);
			}, null, 30 * 3
		);

	}
*/
package hb.useful
{
	import flash.display.DisplayObjectContainer;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import hb.utils.ObjectUtil;


	public final class WrapLoaderMulti
	{
		// :: 생성자
		public function WrapLoaderMulti(wls:Array)
		{
			this.m_wls = wls;

			this.m_countEnd = this.m_wls.length;
			this.m_count = 0;

			var t_la:uint = this.m_countEnd;
			var i:uint;
			for (i = 0; i < t_la; i++)
			{
				var t_wl:WrapLoader = this.m_wls[i];
				var t_loaderInfo:LoaderInfo = t_wl.get_loaderInfo();
				t_loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.p_ioErrorHandler);
				t_loaderInfo.addEventListener(Event.COMPLETE, this.p_completeHandler);
			}
		}

		// :: WrapLoader들 배열 반환
		public function get_wls():Array
		{
			return this.m_wls;
		}
		// - WrapLoader들 배열 참조
		private var m_wls:Array = null;


		// :: 로더들 완료 체킹
		public function p_loadedCheck():void
		{
			if (this.m_count < this.m_countEnd)
			{
				this.m_count++;
				if (this.m_count >= this.m_countEnd)
				{
					ObjectUtil.dispatchCallBack(this, {type: EVENT_TYPE_COMPLETE});
				}
			}
		}
		// :: 로드 카운트 끝 반환
		public function get_countEnd():uint
		{
			return this.m_countEnd;
		}
		// - 로드 카운트 끝
		private var m_countEnd:uint;

		// :: 로드 카운트 반환
		public function get_count():uint
		{
			return this.m_count;
		}
		// - 로드 카운트
		private var m_count:uint;

		// :: 로더들 실패 핸들러
		private function p_ioErrorHandler(event:IOErrorEvent):void
		{
			this.p_loadedCheck();
		}
		// :: 로더들 완료 핸들러
		private function p_completeHandler(event:Event):void
		{
			this.p_loadedCheck();
		}

		// :: 객체 폐기
		public function dispose():void
		{
			for each (var t_wl:WrapLoader in this.m_wls)
			{
				var t_loaderInfo:LoaderInfo = t_wl.get_loaderInfo();
				t_loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.p_ioErrorHandler);
				t_loaderInfo.removeEventListener(Event.COMPLETE, this.p_completeHandler);
				t_wl.dispose();
			}

			this.m_wls = null;
			this.onCallBack = null;
		}

		// :: 닫기
		public function close():void
		{
			for each (var t_wl:WrapLoader in this.m_wls)
			{
				t_wl.close();
			}
		}

		// :: 로드
		public function load():void
		{
			this.m_count = 0;

			for each (var t_wl:WrapLoader in this.m_wls)
			{
				t_wl.load();
			}
		}


		// - [콜백 이벤트 타입]
		public static const EVENT_TYPE_COMPLETE:String = Event.COMPLETE;

		// - 콜백 함수 참조
		public var onCallBack:Function = null;
	}
}
