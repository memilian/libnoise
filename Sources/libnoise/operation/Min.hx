package libnoise.operation;


/**
  * Provides a noise module that outputs the smaller of the two output values from
  * two source modules. [OPERATOR]
  */
class Min extends ModuleBase {

	public function new(lhs : ModuleBase, rhs : ModuleBase) {
		super(2);
		set(0, lhs);
		set(1, rhs);
	}

	override public function getValue(x : Float, y : Float, z : Float) : Float {
		var a = get(0).getValue(x, y, z);
		var b = get(1).getValue(x, y, z);
		return Math.min(a,b);
	}
}
