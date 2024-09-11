package backend.utils;

import backend.utils.Common.NPCAssets;
import backend.utils.Common.PlayerAssets;
import flixel.graphics.FlxGraphic;
import flixel.system.FlxAssets.FlxGraphicAsset;
import sys.FileSystem;
import sys.io.File;

class UIAssets
{
	public static var assetMaps:Map<String, Map<String, FlxGraphic>>;

	public static function initAssetMaps()
	{
		assetMaps = new Map<String, Map<String, FlxGraphic>>();
		// I wish I could automate this somehow.
		assetMaps.set('Misc Assets', [
			'TonyBall Studios' => FileUtil.getUIGraphicFromCache('misc/TonyBall.png'),
			'Autosave' => FileUtil.getUIGraphicFromCache('misc/autoSave.png'),
		]);
		assetMaps.set('Main Menu', [
			'Credits' => FileUtil.getUIGraphicFromCache('menus/main/credits.png'),
			'Logo' => FileUtil.getUIGraphicFromCache('menus/main/logo.png'),
			'Load Game' => FileUtil.getUIGraphicFromCache('menus/main/load game.png'),
			'New Game' => FileUtil.getUIGraphicFromCache('menus/main/new game.png'),
			'Options' => FileUtil.getUIGraphicFromCache('menus/main/options.png'),
			'Selector' => FileUtil.getUIGraphicFromCache('menus/main/selector.png'),
			'TonyMenu' => FileUtil.getUIGraphicFromCache('menus/main/TonyMenu.png'),
			'Sky' => FileUtil.getUIGraphicFromCache('menus/main/sky.png')
		]);
		assetMaps.set('Pause Menu', [
			'Gloria' => FileUtil.getUIGraphicFromCache('menus/pause/gloria.png'),
			'Tony' => FileUtil.getUIGraphicFromCache('menus/pause/tony.png'),
			'Baloney' => FileUtil.getUIGraphicFromCache('menus/pause/baloney.png'),
			'Paused' => FileUtil.getUIGraphicFromCache('menus/pause/paused.png'),
		]);
		assetMaps.set('Save/Load Menu', [
			'Load/Save' => FileUtil.getUIGraphicFromCache('menus/save/loadSave.png'),
			'Photo' => FileUtil.getUIGraphicFromCache('menus/save/photo.png'),
			'Wood' => FileUtil.getUIGraphicFromCache('menus/save/wood.png')
		]);
		assetMaps.set('Warning Menu', [
			'Hey' => FileUtil.getUIGraphicFromCache('menus/warning/Hey.png'),
			'Warning' => FileUtil.getUIGraphicFromCache('menus/warning/Warning.png'),
			'WarningText' => FileUtil.getUIGraphicFromCache('menus/warning/warningg.png'),
			'Box2' => FileUtil.getUIGraphicFromCache('menus/warning/box2.png'),
		]);
		assetMaps.set('Level Selection Menu', [
			'Black Gradiant' => FileUtil.getUIGraphicFromCache('menus/levelSelection/black-gradiant.png'),
			'Level' => FileUtil.getUIGraphicFromCache('menus/levelSelection/level.png'),
			'Numbers' => FileUtil.getUIGraphicFromCache('menus/levelSelection/numbers.png'),
			'Picker Bg' => FileUtil.getUIGraphicFromCache('menus/levelSelection/picker-bg.png'),
		]);
		assetMaps.set('Options Menu', ['BG' => FileUtil.getUIGraphicFromCache('menus/options/bg.png')]);
	}

	public static function getAsset(catagory:String, assetName:String):FlxGraphicAsset
	{
		return assetMaps.get(catagory).get(assetName); // Shorten it to a small function. How convinient! :D
	}
}

class CharacterAssets
{
	public static function getNPCAssets(name:String):NPCAssets
	{
		var npcPath = 'assets/data/characters/npcs/$name';
		var npcImg = '$npcPath/char.png';
		var npcXml = '$npcPath/char.xml';
		return {
			npcPath: npcPath,
			npcImg: npcImg,
			npcXml: npcXml
		};
	}

	public static function getPlayerAssets(name:String):PlayerAssets
	{
		var charPath = 'assets/data/characters/players/$name';
		var charImg = '$charPath/char.png';
		var charXml = '$charPath/char.xml';
		var deathImg = '$charPath/death.png';
		var deathXml = '$charPath/death.xml';
		var dialogueImg = '$charPath/dialogue.png';
		var dialogueXml = '$charPath/dialogue.xml';
		var animBindings = ADHUtil.ParseAA(File.getContent('$charPath/animBindings.adh'), ',');
		var properties = ADHUtil.ParseAA(File.getContent('$charPath/properties.adh'), ':');
		var soundData = ADHUtil.ParseAA(File.getContent('$charPath/sounds/soundBindings.adh'), ':');
		return {
			charPath: charPath,
			charImg: charImg,
			charXml: charXml,
			deathImg: deathImg,
			deathXml: deathXml,
			dialogueImg: dialogueImg,
			dialogueXml: dialogueXml,
			properties: properties,
			animBindings: animBindings,
			soundData: soundData
		};
	}
}

class WorldAssets
{
	public static function initWorldPath(worldName:String)
	{
		var worldPath:String = 'assets/data/worlds/$worldName';
		FileSystem.createDirectory(worldPath);
		File.saveContent('$worldPath/properties.adh', '');
	}

	public static function initLevelPath(worldName:String, levelName:String)
	{
		var levelPath:String = 'assets/data/worlds/$worldName/levels/$levelName';
		FileSystem.createDirectory(levelPath);
		File.saveContent('$levelPath/level.hx', '');
		File.saveContent('$levelPath/level.adh', '');
		File.saveContent('$levelPath/properties.adh', '');
	}

	public static function getWorldPath(worldName:String)
	{
		return 'assets/data/worlds/$worldName';
	}

	public static function getLevelPath(worldName:String, levelName:String)
	{
		return 'assets/data/worlds/$worldName/levels/$levelName';
	}
}
