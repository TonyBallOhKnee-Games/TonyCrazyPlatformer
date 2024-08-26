package frontend.states.substates;

import backend.utils.GameAssets;
import backend.utils.TweenHelper;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.sound.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

class PauseSubState extends FlxSubState
{
	var fadeOverlay:FlxSprite;
	var gloria:FlxSprite;
	var tony:FlxSprite;
	var baloney:FlxSprite;
	var pauseText:FlxSprite;
	var title:FlxText;
	var pauseMusic:FlxSound;
	var canPress:Bool = true;
	var tweens:Array<FlxTween>;

	override public function create():Void
	{
		super.create();

		FlxG.sound.music.pause();
		pauseMusic = new FlxSound().loadEmbedded("assets/music/Paused.wav");
		pauseMusic.play(true, 0, 0);
		pauseMusic.fadeIn(3, 0, 0.5);

		// Fade-Out Overlay
		fadeOverlay = new FlxSprite();
		fadeOverlay.makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		fadeOverlay.camera = PlayState.hudCam;
		fadeOverlay.alpha = 0; // Start transparent
		FlxTween.tween(fadeOverlay, {alpha: 0.7}, 0.8, {ease: FlxEase.quadOut});
		add(fadeOverlay);

		// Characters
		gloria = new FlxSprite(239, 784.2);
		gloria.loadGraphic(GameAssets.getAsset('Pause Menu', 'Gloria'));
		gloria.antialiasing = true;
		gloria.alpha = 0;
		gloria.camera = PlayState.hudCam;
		FlxTween.tween(gloria, {x: 239, y: 19.2, alpha: 1}, 0.8, {ease: FlxEase.circOut, startDelay: 0.05});
		add(gloria);

		tony = new FlxSprite(1323.3, 168.05);
		tony.loadGraphic(GameAssets.getAsset('Pause Menu', 'Tony'));
		tony.antialiasing = true;
		tony.alpha = 0;
		tony.camera = PlayState.hudCam;
		FlxTween.tween(tony, {x: 592.3, y: 168.05, alpha: 1}, 0.8, {ease: FlxEase.circOut, startDelay: 0.1});
		add(tony);

		baloney = new FlxSprite(-697.65, 126.5);
		baloney.loadGraphic(GameAssets.getAsset('Pause Menu', 'Baloney'));
		baloney.antialiasing = true;
		baloney.alpha = 0;
		baloney.camera = PlayState.hudCam;
		FlxTween.tween(baloney, {x: -34.65, y: 126.5, alpha: 1}, 0.8, {
			ease: FlxEase.circOut,
			startDelay: 0.08
		});
		add(baloney);

		// Pause Text
		pauseText = new FlxSprite(396.55, -144.55);
		pauseText.loadGraphic(GameAssets.getAsset('Pause Menu', 'Paused'));
		pauseText.antialiasing = true;
		pauseText.alpha = 0;
		pauseText.camera = PlayState.hudCam;
		FlxTween.tween(pauseText, {x: 396.55, y: 543.95, alpha: 1}, 0.8, {ease: FlxEase.circOut});
		add(pauseText);

		title = new FlxText(0, -200, 0, "Press Q to quit. \n Press ESC to unpause");
		title.setFormat("assets/fonts/baloney.ttf", 32, FlxColor.WHITE, "center");
		title.camera = PlayState.hudCam;

		FlxTween.tween(title, {x: 0, y: 0}, 0.8, {ease: FlxEase.circOut});

		add(title);
	}

	private function startFadeOut():Void
	{
		pauseMusic.fadeTween.cancel();
		pauseMusic.fadeOut(0.8, 0);
		FlxTween.tween(fadeOverlay, {alpha: 0}, 0.8, {
			ease: FlxEase.quadOut,
			onComplete: resumeGame
		});

		FlxTween.tween(pauseText, {x: 396.55, y: -144.55, alpha: 0}, 0.8, {
			ease: FlxEase.circIn
		});

		FlxTween.tween(baloney, {x: -697.65, y: 126.5, alpha: 0}, 0.8, {
			ease: FlxEase.circIn
		});

		FlxTween.tween(tony, {x: 1323.3, y: 168.05, alpha: 0}, 0.8, {
			ease: FlxEase.circIn
		});

		FlxTween.tween(gloria, {x: 239, y: 784.2, alpha: 0}, 0.8, {
			ease: FlxEase.circIn
		});

		FlxTween.tween(title, {x: 0, y: -200}, 0.8, {
			ease: FlxEase.circIn,
			startDelay: 0
		});

		add(title);
	}

	private function startFadeOutQuit():Void
	{
		pauseMusic.fadeTween.cancel();
		pauseMusic.fadeOut(0.8, 0);
		FlxTween.tween(fadeOverlay, {alpha: 1}, 0.8, {
			ease: FlxEase.quadOut,
			onComplete: quittingTime
		});

		FlxTween.tween(pauseText, {x: 396.55, y: -144.55, alpha: 0}, 0.8, {
			ease: FlxEase.circIn
		});

		FlxTween.tween(baloney, {x: -697.65, y: 126.5, alpha: 0}, 0.8, {
			ease: FlxEase.circIn
		});

		FlxTween.tween(tony, {x: 1323.3, y: 168.05, alpha: 0}, 0.8, {
			ease: FlxEase.circIn
		});

		FlxTween.tween(gloria, {x: 239, y: 784.2, alpha: 0}, 0.8, {
			ease: FlxEase.circIn
		});

		FlxTween.tween(title, {x: 0, y: -200}, 0.8, {
			ease: FlxEase.circIn,
			startDelay: 0
		});
	}

	private function resumeGame(_:FlxTween):Void
	{
		FlxG.sound.music.resume();
		close();
	}

	private function quittingTime(_:FlxTween):Void
	{
		// FlxG.sound.music.resume();
		FlxG.switchState(new MainMenuState());
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		if (FlxG.keys.justPressed.ESCAPE && canPress)
		{
			canPress = false;
			TweenHelper.cancelAllTweens();
			startFadeOut();
		}

		if (FlxG.keys.justPressed.Q && canPress)
		{
			canPress = false;
			TweenHelper.cancelAllTweens();
			startFadeOutQuit();
		}
	}
}
