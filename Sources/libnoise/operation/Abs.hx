package libnoise.operation;

/**
 * Provides a noise module that outputs the absolute value of the output value from
 * a source module. [OPERATOR]
 */
class Abs extends ModuleBase {


	/**
	 *	Initializes a new instance of Abs.
     *  @param "input" The input module
	 */
	public function new(input : ModuleBase) {
		super(1);
		set(0, input);
	}

	override public function getValue(x : Float, y : Float, z : Float) {
		return Math.abs(get(0).getValue(x, y, z));
	}
}
