import hb.display.Object3D;
import hb.geom.HBGeom;

class hb.display.Target3D
{
	public function Target3D(target:Object)
	{
		this.m_target = target;
		this.m_p = new Object3D(this.m_target._x, this.m_target._y, 0);
		this.m_rp = new Object3D(0, 0, 0);
		this.m_radian = 0;
	}

	public function get_z_MaxValue():Number
	{
		return this.m_z_MaxValue;
	}

	public function set_z_MaxValue(v:Number):Void
	{
		this.m_z_MaxValue = v;
	}

	public function get_pos():Object3D
	{
		return this.m_p;
	}

	public function set_pos(p:Object3D):Void
	{
		this.m_p = p;
	}

	public function radiusUpdate(cp:Object3D):Void
	{
		var t_dx:Number = this.m_p.x - cp.x;
		var t_dy:Number = this.m_p.y - cp.y;
		var t_dz:Number = this.m_p.z - cp.z;

		this.m_rp.x = Math.abs(t_dx);
		this.m_rp.y = Math.abs(t_dy);
		this.m_rp.z = Math.abs(t_dz);
		this.m_radian = 0;
	}

	public function update():Void
	{
		this.m_target._x = this.m_p.x;
		this.m_target._y = this.m_p.y;

		var t_scaleRaito:Number = (this.m_z_MaxValue - this.m_p.z) / this.m_z_MaxValue;
		var t_scale:Number = 100 * t_scaleRaito;
		this.m_target._xscale =
		this.m_target._yscale = t_scale;
		this.m_target._alpha = t_scale;
	}

	public function translate(p:Object3D):Void
	{
		this.m_p.x += p.x;
		this.m_p.y += p.y;
		this.m_p.z += p.z;
	}

	// :: X축을 기준으로 이동
	public function moveAxisX(radian:Number, cp:Object3D):Void
	{

/*
		var t_dy:Number = this.m_p.y - cp.y;
		var t_dz:Number = this.m_p.z - cp.z;
		var t_radian:Number = Math.atan2(t_dz, t_dy);

		if (t_radian < 0)
			t_radian += HBGeom.FULL_RADIAN;

		t_radian += radian;

		if (t_radian > HBGeom.FULL_RADIAN)
			t_radian -= HBGeom.FULL_RADIAN;

		var t_distY:Number = Math.abs(t_dy);
		var t_distZ:Number = Math.abs(t_dz);
		var t_radius:Number = Math.sqrt((t_distY * t_distY) + (t_distZ * t_distZ));

		this.m_p.y = cp.y + (Math.cos(t_radian) * t_radius);
		this.m_p.z = cp.z + (Math.sin(t_radian) * t_radius);*/
	}

	public function moveAxisY(radian:Number, cp:Object3D):Void
	{
		var t_dx:Number = this.m_p.x - cp.x;
		var t_dz:Number = this.m_p.z - cp.z;
		var t_radian:Number = Math.atan2(t_dz, t_dx);

		if (t_radian < 0)
			t_radian += HBGeom.FULL_RADIAN;

		t_radian += radian;

		if (t_radian > HBGeom.FULL_RADIAN)
			t_radian -= HBGeom.FULL_RADIAN;

		var t_distX:Number = Math.abs(t_dx);
		var t_distZ:Number = Math.abs(t_dz);
		var t_radius:Number = Math.sqrt((t_distX * t_distX) + (t_distZ * t_distZ));

		this.m_p.x = cp.x + (Math.cos(t_radian) * t_radius);
		this.m_p.z = cp.z + (Math.sin(t_radian) * t_radius);
	}

	public function moveAxisZ(radian:Number, cp:Object3D):Void
	{
		var t_dx:Number = this.m_p.x - cp.x;
		var t_dy:Number = this.m_p.y - cp.y;
		var t_radian:Number = Math.atan2(t_dy, t_dx);

		if (t_radian < 0)
			t_radian += HBGeom.FULL_RADIAN;

		t_radian += radian;

		if (t_radian > HBGeom.FULL_RADIAN)
			t_radian -= HBGeom.FULL_RADIAN;

		var t_distX:Number = Math.abs(t_dx);
		var t_distY:Number = Math.abs(t_dy);
		var t_radius:Number = Math.sqrt((t_distX * t_distX) + (t_distY * t_distY));

		this.m_p.x = cp.x + (Math.cos(t_radian) * t_radius);
		this.m_p.y = cp.y + (Math.sin(t_radian) * t_radius);
	}


	private static var __HALF_RADIAN:Number = Math.PI;
	private static var __FULL_RADIAN:Number = __FULL_RADIAN * 2;

	private var m_target:Object = null;
	private var m_p:Object3D = null;
	private var m_rp:Object3D = null;
	private var m_radian:Number;
	private var m_z_MaxValue:Number = 1000;
}





















/*
MovieClip.prototype.rotateY = function (tN, czN, cxN) {
    var _loc4 = czN + (this.zN - czN) * Math.cos(tN) - (this.xN - cxN) * Math.sin(tN);
    this.xN = cxN + (this.zN - czN) * Math.sin(tN) + (this.xN - cxN) * Math.cos(tN);
    this.zN = _loc4;
};

MovieClip.prototype.plot3d = function (fN, vP) {
    if (this.zN < -fN) {
        this._visible = false;
    }
    else {
        this._visible = true;
        var _loc2 = fN / (fN + this.zN);
        this._xscale = this._yscale = _loc2 * 100;
        this._x = this.xN * _loc2;
        this._y = this.yN * _loc2 - vP * this.zN;
        this.swapDepths(50000 - 100 * this.zN);
    }
};

*/