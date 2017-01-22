local ADDON_NAME, EDGE = ...;
--[[
EDGE:Register('ROGUE:Leveling:Assassination' ,{
	{'Overview', "The Assassination spec is ideal for players that enjoy consistent damage in melee range, using daggers for the best attacks, and setting up a variety of debuffs."},
	{'Stat Priority', "Agility\nMultistrike\nCritical Strike >= Mastery\nVersatility >= Haste"},
	{'Enchants', "When leveling, unless you're an Enchanter with lots of mats, don't bother with Enchants. You'll have to add a new one too often with the amount you change gear while leveling."},
	{'Gems', "Do NOT use Gems until max level. Otherwise you're going to spend too much to make it worth gemming each item you can. "},
	{'Talents & Glyphs', function(f)
		local MajorGlyphs = {
			63249, -- Vendetta
			63254, -- Deadly Momentum
			63269, -- Elusiveness
		};
		local MinorGlyphs = {
			43379, -- Pick Pocket
			58038, -- Poisons
			58033, -- Safe Fall
		};
		local Talents = {
			108208, -- Subterfuge
			74001, -- Combat Readiness
			108211, -- Leeching Poison
			138106, -- Cloak and Dagger
			108216, -- Dirty Tricks
			114015, -- Anticipation
			152152, -- Venom Rush
		};
		local TalentTips = "The talents that are primarily utility-based are simply our general recommendation, your play style and raid needs should be priority when choosing these talents. The talent descriptions include some additional advice on when different utility talents are the most appropriate choice.";
		local GlyphTips = "Glyphs are situational, they depend on the make-up of your group as well as the enemies you're facing.That said, we suggest these because they seem to be all around the best for every situation.";
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',MajorGlyphs,MinorGlyphs,Talents,TalentTips,GlyphTips)
	end},
	{'Play Styles', function(f)
		local SingleTargetRotation = "Combo Point Builders:\nDispatch with a target below 35% health or Blindside procs.\nMutilate with a target above 35% health.\n\nFinishing Moves:\nRupture maintained with 5 CP and refreshed with <= 7 sec remaining.\nEnvenom to dump CP.\n\n\nThe Assassination DPS rotation revolves around maintaining Rupture while building and spending your Combo Points. To build Combo Points, you should use Dispatch when a target is below 35% health or Blindside procs. If Dispatch is not available, then you should use Mutilate to build Combo Points. After this, your top priority for spending Combo Points is to apply and maintain a 5 CP Rupture at all times, but try to only refresh the DoT with <= 7 sec remaining. Finally, dump your excess Combo Points into 5 CP Envenom.";
		local MultiTargetRotation = "Fan of Knives to build Combo Points.\nCrimson Tempest to spend Combo Points.\n\nWhen <= 3 targets, simply continue with the single target rotation but apply Rupture on each target. Between 4-5 targets, you should continue to apply Rupture to all targets and switch to Fan of Knives as your Combo Point builder. With 6+ targets, you should abandon the single target rotation and use Fan of Knives to build Combo Points and spend them on 5 CP Crimson Tempest.\n";
		local EffectiveCooldowns = "Preparation Use to reset the cooldown on Vanish.\nTricks of the Trade Use as directed by your raid/party leader.\nVanish Use to cast a cheap Mutilate. Reset with Preparation.\nVendetta Use on cooldown unless you will have to move during the buff.\n";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,EffectiveCooldowns)
	end},
	{'Tips & Tricks',function(f)
		local tips = "Poisons: Deadly Poison\ & Crippling Poison\n";
		local tricks = "You're leveling here, so be sure to take a gathering profssion, and pick up items to sell.\n Also be sure to kill everything you see as you go to and from quest areas etc.";
		--TIPS_RETURN(tips,tricks)
	end},
	
});

EDGE:Register('ROGUE:Leveling:Subtlety' ,{
	{'Overview', "The Subtlety spec is ideal for players that enjoy burst damage in melee range, attacking from Stealth, and setting up a variety of debuffs."},
	{'Stat Priority', "Agility\nMultistrike\nMastery\nCritical Strike >= Versatility >= Haste"},
	{'Enchants', "When leveling, unless you're an Enchanter with lots of mats, don't bother with Enchants. You'll have to add a new one too often with the amount you change gear while leveling."},
	{'Gems', "Do NOT use Gems until max level. Otherwise you're going to spend too much to make it worth gemming each item you can. "},
		{'Talents & Glyphs', function(f)
		local MajorGlyphs = {
			63254, -- Deadly Momentum
			42974, -- Sprint
			42960, -- Evasion
		};
		local MinorGlyphs = {
			58033, -- Safe Fall
			58038, -- Poisons
			43379, -- Blurred Speed
		};
		local Talents = {
			108208, -- Subterfuge
			74001, -- Combat Readiness
			108211, -- Leeching Poison
			138106, -- Cloak and Dagger
			108216, -- Dirty Tricks
			114015, -- Anticipation
			152152, -- venom Rush
		};
		local TalentTips = "The talents that are primarily utility-based are simply our general recommendation, your play style and raid needs should be priority when choosing these talents. The talent descriptions include some additional advice on when different utility talents are the most appropriate choice.";
		local GlyphTips = "Glyphs are situational, they depend on the make-up of your group as well as the enemies you're facing.That said, we suggest these because they seem to be all around the best for every situation.";
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',MajorGlyphs,MinorGlyphs,Talents,TalentTips,GlyphTips)
	end},
	{'Play Styles', function(f)
		local SingleTargetRotation = "Get in Stealth and open with Ambush Icon Ambush+Garrote Icon Garrote\nIf you did not use Premeditation Icon Premeditation, use Hemorrhage Icon Hemorrhage to build the remaining Combo Points\nSpend your Combo Points with Kidney Shot Icon Kidney Shot to stun the target\nGet behind the target and spam Backstab Icon Backstab\nIf the enemy is still alive, use Hemorrhage Icon Hemorrhage, Gouge Icon Gouge, and Backstab Icon Backstab again\nContinue with Hemorrhage Icon Hemorrhage to build Combo Points and Eviscerate Icon Eviscerate to spend them\n\n";
		local MultiTargetRotation = "If you are going to fight several mobs in a row, you need to apply Slice and Dice Icon Slice and Dice and Recuperate Icon Recuperate when you engage the first mob. Thanks to Glyph of Deadly Momentum Icon Glyph of Deadly Momentum, Slice and Dice Icon Slice and Dice and Recuperate Icon Recuperate will be automatically refreshed every time you kill a mob.\nOnly use Rupture Icon Rupture when fighting powerful enemies or dungeon bosses.\n";
		local EffectiveCooldowns = "You also have many abilities that you can use to avoid/mitigate damage: Evasion Icon Evasion, Feint Icon Feint (only works for AoE damage), Cloak of Shadows Icon Cloak of Shadows (improved by Glyph of Cloak of Shadows Icon Glyph of Cloak of Shadows), and Combat Readiness Icon Combat Readiness.\nYou can use Vanish Icon Vanish to disappear from your enemies' sight and Preparation Icon Preparation to reset Vanish's cooldown. Smoke Bomb Icon Smoke Bomb can also be used in conjunction with Sprint Icon Sprint to run away from a fight.\n";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,EffectiveCooldowns)
	end},
	{'Tips & Tricks',function(f)
		local tips = "Poisons: Deadly Poison, Leeching Poison\n\n";
		local tricks = "Remember to use Kick Icon Kick to interrupt harmful spell casts.\n\n Keep in mind that you're leveling so these few things always remember. Sell all items not green or above. For all those green items if you can't use em, send to AH character and sell em on the AH or use enchanting to get mats. Kill all mobs you see as you move between quests. Loot and sell everything possible. ";
		--TIPS_RETURN(tips,tricks)
	end},
	
});

