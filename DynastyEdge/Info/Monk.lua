local ADDON_NAME, EDGE = ...;
--[[
EDGE:Register('MONK:Leveling:Windwalker' ,{
	{'Overview', "The Windwalker Monk is an ideal spec for players who wish to level through solo questing or the Dungeon Finder. While this spec does not do as much AoE damage as Brewmaster, its high single target damage and other utility spells can make solo questing easy. "},
	{'Stat Priority', "Agility\nMultistrike\nVersatility >= Critical Strike\nHaste\nMastery"},
	{'Enchants', "When leveling, unless you're an Enchanter with lots of mats, don't bother with Enchants. You'll have to add a new one too often with the amount you change gear while leveling."},
	{'Gems', "Do NOT use Gems until max level. Otherwise you're going to spend too much to make it worth gemming each item you can. "},
	{'Talents & Glyphs', function(f)
		local MajorGlyphs = {
			125678, -- Touch of Karma
			146953, -- Fortuitous Spheres
			123391, -- Touch of Death
		};
		local MinorGlyphs = {
			123403, -- Flying Serpent Kick
			125154, -- Spirit Roll
			125901, -- Water Roll
		};
		local Talents = {
			116841, -- Tiger's Lust
			115098, -- Chi Wave
			115399, -- Chi Brew
			119381, -- Leg Sweep
			122783, -- Diffuse Magic
			123904, -- Invoke Xuen, the White Tiger
			152173, -- Serenity
		};
		local TalentTips = "The talents that are primarily utility-based are simply our general recommendation, your play style and raid needs should be priority when choosing these talents. The talent descriptions include some additional advice on when different utility talents are the most appropriate choice.";
		local GlyphTips = "Glyphs are situational, they depend on the make-up of your group as well as the enemies you're facing.That said, we suggest these because they seem to be all around the best for every situation.";
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',MajorGlyphs,MinorGlyphs,Talents,TalentTips,GlyphTips)
	end},
	{'Play Styles', function(f)
		local SingleTargetRotation = "Spam Jab Icon Jab to generate Chi.\nUse Rising Sun Kick Icon Rising Sun Kick on cooldown.\nUse Fists of Fury Icon Fists of Fury on cooldown.\nUse Blackout Kick Icon Blackout Kick to dump Chi.\nUse Tiger Palm Icon Tiger Palm to keep Tiger Power Icon Tiger Power up.\nUse Touch of Death Icon Touch of Death whenever it is available.\n";
		local MultiTargetRotation = "Against 3 or more enemies, you can use Spinning Crane Kick Icon Spinning Crane Kick to generate Chi instead of Jab Icon Jab.";
		local EffectiveCooldowns = "Energizing Brew: Use on Cooldown.\nTigereye Brew: Use when 10 or more stacks of the buff.\nFortifying Brew: Reduces incoming Damage.";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,EffectiveCooldowns)
	end},
	{'Tips & Tricks',function(f)
		local tips = "Always use Tigereye Brew once it reaches 10 stacks for maxmimum DPS. Keep an eye on all self-buffs and debuffs, and make sure to refresh them often.";
		local tricks = "";
		--TIPS_RETURN(tips,tricks)
	end},
	
});

EDGE:Register('MONK:PvP:Brewmaster' ,{
	{'Overview', "The Brewmaster Monk is an excellent flag carrier in rated battlegrounds, providing plenty of mobility, self-healing, and damage mitigation to handle the focused efforts of DPS. This spec is not recommended for arena play. "},
	{'Stat Priority', "Stamina\nArmor\nBonus Armor\nMastery\nVersatility\nAgility = PvP Power\nMultistrike >= Critical Strike\nHaste"},
	{'Enchants', "Neck: Gift of Mastery\nCloak: Gift of Mastery\nRing: Gift of Mastery\nWeapon: Mark of Blackrock"},
	{'Gems', "Greater Stamina Taladite"},
	{'Talents & Glyphs', function(f)
		local MajorGlyphs = {
			
		};
		local MinorGlyphs = {
			
		};
		local Talents = {
		
		};
		local TalentTips = "The talents that are primarily utility-based are simply our general recommendation, your play style and raid needs should be priority when choosing these talents. The talent descriptions include some additional advice on when different utility talents are the most appropriate choice.";
		local GlyphTips = "Glyphs are situational, they depend on the make-up of your group as well as the enemies you're facing.That said, we suggest these because they seem to be all around the best for every situation.";
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',MajorGlyphs,MinorGlyphs,Talents,TalentTips,GlyphTips)
	end},
	{'Play Styles', function(f)
		local SingleTargetRotation = "The best assets of a Brewmaster Monk are their mobility and their Shuffle mechanic. As such, you should always be ready to move via Roll or Clash, kite with Dizzying Haze, apply glyphed Breath of Fire, and generally be a nuisance while maintaining 100% uptime on Shuffle through use of Blackout Kick.";
		local MultiTargetRotation = "Your role is not to engage enemies with the intent of bursting them down. Your role is to peel for your healers and critical DPS when you're not carrying the flag. When you are on flag duty, Roll whenever you can, use Tiger's Lust to break roots or snares, use Expel Harm on cooldown, Keg Smash on cooldown (and pick up any ox orbs), and maintain Dizzying Haze. If melee close in, use Leg Sweep to buy some time. ";
		local EffectiveCooldowns = "Don't neglect Zen Sphere when you're under pressure. It's a decent heal, and once you get below 35% you can simply spam Expel Harm. Keep Guard up for the increase in healing and remember to drop your Ox Statue whenever your team is near.";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,EffectiveCooldowns)
	end},
	{'Tips & Tricks',function(f)
		local tips = "";
		local tricks = "";
		--TIPS_RETURN(tips,tricks)
	end},
	
});

