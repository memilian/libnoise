package libnoise.generator;

class Checker extends ModuleBase {

	public function new() {
		super(0);
	}

	override public function getValue(x : Float, y : Float, z : Float) : Float{
		var ix = Std.int(Math.floor(Utils.MakeInt32Range(x)));
		var iy = Std.int(Math.floor(Utils.MakeInt32Range(y)));
		var iz = Std.int(Math.floor(Utils.MakeInt32Range(z)));
		return (ix & 1 ^ iy & 1 ^ iz & 1) != 0 ? -1.0 : 1.0;
	}
}
