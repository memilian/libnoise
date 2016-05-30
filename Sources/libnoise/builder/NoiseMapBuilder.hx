package libnoise.builder;

/**
 Abstract base class for a noise-map builder

 A builder class builds a noise map by filling it with coherent-noise
 values generated from the surface of a three-dimensional mathematical
 object.  Each builder class defines a specific three-dimensional
 surface, such as a cylinder, sphere, or plane.

 A builder class describes these input values using a coordinate system
 applicable for the mathematical object (e.g., a latitude/longitude
 coordinate system for the spherical noise-map builder.)  It then
 "flattens" these coordinates onto a plane so that it can write the
 coherent-noise values into a two-dimensional noise map.

 <b>Building the Noise Map</b>

 To build the noise map, perform the following steps:
 - Pass the bounding coordinates to the SetBounds() method.
 - Pass the noise map size, in points, to the SetDestSize() method.
 - Pass a NoiseMap object to the SetDestNoiseMap() method.
 - Pass a noise module (derived from noise::module::Module) to the
   SetSourceModule() method.
 - Call the Build() method.

 You may also pass a callback function to the SetCallback() method.
 The Build() method calls this callback function each time it fills a
 row of the noise map with coherent-noise values.  This callback
 function has a single integer parameter that contains a count of the
 rows that have been completed.  It returns void.

 Note that SetBounds() is not defined in the abstract base class; it is
 only defined in the derived classes.  This is because each model uses
 a different coordinate system.
**/
class NoiseMapBuilder{

    /// The height of the destination noise map, in points.
    ///
    /// This object does not change the height in the destination noise
    /// map object until the Build() method is called.
    @:isVar public var destHeight : Int;

    /// The height of the destination noise map, in points.
    ///
    /// This object does not change the height in the destination noise
    /// map object until the Build() method is called.
    @:isVar public var destWidth : Int;

    /// The destination noise map will contain the coherent-noise values
    /// from this noise map after a successful call to the Build() method.
    ///
    /// The destination noise map must exist throughout the lifetime of
    /// this object unless another noise map replaces that noise map.
    @:isVar public var destNoiseMap : NoiseMap;

    /// This object fills in a noise map with the coherent-noise values
    /// from this source module.
    ///
    /// The source module must exist throughout the lifetime of this
    /// object unless another noise module replaces that noise module.
    @:isVar public var sourceModule : ModuleBase;

    /// The callback function that Build() calls each time it fills a row
    /// of the noise map with coherent-noise values.
    ///
    /// This callback function has a single integer parameter that
    /// contains a count of the rows that have been completed.
    @:isVar public var callback : Int -> Void;

    public function new() {}

    /// Builds the noise map.
    ///
    /// @pre SetBounds() was previously called.
    /// @pre SetDestNoiseMap() was previously called.
    /// @pre SetSourceModule() was previously called.
    /// @pre The width and height values specified by SetDestSize() are
    /// positive.
    /// @pre The width and height values specified by SetDestSize() do not
    /// exceed the maximum possible width and height for the noise map.
    ///
    /// @post The original contents of the destination noise map is
    /// destroyed.
    ///
    /// @throw noise::ExceptionInvalidParam See the preconditions.
    /// @throw noise::ExceptionOutOfMemory Out of memory.
    ///
    /// If this method is successful, the destination noise map contains
    /// the coherent-noise values from the noise module specified by
    /// SetSourceModule().
    public function build():Void {
        throw "NoiseMapBuilder.build is abstract";
    }

    public function setDestSize(width : Int, heigth : Int):Void {
        destWidth = width;
        destHeight = heigth;
    }
}