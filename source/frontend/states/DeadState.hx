package frontend.states;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flxanimate.FlxAnimate;

class DeadState extends FlxState
{
	override public function create():Void
	{
		super.create();
	}

	override function update(elapsed:Float)
	{
		if (FlxG.keys.anyPressed([ENTER, SPACE]))
		{
			FlxG.switchState(new MainMenuState());
		};
	}
}