EDGE:Register('MONK:PvP:Windwalker' ,{
	{'Overview', "The Windwalker Monk is a decent DPS and support class in arenas or rated battlegrounds. As one of the most mobile melee classes, they have little trouble closing gaps or even kiting as needed. While somewhat lacking in proper peels, the Windwalker can hold their own against most classes. "},
	{'Stat Priority', "Multistrike\nHaste >= Agility = PvP Power\nVersatility\nCritical Strike\nMastery"},
	{'Enchants', "Neck: Gift of Multistrike\nCloak: Gift of Multistrike\nRing: Gift of Multistrike\nWeapon: Mark of Warsong"},
	{'Gems', "Greater Multistrike Taladite"},
	{'Talents & Glyphs', function(f)
		local MajorGlyphs = {
			123391, -- Glyph of Touch of Death
			125678, -- Glyph of Touch Of Karma
			125755, -- Glyph of Paralysis
		};
		local MinorGlyphs = {
			125154, -- Glyph of Spirit Roll
			125901, -- Glyph of Water Roll
			123403, -- Glyph of Flying Serpent Kick
		};
		local Talents = {
			116841, -- Tiger's Lust
			115098, -- Chi Wave
			115399, -- Chi Brew
			119381, -- Leg Sweep
			122280, -- Healing Elixers
			116847, -- Rushing Jade Wind
			152174, -- Chi Explosion
		};
		local TalentTips = "The talents that are primarily utility-based are simply our general recommendation, your play style and raid needs should be priority when choosing these talents. The talent descriptions include some additional advice on when different utility talents are the most appropriate choice.";
		local GlyphTips = "Glyphs are situational, they depend on the make-up of your group as well as the enemies you're facing.That said, we suggest these because they seem to be all around the best for every situation.";
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',MajorGlyphs,MinorGlyphs,Talents,TalentTips,GlyphTips)
	end},
	{'Play Styles', function(f)
		local SingleTargetRotation = "Windwalkers will be better able to control enemies, burst down primary targets, and peel for teammates. Regardless of these changes, a monk's role is almost always chasing down hard to catch targets and immobilizing them until they can be killed. ";
		local MultiTargetRotation = "Try to resist the urge to use Roll on cooldown; instead, use it as a gap closer. Use Tiger's Lust to break roots or snares. Always disarm melee once they pop their cooldowns and use Touch of Karma when casters pop theirs. Let Fists of Fury tick at least once for the stun. ";
		local EffectiveCooldowns = "Due to the random nature of Windwalker bursts, you'll need to be smart about saving and lining up the cooldowns at your disposal. Save 10 stacks of Tiger's Brew and pool your energy before Combo Breaker procs for Blackout Kick and Tiger's Palm. Pop Xuen, then apply those and Rising Sun Kick, which you'll use on cooldown.";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,EffectiveCooldowns)
	end},
	{'Tips & Tricks',function(f)
		local tips = "";
		local tricks = "";
		--TIPS_RETURN(tips,tricks)
	end},
	
});

