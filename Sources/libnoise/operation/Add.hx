package libnoise.operation;

/**
 * Provides a noise module that outputs the sum of the two output values from two
 * source modules. [OPERATOR]
 */
class Add extends ModuleBase {


	/**
	 *	Initializes a new instance of Add.
     *  @param "lhs" The left hand input module.
     *  @param "rhs" The left hand input module.
	 */
	public function new(lhs : ModuleBase, rhs : ModuleBase) {
		super(2);
		set(0, lhs);
		set(1, rhs);
	}

	override public function getValue(x : Float, y : Float, z : Float) {
		var val1 = get(0).getValue(x,y,z);
		var val2 = get(1).getValue(x,y,z);
		return val1 + val2;
	}
}
