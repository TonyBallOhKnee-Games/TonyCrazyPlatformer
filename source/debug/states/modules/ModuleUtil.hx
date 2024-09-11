package debug.states.modules;

class ModuleUtil
{
	public static function setObjectsVisible(module:Module, visible:Bool)
	{
		for (asset in module.hudAssets)
			asset.visible = visible;
		for (text in module.hudTexts)
			text.visible = visible;
	}
}
