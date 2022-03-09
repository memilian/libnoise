package libnoise.operation;


/**
  * Provides a noise module that inverts the output value from a source module. [OPERATOR]
  */
class Invert extends ModuleBase {

	public function new(input : ModuleBase) {
		super(1);
		set(0, input);
	}

	override public function getValue(x : Float, y : Float, z : Float) : Float {
		return -get(0).getValue(x,y,z);
	}
}
