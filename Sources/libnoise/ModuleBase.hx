package libnoise;

class ModuleBase {

	var modules : Array<ModuleBase>;

	public function new(count : Int) {
		if (count > 0)
			modules = new Array<ModuleBase>();
	}

	public inline function get(index : Int) {
		return this.modules[index];
	}

	public inline function set(index : Int, value : ModuleBase) {
		return this.modules[index] = value;
	}

	public inline function length(){
		return modules.length;
	}

	public function getValue(x : Float, y : Float, z : Float) : Float{
		throw "ModuleBase.getValue is an abstract method";
		return 0;
	}

	//TODO: see if dispose functions need to be implemented (cf https://github.com/ricardojmendez/LibNoise.Unity/blob/master/ModuleBase.cs#L158)

}
