local ADDON_NAME, EDGE = ...;

--[[
EDGE:Register('DEATHKNIGHT:Leveling:Frost' ,{
	{'Overview', "You can use Dual-Wield, or one Two-Hand weapon with this setup. There are minor differences in the rotation and important stats. Either way, frost is a great spec for leveling, (some argue the best of the three). You have a lot of damage dealing capability, with survivable help in many different utility spells. All in all a great spec to use if you want to minimize your downtime and just keep tearing through stuff to level quickly."},
	{'Stat Priority', "Dual-Wielding Weapons:\n1.Strength\n2.Mastery\n3.Multistrike\n4.Versatility\n5.Haste\n6.Critical Strike\n\nTwo Hand Weapon:\n1.Strength\n2.Multistrike\n3.Versatility\n4.Mastery\n5.Haste\n6.Critical Strike"},
	{'Enchants', "When leveling, unless you're an Enchanter with lots of mats, don't bother with Enchants. You'll have to add a new one too often with the amount you change gear while leveling."},
	{'Gems', "Do NOT use Gems until max level. Otherwise you're going to spend too much to make it worth gemming each item you can. "},
	{'Talents & Glyphs', function(f)
		local MajorGlyphs = {
			58673, -- Glyph of Icebound Fortitude
			58623, -- Glyh of Anti-Magic Shell
			59327, -- Glyph of DaUnholy Command
		};
		local MinorGlyphs = {
			59307, -- Glyph of Path of Frost
			58669, -- Glyph of Army of the Dead
			63335, -- Glyph of Tranquil Grip
		};
		local Talents = {
			123693, -- Plague Leech
			49039, -- Lichborne
			96268, -- Death's Advance
			45529, -- Blood Tap
			108196, -- Death Siphon
			108200, -- Remorseless Winter
			152279, -- Breath of Sindragosa
		};
		local TalentTips = "Read through the talents we've selected here, the only one that's not apparent right off is Remorseless Winter. For leveling, the stun you get is super helpful for keeping you alive while you adventure.";
		local GlyphTips = "Glyphs are pretty much your choice, beyond Unholy Command and Anti-Magic shell you can choose whatever you'd like, we just put the most fun ones we could find for the remainder. ";
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',MajorGlyphs, MinorGlyphs, Talents, TalentTips, GlyphTips)
	end},
	{'Play Styles', function(f)
		local SingleTargetRotation = "Always be in Frost Presence\nApply Soul Reaper at 87 at the start of every fight\nPut diseases on the target (Use Outbreak if available otherwise use Howling Blast and Plague Strike\nUse Howling Blast if you get a Rime proc.\nUse Killing Machine Procs on Obliterate (2H Weapon) or Frost Strike (Dual Wield)\nUse Obliterate the rest of the time\nDump Runic Power with Frost Strike (don't let Runic Power get to Max).";
		local MultiTargetRotation = "Follow normal Single Target Rotation\nApply Blood Boil right after you apply disease to one target and it will move the diseases to all targets nearby.\nIf targets are stationary also use Death and Decay on Cooldown.";
		local EffectiveCooldowns = "Use Blood Tap to activate more runes if needed.\nPlague Leech should be used when target is almost dead so you can pick up the death runes.\nUse Death Grip and Death's Advance on cooldown to save you a lot of time.\nPillar of Frost: Use on Cooldown\nArmy of the Dead: Use when fighting a strong enemy(s)\nEmpower Rune Weapon: Burst Damage helper.\nDeath Siphon: DPS loss but heals you.\nDeath Strike:Use to heal yourself and do minor damage\nIcebound Fortitude: Reduce incoming damage and protect against stuns\nLichborne: Use to get extra healing.";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,EffectiveCooldowns)
	end},
	{'Tips & Tricks', function(f)
		local tips = "1. Use High damage slow speed weapon if you choose the 2H setup.\n2. Use Rune of the Fallen Crusader on your weapon(s)\n";
		local tricks = nil;
		-- TIPS_RETURN(tips,tricks)
	end},
	
});

EDGE:Register('DEATHKNIGHT:Leveling:Unholy' ,{
	{'Overview', "The Unholy Death Knight is an excellent leveling build. You get a pet and loads of DPS in a sweet little package."},
	{'Stat Priority', "Strength\nMultistrike\nMastery\nCritical Strike\nVersatility\nHaste"},
	{'Enchants', "When leveling, unless you're an Enchanter with lots of mats, don't bother with Enchants. You'll have to add a new one too often with the amount you change gear while leveling."},
	{'Gems', "Do NOT use Gems until max level. Otherwise you're going to spend too much to make it worth gemming each item you can. "},
	{'Talents & Glyphs', function(f)
		local MajorGlyphs = {
			58673, -- Glyph of Icebound Fortitude
			58623, -- Glyph of Anti-Magic Shell
			152281, -- Glyph of Unholy Command
		};
		local MinorGlyphs = {
			59307, -- Glyph of Path of Frost
			58669, -- Glyph of Army of the Dead
			63335, -- Glyph of Tranquil Grip
		};
		local Talents = {
			123693, -- Plague Leech
			49039, -- Lichborne
			96268, -- Death's Advance
			51462, -- Runic COrruption
			108196, -- Death Siphon
			108200, -- Remorseless Winter
			152281, -- Necrotic Plague
		};
		local TalentTips = "These are the suggested talents that will lend themselves to help the most while you're leveling. With that in mind, feel free to try other setups if you'd like, best time to expiriment is while you're leveling.";
		local GlyphTips = "Besides Unholy Command and Anti-Magic shell, the rest of the glyphs are entirely up to you. We put these in there, just as placeholders, if you want to use other glyphs go for it!";
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',MajorGlyphs,MinorGlyphs,Talents,TalentTips,GlyphTips)
	end},
	{'Play Styles', function(f)
		local SingleTargetRotation = "1. Put your diseases on the target: Outbreak or Plague Strike if Outbreak isn't available.\n2. Cast Dark Transformation on cooldown, unless the target is about to die.\n3. Cast Scourge Strike when available\n4. Cast Festering Strike when available\n5. Use Death Coil when you have procs from Sudden Doom and to dump runic power.\n5. Always use Frost Presence\n6. Plague Leech should be used when target is almost dead so you get a death rune.";
		local MultiTargetRotation = "1. Keep up your single target rotation with the following differences.\n2. Use Blood Boil to spread your diseases\n3. Use Death and Decay on cooldown if you can keep the targets in the AOE area.";
		local EffectiveCooldowns = "Summon Gargoyle: Use against powerful enemies\nArmy of the Dead: Use when overwhelmed by a lot of enemies or if you're fighting a strong enemy.\nEmpower Rune Weapon: Use to get a burst of damage.\nDeath Siphon: Self heal\nDeath Strike: Self Heal\nIcebound Fortitude: Reduce incoming damage and immune from stuns.\nLichborne: Use to self heal";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,EffectiveCooldowns)
	end},
	{'Tips & Tricks', function(f)
		local tips = "1. Use High damage slow speed weapon 2-Hand Weapons are best.\n2. Use Rune of the Fallen Crusader on your weapon(s)\nDon't forget Death Grip and Death's Advance to save a lot of time.";
		local tricks = "Use Soul Reaper after level 87, place a debuff on every target you fight. While leveling this ends up giving you a good buff if you kill the target before the debuff wears off. ";
		-- TIPS_RETURN(tips,tricks)
	end},
	
});


