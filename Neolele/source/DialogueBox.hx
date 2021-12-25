package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using StringTools;

class DialogueBox extends FlxSpriteGroup
{
	var noelletalking:Bool = false;
	var berdlytalking:Bool = false;
	var bftalking:Bool = false;
	var gftalking:Bool = false;
	var trolltalking:Bool = false;

	var droptextAllowed:Bool = false;

	var right:Bool = false;
	var left:Bool = false;

	var bitBox:Bool = false;

	var box:FlxSprite;

	var curCharacter:String = '';

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];

	// SECOND DIALOGUE FOR THE PIXEL SHIT INSTEAD???
	var swagDialogue:FlxTypeText;

	var dropText:FlxText;

	public var finishThing:Void->Void;

	var portraitLeft:FlxSprite;
	var portraitRight:FlxSprite;

	var handSelect:FlxSprite;
	var bgFade:FlxSprite;
	
	var portraitNoelle:FlxSprite;
	var portraitNoelleS:FlxSprite;
	var portraitBerdly:FlxSprite;
	var portraitSus:FlxSprite;
	var portraitBf:FlxSprite;
	var portraitBf2:FlxSprite;
	var portraitGf:FlxSprite;
	var portraitNeolele:FlxSprite;
	var portraitNoelleD:FlxSprite;
	var portraitTroll:FlxSprite;

	var gray:FlxSprite;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super();			

		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				FlxG.sound.playMusic(Paths.music('Lunchbox'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'thorns':
				FlxG.sound.playMusic(Paths.music('LunchboxScary'), 0);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
			case 'girl-next-door':
				gray = new FlxSprite();
				gray.makeGraphic(FlxG.width, FlxG.height, FlxColor.GRAY);
				gray.screenCenter();
				add(gray);
			case 'iceshock':
				FlxG.sound.playMusic(Paths.music('roblox'), 0, true);
				FlxG.sound.music.fadeIn(1, 0, 0.8);
		}

		bgFade = new FlxSprite(-200, -200).makeGraphic(Std.int(FlxG.width * 1.3), Std.int(FlxG.height * 1.3), 0xFFB3DFd8);
		bgFade.scrollFactor.set();
		bgFade.alpha = 0;
		add(bgFade);

		new FlxTimer().start(0.83, function(tmr:FlxTimer)
		{
			bgFade.alpha += (1 / 5) * 0.7;
			if (bgFade.alpha > 0.7)
				bgFade.alpha = 0.7;
		}, 5);
		
		var hasDialog = false;
		switch (PlayState.SONG.song.toLowerCase())
		{
			case 'senpai':
				box = new FlxSprite(-20, 45);
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-pixel');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);

				bitBox = true;
			case 'roses':
				box = new FlxSprite(-20, 45);
				hasDialog = true;
				FlxG.sound.play(Paths.sound('ANGRY_TEXT_BOX'));

				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-senpaiMad');
				box.animation.addByPrefix('normalOpen', 'SENPAI ANGRY IMPACT SPEECH', 24, false);
				box.animation.addByIndices('normal', 'SENPAI ANGRY IMPACT SPEECH', [4], "", 24);

				bitBox = true;

			case 'thorns':
				box = new FlxSprite(-20, 45);
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-evil');
				box.animation.addByPrefix('normalOpen', 'Spirit Textbox spawn', 24, false);
				box.animation.addByIndices('normal', 'Spirit Textbox spawn', [11], "", 24);

				var face:FlxSprite = new FlxSprite(320, 170).loadGraphic(Paths.image('weeb/spiritFaceForward'));
				face.setGraphicSize(Std.int(face.width * 6));
				add(face);

				bitBox = true;

			case 'girl-next-door' | 'rude-buster':
				box = new FlxSprite(-20, 45);
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-pixel');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);

				bitBox = true;

			case 'ultra-hd':
				box = new FlxSprite(-20, 45);
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('deltarune/dialogueBox-4k'); 
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);

				trolltalking = true;

			case 'iceshock':
				box = new FlxSprite(-20, 45);
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-evil');
				box.animation.addByPrefix('normalOpen', 'Spirit Textbox spawn', 24, false);
				box.animation.addByIndices('normal', 'Spirit Textbox spawn', [11], "", 24);

				bitBox = true;
				
			default:
				box = new FlxSprite(-20, 45);
				hasDialog = true;
				box.frames = Paths.getSparrowAtlas('weeb/pixelUI/dialogueBox-pixel');
				box.animation.addByPrefix('normalOpen', 'Text Box Appear', 24, false);
				box.animation.addByIndices('normal', 'Text Box Appear', [4], "", 24);

				bitBox = true;
		}

		this.dialogueList = dialogueList;
		
		if (!hasDialog)
			return;
		
		portraitLeft = new FlxSprite(-20, 40);
		portraitLeft.frames = Paths.getSparrowAtlas('weeb/senpaiPortrait');
		portraitLeft.animation.addByPrefix('enter', 'Senpai Portrait Enter', 24, false);
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * PlayState.daPixelZoom * 0.9));
		portraitLeft.updateHitbox();
		portraitLeft.scrollFactor.set();
		add(portraitLeft);
		portraitLeft.visible = false;

		portraitRight = new FlxSprite(0, 40);
		portraitRight.frames = Paths.getSparrowAtlas('weeb/bfPortrait');
		portraitRight.animation.addByPrefix('enter', 'Boyfriend portrait enter', 24, false);
		portraitRight.setGraphicSize(Std.int(portraitRight.width * PlayState.daPixelZoom * 0.9));
		portraitRight.updateHitbox();
		portraitRight.scrollFactor.set();
		add(portraitRight); 
		portraitRight.visible = false;

		portraitNoelle = new FlxSprite(100, FlxG.height - 510);
		portraitNoelle.frames = Paths.getSparrowAtlas('deltarune/portraits/noelle');
		portraitNoelle.animation.addByPrefix('enter', 'NOELLE Portrait Enter', 24, false);
		portraitNoelle.antialiasing = true;
		portraitNoelle.updateHitbox();
		portraitNoelle.scrollFactor.set(); 
		add(portraitNoelle);
		portraitNoelle.visible = false;

		portraitTroll = new FlxSprite(100, FlxG.height - 500);
		portraitTroll.loadGraphic(Paths.image('deltarune/portraits/trollface'), false, (Std.int(portraitTroll.width)), (Std.int(portraitTroll.height)));
		portraitTroll.animation.add('enter', [0], 0, false);
		portraitTroll.antialiasing = true;
		portraitTroll.updateHitbox();
		portraitTroll.screenCenter();
		portraitTroll.scrollFactor.set(); 
		add(portraitTroll);
		portraitTroll.visible = false;

		portraitNoelleS = new FlxSprite(100, FlxG.height - 510);
		portraitNoelleS.frames = Paths.getSparrowAtlas('deltarune/portraits/noelleS');
		portraitNoelleS.animation.addByPrefix('enter', 'NOELLE Portrait Enter', 24, false);
		portraitNoelleS.antialiasing = true;
		portraitNoelleS.updateHitbox();
		portraitNoelleS.scrollFactor.set();
		add(portraitNoelleS); 
		portraitNoelleS.visible = false;
		
		portraitBerdly = new FlxSprite(100, FlxG.height - 510);
		portraitBerdly.frames = Paths.getSparrowAtlas('deltarune/portraits/berdly');
		portraitBerdly.animation.addByPrefix('enter', 'BERDLY Portrait Enter', 24, false);
		portraitBerdly.antialiasing = true; 
		portraitBerdly.updateHitbox();
		portraitBerdly.scrollFactor.set();
		portraitBerdly.flipX = true;
		add(portraitBerdly);
		portraitBerdly.visible = false;

		portraitSus = new FlxSprite(100, FlxG.height - 510);
		portraitSus.frames = Paths.getSparrowAtlas('deltarune/portraits/susie');
		portraitSus.animation.addByPrefix('enter', 'SUS Portrait Enter', 24, false);
		portraitSus.antialiasing = true;
		portraitSus.updateHitbox();
		portraitSus.scrollFactor.set();
		add(portraitSus);
		portraitSus.visible = false;
		// heh heh get it

		portraitBf = new FlxSprite(800, FlxG.height - 510);
		portraitBf.frames = Paths.getSparrowAtlas('deltarune/portraits/bf');
		portraitBf.animation.addByPrefix('enter', 'BF Portrait Enter', 24, false);
		portraitBf.antialiasing = true;
		portraitBf.updateHitbox();
		portraitBf.scrollFactor.set();
		add(portraitBf);
		portraitBf.visible = false;

		portraitBf2 = new FlxSprite(600, FlxG.height - 350);
		portraitBf2.frames = Paths.getSparrowAtlas('deltarune/portraits/bfPortrait');
		portraitBf2.animation.addByPrefix('enter', 'Bf', 24, false);
		portraitBf2.antialiasing = false;
		portraitBf2.updateHitbox();
		portraitBf2.scrollFactor.set();
		portraitBf2.setGraphicSize(Std.int(portraitBf2.width * PlayState.daPixelZoom * 0.9));
		add(portraitBf2);
		portraitBf2.visible = false;

		portraitGf = new FlxSprite(800, FlxG.height - 490);
		portraitGf.frames = Paths.getSparrowAtlas('deltarune/portraits/gf');
		portraitGf.animation.addByPrefix('enter', 'GF Portrait Enter', 24, false);
		portraitGf.antialiasing = false;
		portraitGf.setGraphicSize(Std.int(portraitGf.width / 1.25));
		portraitGf.updateHitbox();
		portraitGf.scrollFactor.set();
		add(portraitGf);
		portraitGf.visible = false;

		portraitNeolele = new FlxSprite(100, FlxG.height - 510);
		portraitNeolele.frames = Paths.getSparrowAtlas('deltarune/portraits/neolele');
		portraitNeolele.animation.addByPrefix('enter', 'NEOLELE Portrait Enter', 24, false);
		portraitNeolele.antialiasing = false;
		portraitNeolele.updateHitbox();
		portraitNeolele.scrollFactor.set();
		portraitNeolele.setGraphicSize(Std.int(portraitNeolele.width * 1.5));
		add(portraitNeolele);
		portraitNeolele.visible = false;

		portraitNoelleD = new FlxSprite(100, FlxG.height - 510);
		portraitNoelleD.frames = Paths.getSparrowAtlas('deltarune/portraits/noelleD');
		portraitNoelleD.animation.addByPrefix('enter', 'NOELLE Portrait Enter', 24, false);
		portraitNoelleD.antialiasing = true;
		portraitNoelleD.updateHitbox();
		portraitNoelleD.scrollFactor.set();
		add(portraitNoelleD);
		portraitNoelleD.visible = false;
		
		box.animation.play('normalOpen');
		box.setGraphicSize(Std.int(box.width * PlayState.daPixelZoom * 0.9));
		box.updateHitbox();
		add(box);

		box.screenCenter(X);
		portraitLeft.screenCenter(X);

		handSelect = new FlxSprite(FlxG.width * 0.9, FlxG.height * 0.9).loadGraphic(Paths.image('weeb/pixelUI/hand_textbox'));
		add(handSelect);

		swagDialogue = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 32);
		swagDialogue.color = 0xFF3F2021;

		if (trolltalking)
		{
			swagDialogue.sounds = [FlxG.sound.load(Paths.sound('trollVoice'), 0.6)];
		}
		else
		{
			swagDialogue.sounds = [FlxG.sound.load(Paths.sound('pixelText'), 0.6)];
		}

		add(swagDialogue);

		if (PlayState.SONG.song.toLowerCase() == 'girl-next-door' || PlayState.SONG.song.toLowerCase() == 'rude-buster'/* || PlayState.SONG.song.toLowerCase() == 'ultra-hd'*/)
		{
			swagDialogue.font = 'Muff99 Regular';
		}
		else
		{
			swagDialogue.font = 'Pixel Arial 11 Bold';
		}

		if (droptextAllowed)
		{
			dropText = new FlxText(242, 502, Std.int(FlxG.width * 0.6), "", 32);
			dropText.font = 'Muff99';
			dropText.color = 0xFFD89494;
			add(dropText);
		}	

		dialogue = new Alphabet(0, 80, "", false, true);
		// dialogue.x = 90;
		// add(dialogue);
	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;

	override function update(elapsed:Float)
	{
		// HARD CODING CUZ IM STUPDI
		if (PlayState.SONG.song.toLowerCase() == 'roses')
			portraitLeft.visible = false;
		if (PlayState.SONG.song.toLowerCase() == 'thorns')
		{
			portraitLeft.color = FlxColor.BLACK;
			swagDialogue.color = FlxColor.WHITE;
			if (droptextAllowed)
				dropText.color = FlxColor.BLACK;
		}

		if (droptextAllowed)
			dropText.text = swagDialogue.text;

		if (box.animation.curAnim != null)
		{
			if (box.animation.curAnim.name == 'normalOpen' && box.animation.curAnim.finished)
			{
				box.animation.play('normal');
				dialogueOpened = true;
			}
		}

		if (dialogueOpened && !dialogueStarted)
		{
			startDialogue();
			dialogueStarted = true;
		}

		if (FlxG.keys.justPressed.ANY  && dialogueStarted == true)
		{
			remove(dialogue);
				
			FlxG.sound.play(Paths.sound('clickText'), 0.8);

			if (dialogueList[1] == null && dialogueList[0] != null)
			{
				if (!isEnding)
				{
					isEnding = true;

					if (PlayState.SONG.song.toLowerCase() == 'senpai' || PlayState.SONG.song.toLowerCase() == 'thorns')
						FlxG.sound.music.fadeOut(2.2, 0);

					new FlxTimer().start(0.2, function(tmr:FlxTimer)
					{
						box.alpha -= 1 / 5;
						bgFade.alpha -= 1 / 5 * 0.7;
						portraitLeft.visible = false;
						portraitRight.visible = false;
						swagDialogue.alpha -= 1 / 5;
						if (droptextAllowed)
							dropText.alpha = swagDialogue.alpha;
					}, 5);

					new FlxTimer().start(1.2, function(tmr:FlxTimer)
					{
						finishThing();
						kill();
					});
				}
			}
			else
			{
				dialogueList.remove(dialogueList[0]);
				startDialogue();
			}
		}
		
		super.update(elapsed);
	}

	var isEnding:Bool = false;

	function startDialogue():Void
	{
		cleanDialog();
		// var theDialog:Alphabet = new Alphabet(0, 70, dialogueList[0], false, true);
		// dialogue = theDialog;
		// add(theDialog);

		// swagDialogue.text = ;
		swagDialogue.resetText(dialogueList[0]);
		swagDialogue.start(0.04, true);

		switch (curCharacter)
		{
			case 'troll':
				portraitBf.visible = false;
				portraitGf.visible = false;
				if (!portraitTroll.visible)
				{
					portraitTroll.visible = true;
					portraitTroll.animation.play('enter');
					trolltalking = true;
				}
			
			case 'bf2':
				portraitNeolele.visible = false;
				if (!portraitBf2.visible)
				{
					portraitBf2.visible = true;
					portraitBf2.animation.play('enter');
				}
			case 'bf':
				portraitBerdly.visible = false;
				portraitGf.visible = false;
				portraitSus.visible = false;
				portraitNoelle.visible = false;
				portraitNoelleD.visible = false;
				portraitNeolele.visible = false;
				portraitNoelleS.visible = false;
				trolltalking = false;
				if (!portraitBf.visible)
				{
					portraitBf.visible = true;
					portraitBf.animation.play('enter');
				}

			case 'noelle':
				portraitBerdly.visible = false;
				portraitBf.visible = false;
				portraitGf.visible = false;
				portraitSus.visible = false;
				portraitNoelleD.visible = false;
				portraitNeolele.visible = false;
				portraitNoelleS.visible = false;
				if (!portraitNoelle.visible)
				{
					portraitNoelle.visible = true;
					portraitNoelle.animation.play('enter');
				}

			case 'noelle-surprised':
				portraitBerdly.visible = false;
				portraitBf.visible = false;
				portraitGf.visible = false;
				portraitSus.visible = false;
				portraitNoelle.visible = false;
				portraitNoelleD.visible = false;
				portraitNeolele.visible = false;
				if (!portraitNoelleS.visible)
				{
					portraitNoelleS.visible = true;
					portraitNoelleS.animation.play('enter');

					gray.alpha = 0;

					FlxG.sound.playMusic(Paths.music('noelle'), 1, true);
				}

			case 'noelle2':
				portraitBerdly.visible = false;
				portraitBf.visible = false;
				portraitGf.visible = false;
				portraitSus.visible = false;
				portraitNoelle.visible = false;
				portraitNeolele.visible = false;
				portraitNoelleS.visible = false;
				if (!portraitNoelleD.visible)
				{
					portraitNoelleD.visible = true;
					portraitNoelleD.animation.play('enter');
				}

			case 'neolele':
				portraitBerdly.visible = false;
				portraitBf.visible = false;
				portraitGf.visible = false;
				portraitSus.visible = false;
				portraitNoelle.visible = false;
				portraitNoelleD.visible = false;
				portraitNoelleS.visible = false;
				portraitBf2.visible = false;
				if (!portraitNeolele.visible)
				{
					portraitNeolele.visible = true;
					portraitNeolele.animation.play('enter');
				}

			case 'berdly':
				portraitBf.visible = false;
				portraitGf.visible = false;
				portraitSus.visible = false;
				portraitNoelle.visible = false;
				portraitNoelleD.visible = false;
				portraitNeolele.visible = false;
				portraitNoelleS.visible = false;
				if (!portraitBerdly.visible)
				{
					portraitBerdly.visible = true;
					portraitBerdly.animation.play('enter');
				}

			case 'susie':
				portraitBerdly.visible = false;
				portraitBf.visible = false;
				portraitGf.visible = false;
				portraitNoelle.visible = false;
				portraitNoelleD.visible = false;
				portraitNeolele.visible = false;
				portraitNoelleS.visible = false;
				if (!portraitSus.visible)
				{
					portraitSus.visible = true;
					portraitSus.animation.play('enter');
				}

			case 'gf':
				portraitBerdly.visible = false;
				portraitBf.visible = false;
				portraitSus.visible = false;
				portraitNoelle.visible = false;
				portraitNoelleD.visible = false;
				portraitNeolele.visible = false;
				portraitNoelleS.visible = false;
				if (!portraitGf.visible)
				{
					portraitGf.visible = true;
					portraitGf.animation.play('enter');
				}
		}
	}

	function cleanDialog():Void
	{
		var splitName:Array<String> = dialogueList[0].split(":");
		curCharacter = splitName[1];
		dialogueList[0] = dialogueList[0].substr(splitName[1].length + 2).trim();
	}
}
