package backend;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;

class Player extends FlxSprite
{
	final SPEED:Int = 450; //450 is default
	final GRAVITY:Int = 600; //600 is deafault

	public function new(xPos:Int = 0, yPos:Int = 0, name:String)
	{
		super(xPos, yPos);

		loadGraphic('assets/images/characters/$name.png', true);
		frames = FlxAtlasFrames.fromSparrow('assets/images/characters/$name.png', 'assets/images/characters/$name.xml');
		animation.addByPrefix('Idle', 'Idle', 24, true);
		animation.addByPrefix('Walk', 'Run', 24, false);
		animation.addByPrefix('JumpInt', 'JumpInt', 24, false);
		animation.addByPrefix('Jump', 'Jump0', 24, false);
		animation.addByPrefix('Crouch', 'Crouch', 24, false);
		animation.addByPrefix('Attack', 'Attack', 24, false);

		scale.set(0.35, 0.35);
		updateHitbox();
		drag.x = SPEED * 4;

		setFacingFlip(LEFT, false, false);
		setFacingFlip(RIGHT, true, false);

		acceleration.y = GRAVITY;
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


	function movement()
	{
		final left = FlxG.keys.anyPressed([LEFT, A]);
		final right = FlxG.keys.anyPressed([RIGHT, D]);
		final down = FlxG.keys.anyPressed([DOWN, S]);
		final attack = FlxG.keys.anyPressed([SHIFT, ALT]);
		final jump = FlxG.keys.anyPressed([UP, SPACE, W]);
		
		
		if (left || right)
		{
			animation.play("Walk");
		}
		else
		{
			if (down)
			{
				if (animation.finished && animation.name == 'Crouch') {} // Why did this logic take 5 whole minutes
				else
					animation.play("Crouch");
			}
			else
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

	
	
	override function update(elapsed:Float)
	{
		jumping();
		super.update(elapsed);
		movement();
	}
}