EDGE:Register('DEATHKNIGHT:PvP:Frost' ,{
	{'Overview', "This is the base build for a Death Knight: Frost in PVP. It includes all the specs you need as well as tips and tricks to get you started in PVP."},
	{'Stat Priority', "Multistrike\nStrength = PvP Power\nVersatility = Haste\nMastery\nCritical Strike"},
	{'Enchants', "Neck: Gift of Multistrike\nCloak: Gift of Multistrike\nRing: Gift of Multistrike\nWeapon:(Mainhand)Rune of the Fallen Crusader, (Offhand) Rune of Razorice"},
	{'Gems', "Greater Multistrike Taladite"},
	{'Talents & Glyphs', function(f)
		local MajorGlyphs = {
			58623, -- Glyph of Anti-Magic Shell
			146648, -- Glyph of REgenerative Magic
			58631, -- Glyph of Icy Touch
		};
		local MinorGlyphs = {
			59309, -- Glyph of Resilient Grip
			58642, -- Glyph of Foul Menagerie
			58677, -- Glyph of Death's Embrace
		};
		local Talents = {
			123693, -- Plague Leech
			49039, -- Lichborne
			108194, -- Asphyxiate
			45529, -- Blood Tap
			119975, -- Conversion
			108201, -- Desecrated Ground
			152280, -- Defile
		};
		local TalentTips = "Unholy Blight, Aspyhxiate and Conversion provide utility, but you can replace them with others in the same tier. Lichborne, Runic Empowerment and Remorseless Winter are required and increase your survivability. Blood tap helps regen runes, and controlling your runes is essential in PVP.";
		local GlyphTips = "Glyphs are all situational. They depend on the make-up of your team and the enemies you face. That in mind, we picked suggestions that will work best for most situations, and the minros are pretty much your choice.\nAnti-Magic Shell increases survivability, Dark SImalcrum improves utility, and Icy Touch Applies constant dispel pressure.";
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',MajorGlyphs,MinorGlyphs,Talents,TalentTips,GlyphTips)
	end},
	{'Play Styles', function(f)
		local SingleTargetRotation = "Cast your diseases, by doing outbreak or casting them individually. Keep them on the target all the time.\nHowling Blast when Rime procs. \nFrost Strike when kIlling machine procs. \nObliterate when you have 1 Frost and unholy runes or 2 death runes. \nKeep Horn of Winter on cooldown. ";
		local MultiTargetRotation = "See Single Target";
		local EffectiveCooldowns = "ALL your other spells, very few do not come in useful in PvP. ";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,EffectiveCooldowns)
	end},
	{'Tips & Tricks', function(f)
		local tips = "1. Use 2 1-Hand Weapons\n2. pay attention to your Runes. It's essential in PvP and it'll help you kill better too!\n3. Setup a macro to stance dance: /castsequence Blood Presence, Frost Presence some things can sometimes work better in another stance and this will get you back and forth quick.";
		local tricks = "Keep in mind there are no 'rotations' possible in PvP. It's ALWAYS best to know what your spells do very well if you want to PvP. That being said here we've providted more of a 'priority structure' to you spells, so you should have an easier time knowing what to do next.";
		-- TIPS_RETURN(tips,tricks)
	end},
	
});

