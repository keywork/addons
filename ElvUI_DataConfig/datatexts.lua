local E, L, V, P, G = unpack(ElvUI); --Inport: Engine, Locales, PrivateDB, ProfileDB, GlobalDB
local DT = E:GetModule('DataTexts')
local DTC = E:NewModule('DTConfig', 'AceEvent-3.0')
local EP = LibStub("LibElvUIPlugin-1.0")
local addonN = ...

local datatexts = {}

local NAME = "Small Panels"
if GetLocale() == "ruRU" then
	NAME = "Малые панели"
end

function DTC:Load(event, addon)
	if addon ~= "ElvUI_Config" then return end
	DTC:UnregisterEvent("ADDON_LOADED")
	
	E.Options.args.datatexts.childGroups = "tab"
	E.Options.args.datatexts.args.panels.guiInline = false
	E.Options.args.datatexts.args.panels.args.small = {
		type = "group",
		name = NAME,
		order = 1,
		args = {},
	}

	for name, _ in pairs(DT.RegisteredDataTexts) do
		datatexts[name] = name
	end
	datatexts[''] = NONE
	
	local table = E.Options.args.datatexts.args.panels.args
	
	local i = 0
	for pointLoc, tab in pairs(P.datatexts.panels) do
		i = i + 1
		if not _G[pointLoc] then table[pointLoc] = nil; return; end
		if type(tab) == 'table' then
			table[pointLoc].guiInline = false
			if pointLoc:find("Chat") then
				table[pointLoc].order = 2
			else
				table[pointLoc].order = 10
			end
		elseif type(tab) == 'string' then
			table[pointLoc] = nil
			table.small.args[pointLoc] = {
				type = 'select',
				name = L[pointLoc] or pointLoc,
				values = datatexts,
				order = 1,
				get = function(info) return E.db.datatexts.panels[pointLoc] end,
				set = function(info, value) E.db.datatexts.panels[pointLoc] = value; DT:LoadDataTexts() end,
			}
			if pointLoc:find("Mini") then
				table.small.args[pointLoc].order = 1
			else
				table.small.args[pointLoc].order = 10
			end
		end
	end
end

function DTC:Initialize()
	EP:RegisterPlugin(addonN)
	self:RegisterEvent("ADDON_LOADED", "Load")
end

E:RegisterModule(DTC:GetName())