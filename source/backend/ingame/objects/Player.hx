package backend.ingame.objects;

import backend.Common.ColliderType;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.system.FlxAssets.FlxGraphicAsset;

class Player extends PhysicsObject
{
	public var speed:Int = 450;

	var _left = false;
	var _right = false;
	var _down = false;
	var _jump = false;

	public function new(xPos:Int = 0, yPos:Int = 0, name:FlxGraphicAsset, colliders:FlxTypedGroup<PhysicsObject>)
	{
		super(xPos, yPos, name, colliders, CONTROLLER);

		loadGraphic('assets/images/characters/$name.png');
		frames = FlxAtlasFrames.fromSparrow('assets/images/characters/$name.png', 'assets/images/characters/$name.xml');
		animation.addByPrefix('Idle', 'Idle', 24, true);
		animation.addByPrefix('Walk', 'Run', 24, false);
		animation.addByPrefix('JumpInt', 'JumpInt', 24, false);
		animation.addByPrefix('Jump', 'Jump0', 24, false);
		animation.addByPrefix('Crouch', 'Crouch', 24, false);
		animation.addByPrefix('Attack', 'Attack', 24, false);

		scale.set(0.35, 0.35);
		updateHitbox();
		drag.x = speed * 4;

		setFacingFlip(LEFT, false, false);
		setFacingFlip(RIGHT, true, false);
	}

	override public function physTick()
	{
		super.physTick();
		_left = FlxG.keys.anyPressed([LEFT, A]);
		_right = FlxG.keys.anyPressed([RIGHT, D]);
		_down = FlxG.keys.anyPressed([DOWN, S]);
		_jump = FlxG.keys.anyPressed([UP, SPACE, W]);
		if (_jump && onFloor)
			velocity.y = -_finalGravity / 1.5;
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
			velocity.x = 0;
			animation.play("Idle");
		}
		else if (_left)
		{
			velocity.x = -speed;
			facing = LEFT;
		}
		else if (_right)
		{
			velocity.x = speed;
			facing = RIGHT;
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
