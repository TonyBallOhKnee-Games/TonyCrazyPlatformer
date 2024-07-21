package frontend.states;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.graphics.frames.FlxAtlasFrames;

class DeadState extends FlxState
{
	override public function create():Void
	{
		super.create();

		var dead:FlxSprite = new FlxSprite(-221.65, -340.7);

		dead.loadGraphic('assets/images/deathScreen/Dead.png', true);
		dead.frames = FlxAtlasFrames.fromSparrow('assets/images/deathScreen/Dead.png', 'assets/images/deathScreen/Dead.xml');
		dead.animation.addByPrefix('Dead', 'Dying', 24, false);
		FlxG.sound.play("assets/sounds/deadTony.wav", 0.5, true);
	}

	override function update(elapsed:Float)
	{
		if (FlxG.keys.anyPressed([ENTER, SPACE]))
		{
			FlxG.switchState(new MainMenuState());
		};
	}
}
