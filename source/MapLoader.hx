package;

import haxe.Json;
import openfl.Assets;
import flixel.tile.FlxTilemap;

class MapLoader{

    public var tileset_path:String;
    public var tileheight:Int;
    public var tilewidth:Int;
    public var layers:Array<FlxTilemap>;

    public function new(filename:String) {

        layers = new Array<FlxTilemap>();

        // Getting the file's content and parsing it to json_map
        var file_content:String = Assets.getText(filename);
        var json_map = Json.parse(file_content);    

        // Distributing in the correct variables
        tileset_path = json_map.tilesets[0].image;
        tileset_path = "assets" + tileset_path.substr(2, tileset_path.length - 2);
        tileheight = Std.parseInt(json_map.tileheight);
        tilewidth = Std.parseInt(json_map.tilewidth);

        // For each layer
        var json_layers:Array<Dynamic> = json_map.layers;
        for (json_layer in json_layers)
        {
            // Getting layer infos
            var layer = new FlxTilemap();
            var width = Std.parseInt(json_layer.width);
            var height = Std.parseInt(json_layer.height);
            layer.loadMapFromArray(json_layer.data, width, height, tileset_path, tilewidth, tileheight, null, 1, 1, 1);
            // Stack them
            layers.push(layer);
        }
    }
}