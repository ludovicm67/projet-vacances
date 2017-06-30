package;

import flixel.group.FlxGroup.FlxTypedGroup;
import objects.Door;

class Reg {

    public static var gravity:Float = 9.81;
    public static var pixelsPerMeter:Int = 64;
    public static var doors:FlxTypedGroup<Door>;

    public static function init():Void
    {
        doors = new FlxTypedGroup<Door>();
    }

    public static function toScale(variable:Float):Float
    {
        return pixelsPerMeter * variable;
    }
}