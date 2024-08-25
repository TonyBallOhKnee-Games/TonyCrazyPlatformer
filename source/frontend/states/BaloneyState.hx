package frontend.states;

import backend.utils.FileUtil;
import backend.utils.GameAssets;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class BaloneyState extends FlxTransitionableState
{
	public var dead:FlxSprite = new FlxSprite(0, -120.2);
	public var swichingShit:Bool = false;

	override public function create():Void
	{
		super.create();

		FlxG.autoPause = false;

		bgColor = 0xffcccccc;

		dead.frames = FlxAtlasFrames.fromSparrow(GameAssets.getAsset('Misc Assets', 'TonyBall Studios'), 'assets/images/ui/misc/TonyBall.xml');
		dead.animation.addByPrefix('Dead', 'EpicSause', 24, false);
		dead.antialiasing = true;
		dead.animation.play("Dead");
		add(dead);

		FlxG.sound.playMusic("assets/music/baloneyIntro.wav", 0.5, false);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (dead.animation.finished && !swichingShit)
		{
			swichingShit = true;
			FlxG.switchState(new WarningState());
		};

		if (FlxG.keys.anyPressed([ENTER, SPACE]))
		{
			swichingShit = true;
			FlxG.switchState(new WarningState());
		};
	}
}
