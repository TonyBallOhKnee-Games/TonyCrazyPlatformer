package backend.utils;

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
	public static var uiImagePaths:Array<String> = [];
	// Gameplay images will be loaded dynamically.
	// public static var hudImagePaths:Array<String> = []; --Later.
	public static var uiImages:Array<String> = [];
	public static var images:Array<String> = [];
	// Sounds/Music
	public static var sound:Array<String> = [];

	public static var fullSize:Int = 0;
	public static var doneCaching = false;
	public static var curProgress:Int = 0;

	public static function cacheBaseAssets(?fromInitializer:Bool = false)
	{
		if (uiImagePaths.length <= 0)
		{
			uiImagePaths.push('misc');
			uiImagePaths.push('menus/levelSelection');
			uiImagePaths.push('menus/main');
			uiImagePaths.push('menus/options');
			uiImagePaths.push('menus/pause');
			uiImagePaths.push('menus/save');
			uiImagePaths.push('menus/warning');
			uiImagePaths.push('menus/levelSelection');
			// Not huds, I'll do that later.
		}
		for (path in uiImagePaths)
		{
			// trace('$path: ${FileSystem.exists('assets/images/ui/$path')}'); --I made a typo...
			for (file in FileSystem.readDirectory(FileSystem.absolutePath('assets/images/ui/$path')))
			{
				if (!file.endsWith(".png"))
					continue;
				uiImages.push('$path/$file');
				fullSize++;
			}
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
			cache(fromInitializer);
		});
	}

	public static function cache(fromInitializer:Bool = false)
	{
		for (i in uiImages)
		{
			curProgress++;
			loadingStr = 'Loading: $i';
			var data:BitmapData = BitmapData.fromFile('assets/images/ui/$i');
			var graphic:FlxGraphic = FlxGraphic.fromBitmapData(data);
			graphic.persist = true;
			graphic.destroyOnNoUse = false;
			FileUtil.addGraphicToCache(i, graphic);
			trace(i);
		}

		for (i in sound)
		{
			curProgress++;
			loadingStr = 'Loading Sound: $i';
			var sound:FlxSound;
			sound = new FlxSound();
			sound.loadEmbedded(i);
			sound.volume = 0;
			sound.play();
			new FlxTimer().start(0.1, function(tmr:FlxTimer)
			{
				sound.stop();
				sound.destroy();
				sound = null;
			});
		}
		doneCaching = true;
		if (fromInitializer)
			Initializer.postCache();
	}
}
