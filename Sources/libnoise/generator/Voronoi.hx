package libnoise.generator;

import libnoise.Cache;

class Voronoi extends ModuleBase {

	var pointCache : Cache<Vector>;
	var frequency : Float;
	var displacement : Float;
	var seed : Int;
	var distance : Bool;

	public function new(frequency : Float, displacement : Float, seed : Int, distance : Bool) {
		this.frequency = frequency;
		this.displacement = displacement;
		this.seed = seed;
		this.distance = distance;
		pointCache = new Cache();
		super(0);
	}

	override public function getValue(x : Float, y : Float, z : Float) : Float {
		x *= frequency;
		y *= frequency;
		z *= frequency;
		var xi = Math.floor(x);
		var iy = Math.floor(y);
		var iz = Math.floor(z);
		var md = 2147483647.0;
		var xc : Float = 0;
		var yc : Float = 0;
		var zc : Float = 0;
		for (zcu in (iz - 2)...(iz + 3)) {
			for (ycu in (iy - 2)...(iy + 3)) {
				for (xcu in (xi - 2)...(xi + 3)) {
					var xp : Float;
					var yp : Float;
					var zp : Float;
					if (pointCache.inBounds(xcu, ycu, zcu)) {
						var p : Vector = pointCache.get(xcu, ycu, zcu);
						xp = p.x;
						yp = p.y;
						zp = p.z;
					} else {
						xp = xcu + Utils.ValueNoise3D(xcu, ycu, zcu, seed);
						yp = ycu + Utils.ValueNoise3D(xcu, ycu, zcu, seed + 1);
						zp = zcu + Utils.ValueNoise3D(xcu, ycu, zcu, seed + 2);
					}
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

	@:inheritDoc
	public override function cache(xMin : Float, yMin : Float, zMin : Float, xMax : Float, yMax : Float, zMax : Float) {
		var xMinInt : Int = Math.floor(xMin * frequency) - 2;
		var yMinInt : Int = Math.floor(yMin * frequency) - 2;
		var zMinInt : Int = Math.floor(zMin * frequency) - 2;
		var xMaxInt : Int = Math.floor(xMax * frequency) + 2;
		var yMaxInt : Int = Math.floor(yMax * frequency) + 2;
		var zMaxInt : Int = Math.floor(zMax * frequency) + 2;

		pointCache.allocate(xMinInt, yMinInt, zMinInt, xMaxInt, yMaxInt, zMaxInt,
			new Vector(x + Utils.ValueNoise3D(x, y, z, seed),
				y + Utils.ValueNoise3D(x, y, z, seed + 1),
				z + Utils.ValueNoise3D(z, y, z, seed + 2)));
	}

	@:inheritDoc
	public override function clearCache() : Void {
		pointCache.clear();
	}
}

class Vector {
	public var x : Float;
	public var y : Float;
	public var z : Float;

	public inline function new(x : Float, y : Float, z : Float) {
		this.x = x;
		this.y = y;
		this.z = z;
	}
}
