package frontend.states;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.FlxSprite;

class CreditsState extends FlxState
{
	override public function create():Void
	{
		super.create();

		var background:FlxSprite = new FlxSprite(0, 0);
		background.loadGraphic("assets/images/optionsBG.png");
		background.antialiasing = true;
		add(background);
		
		// Add title text
		var title:FlxText = new FlxText(0, FlxG.height / 4, FlxG.width, "Credits");
		title.setFormat(null, 32, FlxColor.WHITE, "center");
		add(title);


	}


	private function goBack():Void
	{
		// Switch back to the main menu state
		FlxG.switchState(new MainMenuState());
	}
}
