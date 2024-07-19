package states;

import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.util.FlxCollision;
import flixel.text.FlxText;
import flixel.FlxState;
import flixel.FlxCamera;
import objects.*;
import states.stages.objects.*;

class PlayState extends FlxState
{
    var levelBounds:FlxGroup;
    var tonyPlayer:Tony;
    var hud:BasmaHUD;

    override public function create():Void
    {
        super.create();
        
        bgColor = 0xffcccccc;
        
        tonyPlayer = new Tony(); // Create the tonyPlayer
        //tonyPlayer.scale.set(0.4, 0.4); // Scale the tonyPlayer, for example, to 1.5 times its original size
        tonyPlayer.antialiasing = true;
        add(tonyPlayer);

        hud = new BasmaHUD();
        
        add(hud);
        

        

        // Set the camera to follow the player and zoom out
        //FlxG.camera.follow(tonyPlayer);
        //FlxG.camera.zoom = 0.4;

        
        levelBounds = FlxCollision.createCameraWall(FlxG.camera, false, 1);
         
           
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);

        // Check if the Escape key is pressed to activate the pause state
        if (FlxG.keys.justPressed.ESCAPE) {
            // Pause the game by adding the PauseState
            FlxG.switchState(new MainMenuState());
        }
        if (FlxG.keys.justPressed.R) {
            FlxG.switchState(new DeadState());
        }

        FlxG.collide(tonyPlayer, levelBounds);
    }
}
