local ADDON_NAME, EDGE = ...;
--[[
EDGE:Register('PRIEST:PvP:Shadow*',{
	{'Overview',"This is the base setup for a Shadow Specced Priest in PvP. You'll be putting out a lot of damage and helping with Crowd Control when you get in there and start bangin around."},
	{'Stat Priority',"Multistrike >= Intellect = PvP Power\nVersatility = Crit\nMastery\nHaste"},
	{'Enchants',"Neck: Gift of Multistrike\nCloak: Gift of Multistrike\nRing: Gift of Multistrike\nWeapon: Mark of the Thunderlord"},
	{'Talents & Glyphs',function(f)
		local MajorGlyphs =	{
			55684, -- Glyph of Fade
			55691, -- Glyph of Mass Dispel
			119864, -- Glyph of Dispel Magic
		};
		local MinorGlyphs =	{
			58228, -- Glyph of Dark Archangel
			107906, -- Glyph of Shadow
			57985, -- Glyph of Shadow Ravens
		};
		local Talents = {	
			112833, -- Spectral Guise
			121536, -- Angelic Feather
			162448, -- Surge of Darkness
			108920, -- Void Tendrils
			162452, -- Shadowy Insight
			122121, -- Divine Star
			155246, -- Clarity of Power
		};
		local TalentTips = "The talents that are primarily utility-based are simply our general recommendation, your play style and raid needs should be priority when choosing these talents. The talent descriptions include some additional advice on when different utility talents are the most appropriate choice.";
		local GlyphTips = "Glyphs are situational, they depend on the make-up of your group as well as the enemies you're facing.That said, we suggest these because they seem to be all around the best for every situation.";
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',MajorGlyphs,MinorGlyphs,Talents,TalentTips,GlyphTips)
	end},
	{'Play Styles',function(f)
		local SingleTargetRotation = "As with all classes, the most important thing is to know how your spells and skills work. For the shadow priest you need to know that Shadow Word: Death and Mindblast makes Orbs. The orbs can be used then to make Devouring Plague have lots more DPS. SO lets take a look at a decent opener for PvP Situations.\n*MindBlast, Shadow WOrd: Pain, Vampiric Touch, Mind Flay (Anytime Shadow Word:Death or Mindblast procs use it right away). WHen you get 3 Shadow Orbs use Devouring Plague, Mind Bender, Mind BLast, Vampiric Touch, Shadow Word: Pain, and Mind Flay. ";
		local MultiTargetRotation = "Shadow wordd : Pain and Vampiric Touch to all targets. Continue single target rotation, but use Mind Sear instead of Mind Flay.";
		local EffectiveCooldowns = "Shadowfiend: On Cooldown (Stack with Bloodlust)\nVampiric Embrace: group healing";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,EffectiveCooldowns)
	end},
	{'Tips & Tricks',function(f)
		local tips = "";
		local tricks = "";
		--TIPS_RETURN(tips,tricks)
	end},
});
EDGE:Register('PRIEST:PvP:Holy' ,{
	{'Overview', "Here is the base PvP spec for a Holy Priest, allowing you to be the very best healer out of all the classes in PVP."},
	{'Stat Priority', "Intellect = PvP Power\nSpirit\nMultistrike\nMastery\nCrit\nVersatility\nHaste"},
	{'Enchants', "Neck: Gift of Multistrike\nCloak: Gift of Multistrike\nRing: Gift of Multistrike\nWeapon: Mark of Bleeding Hollow"},
	{'Gems', "Greater Multistrike Taladite"},
	{'Talents & Glyphs', function(f)
		local MajorGlyphs = {
			55685, -- Glyph of Prayer of Mending
			55691, -- Glyph of Mass Dispel
			119872, -- Glyph of Renew
		};
		local MinorGlyphs = {
			126094, -- Glyph of the Val'kyr
			126152, -- Glyph of Confession
			126174, -- Glyph of  Holy Ressurection
		};
		local Talents = {
			112833, -- Spectral Guise
			121536, -- Angelic Feather
			109186, -- Surge of Light
			108920, -- Void Tendrils
			109142, -- Twist of Fate
			110744, -- Divine Star
			152117, -- Words of Mending
		};
		local TalentTips = nil;
		local GlyphTips = "Prayer of Mending: Boost to group heals\nDeep Wells: Boost to healing\nMass Dispel: Utility in group PvP.";
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',MajorGlyphs,MinorGlyphs,Talents,TalentTips,GlyphTips)
	end},
	{'Play Styles', function(f)
		local SingleTargetRotation = "Best thing to do is to know what all your spells do, so you can apply them at the right time. I do have some suggested strategies to try out though. \nIf you're up against a dps/healer your rotation would look something like this. \nPlace LIghtwell, Cast Renew, Prayer of Mending, Holy Word: Serenity, Prayer of Mending, Holy Word: Serenity, Prayer of Mending and so on. \nIf you get a little more pressure, throw a Power Word: SHield into the rotation.\nAs the pressure from the other team rises add Circle of Healing and Divine star into the mix. \nIf you're getting beat down bad, you'll want to use Flash and Greater Heals to keep you and your team topped off. \n";
		local MultiTargetRotation = "See Single Target";
		local EffectiveCooldowns = "See Single Target";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,EffectiveCooldowns)
	
	end},
	{'Tips & Tricks',function(f)
		local tips = "";
		local tricks = "";
		--TIPS_RETURN(tips,tricks)
	end},
});

