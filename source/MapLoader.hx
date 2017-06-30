package;

import haxe.Json;
import openfl.Assets;
import flixel.tile.FlxTilemap;
import flixel.group.FlxGroup;
import flixel.FlxSprite;
import flixel.FlxObject;
import objects.Door;

class MapLoader{

    public var tileset_path:String;
    public var tileheight:Int;
    public var tilewidth:Int;
    public var fullWidth:Int;
    public var fullHeight:Int;

    public var layers:FlxGroup;
    public var collision_layer:FlxTilemap;
    public var objects:FlxGroup;

    public function new(context:PlayState, filename:String) {

        layers = new FlxGroup();
        objects = new FlxGroup();

        // Getting the file's content and parsing it to json_map
        var file_content:String = Assets.getText(filename);
        var json_map = Json.parse(file_content);   

        // Distributing in the correct variables
        tileset_path = json_map.tilesets[0].image;
        tileset_path = "assets" + tileset_path.substr(2, tileset_path.length - 2);
        tileheight = Std.parseInt(json_map.tileheight);
        tilewidth = Std.parseInt(json_map.tilewidth);

        // Getting the map's settings
        fullHeight = json_map.height * tileheight;
        fullWidth = json_map.width * tilewidth;

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

                // Adding animated tiles
                
                for (sid in Reflect.fields(json_map.tilesets[0].tileproperties))
                {
                    var id:Int = Std.parseInt(sid); 
                    var tile_property = Reflect.field(json_map.tilesets[0].tileproperties, sid);
                    var anim_path = tile_property.animation;
                    //trace(id, anim_path);
                    var frames:Array<Int> = Json.parse(tile_property.frames);
                    var framerate = Std.parseInt(tile_property.framerate);
                    var instances = layer.getTileInstances(id+1);
                    if (instances != null)
                    {
                        for (index in instances)
                        {
                            var coord = layer.getTileCoordsByIndex(index, false);
                            var spr = layer.tileToSprite(Std.int(coord.x/64), Std.int(coord.y/64));
                            spr.loadGraphic("assets/images/" + anim_path, true, 64, 64);
                            spr.animation.add("idle", frames, framerate, true);
                            spr.animation.play("idle");
                            
                            layers.add(spr);
                        }
                    }
                }

                // If the layer is a collision layer
                if (json_layer.name == "collision")
                {
                    layer.visible = false;
                    layer.setTileProperties(4, FlxObject.UP, null, null); // Setting up One-way collision
                    collision_layer = layer;
                }
                else // The layer is just a tile layer
                {
                    // Stack them
                    layers.add(layer);
                }
            }
            else if (json_layer.type == "objectgroup") // Object layer
            {
                var json_objects:Array<Dynamic> = json_layer.objects;
                for (json_object in json_objects)
                {
                    if (json_object.type.toLowerCase() == "door")
                    {
                        var door = new Door(context, json_object.x, json_object.y - 64, false);
                        objects.add(door);
                        Reg.doors.add(door);
                    }
                    else if (json_object.type.toLowerCase() == "ladder")
                    {
                        var ladder = new FlxSprite(json_object.x, json_object.y - 64);
                        ladder.visible = false;
                        ladder.setSize(json_object.width, json_object.height);
                        Reg.ladders.add(ladder);
                    }
                }
            }
        }
    }
}