package debug.states;

import backend.utils.AssetUtil.WorldAssets;
import backend.utils.Common.LevelAssets;
import backend.utils.FileUtil;
import backend.utils.Interactions;
import debug.states.modules.EditorModule;
import debug.states.modules.ObjectModifiers;
import flixel.FlxBasic;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.addons.effects.chainable.FlxEffectSprite;
import flixel.addons.effects.chainable.FlxOutlineEffect;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxPoint;
import flixel.system.debug.FlxDebugger;
import flixel.text.FlxText;
import flixel.util.FlxCollision;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;
import frontend.NPC;
import frontend.states.MainMenuState;
import hx.files.File;
import openfl.display.BitmapData;
import openfl.display.Graphics;
import openfl.events.Event;
import openfl.events.IOErrorEvent;
import openfl.net.FileFilter;
import openfl.net.FileReference;

using StringTools;
using flixel.util.FlxSpriteUtil;

class LevelEditor extends FlxTransitionableState
{
	public static var objSelected:EditorSprite;
	public static var spriteMap:Map<String, EditorSprite>;
	public static var npcMap:Map<String, NPC>;
	public static var hudCam:FlxCamera;
	public static var followPos:FlxObject;
	public static var hudModules:Map<String, EditorModule>;
	public static var hudBox:FlxSprite;
	public static var isNull:Bool = true;

	var displaySpr:FlxSprite;

	var youCan:FlxSprite;

	override public function create():Void
	{
		super.create();
		WorldAssets.initLevelPath('BASE', 'LOLIPOP');
		spriteMap = new Map<String, EditorSprite>();
		npcMap = new Map<String, NPC>();
		hudCam = new FlxCamera(0, 0, 1280, 720);
		hudCam.bgColor = FlxColor.TRANSPARENT;
		FlxG.cameras.add(hudCam, false);
		followPos = new FlxObject(0, 0, 0, 0);
		displaySpr = new FlxSprite(-2000, -2000);
		displaySpr.makeGraphic(5000, 5000, FlxColor.TRANSPARENT);
		add(displaySpr);

		generateHud();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		FlxG.camera.follow(followPos, FlxCameraFollowStyle.NO_DEAD_ZONE);
		if (FlxG.keys.anyPressed([ESCAPE, BACKSPACE]))
		{
			FlxG.switchState(new MainMenuState());
		}
		if (FlxG.keys.anyPressed([ENTER]))
		{
			loadImage();
		}
		updateHUD();
		cameraMovement(); // HELP ME PLEASE 😭
		objectSelectionCheck();
		updateSelectedObject();
	}

	function updateHUD()
	{
		for (module in hudModules)
		{
			module.targetCam = hudCam; // Update all instances
			module.parent = hudBox;
			module.selectedObject = objSelected;
			module.objNull = isNull;
			module.updateModule();
		}
	}

	function pushHudModules()
	{
		var objMods = new ObjectModifiers(hudBox, hudCam, objSelected, isNull);
		hudModules.set('objectModifiers', objMods);
		add(objMods);
	}

	function generateHud()
	{
		hudModules = new Map<String, EditorModule>();

		hudBox = new FlxSprite(1280 - 400, 0);
		hudBox.makeGraphic(400, 600, FlxColor.GRAY);
		hudBox.camera = hudCam;
		hudBox.alpha = 0.45;
		hudBox.screenCenter(Y);
		hudBox.updateHitbox();
		add(hudBox);

		pushHudModules();
		for (module in hudModules)
			module.loadModule();
	}

	function _shift()
	{
		return FlxG.keys.pressed.SHIFT;
	}

	function _space()
	{
		return FlxG.keys.pressed.SPACE;
	}

	function updateSelectedObject()
	{
		if (!isNull)
		{
			var posX:Float = 0, posY:Float = 0;
			if (FlxG.keys.justPressed.LEFT)
				posX -= (_shift() ? 2.5 : _space() ? 8 : 5);
			if (FlxG.keys.justPressed.RIGHT)
				posX += (_shift() ? 2.5 : _space() ? 8 : 5);
			if (FlxG.keys.justPressed.UP)
				posY -= (_shift() ? 2.5 : _space() ? 8 : 5);
			if (FlxG.keys.justPressed.DOWN)
				posY += (_shift() ? 2.5 : _space() ? 8 : 5);

			if (FlxG.mouse.pressedRight
				&& (FlxG.mouse.deltaScreenX != 0 || FlxG.mouse.deltaScreenY != 0)
				&& Interactions.objectCollisionMouse(objSelected))
			{
				posX += FlxG.mouse.deltaScreenX * (_shift() ? 0.25 : 1);
				posY += FlxG.mouse.deltaScreenY * (_shift() ? 0.25 : 1);
			}
			objSelected.x += posX;
			objSelected.y += posY;
		}
	}