EDGE:Register('DEATHKNIGHT:PvP:Unholy' ,{
	{'Overview', "This is the base build for a Death Knight: Unholy in PVP. It includes all the specs you need as well as tips and tricks to get you started in PVP."},
	{'Stat Priority', "Multistrike\nStrength = PvP Power\nHaste >= Mastery\nVersatility\nCritical Strike"},
	{'Enchants', "Neck: Gift of Multistrike\nCloak: Gift of Multistrike\nRing: Gift of Multistrike\nWeapon:Rune of the Fallen Crusader"},
	{'Gems', "Greater Multistrike Taladite"},
	{'Talents & Glyphs', function(f)
		local MajorGlyphs = {
			58623, -- Glyph of Anti-Magic Shell
			146648, -- Glyph of REgenerative Magic
			58631, -- Glyph of Icy Touch
		};
		local MinorGlyphs = {
			59309, -- Glyph of Resilient Grip
			58642, -- Glyph of Foul Menagerie
			58677, -- Glyph of Death's Embrace
		};
		local Talents = {
			123693, -- Plague Leech
			49039, -- Lichborne
			108194, -- Asphyxiate
			45529, -- Blood Tap
			119975, -- Conversion
			108201, -- Desecrated Ground
			152280, -- Defile
		};
		local TalentTips = "Roiling Blood, Asphyxiate, and Desecrated Ground are excellent utility enhancers, but you can freely change between other talents in their teirs and still do fine. Lichborne and Conversion are required and increase survivability and Blood Tap is how you'll manage your runes better which is needed in PVP.";
		local GlyphTips = "Glyphs are situational, they depend on the make-up of your group as well as the enemies you're facing.That said, we suggest these because they seem to be all around the best for every situation.";
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',MajorGlyphs,MinorGlyphs,Talents,TalentTips,GlyphTips)
	end},
	{'Play Styles', function(f)
		local SingleTargetRotation = "Rotation is a misnomer, because there is no set rotation in PVP. \nYou have to be able to react to any situation quickly in PVP or you're dead.\n It's vital that you know what your spells and skills do, how they work, and when to use them. \nIt's helpful to also know the same about every other class, but we'll give  you a break on that. \n In the spirit of helpfulness, i've put together this 'rotation' to get you started and help you begin to learn your class better for PVP. \n";
		local MultiTargetRotation = "Heal pet, Chains of Ice as needed, keep your pet out all the time.\nSummon Gargoyle, Dark Transformation, Free Deathcoil (if you're in melee range). These all help with increased DPS.";
		local EffectiveCooldowns = "Priority: Diseases on all targets, \nDeath Coil, \nFestering/Blood, \nNecrotic Strike/scourge strike/death strike\n";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,EffectiveCooldowns)
	end},
	{'Tips & Tricks', function(f)
		local tips = "1. Use 2-Hand Weapon with Fallen Crusader on it.\n2. Manage your runes, keep an eye on them so you know what you can cast.\n";
		local tricks = "You get a full time pet!\n";
		-- TIPS_RETURN(tips,tricks)
	end},
	
});
]]
EDGE:Register('DEATHKNIGHT:Leveling:Unholy' ,{
	{'Stat Priority', "Strength\nHaste\nMastery\nCritical Strike\nVersatility"},
	{'Talents', function(f)
		local Talents = {
			194916, -- All Will Serve
			194917, -- Pestilent Pustules
			207311, -- Clawing Shadows
			108194, -- Asphyxiate
			207319, -- Corpse Shield
			207346, -- Necrosis
			207349, -- Dark Arbiters
		};
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',nil,nil,Talents,TalentTips,nil)
	end},
	{'Rotation', function(f)
		local SingleTargetRotation = "\n1 - Outbreak for Virulent Plague.\n2 - Dark Transformation\n3 - Festering Strike for Festering Wounds\n4 - Clawing Shadows\n5 - Death Coil";
		local MultiTargetRotation = "";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,nil)
	end},
	{'Buffs', "Guild Banners:\nBattle Standard of Cooperation\nStandard of Unity\nBattle Standard of Coordination\n\nFood:\nButtered Sturgeon = 125 Critical Strike\nFrosty Stew = 100 Critical Strike\n\nFlask:\nGreater Draenic Strength Flask\n\nRune:\nStout Augment Rune\n\nPotion:\nDraenic Strength Potion"},
	
});

