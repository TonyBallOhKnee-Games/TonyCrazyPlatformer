package backend;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class GameHud extends FlxTypedGroup<FlxSprite>
{
	var scoreText:FlxText;
	var score = 0;

	public function new()
	{
		super();
	}

	public function incrementScore()
	{
		score++;
		scoreText.text = 'Score: $score';
	}
}
