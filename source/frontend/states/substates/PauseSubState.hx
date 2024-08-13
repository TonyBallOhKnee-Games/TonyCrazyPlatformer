package frontend.states.substates;

import flixel.FlxG;
import flixel.sound.FlxSound;
import flixel.FlxSubState;
import flixel.ui.FlxButton;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.text.FlxText;

class PauseSubState extends FlxSubState
{
    private var fadeOverlay:FlxSprite;
    private var gloria:FlxSprite;
    private var tony:FlxSprite;
    private var baloney:FlxSprite;
    private var pauseText:FlxSprite;
    private var title:FlxText;
   
	override public function create():Void
	{
		super.create();
	
		FlxG.sound.music.pause();
		
	
        
        // Fade-Out Overlay
        fadeOverlay = new FlxSprite();
        fadeOverlay.makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
        fadeOverlay.alpha = 0; // Start transparent

        FlxTween.tween(fadeOverlay, { alpha: 0.7 }, 0.5, 
        { 
            type: FlxTween.ONESHOT, 
            ease: FlxEase.quadOut, 
            //onComplete: resumeGame 
        });

        add(fadeOverlay);

        // Characters
        gloria = new FlxSprite(239, 784.2);
        gloria.loadGraphic("assets/images/Pause/gloria.png");
        gloria.antialiasing = true;
        FlxTween.tween(gloria, { x: 239, y: 19.2 }, 1, 
        { 
            type: FlxTween.ONESHOT,
            ease: FlxEase.circOut,
            startDelay: 0.05
        });
        add(gloria);

        tony = new FlxSprite(1323.3, 168.05);
        tony.loadGraphic("assets/images/Pause/tony.png");
        tony.antialiasing = true;
        FlxTween.tween(tony, { x: 592.3, y: 168.05 }, 1, 
        { 
            type: FlxTween.ONESHOT,
            ease: FlxEase.circOut,
            startDelay: 0.1
        });
        add(tony);

        baloney = new FlxSprite(-697.65, 126.5);
        baloney.loadGraphic("assets/images/Pause/baloney.png");
        baloney.antialiasing = true;
        FlxTween.tween(baloney, { x: -34.65, y: 126.5 }, 1, 
        { 
            type: FlxTween.ONESHOT,
            ease: FlxEase.circOut,
            startDelay: 0.08
        });
        add(baloney);

        // Pause Text
        pauseText = new FlxSprite(396.55, -144.55);
        pauseText.loadGraphic("assets/images/Pause/paused.png");
        pauseText.antialiasing = true;
        FlxTween.tween(pauseText, { x: 396.55, y: 543.95 }, 1, 
        { 
            type: FlxTween.ONESHOT,
            ease: FlxEase.circOut,
            startDelay: 0
        });
        add(pauseText);

        title = new FlxText(0, 0, 0, "Press Q to quit. \n Press ESC to unpause");
        title.setFormat(null, 32, FlxColor.WHITE, "center");
        add(title);

    }

    private function startFadeOut():Void
    {
        FlxTween.tween(fadeOverlay, { alpha: 0 }, 0.5, 
        { 
            type: FlxTween.ONESHOT, 
            ease: FlxEase.quadOut, 
            onComplete: resumeGame 
        });

        FlxTween.tween(pauseText, { x: 396.55, y: -144.55 }, 0.5, 
        { 
            type: FlxTween.ONESHOT,
            ease: FlxEase.circIn
        });

        FlxTween.tween(baloney, { x: -697.65, y: 126.5 }, 0.5, 
        { 
            type: FlxTween.ONESHOT,
            ease: FlxEase.circIn
        });

        FlxTween.tween(tony, { x: 1323.3, y: 168.05 }, 0.5, 
        { 
            type: FlxTween.ONESHOT,
            ease: FlxEase.circIn
        });

        FlxTween.tween(gloria, { x: 239, y: 784.2 }, 0.5, 
        { 
            type: FlxTween.ONESHOT,
            ease: FlxEase.circIn
        });
    }

    private function resumeGame(_:FlxTween):Void
    {
        FlxG.sound.music.resume();
        close();
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);

        if (FlxG.keys.justPressed.ESCAPE)
        {
            startFadeOut();
        }

        if (FlxG.keys.justPressed.Q)
        {
            FlxG.switchState(new MainMenuState());
        }
    }
}
