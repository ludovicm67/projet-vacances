package;

class Reg {

    public static var gravity:Float = 9.81;
    public static var pixelsPerMeter:Int = 64;

    public function new() {
        
    }

    public static function toScale(variable:Float):Float
    {
        return pixelsPerMeter * variable;
    }
}