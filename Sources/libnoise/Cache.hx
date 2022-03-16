package libnoise;

import haxe.macro.Expr;

/**
 * A 3D array of data, used internally.
 */
class Cache<T> {

	@:noCompletion public var data : Array<Array<Array<T>>> = null;

	public var empty(get, never) : Bool;

	@:noCompletion public var xMin : Int = 0;
	@:noCompletion public var yMin : Int = 0;
	@:noCompletion public var zMin : Int = 0;
	@:noCompletion public var xMax : Int = -1;
	@:noCompletion public var yMax : Int = -1;
	@:noCompletion public var zMax : Int = -1;

	public inline function new() {
	}

	/**
	 * @param calculateValue An expression that calculates the value to cache at (`x`, `y`, `z`). The
	 * expression will have access to `x`, `y`, and `z`, even if the calling function doesn't define them.
	 */
	public macro function allocate<T>(self : ExprOf<Cache<T>>, xMin : ExprOf<Int>, yMin : ExprOf<Int>, zMin : ExprOf<Int>, xMax : ExprOf<Int>, yMax : ExprOf<Int>, zMax : ExprOf<Int>, calculateValue : ExprOf<T>) : Expr {
		return macro {
			$self.data =
				[for (x in $xMin...($xMax + 1))
					[for (y in $yMin...($yMax + 1))
						[for (z in $zMin...($zMax + 1))
							$calculateValue
						]
					]
				];

			$self.xMin = $xMin;
			$self.yMin = $yMin;
			$self.zMin = $zMin;
			$self.xMax = $xMax;
			$self.yMax = $yMax;
			$self.zMax = $zMax;
		}
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
