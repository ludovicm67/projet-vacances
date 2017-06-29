package;

import flixel.FlxState;

class PlayState extends FlxState
{
	override public function create():Void
	{
		// Loading the map and adding layers
		var map = new MapLoader(AssetPaths.map__json);
		for (layer in map.layers)
			add(layer);
			
		super.create();
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
