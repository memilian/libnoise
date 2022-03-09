package libnoise.operation;

import haxe.ds.ArraySort;
/**
  * Provides a noise module that maps the output value from a source module onto a
  * terrace-forming curve. [OPERATOR]
  */
  
class Terrace extends ModuleBase {

	public var data : Array<Float>;
	public var inverted : Bool;

	public function new(input : ModuleBase, ?inverted = false) {
		super(1);
		set(0, input);
		this.inverted = inverted;
		this.data = new Array<Float>();
	}

	public inline function controlPointCount() : Int {
		return data.length;
	}

	public function clear() {
		data = new Array<Float>();
	}

	public function add(value : Float) {
		for (val in data)
			if (val == value)
				return;
		data.push(value);
		ArraySort.sort(data, function(a : Float, b : Float) return a < b ? -1 : a == b ? 0 : 1);
	}

	//auto-generate a terrace curve

	public function generate(steps : Int) {
		#if debug
		if (steps < 2)
			throw "Need at least two steps";
		#end
		clear();
		var ts = 2.0 / (steps - 1.0);
		var cv = -1.0;
		for (i in 0...steps) {
			add(cv);
			cv += ts;
		}
	}

	override public function getValue(x : Float, y : Float, z : Float) {
		#if debug
		if (length() < 1)
			throw "need a module";
		if (controlPointCount() < 2)
			throw "need at least 2 controls points";
		#end

		var smv = get(0).getValue(x, y, z);
		var ip = 0;
		for (i in 0...data.length) {
			if (smv < data[ip++])
				break;
		}

		var i0 = (ip - 1 < 0) ? 0 : (ip - 1 > data.length - 1) ? data.length - 1 : ip - 1;
		var i1 = (ip < 0) ? 0 : (ip > data.length - 1) ? data.length - 1 : ip;

		if (i0 == i1) {
			return data[i1];
		}

		var v0 = data[i0];
		var v1 = data[i1];
		var a = (smv - v0) / (v1 - v0);

		if (inverted) {
			a = 1.0 - a;
			var t = v0;
			v0 = v1;
			v1 = t;
		}

		a *= a;
		return Utils.InterpolateLinear(v0, v1, a);
	}


}
