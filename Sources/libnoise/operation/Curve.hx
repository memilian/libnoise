package libnoise.operation;

import haxe.ds.ArraySort;

/**
 * Provides a noise module that maps the output value from a source module onto an
 * arbitrary function curve.
 */
class Curve extends ModuleBase {

	var data : Array<Array<Float>>;

	/**
	 *	Initializes a new instance of Curve.
     *  @param "input" The input module
	 */

	public function new(input : ModuleBase) {
		super(1);
		set(0, input);

		data = new Array<Array<Float>>();
	}

	public inline function controlPointCount() : Int {
		return data.length;
	}


	/**
	 *	Add a control point to the curve
	 *	@param input : The curve input value.
	 *	@param output : The curve output value.
	 */

	public function add(input : Float, output : Float) {
		var vec = new Array<Float>();
		vec[0] = input;
		vec[1] = output;
		for(v in data){
			if(v[0] == input)
				return;
		}
		data.push(vec);
		ArraySort.sort(data, function(a : Array<Float>, b : Array<Float>) {
			return a[0] < b[0] ? -1 : a[0] == b[0] ? 0 : 1;
		});
	}

	/**
	 *	Clear the control points
	 */

	public inline function clear() {
		data = new Array<Array<Float>>();
	}

	override public function getValue(x : Float, y : Float, z : Float) {

		var smv = get(0).getValue(x, y, z);
		var ip = 0;
		for (i in 0...data.length) {
			if (smv < data[ip++][0])
				break;
		}

		var i0 = Utils.Clamp(ip - 2, 0, data.length - 1);
		var i1 = Utils.Clamp(ip - 1, 0, data.length - 1);
		var i2 = Utils.Clamp(ip, 0, data.length - 1);
		var i3 = Utils.Clamp(ip + 1, 0, data.length - 1);

		if (i1 == i2)
			return data[i1][1];

		var ip0 = data[i1][0];
		var ip1 = data[i2][0];
		var a = (smv - ip0) / (ip1 - ip0);
		return Utils.InterpolateCubic(data[i0][1], data[i1][1], data[i2][1], data[i3][1], a);

	}
}
