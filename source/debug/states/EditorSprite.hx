package debug.states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;
import openfl.display.BitmapData;

class EditorSprite extends FlxSprite
{
	public var normalGraphic:FlxGraphicAsset;
	public var outlineGraphic:BitmapData;

	public function loadGraphics(graphic:FlxGraphicAsset)
	{
		loadGraphic(graphic);
		normalGraphic = graphic; // Take a copy of the original graphic
		FlxSpriteUtil.drawRect(this, x, y, width, height, FlxColor.TRANSPARENT, {
			thickness: 5,
			color: FlxColor.RED
		});
		outlineGraphic = pixels.clone(); // Take a copy of the modified graphic
		loadGraphic(normalGraphic); // Load in the normal graphic
	}
}
