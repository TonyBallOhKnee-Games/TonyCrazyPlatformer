package backend.utils;

class Initializer
{
	public static function initialize()
	{
		CachingUtil.cacheBaseAssets(true);
	}

	public static function postCache()
	{
		GameAssets.initAssetMaps();
	}
}
