local ADDON_NAME, EDGE = ...;
--[[
EDGE:Register('WARLOCK:Leveling:Destruction' ,{
	{'Overview', "The Destruction Warlock is optimal for both single mobs and multiple mobs at once. A destruction warlock is capable of putting out a LOT of damage very quickly, quickly eliminating any target they go up against. "},
	{'Stat Priority', "Intellect\nCritical Strike >= Multistrike\nHaste >= Mastery\nVersatility"},
	{'Enchants', "When leveling, unless you're an Enchanter with lots of mats, don't bother with Enchants. You'll have to add a new one too often with the amount you change gear while leveling."},
	{'Gems', "Do NOT use Gems until max level. Otherwise you're going to spend too much to make it worth gemming each item you can. "},
	{'Talents & Glyphs', function(f)
		local MajorGlyphs = {
			148683, -- Glyph of Eternal Resolve
			56218, -- Glyph of Siphon Life
			56235, -- Glyph of Conflagrate
		};
		local MinorGlyphs = {
			56232, -- Glyph of Nightmares
			58079, -- Glyph of Unending Breath
			56241, -- Glyph of Verdant Spheres
		};
		local Talents = {
			108370, -- Soul Leech
			30283, -- Shadowfury
			108415, -- Soul Link
			111400, -- Burning Rush
			108499, -- Grimoire of Supremacy
			108505, -- Archimonde's Darkness
			152107, -- Demonic Servitude
		};
		local TalentTips = "The talents that are primarily utility-based are simply our general recommendation, your play style and raid needs should be priority when choosing these talents. The talent descriptions include some additional advice on when different utility talents are the most appropriate choice.";
		local GlyphTips = "Glyphs are situational, they depend on the make-up of your group as well as the enemies you're facing.That said, we suggest these because they seem to be all around the best for every situation.";
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',MajorGlyphs,MinorGlyphs,Talents,TalentTips,GlyphTips)
	end},
	{'Play Styles', function(f)
		local SingleTargetRotation = "Thanks to your Voidlord, which you should always be using, you can easily pull several mobs at a time and are encouraged to do so.\n\nUse the following priority list.\n\nAt Level 90, you unlock your Tier 6 talents and we advise you to choose Archimonde's Darkness because it allows you to use Dark Soul twice in a row when you are in trouble.\nApply Immolate on all targets and keep it up.◦Use Fire and Brimstone  to help you apply Immolate all multiple targets. It costs 1 Burning Ember.\nActivate Rain of Fire (only against 3 enemies at least).\nCast Conflagrate as often as possible.\nCast Chaos Bolt when you have a Burning Ember.Never cast Chaos Bolt when you have 3 charges of Backdraft \nCast Shadowburn  instead of Chaos Bolt when the target is below 20%.\nCast Incinerate to build up Burning Embers\n";
		local MultiTargetRotation = "Against multiple targets, use Fire and Brimstone, when you do not have to apply/refresh Immolate, to damage all enemies with Incinerate.";
		local EffectiveCooldowns = "When you want to kill mobs faster, activate Dark Soul: Instability and call forth your Terrorguard with Summon Terrorguard. You can also use these spells as survival cooldowns that you will cast when you need to kill mobs before they kill you.";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,EffectiveCooldowns)
	end},
	{'Tips & Tricks',function(f)
		local tips = "Soul Leech will cover most of your health regeneration needs, but if you pulled too many mobs, it might not be enough. In such cases, you can:\n\ncall forth your Abyssal with Summon Abyssal ;\nuse Shadowfury to stun the enemies\nuse Burning Rush , if you want to flee and you are being slowed down.\nAs a Warlock, you have little room for errors when you pull mobs, as you have virtually no ability that enables to easily run away.\n Pet: use your Voidlord always while leveling. (In dungeon ask for requests and bring out the one everyone wants). ";
		local tricks = "You are trying to level fast, and get to 100! So keep up the hard work, and add one or two of these tips to your bag of tricks. :) \n1. When going to and from quest areas/npcs kill everything that crosses your path. 2. Loot everything, and sell every chance you get. don't hold on to anything without sentimental value, as you're leveling you're going to be tradin that gear out soon anyways \n\nPet: use your Voidlord always while leveling. (In dungeon ask for requests and bring out the one everyone wants). You are trying to level fast, and get to 100! So keep up the hard work, and add one or two of these tips to your bag of tricks. :) \n1. When going to and from quest areas/npcs kill everything that crosses your path. 2. Loot everything, and sell every chance you get. don't hold on to anything without sentimental value, as you're leveling you're going to be tradin that gear out soon anyways";
		--TIPS_RETURN(tips,tricks)
	end},
	
});

EDGE:Register('WARLOCK:Leveling:Affliction' ,{
	{'Overview', "An Affliction Warlock has a lot of potential when it comes to leveling. Their DoT's allow for multiple targets to be killed simultaneously and survivability is high due to self healing and a tanking pet. This spec is very good for leveling."},
	{'Stat Priority', "Intellect\nMastery\nHaste\nMultistrike >= Critical Strike\nVersatility"},
	{'Enchants', "When leveling, unless you're an Enchanter with lots of mats, don't bother with Enchants. You'll have to add a new one too often with the amount you change gear while leveling."},
	{'Gems', "Do NOT use Gems until max level. Otherwise you're going to spend too much to make it worth gemming each item you can. "},
	{'Talents & Glyphs', function(f)
		local MajorGlyphs = {
			43390, -- Glyph of Soul Consumption
			56224, -- Glyph of Healthstone
			56218, -- Glyph of Siphon LIfe
		};
		local MinorGlyphs = {
			56232, -- Glyph of Nightmares
			58079, -- Glyph of Unending Breath
			56217, -- Glyph of Subtlety
		};
		local Talents = {
			108370, -- Soul Leech
			30283, -- Shadowfury
			108415, -- Soul Link
			111400, -- Burning Rush
			108499, -- Grimoire of Supremacy
			108505, -- Archemonde's Darkness
			152109, -- Soulburn:  Haunt
		};
		local TalentTips = "The talents that are primarily utility-based are simply our general recommendation, your play style and raid needs should be priority when choosing these talents. The talent descriptions include some additional advice on when different utility talents are the most appropriate choice.";
		local GlyphTips = "Glyphs are situational, they depend on the make-up of your group as well as the enemies you're facing.That said, we suggest these because they seem to be all around the best for every situation.";
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',MajorGlyphs,MinorGlyphs,Talents,TalentTips,GlyphTips)
	end},
	{'Play Styles', function(f)
		local SingleTargetRotation = "Thanks to your Voidlord, which you should always be using, you can easily pull several mobs at a time and are encouraged to do so.\nUse the following priority list.\n\nUse Soulburn Icon Soulburn+Soul Swap Icon Soul Swap to apply Agony Icon Agony, Corruption Icon Corruption, and Unstable Affliction Icon Unstable Affliction on all your targets, if you have Soul Shards. Otherwise, apply them manually.\nCast Haunt Icon Haunt one your primary target when you have a Soul Shard and Haunt's debuff is not applied on that target.\nCast Drain Soul Icon Drain Soul as a filler on your primary target.\nRemember to keep Dark Intent Icon Dark Intent up at all times.";
		local MultiTargetRotation = "Soul Leech will cover most of your health regeneration needs, but if you pulled too many mobs, it might not be enough. In such cases, you can:\n\ncall forth your Abyssal with Summon Abyssal ;\nuse Shadowfury  to stun the enemies;\nuse Burning Rush , if you want to flee and you are being slowed down.\n\nAs a Warlock, you have little room for errors when you pull mobs, as you have virtually no ability that enables to easily run away.";
		local EffectiveCooldowns = "When you want to kill mobs faster, activate Dark Soul: Misery : Misery and call forth your Terrorguard with Summon Terrorguard . You can also use these spells as survival cooldowns that you will cast when you need to kill mobs before they kill you.";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,EffectiveCooldowns)
	end},
	{'Tips & Tricks',function(f)
		local tips = "Soul Leech will cover most of your health regeneration needs, but if you pulled too many mobs, it might not be enough. In such cases, you can:\n\ncall forth your Abyssal with Summon Abyssal ;\nuse Shadowfury to stun the enemies\nuse Burning Rush , if you want to flee and you are being slowed down.\nAs a Warlock, you have little room for errors when you pull mobs, as you have virtually no ability that enables to easily run away.\n Pet: use your Voidlord always while leveling. (In dungeon ask for requests and bring out the one everyone wants). ";
		local tricks = "You are trying to level fast, and get to 100! So keep up the hard work, and add one or two of these tips to your bag of tricks. :) \n1. When going to and from quest areas/npcs kill everything that crosses your path. 2. Loot everything, and sell every chance you get. don't hold on to anything without sentimental value, as you're leveling you're going to be tradin that gear out soon anyways \n\nPet: use your Voidlord always while leveling. (In dungeon ask for requests and bring out the one everyone wants). You are trying to level fast, and get to 100! So keep up the hard work, and add one or two of these tips to your bag of tricks. :) \n1. When going to and from quest areas/npcs kill everything that crosses your path. 2. Loot everything, and sell every chance you get. don't hold on to anything without sentimental value, as you're leveling you're going to be tradin that gear out soon anyways";
		--TIPS_RETURN(tips,tricks)
	end},
	
});

