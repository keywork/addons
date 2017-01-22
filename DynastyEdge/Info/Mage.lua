local ADDON_NAME, EDGE = ...;
--[[
EDGE:Register('MAGE:Leveling:Frost' ,{
	{'Overview', "Frost is a great leveling spec for mages of all experience. The rotation is easy and survivability is high. It's also particularly great for those on PVP servers as you will quickly be able to eliminate enemies. The high burst AoE damage makes pulling large groups of mobs very easy for quicker leveling."},
	{'Stat Priority', "Intellect\nMultistrike\nCritical Strike >= Versatility\nHaste >= Mastery"},
	{'Enchants', "When leveling, unless you're an Enchanter with lots of mats, don't bother with Enchants. You'll have to add a new one too often with the amount you change gear while leveling."},
	{'Gems', "Do NOT use Gems until max level. Otherwise you're going to spend too much to make it worth gemming each item you can. "},
	{'Talents & Glyphs', function(f)
		local MajorGlyphs = {
			42745, -- Splitting Ice
			42748, -- Rapid Displacement
			63090, -- Water Elemental
		};
		local MinorGlyphs = {
			63416, -- Rapid Teleportation
			56384, -- Momentum
			63092, -- Illusion
		};
		local Talents = {
			108843, -- Blazing Speed
			11426, -- Ice Barrier
			111264, -- Ice Ward
			86949, -- Cauterize
			157976, -- Unstable Magic
			116011, -- Rune of Power
			152087, -- Prismatic Crystal
		};
		local TalentTips = "The talents that are primarily utility-based are simply our general recommendation, your play style and raid needs should be priority when choosing these talents. The talent descriptions include some additional advice on when different utility talents are the most appropriate choice.";
		local GlyphTips = "Glyphs are situational, they depend on the make-up of your group as well as the enemies you're facing.That said, we suggest these because they seem to be all around the best for every situation.";
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',MajorGlyphs,MinorGlyphs,Talents,TalentTips,GlyphTips)
	end},
	{'Play Styles', function(f)
		local SingleTargetRotation = "Ice Barrier: Keep up all the time\nIce Ward: Keep up all the time\nFrozen Orb: Cast when it's available\nWater Elemental Freeze: On cooldown\nFrostfire Bolt: Use when Brain Freeze procs\nIce Lance: Us when you have charges of Fingers of Frost\nFrostbolt: Filler spell";
		local MultiTargetRotation = "Group enemies together\nFrost Nova, Water Elemental Freeze, and Cone of Cold to keep them rooted and slowed while you damage them. \nUse Blink to get away when needed.";
		local EffectiveCooldowns = "Invisibility Icon Invisibility is your main survival cooldowns. Use Invisibility to vanish from your enemies' sight. Use Ice Block Icon Ice Block to remove the burning DoT left by Cauterize Icon Cauterize when it saves your life.";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,EffectiveCooldowns)
	end},
	{'Tips & Tricks',function(f)
		local tips = "Save Icy Veins Icon Icy Veins and Time Warp Icon Time Warp for when you are in trouble, so you have a chance to kill your enemies before they kill you.\nRemember to interrupt harmful spell casts with Counterspell Icon Counterspell. Whenever possible, try stealing beneficial effects that mobs cast on themselves with Spellsteal Icon Spellsteal.";
		local tricks = "You can escape a fight through different means. You can run away and slow your enemies with Blizzard, Cone of Cold, Frost Bomb. You can also run off a cliff and use Slow Fall Icon Slow Fall or Blink Icon Blink to negate fall damage.";
		--TIPS_RETURN(tips,tricks)
	end},
	
});

EDGE:Register('MAGE:Leveling:Fire' ,{
	{'Overview', "While Fire is a little more complicated than Arcane or Frost, the results are more than worth it. Fire Mages have excellent mobility and are able to kill multiple targets very quickly with high damage AoE abilities and DoT spreading."},
	{'Stat Priority', "Intellect\nCritical Strike\nMastery\nMultistrike >= Haste\nVersatility"},
	{'Enchants', "When leveling, unless you're an Enchanter with lots of mats, don't bother with Enchants. You'll have to add a new one too often with the amount you change gear while leveling."},
	{'Gems', "Do NOT use Gems until max level. Otherwise you're going to spend too much to make it worth gemming each item you can. "},
	{'Talents & Glyphs', function(f)
		local MajorGlyphs = {
			159485, -- Dragon's Breath
			89926, -- Inferno Blast
			42748, -- Rapid Displacement
		};
		local MinorGlyphs = {
			63416, -- Rapid Teleportation
			56384, -- Momentum
			63092, -- Illusion
		};
		local Talents = {
			108843, -- Blazing Speed
			11426, -- Ice Barrier
			111264, -- Ice Ward
			86949, -- Cauterize
			157976, -- Unstable Magic
			116011, -- Rune of Power
			152087, -- Prismatic Crystal
		};
		local TalentTips = "The talents that are primarily utility-based are simply our general recommendation, your play style and raid needs should be priority when choosing these talents. The talent descriptions include some additional advice on when different utility talents are the most appropriate choice.";
		local GlyphTips = "Glyphs are situational, they depend on the make-up of your group as well as the enemies you're facing.That said, we suggest these because they seem to be all around the best for every situation.";
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',MajorGlyphs,MinorGlyphs,Talents,TalentTips,GlyphTips)
	end},
	{'Play Styles', function(f)
		local SingleTargetRotation = "Ice Barrier: Keep up all the time\nIce Ward: Keep up all the time\nPyroblast: Cast with Pyroblast! procs\nInferno Blast: Use when Heating Up procs and Inferno Blast is off Cooldown.(Inferno Blast will always crit, changing Heating Up into Pyroblast!\nFireball: Filler\nWhen mobs are reaching you, just hit Frost Nova then Blink.";
		local MultiTargetRotation = "As a Fire Mage, you can easily pull large groups of enemies. What you should aim for is to cast 1 or 2 Fireball to build up a decent Ignite . Cast Combustion and use Inferno Blast to spread Ignite and the new DoT created by Combustion. You can also use Dragon's Breath.\nAfter that, you can go towards the mobs, cast Frost Nova to freeze them. Flamestrike and Blizzard do not break Frost Nova, so you should make use of these spells while targets are frozen.\n";
		local EffectiveCooldowns = "Invisibility is your main survival cooldown. Use Invisibility to vanish from your enemies' sight. Use Ice Block Icon to remove the burning DoT left by Cauterize when it saves your life.";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,EffectiveCooldowns)
	end},
	{'Tips & Tricks',function(f)
		local tips = "Save Time Warp Icon Time Warp for when you are in trouble, so you have a chance to kill your enemies before they kill you.";
		local tricks = "You can escape a fight through different means. You can run away and slow your enemies with Dragon's Breath Icon Dragon's Breath. You can also run off a cliff and use Slow Fall Icon Slow Fall or Blink Icon Blink to negate fall damage.\nRemember to interrupt harmful spell casts with Counterspell Icon Counterspell. Whenever possible, try stealing beneficial effects that mobs cast on themselves with Spellsteal Icon Spellsteal.\n";
		--TIPS_RETURN(tips,tricks)
	end},
	
});

