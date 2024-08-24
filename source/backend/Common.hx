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

class Common
{
	public static function sign(value:Float):Int
	{
		if (value > 0)
			return 1;
		if (value < 0)
			return -1;
		return 0;
	}
}
