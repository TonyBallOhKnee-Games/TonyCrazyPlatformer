package frontend.states;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import openfl.Lib;
import openfl.net.URLRequest;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;


class MainMenuState extends FlxState
{
	public static var curSelected:Int = 0; // Selected menu option (0: Start, 1: Load, 2: Options)

	private var selectorguy:FlxSprite;
	public var logoShit:FlxSprite = new FlxSprite(-612.65, -59.2);
	public var tonyDovark:FlxSprite = new FlxSprite(986.9, 347.45);

	override public function create():Void
	{
		super.create();

		curSelected = 0; // Set curSelected to 0 at the start of the state

		FlxG.sound.playMusic("assets/music/MainNew.wav", 0.5, true);

		// Add background image
		var sky:FlxSprite = new FlxSprite(0, 0);
		sky.loadGraphic("assets/images/title/sky.png");
		sky.antialiasing = true;
		add(sky);

		

		logoShit.loadGraphic('assets/images/title/logo.png', true);
		logoShit.frames = FlxAtlasFrames.fromSparrow('assets/images/title/logo.png', 'assets/images/title/logo.xml');
		logoShit.animation.addByPrefix('logoShit', 'coolness', 24, false);
		logoShit.antialiasing = true;
		logoShit.animation.play("logoShit");
		add(logoShit);

		tonyDovark.loadGraphic('assets/images/title/TonyMenu.png', true);
		tonyDovark.frames = FlxAtlasFrames.fromSparrow('assets/images/title/TonyMenu.png', 'assets/images/title/TonyMenu.xml');
		tonyDovark.animation.addByPrefix('tonyDovark', 'TonyBop', 24, false);
		tonyDovark.antialiasing = true;
		tonyDovark.animation.play("tonyDovark");
		add(tonyDovark);

		var start:FlxSprite = new FlxSprite(1430.6, 465.35);
		start.loadGraphic("assets/images/title/new game.png");
		start.antialiasing = true;
		
		FlxTween.tween(start, { x: 374.95, y: 465.35 }, 2, 
			{ 
				type:       ONESHOT,
				ease:       FlxEase.circInOut,
				startDelay: 0.83333333333333333333333333333333
			}
		);

		add(start);

		var load:FlxSprite = new FlxSprite(1424.4, 523.25);
		load.loadGraphic("assets/images/title/loadgame.png");
		load.antialiasing = true;
		
		FlxTween.tween(load, { x: 493.75, y: 523.25 }, 2, 
			{ 
				type:       ONESHOT,
				ease:       FlxEase.circInOut,
				startDelay: 0.83333333333333333333333333333333
			}
		);
		
		add(load);

		var options:FlxSprite = new FlxSprite(1456.3, 581.15);
		options.loadGraphic("assets/images/title/options.png");
		options.antialiasing = true;
		
		FlxTween.tween(options, { x: 637, y: 581.15 }, 2, 
			{ 
				type:       ONESHOT,
				ease:       FlxEase.circInOut,
				startDelay: 0.83333333333333333333333333333333
			}
		);
		
		add(options);

		var credtis:FlxSprite = new FlxSprite(1462.45, 639.05);
		credtis.loadGraphic("assets/images/title/credits.png");
		credtis.antialiasing = true;
		
		FlxTween.tween(credtis, { x: 709.75, y: 639.05 }, 2, 
			{ 
				type:       ONESHOT,
				ease:       FlxEase.circInOut,
				startDelay: 0.83333333333333333333333333333333
			}
		);

		add(credtis);

		selectorguy = new FlxSprite(1095.75, 450.35);
		selectorguy.loadGraphic("assets/images/title/unused/selectorthingy.png");
		selectorguy.antialiasing = true;
		add(selectorguy);

		// Add version text
		var gameVer:FlxText = new FlxText(-700, 12, 0, "Tony's Crazy Adventures Game V1 \nCreated by TonyBallOhKnee", 40);
		gameVer.scrollFactor.set();
		gameVer.setFormat("assets/fonts/baloney.ttf", 40, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		gameVer.antialiasing = true;
		
		FlxTween.tween(gameVer, { x: 12, y: 12 }, 2, 
			{ 
				type:       ONESHOT,
				ease:       FlxEase.circInOut,
				startDelay: 1.3

			}
		);
		
		add(gameVer);

		// Add YouTube button
		var youtubeButton:FlxButton = new FlxButton(0, 700, "YouTube", openYouTube);
		add(youtubeButton);
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
			selectorguy.x = 577.65;	
			selectorguy.y = 465.35;
			case 1:
			selectorguy.x = 715.85;	
			selectorguy.y = 529.15;
			case 2:
			selectorguy.x = 790.1;
			selectorguy.y = 581.15;
			case 3:
			selectorguy.x = 851.3;
			selectorguy.y = 639.05;	
		}
	}

	override function update(elapsed:Float):Void
	{
		if (FlxG.keys.justPressed.UP || FlxG.keys.justPressed.W)
		{
			changeItem(-1);
		}
		if (FlxG.keys.justPressed.DOWN || FlxG.keys.justPressed.S)
		{
			changeItem(1);
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
