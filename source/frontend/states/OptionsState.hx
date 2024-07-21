package frontend.states;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

class OptionsState extends FlxState
{
	override public function create():Void
	{
		super.create();

		// Add title text
		var title:FlxText = new FlxText(0, FlxG.height / 4, FlxG.width, "Options");
		title.setFormat(null, 32, FlxColor.WHITE, "center");
		add(title);

		// Add Sound Toggle button
		var soundButton:FlxButton = new FlxButton(FlxG.width / 2 - 40, FlxG.height / 2, "Toggle Sound", toggleSound);
		add(soundButton);

		// Add Controls button (for demonstration, no functionality)
		var controlsButton:FlxButton = new FlxButton(FlxG.width / 2 - 40, FlxG.height / 2 + 40, "Controls", goToControls);
		add(controlsButton);

		// Add Back button to return to the main menu
		var backButton:FlxButton = new FlxButton(FlxG.width / 2 - 40, FlxG.height / 2 + 80, "Back", goBack);
		add(backButton);
	}

	private function toggleSound():Void
	{
		// Toggle sound on or off
		FlxG.sound.muted = !FlxG.sound.muted;
		trace("Sound toggled: " + (FlxG.sound.muted ? "off" : "on"));
	}

	private function goToControls():Void
	{
		// Go to controls settings (not implemented in this example)
		trace("Go to controls settings");
	}

	private function goBack():Void
	{
		// Switch back to the main menu state
		FlxG.switchState(new MainMenuState());
	}
}
