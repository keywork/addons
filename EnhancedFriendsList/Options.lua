local EFL = unpack(select(2,...))
local AddOnName = ...
local EP

local Defaults = {
	["NameFont"] = IsAddOnLoaded("ElvUI") and ElvUI[1].db.general.font or IsAddOnLoaded("Tukui") and "Tukui Pixel" or "Arial Narrow",
	["NameFontSize"] = 12,
	["NameFontFlag"] = IsAddOnLoaded("Tukui") and "MONOCHROMEOUTLINE" or "OUTLINE",
	["InfoFont"] = IsAddOnLoaded("ElvUI") and ElvUI[1].db.general.font or IsAddOnLoaded("Tukui") and "Tukui Pixel" or "Arial Narrow",
	["InfoFontSize"] = 12,
	["InfoFontFlag"] = IsAddOnLoaded("Tukui") and "MONOCHROMEOUTLINE" or "OUTLINE",
	["GameIconPack"] = "Default",
	["StatusIconPack"] = "Default",
	["FriendGroups"] = false,
	["HideOffline"] = false,
	["CollapsedGroups"] = {},
}

EnhancedFriendsListOptions = CopyTable(Defaults)

function EFL:GetOptions()
	local Options = {
		type = "group",
		name = GetAddOnMetadata(AddOnName, "Title"),
		order = 10,
		args = {
			header = {
				order = 1,
				type = "header",
				name = "Friends List Customization",
			},
			general = {
				order = 2,
				type = "group",
				name = "General",
				guiInline = true,
				get = function(info) return EnhancedFriendsListOptions[info[#info]] end,
				set = function(info, value) EnhancedFriendsListOptions[info[#info]] = value FriendsFrame_UpdateFriends() end, 
				args = {
					NameFont = {
						type = "select", dialogControl = 'LSM30_Font',
						order = 1,
						name = "Name Font",
						desc = "The font that the RealID / Character Name / Level uses.",
						values = AceGUIWidgetLSMlists.font,	
					},
					NameFontSize = {
						order = 2,
						name = "Name Font Size",
						desc = "The font size that the RealID / Character Name / Level uses.",
						type = "range",
						min = 6, max = 22, step = 1,
					},
					NameFontFlag = {
						name = 'Name Font Flag',
						desc = "The font flag that the RealID / Character Name / Level uses.",
						order = 3,
						type = "select",
						values = {
							['NONE'] = 'None',
							['OUTLINE'] = 'OUTLINE',
							['MONOCHROME'] = 'MONOCHROME',
							['MONOCHROMEOUTLINE'] = 'MONOCROMEOUTLINE',
							['THICKOUTLINE'] = 'THICKOUTLINE',
						},
					},
					InfoFont = {
						type = "select", dialogControl = 'LSM30_Font',
						order = 4,
						name = "Info Font",
						desc = "The font that the Zone / Server uses.",
						values = AceGUIWidgetLSMlists.font,	
					},
					InfoFontSize = {
						order = 5,
						name = "Info Font Size",
						desc = "The font size that the Zone / Server uses.",
						type = "range",
						min = 6, max = 22, step = 1,
					},
					InfoFontFlag = {
						order = 6,
						name = "Info Font Outline",
						desc = "The font flag that the Zone / Server uses.",
						type = "select",
						values = {
							['NONE'] = 'None',
							['OUTLINE'] = 'OUTLINE',
							['MONOCHROME'] = 'MONOCHROME',
							['MONOCHROMEOUTLINE'] = 'MONOCROMEOUTLINE',
							['THICKOUTLINE'] = 'THICKOUTLINE',
						},
					},
					InfoFontFlag = {
						order = 6,
						name = "Info Font Outline",
						desc = "The font flag that the Zone / Server uses.",
						type = "select",
						values = {
							['NONE'] = 'None',
							['OUTLINE'] = 'OUTLINE',
							['MONOCHROME'] = 'MONOCHROME',
							['MONOCHROMEOUTLINE'] = 'MONOCROMEOUTLINE',
							['THICKOUTLINE'] = 'THICKOUTLINE',
						},
					},
					GameIconPack = {
						name = 'Game Icon Pack',
						desc = "Different Game Icons.",
						order = 7,
						type = "select",
						values = {
							['Default'] = 'Default',
							['BlizzardChat'] = 'Blizzard Chat',
							['Flat'] = 'Flat Style',
							['Gloss'] = 'Glossy',
						},
					},
					StatusIconPack = {
						name = 'Status Icon Pack',
						desc = "Different Status Icons.",
						order = 8,
						type = "select",
						values = {
							['Default'] = 'Default',
							['Square'] = 'Square',
							['D3'] = 'Diablo 3',
						},
					},
					FriendGroups = {
						type = 'toggle',
						name = 'FriendGroups',
						desc = 'Add FriendGroups',
						order = 9,
					},
				},
			},
		},
	}
	if EP then
		local Ace3OptionsPanel = IsAddOnLoaded("ElvUI") and ElvUI[1] or Enhanced_Config[1]
		Ace3OptionsPanel.Options.args.enhancedfriendslist = Options
	else
		local ACR, ACD = LibStub("AceConfigRegistry-3.0", true), LibStub("AceConfigDialog-3.0", true)
		if not (ACR or ACD) then return end
		ACR:RegisterOptionsTable("EnhancedFriendsList", Options)
		ACD:AddToBlizOptions("EnhancedFriendsList", "EnhancedFriendsList", nil, "general")
	end
end

local ResetVars = false
local InjectOptions = CreateFrame("Frame")
InjectOptions:RegisterEvent("PLAYER_LOGIN")
InjectOptions:SetScript("OnEvent", function()
	EP = LibStub("LibElvUIPlugin-1.0", true)
	if EP then
		EP:RegisterPlugin(AddOnName, EFL.GetOptions)	
	end

	if (not EnhancedFriendsListOptions["Version"] or EnhancedFriendsListOptions["Version"] < 2) then
		EnhancedFriendsListOptions = CopyTable(Defaults)
		EnhancedFriendsListOptions["Version"] = 2
		ResetVars = true
		
	end

	if EnhancedFriendsListOptions["FriendGroups"] then
		EFL:FriendGroups()
	else
		EFL:Basic()
	end
end)