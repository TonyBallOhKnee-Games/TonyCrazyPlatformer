package backend.utils;

import cpp.vm.Gc;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileDiamond;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.TransitionData;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.FlxPoint;
import flixel.sound.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import haxe.Exception;
import lime.app.Application;
import openfl.display.BitmapData;
import openfl.utils.Assets;
import sys.FileSystem;
import sys.io.File;
import sys.thread.Thread;

using StringTools;

class CachingUtil
{
	public static var loadingStr:String = 'hehe, null.';

	// Images
	public static var subImagePaths:Array<String> = [];
	// public static var hudImagePaths:Array<String> = []; --Later.
	public static var subImages:Array<String> = [];
	public static var images:Array<String> = [];
	// Sounds/Music
	public static var sound:Array<String> = [];

	public static var fullSize:Int = 0;
	public static var doneCaching = false;
	public static var curProgress:Int = 0;

	public static function cacheBaseAssets()
	{
		if (subImagePaths.length <= 0)
		{
			subImagePaths.push('characters');
			subImagePaths.push('deathScreen');
			subImagePaths.push('levelSelector');
			subImagePaths.push('Pause');
			subImagePaths.push('saveings');
			subImagePaths.push('title');
			subImagePaths.push('warning');
		}
		for (path in subImagePaths)
		{
			for (file in FileSystem.readDirectory(FileSystem.absolutePath('assets/images/$path')))
			{
				if (!file.endsWith(".png"))
					continue;
				subImages.push('$path/$file');
				fullSize++;
			}
		}
		for (file in FileSystem.readDirectory(FileSystem.absolutePath("assets/images")))
		{
			if (!file.endsWith(".png"))
				continue;
			images.push('assets/images/$file');
			fullSize++;
		}
		for (file in FileSystem.readDirectory(FileSystem.absolutePath("assets/sounds")))
		{
			sound.push(file);
			fullSize++;
		}
		for (file in FileSystem.readDirectory(FileSystem.absolutePath("assets/music")))
		{
			sound.push(file);
			fullSize++;
		}

		Thread.create(() ->
		{ // Create a new thread so the game doesnt freeze
			cache();
		});
	}

	public static function cache()
	{
		curProgress = 0;
		for (i in images)
		{
			curProgress++;
			loadingStr = 'Loading: $i';
			var data:BitmapData = BitmapData.fromFile(i);
			var graphic:FlxGraphic = FlxGraphic.fromBitmapData(data);
			graphic.persist = true;
			graphic.destroyOnNoUse = false;
			FileUtil.addGraphicToCache(i, graphic);
		}
		for (i in subImages)
		{
			curProgress++;
			loadingStr = 'Loading: $i';
			var data:BitmapData = BitmapData.fromFile(i);
			var graphic:FlxGraphic = FlxGraphic.fromBitmapData(data);
			graphic.persist = true;
			graphic.destroyOnNoUse = false;
			FileUtil.addGraphicToCache(i, graphic);
		}

		for (i in sound)
		{
			curProgress++;
			loadingStr = 'Loading Sound: $i';
			var sound:FlxSound;
			sound = new FlxSound();
			sound.loadEmbedded(i);
			sound.destroy();
			sound = null;
		}
		doneCaching = true;
	}
}
