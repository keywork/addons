local ADDON_NAME, EDGE = ...;
--[[
EDGE:Register('DRUID:Leveling:Feral' ,{
	{'Overview', "The Feral Druid is a melee DPS class that utilizes an energy bar but can still shift out and heal itself if necessary. Feral druids do a lot of damage and have little-to-no downtime while leveling."},
	{'Stat Priority', "Agility\nCritical Strike\nMultistrike\nHaste >= Versatility\nMastery"},
	{'Enchants', "When leveling, unless you're an Enchanter with lots of mats, don't bother with Enchants. You'll have to add a new one too often with the amount you change gear while leveling."},
	{'Gems', "Do NOT use Gems until max level. Otherwise you're going to spend too much to make it worth gemming each item you can. "},
	{'Talents & Glyphs', function(f)
		local MajorGlyphs = {
			67598, -- Ferocious Bite
			116172, -- Master Shape Shifter
			47180, -- Cat Form
		};
		local MinorGlyphs = {
			114280, -- The Predator
			107059, -- Chameleon
			57856, -- Aquatic Form
		};
		local Talents = {
			131768, -- Feline Swiftness
			145108, -- Ysera's Gift
			132469, -- Typhoon
			158476, -- Force of Nature
			5211, -- Mighty Bash
			158497, -- Dream of Cenarius
			171746, -- Claws of Shirvallah
		};
		local TalentTips = "The talents that are primarily utility-based are simply our general recommendation, your play style and raid needs should be priority when choosing these talents. The talent descriptions include some additional advice on when different utility talents are the most appropriate choice.";
		local GlyphTips = "Glyphs are situational, they depend on the make-up of your group as well as the enemies you're facing.That said, we suggest these because they seem to be all around the best for every situation.";
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',MajorGlyphs,MinorGlyphs,Talents,TalentTips,GlyphTips)
	end},
	{'Play Styles', function(f)
		local SingleTargetRotation = "1. Use Shred to generate Combo Points.\n2. Keep Savage Roar up.\n3. Maintain Rake on the target.\n4. Maintain Rip on the target, with 5 combo points.\n5. Swipe if needed.";
		local MultiTargetRotation = "See normal rotation.Add Thrash.";
		local EffectiveCooldowns = "Berserk: DPS Increase.\nTiger's Fury: Use on cooldown, or save for very powerful enemies.\nSurvival Instincts: Use to greatly reduce incoming damage.";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,EffectiveCooldowns)
	end},
	{'Tips & Tricks', function(f)
		local tips = "If your target will die fast, use Ferocious Bite to spend your Combo points instead of rip.\nAgainst multiple targets use Thrash on cooldown to keep the bleed on them. Swipe as well will strike more than one target.";
		local tricks = "As always while leveling, kill everything you see, it'll help you get your rotation set and ready.";
		--TIPS_RETURN(tips,tricks)
	end},
	
});

EDGE:Register('DRUID:Leveling:Balance' ,{
	{'Overview', "The Balance Druid is a ranged caster DPS capable of high burst damage and strong AoE. This spec is also able to heal itself when necessary and has little-to-no downtime due to innvervate."},
	{'Stat Priority', "Intellect\nCritical Strike = Mastery >= Haste = Multistrike\nVersatility"},
	{'Enchants', "When leveling, unless you're an Enchanter with lots of mats, don't bother with Enchants. You'll have to add a new one too often with the amount you change gear while leveling."},
	{'Gems', "Do NOT use Gems until max level. Otherwise you're going to spend too much to make it worth gemming each item you can. "},
	{'Talents & Glyphs', function(f)
		local MajorGlyphs = {
			40916, -- Astral Communion
			45604, -- Stampeding Roar
			54733, -- Rebirth
		};
		local MinorGlyphs = {
			114301, -- Stars
			57856, -- Aquatic Form
			114295, -- Grace
		};
		local Talents = {
			131768, -- Feline Swiftness
			145108, -- Ysera's Gift
			132469, -- Typhoon
			33831, -- Force of Nature
			5211, -- Mighty Bash
			108291, -- Heart of the Wild
			152222, -- Euphoria
		};
		local TalentTips = "The talents that are primarily utility-based are simply our general recommendation, your play style and raid needs should be priority when choosing these talents. The talent descriptions include some additional advice on when different utility talents are the most appropriate choice.";
		local GlyphTips = "Glyphs are situational, they depend on the make-up of your group as well as the enemies you're facing.That said, we suggest these because they seem to be all around the best for every situation.";
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',MajorGlyphs,MinorGlyphs,Talents,TalentTips,GlyphTips)
	end},
	{'Play Styles', function(f)
		local SingleTargetRotation = "1. Apply Moonfire and Sunfire on targets that will live more than 10 seconds.\n2. Cast Starsurge often enough to keep it's charges rolling.\n3. Cast Wrath in Solar Eclipse.\n4. Starfire while you are in Lunar Eclipse.";
		local MultiTargetRotation = "Always keep Starfall rolling, use your Damage Over Time abilities on the targets if they live long enough.";
		local EffectiveCooldowns = "Celestial Alignment: DPS Increase\nBarkskin: Use to reduce incoming Damage.\nHealing Touch: Heal thyself.";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,EffectiveCooldowns)
	end},
	{'Tips & Tricks', function(f)
		local tips = "Run between stuff, use your travel abilities to move even if it's a few yards.\nKill everything you want to sneak by. It's good exp and great practice. ";
		local tricks = nil;
		--TIPS_RETURN(tips,tricks)
	end},
	
});

