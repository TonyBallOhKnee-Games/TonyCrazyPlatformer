package frontend.states;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.TransitionData;
import flixel.addons.ui.FlxUIState;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.FlxPoint;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import openfl.Lib;
import openfl.net.URLRequest;

class LevelState extends FlxTransitionableState
{
	public static var curSelected:Int = 0; // Selected menu option (0: Start, 1: Load, 2: Options)

	private var selectorguy:FlxSprite;

	public var logoShit:FlxSprite = new FlxSprite(-612.65, -59.2);
	public var tonyDovark:FlxSprite = new FlxSprite(986.9, 347.45);

	var tween:FlxTween;
	var canChangeSelection:Bool = false;

	override public function create():Void
	{
		super.create();



		curSelected = 0; // Set curSelected to 0 at the start of the state

		

		// Add background image
		var sky:FlxSprite = new FlxSprite(0, 0);
		sky.loadGraphic("assets/images/title/sky.png");
		sky.antialiasing = true;
		add(sky);

		logoShit.loadGraphic('assets/images/levelSelector/numbers.png', true);
		logoShit.frames = FlxAtlasFrames.fromSparrow('assets/images/levelSelector/number.png', 'assets/images/levelSelector/number.xml');
		logoShit.animation.addByPrefix('logoShit', 'coolness', 24, false);
		logoShit.antialiasing = true;
		logoShit.animation.play("logoShit");
		add(logoShit);

		var start:FlxSprite = new FlxSprite(1430.6, 465.35);
		start.loadGraphic("assets/images/title/new game.png");
		start.antialiasing = true;
		FlxTween.tween(start, {x: 374.95, y: 465.35}, 2, {
			ease: FlxEase.circInOut,
			startDelay: 0.83333333333333333333333333333333
		});
		add(start);

		selectorguy = new FlxSprite(1290.65, 465.35);
		selectorguy.loadGraphic("assets/images/title/unused/selectorthingy.png");
		selectorguy.antialiasing = true;
		FlxTween.tween(selectorguy, {x: 577.65, y: 465.35}, 2, {
			ease: FlxEase.quartOut,
			startDelay: 2,
			onComplete: function(t:FlxTween)
			{
				canChangeSelection = true;
			}
		});
		add(selectorguy);

		// Add version text
		var gameVer:FlxText = new FlxText(-700, 12, 0, "Tony's Crazy Adventures Game V1 \nCreated by TonyBallOhKnee", 40);
		gameVer.scrollFactor.set();
		gameVer.setFormat("assets/fonts/baloney.ttf", 40, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		gameVer.antialiasing = true;
		FlxTween.tween(gameVer, {x: 12, y: 12}, 2, {
			ease: FlxEase.circInOut,
			startDelay: 1.3
		});
		add(gameVer);
	}

	private function startGame():Void
	{
		FlxG.switchState(new PlayState());
	}

	private function goToOptions():Void
	{
		FlxG.switchState(new OptionsState());
	}

	private function goToCredits():Void
	{
		FlxG.switchState(new CreditsState());
	}

	private function openYouTube():Void
	{
		Lib.getURL(new URLRequest("https://www.youtube.com/@TonyBallOhKnee"), "_blank");
	}

	private function changeItem(direction:Int):Void
	{
		curSelected += direction;
		if (curSelected < 0)
			curSelected = 3;
		if (curSelected > 3)
			curSelected = 0;

		switch (curSelected)
		{
			case 0:
				// selectorguy.x = 577.65;
				// selectorguy.y = 465.35;

				tween = FlxTween.tween(selectorguy, {x: 577.65, y: 465.35}, 0.1, {
					ease: FlxEase.circOut,
				});
			case 1:
				// selectorguy.x = 715.85;
				// selectorguy.y = 529.15;

				tween = FlxTween.tween(selectorguy, {x: 715.85, y: 529.15}, 0.1, {
					ease: FlxEase.circOut,
				});
			case 2:
				// selectorguy.x = 790.1;
				// selectorguy.y = 581.15;

				tween = FlxTween.tween(selectorguy, {x: 790.1, y: 581.15}, 0.1, {
					ease: FlxEase.circOut,
				});
			case 3:
				// selectorguy.x = 851.3;
				// selectorguy.y = 639.05;

				tween = FlxTween.tween(selectorguy, {x: 851.3, y: 639.05}, 0.1, {
					ease: FlxEase.circOut,
				});
		}
	}

	override function update(elapsed:Float):Void
	{
		if (canChangeSelection)
		{
			if (FlxG.keys.justPressed.UP || FlxG.keys.justPressed.W)
			{
				changeItem(-1);
			}
			if (FlxG.keys.justPressed.DOWN || FlxG.keys.justPressed.S)
			{
				changeItem(1);
			}
		}
		if (FlxG.keys.justPressed.ENTER)
		{
			switch (curSelected)
			{
				case 0:
					startGame();
				case 1:

				case 2:
					goToOptions();
				case 3:
					goToCredits();
			}
		}

		super.update(elapsed);
	}
}
