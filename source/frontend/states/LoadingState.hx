package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.transition.FlxTransitionableState;
import flixel.system.FlxAssets;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class LoadingState extends FlxTransitionableState
{
	private var loadingText:FlxText;
	private var loadingBar:FlxSprite;
	private var loadingProgress:Float = 0;

	override public function create():Void
	{
		super.create();

		// Set background color
		bgColor = FlxColor.BLACK;

		loadingBar = new FlxSprite(FlxG.width / 4, FlxG.height / 2 + 20);
		loadingBar.makeGraphic(Std.int(FlxG.width / 2), 10, FlxColor.WHITE);
		loadingBar.scrollFactor.set();
		loadingBar.scale.x = 0;
		add(loadingBar);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
