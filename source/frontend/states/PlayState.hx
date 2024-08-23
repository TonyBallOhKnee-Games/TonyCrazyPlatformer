package frontend.states;

import backend.GameHud;
import backend.ingame.objects.NPC;
import backend.ingame.objects.PhysicsObject;
import backend.ingame.objects.Player;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup;
import flixel.util.FlxCollision;
import flixel.util.FlxColor;
import frontend.states.substates.DeadSubState;
import frontend.states.substates.PauseSubState;

class PlayState extends FlxTransitionableState
{
	var levelBounds:FlxGroup;

	public var hud:GameHud;

	public var collisionObjects:FlxTypedGroup<PhysicsObject> = new FlxTypedGroup<PhysicsObject>();
	public var jimBanana:NPC;
	public var tonyPlayer:Player;
	public var floor:PhysicsObject;

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

		floor = new PhysicsObject(0, 550, '', collisionObjects, FLOOR);
		floor.makeGraphic(1280, 300, FlxColor.BLACK);
		collisionObjects.add(floor);
		add(floor);

		jimBanana = new NPC(404, 0, '', collisionObjects);
		jimBanana.load(); // Jim has his defaults set already, lol
		jimBanana.scale.x = 0.4;
		jimBanana.scale.y = 0.4;
		jimBanana.updateHitbox();
		jimBanana.animation.play('idleanim');
		add(jimBanana);

		tonyPlayer = new Player(0, 0, 'Tony', collisionObjects);
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
			openSubState(new DeadSubState());
		}

		FlxG.collide(tonyPlayer, levelBounds);

		if (!FlxG.sound.music.playing)
		{
			FlxG.sound.music.resume();
		}
	}
}
