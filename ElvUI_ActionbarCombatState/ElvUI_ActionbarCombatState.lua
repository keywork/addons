local E, L, V, P, G, _ =  unpack(ElvUI);
local ABCS = E:NewModule('ActionBarCS', 'AceHook-3.0', 'AceEvent-3.0');
local AB = E:GetModule('ActionBars');
local EP = LibStub("LibElvUIPlugin-1.0")
local addon = ...
local bars

function ABCS:EnteringCombat()
	for i = 1, bars do
		if E.db.actionbar.combatstate['bar'..i]['enable'] then
			E.db.actionbar['bar'..i]['visibility'] = E.db.actionbar.combatstate['bar'..i]['ic']['visibility']
			E.db.actionbar['bar'..i]['mouseover'] = E.db.actionbar.combatstate['bar'..i]['ic']['mouseover']
			E.db.actionbar['bar'..i]['alpha'] = E.db.actionbar.combatstate['bar'..i]['ic']['alpha']
			AB:PositionAndSizeBar('bar'..i)
			AB:UpdateButtonSettings()
		end
	end
	if E.db.actionbar.combatstate.barPet.enable then
		E.db.actionbar.barPet['visibility'] = E.db.actionbar.combatstate.barPet['ic']['visibility']
		E.db.actionbar.barPet['mouseover'] = E.db.actionbar.combatstate.barPet['ic']['mouseover']
		E.db.actionbar.barPet['alpha'] = E.db.actionbar.combatstate.barPet['ic']['alpha']
		AB:PositionAndSizeBarPet()
		AB:UpdateButtonSettings()
	end
	if E.db.actionbar.combatstate.stanceBar['enable'] then
		E.db.actionbar.stanceBar['mouseover'] = E.db.actionbar.combatstate.stanceBar['ic']['mouseover']
		E.db.actionbar.stanceBar['alpha'] = E.db.actionbar.combatstate.stanceBar['ic']['alpha']
		AB:PositionAndSizeBarShapeShift()
		AB:UpdateButtonSettings()
	end
end

function ABCS:LeavingCombat(force, x)
	for i = 1, bars do
		if E.db.actionbar.combatstate['bar'..i]['enable'] then
			E.db.actionbar['bar'..i]['visibility'] = E.db.actionbar.combatstate['bar'..i]['ooc']['visibility']
			E.db.actionbar['bar'..i]['mouseover'] = E.db.actionbar.combatstate['bar'..i]['ooc']['mouseover']
			E.db.actionbar['bar'..i]['alpha'] = E.db.actionbar.combatstate['bar'..i]['ooc']['alpha']
			AB:PositionAndSizeBar('bar'..i)
			AB:UpdateButtonSettings()
		end
	end
	if E.db.actionbar.combatstate.barPet.enable then
		E.db.actionbar.barPet['visibility'] = E.db.actionbar.combatstate.barPet['ooc']['visibility']
		E.db.actionbar.barPet['mouseover'] = E.db.actionbar.combatstate.barPet['ooc']['mouseover']
		E.db.actionbar.barPet['alpha'] = E.db.actionbar.combatstate.barPet['ooc']['alpha']
		AB:PositionAndSizeBarPet()
		AB:UpdateButtonSettings()
	end
	if E.db.actionbar.combatstate.stanceBar['enable'] then
		E.db.actionbar.stanceBar['mouseover'] = E.db.actionbar.combatstate.stanceBar['ooc']['mouseover']
		E.db.actionbar.stanceBar['alpha'] = E.db.actionbar.combatstate.stanceBar['ooc']['alpha']
		AB:PositionAndSizeBarShapeShift()
		AB:UpdateButtonSettings()
	end
	if force and x then
		if x == "pet" then
			if E.db.actionbar.combatstate.barPet['enable'] then
				E.db.actionbar.barPet['visibility'] = E.db.actionbar.combatstate.barPet['ooc']['visibility']
				E.db.actionbar.barPet['mouseover'] = E.db.actionbar.combatstate.barPet['ooc']['mouseover']
				E.db.actionbar.barPet['alpha'] = E.db.actionbar.combatstate.barPet['ooc']['alpha']
				AB:PositionAndSizeBarPet()
				AB:UpdateButtonSettings()
			else
				E.db.actionbar.barPet['visibility'] = E.db.actionbar.combatstate.barPet.lastSaved.visibility
				E.db.actionbar.barPet['mouseover'] = E.db.actionbar.combatstate.barPet.lastSaved.mouseover
				E.db.actionbar.barPet['alpha'] = E.db.actionbar.combatstate.barPet.lastSaved.alpha
				AB:PositionAndSizeBarPet()
				AB:UpdateButtonSettings()
			end
		elseif x == "stance" then
			if E.db.actionbar.combatstate.stanceBar['enable'] then
				E.db.actionbar.stanceBar['mouseover'] = E.db.actionbar.combatstate.stanceBar['ooc']['mouseover']
				E.db.actionbar.stanceBar['alpha'] = E.db.actionbar.combatstate.stanceBar['ooc']['alpha']
				AB:PositionAndSizeBarShapeShift()
				AB:UpdateButtonSettings()
			else
				E.db.actionbar.stanceBar['mouseover'] = E.db.actionbar.combatstate.stanceBar.lastSaved.mouseover
				E.db.actionbar.stanceBar['alpha'] = E.db.actionbar.combatstate.stanceBar.lastSaved.alpha
				AB:PositionAndSizeBarShapeShift()
				AB:UpdateButtonSettings()
			end
		else
			if E.db.actionbar.combatstate['bar'..x]['enable'] then
				E.db.actionbar['bar'..x]['visibility'] = E.db.actionbar.combatstate['bar'..x]['ooc']['visibility']
				E.db.actionbar['bar'..x]['mouseover'] = E.db.actionbar.combatstate['bar'..x]['ooc']['mouseover']
				E.db.actionbar['bar'..x]['alpha'] = E.db.actionbar.combatstate['bar'..x]['ooc']['alpha']
				AB:PositionAndSizeBar('bar'..x)
				AB:UpdateButtonSettings()
			else
				E.db.actionbar['bar'..x]['visibility'] = E.db.actionbar.combatstate['bar'..x]['lastSaved']['visibility']
				E.db.actionbar['bar'..x]['mouseover'] = E.db.actionbar.combatstate['bar'..x]['lastSaved']['mouseover']
				E.db.actionbar['bar'..x]['alpha'] = E.db.actionbar.combatstate['bar'..x]['lastSaved']['alpha'] 
				AB:PositionAndSizeBar('bar'..x)
				AB:UpdateButtonSettings()
			end
		end
	end
