package libnoise.operation;

/**
 * Provides a noise module that maps the output value from a source module onto an
 * exponential curve. [OPERATOR]
 */
class Exponent extends ModuleBase {

	public var exponent = 1.0;


	/**
	 *	Initializes a new instance of Exponent.
     *  @param "exponent" The exponent to use
     *  @param "input" The input module
	 */

	public function new(exponent : Float, input : ModuleBase) {
		super(1);
		set(0, input);
		this.exponent = exponent;
	}

	override public function getValue(x : Float, y : Float, z : Float) {
		var value = get(0).getValue(x, y, z);
		return Math.pow(Math.abs((value + 1) / 2.0), exponent) * 2 - 1;
	}
}
