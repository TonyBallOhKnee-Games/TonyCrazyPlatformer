package frontend.states;

import backend.GameHud;
import backend.ingame.objects.PhysicsObject;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.TransitionData;
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
	public var hud:GameHud;
	public var hudCam:FlxCamera;
	public var collisionObjects:FlxTypedGroup<PhysicsObject> = new FlxTypedGroup<PhysicsObject>();
	public var jimBanana:NPC;
	public var player:Player;
	public var floor:PhysicsObject;
	public var allLevelData:Array<Array<Array<String>>> = []; // all data:[level:[stuff], npcs:[stuff]]
	public var level:Array<Array<String>> = [];
	public var npcs:Array<Array<String>> = [];
	public var properties:Array<String> = ['CYAN', '', 'assets/music/mainMus.wav', '0.5']; // [bgColor, hudName, bgMusic, bgMusVolume] also stored in a .adh
	public var spriteMap:Map<String, FlxSprite>;
	public var npcMap:Map<String, NPC>;
	public var levelPath:String = '';
	public var hasADHData:Bool = false;

	override public function new(?levelPath:String = '', ?ADHData:Array<Array<Array<String>>>, ?Properties:Array<String>, ?TransIn:TransitionData, ?TransOut:TransitionData)
	{
		super(TransIn, TransOut);
		if (ADHData != null)
		{
			hasADHData = true;
			allLevelData = ADHData;
			level = allLevelData[0];
			npcs = allLevelData[1];
			this.levelPath = levelPath;
			this.properties = Properties;
		}
	}

	override public function create():Void
	{
		super.create();
		FlxTransitionableState.skipNextTransOut = true;
		// Level Initialization
		FlxG.sound.music.stop(); // Stopping current music
		FlxG.sound.playMusic(properties[2], Std.parseFloat(properties[3]), true); // TEMPORARY bg music
		bgColor = FlxColor.fromString(properties[0]); // Sky color

		if (!hasADHData)
		{
			floor = new PhysicsObject(0, 550, '', collisionObjects, FLOOR);
			floor.makeGraphic(1280, 300, FlxColor.BLACK);
			collisionObjects.add(floor);
			add(floor);

			jimBanana = new NPC(404, 0, '', collisionObjects);
			jimBanana.load('jim', null, true, false); // Jim has his defaults set already, lol
			jimBanana.animation.play('idleanim');
			jimBanana.scale.set(0.4, 0.4);
			jimBanana.updateHitbox();
			add(jimBanana);
		}else{
			for (object in level)
			{
				var obj = new FlxSprite(Std.parseint(object[2]), Std.parseint(object[3]), '$levelPath/${object[1]}');
				obj.scale.set(Std.parsefloat(object[4]), Std.parsefloat(object[5]));
				obj.updateHitbox();
				obj.alpha = Std.parsefloat(object[6]);
				spriteMap.set(object[0], obj);
				add(spriteMap.get(object[0]));
				if (object[8] == 'true') // I don't have a string to Collider type function, I'll do it when I get home.
					//collisionObjects.add(spriteMap.get(object[0]));
;			}
			for (object in npcs)
			{
				var obj = new NPC(object[2], object[3], '', collisionObjects);
				obj.load(object[1], null, object[7]);
				obj.scale.set(Std.parsefloat(object[4]), Std.parsefloat(object[5]));
				obj.updateHitbox();
				obj.alpha = Std.parsefloat(object[6]);
				spriteMap.set(object[0], obj);
				add(spriteMap.get(object[0]));
				if (object[8] == 'true'){
					collisionObjects.add(spriteMap.get(object[0]));
				}else{
					spriteMap.get(object[0]).hasPhysics = false;
				}
			}
		}

		player = new Player(0, 0, 'tony', collisionObjects);
		player.antialiasing = true;
		add(player);

		hudCam = new FlxCamera(0, 0, 1280, 720, 0);
		hudCam.bgColor = FlxColor.TRANSPARENT;
		FlxG.cameras.add(hudCam, false);
		hud = new GameHud(properties[1]);
		hud.camera = hudCam;
		add(hud);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		FlxG.camera.follow(player, FlxCameraFollowStyle.PLATFORMER, 15 * elapsed);
		if (FlxG.keys.justPressed.ESCAPE)
		{
			openSubState(new PauseSubState(this));
		}
		if (FlxG.keys.justPressed.R)
		{
			openSubState(new DeadSubState(this));
		}

		if (!FlxG.sound.music.playing)
		{
			FlxG.sound.music.resume();
		}
	}
}
