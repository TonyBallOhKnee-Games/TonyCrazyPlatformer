package frontend.states;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.graphics.frames.FlxAtlasFrames;

class BaloneyState extends FlxState
{
	
	public var dead:FlxSprite = new FlxSprite(0, -120.2);
	public var swichingShit:Bool = false;
	
	override public function create():Void
	{
		super.create();
		
		bgColor = 0xffcccccc;

		dead.loadGraphic('assets/images/TonyBall.png', true);
		dead.frames = FlxAtlasFrames.fromSparrow('assets/images/TonyBall.png', 'assets/images/TonyBall.xml');
		dead.animation.addByPrefix('Dead', 'EpicSause', 24, false);
		dead.antialiasing = true;
		dead.animation.play("Dead");
		add(dead);

		
		FlxG.sound.playMusic("assets/music/baloneyIntro.wav", 0.5, false);
		
	
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		
		if (dead.animation.finished && !swichingShit) {

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
