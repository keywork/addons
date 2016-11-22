local E, L, V, P, G = unpack(select(2, ...)); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB

--Global Settings
G['general'] = {
	["autoScale"] = true,
	["eyefinity"] = true,
	['smallerWorldMap'] = true,
	['WorldMapCoordinates'] = {
		["enable"] = true,
		["position"] = "BOTTOMLEFT",
		["xOffset"] = 0,
		["yOffset"] = 0,
	},
	["disableTutorialButtons"] = true,
	["animateConfig"] = true,
}

G['classtimer'] = {}

G["nameplate"] = {}

G['unitframe'] = {
	['aurafilters'] = {},
	['buffwatch'] = {},
}
