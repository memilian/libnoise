package libnoise.operation;


/**
  * Provides a noise module that outputs the product of the two output values from
  * two source modules. [OPERATOR]
  */
class Multiply extends ModuleBase {

	public function new(lhs : ModuleBase, rhs : ModuleBase) {
		super(2);
		set(0, lhs);
		set(1, rhs);
	}

	override public function getValue(x : Float, y : Float, z : Float) : Float {
		return get(0).getValue(x, y, z)*get(1).getValue(x, y, z);
	}
}
