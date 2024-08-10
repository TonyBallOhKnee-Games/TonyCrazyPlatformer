package frontend.states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileDiamond;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.TransitionData;
import flixel.graphics.FlxGraphic;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;



class WarningState extends FlxState
{
	public static var curSelected:Int = 0; // Selected menu option (0: Start, 1: Load, 2: Options)

	override public function create():Void
	{
		super.create();
		
		FlxG.sound.music.stop();

		FlxG.autoPause = false;
		this.bgColor = 0xff000000;
		var warningBG:FlxSprite = new FlxSprite(0, 0);
		warningBG.loadGraphic("assets/images/warning/Hey.png");
		warningBG.antialiasing = true;
		add(warningBG);

		// add version text
		var warnText:FlxText = new FlxText(0, 0, 685.6,
			"This game is still in development. If you encounter any bugs, please report them to the developers on our Discord server.\nArt is a form of expression, and we appreciate your understanding and support as we continue to create.\nThank you for your feedback and for being part of our community!",
			40);
		warnText.scrollFactor.set();
		warnText.setFormat("assets/fonts/baloney.ttf", 40, FlxColor.WHITE, CENTER);
		warnText.screenCenter(Y);
		warnText.screenCenter(X);
		add(warnText);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		if (FlxG.keys.anyPressed([ENTER, SPACE]))
			FlxG.switchState(new MainMenuState());
	}
}
