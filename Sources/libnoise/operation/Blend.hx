package libnoise.operation;

/**
 * Provides a noise module that outputs a weighted blend of the output values from
 * two source modules given the output value supplied by a control module. [OPERATOR]
 */
class Blend extends ModuleBase {

	public var controller(get, set) : ModuleBase;

	public inline function set_controller(value : ModuleBase){
		return set(2, value);
	}

	public inline function get_controller(){
		return get(2);
	}

	/**
	 *	Initializes a new instance of Blend.
     *  @param "lhs" : The left hand input module.
     *  @param "rhs" : The right hand input module.
     *  @param "controller" The controller of the operator.
     *  @param "input" The input module
	 */
	public function new(rhs : ModuleBase, lhs : ModuleBase, controller : ModuleBase) {
		super(3);
		set(0, rhs);
		set(1, lhs);
		set(2, controller);
	}

	override public function getValue(x : Float, y : Float, z : Float) {
		var a = get(0).getValue(x,y,z);
		var b = get(1).getValue(x,y,z);
		var c = (get(2).getValue(x,y,z)+1.0)/2.0;
		return Utils.InterpolateLinear(a,b,c);
	}
}