EDGE:Register('ROGUE:Leveling:Combat' ,{
	{'Overview', "The Combat support spec is for players that enjoy utilizing consistent damage in melee range, recovering energy quickly, and having the survivability to take a few hits"},
	{'Stat Priority', "Agility\nMultistrike\nMastery\nCritical Strike >= Versatility >= Haste"},
	{'Enchants', "When leveling, unless you're an Enchanter with lots of mats, don't bother with Enchants. You'll have to add a new one too often with the amount you change gear while leveling."},
	{'Gems', "Do NOT use Gems until max level. Otherwise you're going to spend too much to make it worth gemming each item you can. "},
	{'Talents & Glyphs', function(f)
		local MajorGlyphs = {
			63254, -- Deadly Momentum
			42974, -- Sprint
			56806, -- Recuperate
		};
		local MinorGlyphs = {
			58038, -- Poisons
			43379, -- Blurred Speed
			58033, -- Safe Fall
		};
		local Talents = {
			108208, -- ShSubterfuge
			74001, -- Combat Readiness
			108211, -- Leeching Poison
			138106, -- Cloak and Dagger
			108216, -- Dirty Tricks
			114015, -- Anticipation
			152152, -- Venom Rush
		};
		local TalentTips = "Before setting out on your leveling journey, you should take these talents and glyphs, for maximum efficiency. Obviously, this is not set in stone, and you have a lot of liberty. Note that Tier 5 talents are practically useless outside of PvP. \nAt Level 90, you unlock your Tier 6 talents and we advise you to choose Anticipation Icon Anticipation. Marked for Death Icon Marked for Death works as well, but it has a higher skill cap.\n";
		local GlyphTips = "Glyphs are situational, they depend on the make-up of your group as well as the enemies you're facing.That said, we suggest these because they seem to be all around the best for every situation.";
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',MajorGlyphs,MinorGlyphs,Talents,TalentTips,GlyphTips)
	end},
	{'Play Styles', function(f)
		local SingleTargetRotation = "Build Combo Points with the following abilities (by order of priority).1.Cast Revealing Strike Icon Revealing Strike only to keep its debuff up.\nCast Sinister Strike Icon Sinister Strike.\nSpend Combo Points with Eviscerate Icon Eviscerate.\nThanks to Glyph of Deadly Momentum Icon Glyph of Deadly Momentum, you will be able to easily keep 100% uptime on both Slice and Dice Icon Slice and Dice and Recuperate Icon Recuperate (which is very helpful while leveling up). When you intend to fight several mobs in succession, you usually only need to apply Slice and Dice and Recuperate on the first mob you engage.\n";
		local MultiTargetRotation = "When you engage a target, you should always be in Stealth, so that you benefit from Subterfuge Icon Subterfuge. Open with Ambush Icon Ambush (cast it as many times as possible) and then execute the rotation given above. Apply Slice and Dice Icon Slice and Dice and Recuperate Icon Recuperate if they are not up and you are going to fight several enemies in a row.";
		local EffectiveCooldowns = "Leeching Poison and Recuperate will provide you with plenty of health regeneration.\nYou also have many abilities that you can use to avoid/mitigate damage: Evasion, Feint (only works for AoE damage), Cloak of Shadows (improved by Glyph of Cloak of Shadows), and Combat Readiness.\nYou can use Vanish to disappear from your enemies' sight and Preparation to reset Vanish's cooldown. Smoke Bomb can also be used in conjunction with Sprint to run away from a fight.\nRemember to use Kick to interrupt harmful spell casts.\n";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,EffectiveCooldowns)
	end},
	{'Tips & Tricks',function(f)
		local tips = "Rogues are not very well equipped for dealing with several targets at a time, so you should try, as much as possible, to pull mobs one by one.\nPoisons: Deadly Poison, Leeching Poison\n";
		local tricks = "When you want to kill mobs faster, activate Adrenaline Rush and Killing Spree.";
		--TIPS_RETURN(tips,tricks)
	end},
	
});

