package backend.utils;

import flixel.graphics.FlxGraphic;

class FileUtil
{
	public static var cache:Map<String, FlxGraphic> = new Map<String, FlxGraphic>();

	public static function addGraphicToCache(path:String, graphic:FlxGraphic)
	{
		cache.set(path, graphic);
	}

	public static function getGraphicFromCache(path:String):FlxGraphic
	{
		return cache.get(path);
	}
}
