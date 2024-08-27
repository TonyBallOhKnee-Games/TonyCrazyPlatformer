package backend;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class GameHud extends FlxTypedGroup<FlxObject>
{
	var hudSkinName:String;

	public function new(?hudSkin:String = 'default')
	{
		super();
		hudSkinName = hudSkin;
	}
}
