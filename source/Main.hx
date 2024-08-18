package;

import debug.FPSCounter;
import flixel.FlxGame;
import frontend.states.BaloneyState;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();
		var game:FlxGame = new FlxGame(1280, 720, BaloneyState, 240, 240, true);

		addChild(game);
		var fpsCounter = new FPSCounter(15, 5, 0xFFFFFFFF);
		addChild(fpsCounter);
	}
}
