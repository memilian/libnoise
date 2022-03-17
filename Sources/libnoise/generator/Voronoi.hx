package libnoise.generator;

import libnoise.Cache;

/**
 * Provides a noise module that outputs Voronoi cells. [GENERATOR]
 */
class Voronoi extends ModuleBase {

	var sites : Cache<Site>;
	var frequency : Float;
	var displacement : Float;
	var seed : Int;
	var useDistance : Bool;

	/**
	 * @param frequency The frequency of the site points.
	 * @param displacement The intensity of the output value. Multiplies everything except distance.
	 * @param seed The random seed.
	 * @param useDistance Indicates whether the distance from the nearest site is added to the output value.
	 */
	public function new(frequency : Float, displacement : Float, seed : Int, useDistance : Bool) {
		this.frequency = frequency;
		this.displacement = displacement;
		this.seed = seed;
		this.useDistance = useDistance;
		sites = new Cache();
		super(0);
	}

	override public function getValue(x : Float, y : Float, z : Float) : Float {
		x *= frequency;
		y *= frequency;
		z *= frequency;

		var xInt = Math.floor(x);
		var yInt = Math.floor(y);
		var zInt = Math.floor(z);

		var minDist = Math.POSITIVE_INFINITY;
		var xCandidate : Float = 0;
		var yCandidate : Float = 0;
		var zCandidate : Float = 0;

		// Inside each unit cube, there is a site at a random position.  Go
		// through each of the nearby cubes until we find a cube with a site
		// that is closest to (x, y, z).
		for (zCur in (zInt - 2)...(zInt + 3)) {
			for (yCur in (yInt - 2)...(yInt + 3)) {
				for (xCur in (xInt - 2)...(xInt + 3)) {
					// Calculate the position and distance to the site inside of
					// this unit cube.
					var siteX : Float;
					var siteY : Float;
					var siteZ : Float;
					if (sites.inBounds(xCur, yCur, zCur)) {
						var site : Site = sites.get(xCur, yCur, zCur);
						siteX = site.x;
						siteY = site.y;
						siteZ = site.z;
					} else {
						siteX = xCur + Utils.ValueNoise3D(xCur, yCur, zCur, seed);
						siteY = yCur + Utils.ValueNoise3D(xCur, yCur, zCur, seed + 1);
						siteZ = zCur + Utils.ValueNoise3D(xCur, yCur, zCur, seed + 2);
					}

					var dist = (siteX - x) * (siteX - x) + (siteY - y) * (siteY - y) + (siteZ - z) * (siteZ - z);
					if (dist < minDist) {
						// This site is closer than any others found so far.
						minDist = dist;
						xCandidate = siteX;
						yCandidate = siteY;
						zCandidate = siteZ;
					}
				}
			}
		}

		var value : Float;
		if (useDistance) {
			// Determine the distance to the nearest site.
			value = Math.sqrt(minDist) * Utils.SQRT3 - 1.0;
		}
		else {
			value = 0.0;
		}
		return value + (displacement * Utils.ValueNoise3D(Std.int(Math.floor(xCandidate)), Std.int(Math.floor(yCandidate)),
		Std.int(Math.floor(zCandidate)), 0));
	}

	@:inheritDoc
	public override function cache(xMin : Float, yMin : Float, zMin : Float, xMax : Float, yMax : Float, zMax : Float) {
		sites.allocate(
			Math.floor(xMin * frequency) - 2,
			Math.floor(yMin * frequency) - 2,
			Math.floor(zMin * frequency) - 2,
			Math.floor(xMax * frequency) + 2,
			Math.floor(yMax * frequency) + 2,
			Math.floor(zMax * frequency) + 2,
			new Site(x + Utils.ValueNoise3D(x, y, z, seed),
				y + Utils.ValueNoise3D(x, y, z, seed + 1),
				z + Utils.ValueNoise3D(z, y, z, seed + 2)));
	}

	@:inheritDoc
	public override function clearCache() : Void {
		sites.clear();
	}
}

/**
 * The central point defining a Voronoi cell. Also known as a seed or a generator.
 */
class Site {
	public var x : Float;
	public var y : Float;
	public var z : Float;

	public inline function new(x : Float, y : Float, z : Float) {
		this.x = x;
		this.y = y;
		this.z = z;
	}
}
