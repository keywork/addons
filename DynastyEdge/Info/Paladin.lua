local ADDON_NAME, EDGE = ...;
--[[
EDGE:Register('PALADIN:Leveling:Retribution' ,{
	{'Overview', "The Retribution spec is ideal for players that wish to DPS while leveling to 100."},
	{'Stat Priority', "Strength\nMastery\nMultistrike\nCritical Strike >= Versatility\nHaste"},
	{'Enchants', "When leveling, unless you're an Enchanter with lots of mats, don't bother with Enchants. You'll have to add a new one too often with the amount you change gear while leveling."},
	{'Gems', "Do NOT use Gems until max level. Otherwise you're going to spend too much to make it worth gemming each item you can. "},
	{'Talents & Glyphs', function(f)
		local MajorGlyphs = {
			54926, -- Templar's Verdict
			146957, -- Hand of Sacrifice
			54922, -- Double Jeopardy
		};
		local MinorGlyphs = {
			115933, -- Righteous Retreat
			115931, -- Falling Avenger
			57958, -- the Mounted King
		};
		local Talents = {
			26023, -- Pursuit of Justice
			105593, -- Fist of Justice
			20925, -- Sacred Sheild
			114154, -- Unbreakable Spirit
			86172, -- Divine Purpose
			114157, -- Execution Sentance
			157048, -- Final Verdict
		};
		local TalentTips = "The talents that are primarily utility-based are simply our general recommendation, your play style and raid needs should be priority when choosing these talents. The talent descriptions include some additional advice on when different utility talents are the most appropriate choice.";
		local GlyphTips = "Glyphs are situational, they depend on the make-up of your group as well as the enemies you're facing.That said, we suggest these because they seem to be all around the best for every situation.";
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',MajorGlyphs,MinorGlyphs,Talents,TalentTips,GlyphTips)
	end},
	{'Play Styles', function(f)
		local SingleTargetRotation = "Cast Templar's Verdict Icon Templar's Verdict when you have 5 Holy Power (the maximum amount).\nCast Judgment Icon Judgment, Exorcism Icon Exorcism, and Crusader Strike Icon Crusader Strike in order to generate Holy Power.\nCast Hammer of Wrath Icon Hammer of Wrath when the target is below 20% health.";
		local MultiTargetRotation = "When facing more than one enemy, you should replace Templar's Verdict Icon Templar's Verdict with Divine Storm Icon Divine Storm and Crusader Strike Icon Crusader Strike with Hammer of the Righteous Icon Hammer of the Righteous.\nYou should be using Seal of Truth Icon Seal of Truth.";
		local EffectiveCooldowns = "Avenging Wrath: Use as often as possible.\nDivine Shield: Complete immunity to damage.\nHand of Protection: Physical Damage immunity.\nLay on Hands: Full-Health heal.";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,EffectiveCooldowns)
	end},
	{'Tips & Tricks',function(f)
		local tips = "Remember to kill everything you see as you run around and do other quests, free xp!";
		local tricks = "Use a 2Hand Weapon with High DPS score.";
		--TIPS_RETURN(tips,tricks)
	end},
	
});

EDGE:Register('PALADIN:PvP:Holy' ,{
	{'Overview', "The Holy spec is ideal for players that wish to Heal while doing PvP."},
	{'Stat Priority', "Intellect = PvP Power\nCritical Strike\nSpirit\nMultistrike\nMastery\nVersatility\nHaste"},
	{'Enchants', "Neck: Gift of Critical Strike\nCloak: Gift of Critical Strike\nRing: Gift of Critical Strike\nWeapon: Mark of Shadowmoon"},
	{'Gems', "Greater Critical Strike Taladite"},
	{'Talents & Glyphs', function(f)
		local MajorGlyphs = {
			57955, -- Glyph of Flash of Light
			56420, -- Glyph of Denounce
			63218, -- Glyph of Beacon of Light
		};
		local MinorGlyphs = {
			115933, -- Glyph of Righteous Retreat
			115931, -- Glyph of the Falling Avenger
			57958, -- Glyph of the Mounted King
		};
		local Talents = {
			85499, -- Speed of Light
			105593, -- Fist of Justice
			85804, -- Selfless Healer
			105622, -- Clemency
			105809, -- Holy Avenger
			114165, -- Holy Prism
			156910, -- Beacon of Faith
		};
		local TalentTips = "The talents that are primarily utility-based are simply our general recommendation, your play style and raid needs should be priority when choosing these talents. The talent descriptions include some additional advice on when different utility talents are the most appropriate choice.";
		local GlyphTips = "Glyphs are situational, they depend on the make-up of your group as well as the enemies you're facing.That said, we suggest these because they seem to be all around the best for every situation.";
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',MajorGlyphs,MinorGlyphs,Talents,TalentTips,GlyphTips)
	end},
	{'Play Styles', function(f)
		local SingleTargetRotation = "As usual, it's more important to know your spells/skills than to have a set rotation you want to stick to. It's important to be able to react to whatever happens in the smartest way possible because your opponents WILL know their class, AND your class so if you don't know your class be assured they'll trounce you.\nYou're holy so you're going to be healing. Couple of tips: Keep Beacon of LIght up, make use of Flash of Light, use spells to generate holy power so you can use the instant heals it allows.\n";
		local MultiTargetRotation = "You have quite a few Crowd Control abilities. Use them on the other teams healers as often as possible. If they can't get heals, they'll die fast.\n";
		local EffectiveCooldowns = "Text\n";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,EffectiveCooldowns)
	end},
	{'Tips & Tricks',function(f)
		local tips = "Feel free to wade right into the fighting, you wear plate! Plus you can trick the other team into thinking you're ret and will suprise everyone when you keep your team alive.";
		local tricks = "";
		--TIPS_RETURN(tips,tricks)
	end},
	
});

