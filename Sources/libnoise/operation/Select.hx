package libnoise.operation;

/**
 *	Provide a noise module that outputs the value selected from one of the two sources
 * 	modules choosen by the output value from a control module [OPERATOR]
 */
class Select extends ModuleBase {

	public var fallOff : Float;
	public var raw : Float;
	public var min : Float = -1.0;
	public var max : Float = 1.0;

	/**
	 *	@param min : The minimum value
	 *	@param max : The maximum value
	 *	@param fallOff : the fallOff value at the edge transition
	 *  @param inputA : The first input module
	 *	@param inputB : The second input module
	 *	@param controller : The controller module
	 */

	public function new(min = -1.0, max = 1.0, fallOff = 0.0, inputA : ModuleBase, inputB : ModuleBase, controller : ModuleBase) {
		super(3);
		set(0, inputA);
		set(1, inputB);
		set(2, controller);
		this.min = min;
		this.max = max;
		this.fallOff = fallOff;
	}

	override public function getValue(x : Float, y : Float, z : Float) : Float {

		var cv = get(2).getValue(x, y, z);
		if (fallOff > 0) {

			var a : Float;

			if (cv < min - fallOff)
				return get(0).getValue(x, y, z);

			if (cv < min + fallOff) {

				var lc = min - fallOff;
				var uc = min + fallOff;
				a = Utils.MapCubicSCurve((cv - lc) / (uc - lc));
				return Utils.InterpolateLinear(get(0).getValue(x, y, z), get(1).getValue(x, y, z), a);
			}

			if (cv < max - fallOff)
				return get(1).getValue(x, y, z);

			if (cv < max + fallOff) {

				var lc = max - fallOff;
				var uc = max + fallOff;
				a = Utils.MapCubicSCurve((cv - lc) / (uc - lc));
				return Utils.InterpolateLinear(get(1).getValue(x, y, z), get(0).getValue(x, y, z), a);
			}
			return get(0).getValue(x,y,z);
		}
		if(cv < min || cv > max)
			return get(0).getValue(x,y,z);

		return get(1).getValue(x,y,z);
	}
}
