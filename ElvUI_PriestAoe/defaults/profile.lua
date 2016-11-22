local E, L, V, P, G = unpack(ElvUI); --Inport: Engine, Locales, PrivateDB, ProfileDB, GlobalDB

P['epa'] = {
	['debug'] = {
		['one'] = false,
		['two'] = false,
		['three'] = false,
		['four'] = false,
		['testmode'] = false,
	},
	['cycle_time'] = 1,
	['first_groups_only'] = true,
	['targets_hit'] = "targets",
	['coh'] = {
		['enable'] = false,
		['style'] = "texturedIcon",
		['color'] = { r=1, g=1, b=0, a=1},
		['threshold'] = 20,
		['hidecd'] = true,
	},
	['poh'] = {
		['enable'] = true,
		['style'] = "texturedIcon",
		['color'] = { r=1, g=0.25, b=0.27, a=1},
		['threshold'] = 20,
		['incoming_heals'] = false,
	},
	['ch'] = {
		['enable'] = false,
		['style'] = "texturedIcon",
		['color'] = { r=0, g=0.27, b=1, a=1},
		['threshold'] = 25,
		['range'] = true,
		['minjumps'] = 2,
		['maxhealth'] = 85,
	},
	['pwr'] = {
		['enable'] = true,
		['style'] = "texturedIcon",
		['numtargets'] = 3,
		['color'] = { r=1, g=1, b=0, a=1},
		['threshold'] = 20,
	},
	['wg'] = {
		['enable'] = false,
		['style'] = "texturedIcon",
		['color'] = { r=0.8, g=0.4, b=0, a=1},
		['threshold'] = 20,
		['hidecd'] = true,
	},
}

P.unitframe.units['raid']['priestaoe'] = {
	['poh'] = {
		['enable'] = true,
		['size'] = 18,
		['attachTo'] = 'RIGHT',
		['xOffset'] = -4,
		['yOffset'] = 0,
	},
	['cop'] = {
		['enable'] = true,
		['size'] = 18,
		['attachTo'] = 'RIGHT',
		['xOffset'] = -4,
		['yOffset'] = 0,
	},
	['coh'] = {
		['enable'] = true,
		['size'] = 18,
		['attachTo'] = 'TOP',
		['xOffset'] = 0,
		['yOffset'] = 10,
	},
	['ch'] = {
		['enable'] = true,
		['size'] = 18,
		['attachTo'] = 'RIGHT',
		['xOffset'] = -4,
		['yOffset'] = 0,
	},
	['pwr'] = {
		['enable'] = true,
		['size'] = 18,
		['attachTo'] = 'RIGHT',
		['xOffset'] = -4,
		['yOffset'] = 0,
	},
	['wg'] = {
		['enable'] = true,
		['size'] = 18,
		['attachTo'] = 'TOP',
		['xOffset'] = 0,
		['yOffset'] = 6,
	},
}

P.unitframe.units['raid40']['priestaoe'] = {
	['poh'] = {
		['enable'] = true,
		['size'] = 18,
		['attachTo'] = 'RIGHT',
		['xOffset'] = -4,
		['yOffset'] = 0,
	},
	['cop'] = {
		['enable'] = true,
		['size'] = 18,
		['attachTo'] = 'RIGHT',
		['xOffset'] = -4,
		['yOffset'] = 0,
	},
	['coh'] = {
		['enable'] = true,
		['size'] = 18,
		['attachTo'] = 'TOP',
		['xOffset'] = 0,
		['yOffset'] = 10,
	},
	['ch'] = {
		['enable'] = true,
		['size'] = 18,
		['attachTo'] = 'RIGHT',
		['xOffset'] = -4,
		['yOffset'] = 0,
	},
	['pwr'] = {
		['enable'] = true,
		['size'] = 18,
		['attachTo'] = 'RIGHT',
		['xOffset'] = -4,
		['yOffset'] = 0,
	},
	['wg'] = {
		['enable'] = true,
		['size'] = 18,
		['attachTo'] = 'TOP',
		['xOffset'] = 0,
		['yOffset'] = 6,
	},
}