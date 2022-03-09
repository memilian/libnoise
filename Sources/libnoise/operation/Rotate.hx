package libnoise.operation;

/**
  * Provides a noise module that rotates the input value around the origin before
  * returning the output value from a source module. [OPERATOR]
  */
class Rotate extends ModuleBase {

	var rx : Float;
	var x1Matrix : Float;
	var x2Matrix : Float;
	var x3Matrix : Float;
	var ry : Float;
	var y1Matrix : Float;
	var y2Matrix : Float;
	var y3Matrix : Float;
	var rz : Float;
	var z1Matrix : Float;
	var z2Matrix : Float;
	var z3Matrix : Float;

	//angles in degree
	public function new(rx = 0.0, ry = 0.0, rz = 0.0, input : ModuleBase) {
		super(1);
		set(0, input);
		this.rx = rx;
		this.ry = ry;
		this.rz = rz;
		setAngles(rx,ry,rz);
	}

	public function setAngles(_rx : Float, _ry : Float, _rz : Float){
		var xc = Math.cos(_rx * Utils.Deg2Rad);
		var yc = Math.cos(_ry * Utils.Deg2Rad);
		var zc = Math.cos(_rz * Utils.Deg2Rad);
		var xs = Math.sin(_rx * Utils.Deg2Rad);
		var ys = Math.sin(_ry * Utils.Deg2Rad);
		var zs = Math.sin(_rz * Utils.Deg2Rad);
		x1Matrix = ys * xs * zs + yc * zc;
		y1Matrix = xc * zs;
		z1Matrix = ys * zc - yc * xs * zs;
		x2Matrix = ys * xs * zc - yc * zs;
		y2Matrix = xc * zc;
		z2Matrix = -yc * xs * zc - ys * zs;
		x3Matrix = -ys * xc;
		y3Matrix = xs;
		z3Matrix = yc * xc;
		rx = _rx;
		ry = _ry;
		rz = _rz;
	}

	override public function getValue(x : Float, y : Float, z : Float) : Float {
		var nx = (x1Matrix * x) + (y1Matrix * y) + (z1Matrix * z);
		var ny = (x2Matrix * x) + (y2Matrix * y) + (z2Matrix * z);
		var nz = (x3Matrix * x) + (y3Matrix * y) + (z3Matrix * z);
		return get(0).getValue(nx, ny, nz);	}
}