end

function ABCS:MouseOverOption(i)
	if not IsAddOnLoaded("ElvUI_Config") then return end
	if i == "pet" then
		if E.db.actionbar.combatstate.barPet['enable'] then
			E.Options.args.actionbar.args.barPet['args']['mouseover'] = nil
			E.Options.args.actionbar.args.barPet['args']['visibility'] = nil
			E.Options.args.actionbar.args.barPet['args']['alpha'] = nil
		else
			E.Options.args.actionbar.args.barPet['args']['mouseover'] = {
				order = 5,
				name = L['Mouse Over'],
				desc = L['The frame is not shown unless you mouse over the frame.'],
				type = "toggle",
				get = function(info) return E.db.actionbar.barPet['mouseover'] end,
				set = function(info, value) E.db.actionbar.barPet['mouseover'] = value; AB:PositionAndSizeBarPet() end,
			}
			E.Options.args.actionbar.args.barPet['args']['alpha'] = {
				order = 12,
				type = 'range',
				name = L['Alpha'],
				isPercent = true,
				min = 0, max = 1, step = 0.01,
				get = function(info) return E.db.actionbar.barPet['alpha'] end,
				set = function(info, value) E.db.actionbar.barPet['alpha'] = value; AB:PositionAndSizeBarPet() end,
			}
			E.Options.args.actionbar.args.barPet['args']['visibility'] = {
				type = 'input',
				order = 13,
				name = L['Visibility State'],
				desc = L["This works like a macro, you can run different situations to get the actionbar to show/hide differently.\n Example: '[combat] show;hide'"],
				width = 'full',
				multiline = true,
				get = function(info) return E.db.actionbar.barPet['visibility'] end,
				set = function(info, value) 						
					E.db.actionbar['barPet']['visibility'] = value; 
					AB:UpdateButtonSettings()
				end,
			}
		end
	elseif i == "stance" then
		if E.db.actionbar.combatstate.stanceBar['enable'] then
			E.Options.args.actionbar.args.stanceBar['args']['mouseover'] = nil
			E.Options.args.actionbar.args.stanceBar['args']['alpha'] = nil
		else
			E.Options.args.actionbar.args.stanceBar['args']['mouseover'] = {
				order = 5,
				name = L['Mouse Over'],
				desc = L['The frame is not shown unless you mouse over the frame.'],
				type = "toggle",
				get = function(info) return E.db.actionbar.stanceBar['mouseover'] end,
				set = function(info, value) E.db.actionbar.stanceBar['mouseover'] = value; AB:PositionAndSizeBarShapeShift() end,
			}
			E.Options.args.actionbar.args.stanceBar['args']['alpha'] = {
				order = 12,
				type = 'range',
				name = L['Alpha'],
				isPercent = true,
				min = 0, max = 1, step = 0.01,
				get = function(info) return E.db.actionbar.stanceBar['alpha'] end,
				set = function(info, value) E.db.actionbar.stanceBar['alpha'] = value; AB:PositionAndSizeBarShapeShift() end,
			}
		end
	else
		if IsAddOnLoaded('ElvUI_ExtraActionBars') and i > 6 then
			if E.db.actionbar.combatstate['bar'..i]['enable'] then
				E.Options.args.blazeplugins.args.EAB.args['bar'..i]['args']['mouseover'] = nil
				E.Options.args.blazeplugins.args.EAB.args['bar'..i]['args']['visibility'] = nil
				E.Options.args.blazeplugins.args.EAB.args['bar'..i]['args']['alpha'] = nil
			else
				E.Options.args.blazeplugins.args.EAB.args['bar'..i]['args']['mouseover'] = {
					order = 5,
					name = L['Mouse Over'],
					desc = L['The frame is not shown unless you mouse over the frame.'],
					type = "toggle",
					get = function(info) return E.db.actionbar['bar'..i]['mouseover'] end,
					set = function(info, value) E.db.actionbar['bar'..i]['mouseover'] = value; AB:PositionAndSizeBar('bar'..i) end,
				}
				E.Options.args.blazeplugins.args.EAB.args['bar'..i]['args']['alpha'] = {
					order = 12,
					type = 'range',
					name = L['Alpha'],
					isPercent = true,
					min = 0, max = 1, step = 0.01,
					get = function(info) return E.db.actionbar['bar'..i]['alpha'] end,
					set = function(info, value) E.db.actionbar['bar'..i]['alpha'] = value; AB:PositionAndSizeBar('bar'..i) end,
				}
				E.Options.args.blazeplugins.args.EAB.args['bar'..i]['args']['visibility'] = {
					type = 'input',
					order = 14,
					name = L['Visibility State'],
					desc = L["This works like a macro, you can run different situations to get the actionbar to show/hide differently.\n Example: '[combat] show;hide'"],
					width = 'full',
					multiline = true,
					get = function(info) return E.db.actionbar['bar'..i]['visibility'] end,
					set = function(info, value) 						
						E.db.actionbar['bar'..i]['visibility'] = value; 
						AB:UpdateButtonSettings()
					end,
				}
			end
		else
			if E.db.actionbar.combatstate['bar'..i]['enable'] then
				E.Options.args.actionbar.args['bar'..i]['args']['mouseover'] = nil
				E.Options.args.actionbar.args['bar'..i]['args']['visibility'] = nil
				E.Options.args.actionbar.args['bar'..i]['args']['alpha'] = nil
			else
				E.Options.args.actionbar.args['bar'..i]['args']['mouseover'] = {
					order = 5,
					name = L['Mouse Over'],
					desc = L['The frame is not shown unless you mouse over the frame.'],
					type = "toggle",
					get = function(info) return E.db.actionbar['bar'..i]['mouseover'] end,
					set = function(info, value) E.db.actionbar['bar'..i]['mouseover'] = value; AB:PositionAndSizeBar('bar'..i) end,
				}
				E.Options.args.actionbar.args['bar'..i]['args']['alpha'] = {
					order = 12,
					type = 'range',
					name = L['Alpha'],
					isPercent = true,
					min = 0, max = 1, step = 0.01,
					get = function(info) return E.db.actionbar['bar'..i]['alpha'] end,
					set = function(info, value) E.db.actionbar['bar'..i]['alpha'] = value; AB:PositionAndSizeBar('bar'..i) end,
				}
				E.Options.args.actionbar.args['bar'..i]['args']['visibility'] = {
					type = 'input',
					order = 14,
					name = L['Visibility State'],
					desc = L["This works like a macro, you can run different situations to get the actionbar to show/hide differently.\n Example: '[combat] show;hide'"],
					width = 'full',
					multiline = true,
					get = function(info) return E.db.actionbar['bar'..i]['visibility'] end,
					set = function(info, value) 						
						E.db.actionbar['bar'..i]['visibility'] = value; 
						AB:UpdateButtonSettings()
					end,
				}
			end
		end
	end
