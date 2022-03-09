package libnoise.operation;


/**
  * Provides a noise module that outputs the larger of the two output values from
  * two source modules. [OPERATOR]
  */
class Max extends ModuleBase {

	public function new(lhs : ModuleBase, rhs : ModuleBase) {
		super(2);
		set(0, lhs);
		set(1, rhs);
	}

	override public function getValue(x : Float, y : Float, z : Float) : Float {
		var a = get(0).getValue(x, y, z);
		var b = get(1).getValue(x, y, z);
		return Math.max(a,b);
	}
}
