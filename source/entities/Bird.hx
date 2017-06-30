package entities;

import flixel.FlxObject;

class Bird extends BasicEntity{

    public var detection_range:Float = 64 * 2;
    public var speed:Float = 64 * 4;

    private var context:PlayState;

    public function new(context:PlayState, ?x:Float, ?y:Float) {
        super(x, y);
        this.context = context;

        loadGraphic(AssetPaths.crow__png, true, 64, 64);
        animation.add("idle", [0], 4, true);
        animation.add("flee", [0], 4, true);

        brain.push(idle);
    }

    public function idle():Void
    {
        if (Reg.distance(this, context.player) < detection_range)
        {
            brain.pop();
            brain.push(flee);
        }

        animation.play("idle");
    }

    public function flee():Void
    {
        var dir_x = this.getMidpoint().subtractPoint(context.player.getMidpoint()).x;
        velocity.y = -speed;
        velocity.x = (dir_x > 0)?speed:-speed;
        velocity.x /= 2;

        facing = (dir_x > 0)?FlxObject.RIGHT:FlxObject.LEFT;
        flipX = (dir_x > 0)?false:true;

        animation.play("flee");
    }
}