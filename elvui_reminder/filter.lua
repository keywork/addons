local E, L, V, P, G = unpack(ElvUI); --Engine
local R = E:GetModule('Reminder')
--[[
	Spell Reminder Arguments
	
	General:
		enable - turn the reminder off and on.
		strictFilter - allow the use of spells that are not actually in your spellbook (Spell Procs)
		disableSound - Don't play the warning sound.
		
	Type of Check:
		spellGroup - List of spells in a group, if you have anyone of these spells the icon will hide.
		weaponCheck - Run a weapon enchant check instead of a spell check
		CDSpell - Run checks to see if a spell is on cooldown or not.
		
	Spells only Requirements:
		negateGroup - List of spells in a group, if you have anyone of these spells the icon will immediately hide and stop running the spell check (these should be other peoples spells)
		reverseCheck - only works if you provide a role or a tree, instead of hiding the frame when you have the buff, it shows the frame when you have the buff, doesn't work with weapons
		talentTreeException - if reverseCheck is set you can set a talent tree to follow the reverse check if not set then all trees follow the reverse check, doesn't work with weapons
	
	Cooldown only Requirements:
		OnCooldown - Set to "SHOW or "HIDE".
	
	Requirements: (These work for both spell and weapon checks)
		role - you must be a certain role for it to display (Tank, Melee, Caster)
		tree - you must be active in a specific talent tree for it to display ([1] = true, [2] = true, [3] = true, [4] = true) note: tree order can be viewed from top to bottom when you open your talent pane
		minLevel - the minimum level you must be (most of the time we don't need to use this because it will register the spell learned event if you don't know the spell, but in the case of weapon enchants this is useful)
		personal - aura must come from the player
		
	Additional Checks: (Note we always run a check when gaining/losing an aura)
		instance - check when entering a party/raid instance
		pvp - check when entering a bg/arena
		combat - check when entering combat

	For every group created a new frame is created, it's a lot easier this way.
]]

