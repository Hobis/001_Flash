/**
	@name : HBDrawing
	@author : jungheebum(jhb0b@naver.com)
	@blog : http://blog.naver.com/jhb0b
	@date : 2009-04-02
*/
class hb.graphics.HBDrawing
{
	public function HBDrawing()
	{
	}

	public static function drawCircle(target:MovieClip, x:Number, y:Number, radius:Number):Void
	{
		var tc:Number = radius*(Math.SQRT2-1);
		var ta:Number = radius*Math.SQRT1_2;

		target.moveTo(x+radius, y);
		target.curveTo(x+radius, y+tc, x+ta, y+ta);
		target.curveTo(x+tc, y+radius, x, y+radius);
		target.curveTo(x-tc, y+radius, x-ta, y+ta);
		target.curveTo(x-radius, y+tc, x-radius, y+0);
		target.curveTo(x-radius, y-tc, x-ta, y-ta);
		target.curveTo(x-tc, y-radius, x+0, y-radius);
		target.curveTo(x+tc, y-radius, x+ta, y-ta);
		target.curveTo(x+radius, y-tc, x+radius, y);
	}

	public static function drawEllipse(target:MovieClip, x:Number, y:Number, width:Number, height:Number):Void
	{
		var j:Number = width * Math.SQRT1_2;
		var n:Number = height * Math.SQRT1_2;
		var i:Number = j - (height - n) * width / height;
		var m:Number = n - (width - j) * height / width;

		target.moveTo(x + width, y);
		target.curveTo(x + width, y - m, x + j, y - n);
		target.curveTo(x + i, y - height, x, y - height);
		target.curveTo(x - i, y - height, x - j, y - n);
		target.curveTo(x - width, y - m, x - width, y);
		target.curveTo(x - width, y + m, x - j, y + n);
		target.curveTo(x - i, y + height, x, y + height);
		target.curveTo(x + i, y + height, x + j, y + n);
		target.curveTo(x + width, y + m, x + width, y);
	}

	public static function drawRect(target:MovieClip, x:Number, y:Number, width:Number, height:Number):Void
	{
		var from_x:Number = x + width;
		var from_y:Number = y + height;

		target.moveTo(x, y);
		target.lineTo(from_x, y);
		target.lineTo(from_x, from_y);
		target.lineTo(x, from_y);
		target.lineTo(x, y);
	}

	public static function drawRoundRect(
							target:MovieClip,
							x:Number, y:Number,
							width:Number, height:Number,
							ellipseWidth:Number, ellipseHeight:Number):Void
	{

		var half_ew:Number = ellipseWidth / 2;
		var half_eh:Number = ellipseHeight / 2;
		var from_x:Number = x + width;
		var from_y:Number = y + height;
		var from_ex:Number = x + half_ew;
		var from_ey:Number = y + half_eh;

		target.moveTo(x, from_ey);
		target.curveTo(x, y, from_ex, y);
		target.lineTo(from_x-half_ew, y);
		target.curveTo(from_x, y, from_x, from_ey);
		target.lineTo(from_x, from_y-half_eh);
		target.curveTo(from_x, from_y, from_x-half_ew, from_y);
		target.lineTo(from_ex, from_y);
		target.curveTo(x, from_y, x, from_y-half_eh);
		target.lineTo(x, from_ey);
		target.endFill();
	}

	/*
	public static function drawRoundThicknessRect(
							x:Number, y:Number,
							width:Number, height:Number,
							ellipseWidth:Number, ellipseHeight:Number,
							thickness:Number):Void
	{



	}*/

	public static function drawThicknessRect(target:MovieClip,
							x:Number, y:Number,
							width:Number, height:Number,
							thickness:Number):Void
	{
		var from_x:Number = x + width;
		var from_y:Number = y + height;

		target.moveTo(x, y+thickness);
		target.lineTo(x, y);
		target.lineTo(from_x, y);
		target.lineTo(from_x, from_y);
		target.lineTo(0, from_y);
		target.lineTo(0, thickness);
		target.lineTo(from_x-thickness, thickness);
		target.lineTo(from_x-thickness, from_y-thickness);
		target.lineTo(thickness, from_y-thickness);
		target.lineTo(thickness, thickness);
	}

}