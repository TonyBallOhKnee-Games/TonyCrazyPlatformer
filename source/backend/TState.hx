package backend;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.addons.transition.FlxTransitionableState;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

class TState extends FlxState
{
	override public function new()
	{
		super();
		openSubState(new TTransition(false, null));
	}

	function switchState(nextState:FlxState)
	{
		openSubState(new TTransition(true, nextState));
	}
}

class TTransition extends FlxSubState
{
	var _transitionGraphic:FlxSprite;

	override public function new(isTransOut:Bool, nextState:FlxState)
	{
		super(FlxColor.TRANSPARENT);
		_transitionGraphic = new FlxSprite();
		_transitionGraphic.makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		_transitionGraphic.scrollFactor.x = 0;
		_transitionGraphic.scrollFactor.y = 0;
		add(_transitionGraphic);
		if (isTransOut) // I want to make this a one-lines to bad but it formats it to this by default :<
		{
			transOut(nextState);
		}
		else
		{
			transIn();
		}
	}

	function transOut(nextState:FlxState)
	{
		_transitionGraphic.alpha = 0;
		FlxTween.num(0, 1, 0.5, {
			ease: FlxEase.circOut,
			onComplete: function(t:FlxTween)
			{
				FlxG.switchState(nextState);
			}
		}, updateAlpha);
	}

	function transIn()
	{
		_transitionGraphic.alpha = 1;
		FlxTween.num(1, 0, 0.5, {
			ease: FlxEase.circOut,
			onComplete: function(t:FlxTween)
			{
				closeSubState();
			}
		}, updateAlpha);
	}

	function updateAlpha(value:Float)
	{
		_transitionGraphic.alpha = value;
	}
}
