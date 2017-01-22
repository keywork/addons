local ADDON_NAME, EDGE = ...;
--[[
EDGE:Register('SHAMAN:Leveling:Elemental' ,{
	{'Overview', "The Elemental spec is ideal for players that enjoy consistent spell damage from range, a variety of support tools, and some light spot healing. "},
	{'Stat Priority', "Intellect\nMultistrike\nCritical Strike\nHaste >= Mastery\nVersatility"},
	{'Enchants', "When leveling, unless you're an Enchanter with lots of mats, don't bother with Enchants. You'll have to add a new one too often with the amount you change gear while leveling."},
	{'Gems', "Do NOT use Gems until max level. Otherwise you're going to spend too much to make it worth gemming each item you can. "},
	{'Talents & Glyphs', function(f)
		local MajorGlyphs = {
			55446, -- Spiritwalkers Grace
			55449, -- Chain LIghtning
			55455, -- Fire Elemental Totem
		};
		local MinorGlyphs = {
			43381, -- Astral Recall
			55448, -- Lakestrider
			58135, -- Spectral Wolf
		};
		local Talents = {
			108271, -- Astral Shift
			51485, -- Earthgrab Totem
			108285, -- Call of the Elements
			16188, -- Ancestral Switftness
			108281, -- Ancestral Guidance
			165477, -- Unleashed Fury
			152256, -- Storm Elemental Totem
		};
		local TalentTips = "The talents that are primarily utility-based are simply our general recommendation, your play style and raid needs should be priority when choosing these talents. The talent descriptions include some additional advice on when different utility talents are the most appropriate choice.";
		local GlyphTips = "Glyphs are situational, they depend on the make-up of your group as well as the enemies you're facing.That said, we suggest these because they seem to be all around the best for every situation.";
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',MajorGlyphs,MinorGlyphs,Talents,TalentTips,GlyphTips)
	end},
	{'Play Styles', function(f)
		local SingleTargetRotation = "Keep Flame Shock Icon Flame Shock up on the target. Refresh when there are 3 seconds or less left.\nCast Lava Burst Icon Lava Burst on cooldown?watch out for its cooldown being reset by procs of Lava Surge Icon Lava Surge.\nCast Earth Shock Icon Earth Shock when you have between 12 and 15 charges of Lightning Shield Icon Lightning Shield.\nKeep Searing Totem Icon Searing Totem up.\nCast Lightning Bolt Icon Lightning Bolt as a filler.\n\nIf you pulled more than 1 target, replace Lightning Bolt Icon Lightning Bolt with Chain Lightning Icon Chain Lightning.\nKeep Lightning Shield Icon Lightning Shield up.";
		local MultiTargetRotation = "Keep Flame Shock on all Targets\nMagma Totem up\nLava Burst on cooldown (Use when Lava Surge Procs)\nEarth Shock when 10 charges if Lightning Shield\nChain LIghtning instead of LIghtning for filler\n\n4 or more targets:\nKeep Magma Totem up\nSpam Chain Lightning\nEarthquake on Cooldown\nThunderstorm on Cooldown\nFire Elemental Totem";
		local EffectiveCooldowns = "When you need to kill mobs faster, you can use Ancestral Swiftness Icon Ancestral Swiftness, Fire Elemental Totem Icon Fire Elemental Totem, Earth Elemental Totem Icon Earth Elemental Totem, and Bloodlust Icon Bloodlust/Heroism Icon Heroism.\nAt Level 87, you gain Ascendance Icon Ascendance, which you can use as a DPS cooldown.";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,EffectiveCooldowns)
	end},
	{'Tips & Tricks',function(f)
		local tips = "You're leveling as fast as you can I can assume, so be sure to follow these suggestions. Always loot everything, sell or Disenchant everything except gear you can wear. If you get a gear upgrade immediately put it on, and sell or DE what you replaced. \n Kill everything you see while on the way to and from quest areas.";
		local tricks = "Remember this rotation is a suggested priority list, and you'll not have all these spells to start so just add those you get to the rotation as you level. \n\nWhen you are in danger of dying, you can use Astral Shift Icon Astral Shift and heal yourself with Healing Surge Icon Healing Surge. You can also use Ancestral Guidance Icon Ancestral Guidance and let your damaging spells heal you.\n\nIf you are attacked by several enemies, you can try to incapacitate one of them with Hex Icon Hex. You can also summon Capacitor Totem Icon Capacitor Totem or Earthgrab Totem Icon Earthgrab Totem and reset their cooldowns with Call of the Elements Icon Call of the Elements.\n\nIf you decide that running away is safer, summon Earthbind Totem Icon Earthbind Totem or casts Thunderstorm Icon Thunderstorm, and activate Ghost Wolf Icon Ghost Wolf.\n\n";
		--TIPS_RETURN(tips,tricks)
	end},
	
});

EDGE:Register('SHAMAN:Leveling:Enhancement' ,{
	{'Overview', "The Enhancement spec is for players that enjoy leveling with no downtime due to speed enhancements, instant heals, and devastating attacks. Good for leveling 85-90 or raiding at level 85."},
	{'Stat Priority', "Agility\nMultistrike\nMastery >= Haste >= Critical Strike >= Versatility"},
	{'Enchants', "When leveling, unless you're an Enchanter with lots of mats, don't bother with Enchants. You'll have to add a new one too often with the amount you change gear while leveling."},
	{'Gems', "Do NOT use Gems until max level. Otherwise you're going to spend too much to make it worth gemming each item you can. "},
	{'Talents & Glyphs', function(f)
		local MajorGlyphs = {
			55449, -- Chain LIghtning
			55455, -- Fire Elemental Totem
			45771, -- Feral Spirit
		};
		local MinorGlyphs = {
			58058, -- Astral Recall
			55448, -- Lakestrider
			58135, -- Spectral Wolf
		};
		local Talents = {
			108271, -- Astral Shift
			51485, -- Earthgrab Totem
			108285, -- Call of the Elements
			16188, -- Ancestral Swiftness
			108281, -- Ancestral Guidance
			117012, -- Unleashed Fury
			152256, -- Storm Elemental Totem
		};
		local TalentTips = "The talents that are primarily utility-based are simply our general recommendation, your play style and raid needs should be priority when choosing these talents. The talent descriptions include some additional advice on when different utility talents are the most appropriate choice.";
		local GlyphTips = "Glyphs are situational, they depend on the make-up of your group as well as the enemies you're facing.That said, we suggest these because they seem to be all around the best for every situation.";
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',MajorGlyphs,MinorGlyphs,Talents,TalentTips,GlyphTips)
	end},
	{'Play Styles', function(f)
		local SingleTargetRotation = "As an Enhancement Shaman, you should try and kill enemies one by one and to avoid pulling mobs together. Follow this priority list.\n\nCast Lightning Bolt Icon Lightning Bolt if you have 5 stacks of Maelstrom Weapon Icon Maelstrom Weapon ?against 1 enemy.\nCast Chain Lightning Icon Chain Lightning if you have 5 stacks of Maelstrom Weapon Icon Maelstrom Weapon ?against 3 or more enemies.\nApply and refresh Flame Shock Icon Flame Shock after casting Unleash Elements Icon Unleash Elements.\nCast Stormstrike Icon Stormstrike.\nCast Lava Lash Icon Lava Lash.\nSummon and refresh Searing Totem Icon Searing Totem.\nCast Frost Shock Icon Frost Shock.\n";
		local MultiTargetRotation = "Keep Lightning Shield up. \nUse Chain Lightning instead of Lightning";
		local EffectiveCooldowns = "When you need to kill mobs faster, you can use Ancestral Swiftness Icon Ancestral Swiftness, Fire Elemental Totem Icon Fire Elemental Totem, Earth Elemental Totem Icon Earth Elemental Totem, and Bloodlust Icon Bloodlust/Heroism Icon Heroism.\nAt Level 87, you gain Ascendance Icon Ascendance, which you can use as a DPS cooldown.\n";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,EffectiveCooldowns)
	end},
	{'Tips & Tricks',function(f)
		local tips = "When you are in danger of dying, you can use Astral Shift Icon Astral Shift and heal yourself with Healing Surge Icon Healing Surge. You can also use Ancestral Guidance Icon Ancestral Guidance and let your damaging spells heal you. Finally, remember that Shamanistic Rage Icon Shamanistic Rage temporarily reduces the damage you take. \nYou can also easily heal yourself by consuming stacks of Maelstrom Weapon Icon Maelstrom Weapon with healing spells or by summoning your Feral Spirit Icon Feral Spirit.\n";
		local tricks = "If you are attacked by several enemies, you can try to incapacitate one of them with Hex Icon Hex. You can also summon Capacitor Totem Icon Capacitor Totem or Earthgrab Totem Icon Earthgrab Totem and reset their cooldowns with Call of the Elements Icon Call of the Elements.\nIf you decide that running away is safer, summon Earthbind Totem Icon Earthbind Totem and activate Ghost Wolf Icon Ghost Wolf.\n";
		--TIPS_RETURN(tips,tricks)
	end},
	
});

