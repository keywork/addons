local ADDON_NAME, EDGE = ...;
--[[
EDGE:Register('WARRIOR:Leveling:Arms' ,{
	{'Overview', "The Arms Warrior excels at taking a two-hand weapon and smashing everything in his/her way to peices. "},
	{'Stat Priority', "Strength\nCritical Strike\nMultistrike >= Mastery\nVersatility >= Haste"},
	{'Enchants', "When leveling, unless you're an Enchanter with lots of mats, don't bother with Enchants. You'll have to add a new one too often with the amount you change gear while leveling."},
	{'Gems', "Do NOT use Gems until max level. Otherwise you're going to spend too much to make it worth gemming each item you can. "},
	{'Talents & Glyphs', function(f)
		local MajorGlyphs = {
			94372, -- Bull Rush
			63325, -- Death from Above
			43421, -- Mortal striike
		};
		local MinorGlyphs = {
			63327, -- Intimidating Shout
			146973, -- Watchful Eye
			146969, -- Subtle Defender
		};
		local Talents = {
			103826, -- Juggernaut
			103840, -- Impending Victory
			29725, -- Sudden Death
			118000, -- Dragon Roar
			114030, -- Vigilance
			46924, -- Bladestorm
			152278, -- Anger Management
		};
		local TalentTips = "The talents that are primarily utility-based are simply our general recommendation, your play style and raid needs should be priority when choosing these talents. The talent descriptions include some additional advice on when different utility talents are the most appropriate choice.";
		local GlyphTips = "Glyphs are situational, they depend on the make-up of your group as well as the enemies you're facing.That said, we suggest these because they seem to be all around the best for every situation.";
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',MajorGlyphs,MinorGlyphs,Talents,TalentTips,GlyphTips)
	end},
	{'Play Styles', function(f)
		local SingleTargetRotation = "It is important to use Colossus Smash Icon Colossus Smash first when you pull a new target. Doing so will greatly increase the damage of your subsequent abilities. Your 'rotation', however, remains the same whether or not Colossus Smash is available.\n\nUse Mortal Strike Icon Mortal Strike on cooldown.\nApply Rend Icon Rend to the target, if it will live long enough (roughly 10 seconds or more).\nUse Dragon Roar Icon Dragon Roar on cooldown.\nUse Execute Icon Execute (only available when the target is below 20% health).\n5.Use Whirlwind Icon Whirlwind to dump Rage.\n";
		local MultiTargetRotation = "Against multiple targets (2-3), always keep up Sweeping Strikes Icon Sweeping Strikes, and perform a normal rotation";
		local EffectiveCooldowns = "Recklessness: Use as often as possible.\nVictory Rush: Use to restore health\nDie by the Sword: Reduce direct melee Damage\nDefensive Stance: Reduce damage and increase survivability but lose DPS.";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,EffectiveCooldowns)
	end},
	{'Tips & Tricks',function(f)
		local tips = "You should always be in Battle Stance Icon Battle Stance.";
		local tricks = "You are trying to level fast, and get to 100! So keep up the hard work, and add one or two of these tips to your bag of tricks. :) \n1. When going to and from quest areas npcs kill everything that crosses your path. 2. Loot everything, and sell every chance you get. don't hold on to anything without sentimental value, as you're leveling you're going to be tradin that gear out soon anyways";
		--TIPS_RETURN(tips,tricks)
	end},
	
});

EDGE:Register('WARRIOR:Leveling:Fury' ,{
	{'Overview', "The Fury Warrior is the dual-wielding master of smashing faces! Weather you're using one or two handed weapons, this Warrior spec is made to mow down anything in your way. This is also an effective build for raiding at level 85."},
	{'Stat Priority', "Strength\nCritical Strike >= Multistrike\nMastery\nHaste\n >= Versatility"},
	{'Enchants', "When leveling, unless you're an Enchanter with lots of mats, don't bother with Enchants. You'll have to add a new one too often with the amount you change gear while leveling."},
	{'Gems', "Do NOT use Gems until max level. Otherwise you're going to spend too much to make it worth gemming each item you can. "},
	{'Talents & Glyphs', function(f)
		local MajorGlyphs = {
			58098, -- Unending Rage
			58355, -- Enraged Speed
			94372, -- Bull Rush
		};
		local MinorGlyphs = {
			146969, -- Subtle Defender
			146973, -- Watchful Eyen
			63327, -- Intimidating Shout
		};
		local Talents = {
			103826, -- Juggernaut
			103840, -- Impending Victory
			29725, -- Sudden Death
			118000, -- Dragon Roar
			114030, -- Vigilance
			46924, -- Bladestorm
			152277, -- Ravager
		};
		local TalentTips = "The talents that are primarily utility-based are simply our general recommendation, your play style and raid needs should be priority when choosing these talents. The talent descriptions include some additional advice on when different utility talents are the most appropriate choice.";
		local GlyphTips = "Glyphs are situational, they depend on the make-up of your group as well as the enemies you're facing.That said, we suggest these because they seem to be all around the best for every situation.";
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',MajorGlyphs,MinorGlyphs,Talents,TalentTips,GlyphTips)
	end},
	{'Play Styles', function(f)
		local SingleTargetRotation = "The rotation you use while leveling up will prove to be very similar to your normal raiding rotation, but we will summarise the rotation you should use below.\nCast Bloodthirst whenever you are not Enraged.\nCast Dragon Roar on cooldown.\nUse Raging Blow whenever you have 2 stacks.\nUse Execute (only available when the target is below 20% health).\nUse Wild Strike Icon Wild Strike when you have a Bloodsurge proc, or to dump Rage.\n";
		local MultiTargetRotation = "If you are facing a large number of enemies, you can start using Whirlwind Icon Whirlwind, but you are mostly better off performing a single target rotation.";
		local EffectiveCooldowns = "Recklessness: Use as many times as possible\nVictory Rush: Use after killing to restore health.\nDie by the Sword: Use to reduce damage\nDefensive Stance: Switch to this stance to increase survivability, but lose lots of DPS.";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,EffectiveCooldowns)
	end},
	{'Tips & Tricks',function(f)
		local tips = "You should always be in Battle Stance .";
		local tricks = "You are trying to level fast, and get to 100! So keep up the hard work, and add one or two of these tips to your bag of tricks. :) \n1. When going to and from quest areas/npcs kill everything that crosses your path. 2. Loot everything, and sell every chance you get. don't hold on to anything without sentimental value, as you're leveling you're going to be tradin that gear out soon anyways";
		--TIPS_RETURN(tips,tricks)
	end},
	
});

