package ;
import libnoise.operation.Add;
import libnoise.operation.Add;
import libnoise.operation.Abs;
import libnoise.operation.Blend;
import libnoise.operation.Cache;
import libnoise.operation.Clamp;
import libnoise.operation.Exponent;
import libnoise.operation.Displace;
import libnoise.Utils;
import libnoise.operation.Curve;
import libnoise.ModuleBase;
import libnoise.operation.Invert;
import libnoise.operation.Max;
import libnoise.operation.Min;
import libnoise.operation.Power;
import libnoise.operation.Multiply;
import libnoise.operation.Rotate;
import libnoise.operation.Scale;
import libnoise.operation.ScaleBias;
import libnoise.operation.Select;
import libnoise.operation.Subtract;
import libnoise.operation.Terrace;
import libnoise.operation.Translate;
import libnoise.operation.Turbulence;
import libnoise.generator.Voronoi;
import libnoise.generator.Sphere;
import libnoise.generator.Cylinder;
import libnoise.generator.Const;
import libnoise.generator.Checker;
import libnoise.generator.RidgedMultifractal;
import libnoise.generator.Billow;
import libnoise.builder.NoiseMap;
import libnoise.builder.NoiseMapBuilderPlane;
import libnoise.builder.NoiseMapBuilderCylinder;
import libnoise.builder.NoiseMapBuilderSphere;
import libnoise.builder.NoiseMapBuilder;

import format.png.Tools;
import format.png.Writer;
import format.png.Data;
import sys.io.FileOutput;
import sys.io.File;
import haxe.io.BytesBuffer;
import haxe.Timer;
import haxe.io.Bytes;

import libnoise.QualityMode;
import libnoise.generator.Perlin;

class Test {

	public static function main() {
		new Test();
	}

	//dimensions of output images
	var width = 512;
	var height = 512;

	//path to directory where images will be saved
	var outputPath = "test/images/";

	//default modules parameters
	var frequency = 0.01;
	var lacunarity = 2.0;
	var persistence = 0.5;
	var octaves = 16;
	var seed = 42;
	var quality = HIGH;


