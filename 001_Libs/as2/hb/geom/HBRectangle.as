/**
	@name : HBRectangle
	@author : jungheebum(jhb0b@naver.com)
	@blog : http://blog.naver.com/jhb0b
	@date : 2009-04-02
*/
import hb.geom.HBPoint;

class hb.geom.HBRectangle
{

	public function HBRectangle(x:Number, y:Number, w:Number, h:Number)
	{
		this.__x = x || 0;
		this.__y = y || 0;
		this.__width = w || 0;
		this.__height = h || 0;
	}

	public function get x():Number
	{
		return this.__x;
	}
	public function set x(n:Number):Void
	{
		this.__x = n;
	}
	public function get y():Number
	{
		return this.__y;
	}
	public function set y(n:Number):Void
	{
		this.__y = n;
	}

	public function get width():Number
	{
		return this.__width;
	}
	public function set width(n:Number):Void
	{
		this.__width = n;
	}
	public function get height():Number
	{
		return this.__height;
	}
	public function set height(n:Number):Void
	{
		this.__height = n;
	}

	public function get left():Number
	{
		return this.__x;
	}
	public function set left(n:Number):Number
	{
		var cw:Number = n - this.__x;
		this.__x = n;
		this.__width = this.__width - cw;
	}
	public function get right():Number
	{
		return this.__x + this.__width;
	}
	public function set right(n:Number):Number
	{
		this.__width = n - this.__x;
	}

	public function get top():Number
	{
		return this.__y;
	}
	public function set top(n:Number):Void
	{
		this.__y = n;
	}
	public function get bottom():Number
	{
		return this.__y + this.__height;
	}
	public function set bottom(n:Number):Void
	{
		this.__height = n - this.__y;
	}

	public function get size():Object
	{
		return new HBPoint(this.__width, this.__height);
	}
	public function set size(o:Object):Void
	{
		this.__width = o.x;
		this.__height = o.y;
	}

	public function get topLeft():Object
	{
		return new HBPoint(this.__x, this.__y);
	}
	public function set topLeft(v:Object):Void
	{
		this.__x = v.x;
		this.__y = v.y;
	}
	public function get bottomRight():Object
	{
		return new HBPoint(this.__x + this.__width, this.__y + this.__height);
	}
	public function set bottomRight(o:Object):Void
	{
		this.__width = o.x - this.__x;
		this.__height = o.y - this.__y;
	}

	public function clone():Object
	{
		return new HBRectangle(this.__x, this.__y, this.__width, this.__height);
	}

	public function contains(x:Number, y:Number):Boolean
	{
		return (x >= this.__x) && (y >= this.__y) &&
			(x < (this.__x + this.__width)) && (y < (this.__y + this.__height))
	}

	public function containsPoint(o:Object):Boolean
	{
		return (o.x >= this.__x) && (o.y >= this.__y) &&
			(o.x < (this.__x + this.__width)) && (o.y < (this.__y + this.__height));
	}

	// rect - HBRectangle
	public function containsRectangle(rect:HBRectangle):Boolean
	{
		return (rect.x >= this.__x) && (rect.y >= this.__y) &&
			((rect.x + rect.width) <= (this.__x + this.__width)) &&
			((rect.y + rect.height) <= (this.__y + this.__height));
	}

	public function equals(rect:HBRectangle):Boolean
	{
		return (rect.x == this.__x) && (rect.y == this.__y) &&
			((rect.x + rect.width) == (this.__x + this.__width)) &&
			((rect.y + rect.height) == (this.__y + this.__height));
	}

	public function inflate(dx:Number, dy:Number):Void
	{
		this.__x = this.__x - dx;
		this.__y = this.__y - dy;
		this.__width = this.__width + (dx * 2);
		this.__height = this.__height + (dy * 2);
	}

	public function inflatePoint(o:Object):Void
	{
		this.__x = this.__x - o.x;
		this.__y = this.__y - o.y;
		this.__width = this.__width + (o.x * 2);
		this.__height = this.__height + (o.y * 2);
	}

	public function intersection(rect:Object):Object
	{
		var t_left:Number = Math.max(left, rect.left);
		var t_top:Number = Math.max(top, rect.top);
		var t_right:Number = Math.min(right, rect.right);
		var t_bottom:Number = Math.min(bottom, rect.bottom);

		//trace('# :: '+[frontRight, frontBottom]);
		//trace('# :: '+[t_left, t_top]);
		//trace('# :: '+[t_right, t_bottom]);
		//trace((t_left<t_right) && (t_top<t_bottom));

		if ((t_left < t_right) && (t_top < t_bottom))
		{
			return new HBRectangle(t_left, t_top, t_right-t_left, t_bottom-t_top);
		}
		else
		{
			return new HBRectangle(0, 0, 0, 0);
		}

	}

	public function intersects(rect:Object):Boolean
	{
		var t_left:Number = Math.max(left, rect.left);
		var t_top:Number = Math.max(top, rect.top);
		var t_right:Number = Math.min(right, rect.right);
		var t_bottom:Number = Math.min(bottom, rect.bottom);

		return (t_left < t_right) && (t_top < t_bottom);
	}

	public function getIsEmpty():Boolean
	{
		return (this.__width > 0) && (this.__height > 0);
	}

	public function offset(dx:Number, dy:Number):Void
	{
		this.__x = this.__x + dx;
		this.__y = this.__y + dy;
	}

	public function offsetPoint(v:Object):Void
	{
		this.__x = this.__x + v.x;
		this.__y = this.__y + v.y;
	}

	public function setEmpty():Void
	{
		this.__x = 0;
		this.__y = 0;
		this.__width = 0;
		this.__height = 0;
	}

	public function union(rect:Object):Object
	{
		var t_left:Number = Math.min(left, rect.left);
		var t_top:Number = Math.min(top, rect.top);
		var t_right:Number = Math.max(right, rect.right);
		var t_bottom:Number = Math.max(bottom, rect.bottom);

		return new HBRectangle(t_left, t_top, t_right - t_left, t_bottom - t_top);
	}

	public function toString():String
	{
		return
			'(x=' + this.__x.toString() + ', y=' + this.__y.toString() +
			', w=' + this.__width.toString() + ', h=' + this.__height.toString() + ')';
	}


	private var __x:Number;
	private var __y:Number;
	private var __width:Number;
	private var __height:Number;

}