EDGE:Register('MAGE:Leveling:Arcane' ,{
	{'Overview', "Arcane Mages excel in single target burst situations and have mediocre AoE abilities. If you want to kill your targets quick, this is the spec for you."},
	{'Stat Priority', "Intellect\nMastery\nMultistrike\nHaste = Critical Strike\nVersatility"},
	{'Enchants', "When leveling, unless you're an Enchanter with lots of mats, don't bother with Enchants. You'll have to add a new one too often with the amount you change gear while leveling."},
	{'Gems', "Do NOT use Gems until max level. Otherwise you're going to spend too much to make it worth gemming each item you can. "},
	{'Talents & Glyphs', function(f)
		local MajorGlyphs = {
			42743, -- Slow
			42748, -- Rapid Displacement
			42746, -- Cone of Cold
		};
		local MinorGlyphs = {
			63416, -- Rapid Teleportation
			56384, -- Momentum
			63092, -- Illusion
		};
		local Talents = {
			108843, -- Blazing Speed
			11426, -- Ice Barrier
			111264, -- Ice Ward
			86949, -- Cauterize
			157976, -- Unstable Magic
			116011, -- Rune of Power
			152087, -- Prismatic Crystal
		};
		local TalentTips = "The talents that are primarily utility-based are simply our general recommendation, your play style and raid needs should be priority when choosing these talents. The talent descriptions include some additional advice on when different utility talents are the most appropriate choice.";
		local GlyphTips = "Glyphs are situational, they depend on the make-up of your group as well as the enemies you're facing.That said, we suggest these because they seem to be all around the best for every situation.";
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',MajorGlyphs,MinorGlyphs,Talents,TalentTips,GlyphTips)
	end},
	{'Play Styles', function(f)
		local SingleTargetRotation = "Ice Barrier: Keep up all the time.\nIce Ward: Keep up all the time\nArcane Blast: Use to build up Arcane Charges.\nArcane Missles: If target is alive spend your procs\nArcane Barrage: If target is still alive.";
		local MultiTargetRotation = "In multiple-target situations, Arcane Barrage will spend your stacks of Arcane Charge and deal a lot of AoE damage. Arcane Explosion works very well when you are surrounded by a lot of low-health enemies.";
		local EffectiveCooldowns = "Evocation: Use if low on mana.\nInvisibility is your main survival cooldowns. Use Invisibility to vanish from your enemies' sight. Use Ice Block to remove the burning DoT left by Cauterize when it saves your life.";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,EffectiveCooldowns)
	end},
	{'Tips & Tricks',function(f)
		local tips = "Save your DPS cooldowns (Arcane Power, Time Warp ) for when you are in trouble, so you have a chance to kill your enemies before they kill you.\n";
		local tricks = "You can escape a fight through different means. You can run away and slow your enemies with Cone of Cold Icon Cone of Cold. You can also run off a cliff and use Slow Fall or Blink to negate fall damage.\nRemember to interrupt harmful spell casts with Counterspell Icon Counterspell. Whenever possible, try stealing beneficial effects that mobs cast on themselves with Spellsteal Icon Spellsteal.";
		--TIPS_RETURN(tips,tricks)
	end},
	
});