EDGE:Register('ROGUE:PvP:Subtlety' ,{
	{'Overview', "This is the base setup for a PVP Subtlety Rogue. All of the spells, skills, and talents are geared toward figting in a PVP environment."},
	{'Stat Priority', "Multistrike\nAgility = PvP Power\nCritical Strike\nVersatility\nMastery\nHaste"},
	{'Enchants', "Neck: Gift of Multistrike\nCloak: Gift of Multistrike\nRing: Gift of Multistrike\nWeapon: Mark of the Frostwolf"},
	{'Gems', "Greater Multistrike Taladite"},
	{'Talents & Glyphs', function(f)
		local MajorGlyphs = {
			91299, -- Glyph of Blind
			56801, -- Glyph of Cheap Shot
			56812, -- Glyph of Garrote
		};
		local MinorGlyphs = {
			56800, -- Glyph of Decoy
			58032, -- Glyph of Distract
			58038, -- Glyph of Poisons
		};
		local Talents = {
			108208, -- Subterfuge
			108210, -- Nerve Strike
			79008, -- Elusiveness
			36554, -- Shadowstep
			131511, -- Prey on the Weak
			137619, -- Marked for Death
			152150, -- Death from Above
		};
		local TalentTips = "The talents that are primarily utility-based are simply our general recommendation, your play style and raid needs should be priority when choosing these talents. The talent descriptions include some additional advice on when different utility talents are the most appropriate choice.";
		local GlyphTips = "Glyphs are situational, they depend on the make-up of your group as well as the enemies you're facing.That said, we suggest these because they seem to be all around the best for every situation.";
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',MajorGlyphs,MinorGlyphs,Talents,TalentTips,GlyphTips)
	end},
	{'Play Styles', function(f)
		local SingleTargetRotation = "There is no PvP “rotation.” Try to lock up your opponents and burst them down when you can.\nGlyphed Garrote silences casters\nKeep Recuperate up, as necessary.\nTry to keep Slice and Dice up, it’s what drives your energy returns via the Energetic Recovery ability.\nRupture/garrote is good Vs stealthers.\nLearn to use Shadowdance. The training dummies will help with this.\nSave your Shadowstep, if possible, until the opponent escapes (eg: Blink,) then use it to catch up.\n";
		local MultiTargetRotation = "Text\n";
		local EffectiveCooldowns = "Text\n";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,EffectiveCooldowns)
	end},
	{'Tips & Tricks',function(f)
		local tips = "Keep in mind, Talents and Rotations are much more fluid that while playing PvE stuff. You can pretty well use what you think is best over talents and glyphs, we've put here what the best PvPer's in the game use. ";
		local tricks = "Poisons: Deadly Poison, Leeching or Paralytic Poison.";
		--TIPS_RETURN(tips,tricks)
	end},
	
});