EDGE:Register('WARRIOR:PvP:Arms' ,{
	{'Overview', "This spec was designd to allow for the best talents for use when your Arms Warrior wants to do PVP action.\n\nThis is the best setup, used by the most PvP pro's on the circuit (as far as arms warriors go). BUT talents are very situational and most of them depend on your playstyle."},
	{'Stat Priority', "Haste\nMultistrike\nCritical Strike\nStrength = PvP Power\nVersatility\nMastery"},
	{'Enchants', "Neck: Gift of Haste\nCloak: Gift of Haste\nRing: Gift of Haste\nWeapon: Mark of Warsong"},
	{'Gems', "Greater Haste Taladite"},
	{'Talents & Glyphs', function(f)
		local MajorGlyphs = {
			63325, -- Glyph of Death from Above
			94372, -- Glyph of Bull Rush
			58097, -- Glyph of Long Charge
		};
		local MinorGlyphs = {
			63327, -- Glyph of Intimidating Shout
			58369, -- Glyph of Bloody Healing
			123779, -- Glyph of the Blazing Trail
		};
		local Talents = {
			103827, -- Double Time
			55694, -- Enraged Regeneration
			29725, -- Sudden Death
			46968, -- Shockwave
			114029, -- Safeguard
			12292, -- Bloodbath
			152278, -- Anger Management
		};
		local TalentTips = "The talents that are primarily utility-based are simply our general recommendation, your play style and raid needs should be priority when choosing these talents. The talent descriptions include some additional advice on when different utility talents are the most appropriate choice.";
		local GlyphTips = "Glyphs are situational, they depend on the make-up of your group as well as the enemies you're facing.That said, we suggest these because they seem to be all around the best for every situation.";
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',MajorGlyphs,MinorGlyphs,Talents,TalentTips,GlyphTips)
	end},
	{'Play Styles', function(f)
		local SingleTargetRotation = "Strategies, or rotations are not very useful for PvP. You need to know your skills already and be able to apply them when they're needed. ";
		local MultiTargetRotation = "A rotation will not help at all with that, the best thing you can do, and what all PvPer's worth their salt do, is learn your class, their spells and skills so you know what to do with them when the need arises.";
		local EffectiveCooldowns = "Be careful, stay with your healer if you can.";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,EffectiveCooldowns)
	end},
	{'Tips & Tricks',function(f)
		local tips = "Weild high damage 2-Hand Weapon for best results";
		local tricks = "";
		--TIPS_RETURN(tips,tricks)
	end},
	
});

