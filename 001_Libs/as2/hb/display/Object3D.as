class hb.display.Object3D
{
	public function Object3D(x:Number, y:Number, z:Number)
	{
		this.x = (x == undefined) ? 0 : x;
		this.y = (y == undefined) ? 0 : y;
		this.z = (z == undefined) ? 0 : z;
	}

	public var x:Number;
	public var y:Number;
	public var z:Number;
}
