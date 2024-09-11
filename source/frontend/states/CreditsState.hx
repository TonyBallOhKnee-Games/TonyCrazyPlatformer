package frontend.states;

import backend.utils.AssetUtil;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.transition.FlxTransitionableState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

class CreditsState extends FlxTransitionableState
{
	override public function create():Void
	{
		super.create();

		var background:FlxSprite = new FlxSprite(0, 0);
		background.loadGraphic(UIAssets.getAsset('Options Menu', 'BG'));
		background.antialiasing = true;
		add(background);

		// Add title text
		var title:FlxText = new FlxText(0, FlxG.height / 4, FlxG.width, "Credits");
		title.setFormat(null, 32, FlxColor.WHITE, "center");
		add(title);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		if (FlxG.keys.justPressed.ESCAPE)
		{
			goBack();
		}
	}

	private function goBack():Void
	{
		// Switch back to the main menu state
		FlxG.switchState(new MainMenuState());
	}
}
