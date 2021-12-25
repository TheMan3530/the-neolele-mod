package;

import flixel.FlxSprite;

class HealthIcon extends FlxSprite
{
	/**
	 * Used for FreeplayState! If you use it elsewhere, prob gonna annoying
	 */
	public var sprTracker:FlxSprite;

	public function new(char:String = 'bf', isPlayer:Bool = false)
	{
		super();
		
		loadGraphic(Paths.image('iconGrid'), true, 150, 150);

		antialiasing = true;
		animation.add('bf', [0, 1], 0, false, isPlayer);
		animation.add('noelle', [2, 3], 0, false, isPlayer);
		animation.add('neolele', [4, 5], 0, false, isPlayer);
		animation.add('nole', [5, 6], 0, false, isPlayer);
		animation.add('ana-ruv', [7, 8], 0, false, isPlayer);
		animation.add('troll', [9], 0, false, isPlayer);
		animation.add('susie', [10, 11], 0, false, isPlayer);
		animation.play(char);
		scrollFactor.set();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y - 30);
	}
}
