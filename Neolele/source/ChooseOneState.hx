package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxState;

class ChooseOneState extends FlxState
{
    override function create()
    {
        super.create();

        var RollOfRick = FlxG.random.int(0, 99);
        
        if (RollOfRick >= 50)
        {
            FlxG.openURL("https://www.youtube.com/watch?v=dQw4w9WgXcQ");
            FlxG.switchState(new MainMenuState());
        }
        else
        {
            FlxG.switchState(new MainMenuState());
            trace("Screw you you dont get to continue the song");
        }
    }

    override function update(elapsed:Float)
    {
        super.update(elapsed);
    }
}