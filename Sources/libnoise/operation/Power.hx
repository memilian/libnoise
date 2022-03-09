package libnoise.operation;


/**
  * Provides a noise module that outputs value from a first source module
  * to the power of the output value from a second source module. [OPERATOR]
  */
class Power extends ModuleBase {

	public function new(lhs : ModuleBase, rhs : ModuleBase) {
		super(2);
		set(0, lhs);
		set(1, rhs);
	}

	override public function getValue(x : Float, y : Float, z : Float) : Float {
		return Math.pow(get(0).getValue(x, y, z), get(1).getValue(x, y, z));
	}
}
