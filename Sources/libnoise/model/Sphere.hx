package libnoise.model;

class Sphere{

    @:isVar public var module : ModuleBase;

    public inline function new(sourceModule : ModuleBase){ this.module = sourceModule; }

    /**
     Returns the output value from the noise module given the
     (latitude, longitude) coordinates of the specified input value
     located on the surface of the sphere.

     @param lat The latitude of the input value, in degrees.
     @param lon The longitude of the input value, in degrees.

     @returns The output value from the noise module.

     Use a negative latitude if the input value is located on the
     southern hemisphere.

     Use a negative longitude if the input value is located on the
     western hemisphere.
     **/
    public inline function getValue(lat:Float, lon:Float):Float {
        var r =     Math.cos(0.017 * lat);
        var x = r * Math.cos(0.017 * lon);
        var y =     Math.sin(0.017 * lat);
        var z = r * Math.sin(0.017 * lon);
        return module.getValue(x,y,z);
    }
}