package debug.states.modules;

import flixel.FlxCamera;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.text.FlxText;

class EditorModule extends Module
{
	public var selectedObject:FlxSprite;

	public function new(parent:FlxSprite, targetCam:FlxCamera, selectedObject:FlxSprite)
	{
		super(parent, targetCam);
		this.selectedObject = selectedObject;
	}
}