EDGE:Register('DRUID:PvP:Balance' ,{
	{'Overview', "This is the base build for a PVP Balance Druid. All of the spells, skills, and talents are geared toward fighting in a PVP environment."},
	{'Stat Priority', "Multistrike = Haste\nMastery = Intellect = PvP Power\nCritical Strike >= Versatility"},
	{'Enchants', "Neck: Gift of Multistrike\nCloak: Gift of Multistrike\nRing: Gift of Multistrike\nWeapon: Mark of Warsong"},
	{'Gems', "Greater Multistrike Taladite"},
	{'Talents & Glyphs', function(f)
		local MajorGlyphs = {
			48514, -- Glyph of Cyclone
			54733, -- Glyph of Rebirth
			59219, -- Glyph of Dash
		};
		local MinorGlyphs = {
			114295, -- Glyph of Grace
			114338, -- Glyph of the Stag
			114301, -- Glyph of Stars
		};	
		local Talents = {
			102280, -- Displacer Beast
			102351, -- Cenarion Ward
			132469, -- Typhoon
			33831, -- Force of Nature
			99, -- Incapacitating Roar
			108373, -- Dream of Cenarius
			152222, -- Euphoria
		};
		local TalentTips = "The talents that are primarily utility-based are simply our general recommendation, your play style and raid needs should be priority when choosing these talents. The talent descriptions include some additional advice on when different utility talents are the most appropriate choice.";
		local GlyphTips = "Glyphs are situational, they depend on the make-up of your group as well as the enemies you're facing.That said, we suggest these because they seem to be all around the best for every situation.";
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',MajorGlyphs,MinorGlyphs,Talents,TalentTips,GlyphTips)
	end},
	{'Play Styles', function(f)
		local SingleTargetRotation = "Melee Opponent:\nCast Cyclone on your target and drop Wild Mushrooms below them if you get the jump on them\nCast Detonate Wild Mushrooms when Cyclone Ends\nCast Entangling Roots\nApply Moonfire and Sunfire\nCast Wrath or Starfire, depending on which Eclipse you are going into\nCast Typhoon to knock the target away when  they are in Melee range\nCast Starsurge on cooldown \nCaster Opponent:\nCast Cyclone on your target if you get the jump on them\nCast Entangling Roots\nCast Solar Beam on top of their rooted location\nApply Moonfire and Sunfire\nCast Wrath or Starfire, depending on which Eclipse you are going into\nCast Typhoon to knock them back and interupt casting if they are within range\nCast Starsurge on cooldown";
		local MultiTargetRotation = "Cast Wild Mushrooms and detonate on multiple targets\nCast Solar Beam on healers\nCast Starfall";
		local EffectiveCooldowns = "Buff with Mark of the Wild. \n ";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,EffectiveCooldowns)
	end},
	{'Tips & Tricks', function(f)
		local tips = nil;
		local tricks = nil;
		--TIPS_RETURN(tips,tricks)
	end},
	
});

