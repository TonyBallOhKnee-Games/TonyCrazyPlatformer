package backend.utils;

import flixel.tweens.FlxTween;

class TweenHelper
{
	public static function cancelAllTweens()
	{
		FlxTween.globalManager.forEach(function(tween:FlxTween)
		{
			tween.cancel();
		});
	}

	public static function allTweensFinished()
	{
		var tweensFinished:Array<Bool> = [];
		FlxTween.globalManager.forEach(function(tween:FlxTween)
		{
			tweensFinished.push(tween.finished);
		});
		for (finished in tweensFinished)
		{
			if (!finished)
				return false;
		}
		return true;
	}
}