EDGE:Register('WARRIOR:PvP:Fury' ,{
	{'Overview', "This spec was designed to allow for the best talents for use when your Arms Warrior wants to do PVP action."},
	{'Stat Priority', "Multistrike\nHaste\nCritical Strike\nMastery\nVersatility\nStrength = PvP Power"},
	{'Enchants', "Neck: Gift of Multistrike\nCloak: Gift of Multistrike \nRing: Gift of Multistrike\nWeapon: Mark of Warsong"},
	{'Gems', "Greater Multistrike Taladite"},
	{'Talents & Glyphs', function(f)
		local MajorGlyphs = {
			63325, -- Glyph of Death from Above
			94372, -- Glyph of Bull Rush
			58097, -- Glyph of Long Charge
		};
		local MinorGlyphs = {
			63327, -- Glyph of Intimidating Shout
			58369, -- Glyph of Bloody Healing
			123779, -- Glyph of the Blazing Trail
		};
		local Talents = {
			103827, -- Double Time
			55694, -- Enraged Regeneration
			29725, -- Sudden Death
			46968, -- Shockwave
			114029, -- Safeguard
			12292, -- Bloodbath
			152278, -- Anger Management
		};
		local TalentTips = "This is the best setup, used by the most PvP pro's on the circuit (as far as arms warriors go). BUT talents are very situational and most of them depend on your playstyle.";
		local GlyphTips = "Glyphs are situational, they depend on the make-up of your group as well as the enemies you're facing.That said, we suggest these because they seem to be all around the best for every situation.";
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',MajorGlyphs,MinorGlyphs,Talents,TalentTips,GlyphTips)
	end},
	{'Play Styles', function(f)
		local SingleTargetRotation = "Weild high damage 2-Hand Weapon for best results";
		local MultiTargetRotation = "Strategies, or rotations are not very useful for PvP. You need to know your skills already and be able to apply them when they're needed. ";
		local EffectiveCooldowns = "A rotation will not help at all with that, the best thing you can do, and what all PvPer's worth their salt do, is learn your class, their spells and skills so you know what to do with them when the need arises.";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,EffectiveCooldowns)
	end},
	{'Tips & Tricks',function(f)
		local tips = "";
		local tricks = "";
		--TIPS_RETURN(tips,tricks)
	end},
	
});

