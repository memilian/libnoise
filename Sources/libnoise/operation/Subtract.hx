package libnoise.operation;

class Subtract extends ModuleBase {

	/**
	 *
	 * 	@param lhs : The left hand input module
	 * 	@param rhs : The right hand input module
	 */
	public function new(lhs : ModuleBase, rhs : ModuleBase) {
		super(2);
		set(0, lhs);
		set(1, rhs);
	}

	override public function getValue(x : Float, y : Float, z : Float) : Float {

		#if debug
		if (get(0) == null)
			throw "modules[0] should not be null";
		if (get(1) == null)
			throw "modules[1] should not be null";
		#end

		return get(0).getValue(x,y,z) - get(1).getValue(x,y,z);
	}
}
