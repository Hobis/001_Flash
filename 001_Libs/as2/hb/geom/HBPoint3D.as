/**
	@name : HBPoint3D
	@author : jungheebum(jhb0b@naver.com)
	@blog : http://blog.naver.com/jhb0b
	@date : 2009-04-02
*/
class hb.geom.HBPoint3D
{
	public function HBPoint3D(x:Number, y:Number, z:Number)
	{
		this.__x = isNaN(x) ? 0 : x;
		this.__y = isNaN(y) ? 0 : y;
		this.__z = isNaN(z) ? 0 : z;
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

	public function add(o:HBPoint3D):Void
	{
		this.__x = this.__x + o.x;
		this.__y = this.__y + o.y;
		this.__z = this.__z + o.z;
	}

	public function clone():Object
	{
		return new HBPoint3D(this.__x, this.__y, this.__z);
	}

	private var __x:Number;
	private var __y:Number;
	private var __z:Number;
}