EDGE:Register('DEATHKNIGHT:PvE:Blood' ,{
	{'Stat Priority', "Strength\nHaste\nCritical Strike\nMastery\nVersatility"},
	{'Enchants', "Neck: Gift of Haste\nCloak: Gift of Haste\nRing: Gift of Haste\nWeapon: Rune of the Fallen Crusader (DPS) or Rune of the Stoneskin Gargoyle (Tank)"},
	{'Gems', "Immaculate Haste Taladite\nGreater Haste Taladite\nHaste Taladite"},
	{'Talents', function(f)
		local Talents = {
			221536, -- Heartbreaker
			194662, -- Rapid Decomposition
			219786, -- Ossuary
			205723, -- Red Thirst
			206970, -- Tightening Grasp
			206974, -- Foul Bulwark
			114556, -- Purgatory
		};
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',nil,nil,Talents,TalentTips,nil)
	end},
	{'Rotation', function(f)
		local SingleTargetRotation = "1 - Blood Boil for Blood Plague on target.\n2 - Death and Decay when Crimson Scourge procs.\n3 - Marrowmend  to maintain several bone shields\n4 - Death Strike\n5 - Death and Decay\n6 - Heart Strike";
		local MultiTargetRotation = "1 - Blood Boil to keep Blood Plague on target.\n2 - Death and Decay\n3 - Marrowrend and keep a few stacks of Bone Shield up.\n4 - Death Strike\n5 - Heartstrike\n6 - Blood Boil";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,nil)
	end},
	{'Buffs', "Flask:\nGreater Draenic Stamina Flask\n\nFood:\nButtered Sturgeon = 125 Haste\nFrosty Stew = 100 Haste\n\nRune:\nStout Augment Rune\n\nPotion:\nDraenic Versatility Potion"},
});
-- 7.0
EDGE:Register('DEATHKNIGHT:PvE:Frost' ,{
	{'Stat Priority', "Strength\nCritical Strike > Haste\nMastery\nVersatility"},
	{'Enchants', "Neck: Gift of Critical Strike \nCloak: Gift of Critical Strike \nRing: Gift of Critical Strike \nWeapon: (Mainhand)Rune of the Fallen Crusader (Offhand)Rune of Razorice"},
	{'Gems', "Immaculate Critical Strike Taladite\nGreater Critical Strike Taladite"},
	{'Talents', function(f)
		local Talents = {
			207057, -- Shattering Strikes
			57330, -- Horn of Winter
			207126, -- Icecap
			207161, -- Abomination's Might
			207200, -- Permafrost
			207230, -- Frostscythe
			207256, -- Obliteration
		};
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',nil,nil,Talents,TalentTips,nil)
	end},
	{'Rotation', function(f)
		local SingleTargetRotation = "1 - Frost Fever always on target using Howling Blast\n2 - Obliterate\n3 - Howling Blast with Rime proc.\n4 - Frost Strike as Runic Power dump.\n5 - Horn of Winter if you have it.";
		local MultiTargetRotation = "3+ Targets\n\n1 - Frost Fever always on target using Howling Blast\n2 - Remorseless Winter\n3 - Glacial Advance\n4 - Frostscythe \n5 - Howling Blast with Rime proc.\n6 - Frost Strike as Runic Power dump.\n7 - Horn of Winter";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,nil)
	end},
	{'Buffs', "Flask:\nGreater Draenic Stamina Flask. \n \nFood: \nButtered Sturgeon = 125 Haste\nFrosty Stew = 100 Haste \n \nRune: \nStout Augment Rune \n \nPotion: \nDraenic Strength Potion"},
});
--7.0
EDGE:Register('DEATHKNIGHT:PvE:Unholy' ,{
	{'Stat Priority', "Strength\nHaste\nMastery\nCritical Strike\nVersatility"},
	{'Enchants', "Neck: Gift of Multistrike \nCloak: Gift of Multistrike \nRing: Gift of Multistrike \nWeapon: Rune of the Fallen Crusader"},
	{'Gems', "Immaculate Haste Taladite\nGreater Haste Taladite"},
	{'Talents', function(f)
		local Talents = {
			207269, -- Ebon Fever
			207317, -- Epidemic
			207305, -- Castigator
			207313, -- Sludge Belcher
			207321, -- Death Pact
			198943, -- Shadow Infusion
			207349, -- Dark Arbiters
		};
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',nil,nil,Talents,TalentTips,nil)
	end},
	{'Rotation', function(f)
		local SingleTargetRotation = "Dark Arbiter Talent:\n1 - Outbreak for Virulent Plague.\n2 - Dark Transformation\n3 - Dark Arbiter at near max runic power. Spam Death Coil.\n4 - Festering Strike at 5 or less stacks of Festering Wound\n5 - Scourge Strike\n6 - Death Coil";
		local MultiTargetRotation = "1 - Outbreak for Virulent Plague\n2 - Dark Transformation\n3 - Death and Decay\n4 - Scourge Strike standing in Death and Decay\n5 - Epidemic on targets with Virulent Plague or Death and Decay on cooldown.\n6 - Festering Strike to stack Festering Wounds\n7 - Death Coil runic power dump";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,nil)
	end},
	{'Buffs', "Food:\nButtered Sturgeon = 125 Critical Strike\nFrosty Stew = 100 Critical Strike\n\nFlask:\nGreater Draenic Strength Flask\n\nRune:\nStout Augment Rune\n\nPotion:\nDraenic Strength Potion"},
	
});