EDGE:Register('PRIEST:PvP:Discipline' ,{
	{'Overview', "This is a base Discipline PV spec for Priests. \nThis is a good spec to use in PvP because it's a mitagation spec.\nThis means you'll prevent the damage rather than heal it via absorption.	"},
	{'Stat Priority', "Intellect = PvP Power\nSpirit\nCritical Strike\nMastery\nMultistrike\nVersatility\nHaste"},
	{'Enchants', "Neck: Gift of Critical Strike\nCloak: Gift of Critical Strike\nRing: Gift of Critical Strike\nWeapon: Mark of the Thunderlord"},
	{'Gems', "Greater Critical Strike Taladite"},
	{'Talents & Glyphs', function(f)
		local MajorGlyphs = {
			119866, -- Glyph of Penance
			55685, -- Glyph of Prayer of Mending
			55691, -- Glyph of Mass Dispel
		};
		local MinorGlyphs = {
			58009, -- Borrowed Time
			120581, -- Heavens
			57986, -- Shackle Undead
		};
		local Talents = {
			112833, -- Spectral Guise
			121536, -- Angelic Feather
			129250, -- Power Word: Solace
			108920, -- Void Tendrils
			109142, -- Twist of Fate
			110744, -- Divine Star
			152118, -- Clarity of Will
		};
		local TalentTips = nil;
		local GlyphTips = nil;
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',MajorGlyphs,MinorGlyphs,Talents,TalentTips,GlyphTips)
	end},
	{'Play Styles', function(f)
		local SingleTargetRotation = "*First remember that rotations aren't helpful in Pandaria. You should really learn your class, spells and skills if you want to excel in PvP. \nSecond thing is that Disc is a healing spec mostly. You can do some damage, but you're best suited to healing.\nIf you're healing someone, make sure you have Power Word:Shield up onthem first. Keep Penance on cooldown\nFor single target, keep renew up on them, use Heal and Greater Heal depending on the amount youw ish to heal. \nFlash heal is great to spam in order to heal up an emergency situation.Binding heal is helpful as well because it'll heal you and your target.\nUse any of Damage abilities when you find yourself without anyone to heal. \n";
		local MultiTargetRotation = "*Keep Prayer of Mending on cooldown\nPrayer of Healing until everyone is full health\nSpam Prayer of healing to get the Divine Aegis buff, and Shield anyone that takes a lot of damage.\n";
		local EffectiveCooldowns = nil;
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,EffectiveCooldowns)
	end},
	{'Tips & Tricks',function(f)
		local tips = "";
		local tricks = "";
		--TIPS_RETURN(tips,tricks)
	end},
	
});

