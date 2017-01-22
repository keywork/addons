local ADDON_NAME, EDGE = ...;
--[[
EDGE:Register('HUNTER:Leveling:Beast Mastery' ,{
	{'Overview', "In this guide, we will offer you some quick and practical information for leveling up your Hunter from level 85 to level 100. We cover rotation, talents and glyphs. We do not, however, cover statistics, gear, or any information about the zones you should be questing in."},
	{'Stat Priority', "Agility\nMultistrike\nMastery >= Critical Strike >= Versatility\nHaste"},
	{'Enchants', "When leveling, unless you're an Enchanter with lots of mats, don't bother with Enchants. You'll have to add a new one too often with the amount you change gear while leveling."},
	{'Gems', "Do NOT use Gems until max level. Otherwise you're going to spend too much to make it worth gemming each item you can. "},
	{'Talents & Glyphs', function(f)
		local MajorGlyphs = {
			42902, -- Endless Wrath
			56829, -- Misdirection
			56833, -- Mending
		};
		local MinorGlyphs = {
			119462, -- Aspect of the Cheetah
			87393, -- Fetch
			159459, -- Play Dead
		};
		local Talents = {
			109215, -- Post Haste
			19577, -- Intimidation
			109212, -- Spirit Bond
			109306, -- Thrill of the hunt
			130392, -- Blink Strikes
			117050, -- Glaive Toss
			152244, -- Adaptation
		};
		local TalentTips = "The talents that are primarily utility-based are simply our general recommendation, your play style and raid needs should be priority when choosing these talents. The talent descriptions include some additional advice on when different utility talents are the most appropriate choice.";
		local GlyphTips = "Glyphs are situational, they depend on the make-up of your group as well as the enemies you're facing.That said, we suggest these because they seem to be all around the best for every situation.";
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',MajorGlyphs,MinorGlyphs,Talents,TalentTips,GlyphTips)
	end},
	{'Play Styles', function(f)
		local SingleTargetRotation = "Kill Command: on Cooldown\nCobra Shot: Generate Focus\nArcane Shot: Dump Focus\nKill Shot: When target is below 20% health.";
		local MultiTargetRotation = "Replace Arcane shot with Multi-Shot in single target rotation.";
		local EffectiveCooldowns = "Focus Fire: Use when pet has 5 stacks of Frenzy\nBestial Wrath: Use on coolown or save for powerful targets.\nDeterrence: Reduces Incoming Damage.\nDisengage: Quickly gets you out of danger.\nMend Pet: Keep your pet alive!";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,EffectiveCooldowns)
	end},
	{'Tips & Tricks', function(f)
		local tips = nil;
		local tricks = nil;
		--TIPS_RETURN(tips,tricks)
	end},
	
});

EDGE:Register('HUNTER:Leveling:Marksmanship' ,{
	{'Overview', "The Marksmanship spec is ideal for players that enjoy burst damage at ranged, decent survivability, and a more focused rotation."},
	{'Stat Priority', "Agility\nMultistrike\nCritical Strike >= Versatility\nHaste = Mastery"},
	{'Enchants', "When leveling, unless you're an Enchanter with lots of mats, don't bother with Enchants. You'll have to add a new one too often with the amount you change gear while leveling."},
	{'Gems', "Do NOT use Gems until max level. Otherwise you're going to spend too much to make it worth gemming each item you can. "},
	{'Talents & Glyphs', function(f)
		local MajorGlyphs = {
			20895, -- Chimaera Shot
			56829, -- Misdirection
			119447, -- Mending
		};
		local MinorGlyphs = {
			119462, -- Aspect of the Cheetah
			87393, -- Fetch
			159459, -- Play Dead
		};
		local Talents = {
			109215, -- Posthaste
			19577, -- Intimidation
			109212, -- Spirit Bond
			109306, -- STrhill of the Hunt
			130392, -- Blink Strikes
			117050, -- Glaive Toss
			155228, -- Lone Wolf
		};
		local TalentTips = "The talents that are primarily utility-based are simply our general recommendation, your play style and raid needs should be priority when choosing these talents. The talent descriptions include some additional advice on when different utility talents are the most appropriate choice.";
		local GlyphTips = "Glyphs are situational, they depend on the make-up of your group as well as the enemies you're facing.That said, we suggest these because they seem to be all around the best for every situation.";
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',MajorGlyphs,MinorGlyphs,Talents,TalentTips,GlyphTips)
	end},
	{'Play Styles', function(f)
		local SingleTargetRotation = "Chimaera Shot: On Cooldown\nSteady Shot: Generate Focus\nAimed Shot: Dump Focus\nKill Shot: When target is below 20% health";
		local MultiTargetRotation = "Replace Aimed Shot with Multi-shot in the single target rotation.";
		local EffectiveCooldowns = "Rapid Fire: Use on cooldown.\nDeterrence: Reduce incoming damage\nDisengage: Get out of danger fast.\nMend Pet: Heal your pet man!";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,EffectiveCooldowns)
	end},
	{'Tips & Tricks',function(f)
		local tips = "";
		local tricks = "";
		--TIPS_RETURN(tips,tricks)
	end},
	
});

