import hb.geom.HBGeom;

/**
	@name : HBPoint
	@author : jungheebum(jhb0b@naver.com)
	@blog : http://blog.naver.com/jhb0b
	@date : 2009-04-02
*/
class hb.geom.HBPoint
{
	public function HBPoint(x:Number, y:Number)
	{
		this.__x = isNaN(x) ? 0 : x;
		this.__y = isNaN(y) ? 0 : y;
	}

	public function set x(x:Number):Void
	{
		this.__x = x;
	}
	public function get x():Number
	{
		return this.__x;
	}
	public function set y(y:Number):Void
	{
		this.__y = y;
	}
	public function get y():Number
	{
		return this.__y;
	}

	public function add(o:HBPoint):Void
	{
		this.__x = this.__x + o.x;
		this.__y = this.__y + o.y;
	}

	public function clone():HBPoint
	{
		return new HBPoint(this.__x, this.__y);
	}

	public static function distance(pt1:HBPoint, pt2:HBPoint):Number
	{
		return HBGeom.getDistance(pt1.x, pt1.y, pt2.x, pt2.y);
	}

	public function equals(toCompare:HBPoint):Boolean
	{
		return (this.__x == toCompare.x) && (this.__y == toCompare.y);
	}

	public static function interpolate(pt1:HBPoint, pt2:HBPoint, f:Number):HBPoint
	{
		var max_x:Number = Math.max(pt1.x, pt2.x);
		var max_y:Number = Math.max(pt1.y, pt2.y);
		var min_x:Number = Math.min(pt1.x, pt2.x);
		var min_y:Number = Math.min(pt1.y, pt2.y);
		var dist_x:Number = max_x - min_x;
		var dist_y:Number = max_y - min_y;

		return new HBPoint
		(
			min_x + (dist_x * f),
			min_y + (dist_y * f)
		);
	}

	public function get length():Number
	{
		return HBGeom.getRadius(this.__x, this.__y);
	}

	public function normalize(v:Number):Void
	{
		var tr:Number = v / length;
		this.__x = this.__x * tr;
		this.__y = this.__y * tr;
	}

	public function offset(dx:Number, dy:Number):Void
	{
		this.__x = this.__x + dx;
		this.__y = this.__y + dy;
	}

	public static function polar(len:Number, rad:Number):HBPoint
	{
		return new HBPoint
		(
			Math.cos(rad) * len,
			Math.sin(rad) * len
		);
	}

	public function subtract(o:HBPoint):HBPoint
	{
		return new HBPoint
		(
			this.__x - o.x,
			this.__y - o.y
		)
	}

	public function toString():String
	{
		return '(x='+this.__x.toString()+', y='+this.__y.toString()+')';
	}


	private var __x:Number;
	private var __y:Number;

}