G['reminder']['filters'] = {
	DEATHKNIGHT = {
		["Horn of Winter"] = {	-- Horn of Winter group
			["spellGroup"] = {
				[57330] = true,	-- Horn of Winter
			},
			["negateGroup"] = {
				[6673] = true,	-- Battle Shout
				[19506] = true,	-- Trueshot Aura
			},
			["combat"] = true,
			["enable"] = true,
			["strictFilter"] = true,
		},
		["Blood Presence"] = {	-- Blood Presence group
			["spellGroup"] = {
				[48263] = true,	-- Blood Presence
			},
			["role"] = "Tank",
			["instance"] = true,
			["reversecheck"] = true,
			["enable"] = true,
			["strictFilter"] = true,
		},
	},
	DRUID = {
		["Mark of the Wild"] = {	-- Mark of the Wild group
			["spellGroup"] = {
				[1126] = true,	-- Mark of the Wild
			},
			["negateGroup"] = {
				[20217] = true,	-- Blessing of Kings
				[115921] = true,	-- Legacy of the Emperor
				[90363] = true,	-- Embrace of the Shale Spider
			},
			["combat"] = true,
			["instance"] = true,
			["pvp"] = true,
			["enable"] = true,
			["strictFilter"] = true,
		},
	},
	HUNTER = {
	},
	MAGE = {
		["Brilliance"] = {	-- Brilliance group
			["spellGroup"] = {
				[1459] = true,	-- Arcane Brilliance
				[61316] = true,	-- Dalaran Brilliance
			},
			["combat"] = true,
			["instance"] = true,
			["pvp"] = true,
			["enable"] = true,
			["strictFilter"] = true,
		},
	},
	MONK = {
		["Legacy of the Emperor"] = {	-- Legacy of the Emperor group
			["spellGroup"] = {
				[115921] = true,	-- Legacy of the Emperor
			},
			["negateGroup"] = {
				[1126] = true,	-- Mark of the Wild
				[20217] = true,	-- Blessing of Kings
				[90363] = true,	-- Embrace of the Shale Spider
			},
			["role"] = "Healer",
			["combat"] = true,
			["instance"] = true,
			["pvp"] = true,
			["enable"] = true,
			["strictFilter"] = true,
		},
		["Legacy of the White Tiger"] = {	-- Legacy of the White Tiger group
			["spellGroup"] = {
				[116781] = true,	-- Legacy of the White Tiger
			},
			["negateGroup"] = {
				[1459] = true,	-- Arcane Brilliance
				[61316] = true,	-- Dalaran Brilliance
				[24932] = true,	-- Leader of the Pack
				[90309] = true,	-- Terrifying Roar
				[24604] = true,	-- Furious Howl
			},
			["combat"] = true,
			["instance"] = true,
			["pvp"] = true,
			["enable"] = true,
			["strictFilter"] = true,
		},
	},
	PALADIN = {
		["Righteous Fury"] = {	-- Righteous Fury group
			["spellGroup"] = {
				[25780] = true,	-- Righteous Fury
			},
			["role"] = "Tank",
			["instance"] = true,
			["reversecheck"] = true,
			["negate_reversecheck"] = 1,	-- Holy paladins use RF sometimes
			["enable"] = true,
			["strictFilter"] = true,
		},
		["Blessing of Kings"] = {	-- Blessing of Kings group
			["spellGroup"] = {
				[20217] = true,	-- Blessing of Kings
			},
			["negateGroup"] = {
				[1126] = true,	-- Mark of the Wild
				[115921] = true,	-- Legacy of the Emperor
				[90363] = true,	-- Embrace of the Shale Spider
				[19740] = true,	-- Blessing of Might
			},
			["combat"] = true,
			["instance"] = true,
			["pvp"] = true,
			["enable"] = true,
			["strictFilter"] = true,
		},
		["Blessing of Might"] = {	-- Blessing of Might group
			["spellGroup"] = {
				[19740] = true,	-- Blessing of Might
			},
			["negateGroup"] = {
				[116956] = true,	-- Grace of Air
				[93435] = true,	-- Roar of Courage
				[128997] = true,	-- Spirit Beast Blessing
				[20217] = true,	-- Blessing of Kings
			},
			["combat"] = true,
			["instance"] = true,
			["pvp"] = true,
			["enable"] = true,
			["strictFilter"] = true,
		},
	},
	PRIEST = {
	},
	ROGUE = {
		["Lethal Poisons"] = {	-- Lethal Poisons group
			["spellGroup"] = {
				[2823] = true,	-- Deadly Poison
				[8679] = true,	-- Wound Poison
			},
			["combat"] = true,
			["instance"] = true,
			["pvp"] = true,
			["enable"] = true,
			["strictFilter"] = true,
		},
		["Non-Lethal Poisons"] = {	--  Non-Lethal Poisons group
			["spellGroup"] = {
				[3408] = true,	-- Crippling Poison
				[108211] = true,	-- Leeching Poison
			},
			["combat"] = true,
			["instance"] = true,
			["pvp"] = true,
			["enable"] = true,
			["strictFilter"] = true,
		},
	},
	SHAMAN = {
		["Shields"] = {	-- Shields group
			["spellGroup"] = {
				[52127] = true,	-- Water Shield
				[324] = true,	-- Lightning Shield
				[974] = true,	-- Earth Shield
			},
			["combat"] = true,
			["instance"] = true,
			["pvp"] = true,
			["enable"] = true,
			["strictFilter"] = true,
		},
		["Weapons Enchant"] = {	-- Weapons enchants group
			["weapon"] = true,
			["combat"] = true,
			["instance"] = true,
			["pvp"] = true,
			["level"] = 10,
			["enable"] = true,
			["strictFilter"] = true,
		},
	},
	WARLOCK = {
		["Dark Intent"] = {	-- Dark Intent group
			["spellGroup"] = {
				[109773] = true,	-- Dark Intent
			},
			["negateGroup"] = {
				[1459] = true,	-- Arcane Brilliance
				[61316] = true,	-- Dalaran Brilliance
			},
			["combat"] = true,
			["instance"] = true,
			["pvp"] = true,
			["enable"] = true,
			["strictFilter"] = true,
		},
	},
	WARRIOR = {
		["Commanding Shout"] = {	-- Commanding Shout group
			["spellGroup"] = {
				[469] = true,	-- Commanding Shout
			},
			["negateGroup"] = {
				[109773] = true, -- Dark Intent
				[90364] = true,	-- Qiraji Fortitude
				[21562] = true,	-- Fortitude
				[6673] = true,	-- Battle Shout
			},
			["combat"] = true,
			["role"] = "Tank",
			["enable"] = true,
			["strictFilter"] = true,
		},
		["Battle Shout"] = {	-- Battle Shout group
			["spellGroup"] = {
				[6673] = true,	-- Battle Shout
			},
			["negateGroup"] = {
				[57330] = true,	-- Horn of Winter
				[19506] = true,	-- Trueshot Aura
				[469] = true,	-- Commanding Shout
			},
			["combat"] = true,
			["role"] = "Melee",
			["enable"] = true,
			["strictFilter"] = true,
		},
	},
}