	public function new() {
		var testName = "";
		var module : ModuleBase;

		//Perlin generator
		testName = "perlin";
		module = new Perlin(frequency, lacunarity, persistence, octaves, seed, quality);
		generate([module], testName);

		//Billow generator
		testName = "billow";
		module = new Billow(frequency, lacunarity, persistence, octaves, seed, quality);
		generate([module], testName);

		//Ridged Multifractal generator
		testName = "ridged_multifractal";
		module = new RidgedMultifractal(frequency, persistence, 1, seed, quality);
		generate([module], testName);

		//Checker generator
		testName = "checker";
		module = new Checker();
		generate([module], testName);

		//Const generator
		testName = "const";
		module = new Const(1);
		generate([module], testName);

		//Cylinder generator
		testName = "cylinder";
		module = new Cylinder(frequency);
		generate([module], testName);

		//Sphere generator
		testName = "sphere";
		module = new Sphere(frequency);
		generate([module], testName);

		//Voronoi generator - distance on
		testName = "voronoi_distance_on";
		module = new Voronoi(frequency * 2, 1, seed, true);
		generate([module], testName);

		//Voronoi generator - distance off
		testName = "voronoi_distance_off";
		module = new Voronoi(frequency * 2, 1, seed, false);
		generate([module], testName);

		/**
		 * 	Operators
		 */

		//Abs operator
		testName = "abs";
		var absIn = new Billow(frequency, lacunarity, persistence, octaves, seed, quality);
		var abs = new Abs(absIn);
		generate([absIn, abs], testName);

		//Add operator
		testName = "add";
		var addIn1 = new Billow(frequency, lacunarity, persistence, octaves, seed, quality);
		var addIn2 = new RidgedMultifractal(frequency*2, lacunarity, 1, seed, quality);
		var add = new Add(addIn1, addIn2);
		generate([addIn1, addIn2, add], testName);

		//Blend operator
		testName = "blend";
		var blendIn1 = new Perlin(frequency/2, lacunarity, persistence, octaves, 657, quality);
		var blendIn2 = new Billow(frequency, lacunarity, persistence, octaves, seed, quality);
		var blendCtrl = new Sphere(0.006);
		var blend = new Blend(blendIn1, blendIn2, blendCtrl);
		generate([blendIn1, blendIn2, blendCtrl, blend], testName);

		//Cache operator
		testName = "cache";
		var cacheInp = new Billow(frequency, lacunarity, persistence, octaves, seed, quality);
		var cache = new Cache(cacheInp);
		generate([cacheInp, cache], testName);

		//Clamp operator
		testName = "clamp";
		var clampInp = new Billow(frequency, lacunarity, persistence, octaves, seed, quality);
		var clamp = new Clamp(0,0.5,clampInp);
		generate([clampInp, clamp], testName);

		//Curve operator
		testName = "Curve";
		var curveInpt = new Billow(frequency, lacunarity, persistence, octaves, seed, quality);
		var curve = new Curve(curveInpt);
		curve.add(-1, -1);
		curve.add(-0.5, 0);
		curve.add(0, -0.3);
		curve.add(1, 1);
		generate([curveInpt, curve], testName);

		//Displace operator
		testName = "displace";
		var dIn = new Sphere(0.003);
		var dX = new ScaleBias(10, 0, new Billow(frequency/2, lacunarity, persistence, octaves, seed, quality));
		var dY = new ScaleBias(30, 0, new RidgedMultifractal(frequency*2, lacunarity, octaves, seed, quality));
		var dZ = new Const(1);
		var disp = new Displace(dIn, dX, dY, dZ);
		generate([dIn, dX, dY, dZ, disp], testName);

		//Exponent operator
		testName = "exponent";
		var expIn = new Sphere(0.006);
		var exp = new Exponent(3, expIn);
		generate([expIn, exp], testName);

		//Invert operator
		testName = "invert";
		var inv1 = new Billow(frequency, lacunarity, persistence, octaves, seed, quality);
		var invert = new Invert(inv1);
		generate([inv1, invert], testName);

		//Max operator
		testName = "max";
		var max1 = new Billow(frequency, lacunarity, persistence, octaves, seed, quality);
		var max2 = new Cylinder(frequency);
		generate([max1, max2, new Max(max1, max2)], testName);

		//Min operator
		testName = "min";
		var min1 = new Billow(frequency, lacunarity, persistence, octaves, seed, quality);
		var min2 = new Cylinder(frequency);
		generate([min1, min2, new Min(min1, min2)], testName);

		//Multiply operator
		testName = "multiply";
		var pow1 = new Rotate(0, 0, 90, new Cylinder(frequency));
		var pow2 = new Cylinder(frequency);
		generate([pow1, pow2, new Multiply(pow1, pow2)], testName);

		//Power operator
		testName = "power";
		var pow1 = new Perlin(frequency, lacunarity, persistence, octaves, seed, quality);
		var pow2 = new Cylinder(frequency / 3);
		generate([pow1, pow2, new Power(pow1, pow2)], testName);

		//Rotate operator
		testName = "rotate";
		module = new Cylinder(frequency);
		var rotate = new Rotate(30, 0, 45, module);
		generate([module, rotate], testName);

		//Scale operator
		testName = "scale";
		module = new Perlin(frequency, lacunarity, persistence, octaves, seed, quality);
		var scale = new Scale(2.0, 2.0, 2.0, module);
		generate([module, scale], testName);

		//ScaleBias operator
		testName = "scaleBias";
		module = new Perlin(frequency, lacunarity, persistence, octaves, seed, quality);
		var scaleBias = new ScaleBias(0.5, 0.5, module);
		generate([module, scaleBias], testName);

		//Select operator
		testName = "select";
		var inpA = new Perlin(frequency, lacunarity, persistence, octaves, seed, quality);
		var inpB = new Billow(frequency * 2, lacunarity, persistence, octaves, seed, quality);
		var controller = inpA;
		var select = new Select(0.3, 1.0, 0.9, inpA, inpB, controller);
		generate([inpA, inpB, controller, select], testName);

		//Subtract operator
		testName = "subtract";
		module = new Perlin(frequency, lacunarity, persistence, octaves, seed, quality);
		var rhs = new Sphere(frequency);
		var subtract = new Subtract(module, rhs);
		generate([module, rhs, subtract], testName);

		//Terrace operator
		testName = "terrace_6_steps";
		module = new Perlin(frequency, lacunarity, persistence, octaves, seed, quality);
		var terrace = new Terrace(module, true);
		terrace.generate(10); //generate 10 controls points from -1 to 1
		generate([module, terrace], testName);

		//Translate operator
		testName = "translate_x";
		module = new Perlin(frequency, lacunarity, persistence, octaves, seed, quality);
		var translate = new Translate(width / 2, 0, 0, module);
		generate([module, translate], testName);

		//Turbulence operator
		testName = "turbulences";
		module = new Sphere(0.003);//new Voronoi(frequency * 2, 1, seed, false);
		var turb = new Turbulence(10, module);
		turb.setFrequency(0.03);
		generate([module, turb], testName);

		 
                /**
                  *  NoiseMapBuilders
                  **/
                  
                module = new Perlin(frequency, lacunarity, persistence, octaves, seed, quality);
                
                testName = "Perlin_tileable";
                var planeMapBuilder = new NoiseMapBuilderPlane();
                planeMapBuilder.isSeamlessEnabled = true;   //set tileable
                planeMapBuilder.sourceModule = module;
                planeMapBuilder.setDestSize(width, height);
                planeMapBuilder.setBounds(0,0,width, height);
                planeMapBuilder.destNoiseMap = new NoiseMap(width,height);
                generateFromBuilders([planeMapBuilder, planeMapBuilder], testName);
                
                   
                //the cylinder is normalized, we need to increase frequency (or add a scale module)
                module = new Perlin(frequency * 100, lacunarity, persistence, octaves, seed, quality);
                
                testName = "Perlin_Cylinder";
                var cylinderMapBuilder = new NoiseMapBuilderCylinder();
                cylinderMapBuilder.sourceModule = module;
                cylinderMapBuilder.setDestSize(width, height);
                cylinderMapBuilder.setBounds(-180,180,0,2);
                cylinderMapBuilder.destNoiseMap = new NoiseMap(width,height);
                generateFromBuilders([cylinderMapBuilder], testName);
                
                
                //the sphere is normalized, we need to increase frequency (or add a scale module)
                module = new Perlin(frequency * 100, lacunarity, persistence, octaves, seed, quality);

                testName = "Perlin_Sphere";
                var sphereMapBuilder = new NoiseMapBuilderSphere();
                sphereMapBuilder.sourceModule = module;
                sphereMapBuilder.setDestSize(width, height);
                sphereMapBuilder.setBounds(-90,90,-180,180);
                sphereMapBuilder.destNoiseMap = new NoiseMap(width,height);
                generateFromBuilders([sphereMapBuilder], testName);
                
	}

