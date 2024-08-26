package frontend.states;

import backend.GameHud;
import backend.ingame.objects.PhysicsObject;
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
import frontend.NPC;
import frontend.Player;
import frontend.states.substates.DeadSubState;
import frontend.states.substates.PauseSubState;

class PlayState extends FlxTransitionableState
{
	public static var hud:GameHud;
	public static var hudCam:FlxCamera;
	public static var worldSize = 20;
	public static var collisionObjects:FlxTypedGroup<PhysicsObject> = new FlxTypedGroup<PhysicsObject>();
	public static var jimBanana:NPC;
	public static var tonyPlayer:Player;
	public static var floor:PhysicsObject;

	var _finalWorldSize = 0;

	override public function create():Void
	{
		super.create();
		FlxTransitionableState.skipNextTransOut = true;
		// Level Initialization
		_finalWorldSize = worldSize * 1000;
		FlxG.sound.music.stop(); // Stopping current music
		FlxG.sound.playMusic("assets/music/mainMus.wav", 0.5, true); // TEMPORARY bg music
		FlxG.worldBounds.set(0, 0, _finalWorldSize, _finalWorldSize); // Setting world size
		bgColor = 0xff6ceeff; // Sky color

		floor = new PhysicsObject(0, 550, '', collisionObjects, FLOOR);
		floor.makeGraphic(1280, 300, FlxColor.BLACK);
		collisionObjects.add(floor);
		add(floor);

		jimBanana = new NPC(404, 0, '', collisionObjects);
		jimBanana.scale.x = 0.4;
		jimBanana.scale.y = 0.4;
		jimBanana.load(); // Jim has his defaults set already, lol
		jimBanana.updateHitbox();
		jimBanana.animation.play('idleanim');
		// add(jimBanana);

		tonyPlayer = new Player(0, 0, 'tony', collisionObjects);
		tonyPlayer.antialiasing = true;
		add(tonyPlayer);

		hudCam = new FlxCamera(0, 0, 1280, 720, 0);
		hudCam.bgColor = FlxColor.TRANSPARENT;
		FlxG.cameras.add(hudCam, false);
		hud = new GameHud();
		hud.camera = hudCam;
		add(hud);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		FlxG.camera.follow(tonyPlayer, FlxCameraFollowStyle.PLATFORMER, 15 * elapsed);
		if (FlxG.keys.justPressed.ESCAPE)
		{
			openSubState(new PauseSubState());
		}
		if (FlxG.keys.justPressed.R)
		{
			openSubState(new DeadSubState(tonyPlayer));
		}

		if (!FlxG.sound.music.playing)
		{
			FlxG.sound.music.resume();
		}
	}
}
