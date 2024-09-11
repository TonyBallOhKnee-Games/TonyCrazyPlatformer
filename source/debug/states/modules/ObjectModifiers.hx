package debug.states.modules;

import backend.utils.Interactions;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class ObjectModifiers extends EditorModule
{
	override public function loadModule()
	{
		super.loadModule();

		// Assets
		var scaleXPlusBG = new FlxSprite((1280 - 400) + 30, 0);
		scaleXPlusBG.makeGraphic(400 - 60, 30, FlxColor.GRAY);
		scaleXPlusBG.camera = targetCam;
		scaleXPlusBG.alpha = 0.45;
		scaleXPlusBG.screenCenter(Y);
		scaleXPlusBG.y -= 260;
		hudAssets.set('scaleXPlusBG', scaleXPlusBG);
		// group.add(scaleXPlusBG);

		var scaleXMinusBG = new FlxSprite((1280 - 400) + 30, 0);
		scaleXMinusBG.makeGraphic(400 - 60, 30, FlxColor.GRAY);
		scaleXMinusBG.camera = targetCam;
		scaleXMinusBG.alpha = 0.45;
		scaleXMinusBG.screenCenter(Y);
		scaleXMinusBG.y -= 260 - 60;
		hudAssets.set('scaleXMinusBG', scaleXMinusBG);
		// group.add(scaleXMinusBG);

		// Texts
		var scaleTxt = new FlxText((1280 - 400) + 30, 0, 0, 'ScaleX');
		scaleTxt.camera = targetCam;
		scaleTxt.screenCenter(Y);
		scaleTxt.y -= 290;
		hudTexts.set('scaleTxt', scaleTxt);
		// group.add(scaleTxt);

		var scaleXPlusTxt = new FlxText((1280 - 400) + 30, 0, 0, '+', 25);
		scaleXPlusTxt.camera = targetCam;
		scaleXPlusTxt.screenCenter(Y);
		scaleXPlusTxt.y -= 258;
		hudTexts.set('scaleXPlusTxt', scaleXPlusTxt);
		// group.add(scaleXPlusTxt);

		var scaleXTxt = new FlxText((1280 - 400) + 30, 0, 0, '0.5', 25);
		scaleXTxt.camera = targetCam;
		scaleXTxt.screenCenter(Y);
		scaleXTxt.y -= 258 - 30;
		hudTexts.set('scaleXTxt', scaleXTxt);
		// group.add(scaleXTxt);

		var scaleXMinusTxt = new FlxText((1280 - 400) + 30, 0, 0, '-', 25);
		scaleXMinusTxt.camera = targetCam;
		scaleXMinusTxt.screenCenter(Y);
		scaleXMinusTxt.y -= 258 - 60;
		hudTexts.set('scaleXMinusTxt', scaleXMinusTxt);
		// group.add(scaleXMinusTxt);
	}

	var pressedAmt:Int = 0;

	override public function updateModule()
	{
		super.updateModule();

		if (selectedObject != null)
		{
			// ModuleUtil.setObjectsVisible(this, true);
			if (FlxG.mouse.justPressed)
			{
				if (Interactions.objectCollisionMouse(hudAssets.get('scaleXPlusBG')))
					selectedObject.scale.x += 0.1;
				if (Interactions.objectCollisionMouse(hudAssets.get('scaleXMinusBG')))
					selectedObject.scale.x -= 0.1;
			}
			if (FlxG.mouse.pressed) // Hold if for long enough, increases rapidly(I like this feature)
			{
				pressedAmt++;
				if (pressedAmt > 120)
				{
					if (Interactions.objectCollisionMouse(hudAssets.get('scaleXPlusBG')))
						selectedObject.scale.x += 0.1;
					if (Interactions.objectCollisionMouse(hudAssets.get('scaleXMinusBG')))
						selectedObject.scale.x -= 0.1;
				}
			}
			else
			{
				pressedAmt = 0;
			}
			hudTexts.get('scaleXTxt').text = Std.string(selectedObject.scale.x);
		}
		else
		{
			// ModuleUtil.setObjectsVisible(this, false);
		}
	}
}