	override function destroy() // Destroy and nullify everything.
	{
		super.destroy();
		FlxG.cameras.remove(hudCam);
		objSelected.destroy();
		for (obj in spriteMap)
			obj.destroy();
		spriteMap.clear();
		for (obj in npcMap)
			obj.destroy();
		npcMap.clear();
		hudCam.destroy();
		followPos.destroy();
		for (module in hudModules)
		{
			module.unloadModule();
			module.destroy();
			module = null;
		}
		hudModules.clear();
		hudBox.destroy();
		objSelected = null;
		spriteMap = null;
		npcMap = null;
		hudCam = null;
		followPos = null;
		hudModules = null;
		hudBox = null;
	}

	function objectSelectionCheck()
	{
		if (FlxG.mouse.justPressed && !Interactions.spriteCollisionMouse(hudBox, hudCam))
		{
			var objPassed = false;
			for (obj in spriteMap)
			{
				if (Interactions.objectCollisionMouse(obj))
				{
					objPassed = true;
					isNull = false;
					if (obj != objSelected)
					{
						if (objSelected != null)
						{ // Remove Old Selection Box
							trace('removing!');
							objSelected.loadGraphic(objSelected.normalGraphic);
						}
						trace('adding!');
						trace('checked.');
						obj.loadGraphic(obj.outlineGraphic);
						objSelected = obj;
					}
					break;
				}
				else
				{
					obj.visible = true;
				}
			}
			if (!objPassed)
			{
				trace('extra ckeck.');
				if (objSelected != null)
				{ // Remove Old Selection Box
					youCan = objSelected.clone();
					youCan.loadGraphic(objSelected.normalGraphic);
					objSelected.loadGraphic(objSelected.normalGraphic);
					add(youCan);
				}
				isNull = true;
			}
		}
	}

	function cameraMovement()
	{
		if (FlxG.keys.pressed.SHIFT)
			FlxG.camera.zoom += FlxG.mouse.wheel / 50;
		else
			FlxG.camera.zoom += FlxG.mouse.wheel / 10;
		if (FlxG.keys.pressed.D)
		{
			if (FlxG.keys.pressed.SHIFT)
				followPos.x += 5;
			else if (FlxG.keys.pressed.SPACE)
				followPos.x += 20;
			else
				followPos.x += 10;
		}
		if (FlxG.keys.pressed.A)
		{
			if (FlxG.keys.pressed.SHIFT)
				followPos.x -= 5;
			else if (FlxG.keys.pressed.SPACE)
				followPos.x -= 20;
			else
				followPos.x -= 10;
		}
		if (FlxG.keys.pressed.S)
		{
			if (FlxG.keys.pressed.SHIFT)
				followPos.y += 5;
			else if (FlxG.keys.pressed.SPACE)
				followPos.y += 20;
			else
				followPos.y += 10;
		}
		if (FlxG.keys.pressed.W)
		{
			if (FlxG.keys.pressed.SHIFT)
				followPos.y -= 5;
			else if (FlxG.keys.pressed.SPACE)
				followPos.y -= 20;
			else
				followPos.y -= 10;
		}
	}

	var fileRef:FileReference;

	public function loadImage()
	{
		if (fileRef != null)
			return;
		fileRef = new FileReference();
		fileRef.addEventListener(Event.SELECT, onAssetLoad);
		fileRef.addEventListener(Event.CANCEL, onAssetLoadCancel);
		fileRef.addEventListener(IOErrorEvent.IO_ERROR, onAssetLoadError);
		fileRef.browse([new FileFilter('PNG (Image)', '*.png')]);
	}

	function onAssetLoadError(error:IOErrorEvent):Void
	{
		throw error.text;
	}

	function onAssetLoadCancel(_):Void
	{
		return;
	}

	function onAssetLoad(_):Void
	{
		fileRef.removeEventListener(Event.SELECT, onAssetLoad);
		fileRef.removeEventListener(Event.CANCEL, onAssetLoadCancel);
		fileRef.removeEventListener(IOErrorEvent.IO_ERROR, onAssetLoadError);
		var fullPath:String = '';
		@:privateAccess
		if (fileRef.__path != null)
			fullPath = fileRef.__path;

		if (fullPath != null)
		{
			fullPath = fullPath.replace('\\', '/');
			var file = File.of(fullPath);
			var targetDestination:String = '${WorldAssets.getLevelPath('BASE', 'LOLIPOP')}/${fileRef.name}';
			FileUtil.copyFileTo(file, targetDestination);
			loadSpriteAsset(targetDestination, fileRef.name);
		}
		fileRef = null;
	}

	function loadSpriteAsset(path:String, name:String)
	{
		var spr:EditorSprite = new EditorSprite(0, 0);
		spr.loadGraphics(BitmapData.fromFile(path));
		spr.camera = FlxG.camera;
		add(spr);
		spriteMap.set(name + Lambda.count(spriteMap), spr);
	}
}
