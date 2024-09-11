package backend.utils;

import flixel.graphics.FlxGraphic;
import hx.files.File;

class FileUtil
{
	public static var cache:Map<String, FlxGraphic> = new Map<String, FlxGraphic>();

	public static function addGraphicToCache(path:String, graphic:FlxGraphic)
	{
		cache.set(path, graphic);
	}

	public static function getUIGraphicFromCache(path:String):FlxGraphic
	{
		return cache.get(path);
	}

	public static function copyFileTo(f:File, target:String):File
	{
		try
		{
			f.copyTo(target);
		}
		catch (e)
		{
			f.copyTo(target, [OVERWRITE]);
		}
		return File.of(target);
	}
}
