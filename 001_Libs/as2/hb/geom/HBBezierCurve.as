/**
	@name : Bezier Curve - simple two control point cubic bezier curve class
	@author : senocular: www.senocular.com
	@date : 1899-12-31T00:46:56.900
	@doc : <span style="font-size:larger;"><b>Bezier Curve</b> with 2 control points.</span>
	@example :
	{

		var myCurve:Object = new HBBezierCurve
		(
			{x:0, y:0},
			{x:310, y:10},
			{x:390, y:300},
			{x:500, y:300}
		);
		myCurve.setPosition(circle_mc, i/500);
	}
	@class : rewritten by jungheebum
*/
class hb.geom.HBBezierCurve
{

	public function HBBezierCurve(sp:Object, cp1:Object, cp2:Object, ep:Object)
	{
		this.__pArr = [];
		this.__pArr.push(sp);
		this.__pArr.push(cp1);
		this.__pArr.push(cp2);
		this.__pArr.push(ep);
	}

	public function setPosition(to:Object, tv:Number):Void
	{
		var inv:Number = 1 - tv;
		var invcube:Number = inv * inv * inv;
		var invsquare:Number = inv * inv;
		var square:Number = tv * tv;
		var cube:Number = tv * tv * tv;

		to._x = (invcube * this.__pArr[0].x) + (3 * tv * invsquare * this.__pArr[1].x) +
			(3 * square * inv * this.__pArr[2].x) + (cube * this.__pArr[3].x);
		to._y = (invcube * this.__pArr[0].y) + (3 * tv * invsquare * this.__pArr[1].y) +
			(3 * square * inv * this.__pArr[2].y) + (cube * this.__pArr[3].y);
	}

	public function setPoint(n:Number, to:Object):Void
	{
		this.__pArr[n].x = to.x;
		this.__pArr[n].y = to.y;
	}

	public function setPointTo(n:Number, to:Object):Void
	{
		this.__pArr[n].x = to._x;
		this.__pArr[n].y = to._y;
	}

	public function setToPoint(to:Object, n:Number):Void
	{
		to._x = this.__pArr[n].x;
		to._y = this.__pArr[n].y;
	}

	private var __pArr:Array = null;

}