EDGE:Register('MAGE:PvP:Frost' ,{
	{'Overview', "This is the base build for a PVP Frost Mage. All of the spells, skills, and talents are geared toward fighting in a PVP environment."},
	{'Stat Priority', "Multistrike\nVersatility\nIntellect = PvP Power\nMastery\nCritical Strike\nHaste"},
	{'Enchants', "Neck: Gift of Multistrike\nCloak: Gift of Multistrike\nRing: Gift of Multistrike\nWeapon: Mark of the Frostwolf"},
	{'Gems', "Greater Multistrike Taladite"},
	{'Talents & Glyphs', function(f)
		local MajorGlyphs = {
			115710, -- Glyph of Deep Freeze
			56376, -- Glyph of Frost Nova
			115723, -- Glyph of Ice Block
		};
		local MinorGlyphs = {
			57925, -- Glyph of Arcane Language
			126748, -- Glyph of Conjure Familiar
			56384, -- Glyph of Momentum
		};
		local Talents = {
			157913, -- Evanesce
			108978, -- Alter Time
			113724, -- Ring of Frost
			11958, -- Cold Snap
			112948, -- Frost Bomb
			1463, -- Incanter's Flow
			153595, -- Comet Storm
		};
		local TalentTips = "The talents that are primarily utility-based are simply our general recommendation, your play style and raid needs should be priority when choosing these talents. The talent descriptions include some additional advice on when different utility talents are the most appropriate choice.";
		local GlyphTips = "Glyphs are situational, they depend on the make-up of your group as well as the enemies you're facing.That said, we suggest these because they seem to be all around the best for every situation.";
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',MajorGlyphs,MinorGlyphs,Talents,TalentTips,GlyphTips)
	end},
	{'Play Styles', function(f)
		local SingleTargetRotation = "Melee Opponent: \nKeep Ice Barrier up\nBegin with a Polymorph if you are able to\nCast Frost Bomb\nCast Frozen Orb\nCast Frostbolt\nFrost Nova once in melee range and blink away\nCone ofCold and get away if they are able to break your freeze\nUse instant Frostfire Bolt procs when available and Ice Lance when you have charges of Fingers of Frost\nUse your your pet's freeze ability to create Fingers of Frost charges and also root enemy targets\nUtilize other abilites such as Frostjaw or Ring of Frost to keep melee dps from reaching you\n";
		local MultiTargetRotation = "Caster Opponent: \nKeep Ice Barrier up\nBegin with a polymorph if you are able to\nTry to reserve a counterspell for a heal if it's a healer and a crowd control ability if it's a DPS.\nCast Frost Bomb\nCast Frozen Orb\nCast Frostbolt\nUse instant Frostfire Bolt procs when available and Ice Lance when you have charges of Fingers of Frost\nUse your your pet's freeze ability to create Fingers of Frost charges and also root enemy targets\nUtilize other abilites such as Spellsteal to take bubbles and heals off of your opponent\n";
		local EffectiveCooldowns = "See single and multi target rotation texts.";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,EffectiveCooldowns)
	end},
	{'Tips & Tricks',function(f)
		local tips = "PvP is not like fighting PvE at all, as long as you keep that in mind, and know that you're playing against people who can probably guess what you're going to do. Keep this in mind and keep your strategies from getting stagnant and you'll do OK.";
		local tricks = "";
		--TIPS_RETURN(tips,tricks)
	end},
	
});

