package backend.ingame.objects;

import backend.Common.AnimData;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.system.FlxAssets.FlxGraphicAsset;

class PhysicsObject extends FlxSprite
{
	public var gravity:Int = 6;
	public var hasPhysics:Bool = true;

	var _finalGravity = 0;

	public function new(?X:Float = 0, ?Y:Float = 0, ?SimpleGraphic:FlxGraphicAsset)
	{
		super(X, Y, SimpleGraphic);
		// Initializing Physics
		_finalGravity = gravity * 100; // make the gravity variable more user-friendly
		acceleration.y = _finalGravity;
	}

	public function physTick()
	{
		if (isTouching(FLOOR))
		{
			velocity.y = -_finalGravity / 1.5;
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
