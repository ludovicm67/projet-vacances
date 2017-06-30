package;

import flixel.group.FlxGroup;
import flixel.FlxObject;
import objects.Door;

class Reg {

    public static var gravity:Float = 9.81;
    public static var pixelsPerMeter:Int = 64;
    public static var doors:FlxTypedGroup<Door>;
    public static var ladders:FlxGroup;

    public static function init():Void
    {
        doors = new FlxTypedGroup<Door>();
        ladders = new FlxGroup();
    }

    public static function toScale(variable:Float):Float
    {
        return pixelsPerMeter * variable;
    }

    public static function distance(obj1:FlxObject, obj2:FlxObject)
    {
        var mid1 = obj1.getMidpoint();
        var mid2 = obj2.getMidpoint();
        return mid1.distanceTo(mid2);
    }
}