package states;

import flixel.FlxState;
import hxcodec.flixel.FlxVideo;
import flixel.FlxG; // Import for changing state
import states.MainMenuState; // Import the MainMenuState

class StartingCutSceneState extends FlxState
{
    
    public var video:FlxVideo = new FlxVideo();
    
    override public function create():Void
    {
        super.create();
        
        video.play('assets/videos/video.mp4');
        video.onEndReached.add(onVideoEnd); // Use a custom function for when the video ends

    
    }

    private function onVideoEnd():Void
    {
        video.dispose(); // Dispose of the video
        FlxG.switchState(new MainMenuState()); // Change to MainMenuState
    }
}