EDGE:Register('PRIEST:Leveling:Shadow' ,{
	{'Overview', "Shadow is the best talent build for leveling.\n It offers a lot in the way of self-healing and mana regeneration. This spec is setup to get you to shadowform as quick as possible, and allow for the least amount of downtime.\nYou can also use this for raiding at level 85."},
	{'Stat Priority', "Intellect\nMastery\nHaste\nMultistrike >= Critical Strike\nVersatility"},
	{'Enchants', "When leveling, unless you're an Enchanter with lots of mats, don't bother with Enchants. You'll have to add a new one too often with the amount you change gear while leveling."},
	{'Gems', "Do NOT use Gems until max level. Otherwise you're going to spend too much to make it worth gemming each item you can. "},
	{'Talents & Glyphs', function(f)
		local MajorGlyphs = {
			125045, -- Holy Nova
			87195, -- Mind Blast
			55684, -- Fade
		};
		local MinorGlyphs = {
			58228, -- Dark Archangel
			57985, -- Shadow Ravens
			126745, -- Shadowy Friends
		};
		local Talents = {
			19236, -- Desperate Prayer
			121536, -- Angelic Feather
			123040, -- Mindbender
			108920, -- Void Tendrils
			10060, -- power Infusion
			127632, -- Cascade
			155361, -- Void Entropy
		};
		local TalentTips = "In leveing, remember these are suggestinos, feel free to change them if you have a different playstyle. ";
		local GlyphTips = "All glyphs are your choice, but the major's we've shown here are the best for leveling.";
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',MajorGlyphs,MinorGlyphs,Talents,TalentTips,GlyphTips)
	end},
	{'Play Styles', function(f)
		local SingleTargetRotation = "1. Devouring Plague: When you have 3 Shadow Orbs\n2. Mind Blast: on Cooldown\n3. Shadow Word: Pain, Vampiric Touch: if the target lives for more than 10 seconds.\n4. Shadow Word: Death: When target is below 20% health\n5. Mind Flay: When nothing else is available";
		local MultiTargetRotation = "Try to keep your Damage over Time debuffs on all the targets all the time. Use Mind Sear instead of Mind Flay";
		local EffectiveCooldowns = "Mindbender: Use on cooldown\nDispersion: Use to reduce very large amounts of damage.\nFlash Heal: Self heal to use as needed.";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,EffectiveCooldowns)
	
	end},
	{'Tips & Tricks',function(f)
		local tips = "Stay in Shadowform at all times. If you cast a holy spell hop right back into Shadowform when you are done casting.";
		local tricks = "Kill everything you see, it's safer that way and you'll level up much faster. ";
		--TIPS_RETURN(tips,tricks)
	end},
	
});
]]
EDGE:Register('PRIEST:Leveling:Shadow' ,{
	{'Stat Priority', "1 - Intellect\n2 - Spell Power\n3 - Haste\n4 - Critical Strike\n5 - Versatility\n\6 - Mastery"},
	{'Talents', function(f)
		local Talents = {
			109142, -- Twist of Fate
			64129, -- Body and Soul
			205367, -- Dominant Mind*
			199853, -- Reaper of Souls*
			199855, -- San'layn*
			200174, -- Mindbender
			193225, -- Legacy of the Void
		};
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',nil,nil,Talents,nil,nil)
	
	end},
	{'Rotation', function(f)
		local SingleTargetRotation = "1 - Void Eruption\n2 - Mind Blast\n3 - Shadow Word: Pain\n4 - Vampiric Touch\n5 - Mind Flay\n6 - Void Bolt\n7 - Shadowfiend\n8 - Shadow Word: Death\n9 - Mind Blast\n10 - Mind Flay";
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

EDGE:Register('PRIEST:PvE:Shadow' ,{
	{'Stat Priority', "1 - Intellect\n2 - Spell Power\n3 - Haste\n4 - Critical Strike\n5 - Versatility\n\6 - Mastery"},
	{'Enchants', "Back - Enchant Cloak - Gift of Haste\nNeck - Enchant Neck - Gift of Haste\nRings - Enchant Ring - Gift of Haste\nWeapons - Enchant Weapon - Mark of Warsong"},
	{'Talents', function(f)
		local Talents = {
			109142, -- Twist of Fate
			64129, -- Body and Soul
			205369, -- Mind Bomb
			205371, -- Void Ray
			155271, -- Auspicious Spirits
			200174, -- Mindbender
			193225, -- Legacy of the Void
		};
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',nil,nil,Talents,nil,nil)
	
	end},
	{'Rotation', function(f)
		local SingleTargetRotation = "1 - Void Eruption\n2 - Mind Blast\n3 - Shadow Word: Pain\n4 - Vampiric Touch\n5 - Mind Flay\n6 - Void Bolt\n7 - Shadowfiend\n8 - Shadow Word: Death\n9 - Mind Blast\n10 - Mind Flay";
		local MultiTargetRotation = "4+ Targets:\n\n1 - Void Eruption\n2 - Mind Blast\n3 - Shadow Word: Pain \n5 - Mind Sear\n6 - Void Bolt to refresh Pain\n7 - Shadowfiend\n8 - Shadow Word: Death\n9 - Mind Blast\n10 - Mind Sear";
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
EDGE:Register('PRIEST:PvE:Discipline' ,{
	{'Stat Priority', "1 - Intellect\n2 - Haste\n3 - Critical Strike\n4 - Versatility\n5 - Mastery"},
	{'Enchants', "Back - Enchant Cloak - Gift of Haste\nNeck - Enchant Neck - Gift of Haste\nRings - Enchant Ring - Gift of Haste\nWeapons - Enchant Weapon - Mark of Warsong"},
	{'Gems', "1 - Immaculate Haste Taladite\n2 - Greater Haste Taladite\n3 - Haste Taladite"},
	{'Talents', function(f)
		local Talents = {
			214621, -- Schism
			121536, -- Angelic Feather
			204263, --  Shining Force
			123040, -- Mindbender
			10060, -- Power Infusion
			110744, -- Divine Star
			204197, -- Purge the Wicked
		};
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',nil,nil,Talents,nil,nil)
	end},
	{'Rotation', function(f)
		local SingleTargetRotation = "DPS:\n1 - Purge the Wicked\n2 - Schism\n3 - Penance\n4 - Smite\n\nHealing:\nRotation too situational.";
		local MultiTargetRotation = "";
		local EffectiveCooldowns = "";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,nil)	
	end},
	{'Buffs',function(f)
		local tips = "Food:\nButtered Sturgeon = 125 Haste\nFrosty Stew = 100 Haste\n\nFlask: \nGreater Draenic Intellect Flask\n\nRune:\nFocus Augment Rune\n\nPotion:\nDraenic Mana Potion";
		local tricks = "";
		return EDGE:FillTemplate(f,'Tips',tips,tricks)
		--TIPS_RETURN(tips,tricks)
	end},
	
});
-- 7.0
EDGE:Register('PRIEST:PvE:Holy' ,{
	{'Stat Priority', "1 - Intellect\n2 - Mastery\n3 - Critical Strike\n4 - Versatility\n5 - Haste"},
	{'Enchants', "Back - Enchant Cloak - Gift of Mastery\nNeck - Enchant Neck - Gift of Mastery\nRings - Enchant Ring - Gift of Mastery\nWeapons - Enchant Weapon - Mark of Bleeding Hollow"},
	{'Gems', "1 - Immaculate Mastery Taladite\n2 - Greater Mastery Taladite\n3 - Mastery Taladite"},
	{'Talents', function(f)
		local Talents = {
			200128, -- Trail of Light
			121536, -- Angelic Feather
			196707, -- Afterlife
			64901, -- Symbol of Hope
			109186, -- Surge of Light
			120517, -- Halo
			200183, -- Apotheosis
		};
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',nil,nil,Talents,nil,nil)
	end},
	{'Rotation', function(f)
		local SingleTargetRotation = "Healing too situational for set rotation.";
		local MultiTargetRotation = "";
		local EffectiveCooldowns = "Chakra: Sanctuary\nChakra: Serenity\nDivine Hymn\nGuardian Spirit\nLightwell";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,nil)
	
	end},
	{'Buffs',function(f)
		local tips = "Food:\nSleeper Sushi = 125 Mastery\nSleeper Surprise = 100 Mastery\n\nFlask: \nGreater Draenic Intellect Flask\n\nRune:\nFocus Augment Rune\n\nPotion:\nDraenic Mana Potion";
		local tricks = "";
		return EDGE:FillTemplate(f,'Tips',tips,tricks)
		--TIPS_RETURN(tips,tricks)
	end},
	
});