EDGE:Register('WARRIOR:PvP:Protection' ,{
	{'Overview', "This spec was designed to allow for the best talents for use when your Protection Warrior wants to do PVP action."},
	{'Stat Priority', "Stamina\nVersatility\nBonus Armor\nArmor\nMastery\nHaste = Critical Strike\nMultistrike >= Strength = PvP Power"},
	{'Enchants', "Neck: Gift of Versatility\nCloak: Gift of Versatility\nRing: Gift of Versatility\nWeapon: Mark of Bleeding Hollow"},
	{'Gems', "Greater Stamina Taladite"},
	{'Talents & Glyphs', function(f)
		local MajorGlyphs = {
			63325, -- Glyph of Death from Above
			94372, -- Glyph of Bull Rush
			58377, -- Glyph of Blitz
		};
		local MinorGlyphs = {
			63327, -- Glyph of Intimidating Shout
			146969, -- Glyph of subtle  Defender
			123779, -- Glyph of the Blazing Trail
		};
		local Talents = {
			103827, -- Double Time
			55694, -- Enraged Regeneratino
			29725, -- Sudden Death
			46968, -- Shockwave
			114029, -- Safeguard
			12292, -- Bloodbath
			152276, -- Gladiator's Resolve
		};
		local TalentTips = "This is the best setup (for Protection Warriors), though feel free to change Double Time, Piercing Howl, and Shockwave with any of the other talents in their tier.";
		local GlyphTips = "Glyphs are situational, they depend on the make-up of your group as well as the enemies you're facing.That said, we suggest these because they seem to be all around the best for every situation.";
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',MajorGlyphs,MinorGlyphs,Talents,TalentTips,GlyphTips)
	end},
	{'Play Styles', function(f)
		local SingleTargetRotation = "Strategies, or rotations are not very useful for PvP. You need to know your skills already and be able to apply them when they're needed. ";
		local MultiTargetRotation = "A rotation will not help at all with that, the best thing you can do, and what all PvPer's worth their salt do, is learn your class, their spells and skills so you know what to do with them when the need arises.";
		local EffectiveCooldowns = "Stay near healers, keep together!";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,EffectiveCooldowns)
	end},
	{'Tips & Tricks',function(f)
		local tips = "Weild a 1-Hand Weapon and Shield for best results.";
		local tricks = "A good job for you would be to protect the healers. ";
		--TIPS_RETURN(tips,tricks)
	end},
	
});
]]
EDGE:Register('WARRIOR:Leveling:Fury' ,{
	{'Stat Priority', "1 - Strenght\n2 - Haste (38%)\n3 - Critical Strike (30%)\n4 - Mastery\n5 - Versatility\n6 - Haste\n7 - Critical Strike"},
	{'Talents', function(f)
		local Talents = {
			215556, -- War Machine*
			103827, -- Double Time
			215569, -- Wrecking Ball*
			202224, -- Furious Charge*
			202922, -- Carnage
			215573, -- Inner Rage
			46924, -- Bladestorm
		};
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',nil,nil,Talents,nil,nil)
	end},
	{'Rotation', function(f)
		local SingleTargetRotation = "- Odyn's Fury for large amounts of AoE damage. Combine with Battle Cry for more damage.\n- Whirlwind for Meat Cleaver";
		local MultiTargetRotation = "";
		local EffectiveCooldowns = "";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,nil)
	end},
	{'Buffs',function(f)
		local tips = "Guild Banners:\nBattle Standard of Cooperation\nStandard of Unity\nBattle Standard of Coordination\n\nFood:\nButtered Sturgeon = 125 Haste\nFrosty Stew = 100 Haste\n\nCritical Strike Food:\nPickled Eel = 125 Critical Strike\nBlackrock Barbecue = 100 Critical Strike\n\nFlask: \nGreater Draenic Strength Flask\n\nRune:\nStout Augment Rune\n\nPotion:\nDraenic Strength Potion";
		local tricks = "";
		return EDGE:FillTemplate(f,'Tips',tips,tricks)
		--TIPS_RETURN(tips,tricks)
	end},
	
});

