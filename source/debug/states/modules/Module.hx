package debug.states.modules;

import flixel.FlxBasic;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.text.FlxText;

class Module
{
	public var parent:FlxSprite;
	public var targetCam:FlxCamera;
	public var hudAssets:Map<String, FlxSprite>;
	public var hudTexts:Map<String, FlxText>;
	public var loaded:Bool = true;

	public function new(parent:FlxSprite, targetCam:FlxCamera)
	{
		this.parent = parent;
		this.targetCam = targetCam;
	}

	public function unloadModule()
	{
		hudAssets.clear();
		hudTexts.clear();
		hudAssets = null;
		hudTexts = null;
		loaded = false;
	}

	public function updateModule()
	{
		if (loaded)
		{
			for (obj in hudAssets)
			{
				if (obj != null && obj.exists && obj.visible) // functioning as a flixel group
				{
					obj.draw();
				}
			}
			for (text in hudTexts)
			{
				if (text != null && text.exists && text.visible)
				{
					text.draw();
				}
			}
		}
		else
			return;
	}

	public function loadModule()
	{
		loaded = true;
		hudAssets = new Map<String, FlxSprite>();
		hudTexts = new Map<String, FlxText>();
	}
}
