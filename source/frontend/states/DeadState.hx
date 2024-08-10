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
	
	public var dead:FlxSprite = new FlxSprite(0, 0);
	public var funnySong:Bool = false;
	
	override public function create():Void
	{
		super.create();
		
		

		dead.loadGraphic('assets/images/deathScreen/Dead.png', true);
		dead.frames = FlxAtlasFrames.fromSparrow('assets/images/deathScreen/Dead.png', 'assets/images/deathScreen/Dead.xml');
		dead.animation.addByPrefix('Dead', 'Dying instance 1', 24, false);
		dead.antialiasing = true;
		FlxG.sound.music.stop();
		dead.animation.play("Dead");
		add(dead);

		
		FlxG.sound.play("assets/sounds/deadTony.wav", 0.5, false);
		
	
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		
		if (dead.animation.finished && !funnySong) {

			funnySong = true;
			FlxG.sound.playMusic("assets/music/gameOverLoop.wav", 0.3, true);

		};

		if (FlxG.keys.anyPressed([ENTER, SPACE]))
		{
			FlxG.switchState(new PlayState());
		};
		if (FlxG.keys.anyPressed([ESCAPE, BACKSPACE]))
			{
				FlxG.switchState(new MainMenuState());
			};
	}
}