EDGE:Register('WARLOCK:Leveling:Demonology' ,{
	{'Overview', "The Demonology Warlock has seen major improvements over the last few expansions. Demonology is a strong spec for both single target situations and multiple target encounters."},
	{'Stat Priority', "Intellect\nHaste\nCritical Strike >= Multistrike >= Mastery\nVersatility"},
	{'Enchants', "When leveling, unless you're an Enchanter with lots of mats, don't bother with Enchants. You'll have to add a new one too often with the amount you change gear while leveling."},
	{'Gems', "Do NOT use Gems until max level. Otherwise you're going to spend too much to make it worth gemming each item you can. "},
	{'Talents & Glyphs', function(f)
		local MajorGlyphs = {
			56218, -- Glyph of Siphon Life
			56242, -- Glyph of Imp Swarm
			56249, -- Glyph of Demon Training
		};
		local MinorGlyphs = {
			477, -- Glyph of Unending Breath
			56248, -- Glyph of Hand of Gul'dan
			56247, -- Glyph of Falling Meteor
		};
		local Talents = {
			108370, -- Soul Leech
			30283, --Shadowfury
			108416, -- Sacrificial Pact
			111397, -- Blood Horror
			108501, -- Grimoire of Service
			108505, -- Archimonde's Darkness
			152108, -- Cataclysm
		};
		local TalentTips = "The talents that are primarily utility-based are simply our general recommendation, your play style and raid needs should be priority when choosing these talents. The talent descriptions include some additional advice on when different utility talents are the most appropriate choice.";
		local GlyphTips = "Glyphs are situational, they depend on the make-up of your group as well as the enemies you're facing.That said, we suggest these because they seem to be all around the best for every situation.";
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',MajorGlyphs,MinorGlyphs,Talents,TalentTips,GlyphTips)
	end},
	{'Play Styles', function(f)
		local SingleTargetRotation = "Thanks to your Voidlord, which you should always be using, you can easily pull several mobs at a time and are encouraged to do so.To build up Demonic Fury, use the following rotation.\n\nApply and keep Corruption up on all targets.\nCast Hand of Gul'dan when you have a charge and its DoT is not applied on the target.\nCast Soul Fire when Molten Core occurs.\nCast Shadow Bolt as a filler.\nTo spend Demonic Fury, activate Metamorphosis and use the following rotation.\nApply and keep Doom up on all targets.\nSpam Touch of Chaos (it will keep Corruption up). Rotate it between all the enemies if you are fighting several mobs at a time.\nRemember to keep Dark Intent up at all times.";
		local MultiTargetRotation = "See Single Target Information.";
		local EffectiveCooldowns = "When you want to kill mobs faster, activate Dark Soul: Knowledge and call forth your Terrorguard with Summon Terrorguard. You can also use these spells as survival cooldowns that you will cast when you need to kill mobs before they kill you.\n\nwill cover most of your health regeneration needs, but if you pulled too many mobs, it might not be enough. In such cases, you can:\n\ncall forth your Abyssal with Summon Abyssal;\nuse Shadowfury to stun the enemies;\nuse Burning Rush , if you want to flee and you are being slowed down.\n";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,EffectiveCooldowns)
	end},
	{'Tips & Tricks',function(f)
		local tips = "Soul Leech will cover most of your health regeneration needs, but if you pulled too many mobs, it might not be enough. In such cases, you can:\n\ncall forth your Abyssal with Summon Abyssal ;\nuse Shadowfury to stun the enemies\nuse Burning Rush , if you want to flee and you are being slowed down.\nAs a Warlock, you have little room for errors when you pull mobs, as you have virtually no ability that enables to easily run away.\n Pet: use your Voidlord always while leveling. (In dungeon ask for requests and bring out the one everyone wants). ";
		local tricks = "You are trying to level fast, and get to 100! So keep up the hard work, and add one or two of these tips to your bag of tricks. :) \n1. When going to and from quest areas/npcs kill everything that crosses your path. 2. Loot everything, and sell every chance you get. don't hold on to anything without sentimental value, as you're leveling you're going to be tradin that gear out soon anyways \n\nPet: use your Voidlord always while leveling. (In dungeon ask for requests and bring out the one everyone wants). You are trying to level fast, and get to 100! So keep up the hard work, and add one or two of these tips to your bag of tricks. :) \n1. When going to and from quest areas/npcs kill everything that crosses your path. 2. Loot everything, and sell every chance you get. don't hold on to anything without sentimental value, as you're leveling you're going to be tradin that gear out soon anyways";
		--TIPS_RETURN(tips,tricks)
	end},
	
});

