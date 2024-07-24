package;

import flixel.FlxState;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class LoadingState extends FlxState
{
    private var loadingText:FlxText;
    private var loadingBar:FlxSprite;
    private var loadComplete:Bool = false;

    override public function create():Void
    {
        super.create();
        
        // Set background color
        FlxG.bgColor = FlxColor.BLACK;

        // Create and add loading text
        loadingText = new FlxText(0, FlxG.height / 2 - 10, FlxG.width, "Loading...");
        loadingText.setFormat(null, 16, FlxColor.WHITE, "center");
        add(loadingText);

        // Create and add loading bar
        loadingBar = new FlxSprite(FlxG.width / 4, FlxG.height / 2 + 20);
        loadingBar.makeGraphic(FlxG.width / 2, 10, FlxColor.WHITE);
        loadingBar.scrollFactor.set();
        add(loadingBar);

        // Start loading assets
        loadAssets();
    }

    private function loadAssets():Void
    {
        // Simulate asset loading with a timer
        FlxG.assets.loadBitmap("assets/images/someImage.png");
        FlxG.assets.loadSound("assets/sounds/someSound.mp3");

        FlxG.timer.start(3, function(timer):Void {
            loadComplete = true;
        });
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);

        // Update loading bar width based on loading progress
        loadingBar.scale.x = FlxG.assets.progress;

        // If loading is complete, switch to the next state
        if (loadComplete)
        {
            FlxG.switchState(new PlayState());
        }
    }
}
