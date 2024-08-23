package backend.ingame.objects;

import backend.Common.AnimData;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.system.FlxAssets.FlxGraphicAsset;

class NPC extends PhysicsObject
{
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

	public function load(?charName:String = 'Jim', ?anims:Array<AnimData> = null, ?antialiasing:Bool = true)
	{
		if (anims == null)
		{
			anims = defAnimData;
		}
		loadGraphic('assets/images/characters/$charName.png');
		frames = FlxAtlasFrames.fromSparrow('assets/images/characters/$charName.png', 'assets/images/characters/$charName.xml');
		for (anim in anims)
			animation.addByPrefix(anim.name, anim.prefix, anim.fps, anim.looped, anim.flipX, anim.flipY);
		antialiasing = true;
		updateHitbox();
	}
}