EDGE:Register('PALADIN:PvP:Protection' ,{
	{'Overview', "The Protection spec is ideal for players that wish to Tank while doing PvP."},
	{'Stat Priority', "Stamina >= Mastery >= Bonus Armor >=Versatility\nCritical Strike >= Multistrike >= Strength = PvP Power >= Armor > Haste"},
	{'Enchants', "Neck: Gift of Mastery\nCloak: Gift of Mastery\nRing: Gift of Mastery\nWeapon: Mark of Bleeding Hollow"},
	{'Gems', "Greater Stamina Taladite"},
	{'Talents & Glyphs', function(f)
		local MajorGlyphs = {
			56414, -- Glyph of Dazing Shield
			54935, -- Glyph of Final Wrath
			54928, -- Glyph of Consecration
		};
		local MinorGlyphs = {
			115933, -- Glyph of Righteous Retreat
			115931, -- Glyph of the Falling Avenger
			57958, -- Glyph of the Mounted King
		};
		local Talents = {
			87172, -- Long Arm of the Law
			105593, -- Fist of Justice
			114163, -- Eternal Flame
			114154, -- Unbreakable SPirit
			105809, -- Holy Avenger
			114165, -- Holy Prism
			152261, -- Holy Shield
		};
		local TalentTips = "The talents that are primarily utility-based are simply our general recommendation, your play style and raid needs should be priority when choosing these talents. The talent descriptions include some additional advice on when different utility talents are the most appropriate choice.";
		local GlyphTips = "Glyphs are situational, they depend on the make-up of your group as well as the enemies you're facing.That said, we suggest these because they seem to be all around the best for every situation.";
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',MajorGlyphs,MinorGlyphs,Talents,TalentTips,GlyphTips)
	end},
	{'Play Styles', function(f)
		local SingleTargetRotation = "Can't say this enough about every class. If you're going to PVP it's imperative that you know your class. Know your spells and skills, not only what they do (read the tooltips) but when is best situation to use them. That said, here's a sample rotation that may be helpful learning.\nBlessing of Might for yourself, Crusader Strike and Judgement on Cooldown, Shield of the Righeous/Word of Glory used when you ahve 3 Holy Power, Avenger Shield when Grand Crusader procs, Hammer of Wrath if your target is below 20% health\nHammer of Righteous to keep Weakened blows up on the target, Consecration/Holy Wrath on Cooldown if you have the mana.\n";
		local MultiTargetRotation = "Same thoughts as for single target, but use Hammer of Righteous instead of Crusader Strike. \nKeep learning your spells and skills, it's different to tank in PVP than PvE, you get to use a lot more spells because you're not too worried about generating threat. Keep learning, and enjoy!\n";
		local EffectiveCooldowns = "Weapon: 1Hand Weapon and Shield in the Off hand.";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,EffectiveCooldowns)
	end},
	{'Tips & Tricks',function(f)
		local tips = "";
		local tricks = "";
		--TIPS_RETURN(tips,tricks)
	end},
	
});