EDGE:Register('WARLOCK:PvP:Destruction' ,{
	{'Overview', "This is the base build for a PVP Destruction Warlock. All of the spells, skills, and talents are geared toward fighting in a PVP environment."},
	{'Stat Priority', "Haste\nMultistrike >= Mastery >= Intellect = PvP Power >= Critical Strike\nVersatility"},
	{'Enchants', "Neck: Gift of Haste\nCloak: Gift of Haste\nRing: Gift of Haste\nWeapon: Mark of Warsong"},
	{'Gems', "Greater Haste Taladite"},
	{'Talents & Glyphs', function(f)
		local MajorGlyphs = {
			56224, -- Glyph of Healthstone
			146962, -- Glyph of Havoc
			56235, -- Glyph of Conflagrate
		};
		local MinorGlyphs = {
			135557, -- Glyph of Gateway Attunement
			56232, -- Glyph of Nightmares
			56240, -- Glyph of Shadow Bolt
		};
		local Talents = {
			108359, -- Dark Regeneration
			6789, -- Mortal Coil
			108416, -- Sacrificial Pact
			111397, -- Blood Horrow
			108503, -- Grimoire of Sacrifice
			108505, -- Archimonde's Darkness
			152107, -- Demonic Servitude
		};
		local TalentTips = "The talents that are primarily utility-based are simply our general recommendation, your play style and raid needs should be priority when choosing these talents. The talent descriptions include some additional advice on when different utility talents are the most appropriate choice.";
		local GlyphTips = "Glyphs are situational, they depend on the make-up of your group as well as the enemies you're facing.That said, we suggest these because they seem to be all around the best for every situation.";
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',MajorGlyphs,MinorGlyphs,Talents,TalentTips,GlyphTips)
	end},
	{'Play Styles', function(f)
		local SingleTargetRotation = "In PvP there it is usually unlikely that you will be able to ever perform your full rotation perfectly every time you get into a battle. The best thing to do is know your priority spells and with experience and practice, you will soon master the ways of a Destruction Warlock in a PvP environment.";
		local MultiTargetRotation = "To get you started, we've provided a list of your priorities for PvP:\n\nCast Immolate\nCast Conflag\nCast Incinerate\nCast Chaos Bolt\nCast Shadowburn when any target is below 20% health";
		local EffectiveCooldowns = "Finally be sure to use your crowd control and AOE's as much as possible to keep invisible guys away and do as much damage as possible while slowing the bad guys.";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,EffectiveCooldowns)
	end},
	{'Tips & Tricks',function(f)
		local tips = "";
		local tricks = "";
		--TIPS_RETURN(tips,tricks)
	end},
	
});

