package libnoise.builder;

/// Builds a planar noise map.
///
/// This class builds a noise map by filling it with coherent-noise values
/// generated from the surface of a plane.
///
/// This class describes these input values using (x, z) coordinates.
/// Their y coordinates are always 0.0.
///
/// The application must provide the lower and upper x coordinate bounds
/// of the noise map, in units, and the lower and upper z coordinate
/// bounds of the noise map, in units.
///
/// To make a tileable noise map with no seams at the edges, call the
/// EnableSeamless() method.
import libnoise.Utils;
import libnoise.model.Plane;
class NoiseMapBuilderPlane  extends NoiseMapBuilder{

    /// Lower x boundary of the planar noise map, in units.
    @:isVar public var lowerXBound : Float;

    /// Lower z boundary of the planar noise map, in units.
    @:isVar public var lowerZBound : Float;

    /// Upper x boundary of the planar noise map, in units.
    @:isVar public var upperXBound : Float;

    /// Upper z boundary of the planar noise map, in units.
    @:isVar public var upperZBound : Float;

    /// A flag specifying whether seamless tiling is enabled.
    @:isVar public var isSeamlessEnabled : Bool;

    public function new() { super(); }

    /// Sets the boundaries of the planar noise map.
    ///
    /// @param lowerXBound The lower x boundary of the noise map, in
    /// units.
    /// @param upperXBound The upper x boundary of the noise map, in
    /// units.
    /// @param lowerZBound The lower z boundary of the noise map, in
    /// units.
    /// @param upperZBound The upper z boundary of the noise map, in
    /// units.
    ///
    /// @pre The lower x boundary is less than the upper x boundary.
    /// @pre The lower z boundary is less than the upper z boundary.
    public function setBounds(lowerXBound:Float, lowerZBound:Float, upperXBound:Float, upperZBound:Float):Void {
        if(lowerXBound >= upperXBound || lowerZBound >= upperZBound)
            throw 'Invalid parameter';
        this.lowerZBound = lowerZBound;
        this.lowerXBound = lowerXBound;
        this.upperZBound = upperZBound;
        this.upperXBound = upperXBound;
    }

    override public function build():Void {
        if ( upperXBound <= lowerXBound
        || upperZBound <= lowerZBound
        || destWidth <= 0
        || destHeight <= 0
        || sourceModule == null
        || destNoiseMap == null)
            throw 'Invalid parameter';

        var plane : Plane = new Plane(sourceModule);

        var xExtent = upperXBound - lowerXBound;
        var zExtent = upperZBound - lowerZBound;
        var xDelta : Float = xExtent / destWidth;
        var zDelta : Float = zExtent / destHeight;
        var xCur    = lowerXBound;
        var zCur    = lowerZBound;

        for(z in 0...destHeight){
            xCur = lowerXBound;
            for(x in 0...destWidth){
                var curValue : Float;
                if(!isSeamlessEnabled)
                    curValue = plane.getValue(x, z);
                else{
                    var swValue = plane.getValue (xCur          , zCur          );
                    var seValue = plane.getValue (xCur + xExtent, zCur          );
                    var nwValue = plane.getValue (xCur          , zCur + zExtent);
                    var neValue = plane.getValue (xCur + xExtent, zCur + zExtent);
                    var xBlend = 1.0 - ((xCur - lowerXBound) / xExtent);
                    var zBlend = 1.0 - ((zCur - lowerZBound) / zExtent);
                    var z0 = Utils.InterpolateLinear(swValue, seValue, xBlend);
                    var z1 = Utils.InterpolateLinear(nwValue, neValue, xBlend);
                    curValue = Utils.InterpolateLinear(z0, z1, zBlend);
                }
                this.destNoiseMap.setValue(x,z,curValue);
                xCur += xDelta;
            }
            zCur += zDelta;
            if(callback != null)
                callback(z);
        }
    }
}