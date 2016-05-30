package libnoise.builder;

/**
 Builds a spherical noise map.

 This class builds a noise map by filling it with coherent-noise values
 generated from the surface of a sphere.

 This class describes these input values using a (latitude, longitude)
 coordinate system.  After generating the coherent-noise value from the
 input value, it then "flattens" these coordinates onto a plane so that
 it can write the values into a two-dimensional noise map.

 The sphere model has a radius of 1.0 unit.  Its center is at the
 origin.

 The x coordinate in the noise map represents the longitude.  The y
 coordinate in the noise map represents the latitude.

 The application must provide the southern, northern, western, and
 eastern bounds of the noise map, in degrees.
**/
import libnoise.model.Sphere;
class NoiseMapBuilderSphere extends NoiseMapBuilder{

    /// Eastern boundary of the spherical noise map, in degrees.
    @:isVar public var eastLonBound : Float;

    /// Northern boundary of the spherical noise map, in degrees.
    @:isVar public var northLatBound : Float;

    /// Southern boundary of the spherical noise map, in degrees.
    @:isVar public var southLatBound : Float;

    /// Western boundary of the spherical noise map, in degrees.
    @:isVar public var westLonBound : Float;

    public function new() { super(); }

    /**
     Sets the coordinate boundaries of the noise map.

     @param southLatBound The southern boundary of the noise map, in
     degrees.
     @param northLatBound The northern boundary of the noise map, in
     degrees.
     @param westLonBound The western boundary of the noise map, in
     degrees.
     @param eastLonBound The eastern boundary of the noise map, in
     degrees.

     @pre The southern boundary is less than the northern boundary.
     @pre The western boundary is less than the eastern boundary.
    **/
    public function setBounds (southLatBound : Float, northLatBound : Float, westLonBound : Float, eastLonBound : Float)
    {
        if (southLatBound >= northLatBound
        || westLonBound >= eastLonBound) {
            throw 'Invalid parameter';
        }

        this.southLatBound = southLatBound;
        this.northLatBound = northLatBound;
        this.westLonBound  = westLonBound ;
        this.eastLonBound  = eastLonBound ;
    }

    override public function build():Void {
        if ( eastLonBound <= westLonBound
        || northLatBound <= southLatBound
        || destWidth <= 0
        || destHeight <= 0
        || sourceModule == null
        || destNoiseMap == null)
            throw 'Invalid parameter';

        var sphere : Sphere = new Sphere(sourceModule);

        var lonExtent = eastLonBound - westLonBound;
        var latExtent = northLatBound - southLatBound;
        var xDelta : Float = lonExtent / destWidth;
        var yDelta : Float = latExtent / destHeight;
        var curLon = westLonBound;
        var curLat = southLatBound;

        for(y in 0...destHeight){
            curLon = westLonBound;
            for(x in 0...destWidth){
                var curValue = sphere.getValue(curLat, curLon);
                this.destNoiseMap.setValue(x,y,curValue);
                curLon += xDelta;
            }
            curLat += yDelta;
            if(callback != null)
                callback(y);
        }
    }
}