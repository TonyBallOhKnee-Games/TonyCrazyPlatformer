package backend.ingame.objects;

import backend.Common.AnimData;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.system.FlxAssets.FlxGraphicAsset;

class PhysicsObject extends FlxSprite
{
	var gravity:Int = 600;
	var hasPhysics:Bool = true;

	public function new(?X:Float = 0, ?Y:Float = 0, ?SimpleGraphic:FlxGraphicAsset)
	{
		super(X, Y, SimpleGraphic);
		acceleration.y = gravity;
	}

	function physTick()
	{
		if (isTouching(FLOOR))
		{
			velocity.y = -gravity / 1.5;
		}
		// FlxObject.separate(this, UNFINISHED); -- Unfinished feature. I'll do it another day.
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		if (hasPhysics)
		{
			physTick();
		}
	}
}
