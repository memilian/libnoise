package libnoise.model;

class Plane{

    @:isVar public var module : ModuleBase;

    public inline function new(sourceModule : ModuleBase){ this.module = sourceModule; }

    /**
    Returns the output value from the noise module given the
     ( @a x, @a z ) coordinates of the specified input value located
     on the surface of the plane.

     @param x The @a x coordinate of the input value.
     @param z The @a z coordinate of the input value.

     @returns The output value from the noise module.
     **/
    public inline function getValue(x : Float, z : Float):Float {
        return module.getValue(x,0,z);
    }
}