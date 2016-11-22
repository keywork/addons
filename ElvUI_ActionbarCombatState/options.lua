local E, L, V, P, G, _ = unpack(ElvUI);
local ABCS = E:GetModule('ActionBarCS');
local bars

--Options
local function ABConf(bars)
	for i=1, bars do
		local name = L['Bar ']..i
		E.Options.args.actionbar.args.combatstate.args['bar'..i] = {
			order = i,
			name = name,
			type = 'group',
			order = i,
			disabled = function() return not E.private.actionbar.enable or not E.db.actionbar['bar'..i]['enabled'] end,
			args = {
				enable = {
					type = "toggle",
					order = 1,
					name = L['Enable'],
					get = function(info) return E.db.actionbar.combatstate['bar'..i]['enable'] end,
					set = function(info, value) E.db.actionbar.combatstate['bar'..i]['enable'] = value; ABCS:MouseOverOption(i); ABCS:SettingsUpdate(i); ABCS:LeavingCombat(true, i) end
				},
				ic = {
					order = 2,
					name = L["In Combat"],
					type = 'group',
					guiInline = true,
					disabled = function() return not E.db.actionbar.combatstate['bar'..i]['enable'] end,
					get = function(info) return E.db.actionbar.combatstate['bar'..i]['ic'][ info[#info] ] end,
					set = function(info, value) E.db.actionbar.combatstate['bar'..i]['ic'][ info[#info] ]  = value end,
					args = {
						intro = {
							order = 1,
							type = 'description',
							name = L["Conditions below will take effet when entering combat."],
						},
						mouseover = {
							type = "toggle",
							order = 2,
							name = L['Mouseover'],
							desc = L['The frame is not shown unless you mouse over the frame.'],
						},
						alpha = {
							order = 3,
							type = 'range',
							name = L['Alpha'],
							isPercent = true,
							min = 0, max = 1, step = 0.01,
						},
						visibility = {
							type = 'input',
							order = 4,
							name = L['Visibility State'],
							desc = L["This works like a macro, you can run different situations to get the actionbar to show/hide differently.\n Example: '[combat] show;hide'"],
							width = 'full',
							multiline = true,
						},
					},
				},
				ooc = {
					order = 3,
					name = L["Out of Combat"],
					type = 'group',
					guiInline = true,
					disabled = function() return not E.db.actionbar.combatstate['bar'..i]['enable'] end,
					get = function(info) return E.db.actionbar.combatstate['bar'..i]['ooc'][ info[#info] ] end,
					args = {
						intro = {
							order = 1,
							type = 'description',
							name = L["Conditions below will take effet when leaving combat."],
						},
						mouseover = {
							type = "toggle",
							order = 2,
							name = L['Mouseover'],
							desc = L['The frame is not shown unless you mouse over the frame.'],
							set = function(info, value) E.db.actionbar.combatstate['bar'..i]['ooc']['mouseover'] = value; ABCS:LeavingCombat() end,
						},
						alpha = {
							order = 3,
							type = 'range',
							name = L['Alpha'],
							isPercent = true,
							min = 0, max = 1, step = 0.01,
							set = function(info, value) E.db.actionbar.combatstate['bar'..i]['ooc']['alpha'] = value; ABCS:LeavingCombat() end,
						},
						visibility = {
							type = 'input',
							order = 4,
							name = L['Visibility State'],
							desc = L["This works like a macro, you can run different situations to get the actionbar to show/hide differently.\n Example: '[combat] show;hide'"],
							width = 'full',
							multiline = true,
							set = function(info, value) E.db.actionbar.combatstate['bar'..i]['ooc']['mouseover'] = value; ABCS:LeavingCombat() end,
						},
					},
				},
			},
		}
	end
	E.Options.args.actionbar.args.combatstate.args.barPet = {
		order = i,
		name = L['Pet Bar'],
		type = 'group',
		order = 15,
		disabled = function() return not E.private.actionbar.enable or not E.db.actionbar.barPet['enabled'] end,
		args = {
			enable = {
				type = "toggle",
				order = 1,
				name = L['Enable'],
				get = function(info) return E.db.actionbar.combatstate.barPet['enable'] end,
				set = function(info, value) E.db.actionbar.combatstate.barPet['enable'] = value; ABCS:MouseOverOption("pet"); ABCS:SettingsUpdate("pet"); ABCS:LeavingCombat(true, "pet") end
			},
			ic = {
				order = 2,
				name = L["In Combat"],
				type = 'group',
				guiInline = true,
				disabled = function() return not E.db.actionbar.combatstate.barPet['enable'] end,
				get = function(info) return E.db.actionbar.combatstate.barPet['ic'][ info[#info] ] end,
				set = function(info, value) E.db.actionbar.combatstate.barPet['ic'][ info[#info] ]  = value end,
				args = {
					intro = {
						order = 1,
						type = 'description',
						name = L["Conditions below will take effet when entering combat."],
					},
					mouseover = {
						type = "toggle",
						order = 2,
						name = L['Mouseover'],
						desc = L['The frame is not shown unless you mouse over the frame.'],
					},
					alpha = {
						order = 3,
						type = 'range',
						name = L['Alpha'],
						isPercent = true,
						min = 0, max = 1, step = 0.01,
					},
					visibility = {
						type = 'input',
						order = 4,
						name = L['Visibility State'],
						desc = L["This works like a macro, you can run different situations to get the actionbar to show/hide differently.\n Example: '[combat] show;hide'"],
						width = 'full',
						multiline = true,
					},
				},
			},
			ooc = {
				order = 3,
				name = L["Out of Combat"],
				type = 'group',
				guiInline = true,
				disabled = function() return not E.db.actionbar.combatstate.barPet['enable'] end,
				get = function(info) return E.db.actionbar.combatstate.barPet['ooc'][ info[#info] ] end,
				args = {
					intro = {
						order = 1,
						type = 'description',
						name = L["Conditions below will take effet when leaving combat."],
					},
					mouseover = {
						type = "toggle",
						order = 2,
						name = L['Mouseover'],
						desc = L['The frame is not shown unless you mouse over the frame.'],
						set = function(info, value) E.db.actionbar.combatstate.barPet['ooc']['mouseover'] = value; ABCS:LeavingCombat() end,
					},
					alpha = {
						order = 3,
						type = 'range',
						name = L['Alpha'],
						isPercent = true,
						min = 0, max = 1, step = 0.01,
						set = function(info, value) E.db.actionbar.combatstate.barPet['ooc']['alpha'] = value; ABCS:LeavingCombat() end,
					},
					visibility = {
						type = 'input',
						order = 4,
						name = L['Visibility State'],
						desc = L["This works like a macro, you can run different situations to get the actionbar to show/hide differently.\n Example: '[combat] show;hide'"],
						width = 'full',
						multiline = true,
						set = function(info, value) E.db.actionbar.combatstate.barPet['ooc']['mouseover'] = value; ABCS:LeavingCombat() end,
					},
				},
			},
		},
	}
	E.Options.args.actionbar.args.combatstate.args.stanceBar = {
		order = i,
		name = L['Stance Bar'],
		type = 'group',
		order = 20,
		disabled = function() return not E.private.actionbar.enable or not E.db.actionbar.stanceBar['enabled'] end,
		args = {
			enable = {
				type = "toggle",
				order = 1,
				name = L['Enable'],
				get = function(info) return E.db.actionbar.combatstate.stanceBar['enable'] end,
				set = function(info, value) E.db.actionbar.combatstate.stanceBar['enable'] = value; ABCS:MouseOverOption("stance"); ABCS:SettingsUpdate("stance"); ABCS:LeavingCombat(true, "stance") end
			},
			ic = {
				order = 2,
				name = L["In Combat"],
				type = 'group',
				guiInline = true,
				disabled = function() return not E.db.actionbar.combatstate.stanceBar['enable'] end,
				get = function(info) return E.db.actionbar.combatstate.stanceBar['ic'][ info[#info] ] end,
				set = function(info, value) E.db.actionbar.combatstate.stanceBar['ic'][ info[#info] ]  = value end,
				args = {
					intro = {
						order = 1,
						type = 'description',
						name = L["Conditions below will take effet when entering combat."],
					},
					mouseover = {
						type = "toggle",
						order = 2,
						name = L['Mouseover'],
						desc = L['The frame is not shown unless you mouse over the frame.'],
					},
					alpha = {
						order = 3,
						type = 'range',
						name = L['Alpha'],
						isPercent = true,
						min = 0, max = 1, step = 0.01,
					},
				},
			},
			ooc = {
				order = 3,
				name = L["Out of Combat"],
				type = 'group',
				guiInline = true,
				disabled = function() return not E.db.actionbar.combatstate.stanceBar['enable'] end,
				get = function(info) return E.db.actionbar.combatstate.stanceBar['ooc'][ info[#info] ] end,
				args = {
					intro = {
						order = 1,
						type = 'description',
						name = L["Conditions below will take effet when leaving combat."],
					},
					mouseover = {
						type = "toggle",
						order = 2,
						name = L['Mouseover'],
						desc = L['The frame is not shown unless you mouse over the frame.'],
						set = function(info, value) E.db.actionbar.combatstate.stanceBar['ooc']['mouseover'] = value; ABCS:LeavingCombat() end,
					},
					alpha = {
						order = 3,
						type = 'range',
						name = L['Alpha'],
						isPercent = true,
						min = 0, max = 1, step = 0.01,
						set = function(info, value) E.db.actionbar.combatstate.stanceBar['ooc']['alpha'] = value; ABCS:LeavingCombat() end,
					},
				},
			},
		},
	}
end


function ABCSGetOptions()
E.Options.args.actionbar.args.combatstate = {
	type = 'group',
	order = 13,
	name = L['Combat State Options'],
	childGroups = "select",
	args = {
		header = {
			order = 1,
			type = "header",
			name = L["Combat State Options"],
		},
		intro = {
			order = 2,
			type = 'description',
			name = L["OOC_DESC"],
		},
	},
}

bars = IsAddOnLoaded('ElvUI_ExtraActionBars') and 10 or 6

ABConf(bars)
end
