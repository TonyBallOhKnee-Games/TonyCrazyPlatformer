package frontend;

import backend.ingame.objects.PhysicsObject;
import backend.utils.AssetUtil.CharacterAssets;
import backend.utils.Common.ColliderType;
import backend.utils.Common.PlayerAssets;
import backend.utils.Common;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.sound.FlxSound;
import flixel.system.FlxAssets.FlxGraphicAsset;

using StringTools;

class Player extends PhysicsObject
{
	public var speed:Float = 4.5;
	public var assets:PlayerAssets;
	public var sounds:Map<String, FlxSound>;
	public var soundActionList:Array<String> = ['jump'];
	public var physDragMult:Float = 4;

	var _left = false;
	var _right = false;
	var _down = false;
	var _jump = false;
	var _finalSpeed:Float = 0;

	public function new(xPos:Int = 0, yPos:Int = 0, name:FlxGraphicAsset, colliders:FlxTypedGroup<PhysicsObject>)
	{
		super(xPos, yPos, name, colliders, CONTROLLER);
		assets = CharacterAssets.getPlayerAssets(name);
		frames = FlxAtlasFrames.fromSparrow(assets.charImg, assets.charXml);
		if (assets.animBindings != null)
		{
			for (animBinding in assets.animBindings)
			{
				animation.addByPrefix(animBinding[0], animBinding[1], Std.parseFloat(animBinding[2]), Common.parseBool(animBinding[3]));
			}
		}
		else
		{
			animation.addByPrefix('Idle', 'Idle', 24, true);
			animation.addByPrefix('Walk', 'Run', 24, false);
			animation.addByPrefix('JumpInt', 'JumpInt', 24, false);
			animation.addByPrefix('Jump', 'Jump0', 24, false);
			animation.addByPrefix('Crouch', 'Crouch', 24, false);
			animation.addByPrefix('Attack', 'Attack', 24, false);
		}
		scale.set(0.35, 0.35);

		if (assets.properties != null)
		{
			for (property in assets.properties)
			{
				if (property[0].toLowerCase() == 'scalex')
					scale.x = Std.parseFloat(property[1].trim());
				if (property[0].toLowerCase() == 'scaley')
					scale.y = Std.parseFloat(property[1].trim());
				if (property[0].toLowerCase() == 'physdragmult')
					physDragMult = Std.parseFloat(property[1].trim());
				if (property[0].toLowerCase() == 'speed')
					speed = Std.parseFloat(property[1].trim());
			}
		}
		_finalSpeed = speed * 100;
		updateHitbox();
		physDrag.x = _finalSpeed * physDragMult;
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
		_finalSpeed = speed * 100;
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
			physVelocity.x = -_finalSpeed;
			facing = LEFT;
		}
		else if (_right)
		{
			physVelocity.x = _finalSpeed;
			facing = RIGHT;
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
