package objects;

import flixel.text.FlxText;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.FlxG;

class Door extends FlxGroup
{
    public var isOpen = false;
    public var range = 64;

    private var context:PlayState;
    private var text:FlxText;
    private var sprite:FlxSprite;

    public function new(context:PlayState, ?x:Float, ?y:Float, isOpenDefault:Bool)
    {
        super();
        this.context = context;

        // Creating the door sprite
        sprite = new FlxSprite(x+64-3, y);
        sprite.loadGraphic(AssetPaths.door__png, true, 64, 64);
        sprite.setSize(3, 64);
        sprite.offset.set(64-3, 0);
        sprite.immovable = true;

        // Adding animations for opening and closing
        sprite.animation.add("close", [0], 1, false);
        sprite.animation.add("open", [1], 1, false);
        add(sprite);

        // Adding the text that pops over the door
        text = new FlxText(0, 0, 0, "Press E to open/close the door", 12);
        text.setPosition(sprite.x - Std.int(text.width / 2), sprite.y - 12 - 12);
        add(text);

        interract(isOpenDefault);
    }

    // Function to open and close the door
    public function interract(open:Bool)
    {
        isOpen = open;
        if (isOpen)
        {
            sprite.animation.play("open");
            sprite.solid = false;
        }
        else
        {
            sprite.animation.play("close");
            sprite.solid = true;
        }
    }

    override public function update(elapsed:Float)
    {
        // If the player is near the door we show the text and listen to the key's input
        if (context.player.getMidpoint().distanceTo(sprite.getMidpoint()) <= range)
        {
            text.visible = true;
            if (FlxG.keys.justPressed.E)
                interract(!isOpen);
        }
        else
            text.visible = false;
    }
}