EDGE:Register('SHAMAN:PvP:Elemental' ,{
	{'Overview', "PVP for the Elemental Shaman setup that is best for DPS and killing other players."},
	{'Stat Priority', "Multistrike\nHaste >= Critical Strike >= Mastery >= Intellect = PvP Power\nVersatility"},
	{'Enchants', "Neck: Gift of Multistrike\nCloak: Gift of Multistrike\nRing: Gift of Multistrike\nWeapon: Mark of the Frostwolf"},
	{'Gems', "Greater Multistrike Taladite"},
	{'Talents & Glyphs', function(f)
		local MajorGlyphs = {
			101052, -- Glyph of Lightning Shield
			63280, -- Glyph of Shamanistic Rage
			55442, -- Glyph of Capacitor Totem
		};
		local MinorGlyphs = {
			55448, -- Glyph of Lakestrider
			58057, -- Glyph of Totemic Encirclement
			62132, -- Glyph of Thunderstorm
		};
		local Talents = {
			30884, -- Nature's Guardian
			108273, -- Windwalk Totem
			108285, -- Call of the Elements
			16188, -- Acestral Swiftness
			108281, -- Rushing Streams
			165477, -- Unleashed Fury
			152256, -- Elemental Fusion
		};
		local TalentTips = "The talents that are primarily utility-based are simply our general recommendation, your play style and raid needs should be priority when choosing these talents. The talent descriptions include some additional advice on when different utility talents are the most appropriate choice.";
		local GlyphTips = "Glyphs are situational, they depend on the make-up of your group as well as the enemies you're facing.That said, we suggest these because they seem to be all around the best for every situation.";
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',MajorGlyphs,MinorGlyphs,Talents,TalentTips,GlyphTips)
	end},
	{'Play Styles', function(f)
		local SingleTargetRotation = "Priority Spell Listing:\n\nFlame Shock if DoT expired or 1 tick left\nLava Burst if Flame Shock is active on target\nEarth Shock if you have 6-7 charges of Lightning Shield\nFire Elemental Totem on Cooldown\nSearing Totem if you have no active fire totem\nLightning Bolt\nOnly have to stop moving to cast Lava Burst which only should be cast if Lava Surge procs.";
		local MultiTargetRotation = "Same as Single target priority, except use Chain Lightning instead of Lightning Bolt on highest HP target\nCast Earthquake";
		local EffectiveCooldowns = "Ascendance  is your main DPS cooldown. This ability causes your Lava Burst to no longer have a cooldown and your Chain Lightning to become Lava Beam , a more powerful AoE ability. Ascendance has a 3-minute cooldown and should be used whenever it is available. You can also save it to line it up with periods during which you deal increased damage. For single-target damage, spam Lava Burst  and cast Earth Shock when you reach 20 stacks of Fulmination .\nFor AoE damage, spam Lava Beam .\nBefore using Ascendance, make sure that Flame Shock will not need to be refreshed while Ascendance is active.\nStack Ascendance with Elemental Mastery, if you have chosen it as your Tier 4 talent.\nFire Elemental Totem  is an DPS cooldown. It should be used whenever your Fire Elemental will be able to attack the boss for 1 minute without being interrupted (30 seconds if you are using Glyph of Fire Elemental Totem ).\nSpiritwalker's Grace can be used to cast Lava Burst when you are on the move.\nThunderstorm is an AoE DPS cooldown, which you should always use when you have 10 or more enemies to attack and.\n";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,EffectiveCooldowns)
	end},
	{'Tips & Tricks',function(f)
		local tips = "It's PvP, try really hard to not die. :) (more may be added here)";
		local tricks = "";
		--TIPS_RETURN(tips,tricks)
	end},
	
});

