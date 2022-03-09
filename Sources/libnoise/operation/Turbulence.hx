package libnoise.operation;

import libnoise.generator.Perlin;
import libnoise.QualityMode;

/**
 * Provides a noise module that that randomly displaces the input value before
 * returning the output value from a source module. [OPERATOR]
 **/

 class Turbulence  extends ModuleBase{

	static inline var X0 : Float = (12414.0 / 65536.0);
	static inline var Y0 : Float = (65124.0 / 65536.0);
	static inline var Z0 : Float = (31337.0 / 65536.0);
	static inline var X1 : Float = (26519.0 / 65536.0);
	static inline var Y1 : Float = (18128.0 / 65536.0);
	static inline var Z1 : Float = (60493.0 / 65536.0);
	static inline var X2 : Float = (53820.0 / 65536.0);
	static inline var Y2 : Float = (11213.0 / 65536.0);
	static inline var Z2 : Float = (44845.0 / 65536.0);

	public var power = 1.0;
	var xDistort : Perlin;
	var yDistort : Perlin;
	var zDistort : Perlin;

	public function new(power : Float, input : ModuleBase, ?distortX : Perlin, ?distortY : Perlin, ?distortZ : Perlin) {
		super(1);

		set(0, input);

		this.power = power;

		if(distortX == null)
			this.xDistort = new Perlin(1.0, 2.0, 0.5, 6, 123, MEDIUM);
		else
			this.xDistort = distortX;
		if(distortY == null)
			this.yDistort = new Perlin(1.0, 2.0, 0.5, 6, 123, MEDIUM);
		else
			this.yDistort = distortY;
		if(distortZ == null)
			this.zDistort = new Perlin(1.0, 2.0, 0.5, 6, 123, MEDIUM);
		else
			this.zDistort = distortZ;
	}

	// set the roughness of the turbulence.
	public function setFrequency(frequency : Float){
		xDistort.frequency = frequency;
		yDistort.frequency = frequency;
		zDistort.frequency = frequency;
	}

	// set the roughness of the turbulence.
	public function setRoughness(roughness : Int){
		xDistort.octaves = roughness;
		yDistort.octaves = roughness;
		zDistort.octaves = roughness;
	}

	// set the seed of the turbulence.
	public function setSeed(seed : Int){
		xDistort.seed = seed;
		yDistort.seed = seed;
		zDistort.seed = seed;
	}

	override public function getValue(x : Float, y : Float, z : Float) : Float{
		var xd = x + (xDistort.getValue(x + X0, y + Y0, z + Z0) * power);
		var yd = y + (yDistort.getValue(x + X1, y + Y1, z + Z1) * power);
		var zd = z + (zDistort.getValue(x + X2, y + Y2, z + Z2) * power);
		return get(0).getValue(xd, yd, zd);
	}
}
