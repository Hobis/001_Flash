/**
	@name : FPSTimer
	@author : jungheebum(jhb0b@naver.com)
	@blog : http://blog.naver.com/jhb0b
	@date : 2009-06-28
	@using :
	{
		import hb.frame.FPSTimer;

		var timer:FPSTimer = new FPSTimer(10, 10, _root);
		timer.onTimer = function(nc:Number, tc:Number)
		{
			trace('### onTimer ############################');
			trace('# now count :: '+nc);
			trace('# total count :: '+tc);
		};
		timer.onTimerComplete = function(nc:Number, tc:Number)
		{
			trace('### onTimerComplete ######################');
			trace('# now count :: '+nc);
			trace('# total count :: '+tc);
		};

		timer.start();

		this.onMouseDown = function()
		{
			timer.reset();
			timer.start();
		};
	}
*/
class hb.frame.FPSTimer
{
	// ---------------------------------------------------------------------------------------------------
	//
	//	Initialize
	//
	// ---------------------------------------------------------------------------------------------------
	public function FPSTimer(delay:Number, repeatCount:Number, scope:Object, index:Number)
	{
		this.p_init(delay, repeatCount, scope, index);
	}

	private function p_init(delay:Number, repeatCount:Number, scope:Object, index:Number):Void
	{
		this.delay = delay;
		this.repeatCount = repeatCount;
		this.__scope = scope;
		if (index == undefined) index = __SCOPE_INDEX;
		this.__bef_mc = this.__scope.createEmptyMovieClip(__SCOPE_NAME, index);
	}
	// ---------------------------------------------------------------------------------------------------

	public function removeScope():Void
	{
		this.__bef_mc.onEnterFrame = null;
		this.__bef_mc.removeMovieClip();
		this.__bef_mc = null;
	}

	public function reset():Void
	{
		if (this.isRunning) this.stop();
		this.__iLoop = 0;
		this.__iCount = 0;
	}

	public function start():Void
	{
		if (this.isRunning) return;

		this.isRunning = true;

		this.__iLoop = 0;

		var o:Object = this;
		this.__bef_mc.onEnterFrame = function():Void
		{
			if (o.__iLoop >= o.delay)
			{
				o.__iCount++;
				o.__iLoop = 0;

				if (o.onTimer != null)
				{
					o.onTimer(o.__iCount, o.repeatCount);
				}

				if ((o.__iCount >= o.repeatCount) && (o.repeatCount > 0))
				{
					o.stop();

					if (o.onTimerComplete != null)
					{
						o.onTimerComplete(o.__iCount, o.repeatCount);
					}

					return;
				}

			}

			//trace(o.__iLoop);
			o.__iLoop++;

		};

	}

	public function stop():Void
	{
		this.isRunning = false;
		this.__bef_mc.onEnterFrame = null;
	}

	public function setInfo(delay:Number, repeatCount:Number):Void
	{
		this.delay = delay;
		this.repeatCount = repeatCount;
	}


	// ---------------------------------------------------------------------------------------------------
	//
	//	Property's
	//
	// ---------------------------------------------------------------------------------------------------
	private static var __SCOPE_INDEX:Number = 990088;
	private static var __SCOPE_NAME:String = '$__bef_mc__';

	public var onTimer:Function = null;
	public var onTimerComplete:Function = null;

	public var isRunning:Boolean = false;
	public var delay:Number = 0;
	public var repeatCount:Number = 0;

	private var __bef_mc:MovieClip = null;
	private var __scope:Object = null;

	private var __iLoop:Number = 0;
	private var __iCount:Number = 0;
	// ---------------------------------------------------------------------------------------------------

}