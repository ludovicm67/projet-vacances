package;

import haxe.Json;
import openfl.Assets;
import flixel.tile.FlxTilemap;
import flixel.group.FlxGroup;
import objects.Door;

class MapLoader{

    public var tileset_path:String;
    public var tileheight:Int;
    public var tilewidth:Int;
    public var layers:Array<FlxTilemap>;
    public var collision_layer:FlxTilemap;
    public var objects:FlxGroup;

    public function new(context:PlayState, filename:String) {

        layers = new Array<FlxTilemap>();
        objects = new FlxGroup();

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
            if (json_layer.type == "tilelayer") // Tile layer
            {
                // Getting layer infos
                var layer = new FlxTilemap();
                var width = Std.parseInt(json_layer.width);
                var height = Std.parseInt(json_layer.height);
                layer.loadMapFromArray(json_layer.data, width, height, tileset_path, tilewidth, tileheight, null, 1, 1, 1);
                // If the layer is a collision layer
                if (json_layer.name == "collision")
                {
                    layer.visible = false;
                    collision_layer = layer;
                }
                else // The layer is just a tile layer
                {
                    // Stack them
                    layers.push(layer);
                }
            }
            else if (json_layer.type == "objectgroup") // Object layer
            {
                var json_objects:Array<Dynamic> = json_layer.objects;
                for (json_object in json_objects)
                {
                    if (json_object.type == "door")
                    {
                        var door = new Door(context, Std.parseInt(json_object.x), Std.parseInt(json_object.y), false);
                        objects.add(door);
                        Reg.doors.add(door);
                    }
                }
            }
        }
    }
}