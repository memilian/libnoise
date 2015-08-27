package libnoise.generator;

class Const extends ModuleBase{

	var value : Int;

	public function new(value : Int) {
		super(0);
		this.value = value;
	}

	override public function getValue(x : Float, y : Float, z : Float) : Float{
		return value;
	}
}