EDGE:Register('WARLOCK:PvP:Affliction' ,{
	{'Overview', "This is the base build for a PVP Affliction Warlock. All of the spells, skills, and talents are geared toward fighting in a PVP environment. Currently, Affliction is the best Warlock spec to play for PvP in 6.0"},
	{'Stat Priority', "Mastery = Multistrike\nIntellect = PvP Power >= Haste\nCritical Strike >= Versatility"},
	{'Enchants', "Neck: Gift of Multistrike\nCloak: Gift of Multistrike\nRing: Gift of Multistrike\nWeapon: Mark of Bleeding Hollow"},
	{'Gems', "Greater Multistrike Taladite"},
	{'Talents & Glyphs', function(f)
		local MajorGlyphs = {
			56224, -- Glyph of Healthstone
			56218, -- Glyph of Siphon Life
			56233, -- Glyph of Unstable Affliction
		};
		local MinorGlyphs = {
			135557, -- Glyph of Gateway Attunement
			58079, -- Glyph of Unending Breath
			56232, -- Glyph of Nightmares
		};
		local Talents = {
			108359, -- Dark Regeneration
			30283, -- Shadowfury
			108415, -- Soul Link
			111397, -- Blood Horror
			108499, -- Grimoire of Supremacy
			108505, -- Archimonde's Darkness
			152109, -- Soulburn: Haunt
		};
		local TalentTips = "The talents that are primarily utility-based are simply our general recommendation, your play style and raid needs should be priority when choosing these talents. The talent descriptions include some additional advice on when different utility talents are the most appropriate choice.";
		local GlyphTips = "Glyphs are situational, they depend on the make-up of your group as well as the enemies you're facing.That said, we suggest these because they seem to be all around the best for every situation.";
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',MajorGlyphs,MinorGlyphs,Talents,TalentTips,GlyphTips)
	end},
	{'Play Styles', function(f)
		local SingleTargetRotation = "In PvP there it is usually unlikely that you will be able to ever perform your full rotation perfectly every time you get into a battle. The best thing to do is know your priority spells and with experience and practice, you will soon master the ways of an Affliction Warlock in a PvP environment.";
		local MultiTargetRotation = "To get you started, we've provided a list of your priorities for PvP:\nCast Unstable affliction\nCast Haunt\nCast Corruption\nCast Agony\nRepeat on multiple targets if needed. (pets etc)\nDrain life is always your filler. Your shadowbolt scales with drain life, and Demonsoul does. If you have to fake cast with it, it will always allow you some damage oppose to cancelling a cast.\n";
		local EffectiveCooldowns = "Text\n";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,EffectiveCooldowns)
	end},
	{'Tips & Tricks',function(f)
		local tips = "";
		local tricks = "";
		--TIPS_RETURN(tips,tricks)
	end},
	
});

