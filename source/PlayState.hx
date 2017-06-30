package;

import flixel.FlxState;
import flixel.FlxG;
import entities.Bird;

class PlayState extends FlxState
{
	public var player:Player;
	public var map:MapLoader;

	override public function create():Void
	{
		// Loading the map and adding layers
		map = new MapLoader(this, AssetPaths.map__json);
		for (layer in map.layers)
			add(layer);
		add(map.collision_layer);
		add(map.objects);

		player = new Player(640, 192);
		add(player);

		var bird = new Bird(this, 324, 192);
		add(bird);
		var bird2 = new Bird(this, 964, 192);
		add(bird2);

		FlxG.camera.follow(player, TOPDOWN, 0.1);
		FlxG.camera.setScrollBoundsRect(0, 0, map.fullWidth, map.fullHeight);
		FlxG.worldBounds.set(0, 0, map.fullWidth, map.fullHeight);
			
		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		FlxG.collide(player, map.collision_layer);
		FlxG.collide(player, Reg.doors);

		player.isOnLadder = player.overlaps(Reg.ladders);
	}
}
