local E, L, V, P, G, _ = unpack(ElvUI);
local bars = IsAddOnLoaded('ElvUI_ExtraActionBars') and 10 or 6
P.actionbar['combatstate'] = {}

for i = 1, bars do
P.actionbar['combatstate']["bar"..i] = {
	["enable"] = false,
	["ic"] = {
		['mouseover'] = false,
		['visibility'] = P.actionbar["bar"..i]['visibility'],
		['alpha'] = P.actionbar["bar"..i]['alpha'],
	},
	["ooc"] = {
		['mouseover'] = true,
		['visibility'] = P.actionbar["bar"..i]['visibility'],
		['alpha'] = P.actionbar["bar"..i]['alpha'],
	},
	['lastSaved'] = {
		['mouseover'] = '',
		['visibility'] = '',
		['alpha'] = '',
	},
}
end

P.actionbar['combatstate']['barPet'] = {
	["enable"] = false,
	["ic"] = {
		['mouseover'] = false,
		['visibility'] = P.actionbar['barPet']['visibility'],
		['alpha'] = P.actionbar['barPet']['alpha'],
	},
	["ooc"] = {
		['mouseover'] = true,
		['visibility'] = P.actionbar['barPet']['visibility'],
		['alpha'] = P.actionbar['barPet']['alpha'],
	},
	['lastSaved'] = {
		['mouseover'] = '',
		['visibility'] = '',
		['alpha'] = '',
	},	
}

P.actionbar['combatstate']['stanceBar'] = {
	["enable"] = false,
	["ic"] = {
		['mouseover'] = false,
		['alpha'] = P.actionbar['stanceBar']['alpha'],
	},
	["ooc"] = {
		['mouseover'] = true,
		['alpha'] = P.actionbar['stanceBar']['alpha'],
	},
	['lastSaved'] = {
		['mouseover'] = '',
		['alpha'] = '',
	},
}