/**
	@Name: HB Geometry
	@Author: Hobis Jung(jhb0b@naver.com)
	@Blog: http://blog.naver.com/jhb0b
	@Date: 11-06-22
*/
class hb.geom.HBGeom
{
	public function HBGeom()
	{
	}

	// :: Angle To Radian
	public static function getAToR(a:Number):Number
	{
		return a * TO_RADIANS;
	}

	// :: Radian To Angle
	public static function getRToA(r:Number):Number
	{
		return r * TO_ANGLES;
	}

	// :: Get Length
	public static function getL(r:Number, t:Number):Number
	{
		return r * t;
	}

	// :: getRadius
	public static function getRadius(x:Number, y:Number):Number
	{
		return Math.sqrt((x * x) + (y * y));
	}

	// :: getRadian
	public static function getRadian(y:Number, x:Number):Number
	{
		return Math.atan2(y, x);
	}

	// :: getRadian2
	public static function getRadian2(x1:Number, y1:Number, x2:Number, y2:Number):Number
	{
		var t_distX:Number = x2 - x1;
		var t_distY:Number = y2 - y1;
		return Math.atan2(t_distY, t_distX);
	}

	// :: getDistance
	public static function getDistance(x1:Number, y1:Number, x2:Number, y2:Number):Number
	{
		var t_distX:Number = x2 - x1;
		var t_distY:Number = y2 - y1;
		var pn:Number = Math.sqrt((t_distX * t_distX) + (t_distY * t_distY));
		return pn;
	}

	// :: getDistance
	public static function getDistance2(p1:Object, p2:Object):Number
	{
		var pn:Number = getDistance(p1.x, p1.y, p2.x, p2.y);
		return pn;
	}

	// :: cos x
	public static function getX(r:Number, radius:Number):Number
	{
		return Math.cos(r) * radius;
	}

	// :: sin x
	public static function getY(r:Number, radius:Number):Number
	{
		return Math.sin(r) * radius;
	}



	public static var FULL_ANGLE:Number = 360;
	public static var FULL_RADIAN:Number = Math.PI * 2;
	public static var TO_RADIANS:Number = Math.PI / 180;
	public static var TO_ANGLES:Number = 180 / Math.PI;

}
