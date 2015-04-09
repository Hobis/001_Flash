/**
	@name : FrameControl 1.2
	@author : Hobis Jung (jhb0b@naver.com)
	@date : 2010-09-01
	@using :
	{
		import hb.frame.FrameControl;
		FrameControl.register();
	}
*/
class hb.frame.FrameControl
{
	private function FrameControl()
	{
	}

	public static function register():Void
	{
		if (__isRegister)
		{
			trace('FrameControl creation !!');
			return;
		}
		else
		{
			// ---------------------------------------------------------------------------------------------- //
			//	 register MovieClip Prototype
			// ---------------------------------------------------------------------------------------------- //
			// :: Frame Over/Out
			MovieClip.prototype.hb_frameOO = function(type:String):Void
			{
				var t_ef:Function = null;

				if (type == 'over')
				{
					t_ef = function():Void
					{
						if (this._currentframe >= this._totalframes)
						{
							this.onEnterFrame = null;
							return;
						}

						this.nextFrame();
					};
				}
				else if (type == 'out')
				{
					t_ef = function():Void
					{
						if (this._currentframe <= 1)
						{
							this.onEnterFrame = null;
							return;
						}

						this.prevFrame();
					};
				}

				this.onEnterFrame = t_ef;
			};

			// :: Frame Over/Out CallBack
			MovieClip.prototype.hb_frameOOC = function(type:String, co:Object):Void
			{
				var t_ef:Function = null;

				if (type == 'over')
				{
					t_ef = function():Void
					{
						if (this._currentframe >= this._totalframes)
						{
							this.onEnterFrame = null;

							if (co != undefined)
								co.func.apply(co.scope, co.args);

							return;
						}

						this.nextFrame();
					};
				}
				else if (type == 'out')
				{
					t_ef = function():Void
					{
						if (this._currentframe <= 1)
						{
							this.onEnterFrame = null;

							if (co != undefined)
								co.func.apply(co.scope, co.args);

							return;
						}

						this.prevFrame();
					};
				}

				this.onEnterFrame = t_ef;
			};

			// :: Frame To CallBack
			MovieClip.prototype.hb_frameToC = function(toFrame:Number, co:Object):Void
			{
				if ((toFrame == undefined) || (toFrame == this._currentframe))
					return;

				if (toFrame < 0)
					toFrame = 1;
				else if (toFrame > this._totalframes)
					toFrame = this._totalframes;

				var t_frameGap:Number;

				if (toFrame > this._currentframe)
					t_frameGap = 1;
				else if (toFrame < this._currentframe)
					t_frameGap = -1;

				this.onEnterFrame = function():Void
				{
					if (this._currentframe == toFrame)
					{
						this.onEnterFrame = null;

						if (co != undefined)
							co.func.apply(co.scope, co.args);

						return;
					}

					this.gotoAndStop(this._currentframe + t_frameGap);
				};
			};
			// ---------------------------------------------------------------------------------------------- //

			__isRegister = true;

			trace('FrameControl MovieClip.prototype Registed !!');
		}

	}//end function

	// :: prototype remove.
	public static function remove():Void
	{
		if (__isRegister)
		{
			delete MovieClip.prototype.hb_frameOOC;
			delete MovieClip.prototype.hb_frameOO;
			delete MovieClip.prototype.hb_frameToC;

			__isRegister = false;

			trace('FrameControl removed !!');
		}
	}

	public static var __isRegister:Boolean = false;
}