EDGE:Register('DRUID:PvP:Feral' ,{
	{'Overview', "This is the base build for a PVP Feral Druid. All of the spells, skills, and talents are geared toward fighting in a PVP environment."},
	{'Stat Priority', "Agility = PvP Power\nMultistrike\nVersatility\nHaste >= Critical Strike\nMastery"},
	{'Enchants', "Neck: Gift of Multistrike\nCloak: Gift of Multistrike\nRing: Gift of Multistrike\nWeapon: Mark of the Frostwolf"},
	{'Gems', "Greater Multistrike Taladite"},
	{'Talents & Glyphs', function(f)
		local MajorGlyphs = {
			127540, -- Glyph of Savage Roar
			47180, -- Glyph of Cat Form
			67598, -- Glyph of Ferocious Bite
		};
		local MinorGlyphs = {
			114295, -- Glyph of Grace
			114338, -- Glyph of the Stag
			107059, -- Chameleon
		};
		local Talents = {
			102280, -- Displacer Beast
			102351, -- Cenarion Ward
			132469, -- Typhoon
			102703, -- Force of Nature
			99, -- Incapacitating Roar
			158497, -- Dream of Cenarius
			171746, -- Claws of Shirvallah
		};
		local TalentTips = "The talents that are primarily utility-based are simply our general recommendation, your play style and raid needs should be priority when choosing these talents. The talent descriptions include some additional advice on when different utility talents are the most appropriate choice.";
		local GlyphTips = "Glyphs are situational, they depend on the make-up of your group as well as the enemies you're facing.That said, we suggest these because they seem to be all around the best for every situation.";
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',MajorGlyphs,MinorGlyphs,Talents,TalentTips,GlyphTips)
	end},
	{'Play Styles', function(f)
		local SingleTargetRotation = "Feral Druids are can take down an enemy in seconds with the right cooldowns up. They are extremely strong against clothies and can dual it out with any other melee class for a while due to their high survivability and cooldowns. Also, Druids in general are the best class when it comes to running flags and holding nodes due to their high mobility and excellent survivability.";
		local MultiTargetRotation = "See Single target/Effective Cooldowns.";
		local EffectiveCooldowns = "1. Mangle\n2. Tiger's Fury\n3. Shred\n4. Rake/Rip depending on your combo points.";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,EffectiveCooldowns)
	end},
	{'Tips & Tricks', function(f)
		local tips = "When it comes to PVP, all talents can be useful in different situations. ";
		local tricks = "The glyphs you choose will be dependent on what type of PVP you are doing and personal preference. We've listed some recommendations to get you started";
		--TIPS_RETURN(tips,tricks)
	end},
	
});

EDGE:Register('DRUID:PvP:Resoration' ,{
	{'Overview', "This is the base build for a PVP Restoration Druid. All of the spells, skills, and talents are geared toward fighting in a PVP environment."},
	{'Stat Priority', "StatList\n"},
	{'Enchants', "Neck: \nCloak: \nRing: \nWeapon: "},
	{'Gems', ""},
	{'Talents & Glyphs', function(f)
		local MajorGlyphs = {
			63057, -- Glyph of Barkskin
			121840, -- Glyph of Blooming
			116218, -- Glyph of Regrowth
		};
		local MinorGlyphs = {
			114295, -- Glyph of Grace
			114338, -- Glyph of the Stag
			57856, -- Glyph of Aquatic Form
		};
		local Talents = {
			102280, -- Displacer Beast
			102351, -- Cenarion Ward
			132469, -- Typhoon
			102693, -- Force of Nature
			99, -- Incapacitating Roar
			158497, -- Dream of Cenarius
			171746, -- Claws of Shirvallah
		};
		local TalentTips = "When it comes to PVP, all talents can be useful in different situations. The talents listed below are the most useful and common selections when PVP'ing on a Restoration Druid.";
		local GlyphTips = "Glyphs are situational, they depend on the make-up of your group as well as the enemies you're facing.That said, we suggest these because they seem to be all around the best for every situation.\n-Displacer Beast, Typhoon, and Incapacitating Roar: Useful for survivability, utility, and control of enemies.\nForce of Nature and Nature's Vigil: Increases damage and adds burst\nNature's Swiftness: Useful for an instant heal or crowd control";
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',MajorGlyphs,MinorGlyphs,Talents,TalentTips,GlyphTips)
	end},
	{'Play Styles', function(f)
		local SingleTargetRotation = "Healing over Time:\nCast Lifebloom on yourself or on a nearby target. It's extremely important to always keep Lifebloom up\nCast Rejuvenation on targets to set up Swiftmend\n";
		local MultiTargetRotation = "Direct Healing:\nIt's important to keep your HoT's on targets at all times but if you need to direct heal, these options are the best\nCast Healing Touch\nCast Regrowth as an emergency heal";
		local EffectiveCooldowns = "Know your spells, can't list all the others here. ";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,EffectiveCooldowns)
	end},
	{'Tips & Tricks', function(f)
		local tips = "Restoration Druids are strong PvP healers due to their massive amount of defensive cooldowns and the ability to get away. In addition to excellent survivability, resto druids heal over time and these heals are very effective in the PvP environment. Also, Druids in general are the best class when it comes to running flags and holding nodes due to their high mobility and excellent survivability.";
		local tricks = nil;
		--TIPS_RETURN(tips,tricks)
	end},
	
});

