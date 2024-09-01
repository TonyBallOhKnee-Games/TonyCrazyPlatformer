package backend.utils;

import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.system.FlxAssets.FlxXmlAsset;

typedef AnimData =
{
	var name:String;
	var prefix:String;
	var fps:Float;
	var looped:Bool;
	var flipX:Bool;
	var flipY:Bool;
}

typedef PlayerAssets =
{
	var charPath:String;
	var charImg:FlxGraphicAsset;
	var charXml:FlxXmlAsset;
	var deathImg:FlxGraphicAsset;
	var deathXml:FlxXmlAsset;
	var dialogueImg:FlxGraphicAsset;
	var dialogueXml:FlxXmlAsset;
	var properties:Array<Array<String>>;
	var animBindings:Array<Array<String>>;
	var soundData:Array<Array<String>>;
}

typedef NPCAssets =
{
	var npcPath:String;
	var npcImg:FlxGraphicAsset;
	var npcXml:FlxXmlAsset;
	// I need to make this a lot bigger when needed.
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

	public static function parseBool(s:String)
	{ // this can be a one-liner, i forgot how though
		if (s == "true")
			return true;
		return false;
	}
}