EDGE:Register('HUNTER:Leveling:Survival' ,{
	{'Overview', "The Survival spec is ideal for players that enjoy sustained damage at ranged, excellent survivability, and a variety of utility options."},
	{'Stat Priority', "Agility\nMultistrike\nCritical Strike >= Versatility\nMastery >= Haste"},
	{'Enchants', "When leveling, unless you're an Enchanter with lots of mats, don't bother with Enchants. You'll have to add a new one too often with the amount you change gear while leveling."},
	{'Gems', "Do NOT use Gems until max level. Otherwise you're going to spend too much to make it worth gemming each item you can. "},
	{'Talents & Glyphs', function(f)
		local MajorGlyphs = {
			20895, -- Animal Bond
			56829, -- Misdirection
			119447, -- Mending
		};
		local MinorGlyphs = {
			119462, -- Aspect of the Cheetah
			87393, -- Fetch
			159459, -- Play Dead
		};
		local Talents = {
			109215, -- Posthaste
			19577, -- Intimidation
			109212, -- Spirit Bond
			109306, -- STrhill of the Hunt
			130392, -- Blink Strikes
			117050, -- Glaive Toss
			155228, -- Lone Wolf
		};
		local TalentTips = "The talents that are primarily utility-based are simply our general recommendation, your play style and raid needs should be priority when choosing these talents. The talent descriptions include some additional advice on when different utility talents are the most appropriate choice.";
		local GlyphTips = "Glyphs are situational, they depend on the make-up of your group as well as the enemies you're facing.That said, we suggest these because they seem to be all around the best for every situation.";
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',MajorGlyphs,MinorGlyphs,Talents,TalentTips,GlyphTips)
	end},
	{'Play Styles', function(f)
		local SingleTargetRotation = "Explosive Shot: on cooldown and Lock and Load procs.\nBlack Arrow on target if they will live longer than 12 seconds.\nCobra Shot: Generate focus\nArcane Shot: Dump Focus";
		local MultiTargetRotation = "Replace Arcane Shot with Multi-shot and place explosive traps as well as the single target rotation.";
		local EffectiveCooldowns = "Deterrence: Reduce incoming damage.\nDisengage: Get out of danger fast.\nMend Pet: Keep your pet healthy!";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,EffectiveCooldowns)
	end},
	{'Tips & Tricks',function(f)
		local tips = "";
		local tricks = "";
		--TIPS_RETURN(tips,tricks)
	end},
	
});

