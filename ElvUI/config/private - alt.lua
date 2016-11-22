local E, L, V, P, G = unpack(select(2, ...)); --Inport: Engine, Locales, PrivateDB, ProfileDB, GlobalDB

--Locked Settings, These settings are stored for your character only regardless of profile options.

V['general'] = {
	['loot'] = true,
	['lootRoll'] = true,
	["normTex"] = "Minimalist",
	["glossTex"] = "Minimalist",
	["dmgfont"] = "DecUI Alt-Combat",
	["namefont"] = "AgencyFB Bold",
	['chatBubbles'] = 'backdrop',
	['chatBubbleFont'] = "AgencyFB Bold",
	['chatBubbleFontSize'] = 12,
	['pixelPerfect'] = false,
	['replaceBlizzFonts'] = true,
	['minimap'] = {
		['enable'] = true,
		['hideGarrison'] = true,
		['hideCalendar'] = true,
	},
}

V['bags'] = {
	['enable'] = true,
	['bagBar'] = false,
}

V["nameplate"] = {
	["enable"] = true,
}

V['auras'] = {
	['enable'] = true,
	['disableBlizzard'] = true,

	["masque"] = {
		["buffs"] = false,
		["debuffs"] = false,
		["consolidatedBuffs"] = false,
	},
}

V['chat'] = {
	['enable'] = true,
}

V['skins'] = {
	['ace3'] = {
		['enable'] = true,
	},
	['blizzard'] = {
		['enable'] = true,
		["deathRecap"] = true,
		["bags"] = true,
		["bmah"] = true, --black market ah
		["reforge"] = true,
		["calendar"] = true,
		["achievement"] = true,
		["lfguild"] = true,
		["inspect"] = true,
		["binding"] = true,
		["gbank"] = true,
		["archaeology"] = true,
		["guildcontrol"] = true,
		["guild"] = true,
		["tradeskill"] = true,
		["raid"] = true,
		["talent"] = true,
		["auctionhouse"] = true,
		["barber"] = true,
		["macro"] = true,
		["debug"] = true,
		["trainer"] = true,
		["socket"] = true,
		['loot'] = true,
		["alertframes"] = true,
		["bgscore"] = true,
		["merchant"] = true,
		["mail"] = true,
		["garrison"] = true,
		["help"] = true,
		["trade"] = true,
		["gossip"] = true,
		["greeting"] = true,
		["worldmap"] = true,
		["taxi"] = true,
		["quest"] = true,
		["questChoice"] = true,
		["petition"] = true,
		["dressingroom"] = true,
		["pvp"] = true,
		["lfg"] = true,
		["nonraid"] = true,
		["friends"] = true,
		["spellbook"] = true,
		["character"] = true,
		["misc"] = true,
		["tabard"] = true,
		["guildregistrar"] = true,
		["timemanager"] = true,
		["encounterjournal"] = true,
		["voidstorage"] = true,
		["transmogrify"] = true,
		["stable"] = true,
		["bgmap"] = true,
		['mounts'] = true,
		['petbattleui'] = true,
		['losscontrol'] = true,
		['itemUpgrade'] = true,
		["addonManager"] = true,
		["mirrorTimers"] = true,
		["objectiveTracker"] = true,
	},
}

V['tooltip'] = {
	['enable'] = true,
}

V['unitframe'] = {
	['enable'] = true,
	['disabledBlizzardFrames'] = {
		['player'] = true,
		['target'] = true,
		['focus'] = true,
		['boss'] = true,
		['arena'] = true,
		['party'] = true,
		['raid'] = true,
	},
}

V["actionbar"] = {
	["enable"] = true,
	["hideCooldownBling"] = false,

	["masque"] = {
		["actionbars"] = false,
		["petBar"] = false,
		["stanceBar"] = false,
	},
}

V["cooldown"] = {
	enable = true
}