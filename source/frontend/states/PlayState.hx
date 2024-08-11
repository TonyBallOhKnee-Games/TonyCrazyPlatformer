package frontend.states;

import backend.GameHud;
import backend.Player;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.util.FlxCollision;
import frontend.states.substates.PauseSubState;

class PlayState extends FlxState
{
	var levelBounds:FlxGroup;
	var tonyPlayer:Player;
	var hud:GameHud;

	override public function create():Void
	{
		super.create();


		FlxG.sound.music.stop();
		if (!FlxG.sound.music.playing) {

			FlxG.sound.playMusic("assets/music/bigAss.wav", 0.5, true);

		}
		
		bgColor = 0xffcccccc;

		tonyPlayer = new Player(0, 0, 'Tony');
		tonyPlayer.antialiasing = true;
		add(tonyPlayer);

		hud = new GameHud();
		add(hud);

		levelBounds = FlxCollision.createCameraWall(FlxG.camera, false, 1);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		if (FlxG.keys.justPressed.ESCAPE)
		{
			openSubState(new PauseSubState());
		}
		if (FlxG.keys.justPressed.R)
		{
			FlxG.switchState(new DeadState());
		}

		FlxG.collide(tonyPlayer, levelBounds);
	}
}
