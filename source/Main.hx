package;

import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite
{
	public var zoom:Float = 1.75;

	public function new()
	{
		super();
		Reg.init();

		addChild(new FlxGame(Std.int(1280/zoom), Std.int(720/zoom), PlayState));
	}
}
