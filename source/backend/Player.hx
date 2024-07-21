package backend;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;

class Player extends FlxSprite
{
	final SPEED:Int = 450;
	final GRAVITY:Int = 600;

	public function new(xPos:Int = 0, yPos:Int = 0, name:String)
	{
		super(xPos, yPos);

		loadGraphic('assets/images/characters/$name.png', true);
		frames = FlxAtlasFrames.fromSparrow('assets/images/characters/$name.png', 'assets/images/characters/$name.xml');
		animation.addByPrefix('Idle', 'Idle', 24, true);
		animation.addByPrefix('Walk', 'Run', 24, true);
		animation.addByPrefix('JumpInt', 'JumpInt', 24, true);
		animation.addByPrefix('Jump', 'Jump0', 24, true);
		animation.addByPrefix('Crouch', 'Crouch', 24, true);

		scale.set(0.5, 0.5);
		updateHitbox();
		drag.x = SPEED * 4;

		setFacingFlip(LEFT, false, false);
		setFacingFlip(RIGHT, true, false);

		acceleration.y = GRAVITY;
	}

	function movement()
	{
		final left = FlxG.keys.anyPressed([LEFT, A]);
		final right = FlxG.keys.anyPressed([RIGHT, D]);
		final down = FlxG.keys.anyPressed([DOWN, S]);

		if (left || right)
		{
			animation.play("Walk");
		}
		else
		{
			animation.play("Idle");
		}

		if (left && right)
		{
			velocity.x = 0;
			animation.play("Idle");
		}
		else if (left)
		{
			velocity.x = -SPEED;
			facing = LEFT;
		}
		else if (right)
		{
			velocity.x = SPEED;
			facing = RIGHT;
		}
	}

	function jumping()
	{
		final jump = FlxG.keys.anyPressed([UP, SPACE, W]);
		if (jump && isTouching(FLOOR))
		{
			velocity.y = -GRAVITY / 1.5;

			animation.play("JumpInt");
		}
	}

	override function update(elapsed:Float)
	{
		jumping();
		super.update(elapsed);
		movement();
	}
}
