package libnoise.generator;

class Voronoi extends ModuleBase {

	var frequency : Float;
	var displacement : Float;
	var seed : Int;
	var distance : Bool;

	public function new(frequency : Float, displacement : Float, seed : Int, distance : Bool) {
		this.frequency = frequency;
		this.displacement = displacement;
		this.seed = seed;
		this.distance = distance;
		super(0);
	}

	override public function getValue(x : Float, y : Float, z : Float) : Float {
		x *= frequency;
		y *= frequency;
		z *= frequency;
		var xi = (x > 0.0 ? Std.int(x) : Std.int(x - 1));
		var iy = (y > 0.0 ? Std.int(y) : Std.int(y - 1));
		var iz = (z > 0.0 ? Std.int(z) : Std.int(z - 1));
		var md = 2147483647.0;
		var xc : Float = 0;
		var yc : Float = 0;
		var zc : Float = 0;
		for (zcu in (iz - 2)...(iz + 3)) {
			for (ycu in (iy - 2)...(iy + 3)) {
				for (xcu in (xi - 2)...(xi + 3)) {
					var xp = xcu + Utils.ValueNoise3D(xcu, ycu, zcu, seed);
					var yp = ycu + Utils.ValueNoise3D(xcu, ycu, zcu, seed + 1);
					var zp = zcu + Utils.ValueNoise3D(xcu, ycu, zcu, seed + 2);
					var xd = xp - x;
					var yd = yp - y;
					var zd = zp - z;
					var d = xd * xd + yd * yd + zd * zd;
					if (d < md) {
						md = d;
						xc = xp;
						yc = yp;
						zc = zp;
					}
				}
			}
		}
		var v : Float;
		if (distance) {
			var xd = xc - x;
			var yd = yc - y;
			var zd = zc - z;
			v = (Math.sqrt(xd * xd + yd * yd + zd * zd)) * Utils.SQRT3 - 1.0;
		}
		else {
			v = 0.0;
		}
		return v + (displacement * Utils.ValueNoise3D(Std.int(Math.floor(xc)), Std.int(Math.floor(yc)),
		Std.int(Math.floor(zc)), 0));
	}
}