EDGE:Register('SHAMAN:PvP:Enchancement' ,{
	{'Overview', "PVP for the Enhancement Shaman setup that is best for DPS and killing other players."},
	{'Stat Priority', "Agility = PvP Power\nMultistrike\nVersatility\nMastery >= Critical Strike\nHaste"},
	{'Enchants', "Neck: Gift of Multistrike\nCloak: Gift of Multistrike\nRing: Gift of Multistrike\nWeapon: Mark of the Frostwolf"},
	{'Gems', "Greater Multistrike Taladite"},
	{'Talents & Glyphs', function(f)
		local MajorGlyphs = {
			63280, -- Glyph of Shamanistic Rage
			59289, -- Glyph of Ghost Wolf
			55439, -- Glyph of Purge
		};
		local MinorGlyphs = {
			55448, -- Glyph of the Lakestrider
			58057, -- Glyph of Totemic Encirclement
			58135, -- Glyph of Spectral Wolf
		};
		local Talents = {
			30884, -- Nature's Guardian
			108273, -- Windwalk Totem
			108285, -- Call of the Elements
			16188, -- Ancestral Swiftness
			108281, -- Ancestral Guidance
			117014, -- Elemental Blast
			152257, -- Storm Elemental Totem
		};
		local TalentTips = "The talents that are primarily utility-based are simply our general recommendation, your play style and raid needs should be priority when choosing these talents. The talent descriptions include some additional advice on when different utility talents are the most appropriate choice.";
		local GlyphTips = "Glyphs are situational, they depend on the make-up of your group as well as the enemies you're facing.That said, we suggest these because they seem to be all around the best for every situation.";
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',MajorGlyphs,MinorGlyphs,Talents,TalentTips,GlyphTips)
	end},
	{'Play Styles', function(f)
		local SingleTargetRotation = "Priority Spell Listing:\n\nKeep Searing Totem up\nUse Lightning Bolt when Maelstrom Weapon procs\nFlame Shock to apply and refresh the DoT\nStormstrike/Stormblast on Cooldown\nLava Lash when 5 stacks of Searing Flame (basically when on Cooldown)\nUnleash Elements on Cooldown\nEarth Shock when you have nothing else to cast.";
		local MultiTargetRotation = "Multiple Targets:\n\nFlame Shock\nLava Lash\nFire Nova\n3 or More Enemies use Magma Totem, else use Searing Totem\nReplace Lightning Bolt with Chain Lightning\nUnleash Elements should be followed by Fire Nova";
		local EffectiveCooldowns = "Make judicious use of Ascendance\nFeral Spirit on Cooldown\nBloodlust or Heroism used on cooldown\nStormlash Totem used on cooldown to increase the raids damage";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,EffectiveCooldowns)
	end},
	{'Tips & Tricks',function(f)
		local tips = "";
		local tricks = "";
		--TIPS_RETURN(tips,tricks)
	end},
	
});
]]
EDGE:Register('SHAMAN:Leveling:Enhancement' ,{
	{'Stat Priority', "1 - Agility\n2 - Haste (17%)\n3 - Mastery\n4 - Haste (above 17%)\n5 - Critical Strike\n6 - Versatility"},
	{'Talents', function(f)
		local Talents = {
			201897, -- Boulderfist
			196884, -- Feral Lunge*
			192058, -- Lightning Surge Totem
			192087, -- Ancestral Swiftness*
			17364, -- Stormstrike*
			192246, -- Crashing Storm
			197992, -- Landslide
		};
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',nil,nil,Talents,nil,nil)
	end},
	{'Rotation', function(f)
		local SingleTargetRotation = "1 - Boulderfist and Landslide buffs\n2 - Frostbrand for Hailstorm buff\n3 - Flametongue buff\n4 - Feral Spirit\n5 - Stormstrike with Stormbringer procs\n6 - Crash Lightning\n7 - Lava Lash \n9 - Flametongue";
		local MultiTargetRotation = "";
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

EDGE:Register('SHAMAN:PvE:Restoration' ,{
	{'Stat Priority', "1 - Intellect\n2 - Mastery\n3 - Critical Strike\n4 - Haste\n5 - Versatility"},
	{'Enchants', "Back - Enchant Cloak - Gift of Mastery\nNeck - Enchant Neck - Gift of Mastery\nRings - Enchant Ring - Gift of Mastery\nWeapons - Enchant Weapon - Mark of Bleeding Hollow"},
	{'Gems', "1 - Immaculate Mastery Taladite\n2 - Greater Mastery Taladite\n3 - Mastery Taladite"},
	{'Talents', function(f)
		local Talents = {
			200072, -- Torrent
			192077, -- Wind Rush Totem
			192058, -- Lightning Surge Totem
			108281, -- Ancestral Guidance
			207401, -- Ancestral Vigor
			157153, -- Cloudburst Totem
			157154, -- High Tide
		};
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',nil,nil,Talents,nil,nil)
	end},
	{'Rotation', function(f)
		local SingleTargetRotation = "Too Situational for an actual rotation.";
		local MultiTargetRotation = "";
		local EffectiveCooldowns = "";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,nil)
	end},
	{'Buffs',function(f)
		local tips = "Food:\nSleeper Sushi = 125 Mastery\nSleeper Surprise = 100 Mastery\n\nFlask: \nGreater Draenic Intellect Flask\n\nRune:\nFocus Augment Rune\n\nPotion:\nDraenic Mana Potion";
		local tricks = "";
		return EDGE:FillTemplate(f,'Tips',tips,tricks)
		--TIPS_RETURN(tips,tricks)
	end},
	
});
-- 7.0
EDGE:Register('SHAMAN:PvE:Elemental' ,{
	{'Stat Priority', "1 - Intellect\n2 - Critical Strike\n3 - Haste\n4 - Versatility\n5 - Mastery"},
	{'Enchants', "Back - Enchant Cloak - Gift of Critical Strike\nNeck - Enchant Neck - Gift of Critical Strike\nRings - Enchant Ring - Gift of Critical Strike\nWeapons - Enchant Weapon - Mark of the Thunderlord"},
	{'Gems', "1 - Immaculate Critical Strike Taladite\n2 - Greater Critical Strike Taladite\n3 - Critical Strike Taladite"},
	{'Talents', function(f)
		local Talents = {
			210643, -- Totem Mastery
			192077, -- Wind Rush Totem
			192058, -- Lightning Surge Totem
			192087, -- Ancestral Swiftness
			117013, -- Primal Elementalist
			16166, -- Elemental Mastery
			114050, -- Ascendance
		};
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',nil,nil,Talents,nil,nil)
	end},
	{'Rotation', function(f)
		local SingleTargetRotation = "1 - Flame Shock if target lives more than 6 seconds\n2 - Fire Elemental\n3 - Earth Shock if at max Maelstrom\n4 - Ascendance\n5 - Elemental Mastery\n6 - Totem Mastery\n7 - Lava Burst\n8 - Earthquake if 3+ targets\n9 - Earth Shock if 90+ Maelstrom\n10 - Chain Lightning if 2+ targets\n11 - Lightning Bolt filler";
		local MultiTargetRotation = "";
		local EffectiveCooldowns = "";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,nil)
	end},
	{'Buffs',function(f)
		local tips = "CONSUMABLES\n\nFood:\nPickled Eel = 125 Critical Strike\nBlackrock Barbecue = 100 Critical Strike\n\nFlask: \nGreater Draenic Intellect Flask\n\nRune:\nFocus Augment Rune\n\nPotion:\nDraenic Intellect Potion";
		local tricks = "";
		return EDGE:FillTemplate(f,'Tips',tips,tricks)
		--TIPS_RETURN(tips,tricks)
	end},
	
});
-- 7.0
EDGE:Register('SHAMAN:PvE:Enhancement' ,{
	{'Stat Priority', "1 - Agility\n2 - Haste (17%)\n3 - Mastery\n4 - Haste (above 17%)\n5 - Critical Strike\n6 - Versatility"},
	{'Enchants', "Back - Enchant Cloak - Gift of Mastery\nNeck - Enchant Neck - Gift of Mastery\nRings - Enchant Ring - Gift of Mastery\nWeapons - Enchant Weapon - Mark of Bleeding Hollow"},
	{'Gems', "1 - Immaculate Mastery Taladite\n2 - Greater Mastery Taladite\n3 - Mastery Taladite"},
	{'Talents', function(f)
		local Talents = {
			201897, -- Boulderfist
			192077, -- Wind Rush Totem
			192058, -- Lightning Surge TOtem
			210853, -- Hailstorm
			210731, -- Empowered Stormlash
			192246, -- Crashing Storm
			197992, -- Landslide
		};
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',nil,nil,Talents,nil,nil)
	end},
	{'Rotation', function(f)
		local SingleTargetRotation = "1 - Boulderfist and Landslide buffs\n2 - Frostbrand for Hailstorm buff\n3 - Boulderfist (if less than 130 Maelstrom and you have 2 charges)\n4 - Flametongue buff\n5 - Feral Spirit\n6 - Stormstrike with Stormbringer procs\n7 - Crash Lightning\n8 - Lava Lash with 110+ Maelstrom\n9 - Boulderfist\n10 - Flametongue";
		local MultiTargetRotation = "";
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

