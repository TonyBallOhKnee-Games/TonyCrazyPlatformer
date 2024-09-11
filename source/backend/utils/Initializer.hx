package backend.utils;

import backend.utils.AssetUtil.UIAssets;

class Initializer
{
	public static function initialize()
	{
		CachingUtil.cacheBaseAssets(true);
	}

	public static function postCache()
	{
		UIAssets.initAssetMaps();
	}
}