EDGE:Register('MAGE:PvP:Fire' ,{
	{'Overview', "This is the base build for a PVP Fire Mage. All of the spells, skills, and talents are geared toward fighting in a PVP environment."},
	{'Stat Priority', "Critical Strike\nMultistrike >= Haste\nIntellect = PvP Power\nVersatility"},
	{'Enchants', "Neck: Gift of Critical Strike\nCloak: Gift of Critical Strike\nRing: Gift of Critical Strike\nWeapon: Mark of the Thunderlord"},
	{'Gems', "Greater Critical Strike Taladite"},
	{'Talents & Glyphs', function(f)
		local MajorGlyphs = {
			115710, -- Glyph of Deep Freeze
			115723, -- Glyph of Ice Block
			56376, -- Glyph of Frost Nova
		};
		local MinorGlyphs = {
			57925, -- Glyph of Arcane Language
			126748, -- Glyph of Conjure Familiar
			56384, -- Glyph of Momentum
		};
		local Talents = {
			157913, -- Evanesce
			108978, -- Alter Time
			113724, -- Ring of Frost
			11958, -- Cold Snap
			44457, -- LIving Bomb
			1463, -- Incanter's Flow
			155148, -- Kindilng
		};
		local TalentTips = "The talents that are primarily utility-based are simply our general recommendation, your play style and raid needs should be priority when choosing these talents. The talent descriptions include some additional advice on when different utility talents are the most appropriate choice.";
		local GlyphTips = "Glyphs are situational, they depend on the make-up of your group as well as the enemies you're facing.That said, we suggest these because they seem to be all around the best for every situation.";
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',MajorGlyphs,MinorGlyphs,Talents,TalentTips,GlyphTips)
	end},
	{'Play Styles', function(f)
		local SingleTargetRotation = "Melee Opponent: \nKeep Ice Barrier up\nBegin with a Polymorph if you are able to\nCast Living Bomb\nCast Fireball\nFrost Nova once in melee range and blink away\nDragon's Breath and get away if they are able to break your freeze\nUse instant Pyroblast! when available and Scorch while moving.\nCast Inferno Blast to spread dots, proc Pyroblast!, or to use as an instant cast finisher.\nUtilize other abilites such as Frostjaw or Ring of Frost to keep melee dps from reaching you\n";
		local MultiTargetRotation = "Caster Opponent: \nKeep Ice Barrier up\nBegin with a polymorph if you are able to\nTry to reserve a counterspell for a heal if it's a healer and a crowd control ability if it's a DPS.\nCast Living Bomb\nCast Fireball\nBlink within range of them when Dragon's Breath is available to disorient.\nUse instant Pyroblast! procs when available and Scorch when moving\nCast Inferno Blast to spread dots, proc Pyroblast!, or to use as an instant cast finisher.";
		local EffectiveCooldowns = "\nUtilize other abilites such as Spellsteal to take bubbles and heals off of your opponent\n";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,EffectiveCooldowns)
	end},
	{'Tips & Tricks',function(f)
		local tips = "Fire is full of potential when it comes to PVP. They are strong against Melee and can do a lot of damage really quickly to multiple targets.";
		local tricks = "";
		--TIPS_RETURN(tips,tricks)
	end},
	
});