EDGE:Register('HUNTER:PvP:Beast Mastery' ,{
	{'Overview', "This is the base setup for a Beast Master Hunter in PvP. It's set to give you the best chance of succeeding in any PVP environment."},
	{'Stat Priority', "Multistrike >= Agility = PvP Power\nVersatility\nCritical Strike\nMastery\nHaste"},
	{'Enchants', "Neck: Gift of Multistrike\nCloak: Gift of Multistrike\nRing: Gift of Multistrike\nWeapon: Oglethorpe's Missile Splitter"},
	{'Gems', "Greater Multistrike Taladite"},
	{'Talents & Glyphs', function(f)
		local MajorGlyphs = {
			20895, -- Glyph of Animal Bond
			42908, -- Glyph of Explosive Trap
			42917, -- Glyph of Solace
		};
		local MinorGlyphs = {
			57866, -- Glyph of Revive Pet
			125042, -- Glyph of Aspect of the Beast
			119462, -- Glyph of Aspect of the Cheetah
		};
		local Talents = {
			109298, -- Narrow Escape
			19386, -- Wyvern Sting
			109260, -- Iron Hawk
			109306, -- Thrill of the Hunt
			131894, -- A Murder of rows
			117050, -- Glaive Toss
			152244, -- Adaptation
		};
		local TalentTips = "The talents that are primarily utility-based are simply our general recommendation, your play style and raid needs should be priority when choosing these talents. The talent descriptions include some additional advice on when different utility talents are the most appropriate choice.";
		local GlyphTips = "Animal Bond: Boost Survivability\nExplosive Trap: adds knockback.\nSolace: Crowd Control helper.\nMinor:\nRevive Pet: No more Pushback\nAspect of the Beast\nMakes you Untrackable\nAspect of the Cheetah: No more daze.";
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',MajorGlyphs,MinorGlyphs,Talents,TalentTips,GlyphTips)
	end},
	{'Play Styles', function(f)
		local SingleTargetRotation = "Knowing your spells and when to cast them as well as what they do is the best rotation you can have. Especially in PvP! Know your spells";
		local MultiTargetRotation = "See Single Target Rotation";
		local EffectiveCooldowns = "See Single Target Rotation";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,EffectiveCooldowns)
	end},
	{'Tips & Tricks',function(f)
		local tips = "";
		local tricks = "";
		--TIPS_RETURN(tips,tricks)
	end},
	
});

EDGE:Register('HUNTER:PvP:Marksmanship' ,{
	{'Overview', "TEXT"},
	{'Stat Priority', "Multistrike\nAgility = PvP Power\nVersatility\nMastery\nCritical Strike\nHaste"},
	{'Enchants', "Neck: Gift of Multistrike\nCloak: Gift of Multistrike\nRing: Gift of Multistrike\nWeapon: Oglethorpe's Missile Splitter"},
	{'Gems', "Greater Multistrike Taladite"},
	{'Talents & Glyphs', function(f)
		local MajorGlyphs = {
			20895, -- Glyph of Animal Bond
			42908, -- Glyph of Explosive Trap
			42917, -- Glyph of Solace
		};
		local MinorGlyphs = {
			57866, -- Glyph of Revive Pet
			125042, -- Glyph of Aspect of the Beast
			119462, -- Glyph of Aspect of the Cheetah
		};
		local Talents = {
			109298, -- Narrow Escape
			19386, -- Wyvern Sting
			109260, -- Iron Hawk
			109306, -- Thrill of the Hunt
			131894, -- A Murder of rows
			117050, -- Glaive Toss
			155228, -- Lone Wolf
		};
		local TalentTips = "The talents that are primarily utility-based are simply our general recommendation, your play style and raid needs should be priority when choosing these talents. The talent descriptions include some additional advice on when different utility talents are the most appropriate choice.";
		local GlyphTips = "Glyphs are situational, they depend on the make-up of your group as well as the enemies you're facing.That said, we suggest these because they seem to be all around the best for every situation.";
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',MajorGlyphs,MinorGlyphs,Talents,TalentTips,GlyphTips)
	end},
	{'Play Styles', function(f)
		local SingleTargetRotation = "Knowing your spells and when to cast them as well as what they do is the best rotation you can have. Especially in PvP! Know your spells";
		local MultiTargetRotation = "See Single Target Rotation";
		local EffectiveCooldowns = "See Single Target Rotation";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,EffectiveCooldowns)
	end},
	{'Tips & Tricks',function(f)
		local tips = "";
		local tricks = "";
		--TIPS_RETURN(tips,tricks)
	end},
	
});

