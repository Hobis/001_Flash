package hb.utils
{
/**
	@Name: GeomUtil
	@Author: HobisJung(jhb0b@naver.com)
	@Date: 2013-03-05
	@Using:
	{
	}
*/
	public final class GeomUtil
	{
		public function GeomUtil()
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



		// -
		public static const FULL_ANGLE:Number = 360;

		// -
		public static const FULL_RADIAN:Number = Math.PI * 2;

		// -
		public static const TO_RADIANS:Number = Math.PI / 180;

		// -
		public static const TO_ANGLES:Number = 180 / Math.PI;
	}
}
