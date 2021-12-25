package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.FlxState;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.text.FlxText;

class AwardState extends FlxState
{
    var description:FlxText;

    var noAchievement:FlxButton;
    var noAchievement2:FlxButton;
    var noAchievement3:FlxButton;
    var neolelevar:FlxButton;
    var trollvar:FlxButton;
    var anavar:FlxButton;

    override function create()
    {
        super.create();

        FlxG.mouse.visible = true;

        var brown:FlxSprite = new FlxSprite();
        brown.makeGraphic(FlxG.width, FlxG.height, FlxColor.BROWN);
        brown.antialiasing = false;
        brown.screenCenter();
        add(brown);

        noAchievement = new FlxButton(50, 30, '', none);
        noAchievement.loadGraphic(Paths.image('awards/red'));
        noAchievement.updateHitbox();
        add(noAchievement);

        noAchievement2 = new FlxButton(250, 30, '', none2);
        noAchievement2.loadGraphic(Paths.image('awards/red'));
        noAchievement2.updateHitbox();
        add(noAchievement2);

        noAchievement3 = new FlxButton(450, 30, '', none3);
        noAchievement3.loadGraphic(Paths.image('awards/red'));
        noAchievement3.updateHitbox();
        add(noAchievement3);

        neolelevar = new FlxButton(50, 30, '', neolele);
        neolelevar.loadGraphic(Paths.image('awards/red'));
        neolelevar.updateHitbox();
        add(neolelevar);
        neolelevar.visible = false;

        trollvar = new FlxButton(250, 30, '', troll);
        trollvar.loadGraphic(Paths.image('awards/red'));
        trollvar.updateHitbox();
        add(trollvar);
        trollvar.visible = false;

        anavar = new FlxButton(450, 30, '', ana);
        anavar.loadGraphic(Paths.image('awards/red'));
        anavar.updateHitbox();
        add(anavar);
        anavar.visible = false;

        if (FlxG.save.data.anadila)
            anavar.visible = true;

        if (FlxG.save.data.ultraHD)
            trollvar.visible = true;
        
        if (StoryMenuState.weekUnlocked[2])
            neolelevar.visible = true;
    }

    function neolele()
    {
        if (neolelevar.visible)
        {
            trace('neolele');
        }
        if (neolelevar.visible = false)
        {
            trace('sus');

            description = new FlxText(0, -200, 0, "You didn't unlock this award yet!", 40);
            description.setFormat(null, 40, FlxColor.BLACK);
            description.screenCenter(X);
            add(description);
        }
    }

    function none()
    {
        if (neolelevar.visible = false)
        {
            trace('sus');
        }
    }

    function none2()
    {
        if (trollvar.visible = false)
        {
            trace('sus');
        }
    }

    function none3()
    {
        if (anavar.visible = false)
        {
            trace('sus');
        }
    }

    function troll()
    {
        if (trollvar.visible)
        {
            trace('troll');
        }
        if (trollvar.visible = false)
        {
            trace('sus');
        }
    }

    function ana()
    {
        if (anavar.visible)
        {
            trace('ana');
        }
        if (anavar.visible = false)
        {
            trace('sus');
        }
    }

    override function update(elapsed:Float)
    {
        super.update(elapsed);
        
        if (FlxG.keys.pressed.ESCAPE)
            FlxG.switchState(new MainMenuState());
    }
}