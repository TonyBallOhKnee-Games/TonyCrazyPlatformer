package frontend.states.substates;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class DeadSubState extends FlxSubState
{
	public var dead:FlxSprite = new FlxSprite(0, 0);
	public var funnySong:Bool = false;
	public var player:Player;

	override public function new(player:Player)
	{
		super(FlxColor.TRANSPARENT);
		this.player = player;
	}

	override public function create():Void
	{
		super.create();

		FlxG.sound.music.stop();
		dead.frames = FlxAtlasFrames.fromSparrow(player.assets.deathImg, player.assets.deathXml);
		dead.animation.addByPrefix('Dead', 'Dying instance 1', 24, false);
		dead.antialiasing = true;
		dead.animation.play("Dead");
		dead.camera = PlayState.hudCam;
		add(dead);

		FlxG.sound.play("assets/sounds/deadTony.wav", 0.5, false);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (dead.animation.finished && !funnySong)
		{
			funnySong = true;
			FlxG.sound.playMusic("assets/music/gameOverLoop.wav", 0.3, true);
		};

		if (FlxG.keys.anyPressed([ENTER, SPACE]))
		{
			close();
			FlxG.switchState(new PlayState());
		};
		if (FlxG.keys.anyPressed([ESCAPE, BACKSPACE]))
		{
			close();
			FlxG.sound.music.stop();
			FlxG.switchState(new MainMenuState());
		};
	}
}