EDGE:Register('WARLOCK:PvP:Demonology' ,{
	{'Overview', "This is the base build for a PVP Demonology Warlock. All of the spells, skills, and talents are geared toward fighting in a PVP environment."},
	{'Stat Priority', "Multistrike\nMastery = Critical Strike\nIntellect = PvP Power = Haste\nVersatility"},
	{'Enchants', "Neck: Gift of Multistrike\nCloak: Gift of Multistrike\nRing: Gift of Multistrike\nWeapon: Mark of the Thunderlord"},
	{'Gems', "Greater Multistrike Taladite"},
	{'Talents & Glyphs', function(f)
		local MajorGlyphs = {
			56224, -- Glyph of Healthstone
			56242, -- Glyph of Imp Swarm
			63303, -- Glyph of Demon Training
		};
		local MinorGlyphs = {
			56240, -- Glyph of Shadow Bolt
		135557, -- Glyph of Gateway Attunement
		56232, -- Glyph of Nightmares
		};
		local Talents = {
			108359, -- Dark Regeneration
			6789, -- Mortal Coil
			108415, -- Soul Link
			111397, -- Blood Horror
			108501, -- Grimoire of Service
			108505, -- Archimonde's Darkness
			157695, -- Demonbolt
		};
		local TalentTips = "The talents that are primarily utility-based are simply our general recommendation, your play style and raid needs should be priority when choosing these talents. The talent descriptions include some additional advice on when different utility talents are the most appropriate choice.";
		local GlyphTips = "Glyphs are situational, they depend on the make-up of your group as well as the enemies you're facing.That said, we suggest these because they seem to be all around the best for every situation.";
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',MajorGlyphs,MinorGlyphs,Talents,TalentTips,GlyphTips)
	end},
	{'Play Styles', function(f)
		local SingleTargetRotation = "In PvP there it is usually unlikely that you will be able to ever perform your full rotation perfectly every time you get into a battle. The best thing to do is know your priority spells and with experience and practice, you will soon master the ways of a Demonology Warlock in a PvP environment.";
		local MultiTargetRotation = "To get you started, we've provided a list of your priorities for PvP:\nCast Dark Soul\nCast Corruption\nCast Hand of Guldan\nCast Metamorphosis\nCast  Doom\nCast Imp Swarm\nCast Shadowbolt/Soulfire as filler with procs";
		local EffectiveCooldowns = "Text\n";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,EffectiveCooldowns)
	end},
	{'Tips & Tricks',function(f)
		local tips = "";
		local tricks = "";
		--TIPS_RETURN(tips,tricks)
	end},
	
});
]]
EDGE:Register('WARLOCK:Leveling:Affliction' ,{
	{'Stat Priority', "1 - Intellect\n2 - Haste\n3 - Mastery\n4 - Critical Strike\n5 - Versatility"},
	{'Talents', function(f)
		local Talents = {
			198590, -- Drain Soul*
			196105, -- Contagion
			219272, -- Demon Skin
			63106, -- Siphon Life
			111400, -- Burning Rush*
			152107, -- Grimoire of Supremacy*
			205179, -- Phantom Singularity*
		};
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',nil,nil,Talents,nil,nil)
	end},
	{'Rotation', function(f)
		local SingleTargetRotation = "- DOT your targets with Agony, Corruption and Siphon Life\n- Unstable Affliction for extra damage\n- Drain Soul for soul shards\n- Phantom Singularity for multi target";
		local MultiTargetRotation = "";
		local EffectiveCooldowns = "";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,nil)
	end},
	{'Buffs',function(f)
		local tips = "Guild Banners:\nBattle Standard of Cooperation\nStandard of Unity\nBattle Standard of Coordination\n\nFood:\nButtered Sturgeon = 125 Haste\nFrosty Stew = 100 Haste\n\nFlask: \nGreater Draenic Intellect Flask\n\nRune:\nFocus Augment Rune\n\nPotion:\nDraenic Intellect Potion";
		local tricks = "";
		return EDGE:FillTemplate(f,'Tips',tips,tricks)
		--TIPS_RETURN(tips,tricks)
	end},
	
});

