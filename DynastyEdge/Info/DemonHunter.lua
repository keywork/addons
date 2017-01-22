local ADDON_NAME, EDGE = ...;
EDGE:Register('DEMONHUNTER:Leveling:Havoc' ,{
	{'Stat Priority', "Agility\nCritical Strike\nVersatility\nHaste\nMastery"},
	{'Talents', function(f)
		local Talents = {
			192939, -- Fel Mastery*
			206478, -- Demonic Appetite
			213241,	-- Felblade
			217996,	-- Soul Rending
			206476,	-- Momentum
			203556,	-- Master of the Glaive
		};
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',nil,nil,Talents,TalentTips,nil)
	end},
	{'Rotation', function(f)
		local SingleTargetRotation = "\n1 - Throw Glaive\n2 - Fel Rush\n3 - Chaos Strike\n4 - Vengeful Retreat\n5 - Fel Rush\n6 - Chaos Strike\n\nEye Beam on cooldown, especially on multiple targets.";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,nil)
	end},
	{'Buffs', "Flask:\nGreater Draenic Agility Flask\n\nFood:\nPickled Eel = 125 Critical Strike\nBlackrock Barbecue = 100 Critical Strike\n\nRune:\nEmpowered Augment Rune\n\nPotion:\nDraenic Agility Potion"},
});

EDGE:Register('DEMONHUNTER:PvE:Havoc' ,{
	{'Stat Priority', "Agility\nCritical Strike\nVersatility\nHaste\nMastery"},
	{'Enchants', "Neck: Gift of Critical Strike\nCloak: Gift of Critical Strike\nRing: Gift of Critical Strike\nEnchant Weapon - Mark of the Thunderlord"},
	{'Gems', "Immaculate Critical Strike Taladite\nGreater Critical Strike Taladite\nCritical Strike Taladite"},
	{'Talents', function(f)
		local Talents = {
			192939, -- Fel Mastery
			203555, -- Demon Blades
		};
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',nil,nil,Talents,TalentTips,nil)
	end},
	{'Rotation', function(f)
		local SingleTargetRotation = "1 - Vengeful Retreat\n2 - Fel Rush\n3 - Chaos Strike\n4 - Demon's Bite\n5 - Throw Glaive";
		local MultiTargetRotation = "1 - Fel Rush \n2 - Vengeful Retreat\n3 - Fel Rush\n4 - Eye Beam\n5 - Chaos Strike\n6 - Blade Dance with 4+ targets\n7 - Demon's Bite to generate Fury";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,nil)
	end},
	{'Buffs', "Guild Banners:\nBattle Standard of Cooperation\nStandard of Unity\nBattle Standard of Coordination\n\nFlask:\nGreater Draenic Agility Flask\n\nFood:\nPickled Eel = 125 Critical Strike\nBlackrock Barbecue = 100 Critical Strike\n\nRune:\nEmpowered Augment Rune\n\nPotion:\nDraenic Agility Potion"},
});

EDGE:Register('DEMONHUNTER:PvE:Vengeance' ,{
	{'Stat Priority', "Agility\nHaste\nMastery\nVersatility\nCritical Strike"},
	{'Enchants', "Neck: Gift of Haste\nCloak: Gift of Haste\nRing: Gift of Haste\nEnchant Weapon - Mark of Warsong"},
	{'Gems', "Immaculate Haste Taladite\nGreater Haste Taladite\nHaste Taladite"},
	{'Talents', function(f)
		local Talents = {
			207548, -- Agonizing Flames
			207739, -- Burning Alive
		};
		return EDGE:FillTemplate(f,'TalentsAndGlyphs',nil,nil,Talents,TalentTips,nil)
	end},
	{'Rotation', function(f)
		local SingleTargetRotation = "1 - Soul Cleave. Don't let Pain cap.\n2 - Immolation Aura\n3 - Sigil of Flame\n4 - Shear on global cooldowns";
		local MultiTargetRotation = "1 - Soul Cleave\n2 - Immolation Aura\n3 - Sigil of Flame\n4 - Fiery Brand\n5 - Shear on global cooldowns";
		return EDGE:FillTemplate(f,'PlayStyles',SingleTargetRotation,MultiTargetRotation,nil)
	end},
	{'Buffs', "Flask:\nGreater Draenic Agility Flask\n\nFood:\nPickled Eel = 125 Haste\nBlackrock Barbecue = 100 Haste\n\nRune:\nEmpowered Augment Rune\n\nPotion:\nDraenic Agility Potion"},
});