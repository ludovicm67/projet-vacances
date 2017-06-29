# Introduction

This is a small colaborative project for hollidays and to try a new langage and explore game mecanics through a small plateformer game.

# Goal of each class
## MapLoader
Class that will load a map from a JSON file and the corresponding tileset.

## Reg
Static class which contains only static functions and static variables, used for global variables.

# Compilation

In order to compile the project you have to install a few things :

1. First install Haxe : [https://haxe.org/](https://haxe.org/)

2. Then install flixel with the following command typed in the command prompt : 
```
haxelib install flixel
```

3. Install the lime command with : 
```
haxelib run lime setup
``` 

4. and then the flixel command : 
```
haxelib install flixel-tools 
haxelib run flixel-tools setup
```

To compile you just need to go in the project folder and run the following command : 
```
lime test <env>
```
With the environment as in the following : `windows linux neko flash html` (we recommand neko as it is the most consistent through plateforms)