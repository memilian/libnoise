package libnoise.builder;

/// Builds a cylindrical noise map.
///
/// This class builds a noise map by filling it with coherent-noise values
/// generated from the surface of a cylinder.
///
/// This class describes these input values using an (angle, height)
/// coordinate system.  After generating the coherent-noise value from the
/// input value, it then "flattens" these coordinates onto a plane so that
/// it can write the values into a two-dimensional noise map.
///
/// The cylinder model has a radius of 1.0 unit and has infinite height.
/// The cylinder is oriented along the @a y axis.  Its center is at the
/// origin.
///
/// The x coordinate in the noise map represents the angle around the
/// cylinder's y axis.  The y coordinate in the noise map represents the
/// height above the x-z plane.
///
/// The application must provide the lower and upper angle bounds of the
/// noise map, in degrees, and the lower and upper height bounds of the
/// noise map, in units.
import libnoise.model.Cylinder;
class NoiseMapBuilderCylinder extends NoiseMapBuilder{

    /// Lower angle boundary of the cylindrical noise map, in degrees.
    @:isVar public var lowerAngleBound : Float;

    /// Lower height boundary of the cylindrical noise map, in units.
    @:isVar public var lowerHeightBound : Float;

    /// Upper angle boundary of the cylindrical noise map, in degrees.
    @:isVar public var upperAngleBound : Float;

    /// Upper height boundary of the cylindrical noise map, in units.
    @:isVar public var upperHeightBound : Float;

    public function new() { super(); }

    public function setBounds(lowerAngleBound:Float, upperAngleBound:Float, lowerHeightBound:Float, upperHeightBound:Float):Void {
        if(lowerAngleBound >= upperAngleBound || lowerHeightBound >= upperHeightBound)
            throw 'Invalid parameter';
        this.lowerHeightBound = lowerHeightBound;
        this.lowerAngleBound = lowerAngleBound;
        this.upperHeightBound = upperHeightBound;
        this.upperAngleBound = upperAngleBound;
    }

    override public function build():Void {
        if ( upperAngleBound <= lowerAngleBound
        || upperHeightBound <= lowerHeightBound
        || destWidth <= 0
        || destHeight <= 0
        || sourceModule == null
        || destNoiseMap == null)
            throw 'Invalid parameter';

        var cylinder : Cylinder = new Cylinder(sourceModule);

        var angleExtent = upperAngleBound - lowerAngleBound;
        var heightExtent = upperHeightBound - lowerHeightBound;
        var xDelta : Float = angleExtent / destWidth;
        var yDelta : Float = heightExtent / destHeight;
        var curAngle = lowerAngleBound;
        var curHeight = lowerHeightBound;

        for(y in 0...destHeight){
            curAngle = lowerAngleBound;
            for(x in 0...destWidth){
                var curValue = cylinder.getValue(curAngle, curHeight);
                this.destNoiseMap.setValue(x,y,curValue);
                curAngle += xDelta;
            }
            curHeight += yDelta;
            if(callback != null)
                callback(y);
        }
    }
}