EDGE:Register('MAGE:PvP:Arcane' ,{
	{'Overview', "This is the base build for a PVP Arcane Mage. All of the spells, skills, and talents are geared toward fighting in a PVP environment."},
	{'Stat Priority', "Intellect\nMastery\nMultistrike\nHaste = Critical Strike\nVersatility"},
	{'Enchants', "Neck: Gift of Haste\nCloak: Gift of Haste\nRing: Gift of Haste\nWeapon: Mark of Warsong"},
	{'Gems', "Greater Haste Taladite"},
	{'Talents & Glyphs', function(f)
		local MajorGlyphs = {
			62210, -- Glyph of Arcnae Power
			56376, -- Glyph of Frost Nova
			115718, -- Glyph of Arcane Explosion
		};
		local MinorGlyphs = {
			57925, -- Glyph of Arcane Language
			126748, -- Glyph of Conjure Familiar
			56384, -- Glyph of Momentum
		};
		local Talents = {
			157913, -- Evanesce
			108978, -- Alter Time
			113724, -- Ring of Frost
			11958, -- Cold Snap
			114923, -- Nether Tempest
			1463, -- Incanter's Flow
			153626, -- Arcane Orb
		};
		local TalentTips = "The talents that are primarily utility-based are simply our general recommendation, your play style and raid needs should be priority when choosing these talents. The talent descriptions include some additional advice on when different utility talents are the most appropriate choice.";
		local GlyphTips = "Glyphs are situational, they depend on the make-up of your group as well as the enemies you're facing.That said, we suggest these because they seem to be all around the best for every situation.";
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',MajorGlyphs,MinorGlyphs,Talents,TalentTips,GlyphTips)
	end},
	{'Play Styles', function(f)
		local SingleTargetRotation = "Melee Opponent: \nKeep Ice Barrier up\nBegin with a Polymorph if you are able to\nApply Slow, and cast Frost Bomb\nCast Arcane Blast\nFrost Nova once in melee range and blink away\nMake sure slow is still on them and repeat\nUse Arcane Missiles when available and Arcane Barrage as a finisher\nUtilize other abilites such as Frostjaw or Ring of Frost to keep melee dps from reaching you\n";
		local MultiTargetRotation = "Caster Opponent: \nKeep Ice Barrier up\nBegin with a polymorph if you are able to\nTry to reserve a counterspell for a heal if it's a healer and a crowd control ability if it's a DPS.\nCast Frost Bomb\nCast Arcane Blast\nUse Arcane Missiles when available and Arcane Barrage as a finisher\nUtilize other abilites such as Spellsteal to take bubbles and heals off of your opponent\n";
		local EffectiveCooldowns = "Arcane Brilliance: Keep up at all times.\nFrost Armor: Keep up at all times.";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,EffectiveCooldowns)
	end},
	{'Tips & Tricks',function(f)
		local tips = "Arcane is an easy spec to master and with the proper knowledge of your abilites and when to use them, PVP can be a fun and exhilerating experience for any Arcane Mage. \n";
		local tricks = "";
		--TIPS_RETURN(tips,tricks)
	end},
	
});
]]
EDGE:Register('MAGE:Leveling:Fire' ,{
	{'Stat Priority', "1 - Intellect\n2 - Critical Strike\n3 - Mastery\n4 - Haste\n5 - Versatility"},
	{'Talents', function(f)
		local Talents = {
			205023, -- Conflagration*
			212653, -- Shimmer
			1463, -- Incanter's Flow*
			205029, -- Flame On
			108839, -- Ice Floes
			44457, -- Living Bomb
			198929, -- Cinderstorm
		};
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',nil,nil,Talents,nil,nil)
	end},
	{'Rotation', function(f)
		local SingleTargetRotation = "1 - Rune of Power\n2 - Combustion\n3 - Pyroblast (with Hot Streak)\n4 - Flame On\n5 - Dragon's Breath\n6 - Fire Blast\n7 - Fireball\n8 - Scorch";
		local MultiTargetRotation = "";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,nil)
	end},
	{'Buffs',function(f)
		local tips = "Guild Banners:\nBattle Standard of Cooperation\nStandard of Unity\nBattle Standard of Coordination\n\nFood:\nPickled Eel = 125 Critical Strike\nBlackrock Barbecue = 100 Critical Strike\n\nFlask: \nGreater Draenic Intellect Flask\n\nRune:\nFocus Augment Rune\n\nPotion:\nDraenic Intellect Potion";
		local tricks = "";
		return EDGE:FillTemplate(f,'Tips',tips,tricks)
		--TIPS_RETURN(tips,tricks)
	end},
	
});

