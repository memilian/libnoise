package libnoise.generator;

class Cylinder extends ModuleBase{
	var frequency = 1.0;

	public function new(frequency : Float) {
		super(0);
		this.frequency = frequency;
	}

	override public function getValue(x : Float, y : Float, z : Float) : Float{
		x *= frequency;
		z *= frequency;
		var dfc = Math.sqrt(x * x + z * z);
		var dfss = dfc - Math.floor(dfc);
		var dfls = 1.0 - dfss;
		var nd = Math.min(dfss, dfls);
		return 1.0 - (nd * 4.0);
	}
}