EDGE:Register('ROGUE:PvP:Combat' ,{
	{'Overview', "This is the base setup for a PVP combat Rogue. All of the spells, skills, and talents are geared toward figting in a PVP environment."},
	{'Stat Priority', "Multistrike >= Agility = PvP Power\nVersatility\nCritical Strike\nHaste\nMastery"},
	{'Enchants', "Neck: Gift of Multistrike\nCloak: Gift of Multistrike\nRing: Gift of Multistrike\nWeapon: Mark of the Thunderlord"},
	{'Gems', "Greater Multistrike Taladite"},
	{'Talents & Glyphs', function(f)
		local MajorGlyphs = {
			91299, -- Glyph of Blind
			56801, -- Glyph of Cheap Shot
			56812, -- Glyph of Garrote
		};
		local MinorGlyphs = {
			56800, -- Glyph of Decoy
			58032, -- Glyph of Distract
			58038, -- Glyph of Poisons
		};
		local Talents = {
			108208, -- Subterfusge
			108210, -- Nerve Strike
			79008, -- Elusiveness
			36554, -- Shadowstep
			131511, -- Prey on the Weak
			137619, -- Marked for Death
			152150, -- Death from Above
		};
		local TalentTips = "The talents that are primarily utility-based are simply our general recommendation, your play style and raid needs should be priority when choosing these talents. The talent descriptions include some additional advice on when different utility talents are the most appropriate choice.";
		local GlyphTips = "Glyphs are situational, they depend on the make-up of your group as well as the enemies you're facing.That said, we suggest these because they seem to be all around the best for every situation.";
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',MajorGlyphs,MinorGlyphs,Talents,TalentTips,GlyphTips)
	end},
	{'Play Styles', function(f)
		local SingleTargetRotation = "There is no PvP “rotation.” Try to lock up your opponents and burst them down when you can.";
		local MultiTargetRotation = "Glyphed Garrote silences casters\nKeep Recuperate up, as necessary.\nTry to keep Slice and Dice up, it’s what drives your energy returns via the Energetic Recovery ability.";
		local EffectiveCooldowns = "Save your Shadowstep, if possible, until the opponent escapes (eg: Blink,) then use it to catch up.";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,EffectiveCooldowns)
	end},
	{'Tips & Tricks',function(f)
		local tips = "Poisons: Deadly Poison and Leeching Poison or Paralytic Poison\n";
		local tricks = "Learn to use Shadowdance. The training dummies will help with this.";
		--TIPS_RETURN(tips,tricks)
	end},
	
});

