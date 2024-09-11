package frontend.states;

import backend.utils.AssetUtil.UIAssets;
import backend.utils.CachingUtil;
import debug.states.LevelEditor;
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

class MainMenuState extends FlxTransitionableState
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

		FlxTransitionableState.defaultTransIn = new TransitionData();
		FlxTransitionableState.defaultTransOut = new TransitionData();
		FlxTransitionableState.defaultTransIn.color = FlxColor.BLACK;
		FlxTransitionableState.defaultTransOut.color = FlxColor.BLACK;
		FlxTransitionableState.defaultTransIn.type = TransitionType.FADE;
		FlxTransitionableState.defaultTransOut.type = TransitionType.FADE;
		FlxTransitionableState.defaultTransIn.direction = new FlxPoint(-1, -1); // A swipe effect
		FlxTransitionableState.defaultTransOut.direction = new FlxPoint(1, 1);
		FlxTransitionableState.defaultTransIn.duration = 0.6;
		FlxTransitionableState.defaultTransOut.duration = 0.6;
		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		curSelected = 0; // Set curSelected to 0 at the start of the state
		if (!FlxG.sound.music.playing)
		{
			FlxG.sound.playMusic("assets/music/MainNew.wav", 0.5, true);
		}

		// Add background image
		var sky:FlxSprite = new FlxSprite(0, 0);
		sky.loadGraphic(UIAssets.getAsset('Main Menu', 'Sky'));
		sky.antialiasing = true;
		add(sky);

		logoShit.frames = FlxAtlasFrames.fromSparrow(UIAssets.getAsset('Main Menu', 'Logo'), 'assets/images/ui/menus/main/logo.xml');
		logoShit.animation.addByPrefix('logoShit', 'coolness', 24, false);
		logoShit.antialiasing = true;
		logoShit.animation.play("logoShit");
		add(logoShit);

		tonyDovark.frames = FlxAtlasFrames.fromSparrow(UIAssets.getAsset('Main Menu', 'TonyMenu'), 'assets/images/ui/menus/main/TonyMenu.xml');
		tonyDovark.animation.addByPrefix('tonyDovark', 'TonyBop', 24, false);
		tonyDovark.antialiasing = true;
		tonyDovark.animation.play("tonyDovark");
		add(tonyDovark);

		var start:FlxSprite = new FlxSprite(1430.6, 465.35);
		start.loadGraphic(UIAssets.getAsset('Main Menu', 'New Game'));
		start.antialiasing = true;
		FlxTween.tween(start, {x: 374.95, y: 465.35}, 2, {
			ease: FlxEase.circInOut,
			startDelay: 0.83333333333333333333333333333333
		});
		add(start);

		var load:FlxSprite = new FlxSprite(1424.4, 523.25);
		load.loadGraphic(UIAssets.getAsset('Main Menu', 'Load Game'));
		load.antialiasing = true;
		FlxTween.tween(load, {x: 493.75, y: 523.25}, 2, {
			ease: FlxEase.circInOut,
			startDelay: 0.83333333333333333333333333333333
		});
		add(load);

		var options:FlxSprite = new FlxSprite(1456.3, 581.15);
		options.loadGraphic(UIAssets.getAsset('Main Menu', 'Options'));
		options.antialiasing = true;
		FlxTween.tween(options, {x: 637, y: 581.15}, 2, {
			ease: FlxEase.circInOut,
			startDelay: 0.83333333333333333333333333333333
		});
		add(options);

		var credtis:FlxSprite = new FlxSprite(1462.45, 639.05);
		credtis.loadGraphic(UIAssets.getAsset('Main Menu', 'Credits'));
		credtis.antialiasing = true;
		FlxTween.tween(credtis, {x: 709.75, y: 639.05}, 2, {
			ease: FlxEase.circInOut,
			startDelay: 0.83333333333333333333333333333333
		});
		add(credtis);

		selectorguy = new FlxSprite(1290.65, 465.35);
		selectorguy.loadGraphic(UIAssets.getAsset('Main Menu', 'Selector'));
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
		FlxG.switchState(new LevelEditor());
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
				FlxG.sound.play("assets/sounds/selectinSoung.wav", 0.5, false);
				changeItem(-1);
			}
			if (FlxG.keys.justPressed.DOWN || FlxG.keys.justPressed.S)
			{
				FlxG.sound.play("assets/sounds/selectinSoung.wav", 0.5, false);
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
