package states;




import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;




class DeadState extends FlxState
{

    public static var curSelected: Int = 0; // Selected menu option (0: Start, 1: Load, 2: Options)
    
    

    override public function create():Void
    {
        super.create();

        

       



        var clouds:FlxSprite = new FlxSprite(0,0);
        clouds.loadGraphic("assets/images/warning/Hey.png");
        add(clouds);


        //add version text
        var warnText:FlxText = new FlxText(0, 0, 685.6, "Your dead. El bozo.", 40);
        warnText.scrollFactor.set();
        warnText.setFormat("assets/fonts/baloney.ttf", 40, FlxColor.WHITE, CENTER);
        warnText.screenCenter(Y);
        warnText.screenCenter(X);
        add(warnText);

        //var dead:FlxAnimate = new FlxAnimate(0, 0, PathToAtlas);







       


    }
        
          
    override function update(elapsed:Float)
        {
            
         if (FlxG.keys.anyPressed([ENTER, SPACE])){
            FlxG.sound.play("assets/sounds/confirmMenu.ogg");
            FlxG.switchState(new MainMenuState());
            
        };

            super.update(elapsed);
        }

}