EDGE:Register('ROGUE:PvP:Assassination' ,{
	{'Overview', "TEXT"},
	{'Stat Priority', "StatList\n"},
	{'Enchants', "Neck: \nCloak: \nRing: \nWeapon: "},
	{'Gems', ""},
	{'Talents & Glyphs', function(f)
		local MajorGlyphs = {
			91299, -- Glyph of Blind
			56801, -- Glyph of Cheap Shot
			56812, -- Glyph of Garrote
		};
		local MinorGlyphs = {
			56800, -- Glyph of Decoy
			58032, -- Glyph of Distract
			58038, -- Glyph of Poisons
		};
		local Talents = {
			108208, -- Subterfuge
			108210, -- Nerve Strike
			79008, -- Elusiveness
			36554, -- Shadowstep
			131511, -- Prey on the Weak
			137619, -- Marked for Death
			152150, -- Death from Above
		};
		local TalentTips = "The talents that are primarily utility-based are simply our general recommendation, your play style and raid needs should be priority when choosing these talents. The talent descriptions include some additional advice on when different utility talents are the most appropriate choice.";
		local GlyphTips = "Glyphs are situational, they depend on the make-up of your group as well as the enemies you're facing.That said, we suggest these because they seem to be all around the best for every situation.";
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',MajorGlyphs,MinorGlyphs,Talents,TalentTips,GlyphTips)
	end},
	{'Play Styles', function(f)
		local SingleTargetRotation = "There is no PvP “rotation.” Try to lock up your opponents and burst them down when you can.";
		local MultiTargetRotation = "Glyphed Garrote silences casters\nKeep Recuperate up, as necessary.\nTry to keep Slice and Dice up, it’s what drives your energy returns via the Energetic Recovery ability.";
		local EffectiveCooldowns = "Save your Shadowstep, if possible, until the opponent escapes (eg: Blink,) then use it to catch up.";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,EffectiveCooldowns)
	end},
	{'Tips & Tricks',function(f)
		local tips = "Poisons: Deadly Poison and Leeching Poison or Paralytic Poison\n";
		local tricks = "Learn to use Shadowdance. The training dummies will help with this.";
		--TIPS_RETURN(tips,tricks)
	end},
	
});
]]
EDGE:Register('ROGUE:Leveling:Outlaw' ,{
	{'Stat Priority', "1 - Agility\n2 - Haste\n3 - Mastery\n4 - Critical Strike\n5 - Versatility"},
	{'Talents', function(f)
		local Talents = {
			196938, -- Quick Draw
			195457, -- Grappling Hook
			193531, -- Deeper Stratagem
			193546, -- Iron Stomach*
			108216, -- Dirty Tricks*
			185767, -- Cannonball Barrage*
			137619, -- Marked for Death
		};
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',nil,nil,Talents,nil,nil)
	end},
	{'Rotation', function(f)
		local SingleTargetRotation = "- Marked for Death target\n- Do not use Roll the Bones to hunt for the best buffs\n- Cannonball Barrage for big burst";
		local MultiTargetRotation = "";
		local EffectiveCooldowns = "";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,nil)
	end},
	{'Buffs',function(f)
		local tips = "Guild Banners:\nBattle Standard of Cooperation\nStandard of Unity\nBattle Standard of Coordination\n\nFood:\nButtered Sturgeon = 125 Haste\nFrosty Stew = 100 Haste\n\nFlask: \nGreater Draenic Agility Flask\n\nRune:\nHyper Augment Rune\n\nPotion:\nDraenic Agility Potion";
		local tricks = "";
		return EDGE:FillTemplate(f,'Tips',tips,tricks)
		--TIPS_RETURN(tips,tricks)
	end},
	
});

