package libnoise.generator;

class Billow extends ModuleBase {

	@range()
	public var frequency : Float;
	public var lacunarity : Float;
	public var persistence : Float;
	public var octaves : Int;
	public var seed : Int;
	public var quality : QualityMode;

	public function new(frequency : Float, lacunarity : Float, persistence : Float, octaves : Int, seed : Int, quality : QualityMode) {
		this.frequency = frequency;
		this.lacunarity = lacunarity;
		this.persistence = persistence;
		this.octaves = octaves;
		this.seed = seed;
		this.quality = quality;
		super(0);
	}

	override public function getValue(x : Float, y : Float, z : Float) : Float {
		var value = 0.0;
		var curp = 1.0;
		x *= frequency;
		y *= frequency;
		z *= frequency;
		for (i in 0...octaves) {
			var nx = Utils.MakeInt32Range(x);
			var ny = Utils.MakeInt32Range(y);
			var nz = Utils.MakeInt32Range(z);
			var _seed = (seed + i) & 0xffffffff;
			var signal = Utils.GradientCoherentNoise3D(nx, ny, nz, _seed, quality);
			signal = 2.0 * Math.abs(signal) - 1.0;
			value += signal * curp;
			x *= lacunarity;
			y *= lacunarity;
			z *= lacunarity;
			curp *= persistence;
		}
		return value + 0.5;
	}
}
