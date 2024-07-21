package;

import flixel.FlxGame;
import openfl.display.Sprite;
import states.WarningState;


class Main extends Sprite
{
    public function new()
    {
        super();
        var game:FlxGame = new FlxGame(1280, 720, WarningState, 60, 60, true);
        
        addChild(game);
        
    }
}