EDGE:Register('ROGUE:PvE:Assassination' ,{
	{'Stat Priority', "1 - Agility\n2 - Versatility\n3 - Critical Strike\n4 - Mastery\n5 - Haste"},
	{'Enchants', "Back - Enchant Cloak - Gift of Versatility\nNeck - Enchant Neck - Gift of Versatility\nRings - Enchant Ring - Gift of Versatility\nWeapons - Enchant Weapon - Mark of the Shadowmoon"},
	{'Gems', "1 - Immaculate Versatility Taladite\n2 - Greater Versatility Taladite\n3 - Versatility Taladite"},
	{'Talents', function(f)
		local Talents = {
			16511, -- Hemorrhage
			14062, -- Nightstalker
			193531, -- Deeper Strategem
			31230, -- Cheat Death
			131511, -- Prey on the Weak
			200806, -- Exsanguinate
			152152, -- Venom Rush
		};
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',nil,nil,Talents,nil,nil)
	end},
	{'Rotation', function(f)
		local SingleTargetRotation = "1 - Rupture\n2 - Vendetta\n3 - Vanish then Rupture\n4 - Hemorrhage\n5 - Garrote\n6 - Exsanguinate\n7 - Envenom\n8 - Mutilate";
		local MultiTargetRotation = "";
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
-- 7.0
EDGE:Register('ROGUE:PvE:Outlaw' ,{
	{'Stat Priority', "1 - Agility\n2 - Haste\n3 - Mastery\n4 - Critical Strike\n5 - Versatility"},
	{'Enchants', "Back - Enchant Cloak - Gift of Haste\nNeck - Enchant Neck - Gift of Haste\nRings - Enchant Ring - Gift of Haste\nWeapons - Enchant Weapon - Mark of the Warsong"},
	{'Gems', "1 - Immaculate Haste Taladite\n2 - Greater Haste Taladite\n3 - Haste Taladite"},
	{'Talents', function(f)
		local Talents = {
			196938, -- Quick Draw
			195457, -- Grappling Hook
			193531, -- Deeper Stratagem
			31230, -- Cheat Death
			131511, -- Prey on the Weak
			193539, -- Alacrity
			137619, -- Marked for Death
		};
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',nil,nil,Talents,nil,nil)
	end},
	{'Rotation', function(f)
		local SingleTargetRotation = "1 - Maintain Roll the Bones\n2 - Adrenaline Rush\n3 - Marked for Death (With 0 or 1 combo point\n4 - Run Through at 5-6 Combo Points\n5 - Run Through (6 points)\n6 - Pistol Shot with Opportunity proc\n7 - Saber Slash";
		local MultiTargetRotation = "";
		local EffectiveCooldowns = "";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,nil)
	end},
	{'Buffs',function(f)
		local tips = "Food:\nButtered Sturgeon = 125 Haste\nFrosty Stew = 100 Haste\n\nFlask: \nGreater Draenic Agility Flask\n\nRune:\nHyper Augment Rune\n\nPotion:\nDraenic Agility Potion";
		local tricks = "";
		return EDGE:FillTemplate(f,'Tips',tips,tricks)
		--TIPS_RETURN(tips,tricks)
	end},
	
});
-- 7.0
EDGE:Register('ROGUE:PvE:Subtlety' ,{
	{'Stat Priority', "1 - Agility\n2 - Versatility\n3 - Critical Strike\n4 - Mastery\n5 - Haste"},
	{'Enchants', "Back - Enchant Cloak - Gift of Versatility\nNeck - Enchant Neck - Gift of Versatility\nRings - Enchant Ring - Gift of Versatility\nWeapons - Enchant Weapon - Mark of Shadowmoon"},
	{'Gems', "1 - Immaculate Versatility Taladite\n2 - Greater Versatility Taladite\n3 - Versatility Taladite"},
	{'Talents', function(f)
		local Talents = {
			31223, -- Master of Subtlety
			108208, -- Subterfuge
			14983, -- Vigor
			79008, -- Elusiveness
			196951, -- Strike from the Shadows
			196979, -- Premeditation
			196976, -- Master of Shadows
		};
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',nil,nil,Talents,nil,nil)
	end},
	{'Rotation', function(f)
		local SingleTargetRotation = "1 - Symbols of Death buff maintained\n2 - Shadow Blades\n3 - Vanish then Shadowstrike\n4 - Maintain Nightblade\n5 - Shadow Dance with 2+ charges\n6 - Eviscerate\n7 - Backstab for combo points";
		local MultiTargetRotation = "";
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