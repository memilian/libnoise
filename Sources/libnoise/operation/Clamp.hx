package libnoise.operation;

/**
 * Provides a noise module that clamps the output value from a source module to a
 * range of values. [OPERATOR]
 */
class Clamp extends ModuleBase {

	public var min = -1.0;
	public var max = 1.0;

	/**
	 *	Initializes a new instance of Clamp.
     *  @param "min" : The minimum value
     *  @param "y" : The maximum value
     *  @param "input" The input module
	 */
	public function new(min : Float, max : Float, input : ModuleBase) {
		super(1);
		set(0,input);
		this.min = min;
		this.max = max;
	}

	override public function getValue(x : Float, y : Float, z : Float){
		#if debug
			if(min > max)
				throw "min should be inferior to max";
		#end
		var value = get(0).getValue(x,y,z);
		return value < min ? min : value > max ? max : value;
	}
}
