package libnoise.generator;

class RidgedMultifractal extends ModuleBase{

	var weights : Array<Float> = new Array<Float>();
	public var frequency : Float;
	public var lacunarity : Float;
	public var persistence : Float;
	public var octaves : Int;
	public var seed : Int;
	public var quality : QualityMode;

	public function new(frequency : Float, lacunarity : Float, octaves : Int, seed : Int, quality : QualityMode) {
		this.frequency = frequency;
		this.lacunarity = lacunarity;
		this.octaves = octaves;
		this.seed = seed;
		this.quality = quality;
		updateWeights();
		super(0);
	}

	override public function getValue(x : Float, y : Float, z : Float) : Float {
		x *= frequency;
		y *= frequency;
		z *= frequency;
		var value = 0.0;
		var weight = 1.0;
		var offset = 1.0;
		var gain = 2.0;
		for (i in 0...octaves) {
			var nx = Utils.MakeInt32Range(x);
			var ny = Utils.MakeInt32Range(y);
			var nz = Utils.MakeInt32Range(z);
			var _seed  : Int = (seed + i) & 0x7fffffff;
			var signal = Utils.GradientCoherentNoise3D(nx, ny, nz, _seed, quality);
			signal = Math.abs(signal);
			signal = offset - signal;
			signal *= signal;
			signal *= weight;
			weight = signal * gain;
			weight = weight > 1.0 ? 1.0 : weight < 0 ? 0 : weight;
			value += (signal * weights[i]);
			x *= lacunarity;
			y *= lacunarity;
			z *= lacunarity;
		}
		return (value * 1.25) - 1.0;
	}

	function updateWeights(){
		var f = 1.0;
		for (i in 0...(Utils.OctavesMaximum))
		{
			weights.push(Math.pow(f, -1.0));
			f *= lacunarity;
		}
	}
}
