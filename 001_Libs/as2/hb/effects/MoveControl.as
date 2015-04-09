/**
	@name : Smooth To Control 1.0
	@author : jungheebum(jhb0b@naver.com)
	@blog : http://blog.naver.com/jhb0b
	@date : 2009-04-02
	@using :
	{
		import hb.effects.MoveControl;

		MoveControl.register();

		this.my_mc.hb_move
		(
			'_x', 100, .6,
			{
				func: function():Void
				{
				},
				scope: this,
				arg: []
			}
		);
	}
*/
class hb.effects.MoveControl
{
	public function MoveControl()
	{
	}

	public static function register():Void
	{
		if (__isRegister)
		{
			trace('MoveControl Registed !!');
			return;
		}

		__isRegister = true;

		MovieClip.prototype.hb_move = function(prop:String, cpN:Number, spN:Number, co:Object):Void
		{
			this.onEnterFrame = function()
			{
				if (Math.round(this[prop]) == cpN)
				{
					delete this.onEnterFrame;
					this[prop] = cpN;
					if (co != undefined)
						co.func.apply(co.scope, co.arg);
					//trace("¡Ü hb_move Last :: "+this[prop]);
					return;
				}
				this[prop] = this[prop] + ((cpN - this[prop]) * spN);
			};
		};

		// - Sequence Add
		MovieClip.prototype.hb_moves = function(propArr:Array, cpNArr:Array, spNArr:Array, co:Object):Void
		{
			this.onEnterFrame = function()
			{
				var i:Number = propArr.length;
				if (!i)
				{
					delete this.onEnterFrame;
					if (co != undefined)
						co.func.apply(co.scope, co.arg);
					trace('# hb_moves End :: ');
					return;
				}

				var dist_n:Number;
				while (i--)
				{
					dist_n = cpNArr[i] - this[propArr[i]];
					if (Math.abs(dist_n) < 1)
					//if(Math.round(this[propArr[i]]) == cpNArr[i])
					{
						this[propArr[i]] = cpNArr[i];
						//trace('# hb_moves End '+propArr[i]+' :: '+this[propArr[i]]);
						propArr.splice(i, 1);
						cpNArr.splice(i, 1);
						spNArr.splice(i, 1);
						continue;
					}
					//this[propArr[i]] = this[propArr[i]]+((cpNArr[i]-this[propArr[i]])*spNArr[i]);
					this[propArr[i]] = this[propArr[i]] + (dist_n*spNArr[i]);
					//trace('# hb_moves Ing ' + propArr[i] + ' :: ' + this[propArr[i]]);
				}
			};

		};

		MovieClip.prototype.hb_movesq = function(sqArr:Array, co:Object):Void
		{
			this.onEnterFrame = function()
			{
				var i:Number = sqArr.length;
				if (!i)
				{
					delete this.onEnterFrame;
					if (co != undefined)
						co.func.apply(co.scope, co.arg);
					//trace('# hb_movesq End :: ');
					return;
				}

				var dist_n:Number;
				while (i--)
				{
					dist_n = sqArr[i].cpN - this[sqArr[i].prop];
					if (Math.abs(dist_n) < 1)
					{
						this[sqArr[i].prop] = sqArr[i].cpN;
						//trace('# hb_movesq End '+sqArr[i].prop+' :: '+this[sqArr[i].prop]);
						sqArr.splice(i, 1);
						continue;
					}
					this[sqArr[i].prop] = this[sqArr[i].prop] + (dist_n * sqArr[i].spN);
					//trace('# hb_movesq Ing '+sqArr[i].prop+' :: '+this[sqArr[i].prop]);
				}
			};

		};

		MovieClip.prototype.hb_moveBreak = function():Void
		{
			delete this.onEnterFrame;
		};
	}

	// :: remove prototype
	public static function remove():Void
	{
		if (__isRegister)
		{
			delete MovieClip.prototype.hb_move;
			delete MovieClip.prototype.hb_moves;
			delete MovieClip.prototype.hb_movesq;
			delete MovieClip.prototype.hb_moveBreak;
			__isRegister = false;
			trace('MoveControl removed !!');
		}
	}


	private static var __isRegister:Boolean = false;

}