EDGE:Register('WARLOCK:PvE:Destruction' ,{
	{'Stat Priority', "1 - Intellect\n2 - Haste\n3 - Critical Strike\n4 - Versatility\n5 - Mastery"},
	{'Enchants', "Back - Enchant Cloak - Gift of Haste\nNeck - Enchant Neck - Gift of Haste\nRings - Enchant Ring - Gift of Haste\nWeapons - Enchant Weapon - Mark of Warsong"},
	{'Gems', "1 - Immaculate Haste Taladite\n2 - Greater Haste Taladite\n3 - Haste Taladite"},
	{'Talents', function(f)
		local Talents = {
			205184, -- Roaring Blaze
			205148, -- Reverse Entropy
			219272, -- Demon Skin
			196412, -- Eradication
			108416, -- Dark Pact
			108501, -- Grimoire of Service
			196410, -- Wreak Havok
		};
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',nil,nil,Talents,nil,nil)
	end},
	{'Rotation', function(f)
		local SingleTargetRotation = "1 - Immolate\n2 - Chaos Bolt (5 shards)\n3 - Conflagrate after Immolate\n4 - Summon Doomguard\n5 - Grimoire: Imp\n6 - Conflagrate for Soul Shards\n7 - Incinerate as filler";
		local MultiTargetRotation = "";
		local EffectiveCooldowns = "";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,nil)
	end},
	{'Buffs',function(f)
		local tips = "Food:\nButtered Sturgeon = 125 Haste\nFrosty Stew = 100 Haste\n\nFlask: \nGreater Draenic Intellect Flask\n\nRune:\nFocus Augment Rune\n\nPotion:\nDraenic Intellect Potion";
		local tricks = "";
		return EDGE:FillTemplate(f,'Tips',tips,tricks)
		--TIPS_RETURN(tips,tricks)
	end},
	
});
-- 7.0
EDGE:Register('WARLOCK:PvE:Affliction' ,{
	{'Stat Priority', "1 - Intellect\n2 - Haste\n3 - Mastery\n4 - Critical Strike\n5 - Versatility"},
	{'Enchants', "Back - Enchant Cloak - Gift of Haste\nNeck - Enchant Neck - Gift of Haste\nRings - Enchant Ring - Gift of Haste\nWeapons - Enchant Weapon - Mark of the Warsong"},
	{'Gems', "1 - Immaculate Haste Taladite\n2 - Greater Haste Taladite\n3 - Haste Taladite"},
	{'Talents', function(f)
		local Talents = {
			196102, -- Writhe in Agony
			196105, -- Contagion
			219272, -- Demon Skin
			63106, -- Siphon Life
			108416, -- Dark Pact
			108501, -- Grimoire of Service
			205178, -- Soul Effigy
		};
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',nil,nil,Talents,nil,nil)
	end},
	{'Rotation', function(f)
		local SingleTargetRotation = "1 - Agony and Soul Effigy\n2 - Unstable Affliction at 5 Soul Shards\n3 - Corruption\n4 - Siphon Life\n5 - Summon Doomguard\n7 - Grimoire: Felhunter\n8 - Unstable Affliction as Soul Shard dump\n9 - Drain Life or Drain Soul as filler";
		local MultiTargetRotation = "";
		local EffectiveCooldowns = "";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,nil)
	end},
	{'Buffs',function(f)
		local tips = "Food:\nButtered Sturgeon = 125 Haste\nFrosty Stew = 100 Haste\n\nFlask: \nGreater Draenic Intellect Flask\n\nRune:\nFocus Augment Rune\n\nPotion:\nDraenic Intellect Potion";
		local tricks = "";
		return EDGE:FillTemplate(f,'Tips',tips,tricks)
		--TIPS_RETURN(tips,tricks)
	end},
	
});
-- 7.0
EDGE:Register('WARLOCK:PvE:Demonology' ,{
	{'Stat Priority', "1 - Intellect\n2 - Haste\n3 - Master = Critical Strike\n4 - Versatility"},
	{'Enchants', "Back - Enchant Cloak - Gift of Haste\nNeck - Enchant Neck - Gift of Haste\nRings - Enchant Ring - Gift of Haste\nWeapons - Enchant Weapon - Mark of Warsong"},
	{'Gems', "1 - Immaculate Haste Taladite\n2 - Greater Haste Taladite\n3 - Haste Taladite"},
	{'Talents', function(f)
		local Talents = {
			196269, -- Shadowy Inspiration
			196270, -- Impending Doom
			219272, -- Demon Skin
			196605, -- Power Trip
			111400, -- Burning Rush
			108501, -- Grimoire of Service
			157695, -- Demonbolt
		};
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',nil,nil,Talents,nil,nil)
	end},
	{'Rotation', function(f)
		local SingleTargetRotation = "1 - Doom\n2 - Call Dreadstalkers and give Demonic Empowerment\n3 - Summon Doomguard and give Demonic Empowerment\n4 - Hand of Gul'dan (4+ shards) and give Demonic Empowerment\n5 - Grimoire: Felguard and give Demonic Empowerment\n6 - Command Demon (Felstorm)\n9 - Demonbolt";
		local MultiTargetRotation = "";
		local EffectiveCooldowns = "";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,nil)
	end},
	{'Buffs',function(f)
		local tips = "Food:\nButtered Sturgeon = 125 Haste\nFrosty Stew = 100 Haste\n\nFlask: \nGreater Draenic Intellect Flask\n\nRune:\nFocus Augment Rune\n\nPotion:\nDraenic Intellect Potion";
		local tricks = "";
		return EDGE:FillTemplate(f,'Tips',tips,tricks)
		--TIPS_RETURN(tips,tricks)
	end},
	
});