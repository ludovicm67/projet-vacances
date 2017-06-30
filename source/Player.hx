package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxObject;

class Player extends FlxSprite
{
    public var maxTimeHeld:Float = 0.1;
    public var maxJump:Bool = false;
    public var airMovementCoeff:Float = 0.8;
    public var isOnLadder:Bool = false;

    public var weapon:FlxSprite;

    private var gravity:Float = 9.81 * 64;
    private var timeHeld:Float = 0;
    private var isJumping:Bool = false;

    public function new(?X:Float=0, ?Y:Float=0) 
	{
        super(X, Y);

        loadGraphic(AssetPaths.player__png, true, 64, 64);

        drag.set(64*30, 6400*1.4);
        maxVelocity.set(64*4, 64*10);

        setSize(16, 60);
        offset.set(24, 4);

        animation.add("idle", [0, 1, 2, 3], 4, true);
        animation.add("walk", [4, 5, 6, 7, 8, 9, 10, 11], 12, true);
        animation.play("idle");
    }

    override public function update(elapsed:Float)
    {
        movement();
        jump(elapsed);

        super.update(elapsed);
    }

    private function movement()
    {
		var left = FlxG.keys.anyPressed([LEFT, Q]);
		var right = FlxG.keys.anyPressed([RIGHT, D]);

        var accValue = (isTouching(FlxObject.DOWN))?drag.x:drag.x*airMovementCoeff;

        acceleration.x = 0;
        if (left)
			acceleration.x -= accValue;
		else if (right)
			acceleration.x += accValue;
    }

    private function jump(elapsed:Float)
    {
        var up = FlxG.keys.anyPressed([UP, Z]);
        var down = FlxG.keys.anyPressed([DOWN, S]);

        if (isOnLadder)
        {
            acceleration.y = 0;
            if(up)
                velocity.y -= drag.y * 0.017;
            else if (down)
                velocity.y += drag.y * 0.0175;
        }
        else {
            acceleration.y = gravity;

            if (up && timeHeld == 0 && isTouching(FlxObject.DOWN) && !isJumping)
            {
                isJumping = true;
                acceleration.y -= drag.y;
            }
            if (up && timeHeld <= maxTimeHeld && !maxJump && isJumping)
            {
                timeHeld += elapsed;
               acceleration.y -= drag.y * 0.2;
            }
            else if (up && timeHeld > maxTimeHeld)
            {
                maxJump = true;
            }
            else if (!up && timeHeld != 0)
            {
                timeHeld = 0;
                maxJump = false;
            }
            else if (!up)
            {
                isJumping = false;
            }
        }
    }

    override public function draw()
    {
        super.draw();
        if (acceleration.x > 0)
        {
            facing = FlxObject.RIGHT;
            flipX = false;
            animation.play("walk");
        }
        else if (acceleration.x < 0)
        {
            facing = FlxObject.LEFT;
            flipX = true;
            animation.play("walk");
        }
        else {
            animation.play("idle");
        }
    }
}