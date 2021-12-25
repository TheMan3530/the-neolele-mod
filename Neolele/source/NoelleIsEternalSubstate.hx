package;

import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.addons.plugin.taskManager.FlxTask;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxSubState;
import flixel.util.FlxTimer;

class NoelleIsEternalSubstate extends FlxSubState
{
    var creepytimer:FlxTimer;
    var othertimer:FlxTimer;

    override function create()
    {
        super.create();

        creepytimer = new FlxTimer().start(3.0, function showText(tmr:FlxTimer)
            {
                othertimer = new FlxTimer().start(0.5, function display(tmr:FlxTimer)
                    {
                        var eternal1:FlxText = new FlxText(0, 0, 0, 'NOELLE IS ETERNAL', 50);
                        eternal1.setFormat('VCR OSD Mono', 50, FlxColor.WHITE);
                        eternal1.alpha = 0.35;
                        add(eternal1);
                    }, 3);
            }, 0);
    }

    override function update(elapsed:Float)
    {
        super.update(elapsed);
    }
}