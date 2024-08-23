package backend;

typedef AnimData =
{
	var name:String;
	var prefix:String;
	var fps:Float;
	var looped:Bool;
	var flipX:Bool;
	var flipY:Bool;
}

enum ColliderType
{
	FLOOR;
	WALL;
	// PUSHABLE; -- Later.
	CONTROLLER;
	NPC;
	NONE;
}

class Common {}
