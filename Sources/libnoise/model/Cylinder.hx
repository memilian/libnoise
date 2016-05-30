package libnoise.model;

class Cylinder{

    @:isVar public var module : ModuleBase;

    public inline function new(sourceModule : ModuleBase){ this.module = sourceModule; }

    /// Returns the output value from the noise module given the
    /// (angle, height) coordinates of the specified input value located
    /// on the surface of the cylinder.
    ///
    /// @param angle The angle around the cylinder's center, in degrees.
    /// @param height The height along the @a y axis.
    ///
    /// @returns The output value from the noise module.
    ///
    /// This cylinder has a radius of 1.0 unit and has infinite height.
    /// It is oriented along the @a y axis.  Its center is located at the
    /// origin.
    public inline function getValue(angle:Float, height:Float):Float {
        var x = Math.cos(angle * 0.017);
        var y = height;
        var z = Math.sin(angle * 0.017);
        return module.getValue(x,y,z);
    }
}