EDGE:Register('PALADIN:PvP:Retribution' ,{
	{'Overview', "The Retribution spec is ideal for players that wish to DPS while doing PvP."},
	{'Stat Priority', "Multistrike\nStrength = PvP Power\nCritical Strike\nVersatility\nMastery\nHaste"},
	{'Enchants', "Neck: Gift of Multistrike\nCloak: Gift of Multistrike\nRing: Gift of Multistrike\nWeapon: Mark of the Thunderlord"},
	{'Gems', "Greater Multistrike Taladite"},
	{'Talents & Glyphs', function(f)
		local MajorGlyphs = {
			54926, -- Glyph of Templar's Verdict
			54922, -- Glyph of Double Jeopardy
			54936, -- Glyph of Word of GLory
		};
		local MinorGlyphs = {
			115933, -- Glyph of Righteous Retreat
			115931, -- Glyph of the Falling Avenger
			57958, -- Glyph of the Mounted King
		};
		local Talents = {
			87172, -- Long Arm of the Law
			105593, -- Fist of Justice
			85804, -- Selfless Healer
			105622, -- Clemency
			105809, -- Holy Avenger
			114157, -- Execution Sentance
			157048, -- Final Verdict
		};
		local TalentTips = "The talents that are primarily utility-based are simply our general recommendation, your play style and raid needs should be priority when choosing these talents. The talent descriptions include some additional advice on when different utility talents are the most appropriate choice.";
		local GlyphTips = "Glyphs are situational, they depend on the make-up of your group as well as the enemies you're facing.That said, we suggest these because they seem to be all around the best for every situation.";
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',MajorGlyphs,MinorGlyphs,Talents,TalentTips,GlyphTips)
	end},
	{'Play Styles', function(f)
		local SingleTargetRotation = "Single and Multiple targets have so close to the same rotation it's not needed to show both, again keeping in mind that these are more priority spells listing than a proper rotation.";
		local MultiTargetRotation = "Inquisition, Templar's Verdict (only at 5 Holy Power), Exorcism, Hammer of Wrath, Crusader Strike, Judgement, Templar's Verdict (3-4 Holy Power).";
		local EffectiveCooldowns = "Use Blessing of Kings on yourself, default to Seal of Truth, and be sure to use your cooldowns early and often.";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,EffectiveCooldowns)
	end},
	{'Tips & Tricks',function(f)
		local tips = "Know your spells and skills. I can give a rudimentary rotation here, but you'll need to know what each of your spells and skills do and when they're useful. If you depend on a set rotation other players will walk all over you. ";
		local tricks = "";
		--TIPS_RETURN(tips,tricks)
	end},
	
});
]]
EDGE:Register('PALADIN:Leveling:Retribution' ,{
	{'Stat Priority', "1 - Strength\n2 - Haste (30%)\n3 - Critical Strike\n4 - Mastery\n5 - Versatility"},
	{'Talents', function(f)
		local Talents = {
			198038, -- Final Verdict
			217020, -- Zeal
			198054, -- Fist of Justice
			202270, -- Blade of Wrath *
			215661, -- Justicar's Vengance *
			230332, -- Cavalier
			223817, -- Divine Purpose
		};
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',nil,nil,Talents,nil,nil)
	end},
	{'Rotation', function(f)
		local SingleTargetRotation = "1 - Zeal and Blade of Wrath for Holy Power\n2 - Judgment to debuff\n4 - Templar's Verdict\n5 - Justicar's Vengeance with proc";
		local MultiTargetRotation = "";
		local EffectiveCooldowns = "";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,no)
	end},
	{'Buffs',function(f)
		local tips = "Guild Banners:\nBattle Standard of Cooperation\nStandard of Unity\nBattle Standard of Coordination\n\nFood:\nButtered Sturgeon = 125 Haste\nFrosty Stew = 100 Haste\n\nFlask: \nGreater Draenic Strength Flask\n\nRune:\nStout Augment Rune\n\nPotion:\nDraenic Strength Potion";
		local tricks = "";
		return EDGE:FillTemplate(f,'Tips',tips,tricks)
		--TIPS_RETURN(tips,tricks)
	end},
	
});

