package libnoise.operation;


/**
  * Provides a noise module that scales the coordinates of the input value before
  * returning the output value from a source module. [OPERATOR]
  */
class Scale extends ModuleBase {

	private var sx : Float;
	private var sy : Float;
	private var sz : Float;

	public function new(sx = 1.0, sy = 1.0, sz = 1.0, input : ModuleBase) {
		super(1);
		set(0, input);
		this.sx = sx;
		this.sy = sy;
		this.sz = sz;
	}

	override public function getValue(x : Float, y : Float, z : Float) : Float {
		return get(0).getValue(x * sx, y * sy, z * sz);
	}
}
