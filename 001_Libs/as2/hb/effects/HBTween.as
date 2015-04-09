/**
	@name : HBTween ver 1.06
	@author : jungheebum (jhb0b@naver.com)
	@blog : http://blog.naver.com/jhb0b
	@code assistance by : mx.transitions.Tween Code
	@date : 2009-04-02
	@using :
	{
		import hb.effects.HBTween;
		import hb.effects.easing.*;

		var tween:HBTween = new HBTween(this.rect_mc, '_x', Strong.easeInOut);
		this.tween.onTweenUpdate = function(target:Object, v:Number):Void
		{
			trace('onTweenUpdate');
			trace('arguments.length : ' + arguments.length);
		};
		this.tween.onTweenEnd = function(target:Object):Void
		{
			trace('onTweenEnd');
			trace('arguments.length : ' + arguments.length);
		};
		this.tween.to(450);
	}
*/

import hb.effects.easing.None;

class hb.effects.HBTween
{
	//------------------------------------------------------------------------------------------------------------
	//
	//	Member's
	//
	//------------------------------------------------------------------------------------------------------------
	public function HBTween(target:Object, prop:String, func:Function)
	{
		if (arguments.length < 3)
		{
			trace('HBTween : Not enough parameters');
			return;
		}

		this.p_init(target, prop, func);
	}

	private function p_init(target:Object, prop:String, func:Function):Void
	{
		__p_init_ef();

		this.target = target;
		this.prop = prop;

		this.func = (func != undefined) ? func : defaultEasing;
	}

	private static function __p_init_ef():Void
	{
		if (!_global.$MovieClip)
		{
			_global.$MovieClip = {};
			AsBroadcaster.initialize(_global.$MovieClip);

			var t_mc:MovieClip = _root.createEmptyMovieClip('__bef_mc', movieClipIndex);
			t_mc.onEnterFrame = function():Void
			{
				_global.$MovieClip.broadcastMessage('p_onEnterFrame');
			};
		}
	}

	private function p_onEnterFrame():Void
	{
		if (this.time >= this.duration)
		{
			this.stop();

			if (this.onTweenEnd != null)
				this.onTweenEnd(this.target);

			return;
		}

		this.time++;
		this.setPosition(this.getPosition(this.time));
	}

	public static function simple(target:Object, prop:String,
		func:Function, change:Number, duration:Number):HBTween
	{
		if (arguments.length < 4) return;

		var rv:HBTween = new HBTween(target, prop, func);
		if (duration != undefined) rv.duration = duration;
		rv.to(change);

		return rv;
	}

	public static function unabled_ef():Void
	{
		delete _root.__bef_mc.onEnterFrame;
		_root.__bef_mc.removeMovieClip();
		delete _global.$MovieClip;
	}

	public function setChange(v:Number):Void
	{
		this.change = v - this.begin;
	}

	public function setPosition(v:Number):Void
	{
		if (this.isRound) v = Math.round(v);

		this.target[this.prop] = v;

		if (this.onTweenUpdate != null)
			this.onTweenUpdate(this.target, v);
	}

	public function getPosition(t:Number):Number
	{
		if (t == undefined) t = this.time;
		return this.func(t, this.begin, this.change, this.duration);
	}

	public function to(change:Number):Void
	{
		this.begin = this.target[this.prop];
		this.setChange(change);
		this.start();
	}

	public function start():Void
	{
		this.time = 0;
		_global.$MovieClip.addListener(this);
	}

	public function stop():Void
	{
		_global.$MovieClip.removeListener(this);
	}

	public function toString():String
	{
		return 'HBTween Object';
	}
	//------------------------------------------------------------------------------------------------------------


	//------------------------------------------------------------------------------------------------------------
	//
	//	property's
	//
	//------------------------------------------------------------------------------------------------------------
	//
	public var time:Number = 0;
	public var target:Object = null;
	public var prop:String = null;
	public var begin:Number;
	public var change:Number;

	public var duration:Number = 36;
	public var func:Function = null;

	public var isRound:Boolean = false;

	public var onTweenUpdate:Function = null;
	public var onTweenEnd:Function = null;

	public static var defaultEasing:Function = None.easeNone;

	public static var movieClipIndex:Number = 999898;
	//------------------------------------------------------------------------------------------------------------

}