EDGE:Register('MAGE:PvE:Arcane' ,{
	{'Stat Priority', "1 - Intellect\n2 - Mastery\n3 - Critical Strike\n4 - Versatility\n5 - Haste"},
	{'Enchants', "Back - Enchant Cloak - Gift of Mastery\nNeck - Enchant Neck - Gift of Mastery\nRings - Enchant Ring - Gift of Mastery\nWeapons - Enchant Weapon - Mark of Bleeding Hollow"},
	{'Gems', "1 - Immaculate Mastery Taladite\n2 - Greater Mastery Taladite\n3 - Mastery Taladite"},
	{'Talents', function(f)
		local Talents = {
			205035, -- Words of Power
			212653, -- Shimmer
			116011, -- Rune of Power
			157980, -- Supernova
			108839, -- Ice Floes
			205039, -- Erosion
			198923, -- Quickening
		};
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',nil,nil,Talents,nil,nil)
	end},
	{'Rotation', function(f)
		local SingleTargetRotation = "1 - Rune of Power with 2 charges\n2 - Arcane Missiles\n3 - Supernova\n4 - Arcane Barrage\n5 - Arcane Blast\n\nBurn:\n\n1 - Arcane Charges (4)\n2 - Rune of Power\n3 - Arcane Power\n4 - Arcane Missiles\n5 - Arcane Blast\n6 - Presence of Mind";
		local MultiTargetRotation = "";
		local EffectiveCooldowns = "";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,nil)
	end},
	{'Buffs',function(f)
		local tips = "Food:\nSleeper Sushi = 125 Mastery\nSleeper Surprise = 100 Mastery\n\nFlask: \nGreater Draenic Intellect Flask\n\nRune:\nFocus Augment Rune\n\nPotion:\nDraenic Intellect Potion";
		local tricks = "";
		return EDGE:FillTemplate(f,'Tips',tips,tricks)
		--TIPS_RETURN(tips,tricks)
	end},
	
});
-- 7.0
EDGE:Register('MAGE:PvE:Fire' ,{
	{'Stat Priority', "1 - Intellect\n2 - Critical Strike\n3 - Mastery\n4 - Haste\n5 - Versatility"},
	{'Enchants', "Back - Enchant Cloak - Gift of Critical Strike\nNeck - Enchant Neck - Gift of Critical Strike\nRings - Enchant Ring - Gift of Critical Strike\nWeapons - Enchant Weapon - Mark of the Thunderlord"},
	{'Gems', "1 - Immaculate Critical Strike Taladite\n2 - Greater Critical Strike Taladite\n3 - Critical Strike Taladite"},
	{'Talents', function(f)
		local Talents = {
			205020, -- Pyromaniac
			212653, -- Shimmer
			116011, -- Rune of Power
			205029, -- Flame On
			108839, -- Ice Floes
			157976, -- Unstable Magic
			155148, -- Kindling
		};
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',nil,nil,Talents,nil,nil)
	end},
	{'Rotation', function(f)
		local SingleTargetRotation = "1 - Rune of Power\n2 - Combustion\n3 - Rune of Power (2 charges)\n4 - Pyroblast (with Hot Streak)\n5 - Flame On\n6 - Dragon's Breath\n7 - Fire Blast\n8 - Fireball\n9 - Scorch";
		local MultiTargetRotation = "";
		local EffectiveCooldowns = "";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,nil)
	end},
	{'Buffs',function(f)
		local tips = "Food:\nPickled Eel = 125 Critical Strike\nBlackrock Barbecue = 100 Critical Strike\n\nFlask: \nGreater Draenic Intellect Flask\n\nRune:\nFocus Augment Rune\n\nPotion:\nDraenic Intellect Potion";
		local tricks = "";
		return EDGE:FillTemplate(f,'Tips',tips,tricks)
		--TIPS_RETURN(tips,tricks)
	end},
	
});
-- 7.0
EDGE:Register('MAGE:PvE:Frost' ,{
	{'Stat Priority', "1 - Intellect\n2 - Haste\n3 - Critical Strike (37%)\n4 - Versatility\n5 - Mastery\n6 - Critical Strike"},
	{'Enchants', "Back - Enchant Cloak - Gift of Haste\nNeck - Enchant Neck - Gift of Haste\nRings - Enchant Ring - Gift of Haste\nWeapons - Enchant Weapon - Mark of Warsong"},
	{'Gems', "1 - Immaculate Haste Taladite\n2 - Greater Haste Taladite\n3 - Haste Taladite"},
	{'Talents', function(f)
		local Talents = {
			205021, -- Ray of Frost
			212653, -- Shimmer
			116011, -- Rune of Power
			205030, -- Frozen touch
			108839, -- Ice Floes
			157976, -- Unstable Magic
			199786, -- Glacial Spike
		};
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',nil,nil,Talents,nil,nil)
	end},
	{'Rotation', function(f)
		local SingleTargetRotation = "1 - Rune of Power (2 charges)\n2 - Ray of Frost\n3 - Icy Veins\n4 - Rune of Power\n5 - Frost Bomb\n6 - Frozen Orb\n7 - Frozen Touch\n8 - Ice Lance (2 charges of Fingers of Frost)\n9 - Flurry (Brain Freeze active)\n10 - Ice Lance (Flurry)\n11 - Water Jet\n12 - Ice Nova (If you have it)\n13 - Blizzard\n14 - Ice Lance\n15 - Glacial Spike\n16 - Frostbolt";
		local MultiTargetRotation = "";
		local EffectiveCooldowns = "";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,nil)
	end},
	{'Buffs',function(f)
		local tips = "CONSUMABLES\n\nFood:\nButtered Sturgeon = 125 Haste\nFrosty Stew = 100 Haste\n\nFlask: \nGreater Draenic Intellect Flask\n\nRune:\nFocus Augment Rune\n\nPotion:\nDraenic Intellect Potion";
		local tricks = "";
		return EDGE:FillTemplate(f,'Tips',tips,tricks)
		--TIPS_RETURN(tips,tricks)
	end},
	
});