package frontend.states.substates;

import flixel.FlxG;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

class PauseSubState extends FlxSubState
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
		close();
	}

	// Override the update method to listen for key presses
	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		if (FlxG.keys.justPressed.ESCAPE)
		{
			resumeGame();
		}
	}
}