EDGE:Register('DRUID:PvP:Guardian' ,{
	{'Overview', "The Guardian Druid is an ideal choice for players that enjoy an active tank rotation based on generating rage and using minor survival cooldowns appropriately. In addition to being fantastic tanks, a Guardian Druid also pulls high DPS capable of competing with other DPS classes while they tank."},
	{'Stat Priority', "Armor\nStamina\nMultistrike\nBonus Armor\nMastery\nVersatility >= Haste\nAgility = PvP Power\nCritical Strike"},
	{'Enchants', "Neck: Gift of Multistrike\nCloak: Gift of Multistrike\nRing: Gift of Multistrike\nWeapon: Mark of the Frostwolf"},
	{'Gems', "Greater Stamina Taladite"},
	{'Talents & Glyphs', function(f)
		local MajorGlyphs = {
			114237, -- Fae Silence
			54733, -- Rebirth
			114222, -- Stampeding Roar
		};
		local MinorGlyphs = {
			114295, -- Grace
			107059, -- the Chameleon
			114338, -- The Stag
		};
		local Talents = {
			102280, --Displacer Beast
			108238, -- Renewal
			132469, -- Typhoon
			102706, -- Force of Nature
			99, -- Incapacitating Roar
			158501, -- Dream of Cenarius
			155835, -- Bristling Fur
		};
		local TalentTips = "The talents that are primarily utility-based are simply our general recommendation, your play style and raid needs should be priority when choosing these talents. The talent descriptions include some additional advice on when different utility talents are the most appropriate choice.";
		local GlyphTips = "Glyphs are situational, they depend on the make-up of your group as well as the enemies you're facing.That said, we suggest these because they seem to be all around the best for every situation.";
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',MajorGlyphs,MinorGlyphs,Talents,TalentTips,GlyphTips)
	end},
	{'Play Styles', function(f)
		local SingleTargetRotation = "Single Target Tanking Rotation:\nMangle on cooldown\nKeep Thrash's Bleed effect up on target\nLacerate spam\nMaul\nOnly when you are under Tooth and Claw proc\nOnly when you are at or very close to max rage\nOnly wehn you do not need to use your active mitigation";
		local MultiTargetRotation = "Multiple Target Tanking Rotation:\nSpam Thrash\nMangle on cooldown\nMaul (restrictions same as above)";
		local EffectiveCooldowns = "Taunting: \nGrowl\nCooldowns:\nFrenzied Regeneration\nsavage Defence\nSurvival Instincts\nBarkskin\nBerserk before mangle is used";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,EffectiveCooldowns)
	end},
	{'Tips & Tricks', function(f)
		local tips = "Keep in mind PVP is so fluid there's no way you'll get a set rotation to use. the best thing is to learn your class so you \nknow when to use each spell and see situations where some are useless. That said, here's a suggested 'rotation' to use \nwhile you learn your spells better for the PvP environment.";
		local tricks = "Buff: Mark of the Wild";
		--TIPS_RETURN(tips,tricks)
	end},
	
});
]]
EDGE:Register('DRUID:Leveling:Feral' ,{
	{'Stat Priority', "Agility\nCritical Strike\nVersatility = Mastery\nHaste"},
	{'Talents & Glyphs', function(f)
		local Talents = {
			202021, -- Predator
			102280, -- Displacer Beast 
			197492, -- Restoration Affinity
			5211, -- Mighty Bash
			158478, -- Soul of the Forest
			202032, -- Jagged Wounds
			155672, -- Bloodtalons
		};
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',nil,nil,Talents,nil,nil)
	end},
	{'Rotation', function(f)
		local SingleTargetRotation = "1 - Rake to DOT target and make Shred do 20% more damage\n2 - Shred as your main damage ability and build combo points\n3 - Rip if target has a lot of health, otherwise Ferocious Bite\n\n- Prowl for 20% damage boost on opening move\n- Tiger's Fury for energy and damage boost\n- Berserk ";
		local MultiTargetRotation = "- Thrash to apply dots\n- Swipe";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,nil)
	end},
	{'Buffs', function(f)
		local tips = "Guild Banners:\nBattle Standard of Cooperation\nStandard of Unity\nBattle Standard of Coordination\n\nFood:\nPickled Eel = 125 Critical Strike\nBlackrock Barbeque = 100 Critical Strike\n\nFlask:\nGreater Draenic Agility Flask\n\nRune:\nHyper Augment Rune\n\nPotion:\nDraenic Agility Potion";
		local tricks = "";
		return EDGE:FillTemplate(f,'Tips',tips,tricks)
		--TIPS_RETURN(tips,tricks)
	end},
	
});
EDGE:Register('DRUID:PvE:Balance' ,{
	{'Stat Priority', "Intellect\nHaste\nCritical Strike\nMastery\nVersatility"},
	{'Enchants', "Neck: Gift of Haste\nCloak: Gift of Haste\nRing: Gift of Haste\nWeapon: Mark of Warsong"},
	{'Gems', "Immaculate Haste Taladite\nGreater Haste Taladite\nHaste Taladite"},
	{'Talents', function(f)
		local Talents = {
			202345, -- Starlord
			108238, -- Renewal
			197491, -- Guardian Affinity
			5211, -- Mighty Bash
			202347, -- Stellar Flare
			202342, -- Shooting Stars
			202354, -- Stellar Drift
		};
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',nil,nil,Talents,nil,nil)
	end},
	{'Rotation', function(f)
		local SingleTargetRotation = "1 - Moonfire, Sunfire and Stellar Flare on target at all times.\n2 - Solar Wrath for Astral Power.\n3 - Starsurge";
		local MultiTargetRotation = "1 - Moonfire and Sunfire higher health targets\n2 - Stellar Flare targets living longer than 10 seconds\n3 - Incarnation: Chosen of Elune";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,nil)
	end},
	{'Buffs', function(f)
		local tips = "Food:\nButtered Sturgeon = 125 Haste\nFrosty Stew = 100 Haste\n\nFlask:\nGreater Draenic Intellect Flask\n\nRune:\nFocus Augment Rune\n\nPotion:\nDraenic Intellect Potion";
		local tricks = nil;
		return EDGE:FillTemplate(f,'Tips',tips,tricks)
	end},
	
});
-- 7.0
EDGE:Register('DRUID:PvE:Feral' ,{
	{'Stat Priority', "STANDARD\nAgility\nCritical Strike\nVersatility = Mastery\nHaste\n\nINCARNATION: KING OF THE JUNGLE\nAgility\nCritical Strike (50%)\nVersatility\nCritical Strike\nMastery\nHaste"},
	{'Enchants', "Neck: Gift of Critical Strike\nCloak: Gift of Critical Strike\nRing: Gift of Critical Strike\nWeapon: Mark of the Thunderlord"},
	{'Gems', "Immaculate Critical Strike Taladite\nGreater Critical Strike Taladite\nCritical Strike Taladite"},
	{'Talents & Glyphs', function(f)
		local Talents = {
			155580, -- Lunar Inspiration
			132302, -- Wild Charge
			197488, -- Balance Affinity
			5211, -- Mighty Bash
			102543, -- Incarnation King of the Jungle
			202032, -- Jagged Wounds
			155672, -- Bloodtalons
		};
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',nil,nil,Talents,nil,nil)
	end},
	{'Rotation', function(f)
		local SingleTargetRotation = "1 - Rake\n2 - Shred\n3 - Rip (5 points) or Ferocious Bite if less than 25% health to maintain Rip.\n4 - Ferocious Bite ";
		local MultiTargetRotation = "2-3 Targets:\n1 - Rake and Thrash all targets.\n2 - Shred\n\n4-8 Targets:\n1 - Rake and Thrash on all targets.\n2 - Rip when possible\n\n9+ Targets:\n1 - Thrash \n2 - Swipe\n3 - Rip when possible";
		local EffectiveCooldowns = "";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,nil)
	end},
	{'Buffs', function(f)
		local tips = "Food:\nPickled Eel = 125 Critical Strike\nBlackrock Barbeque = 100 Critical Strike\n\nFlask:\nGreater Draenic Agility Flask\n\nRune:\nHyper Augment Rune\n\nPotion:\nDraenic Agility Potion";
		local tricks = "";
		return EDGE:FillTemplate(f,'Tips',tips,tricks)
		--TIPS_RETURN(tips,tricks)
	end},
	
});
-- 7.0
EDGE:Register('DRUID:PvE:Guardian' ,{
	{'Stat Priority', "Mastery\nHaste\nVersatility\nAgility\nCritical Strike"},
	{'Enchants', "Neck: Gift of Mastery\nCloak: Gift of Masstery\nRing: Gift of Mastery\nWeapon: Mark of the Bleeding Hollow"},
	{'Gems', "Immaculate Mastery Taladite\nGreater Mastery Taladite\nMastery Taladite"},
	{'Talents', function(f)
		local Talents = {
			203962, -- Blood Frenzy
			204012, -- Guttural Roars
			197492, -- Restoration Affinity
			5211, -- Mighty Bash
			102558, -- Incarnation: Guardian of Ursoc
			155578, -- Guardian of Elune
			204053, -- Rend and Tear
		};
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',nil,nil,Talents,nil,nil)
	end},
	{'Rotation', function(f)
		local SingleTargetRotation = "1 - Mangle\n2 - Thrash\n3 - Moonfire\n4 - Swipe\n6 - Maul";
		local MultiTargetRotation = "1 - Thrash\n2 - Mangle\n3 - Moonfire on targets\n4 - Swipe\n5 - Maul";
		local EffectiveCooldowns = "";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,nil)
	end},
	{'Buffs', function(f)
		local tips = "Food:\nSleeper Sushi = 125 Mastery\nSleeper Suprise = 100 Mastery\n\nFlask:\nGreater Draenic Stamina Flask\n\nRune:\nHyper Augment Rune\n\nPotion:\nDraenic Agility Potion";
		local tricks = "";
		return EDGE:FillTemplate(f,'Tips',tips,tricks)
		--TIPS_RETURN(tips,tricks)
	end},
	
});
-- 7.0
EDGE:Register('DRUID:PvE:Restoration' ,{
	{'Stat Priority', "Intellect\nHaste\nCritical Strike\nMastery\Versatility"},
	{'Enchants', "Neck: Gift of Haste\nCloak: Gift of Haste\nRing: Gift of Haste\nWeapon: Mark of Warsong"},
	{'Gems', "Immaculate Haste Taladite\nGreater Haste Taladite\nHaste Taladite"},
	{'Talents', function(f)
		local Talents = {
			200383, -- Prosperity
			108238, -- Renewal
			197491, -- Guardian Affinity
			5211, -- Mighty Bash
			158478, -- Soul of the Forest
			207385, -- Spring Blossoms
			197721, -- Flourish
		};
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',nil,nil,Talents,nil,nil)
	end},
	{'Rotation', function(f)
		local SingleTargetRotation = "1 - Efflorescence \n2 - Lifebloom(1 target), Regrowth and Rejuvenation on targets\n3 - Healing Touch if damage too much.\n4 - Swiftmend to burst heal in emergencies.\n5 - Ironbark if target still dying too fast.";
		local MultiTargetRotation = "1 - Efflorescence\n2 - Rejuvenate targets taking more damage\n3 - Wild Growth when calm\4 - Swiftmend when health gets low.";
		local EffectiveCooldowns = "";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,nil)
	end},
	{'Buffs', function(f)
		local tips = "Food:\nButtered Sturgeon = 125 Haste\nFrosty Stew = 100 Haste\n\nFlask: \nGreater Draenic Intellect Flask\n\nRune:\nFocus Augment Rune\n\nPotion:\nDraenic Intellect Potion";
		local tricks = "";
		return EDGE:FillTemplate(f,'Tips',tips,tricks)
		--TIPS_RETURN(tips,tricks)
	end},
	
});