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

		// Create and add loading text
		loadingText = new FlxText(0, FlxG.height / 2 - 10, FlxG.width, "Loading...");
		loadingText.setFormat(null, 16, FlxColor.WHITE, "center");
		add(loadingText);

		// Create and add loading bar
		loadingBar = new FlxSprite(FlxG.width / 4, FlxG.height / 2 + 20);
		loadingBar.makeGraphic(FlxG.width / 2, 10, FlxColor.WHITE);
		loadingBar.scrollFactor.set();
		loadingBar.scale.x = 0;
		add(loadingBar);

		// Start loading assets
		loadAssets();
	}

	private function loadAssets():Void
	{
		// Load images
		FlxG.assets.loadGraphic("assets/images/someImage.png", false, true, 100, 100);
		FlxG.assets.loadGraphic("assets/images/anotherImage.png", false, true, 100, 100);

		// Load sounds
		FlxG.assets.loadSound("assets/sounds/someSound.mp3");
		FlxG.assets.loadSound("assets/sounds/anotherSound.mp3");

		// Preload the assets
		FlxG.assets.onLoadComplete = onAssetsLoaded;
	}

	private function onAssetsLoaded():Void
	{
		// Transition to the next state when loading is complete
		FlxG.switchState(new PlayState());
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		// Update loading progress
		loadingProgress = FlxG.assets.progress;
		loadingBar.scale.x = loadingProgress;

		// Optionally, you can display the percentage of loading
		loadingText.text = "Loading... " + Math.round(loadingProgress * 100) + "%";
	}
}
