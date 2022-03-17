package libnoise;

/**
 * A 3D array of data, used internally.
 */
class Cache<T> {

	var data : Array<Array<Array<T>>> = null;

	public var empty(get, never) : Bool;

	public var xMin(default, null) : Int = 0;
	public var yMin(default, null) : Int = 0;
	public var zMin(default, null) : Int = 0;
	public var xMax(default, null) : Int = -1;
	public var yMax(default, null) : Int = -1;
	public var zMax(default, null) : Int = -1;

	public inline function new() {
	}

	/**
	 * Allocates enough space to cache the given region. This will overwrite any existing data.
	 */
	public inline function allocate(xMin : Int, yMin : Int, zMin : Int, xMax : Int, yMax : Int, zMax : Int) : Void {
		data = [];
		for (x in 0...(xMax - xMin + 1)) {
			data.push([]);
			for (y in 0...(yMax - yMin + 1)) {
				data[x].push([]);

				// `resize()` will insert appropriate default values.
				data[x][y].resize(zMax - zMin + 1);
			}
		}

		this.xMin = xMin;
		this.yMin = yMin;
		this.zMin = zMin;
		this.xMax = xMax;
		this.yMax = yMax;
		this.zMax = zMax;
	}

	public inline function clear() : Void {
		data = null;
		xMin = 0;
		xMax = -1;
	}

	public inline function inBounds(x : Int, y : Int, z : Int) : Bool {
		return x >= xMin && x <= xMax && y >= yMin && y <= yMax && z >= zMin && z <= zMax;
	}

	/**
	 * Precondition: (`x`, `y`, `z`) is in bounds.
	 */
	public inline function get(x : Int, y : Int, z : Int) : T {
		return data[x - xMin][y - yMin][z - zMin];
	}

	/**
	 * Precondition: (`x`, `y`, `z`) is in bounds.
	 */
	public inline function set(x : Int, y : Int, z : Int, value : T) : T {
		return data[x - xMin][y - yMin][z - zMin] = value;
	}

	inline function get_empty() : Bool {
		return data == null;
	}
}
