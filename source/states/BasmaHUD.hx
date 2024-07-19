package states;

import flixel.text.FlxText;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.util.FlxColor;

class BasmaHUD extends FlxTypedGroup<FlxSprite> {

    var scoreText: FlxText;
    var score = 0;

    public function new() {

        super();
        

        var logoB:FlxSprite = new FlxSprite(922.05, 37.35);
        logoB.loadGraphic("assets/images/huds/basma/basmas.png");
        logoB.antialiasing = true;
        logoB.scrollFactor.set(0,0);

        add(logoB);

        var news:FlxSprite = new FlxSprite(0, 633.1);
        news.loadGraphic("assets/images/huds/basma/unneeded new.png");
        news.antialiasing = true;
        news.scrollFactor.set(0,0);

        add(news);
        
        var sand:FlxSprite = new FlxSprite(858.05, 581.5);
        sand.loadGraphic("assets/images/huds/basma/sand.png");
        sand.antialiasing = true;
        sand.scrollFactor.set(0,0);

        add(sand);

        var boat:FlxSprite = new FlxSprite(858.05, 581.5);
        boat.loadGraphic("assets/images/huds/basma/boat.png");
        boat.antialiasing = true;
        boat.scrollFactor.set(0,0);

        add(boat);






        var bars:FlxSprite = new FlxSprite(0, 0);
        bars.loadGraphic("assets/images/huds/basma/bars.png");
        bars.antialiasing = true;
        bars.scrollFactor.set(0,0);
        add(bars);
        
        scoreText = new FlxText(0, 0, 0, "Score: 0");
        scoreText.scrollFactor.set(0,0);
        scoreText.setFormat("assets/fonts/baloney.ttf", 40, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        scoreText.antialiasing = true;

        add(scoreText);

        
    }

    public function incrementScore() {

        score++;
        scoreText.text = 'Score: $score';

    }
}