package libnoise.operation;

/**
 * Provides a noise module that uses three source modules to displace each
 * coordinate of the input value before returning the output value from
 * a source module. [OPERATOR]
 */
class Displace extends ModuleBase {

	public var X(get,set) : ModuleBase;
	public inline function set_X(val : ModuleBase){
		return set(1, val);
	}
	public inline function get_X() : ModuleBase{
		return get(1);
	}
	public var Y(get,set) : ModuleBase;
	public inline function set_Y(val : ModuleBase){
		return set(2, val);
	}
	public inline function get_Y() : ModuleBase{
		return get(2);
	}
	public var Z(get,set) : ModuleBase;
	public inline function set_Z(val : ModuleBase){
		return set(3, val);
	}
	public inline function get_Z() : ModuleBase{
		return get(3);
	}

	/**
	 *	Initializes a new instance of Displace.
     *  @param "input" The input module
     *  @param "x" The displacement module of the x-axis
     *  @param "y" The displacement module of the y-axis
     *  @param "z" The displacement module of the z-axis
	 */
	public function new(input : ModuleBase, x : ModuleBase, y : ModuleBase, z : ModuleBase) {
		super(4);
		set(0, input);
		set(1, x);
		set(2, y);
		set(3, z);
	}

	override public function getValue(x : Float, y : Float, z : Float) {
		var dx = x + get(1).getValue(x, y, z);
		var dy = y + get(2).getValue(x, y, z);
		var dz = z + get(3).getValue(x, y, z);
		return get(0).getValue(dx,dy,dz);
	}
}
