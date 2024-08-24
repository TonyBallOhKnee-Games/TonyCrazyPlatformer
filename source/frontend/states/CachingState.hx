package frontend.states;

import backend.utils.CachingUtil;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxBackdrop;
import flixel.math.FlxMath;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.ui.FlxBar;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class CachingState extends FlxState
{
	public static var loadingText:FlxText;
	public static var initialized:Bool = false;
	public static var exitingState:Bool = false;
	public static var progBar:FlxBar;
	public static var lerpProg:Float;
	public static var tonyHead:FlxSprite;

	override function create()
	{
		super.create();
		var gradient = new FlxSprite(0, 0, 'assets/images/loading/Gradient.png');
		add(gradient);
		gradient.color = FlxColor.GREEN;
		var backdrop = new FlxBackdrop('assets/images/loading/Checker.png', XY);
		backdrop.velocity.x = 500;
		backdrop.velocity.y = 500;
		backdrop.color = FlxColor.LIME;
		add(backdrop);
		tonyHead = new FlxSprite(0, 0, 'assets/images/loading/TonyHead.png');
		add(tonyHead);
		CachingUtil.cacheBaseAssets();
		loadingText = new FlxText(12, 570, 0, "", 12);
		loadingText.scrollFactor.set();
		loadingText.setFormat(null, 35, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, false);
		loadingText.borderSize = 3;
		add(loadingText);
		progBar = new FlxBar(0, FlxG.height * 0.9, FlxBarFillDirection.HORIZONTAL_INSIDE_OUT, 601, 35, 'lerpProg', 0, CachingUtil.fullSize, true);
		progBar.scale.x = 2;
		progBar.scale.y = 2;
		progBar.screenCenter(X);
		progBar.scrollFactor.set();
		progBar.createGradientBar([FlxColor.BLACK], [FlxColor.GREEN, FlxColor.LIME], 1, 180, true, FlxColor.BLACK);
		add(progBar);
		initialized = true;
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		lerpProg = FlxMath.lerp(CachingUtil.curProgress, lerpProg, 0.9);
		if (CachingUtil.doneCaching)
		{
			if (!exitingState)
			{
				exitingState = true;
				loadingText.text = 'Done!';
				FlxG.camera.flash();
				progBar.destroy();
				progBar = null;
				new FlxTimer().start(5, function(tmr:FlxTimer)
				{
					doneLoading();
				});
			}
		}
		else
		{
			progBar.value = lerpProg;
			if (CachingUtil.loadingStr != 'hehe, null.')
				loadingText.text = CachingUtil.curProgress + '/' + CachingUtil.fullSize;
		}
		loadingText.screenCenter(X);
	}

	function doneLoading()
	{
		FlxG.switchState(new BaloneyState());
	}
}
