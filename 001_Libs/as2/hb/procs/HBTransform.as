/**
	@name :
	@author : jungheebum(jhb0b@naver.com)
	@date : 2009-06-03
*/
class hb.procs.HBTransform
{
	// ---------------------------------------------------------------------------------------------------
	//
	//	Initialize
	//
	// ---------------------------------------------------------------------------------------------------
	public function HBTransform(target:MovieClip, centerX:Number, centerY:Number)
	{
		this.__target = target;
		this.__centerX = centerX;
		this.__centerY = centerY;

		this.__x = this.__target._x;
		this.__y = this.__target._y;
		this.__width = this.__target._width;
		this.__height = this.__target._height;
		this.__scaleX = this.__target._xscale / 100;
		this.__scaleY = this.__target._yscale / 100;
		this.__radian = this.__target._rotation * (Math.PI / 180);
	}
	// ---------------------------------------------------------------------------------------------------


	// ---------------------------------------------------------------------------------------------------
	//
	//	Private's
	//
	// ---------------------------------------------------------------------------------------------------
	// ---------------------------------------------------------------------------------------------------


	// ---------------------------------------------------------------------------------------------------
	//
	//	Public's
	//
	// ---------------------------------------------------------------------------------------------------
	// ::
	public function setPosition(xv:Number, yv:Number):Void
	{
		this.__x = xv;
		this.__y = yv;
		target._x = this.__x;
		target._y = this.__y;
	}

	// ::
	public function setScale(scaleX:Number, scaleY:Number):Void
	{
		var t_deltaX:Number = scaleX - this.__scaleX;
		var t_deltaY:Number = scaleY - this.__scaleY;
		var t_moveX:Number = this.__x - (t_deltaX * this.__centerX);
		var t_moveY:Number = this.__y - (t_deltaY * this.__centerY);

		this.setPosition(t_moveX, t_moveY);

		this.__scaleX = scaleX;
		this.__scaleY = scaleY;

		target._xscale = this.__scaleX * 100;
		target._yscale = this.__scaleY * 100;
	}

	// ::
	public function setRadian(v:Number):Void
	{
	}

	public function get centerX():Number
	{
		return this.__centerX;
	}

	public function set centerX(v:Number):Void
	{
		this.__centerX = v;
	}

	public function get centerY():Number
	{
		return this.__centerY;
	}

	public function set centerY(v:Number):Void
	{
		this.__centerY = v;
	}

	public function get target():MovieClip
	{
		return this.__target;
	}

	public function set target(target:MovieClip):Void
	{
		this.__target = target;
	}

	public function get x():Number
	{
		return this.__x;
	}

	public function set x(v:Number):Void
	{
		this.__x = v;
	}

	public function get y():Number
	{
		return this.__y;
	}

	public function set y(v:Number):Void
	{
		this.__y = v;
	}

	public function get width():Number
	{
		return this.__width;
	}

	public function set width(v:Number):Void
	{
		this.__width = v;
	}

	public function get height():Number
	{
		return this.__height;
	}

	public function set height(v:Number):Void
	{
		this.__height = v;
	}

	public function get scaleX():Number
	{
		return this.__scaleX;
	}

	public function set scaleX(v:Number):Void
	{
		this.__scaleX = v;
	}

	public function get scaleY():Number
	{
		return this.__scaleY;
	}

	public function set scaleY(v:Number):Void
	{
		this.__scaleY = v;
	}

	public function get radian():Number
	{
		return this.__radian;
	}

	public function set radian(v:Number):Void
	{
		this.__radian = v;
	}
	// ---------------------------------------------------------------------------------------------------

	// ---------------------------------------------------------------------------------------------------
	//
	//	Property's
	//
	// ---------------------------------------------------------------------------------------------------
	private var __target:MovieClip = null;

	private var __centerX:Number;
	private var __centerY:Number;

	private var __x:Number;
	private var __y:Number;
	private var __width:Number;
	private var __height:Number;
	private var __scaleX:Number;
	private var __scaleY:Number;

	private var __radian:Number;
	// ---------------------------------------------------------------------------------------------------
}