end

function ABCS:SettingsUpdate(i)
	if i == "pet" then
		if E.db.actionbar.combatstate.barPet['enable'] then
			E.db.actionbar.combatstate.barPet.lastSaved.mouseover = E.db.actionbar.barPet.mouseover
			E.db.actionbar.combatstate.barPet.lastSaved.visibility = E.db.actionbar.barPet.visibility
			E.db.actionbar.combatstate.barPet.lastSaved.alpha = E.db.actionbar.barPet.alpha
		end
	elseif i == "stance" then
		if E.db.actionbar.combatstate.stanceBar['enable'] then
			E.db.actionbar.combatstate.stanceBar.lastSaved.mouseover = E.db.actionbar.stanceBar.mouseover
			E.db.actionbar.combatstate.stanceBar.lastSaved.alpha = E.db.actionbar.stanceBar.alpha
		end
	else
		if E.db.actionbar.combatstate['bar'..i]['enable'] then
			E.db.actionbar.combatstate['bar'..i]['lastSaved']['visibility'] = E.db.actionbar['bar'..i]['visibility']
			E.db.actionbar.combatstate['bar'..i]['lastSaved']['mouseover'] = E.db.actionbar['bar'..i]['mouseover']
			E.db.actionbar.combatstate['bar'..i]['lastSaved']['alpha'] = E.db.actionbar['bar'..i]['alpha']
		end
	end
end

function ABCS:Initialize()
	bars = IsAddOnLoaded('ElvUI_ExtraActionBars') and 10 or 6
	self:RegisterEvent("PLAYER_REGEN_DISABLED", "EnteringCombat")
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "LeavingCombat")
	EP:RegisterPlugin(addon,ABCSGetOptions)

	for i = 1, bars do
		ABCS:MouseOverOption(i)
	end
end

E:RegisterModule(ABCS:GetName())