EDGE:Register('HUNTER:PvP:Survival' ,{
	{'Overview', "This is the base setup for a Survival Hunter in PvP. It's set to give you the best chance of succeeding in any PVP environment."},
	{'Stat Priority', "Multistrike\nAgility = PvP Power\nVersatility\nCritical Strike\nHaste\nMastery"},
	{'Enchants', "Neck: Gift of Multistrike\nCloak: Gift of Multistrike\nRing: Gift of Multistrike\nWeapon: Oglethorpe's Missile Splitter"},
	{'Gems', "Greater Multistrike Taladite"},
	{'Talents & Glyphs', function(f)
		local MajorGlyphs = {
			20895, -- Glyph of Animal Bond
			132106, -- Glyph of Liberation
			42917, -- Glyph of Solace
		};
		local MinorGlyphs = {
			57866, -- Glyph of Revive Pet
			125042, -- Glyph of Aspect of the Beast
			119462, -- Glyph of Aspect of the Cheetah
		};
		local Talents = {
			109298, -- Narrow Escape
			19386, -- Wyvern Sting
			109260, -- Iron Hawk
			109306, -- Thrill of the Hunt
			131894, -- A Murder of rows
			117050, -- Glaive Toss
			162534, -- Exotic Munitions
		};
		local TalentTips = "The talents that are primarily utility-based are simply our general recommendation, your play style and raid needs should be priority when choosing these talents. The talent descriptions include some additional advice on when different utility talents are the most appropriate choice.";
		local GlyphTips = "Glyphs are situational, they depend on the make-up of your group as well as the enemies you're facing.That said, we suggest these because they seem to be all around the best for every situation.";
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',MajorGlyphs,MinorGlyphs,Talents,TalentTips,GlyphTips)
	end},
	{'Play Styles', function(f)
		local SingleTargetRotation = "Knowing your spells and when to cast them as well as what they do is the best rotation you can have. Especially in PvP! Know your spells";
		local MultiTargetRotation = "See Single Target Rotation";
		local EffectiveCooldowns = "See Single Target Rotation";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,EffectiveCooldowns)
	end},
	{'Tips & Tricks',function(f)
		local tips = "";
		local tricks = "";
		--TIPS_RETURN(tips,tricks)
	end},
	
});
]]
EDGE:Register('HUNTER:Leveling:Marksmanship' ,{
	{'Stat Priority', "Agility\nMastery\nHaste\nVersatility\nCritical Strike"},
	{'Talents', function(f)
		local Talents = {
			155228, -- Lone Wolf
			194599, -- Black Arrow*
			109215, -- Posthaste
			213423, -- Patient Sniper
			199483, -- Camouflage*
			120360, -- Barrage
			214579, -- Sidewinders
		};
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',nil,nil,Talents,nil,nil)
	end},
	{'Rotation', function(f)
		local SingleTargetRotation = "1 - Barrage\n2 - Sidewinders (Avoid reaching 2 charges)\n3 - Black Arrow\n4 - Marked Shot\n5 - Aimed Shot";
		local MultiTargetRotation = "Sidewinders!";
		local EffectiveCooldowns = "";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,nil)
	end},
	{'Buffs',function(f)
		local tips = "Guild Banners:\nBattle Standard of Cooperation\nStandard of Unity\nBattle Standard of Coordination\n\nFood:\nSleeper Sushi = 125 Mastery\nSleeper Surprise = 100 Mastery\n\nFlask: \nGreater Draenic Agility Flask\n\nRune:\nHyper Augment Rune\n\nPotion:\nDraenic Agility Potion";
		local tricks = "";
		return EDGE:FillTemplate(f,'Tips',tips,tricks)
		--TIPS_RETURN(tips,tricks)
	end},
	
});

