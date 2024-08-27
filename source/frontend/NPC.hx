package frontend;

import backend.ingame.objects.PhysicsObject;
import backend.utils.Common.AnimData;
import backend.utils.Common.NPCAssets;
import backend.utils.GameAssets;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.system.FlxAssets.FlxGraphicAsset;

class NPC extends PhysicsObject
{
	public var assets:NPCAssets;

	public function new(?X:Float = 0, ?Y:Float = 0, ?SimpleGraphic:FlxGraphicAsset, colliders:FlxTypedGroup<PhysicsObject>)
	{
		super(X, Y, SimpleGraphic, colliders, NPC);
	}

	public static final defAnimData:Array<AnimData> = [
		{
			name: 'idleanim',
			prefix: 'Jim Idle',
			fps: 24,
			looped: true,
			flipX: false,
			flipY: false
		}
	];

	public function load(?charName:String = 'jim', ?anims:Array<AnimData> = null, ?antialiasing:Bool = true, ?updateNPCHitbox = true)
	{
		if (anims == null)
		{
			anims = defAnimData;
		}
		assets = GameAssets.getNPCAssets(charName);
		frames = FlxAtlasFrames.fromSparrow(assets.npcImg, assets.npcXml);
		for (anim in anims)
			animation.addByPrefix(anim.name, anim.prefix, anim.fps, anim.looped, anim.flipX, anim.flipY);
		antialiasing = true;
		if (updateNPCHitbox)
			updateHitbox();
	}
}
