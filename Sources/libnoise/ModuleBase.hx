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

	/**
	 * Caches values within the given region of space. Certain classes will use this to improve performance
	 * when you call `getValue()` within that region.
	 * 
	 * Only one region can be cached at a time. Trying to cache another will overwrite the first. To avoid
	 * this, create a new module instance if `isCacheEmpty()` returns false.
	 */
	public function cache(xMin : Float, yMin : Float, zMin : Float, xMax : Float, yMax : Float, zMax : Float) : Void {
		if (modules != null) {
			for (module in modules) {
				module.cache(xMin, yMin, zMin, xMax, yMax, zMax);
			}
		}
	}

	public function isCacheEmpty() : Bool {
		if (modules != null) {
			for (module in modules) {
				if (!module.isCacheEmpty()) {
					return false;
				}
			}
		}
		
		return true;
	}

	public function clearCache() : Void {
		for (module in modules) {
			module.clearCache();
		}
	}

	//TODO: see if dispose functions need to be implemented (cf https://github.com/ricardojmendez/LibNoise.Unity/blob/master/ModuleBase.cs#L158)

}
