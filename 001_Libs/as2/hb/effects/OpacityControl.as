/**
	@name: OpacityControl
	@author: hobis(hobisjung@gmail.com)
	@blog: http://blog.naver.com/jhb0b
	@date: 2010-09-27
	@using:
	{
	}
*/
class hb.effects.OpacityControl
{
	public function OpacityControl()
	{
	}

	// :: Add prototype
	public static function register():Void
	{
		if (__isRegister)
		{
			trace('OpacityControl Registed !!');
			return;
		}
		else
		{
			
			MovieClip.prototype.hb_fadeIOC = function(mode:String, num:Number, co:Object):Void
			{
				if (mode == 'out')
				{
					this.onEnterFrame = function():Void
					{
						if (this._alpha < num)
						{
							delete this.onEnterFrame;
							this._alpha = 0;
							this._visible = false;
							
							if (co != undefined)
							{
								co.func.apply(co.scope, co.arg);
							}
							
							trace('Last : ' + this._alpha);
							return;
						}
						this._alpha -= num;
					};
				}
				else if (mode == 'in')
				{
					if (!this._visible)
						this._visible = true;
						
					var toNum:Number = 100 - num;
					
					this.onEnterFrame = function():Void
					{
						if (this._alpha > toNum)
						{
							delete this.onEnterFrame;
							this._alpha = 100;
							
							if (co != undefined)
							{
								co.func.apply(co.scope, co.arg);
							}
							
							trace('Last : ' + this._alpha);
							return;
						}
						this._alpha += num;
					};
				}
			};
		}
			
			MovieClip.prototype.hb_fadeIOCTo = function(mode:String, num:Number, cpN:Number, co:Object):Void
			{
				var transN:Number = (num == undefined) ? 4 : num;
				
				if (mode == 'out')
				{
					this.onEnterFrame = function():Void
					{
						if (this._alpha <= cpN)
						{
							delete this.onEnterFrame;
							this._alpha = cpN;
							
							if (co != undefined)
							{
								co.func.apply(co.scope, co.arg);
							}
							trace('Last : ' + this._alpha);
							return;
						}
						this._alpha = this._alpha - transN;
					};
				}
				else if (mode == 'in')
				{
					this.onEnterFrame = function():Void
					{
						if (this._alpha >= cpN)
						{
							delete this.onEnterFrame;
							this._alpha = cpN;
							
							if (co != undefined)
							{
								co.func.apply(co.scope, co.arg);
							}
							trace('Last : ' + this._alpha);
							return;
						}
						this._alpha = this._alpha+transN;
					};
				}
			};
		}	
		
		__isRegister = true;
	}

	// :: Remove prototype
	public static function remove():Void
	{
		if (__isRegister)
		{
			delete MovieClip.prototype.hb_fadeIOC;
			delete MovieClip.prototype.hb_fadeIOCTo;
			__isRegister = false;
			
			trace('OpacityControl removed !!');
		}
	}


	private static var __isRegister:Boolean = false;

}