EDGE:Register('MONK:PvP:Mistweaver' ,{
	{'Overview', "This World of Warcraft PvP Mistweaver Monk guide is for players looking to optimize their character and gameplay to achieve optimal effectiveness in PvP end-game content like Battlegrounds and Arenas. Use this guide to help with your choices in optimizing gear, stats, and talents."},
	{'Stat Priority', "Intellect = PvP Power\nMultistrike\nCritical Strike\nSpirit\nVersatility\nHaste\nMastery"},
	{'Enchants', "Neck: Gift of Multistrike\nCloak: Gift of Multistrike\nRing: Gift of Multistrike\nWeapon: Mark of Shadowmoon"},
	{'Gems', "Greater Multistrike Taladite"},
	{'Talents & Glyphs', function(f)
		local MajorGlyphs = {
			124989, -- Glyph of LIfe Cocoon
			123763, -- Glyph of Mana Tea
			125755, -- Glyph of Paralysis
		};
		local MinorGlyphs = {
			125154, -- Glyph of Spirit Roll
			125901, -- Glyph of Water Roll
			123403, -- Glyph of Flying Serpent Kick
		};
		local Talents = {
			116841, -- Tiger's Lust
			115098, -- Chi Wave
			115399, -- Chi Brew
			116844, -- Ring of Peace
			122280, -- Healing Elixers
			123904, -- Invoke Xuen, the White Tiger
			173841, -- Pool of Mists
		};
		local TalentTips = "The talents that are primarily utility-based are simply our general recommendation, your play style and raid needs should be priority when choosing these talents. The talent descriptions include some additional advice on when different utility talents are the most appropriate choice.";
		local GlyphTips = "Glyphs are situational, they depend on the make-up of your group as well as the enemies you're facing.That said, we suggest these because they seem to be all around the best for every situation.";
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',MajorGlyphs,MinorGlyphs,Talents,TalentTips,GlyphTips)
	end},
	{'Play Styles', function(f)
		local SingleTargetRotation = "The strength of the Mistweaver Monk is in their ability to output massive amounts of burst healing. When paired with cooldowns, a Mistweaver can save a teammate from being burst down by multiple targets, but it does come at the cost of great mana strain. Additionaly, the Mistweaver is one of the most mobile healers and can provide some support through DPS, which also transfers healing. ";
		local MultiTargetRotation = "When playing Mistweaver, first realize that you cannot rely on Eminence alone and hope to keep your teammates alive through DPS. You'll need your strong heals: Surging Mist in particular. Place Healing Spheres strategically around the battlefield, as they offer the greatest HPS. Also place your Jade Serpent Statue in a central location. ";
		local EffectiveCooldowns = "Ideally you'll focus on one target at a time. Cast Soothing Mists just long enough to get a tick of it in, then use Surging Mist for burst healing and Enveloping Mist if the target is still being focused before switching back to Soothing Mists. ";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,EffectiveCooldowns)
	end},
	{'Tips & Tricks',function(f)
		local tips = "Don't neglect Renewing Mists, as you can HoT your whole team and then use Uplift for a powerful group heal. When significant burst is required, use Thunder Focus Tea, Soothing Mists, then Surging Mist. Follow up with a HoT as needed. Consume your Mana Tea stacks whenever they're off cooldown, but be prepared to need some DPS time to regen mana. ";
		local tricks = "";
		--TIPS_RETURN(tips,tricks)
	end},
	
});
]]
EDGE:Register('MONK:Leveling:Windwalker' ,{
	{'Stat Priority', "1 - Agility\n2 - Versatility (10%)\n3 - Haste = Critical Strike = Mastery"},
	{'Talents', function(f)
		local Talents = {
			115098, -- Chi Wave
			116841, -- Tiger's Lust
			115396, -- Ascension *
			119381, -- Leg Sweep
			122281, -- Healing Elixir*
			116847, -- Rushing Jade Wind
			196743, -- Chi Orbit*
		};
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',nil,nil,Talents,nil,nil)
	end},
	{'Rotation', function(f)
		local SingleTargetRotation = "1 - Fists of Fury\n2 - Whirling Dragon Punch\n4 - Tiger Palm\n5 - Rising Sun Kick\n6 - Chi Wave\n7 - Blackout Kick\n8 - Tiger Palm";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,nil)
	end},
	{'Buffs',function(f)
		local tips = "Guild Banners:\nBattle Standard of Cooperation\nStandard of Unity\nBattle Standard of Coordination\n\nFood:\nJumbo Sea Dog = 125 Versatility\nGorgrond Chowder = 100 Versatility\n\nFlask: \nGreater Draenic Agility Flask\n\nRune:\nHyper Augment Rune\n\nPotion:\nDraenic Agility Potion";
		local tricks = "";
		return EDGE:FillTemplate(f,'Tips',tips,tricks)
		--TIPS_RETURN(tips,tricks)
	end},
	
});

