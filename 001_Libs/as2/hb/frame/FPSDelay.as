/**
	@name : FPSDelay 1.0
	@author : jungheebum(jhb0b@naver.com)
	@blog : http://blog.naver.com/jhb0b
	@date : 2009-04-02
	@using :
	{
		import hb.frame.FPSDelay;

		FPSDelay.excute
		(
			60, this,
			function()
			{
				trace('60 FPS 진행된 후에 실행.');
			}, null
		);
	}
*/
class hb.frame.FPSDelay
{

	public function FPSDelay()
	{
	}

	// :: FPS Delay After excute
	public static function excute(delayNum:Number, scope:Object, exeFunc:Function, paraObj:Object):Void
	{
		var iLoop:Number = 0;
		var befMC:MovieClip = null;

		befMC = scope.createEmptyMovieClip('befMC__$', 991110);
		befMC.onEnterFrame = function():Void
		{
			if (iLoop >= delayNum)
			{
				delete this.onEnterFrame;
				this.removeMovieClip();
				exeFunc.call(scope, paraObj);
				return;
			}
			iLoop++;
			//trace(iLoop);
		};

	}

	// :: FPS Delay Looping excute
	public static function loop(delayNum:Number, scope:Object, exeFunc:Function, paraObj:Object):Void
	{
		var iLoop:Number = 0;
		var befMC:MovieClip = null;

		befMC = scope.createEmptyMovieClip('befMC__$_loop', 991111);
		befMC.onEnterFrame = function():Void
		{
			if (iLoop >= delayNum)
			{
				exeFunc.call(scope, paraObj);
				iLoop = 0;
				return;
			}
			iLoop++;
			//trace(iLoop);
		};
	}

	// :: Looping excute clear
	public static function breakDelay(scope:Object):Void
	{
		delete scope.befMC__$.onEnterFrame;
		scope.befMC__$.removeMovieClip();
	}

	// :: Looping excute clear
	public static function clearLoop(scope:Object):Void
	{
		delete scope.befMC__$_loop.onEnterFrame;
		scope.befMC__$_loop.removeMovieClip();
	}

}