EDGE:Register('WARRIOR:PvE:Arms' ,{
	{'Stat Priority', "1 - Strength\n2 - Haste\n3 - Mastery\n4 - Versatility\n5 - Critical Strike"},
	{'Enchants', "Back - Enchant Cloak - Gift of Haste\nNeck - Enchant Neck - Gift of Haste\nRings - Enchant Ring - Gift of Haste\nWeapons - Enchant Weapon - Mark of Bleeding Hollow"},
	{'Gems', "1 - Immaculate Haste Taladite\n2 - Greater Haste Taladite\n3 - Haste Taladite"},
	{'Talents', function(f)
		local Talents = {
			202297, -- Dauntless
			103827, -- Double Time
			202316, -- Fervor of Battle
			202163, -- Bounding Stride
			215550, -- In for the Kill
			215538, -- Trauma
			203179, -- Opportunity Strikes
		};
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',nil,nil,Talents,nil,nil)
	end},
	{'Rotation', function(f)
		local SingleTargetRotation = "1 - Colossus Smash\n2 - Mortal Strike\n3 - Whirlwind (with Fervor of Battle talented)";
		local MultiTargetRotation = "1 - Cleave\n2 - Mortal Strike (against 2)\n3 - Whirlwind\n4 - Colossus Smash";
		local EffectiveCooldowns = "";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,nil)
	end},
	{'Buffs',function(f)
		local tips = "Food:\nButtered Sturgeon = 125 Haste\nFrosty Stew = 100 Haste\n\nFlask: \nGreater Draenic Strength Flask\n\nRune:\nStout Augment Rune\n\nPotion:\nDraenic Strength Potion";
		local tricks = "";
		return EDGE:FillTemplate(f,'Tips',tips,tricks)
		--TIPS_RETURN(tips,tricks)
	end},
	
});
-- 7.0
EDGE:Register('WARRIOR:PvE:Fury' ,{
	{'Stat Priority', "1 - Strenght\n2 - Haste (38%)\n3 - Critical Strike (30%)\n4 - Mastery\n5 - Versatility\n6 - Haste\n7 - Critical Strike"},
	{'Enchants', "Back - Enchant Cloak - Gift of Haste/Critical Strike\nNeck - Enchant Neck - Gift of Haste/Critical Strike\nRings - Enchant Ring - Gift of Haste/Critical Strike\nWeapons - Enchant Weapon - Mark of the Thunderlord"},
	{'Gems', "1 - Immaculate Haste Taladite\n2 - Greater Haste Taladite\n3 - Haste Taladite \n\n or \n\n1 - Immaculate Critical Strike Taladite\n2 - Greater Critical Strike Taladite\n3 - Critical Strike Taladite"},
	{'Talents', function(f)
		local Talents = {
			202296, -- Endless Rage
			103827, -- Double Time
			107574, -- Avatar
			208154, -- Warpaint
			202922, -- Carnage
			215573, -- Inner Rage
			46924, -- Bladestorm
		};
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',nil,nil,Talents,nil,nil)
	end},
	{'Rotation', function(f)
		local SingleTargetRotation = "1 - Rampage for Enrage or at max rage\n2 - Bloodthirst if you're not Enraged\n4 - Raging Blow\n5 - Furious Slash filler";
		local MultiTargetRotation = "1 - Whirlwind for Meat Cleaver\n2 - Rampage for Enrage or at max rage\n3 - Bloodthirst for Enrage\n4 - Whirlwind";
		local EffectiveCooldowns = "";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,nil)
	end},
	{'Buffs',function(f)
		local tips = "Haste Food:\nButtered Sturgeon = 125 Haste\nFrosty Stew = 100 Haste\n\nCritical Strike Food:\nPickled Eel = 125 Critical Strike\nBlackrock Barbecue = 100 Critical Strike\n\nFlask: \nGreater Draenic Strength Flask\n\nRune:\nStout Augment Rune\n\nPotion:\nDraenic Strength Potion";
		local tricks = "";
		return EDGE:FillTemplate(f,'Tips',tips,tricks)
		--TIPS_RETURN(tips,tricks)
	end},
	
});
-- 7.0
EDGE:Register('WARRIOR:PvE:Protection' ,{
	{'Stat Priority', "1 - Haste\n2 - Mastery\n3 - Versatility\n4 - Strength\n5 - Critical Strike"},
	{'Enchants', "Back - Enchant Cloak - Gift of Haste\nNeck - Enchant Neck - Gift of Haste\nRings - Enchant Ring - Gift of Haste\nWeapons - Enchant Weapon - Mark of Warsong"},
	{'Gems', "1 - Immaculate Haste Taladite\n2 - Greater Haste Taladite\n3 - Haste Taladite"},
	{'Talents', function(f)
		local Talents = {
			46968, -- Shockwave
			205484, -- Insipiring Presence
			107574, -- Avatar
			203201, -- Crackling Thunder
			202561, -- Never Surrender
			202572, -- Vengance
			152278, -- Anger Management
		};
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',nil,nil,Talents,nil,nil)
	end},
	{'Rotation', function(f)
		local SingleTargetRotation = "1 - Shield Slam\n2 - Revenge\n3 - Devastate as filler\n4 - Intercept nearby player (but don't turn boss around)";
		local MultiTargetRotation = "1 - Revenge\n2 - Thunder Clap\n3 - Shield Slam\n4 - Devastate as filler\n5 - Focused Rage";
		local EffectiveCooldowns = "";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,EffectiveCooldowns)
	end},
	{'Buffs',function(f)
		local tips = "Food:\nButtered Sturgeon = 125 Haste\nFrosty Stew = 100 Haste\n\nFlask: \nGreater Draenic Stamina Flask\n\nRune:\nStout Augment Rune\n\nPotion:\nDraenic Versatility Potion";
		local tricks = "";
		return EDGE:FillTemplate(f,'Tips',tips,tricks)
		--TIPS_RETURN(tips,tricks)
	end},
	
});
