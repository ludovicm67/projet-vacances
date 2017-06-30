package entities;

import flixel.FlxSprite;

class BasicEntity extends FlxSprite {

    public var brain:FSM;

    public function new(?x:Float, ?y:Float) {
        super(x, y);

        brain = new FSM();
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);
        brain.update(elapsed);
    }
}