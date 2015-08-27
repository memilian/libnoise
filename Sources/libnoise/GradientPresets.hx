package libnoise;

//Don't use this yet
	/*
class GradientPresets {

	static var Empty(default,null) : Gradient;
	static var Grayscale(default,null) : Gradient;
	static var Rgb(default,null) : Gradient;
	static var Rgba(default,null) : Gradient;
	static var Terrain(default,null) : Gradient;

	public static function __init__(){
		// Grayscale gradient color keys
		var grayscaleColorKeys = new List<GradientColorKey>();
		grayscaleColorKeys.push(new GradientColorKey(Color.black, 0));
		grayscaleColorKeys.push(new GradientColorKey(Color.white, 1));

		// RGB gradient color keys
		var rgbColorKeys = new List<GradientColorKey>();
		rgbColorKeys.push(new GradientColorKey(Color.red, 0));
		rgbColorKeys.push(new GradientColorKey(Color.green, 0.5));
		rgbColorKeys.push(new GradientColorKey(Color.blue, 1));

		// RGBA gradient color keys
		var rgbaColorKeys = new List<GradientColorKey>();
		rgbaColorKeys.push(new GradientColorKey(Color.red, 0));
		rgbaColorKeys.push(new GradientColorKey(Color.green, 1 / 3));
		rgbaColorKeys.push(new GradientColorKey(Color.blue, 2 / 3));
		rgbaColorKeys.push(new GradientColorKey(Color.black, 1));


		// RGBA gradient alpha keys
		var rgbaAlphaKeys = new List<GradientAlphaKey>();
		rgbaAlphaKeys.push(new GradientAlphaKey(0, 2 / 3));
		rgbaAlphaKeys.push(new GradientAlphaKey(1, 1));

		// Terrain gradient color keys
		var terrainColorKeys = new List<GradientColorKey>();
		terrainColorKeys.push(new GradientColorKey(new Color(0, 0, 0.5), 0));
		terrainColorKeys.push(new GradientColorKey(new Color(0.125, 0.25, 0.5), 0.4));
		terrainColorKeys.push(new GradientColorKey(new Color(0.25, 0.375, 0.75), 0.48));
		terrainColorKeys.push(new GradientColorKey(new Color(0, 0.75, 0), 0.5));
		terrainColorKeys.push(new GradientColorKey(new Color(0.75, 0.75, 0), 0.625));
		terrainColorKeys.push(new GradientColorKey(new Color(0.625, 0.375, 0.25), 0.75));
		terrainColorKeys.push(new GradientColorKey(new Color(0.5, 1, 1), 0.875));
		terrainColorKeys.push(new GradientColorKey(Color.white, 1));

		// Generic gradient alpha keys
		var alphaKeys = new List<GradientAlphaKey>();
		alphaKeys.push(new GradientAlphaKey(1, 0));
		alphaKeys.push(new GradientAlphaKey(1, 1));

		Empty = new Gradient();

		Rgb = new Gradient();
		Rgb.SetKeys(rgbColorKeys.ToArray(), alphaKeys.ToArray());

		Rgba = new Gradient();
		Rgba.SetKeys(rgbaColorKeys.ToArray(), rgbaAlphaKeys.ToArray());

		Grayscale = new Gradient();
		Grayscale.SetKeys(grayscaleColorKeys.ToArray(), alphaKeys.ToArray());

		Terrain = new Gradient();
		Terrain.SetKeys(terrainColorKeys.ToArray(), alphaKeys.ToArray());
	}


}
*/