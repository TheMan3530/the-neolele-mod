package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxState;

class BerdlyFreeze extends FlxState
{
    override function create()
    {
        super.create();
        
        FlxG.switchState(new VideoState('assets/videos/BERDLY-DIES-LOL.webm', new ChooseOneState(), 4392, true));
    }

    override function update(elapsed:Float)
    {
        super.update(elapsed);
    }
}