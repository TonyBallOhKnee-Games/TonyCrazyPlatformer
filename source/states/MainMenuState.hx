package states;

import flixel.FlxState;
import flixel.FlxG;
import flixel.ui.FlxButton;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.FlxSprite;
import openfl.Lib;
import openfl.net.URLRequest;
import flixel.FlxObject;

class MainMenuState extends FlxState
{
    public static var curSelected: Int = 0; // Selected menu option (0: Start, 1: Load, 2: Options)
    private var selectorguy: FlxSprite;

    override public function create():Void
    {
        super.create();

        FlxG.sound.playMusic("assets/music/MainNew.wav", 0.5, true);

        // Add background image
        var sky:FlxSprite = new FlxSprite(0, 0);
        sky.loadGraphic("assets/images/title/sky.png");
        sky.antialiasing = true;
        add(sky);

        var clouds:FlxSprite = new FlxSprite(-81.7, 5.9);
        clouds.loadGraphic("assets/images/title/clouds.png");
        clouds.antialiasing = true;
        add(clouds);

        // Add additional menu images
        var imSoHappySoHappyGoLuckyMe:FlxSprite = new FlxSprite(78, 99.95);
        imSoHappySoHappyGoLuckyMe.loadGraphic("assets/images/title/tony.png");
        imSoHappySoHappyGoLuckyMe.antialiasing = true;
        add(imSoHappySoHappyGoLuckyMe);

        var logoShit:FlxSprite = new FlxSprite(734.3, 6.75);
        logoShit.loadGraphic("assets/images/title/logo.png");
        logoShit.antialiasing = true;
        add(logoShit);

        var start:FlxSprite = new FlxSprite(840.85, 442.1);
        start.loadGraphic("assets/images/title/new game.png");
        start.antialiasing = true;
        add(start);

        var load:FlxSprite = new FlxSprite(831.4, 520.95);
        load.loadGraphic("assets/images/title/loadgame.png");
        load.antialiasing = true;
        add(load);

        var options:FlxSprite = new FlxSprite(835.35, 601.9);
        options.loadGraphic("assets/images/title/options.png");
        options.antialiasing = true;
        add(options);

        selectorguy = new FlxSprite(1095.75, 450.35);
        selectorguy.loadGraphic("assets/images/title/selectorthingy.png");
        selectorguy.antialiasing = true;
        add(selectorguy);

        // Add version text
        var gameVer:FlxText = new FlxText(12, 12, 0, "Tony's Crazy Platformer V1 \nCreated by TonyBallOhKnee", 40);
        gameVer.scrollFactor.set();
        gameVer.setFormat("assets/fonts/baloney.ttf", 40, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        gameVer.antialiasing = true;
        add(gameVer);

        // Add YouTube button
        var youtubeButton:FlxButton = new FlxButton(0,600, "YouTube", openYouTube);
        add(youtubeButton);
    }

    private function startGame():Void
    {
        // Switch to the game state (you need to create this)
        FlxG.switchState(new PlayState());
    }

    private function goToOptions():Void
    {
        // Switch to the options state (you need to create this)
        FlxG.switchState(new OptionsState());
    }

    private function openYouTube():Void
    {
        // Open YouTube link
        Lib.getURL(new URLRequest("https://www.youtube.com/@TonyBallOhKnee"), "_blank");
    }

    private function changeItem(direction:Int):Void
    {
        curSelected += direction;
        if (curSelected < 0) curSelected = 2;
        if (curSelected > 2) curSelected = 0;

        switch (curSelected)
        {
            case 0: selectorguy.y = 450.35;
            case 1: selectorguy.y = 520.95;
            case 2: selectorguy.y = 601.9;
        }
    }

    override function update(elapsed:Float):Void
    {
        if (FlxG.keys.justPressed.UP || FlxG.keys.justPressed.W) {
            changeItem(-1);
        }
        if (FlxG.keys.justPressed.DOWN || FlxG.keys.justPressed.S) {
            changeItem(1);
        }
        if (FlxG.keys.justPressed.ENTER) {
            switch (curSelected) {
                case 0: startGame();
                case 1: // Implement load game logic here
                case 2: goToOptions();
            }
        }

        super.update(elapsed);
    }
}
