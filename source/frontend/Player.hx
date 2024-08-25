package frontend;

import backend.ingame.objects.PhysicsObject;
import backend.utils.Common.ColliderType;
import backend.utils.Common.PlayerAssets;
import backend.utils.GameAssets;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.sound.FlxSound;
import flixel.system.FlxAssets.FlxGraphicAsset;

class Player extends PhysicsObject
{
	public var speed:Int = 450;
	public var assets:PlayerAssets;
	public var sounds:Map<String, FlxSound>;
	public var soundActionList:Array<String> = ['jump'];

	var _left = false;
	var _right = false;
	var _down = false;
	var _jump = false;

	public function new(xPos:Int = 0, yPos:Int = 0, name:FlxGraphicAsset, colliders:FlxTypedGroup<PhysicsObject>)
	{
		super(xPos, yPos, name, colliders, CONTROLLER);
		assets = GameAssets.getPlayerAssets(name);
		frames = FlxAtlasFrames.fromSparrow(assets.charImg, assets.charXml);
		animation.addByPrefix('Idle', 'Idle', 24, true);
		animation.addByPrefix('Walk', 'Run', 24, false);
		animation.addByPrefix('JumpInt', 'JumpInt', 24, false);
		animation.addByPrefix('Jump', 'Jump0', 24, false);
		animation.addByPrefix('Crouch', 'Crouch', 24, false);
		animation.addByPrefix('Attack', 'Attack', 24, false);

		scale.set(0.35, 0.35);
		updateHitbox();
		physDrag.x = speed * 4;

		setFacingFlip(LEFT, false, false);
		setFacingFlip(RIGHT, true, false);

		// Initialize Sounds
		var soundMapper:Map<String, String> = new Map<String, String>();
		sounds = new Map<String, FlxSound>();
		for (soundBinding in assets.soundData)
			soundMapper.set(soundBinding[0], soundBinding[1]);
		for (action in soundActionList)
			sounds.set(action, new FlxSound().loadEmbedded('${assets.charPath}/sounds/${soundMapper.get(action)}'));
	}

	override public function physTick(elapsed:Float)
	{
		super.physTick(elapsed);
		_left = FlxG.keys.anyPressed([LEFT, A]);
		_right = FlxG.keys.anyPressed([RIGHT, D]);
		_down = FlxG.keys.anyPressed([DOWN, S]);
		_jump = FlxG.keys.anyPressed([UP, SPACE, W]);
		if (_jump && onFloor)
		{
			sounds.get('jump').play();
			physVelocity.y = -_finalGravity / 1.5;
		}
		movement();
	}

	function movement()
	{
		if (_left || _right)
		{
			animation.play("Walk");
		}
		else
		{
			if (_down)
			{
				if (animation.finished && animation.name == 'Crouch') {} // Why did this logic take 5 whole minutes
				else
					animation.play("Crouch");
			}
			else
				animation.play("Idle");
		}

		if (_left && _right)
		{
			physVelocity.x = 0;
			animation.play("Idle");
		}
		else if (_left)
		{
			physVelocity.x = -speed;
			facing = LEFT;
		}
		else if (_right)
		{
			physVelocity.x = speed;
			facing = RIGHT;
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
