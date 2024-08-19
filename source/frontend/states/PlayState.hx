package frontend.states;

import backend.GameHud;
import backend.Player;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup;
import flixel.util.FlxCollision;
import frontend.states.substates.PauseSubState;

class PlayState extends FlxTransitionableState
{
	var levelBounds:FlxGroup;
	var tonyPlayer:Player;

	var hud:GameHud;

	public var jimBanana:FlxSprite = new FlxSprite(404.65, 141.95);

	override public function create():Void
	{
		super.create();
		FlxTransitionableState.skipNextTransOut = true;
		FlxG.sound.music.stop();
		if (!FlxG.sound.music.playing)
		{
			FlxG.sound.playMusic("assets/music/mainMus.wav", 0.5, true);
		}

		bgColor = 0xffcccccc;

		jimBanana.loadGraphic('assets/images/characters/Jim.png', true);
		jimBanana.frames = FlxAtlasFrames.fromSparrow('assets/images/characters/Jim.png', 'assets/images/characters/Jim.xml');
		jimBanana.animation.addByPrefix('idleanim', 'Jim Idle', 24, true);
		jimBanana.antialiasing = true;
		jimBanana.animation.play("idleanim");
		add(jimBanana);

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

		if (!FlxG.sound.music.playing)
		{
			FlxG.sound.music.resume();
		}
	}
}