EDGE:Register('PALADIN:PvE:Holy' ,{
	{'Stat Priority', "1 - Intellect\n2 - Critical Strike\n3 - Mastery\n4 - Versatility\n5 - Haste"},
	{'Enchants', "Neck: Gift of Critical Strike\nCloak: Gift of Critical Strike\nRing: Gift of Critical Strike\nWeapon: Mark of the Frostwolf"},
	{'Gems', "1 - Immaculate Critical Strike Taladite\n2 - Greater Critical Strike Taladite\n3 - Critical Strike Taladite"},
	{'Talents', function(f)
		local Talents = {
			223306, -- Bestow Faith
			214202, -- Rule of Law
			115750, -- Blinding Light
			183415, -- Aura of Mercy
			114165, -- Holy Prism
			53376, -- Sanctified Wrath
			197446, -- Beacon of the Lightbringier
		};
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',nil,nil,Talents,nil,nil)
	end},
	{'Rotation', function(f)
		local SingleTargetRotation = "1 - Beacon of Light on target\n2 - Holy Shock\n3 - Bestow Faith\n4 - Holy Light or Flash of Light";
		local MultiTargetRotation = "";
		local EffectiveCooldowns = "";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,nil)
	end},
	{'Buffs',function(f)
		local tips = "Food:\nPickled Eel = 125 Critical Strike\nBlackrock Barbecue = 100 Critical Strike\n\nFlask: \nGreater Draenic Intellect Flask\n\nRune:\nFocus Augment Rune\n\nPotion:\nDraenic Mana Potion";
		local tricks = "";
		return EDGE:FillTemplate(f,'Tips',tips,tricks)
		--TIPS_RETURN(tips,tricks)
	end},
	
});

EDGE:Register('PALADIN:PvE:Protection' ,{
	{'Stat Priority', "1 - Versatility\n2 - Haste\n3 - Mastery\n4 - Critical Strike"},
	{'Enchants', "Back - Enchant Cloak - Gift of Versatility\nNeck - Enchant Neck - Gift of Versatility\nRings - Enchant Ring - Gift of Versatility\nWeapons - Enchant Weapon - Mark of the Bleeding Hollow"},
	{'Gems', "1 - Immaculate Versatility Taladite\n2 - Greater Versatility Taladite\n3 - Versatility Taladite"},
	{'Talents', function(f)
		local Talents = {
			204019, -- Blessed Hammer
			204035, -- Bastion of Light
			115750, -- Blinding Light
			204018, -- Blessing of Spellwarding
			204139, -- Knight Templar
			183778, -- Judgment of Light
			203791, -- Last Defender
		};
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',nil,nil,Talents,nil,nil)
	end},
	{'Rotation', function(f)
		local SingleTargetRotation = "1 - Judgment\n2 - Consecration\n3 - Avenger's Shield";
		local MultiTargetRotation = "1 - Avenger's Shield\n2 - Consecreation\n3 - Blessed Hammer\n4 - Judgment";
		local EffectiveCooldowns = "";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,nil)
	end},
	{'Buffs',function(f)
		local tips = "Food:\nJumbo Sea Dog = 125 Versatility\nGorgrond Chowder = 100 Versatility\n\nFlask: \nGreater Draenic Stamina Flask\n\nRune:\nStout Augment Rune\n\nPotion:\nDraenic Versatility Potion";
		local tricks = "";
		return EDGE:FillTemplate(f,'Tips',tips,tricks)
		--TIPS_RETURN(tips,tricks)
	end},
	
});

EDGE:Register('PALADIN:PvE:Retribution' ,{
	{'Stat Priority', "1 - Strength\n2 - Haste (30%)\n3 - Critical Strike\n4 - Mastery\n5 - Versatility"},
	{'Enchants', "Back - Enchant Cloak - Gift of Haste\nNeck - Enchant Neck - Gift of Haste\nRings - Enchant Ring - Gift of Haste\nWeapons - Enchant Weapon - Mark of the Thunderlord"},
	{'Gems', "1 - Immaculate Haste Taladite\n2 - Greater Haste Taladite\n3 - Haste Taladite"},
	{'Talents', function(f)
		local Talents = {
			213757, -- Execution Sentence
			203316, -- The Fires of Justice
			115750, -- Blinding Light
			202270, -- Blade of Wrath
			215661, -- Justicar's Vengance
			213313, -- Divine Intervention
			223817, -- Divine Purpose
		};
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',nil,nil,Talents,nil,nil)
	end},
	{'Rotation', function(f)
		local SingleTargetRotation = "1 - Crusader Strike\n2 - Blade of Wrath\n3 - Judgment\n4 - Execution Sentence\n5 - Justicar's Vengeance\n6 - Templar's Verdict";
		local MultiTargetRotation = "1 - Crusader Strike\n2 - Blade of Wrath\n3 - Judgment\n4 - Execution Sentence\n5 - Divine Storm";
		local EffectiveCooldowns = "";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,no)
	end},
	{'Buffs',function(f)
		local tips = "Food:\nButtered Sturgeon = 125 Haste\nFrosty Stew = 100 Haste\n\nFlask: \nGreater Draenic Strength Flask\n\nRune:\nStout Augment Rune\n\nPotion:\nDraenic Strength Potion";
		local tricks = "";
		return EDGE:FillTemplate(f,'Tips',tips,tricks)
		--TIPS_RETURN(tips,tricks)
	end},
	
});

