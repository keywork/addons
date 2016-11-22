local E, L, V, P, G, _ =  unpack(ElvUI);
local DT = E:GetModule('DataTexts')
local BG = E:GetModule('BackGrounds')
local DTB = E:GetModule('ActionBarPanels')

function DTB:setOptions()
E.Options.args.ActionBarPanels.args.Backgrounds = {
	type = "group",
	name = "Backgrounds",
	order = 605,
	args = {
		LeftBG = {
			order = 1,
			type = "group",
			name = "Left Background",
			guiInline = true,
			args = {
				Enable = {
					order = 1,
					type = "toggle",
					name = "Enabled",
					get = function(info) return E.db.datatexts.Backgrounds.LeftBG.Enabled end,
					set = function(info, value) E.db.datatexts.Backgrounds.LeftBG.Enabled = value; BG:FramesVisibility() end,
				},
				Height = {
					order = 2,
					type = "range",
					name = "Height",
					min = 0, max = E.screenheight/2, step = 1,
					get = function(info) return E.db.datatexts.Backgrounds.LeftBG.Height end,
					set = function(info, value) E.db.datatexts.Backgrounds.LeftBG.Height = value; BG:FramesSize() end,
				},
				Width = {
					order = 3,
					type = "range",
					name = "Width",
					min = 0, max = E.screenwidth, step = 1,
					get = function(info) return E.db.datatexts.Backgrounds.LeftBG.Width end,
					set = function(info, value) E.db.datatexts.Backgrounds.LeftBG.Width = value; BG:FramesSize() end,
				},
				Xoff = {
					order = 4,
					type = "range",
					name = "X-Offset",
					min = -E.screenwidth/2, max = E.screenwidth/2, step = 1,
					get = function(info) return E.db.datatexts.Backgrounds.LeftBG.XOff end,
					set = function(info, value) E.db.datatexts.Backgrounds.LeftBG.XOff = value; BG:FramesPositions() end,
				},
				Yoff = {
					order = 5,
					type = "range",
					name = "Y-Offset",
					min = -21, max = E.screenheight, step = 1,
					get = function(info) return E.db.datatexts.Backgrounds.LeftBG.YOff end,
					set = function(info, value) E.db.datatexts.Backgrounds.LeftBG.YOff = value; BG:FramesPositions() end,
				},
				PetHide = {
					order = 6,
					type = "toggle",
					name = "Hide in Pet Battle",
					get = function(info) return E.db.datatexts.Backgrounds.LeftBG.PetHide end,
					set = function(info, value) E.db.datatexts.Backgrounds.LeftBG.PetHide = value; BG:RegisterHide() end,
				},
				Template = {
					order = 7,
					type = "select",
					name = "Template",
					get = function(info) return E.db.datatexts.Backgrounds.LeftBG.Template end,
					set = function(info, value) E.db.datatexts.Backgrounds.LeftBG.Template = value; DT:SetTemplate(); E:StaticPopup_Show("CONFIG_RL") end,
					values = {
						['DEFAULT'] = 'Default',
						['TRANSPARENT'] = 'Transparent',
						['CColor'] = 'Class Color',
					},
				},
			}
		},
		RightBG = {
			order = 2,
			type = "group",
			name = "Right Background",
			guiInline = true,
			args = {
				Enable = {
					order = 1,
					type = "toggle",
					name = "Enabled",
					get = function(info) return E.db.datatexts.Backgrounds.RightBG.Enabled end,
					set = function(info, value) E.db.datatexts.Backgrounds.RightBG.Enabled = value; BG:FramesVisibility() end,
				},
				Height = {
					order = 2,
					type = "range",
					name = "Height",
					min = 0, max = E.screenheight/2, step = 1,
					get = function(info) return E.db.datatexts.Backgrounds.RightBG.Height end,
					set = function(info, value) E.db.datatexts.Backgrounds.RightBG.Height = value; BG:FramesSize() end,
				},
				Width = {
					order = 3,
					type = "range",
					name = "Width",
					min = 0, max = E.screenwidth, step = 1,
					get = function(info) return E.db.datatexts.Backgrounds.RightBG.Width end,
					set = function(info, value) E.db.datatexts.Backgrounds.RightBG.Width = value; BG:FramesSize() end,
				},
				Xoff = {
					order = 4,
					type = "range",
					name = "X-Offset",
					min = -E.screenwidth/2, max = E.screenwidth/2, step = 1,
					get = function(info) return E.db.datatexts.Backgrounds.RightBG.XOff end,
					set = function(info, value) E.db.datatexts.Backgrounds.RightBG.XOff = value; BG:FramesPositions() end,
				},
				Yoff = {
					order = 5,
					type = "range",
					name = "Y-Offset",
					min = -21, max = E.screenheight, step = 1,
					get = function(info) return E.db.datatexts.Backgrounds.RightBG.YOff end,
					set = function(info, value) E.db.datatexts.Backgrounds.RightBG.YOff = value; BG:FramesPositions() end,
				},
				PetHide = {
					order = 6,
					type = "toggle",
					name = "Hide in Pet Battle",
					get = function(info) return E.db.datatexts.Backgrounds.RightBG.PetHide end,
					set = function(info, value) E.db.datatexts.Backgrounds.RightBG.PetHide = value; BG:RegisterHide() end,
				},
				Template = {
					order = 7,
					type = "select",
					name = "Template",
					get = function(info) return E.db.datatexts.Backgrounds.RightBG.Template end,
					set = function(info, value) E.db.datatexts.Backgrounds.RightBG.Template = value; DT:SetTemplate(); E:StaticPopup_Show("CONFIG_RL") end,
					values = {
						['DEFAULT'] = 'Default',
						['TRANSPARENT'] = 'Transparent',
						['CColor'] = 'Class Color',
					},
				},
			}
		},
		BottomBG = {
			order = 3,
			type = "group",
			name = "Bottom Background",
			guiInline = true,
			args = {
				Enable = {
					order = 1,
					type = "toggle",
					name = "Enabled",
					get = function(info) return E.db.datatexts.Backgrounds.BottomBG.Enabled end,
					set = function(info, value) E.db.datatexts.Backgrounds.BottomBG.Enabled = value; BG:FramesVisibility() end,
				},
				Height = {
					order = 2,
					type = "range",
					name = "Height",
					min = 0, max = E.screenheight/2, step = 1,
					get = function(info) return E.db.datatexts.Backgrounds.BottomBG.Height end,
					set = function(info, value) E.db.datatexts.Backgrounds.BottomBG.Height = value; BG:FramesSize() end,
				},
				Width = {
					order = 3,
					type = "range",
					name = "Width",
					min = 0, max = E.screenwidth, step = 1,
					get = function(info) return E.db.datatexts.Backgrounds.BottomBG.Width end,
					set = function(info, value) E.db.datatexts.Backgrounds.BottomBG.Width = value; BG:FramesSize() end,
				},
				Xoff = {
					order = 4,
					type = "range",
					name = "X-Offset",
					min = -E.screenwidth/2, max = E.screenwidth/2, step = 1,
					get = function(info) return E.db.datatexts.Backgrounds.BottomBG.XOff end,
					set = function(info, value) E.db.datatexts.Backgrounds.BottomBG.XOff = value;  BG:FramesPositions() end,
				},
				Yoff = {
					order = 5,
					type = "range",
					name = "Y-Offset",
					min = -21, max = E.screenheight, step = 1,
					get = function(info) return E.db.datatexts.Backgrounds.BottomBG.YOff end,
					set = function(info, value) E.db.datatexts.Backgrounds.BottomBG.YOff = value;  BG:FramesPositions() end,
				},
				PetHide = {
					order = 6,
					type = "toggle",
					name = "Hide in Pet Battle",
					get = function(info) return E.db.datatexts.Backgrounds.BottomBG.PetHide end,
					set = function(info, value) E.db.datatexts.Backgrounds.BottomBG.PetHide = value; BG:RegisterHide() end,
				},
				Template = {
					order = 7,
					type = "select",
					name = "Template",
					get = function(info) return E.db.datatexts.Backgrounds.BottomBG.Template end,
					set = function(info, value) E.db.datatexts.Backgrounds.BottomBG.Template = value; DT:SetTemplate(); E:StaticPopup_Show("CONFIG_RL") end,
					values = {
						['DEFAULT'] = 'Default',
						['TRANSPARENT'] = 'Transparent',
						['CColor'] = 'Class Color',
					},
				},
			}
		}
	},
}
end

local DTFrame = CreateFrame('Frame')
DTFrame:RegisterEvent('ADDON_LOADED')
DTFrame:SetScript('OnEvent',function(self, event, addon)
	if event == 'ADDON_LOADED' and addon == 'ElvUI_Config' then
		DTB:setOptions()
		DTFrame:UnregisterEvent('ADDON_LOADED')
	end
end)