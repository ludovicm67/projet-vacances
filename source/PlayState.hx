package;

import flixel.FlxState;
import flixel.FlxG;

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

		player = new Player();
		add(player);
			
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
