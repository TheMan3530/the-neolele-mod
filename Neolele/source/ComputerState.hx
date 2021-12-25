package;

import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxG;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;

class ComputerState extends FlxState
{
    override function create()
    {
        super.create();

        FlxG.mouse.visible = true;

        var blue:FlxSprite = new FlxSprite();
        blue.makeGraphic(FlxG.width, FlxG.height, FlxColor.BLUE);
        add(blue);

        var computer:FlxSprite = new FlxSprite();
        computer.loadGraphic(Paths.image('computer'));
        computer.setGraphicSize(Std.int(computer.width * 2));
        computer.screenCenter();
        computer.antialiasing = true;
        add(computer);

        var browser:FlxButton = new FlxButton(0, 0, '', HD);
        browser.loadGraphic(Paths.image('browser'));
        browser.setGraphicSize(Std.int(browser.width / 5));
        browser.screenCenter();
        add(browser);
    }

    function HD()
    {
        // copied from the option thing
        var poop:String = Highscore.formatSong("Ultra-Hd", 1);

		PlayState.SONG = Song.loadFromJson(poop, "Ultra-Hd");
		PlayState.isStoryMode = true;
		PlayState.storyDifficulty = 0;
		PlayState.storyWeek = 69; // ha ha funni number lol
		trace('CUR WEEK' + PlayState.storyWeek);
		LoadingState.loadAndSwitchState(new PlayState());
		return false;
    }

    override function update(elapsed:Float)
    {
        super.update(elapsed);

        if (FlxG.keys.justPressed.ESCAPE)
            FlxG.switchState(new MainMenuState());
    }
}