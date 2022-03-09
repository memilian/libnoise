package libnoise.operation;

/**
 * Provides a noise module that moves the coordinates of the input value before
 * returning the output value from a source module. [OPERATOR]
 */
 
class Translate extends ModuleBase {

	public var dx = 1.0;
	public var dy = 1.0;
	public var dz = 1.0;

	/**
	 *	Initializes a new instance of Translate. 
     *  @param "x" The translation on the x-axis
     *  @param "y" The translation on the y-axis
     *  @param "z" The translation on the z-axis
     *  @param "input" The input module
	 */
	public function new(dx : Float, dy : Float, dz : Float, input : ModuleBase) {
		super(1);
		set(0,input);
		this.dx = dx;
		this.dy = dy;
		this.dz = dz;
	}

	override public function getValue(x : Float, y : Float, z : Float){
		return get(0).getValue(x + dx, y + dy, z + dz);
	}
}
