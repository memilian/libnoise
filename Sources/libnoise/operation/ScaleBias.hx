package libnoise.operation;

/**
  * Provides a noise module that applies a scaling factor and a bias to the output
  * value from a source module. [OPERATOR]
  */
class ScaleBias extends ModuleBase{

	public var scale : Float;
	public var bias : Float;

	public function new(scale = 1.0, bias = 0.0, input : ModuleBase) {
		super(1);
		set(0, input);
		this.scale = scale;
		this.bias = bias;
	}

	override public function getValue(x: Float, y : Float, z : Float) : Float{
		return get(0).getValue(x,y,z) * scale + bias;
	}
}
