package frontend.states;

import flixel.FlxG;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import openfl.Lib;
import openfl.events.KeyboardEvent;

class PauseState extends FlxSubState
{
	override public function create():Void
	{
		super.create();

		// Add pause text
		var pauseText:FlxText = new FlxText(0, FlxG.height / 4, FlxG.width, "PAUSED");
		pauseText.setFormat(null, 32, FlxColor.RED, "center");
		add(pauseText);

		// Add resume button
		var resumeButton:FlxButton = new FlxButton(FlxG.width / 2 - 40, FlxG.height / 2, "Resume", resumeGame);
		add(resumeButton);
	}

	private function resumeGame():Void
	{
		// Resume the game by removing this pause state
		FlxG.state.remove(this);
	}

	// Override the update method to listen for key presses
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		// Check if the Escape key is pressed to resume the game
		if (FlxG.keys.justPressed.ESCAPE)
		{
			resumeGame();
		}
	}
}