EDGE:Register('HUNTER:PvE:Beast Mastery' ,{
	{'Stat Priority', "Agility\nHaste\nVersatility\nMastery\nCritical Strike"},
	{'Enchants', "Neck: Gift of Haste\nCloak: Gift of Haste\nRing: Gift of Haste\nWeapon: Oglethorpe's Missile Splitter"},
	{'Gems', "Immaculate Haste Taladite\nGreater Haste Taladite\nHaste Strike Taladite"},
	{'Talents', function(f)
		local Talents = {
			204308, -- Big Game Hunter
			199530, -- Stomp
			109215, -- Posthaste
			194306, -- Bestial Fury
			109248, -- Binding Shot
			131894, -- A Murder of Crows
			201430, -- Stampede
		};
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',nil,nil,Talents,nil,nil)
	end},
	{'Rotation', function(f)
		local SingleTargetRotation = "1 - Kill Command\n2 - Dire Beast or Dire Frenzy\n3 - Cobra Shot";
		local MultiTargetRotation = "1 - Multi-Shot to give pet Beast Cleave\n2 - Kill Command\n3 - Kill Command\n4 - Dire Beast or Dire Frenzy";
		local EffectiveCooldowns = "";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,nil)
	end},
	{'Buffs',function(f)
		local tips = "Food:\nButtered Sturgeon = 125 Haste\nFrosty Stew = 100 Haste\n\nFlask: \nGreater Draenic Agility Flask \n\nRune:\nHyper Augment Rune\n\nPotion:\nDraenic Agility Potion";
		local tricks = "";
		return EDGE:FillTemplate(f,'Tips',tips,tricks)
		--TIPS_RETURN(tips,tricks)
	end},
	
});
-- 7.0
EDGE:Register('HUNTER:PvE:Marksmanship' ,{
	{'Stat Priority', "Agility\nMastery\nHaste\nVersatility\nCritical Strike"},
	{'Enchants', "Neck: Gift of Mastery\nCloak: Gift of Mastery\nRing: Gift of Mastery\nWeapon: Hemet's Heartseeker"},
	{'Gems', "Immaculate Haste Taladite\nGreater Haste Taladite\nHaste Taladite"},
	{'Talents', function(f)
		local Talents = {
			155228, -- Lone Wolf
			194595, -- Lock and Load
			109215, -- Posthaste
			213423, -- Patient Sniper
			109248, -- Binding Shot
			120360, -- Barrage
			214579, -- Sidewinders
		};
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',nil,nil,Talents,nil,nil)
	end},
	{'Rotation', function(f)
		local SingleTargetRotation = "1 - Marked Shot\n2 - Barrage\n3 - Aimed Shot\n4 - Sidewinders (Avoid reaching 2 charges)";
		local MultiTargetRotation = "Sidewinders!";
		local EffectiveCooldowns = "";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,nil)
	end},
	{'Buffs',function(f)
		local tips = "Food:\nSleeper Sushi = 125 Mastery\nSleeper Surprise = 100 Mastery\n\nFlask: \nGreater Draenic Agility Flask\n\nRune:\nHyper Augment Rune\n\nPotion:\nDraenic Agility Potion";
		local tricks = "";
		return EDGE:FillTemplate(f,'Tips',tips,tricks)
		--TIPS_RETURN(tips,tricks)
	end},
	
});
-- 7.0
EDGE:Register('HUNTER:PvE:Survival' ,{
	{'Stat Priority', "Agility\nVersatility\nCritical Strike\nHaste\nMastery"},
	{'Enchants', "Neck: Gift of Versatility\nCloak: Gift of Versatility\nRing: Gift of Versatility\nWeapon: Mark of Shadowmoon"},
	{'Gems', "Immaculate Versatility Taladite\nGreater Versatility Taladite\nVersatility Taladite"},
	{'Talents', function(f)
		local Talents = { -- Talents
			201082, -- Way of the Mok'Nathal
			201078, -- Snake Hunter
			109215, -- Posthaste
			199518, -- Improved Traps
			200108, -- Ranger's Net
			194855, -- Dragonsfire Grenade
			199543, -- Expert Trapper
		};
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',nil,nil,Talents,nil,nil)
	end},
	{'Rotation', function(f)
		local SingleTargetRotation = "1 - Explosive Trap\n2 - Dragonsfire Grenade\n3 - Lacerate\n4 - Mongoose Bite\n5 - Flanking Strike (Focus Dump)";
		local MultiTargetRotation = "2-3 Targets:\n1 - Butchery\n2 - Single Target rotation\n\n4+ Targets:\n1 - Butchery\n1 - Carve";
		local EffectiveCooldowns = "";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,nil)
	end},
	{'Buffs',function(f)
		local tips = "Food:\nJumbo Sea Dog = 125 Versatility\nGorgrond Chowder = 100 Versatility\n\nFlask: \nGreater Draenic Agility Flask\n\nRune:\nHyper Augment Rune\n\nPotion:\nDraenic Agility Potion";
		local tricks = "";
		return EDGE:FillTemplate(f,'Tips',tips,tricks)
		--TIPS_RETURN(tips,tricks)
	end},
	
});

