package backend.utils;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxRect;

class Interactions
{
	public static function objectCollision(object1:FlxObject, object2:FlxObject)
	{
		return object2.x >= object1.x + object1.width
			|| object2.x + object2.width <= object1.x
			|| object2.y >= object1.y + object1.height
			|| object2.y + object2.height <= object1.y;
	}

	public static function objectCollisionMouse(object:FlxObject)
	{
		return FlxG.mouse.x > object.x
			&& FlxG.mouse.x < object.x + object.width
			&& FlxG.mouse.y > object.y
			&& FlxG.mouse.y < object.y + object.height
			&& object.alive;
	}

	private static function getScreenBounds(object:FlxSprite, camera:FlxCamera)
	{
		var screenBounds:FlxRect = new FlxRect();
		screenBounds = object.getScreenBounds(screenBounds, camera);
		return screenBounds;
	}

	public static function spriteCollisionMouse(object:FlxSprite, ?camera:FlxCamera)
	{
		if (camera == null)
			camera = FlxG.camera;

		var bounds:FlxRect = getScreenBounds(object, camera);
		return FlxG.mouse.getScreenPosition(camera).x > bounds.x
			&& FlxG.mouse.getScreenPosition(camera).x < bounds.x + bounds.width
			&& FlxG.mouse.getScreenPosition(camera).y > bounds.y
			&& FlxG.mouse.getScreenPosition(camera).y < bounds.y + bounds.height
			&& object.alive;
	}

	public static function clickedSprite(object:FlxSprite, ?camera:FlxCamera)
	{
		if (spriteCollisionMouse(object, camera))
			return FlxG.mouse.justPressed;
		else
			return false;
	}

	public static function clickingSprite(object:FlxSprite, ?camera:FlxCamera)
	{
		if (spriteCollisionMouse(object, camera))
			return FlxG.mouse.pressed;
		else
			return false;
	}

	public static function clickedObject(object:FlxObject)
	{
		if (objectCollisionMouse(object))
			return FlxG.mouse.justPressed;
		else
			return false;
	}

	public static function clickingObject(object:FlxObject)
	{
		if (objectCollisionMouse(object))
			return FlxG.mouse.pressed;
		else
			return false;
	}
}
