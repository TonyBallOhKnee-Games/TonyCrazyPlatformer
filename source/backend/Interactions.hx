package backend;

import flixel.FlxG;
import flixel.FlxObject;

class Interactions
{
	public static function objectCollision(object1:FlxObject, object2:FlxObject)
	{
		return object1.x > object2.x
			&& object1.x < object2.x + object2.width
			&& object1.y > object2.y
			&& object1.y < object2.y + object2.height;
	}

	public static function objectCollisionMouse(object:FlxObject)
	{
		return FlxG.mouse.x > object.x
			&& FlxG.mouse.x < object.x + object.width
			&& FlxG.mouse.y > object.y
			&& FlxG.mouse.y < object.y + object.height
			&& object.alive;
	}

	public static function clickedObject(object:FlxObject)
	{
		if (FlxG.mouse.x > object.x
			&& FlxG.mouse.x < object.x + object.width
			&& FlxG.mouse.y > object.y
			&& FlxG.mouse.y < object.y + object.height
			&& object.alive)
			return FlxG.mouse.justPressed;
		else
			return false;
	}

	public static function clickingObject(object:FlxObject)
	{
		if (FlxG.mouse.x > object.x
			&& FlxG.mouse.x < object.x + object.width
			&& FlxG.mouse.y > object.y
			&& FlxG.mouse.y < object.y + object.height
			&& object.alive)
			return FlxG.mouse.pressed;
		else
			return false;
	}
}