	//generate a png containing the image of each modules next of each other

	public function generate(modules : Array<ModuleBase>, name : String) {
		var timeStart = Timer.stamp();

		var w = (modules.length) * width;


		//generate pixel values
		var data : BytesBuffer = new BytesBuffer();
		for (y in 0...height) {
			for (x in 0...w) {
				//pick a module based on the current x position
				var moduleIndex = Std.int(x / width);
				var xOff = moduleIndex * width;

				var value = getGreyValue(modules[moduleIndex].getValue(x - xOff, y, 0));
				data.addByte(value);
			}
		}

		createPng(data.getBytes(), w, height, name);

		var genTime = Timer.stamp() - timeStart;
		trace('Generated image $name in $genTime');
	}
	
	public function generateFromBuilders(builders : Array<NoiseMapBuilder>, name : String) {
		var timeStart = Timer.stamp();

		var w = (builders.length) * width;

		//generate noiseMaps
		for(builder in builders)
                    builder.build();

		//generate pixel values
		var data : BytesBuffer = new BytesBuffer();
		for (y in 0...height) {
			for (x in 0...w) {
				//pick a noiseMap based on the current x position
				var idx = Std.int(x / width);
				var xOff = idx * width;

				var value = getGreyValue(builders[idx].destNoiseMap.getValue(x - xOff, y));
				data.addByte(value);
			}
		}

		createPng(data.getBytes(), w, height, name);

		var genTime = Timer.stamp() - timeStart;
		trace('Generated image $name in $genTime');
	}

	public function getGreyValue(val : Float) {
		var val = Std.int(128 * (val + 1));
		return val > 255 ? 255 : val < 0 ? 0 : val;
	}

	public function createPng(data : Bytes, w : Int, h : Int, name : String) {
		var pngData : Data = Tools.buildGrey(w, h, data);
		var handle : FileOutput = File.write('$outputPath$name.png', true);
		var writer : Writer = new Writer(handle);
		writer.write(pngData);
	}
}
