package backend.ingame.objects;

import backend.utils.Common.ColliderType;
import backend.utils.Common;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxPoint;
import flixel.system.FlxAssets.FlxGraphicAsset;

class PhysicsObject extends FlxSprite
{
	public var gravity:Int = 6;
	public var hasPhysics:Bool = true;
	public var type:ColliderType;

	public var colliders:FlxTypedGroup<PhysicsObject> = new FlxTypedGroup<PhysicsObject>();
	public var colliderType:ColliderType = NONE;

	public var physVelocity:FlxPoint;
	public var physAcceleration:FlxPoint;
	public var physMaxVelocity:FlxPoint;
	public var physDrag:FlxPoint;
	public var onFloor:Bool = false;
	public var isColliding:Bool = false;

	var _finalGravity = 0;

	public function new(?X:Float = 0, ?Y:Float = 0, ?SimpleGraphic:FlxGraphicAsset, colliders:FlxTypedGroup<PhysicsObject>, type:ColliderType)
	{
		super(X, Y, SimpleGraphic);
		this.colliders = colliders;
		this.type = type;

		// Initializing Physics
		_finalGravity = gravity * 100; // make the gravity/world size variable more user-friendly
		physVelocity = new FlxPoint(0, 0);
		physAcceleration = new FlxPoint(0, 0);
		physMaxVelocity = new FlxPoint(500, 500); // Optional max physVelocity cap
		physDrag = new FlxPoint(0, 0); // Drag force values for x and y axes
		if (type == CONTROLLER || type == NPC)
		{
			physAcceleration.y = _finalGravity;
		}
		else
		{
			immovable = true;
		}
	}

	public function physTick(elapsed:Float)
	{
		// update velocity based on physAcceleration
		physVelocity.x += physAcceleration.x * elapsed;
		physVelocity.y += physAcceleration.y * elapsed;

		// horizontal drag
		if (physVelocity.x != 0)
		{
			var dragX = physDrag.x * elapsed;
			if (Math.abs(physVelocity.x) < dragX)
				physVelocity.x = 0; // stop completely when drag overcomes velocity
			else
				physVelocity.x -= dragX * Common.sign(physVelocity.x); // apply drag in the opposite direction of movement
		}

		// vertical drag
		if (physVelocity.y != 0)
		{
			var dragY = physDrag.y * elapsed;
			if (Math.abs(physVelocity.y) < dragY)
				physVelocity.y = 0;
			else
				physVelocity.y -= dragY * Common.sign(physVelocity.y);
		}

		// clamp velocity to maxVelocity
		physVelocity.x = Math.min(physVelocity.x, physMaxVelocity.x);
		physVelocity.y = Math.min(physVelocity.y, physMaxVelocity.y);

		// update position based on velocity
		x += physVelocity.x * elapsed;
		y += physVelocity.y * elapsed;

		// collision logic
		if (type != FLOOR && type != NONE)
		{
			colliders.forEachAlive(function(obj:PhysicsObject)
			{
				// Collision detection
				isColliding = FlxG.collide(this, obj);
				// Post Collision handling
				colliderType = obj.type;
				if (isColliding && colliderType == FLOOR)
				{
					onFloor = true;
				}
				else
				{
					onFloor = false;
				}
			});
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		if (hasPhysics)
			physTick(elapsed);
	}
}
