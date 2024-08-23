package backend.ingame.objects;

import backend.Common.ColliderType;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.system.FlxAssets.FlxGraphicAsset;

class PhysicsObject extends FlxSprite
{
	public var gravity:Int = 6;
	public var hasPhysics:Bool = true;
	public var colliders:FlxTypedGroup<PhysicsObject> = new FlxTypedGroup<PhysicsObject>();
	public var isColliding:Bool = false;
	public var type:ColliderType;
	public var colliderType:ColliderType = NONE;
	public var onFloor:Bool = false;

	var _finalGravity = 0;

	public function new(?X:Float = 0, ?Y:Float = 0, ?SimpleGraphic:FlxGraphicAsset, colliders:FlxTypedGroup<PhysicsObject>, type:ColliderType)
	{
		super(X, Y, SimpleGraphic);
		this.colliders = colliders;
		this.type = type;

		// Initializing Physics
		_finalGravity = gravity * 100; // make the gravity variable more user-friendly
		if (type == CONTROLLER || type == NPC)
		{
			applyGravity();
		}
	}

	public function removeGravity()
	{
		acceleration.y = 0;
	}

	public function invertGravity()
	{
		acceleration.y -= _finalGravity * 2; // Why did i invert it like this
	}

	public function applyGravity()
	{
		acceleration.y = _finalGravity;
	}

	public function physTick()
	{
		if (type != FLOOR && type != NONE)
		{
			isColliding = false;
			onFloor = false;
			colliders.forEachAlive(function(obj:PhysicsObject)
			{
				isColliding = FlxG.collide(this, obj);
				colliderType = obj.colliderType;
				if (isColliding && colliderType == FLOOR)
					onFloor = true;
			});
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		if (hasPhysics)
			physTick();
	}
}
