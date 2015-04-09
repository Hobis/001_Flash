/**	
	@Name: WrapLoader
	@Author: HobisJung
	@Date: 2013-08-28
	@Comment:
	{
		좀 사용하기 편하게 만든 로더
	}
	@Using:
	{
		import flash.events.Event;
		import flash.events.IOErrorEvent;
		import flash.events.ProgressEvent;
		import flash.net.URLRequest;
		import hb.useful.WrapLoader;
		
		
		// 사용법 1
		var t_wl:WrapLoader = new WrapLoader(this, null,
			function(event:Event):void
			{
				trace('event.type: ' + event.type);
			},
			function(event:ProgressEvent):void
			{
				trace('event.type: ' + event.type);
			},
			function(event:IOErrorEvent):void
			{
				trace('event.type: ' + event.type);
			}
		);
		t_wl.load_a('WrapLoader_Sub_1.swf');
		
		
		HB_Proxy.hb_frame_delayExcute(this,
			function():void
			{
				t_wl.dispose();
				t_wl = null;
			}, null, 30 * 3
		);
		
		// 사용법 2
		var t_wl2:WrapLoader = new WrapLoader(this, new URLRequest('WrapLoader_Sub_2.swf'),
			function(event:Event):void
			{
				trace('event.type: ' + event.type);
			},
			function(event:ProgressEvent):void
			{
				trace('event.type: ' + event.type);
			},
			function(event:IOErrorEvent):void
			{
				trace('event.type: ' + event.type);
			}
		);
		t_wl2.get_loader().x = 100;
		t_wl2.get_loader().y = 100;
		t_wl2.load();
	}
*/
package hb.useful
{
	import flash.display.Loader;
	import flash.display.LoaderInfo;	
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.IOErrorEvent;	
	import flash.events.ProgressEvent;	
	import flash.system.LoaderContext;
	import flash.net.URLRequest;


	public final class WrapLoader
	{
		// :: 생성자
		public function WrapLoader(
								container:DisplayObjectContainer = null,
								urlRequest:URLRequest = null,
								completeHandler:Function = null,
								progressHandler:Function = null,
								ioErrorHandler:Function = null):void
		{
			this.m_loader = new Loader();
			var t_loaderInfo:LoaderInfo = this.m_loader.contentLoaderInfo;

			if (container != null)
			{
				container.addChild(this.m_loader);
			}
			
			if (urlRequest != null)
			{
				this.m_urlRequest = urlRequest;
			}			

			if (completeHandler != null)
			{
				this.m_completeHandler = completeHandler;
				t_loaderInfo.addEventListener(Event.COMPLETE, this.m_completeHandler);
			}

			if (progressHandler != null)
			{
				this.m_progressHandler = progressHandler;
				t_loaderInfo.addEventListener(ProgressEvent.PROGRESS, this.m_progressHandler);
			}

			if (ioErrorHandler != null)
			{
				this.m_ioErrorHandler = ioErrorHandler;
				t_loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.m_ioErrorHandler);
			}
			else
			{
				t_loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.p_loader_ioError);
			}
		}
		
		// :: 완료 핸들러 반환
		public function get_completeHandler():Function
		{
			return this.m_completeHandler;
		}
		// - 완료 핸들러 참조
		private var m_completeHandler:Function = null;
		
		// :: 진행 핸들러 반환
		public function get_progressHandler():Function
		{
			return this.m_progressHandler;
		}
		// - 진행 핸들러 참조
		private var m_progressHandler:Function = null;
		
		// :: 에러 핸들러 반환
		public function get_ioErrorHandler():Function
		{
			return this.m_ioErrorHandler;
		}
		// - 에러 핸들러 참조
		private var m_ioErrorHandler:Function = null;		
		

		// :: 에러 핸들러 (기본용)
		private function p_loader_ioError(event:IOErrorEvent):void
		{
			var t_loaderInfo:LoaderInfo = this.m_loader.contentLoaderInfo;
			t_loaderInfo.removeEventListener(event.type, this.p_loader_ioError);

			trace('p_loader_ioError');
		}
		

		// :: 객체 폐기(재사용 안됨)
		public function dispose():void
		{
			this.close();
			
			var t_loaderInfo:LoaderInfo = this.m_loader.contentLoaderInfo;
			
			if (this.m_completeHandler != null)
			{
				t_loaderInfo.removeEventListener(Event.COMPLETE, this.m_completeHandler);
			}

			if (this.m_progressHandler != null)
			{
				t_loaderInfo.removeEventListener(ProgressEvent.PROGRESS, this.m_progressHandler);
			}

			if (this.m_ioErrorHandler != null)
			{
				t_loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.m_ioErrorHandler);
			}
			else
			{
				t_loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.p_loader_ioError);
			}
			
			var t_loaderCont:DisplayObjectContainer = this.m_loader.parent;
			if (t_loaderCont != null)
			{
				t_loaderCont.removeChild(this.m_loader);
			}
			
			this.m_loader = null;
		}

		// :: 닫기
		public function close(gc:Boolean = true):void
		{
			try
			{
				this.m_loader.close();
			}
			catch (e:Error) {}
			
			this.m_loader.unloadAndStop(gc);
		}

		// :: 로드
		public function load(urlRequest:URLRequest = null, lc:LoaderContext = null):void
		{
			this.close();
			
			if (urlRequest != null)
			{
				this.m_urlRequest = urlRequest;
				this.m_loader.load(this.m_urlRequest, lc);
			}
			else
			{
				if (this.m_urlRequest != null)
				{
					this.m_loader.load(this.m_urlRequest, lc);
				}
			}

		}
		
		// :: 로드 a
		public function load_a(url:String, lc:LoaderContext = null):void
		{
			this.load(new URLRequest(url), lc);
		}		
		
		
		// :: Url 객체 반환
		public function get_urlRequest():URLRequest
		{
			return this.m_urlRequest;
		}
		// - Url 객체
		private var m_urlRequest:URLRequest = null;		
		

		// :: 로더 컨테이너 반환
		public function get_loaderContainer():DisplayObjectContainer
		{
			return this.m_loader.parent;
		}
		// :: 로더 인포 반환
		public function get_loaderInfo():LoaderInfo
		{
			return this.m_loader.contentLoaderInfo;
		}		
		// :: 로더 객체 반환
		public function get_loader():Loader
		{
			return this.m_loader;
		}
		// - 로더 객체
		private var m_loader:Loader = null;
	}
}
