package;

import debug.FPSCounter;
import flixel.FlxG;
import flixel.FlxGame;
import frontend.states.CachingState;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();
		var game:FlxGame = new FlxGame(1280, 720, CachingState, 250, 250, true);
		addChild(game);

		#if debug
		var fpsCounter = new FPSCounter(15, 5, 0xFFFFFFFF);
		addChild(fpsCounter);
		#end
		haxe.Log.trace = function(v:Dynamic, ?infos:haxe.PosInfos)
		{
			sys.thread.Thread.create(() ->
			{ // So the whole game doesn't just slow down when tracing every frame.
				var str = haxe.Log.formatOutput(v, infos);
				Sys.println(str);
			});
		}
	}
}