EDGE:Register('MONK:PvE:Brewmaster' ,{
	{'Stat Priority', "1 - Haste (30%)\n2 - Critical Strike = Mastery\n3 - Agility\n4 - Versatility"},
	{'Enchants', "Back - Enchant Cloak - Gift of Haste\nNeck - Enchant Neck - Gift of Haste\nRings - Enchant Ring - Gift of Haste\nWeapons - Enchant Weapon - Mark of Warsong"},
	{'Gems', "1 - Immaculate Haste Taladite\n2 - Greater Haste Taladite\n3 - Haste Taladite"},
	{'Talents', function(f)
		local Talents = {
			123986, -- Chi Burst
			115008, -- Chi Torpedo
			115399, -- Black Ox Brew
			119381, -- Leg Sweep
			122281, -- Healing Elixer
			196730, -- Special Delivery
			196736, -- Blackout Combo
		};
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',nil,nil,Talents,nil,nil)
	end},
	{'Rotation', function(f)
		local SingleTargetRotation = "1 - Keg Smash\n2 - Tiger Palm \n3 - Blackout Strike\n4 - Breath of Fire";
		local MultiTargetRotation = "1 - Keg Smash\n2 - Chi Burst\n3 - Rushing Jade Wind\n4 - Tiger Palm\n5 - Blackout Strike";
		local EffectiveCooldowns = "";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,nil)
	end},
	{'Buffs',function(f)
		local tips = "Food:\nButtered Sturgeon = 125 Haste\nFrosty Stew = 100 Haste\n\nFlask: \nGreater Draenic Stamina Flask\n\nRune:\nHyper Augment Rune\n\nPotion:\nDraenic Versatility Potion";
		local tricks = "";
		return EDGE:FillTemplate(f,'Tips',tips,tricks)
		--TIPS_RETURN(tips,tricks)
	end},
	
});
-- 7.0
EDGE:Register('MONK:PvE:Mistweaver' ,{
	{'Stat Priority', "1 - Intellect\n2 - Critical Strike\n3 - Versatility\n4 - Mastery\n5 - Haste"},
	{'Enchants', "Back - Enchant Cloak - Gift of Critical Strike\nNeck - Enchant Neck - Gift of Critical Strike\nRings - Enchant Ring - Gift of Critical Strike\nWeapons - Enchant Weapon - Mark of the Frostwolf"},
	{'Gems', "1 - Immaculate Critical Strike Taladite\n2 - Greater Critical Strike Taladite\n3 - Critical Strike Taladite"},
	{'Talents', function(f)
		local Talents = {
			123986, -- Chi Burst
			115008, -- Chi Torpedo
			197915, -- Lifecycles
			119381, -- Leg Sweep
			122278, -- Dampen Harm
			198664, -- Invoke Chi-Ji
			197908, -- Mana Tea
		};
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',nil,nil,Talents,nil,nil)
	end},
	{'Rotation', function(f)
		local SingleTargetRotation = "- Renewing Mist on cooldown. \n- Enveloping Mist maintained on healing target. It is refreshed with Vivify.\n\nLow Damage\n- Effuse, Envoloping Mist, Vivify, or Life Cocoon your target and channel Soothing Mist.\n\nMedium-High Damage\n- Use Effuse and Vivify";
		local MultiTargetRotation = "";
		local EffectiveCooldowns = "";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,nil)
	end},
	{'Buffs',function(f)
		local tips = "CONSUMABLES\n\nFood:\nButtered Sturgeon = 125 Critical Strike\nFrosty Stew = 100 Critical Strike\n\nFlask: \nGreater Draenic Intellect Flask\n\nRune:\nFocus Augment Rune\n\nPotion:\nDraenic Intellect Potion";
		local tricks = "";
		return EDGE:FillTemplate(f,'Tips',tips,tricks)
		--TIPS_RETURN(tips,tricks)
	end},
	
});
-- 7.0
EDGE:Register('MONK:PvE:Windwalker' ,{
	{'Stat Priority', "1 - Agility\n2 - Versatility (10%)\n3 - Haste = Critical Strike = Mastery"},
	{'Enchants', "Back - Enchant Cloak - Gift of Versatility\nNeck - Enchant Neck - Gift of Versatility\nRings - Enchant Ring - Gift of Versatility\nWeapons - Enchant Weapon - Mark of Shadowmoon"},
	{'Gems', "1 - Immaculate Versatility Taladite\n2 - Greater Versatility Taladite\n3 - Versatility Taladite"},
	{'Talents', function(f)
		local Talents = {
			115098, -- Chi Wave
			116841, -- Tiger's Lust
			115288, -- Energizing Elixer
			119381, -- Leg Sweep
			122278, -- Dampen Harm
			116847, -- Rushing Jade Wind
			152175, -- Whirling Dragon Punch
		};
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',nil,nil,Talents,nil,nil)
	end},
	{'Rotation', function(f)
		local SingleTargetRotation = "1 - Fists of Fury\n2 - Whirling Dragon Punch\n4 - Tiger Palm\n5 - Rising Sun Kick\n6 - Chi Wave\n7 - Blackout Kick\n8 - Tiger Palm";
		local MultiTargetRotation = "2-3 Targets:\n\n1 - Whirling Dragon Punch\n2 - Fists of Fury\n3 - Rising Sun Kick\n4 - Rushing Jade Wind\n4 - Chi Burst\n5 - Spinning Crane Kick\n6 - Blackout Kick\n7 - Tiger Palm\n\n4+ Targets:\n1 - Whirling Dragon Punch\n2 - Fists of Fury\n3 - Rising Sun Kick\n4 - Rushing Jade Wind\n5 - Spinning Crane Kick\n5 - Chi Burst\n6 - Blackout Kick\n7 - Tiger Palm";
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