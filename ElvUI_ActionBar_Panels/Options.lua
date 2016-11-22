local E, L, V, P, G, _ =  unpack(ElvUI);
local DT = E:GetModule('DataTexts')
local DTB = E:GetModule('ActionBarPanels')

function DTB:addOptions()

E.Options.args.ActionBarPanels = {
	type = "group",
	name = "ActionBar Panels",
	order = 600,
	args = {
			header = {
				order = 1,
				type = "header",
				name = "ElvUI_ActionBarPanels",
			},
			info = {
				order = 2,
				type = "description",
				name = "ActionBarPanels Information",
			},
		topPanel = {
			order = 3,
			type = "group",
			name = "Top Panel",
			guiInline = true,
			args = {
				topEnable = {
					order = 1,
					type = "toggle",
					name = "Enabled",
					get = function(info) return E.db.datatexts.ActionBarPanels.TopPanel.Enabled end,
					set = function(info, value) E.db.datatexts.ActionBarPanels.TopPanel.Enabled = value; DTB:ShowPanels() end
				},
				topHeight = {
					order = 2,
					type = "range",
					name = "Height",
					min = 1, max = 60, step = .5,
					get = function(info) return E.db.datatexts.ActionBarPanels.TopPanel.Height end,
					set = function(info, value) E.db.datatexts.ActionBarPanels.TopPanel.Height = value; DTB:SetSize() end
				},
				PetHide = {
					order = 3,
					type = "toggle",
					name = "Hide in Pet Battle",
					get = function(info) return E.db.datatexts.ActionBarPanels.TopPanel.PetHide end,
					set = function(info, value) E.db.datatexts.ActionBarPanels.TopPanel.PetHide = value; DT:PetBattleHide() end,
				},
				Template = {
					order = 4,
					type = "select",
					name = "Template",
					get = function(info) return E.db.datatexts.ActionBarPanels.TopPanel.Template end,
					set = function(info, value) E.db.datatexts.ActionBarPanels.TopPanel.Template = value; DTB:ChangeTemplate(); E:StaticPopup_Show("CONFIG_RL") end,
					values = {
						['DEFAULT'] = 'Default',
						['TRANSPARENT'] = 'Transparent',
						['CColor'] = 'Class Color',
					},
				},
			},
		},
		bottomPanel = {
			order = 4,
			type = "group",
			name = "Bottom Panel",
			guiInline = true,
			args = {
				bottomEnable = {
					order = 1,
					type = "toggle",
					name = "Enabled",
					get = function(info) return E.db.datatexts.ActionBarPanels.BottomPanel.Enabled end,
					set = function(info, value) E.db.datatexts.ActionBarPanels.BottomPanel.Enabled = value; DTB:ShowPanels() end
				},
				bottomHeight = {
					order = 2,
					type = "range",
					name = "Height",
					min = 1, max = 60, step = .5,
					get = function(info) return E.db.datatexts.ActionBarPanels.BottomPanel.Height end,
					set = function(info, value) E.db.datatexts.ActionBarPanels.BottomPanel.Height = value; DTB:SetSize() end
				},
				PetHide = {
					order = 3,
					type = "toggle",
					name = "Hide in Pet Battle",
					get = function(info) return E.db.datatexts.ActionBarPanels.BottomPanel.PetHide end,
					set = function(info, value) E.db.datatexts.ActionBarPanels.BottomPanel.PetHide = value; DT:PetBattleHide() end,
				},
				Template = {
					order = 4,
					type = "select",
					name = "Template",
					get = function(info) return E.db.datatexts.ActionBarPanels.BottomPanel.Template end,
					set = function(info, value) E.db.datatexts.ActionBarPanels.BottomPanel.Template = value; DTB:ChangeTemplate(); E:StaticPopup_Show("CONFIG_RL") end,
					values = {
						['DEFAULT'] = 'Default',
						['TRANSPARENT'] = 'Transparent',
						['CColor'] = 'Class Color',
					},
				},
			}
		},
	}
}

E.Options.args.ActionBarPanels.args.Bars = {
	type = "group",
	name = "Datatext Panels",
	order = 600,
	args = {
		bottomDataBar = {
			order = 2,
			type = "group",
			name = "ActionBar Panel One",
			guiInline = true,
			args = {
				enable = {
					type = "toggle",
					order = 1,
					name = "Enabled",
					get = function(info) return E.db.datatexts.ActionBarPanels.ActionBarPanelOne.Enabled end,
					set = function(info, value) E.db.datatexts.ActionBarPanels.ActionBarPanelOne.Enabled = value; DT:UpdateFrames() end
				},
				width = {
					type = "range",
					order = 2,
					name = "Width",
					min = 250, max = 550, step = 1,
					get = function(info) return E.db.datatexts.ActionBarPanels.ActionBarPanelOne.Width end,
					set = function(info, value) E.db.datatexts.ActionBarPanels.ActionBarPanelOne.Width = value; DT:UpdateFrames() end,
				},
				petBattle = {
					type = "toggle",
					order = 3,
					name = "Hide in Pet Battle",
					get = function(info) return E.db.datatexts.ActionBarPanels.ActionBarPanelOne.PetBattleHide end,
					set = function(info, value) E.db.datatexts.ActionBarPanels.ActionBarPanelOne.PetBattleHide = value; DT:UpdateFrames() end
				},
				Template = {
					order = 5,
					type = "select",
					name = "Template",
					get = function(info) return E.db.datatexts.ActionBarPanels.ActionBarPanelOne.Template end,
					set = function(info, value) E.db.datatexts.ActionBarPanels.ActionBarPanelOne.Template = value; DT:SetTemplate(); E:StaticPopup_Show("CONFIG_RL") end,
					values = {
						['DEFAULT'] = 'Default',
						['TRANSPARENT'] = 'Transparent',
						['CColor'] = 'Class Color',
					},
				},
				Mouseover = {
					type = "toggle",
					order = 4,
					name = "Mouseover",
					get = function(info) return E.db.datatexts.ActionBarPanels.ActionBarPanelOne.MouseOver end,
					set = function(info, value) E.db.datatexts.ActionBarPanels.ActionBarPanelOne.MouseOver = value; DT:MouseOver() end,
				},
			}
		},
		rightChat = {
			order = 4,
			type = "group",
			name = "Right Chat Tab",
			guiInline = true,
			args = {
				enable = {
					type = "toggle",
					order = 1,
					name = "Enabled",
					get = function(info) return E.db.datatexts.ActionBarPanels.RightChatDatatextPanel.Enabled end,
					set = function(info, value) E.db.datatexts.ActionBarPanels.RightChatDatatextPanel.Enabled = value; DT:UpdateFrames() end,
				}
			}
		},
		extraone = {
			order = 6,
			type = "group",
			name = "ActionBar Panel Two",
			guiInline = true,
			args = {
				enable = {
					type = "toggle",
					order = 1,
					name = "Enabled",
					get = function(info) return E.db.datatexts.ActionBarPanels.ActionBarPanelTwo.Enabled end,
					set = function(info, value) E.db.datatexts.ActionBarPanels.ActionBarPanelTwo.Enabled = value; DT:UpdateFrames() end,
				},
				width = {
					type = "range",
					order = 2,
					name = "Width",
					min = 50, max = 500, step = 1,
					get = function(info) return E.db.datatexts.ActionBarPanels.ActionBarPanelTwo.Width end,
					set = function(info, value) E.db.datatexts.ActionBarPanels.ActionBarPanelTwo.Width = value; DT:UpdateFrames(); end,
				},
				petBattle = {
					type = "toggle",
					order = 3,
					name = "Hide in Pet Battle",
					get = function(info) return E.db.datatexts.ActionBarPanels.ActionBarPanelTwo.PetBattleHide end,
					set = function(info, value) E.db.datatexts.ActionBarPanels.ActionBarPanelTwo.PetBattleHide = value; DT:UpdateFrames() end
				},
				mouseover = {
					type = "toggle",
					order = 4,
					name = "Mouseover",
					get = function(info) return E.db.datatexts.ActionBarPanels.ActionBarPanelTwo.MouseOver end,
					set = function(info, value) E.db.datatexts.ActionBarPanels.ActionBarPanelTwo.MouseOver = value; DT:MouseOver() end,
				},
				dataplacement = {
					type = "range",
					order = 5,
					name = "Data Places",
					min = 1, max = 3, step = 2,
					get = function(info) return E.db.datatexts.ActionBarPanels.ActionBarPanelTwo.DataPlacements end,
					set = function(info, value) E.db.datatexts.ActionBarPanels.ActionBarPanelTwo.DataPlacements = value; E:StaticPopup_Show("CONFIG_RL") end,
				},
				Template = {
					order = 4,
					type = "select",
					name = "Template",
					get = function(info) return E.db.datatexts.ActionBarPanels.ActionBarPanelTwo.Template end,
					set = function(info, value) E.db.datatexts.ActionBarPanels.ActionBarPanelTwo.Template = value; DT:SetTemplate(); E:StaticPopup_Show("CONFIG_RL") end,
					values = {
						['DEFAULT'] = 'Default',
						['TRANSPARENT'] = 'Transparent',
						['CColor'] = 'Class Color',
					},
				},
			},
		},
		extratwo = {
			order = 7,
			type = "group",
			name = "ActionBar Panel Three",
			guiInline = true,
			args = {
				enable = {
					type = "toggle",
					order = 1,
					name = "Enabled",
					get = function(info) return E.db.datatexts.ActionBarPanels.ActionBarPanelThree.Enabled end,
					set = function(info, value) E.db.datatexts.ActionBarPanels.ActionBarPanelThree.Enabled = value; DT:UpdateFrames() end,
				},
				width = {
					type = "range",
					order = 2,
					name = "Width",
					min = 50, max = 500, step = 1,
					get = function(info) return E.db.datatexts.ActionBarPanels.ActionBarPanelThree.Width end,
					set = function(info, value) E.db.datatexts.ActionBarPanels.ActionBarPanelThree.Width = value; DT:UpdateFrames(); end,
				},
				petBattle = {
					type = "toggle",
					order = 3,
					name = "Hide in Pet Battle",
					get = function(info) return E.db.datatexts.ActionBarPanels.ActionBarPanelThree.PetBattleHide end,
					set = function(info, value) E.db.datatexts.ActionBarPanels.ActionBarPanelThree.PetBattleHide = value; DT:UpdateFrames() end
				},
				mouseover = {
					type = "toggle",
					order = 4,
					name = "Mouseover",
					get = function(info) return E.db.datatexts.ActionBarPanels.ActionBarPanelThree.MouseOver end,
					set = function(info, value) E.db.datatexts.ActionBarPanels.ActionBarPanelThree.MouseOver = value; DT:MouseOver() end,
				},
				dataplacement = {
					type = "range",
					order = 5,
					name = "Data Places",
					min = 1, max = 3, step = 2,
					get = function(info) return E.db.datatexts.ActionBarPanels.ActionBarPanelThree.DataPlacements end,
					set = function(info, value) E.db.datatexts.ActionBarPanels.ActionBarPanelThree.DataPlacements = value; E:StaticPopup_Show("CONFIG_RL") end,
				},
				Template = {
					order = 4,
					type = "select",
					name = "Template",
					get = function(info) return E.db.datatexts.ActionBarPanels.ActionBarPanelThree.Template end,
					set = function(info, value) E.db.datatexts.ActionBarPanels.ActionBarPanelThree.Template = value; DT:SetTemplate(); E:StaticPopup_Show("CONFIG_RL") end,
					values = {
						['DEFAULT'] = 'Default',
						['TRANSPARENT'] = 'Transparent',
						['CColor'] = 'Class Color',
					},
				},
			}
		},
		extrathree = {
			order = 8,
			type = "group",
			name = "ActionBar Panel Four",
			guiInline = true,
			args = {
				enable = {
					type = "toggle",
					order = 1,
					name = "Enabled",
					get = function(info) return E.db.datatexts.ActionBarPanels.ActionBarPanelFour.Enabled end,
					set = function(info, value) E.db.datatexts.ActionBarPanels.ActionBarPanelFour.Enabled = value; DT:UpdateFrames() end,
				},
				width = {
					type = "range",
					order = 2,
					name = "Width",
					min = 50, max = 500, step = 1,
					get = function(info) return E.db.datatexts.ActionBarPanels.ActionBarPanelFour.Width end,
					set = function(info, value) E.db.datatexts.ActionBarPanels.ActionBarPanelFour.Width = value; DT:UpdateFrames(); end,
				},
				petBattle = {
					type = "toggle",
					order = 3,
					name = "Hide in Pet Battle",
					get = function(info) return E.db.datatexts.ActionBarPanels.ActionBarPanelFour.PetBattleHide end,
					set = function(info, value) E.db.datatexts.ActionBarPanels.ActionBarPanelFour.PetBattleHide = value; DT:UpdateFrames() end
				},
				mouseover = {
					type = "toggle",
					order = 4,
					name = "Mouseover",
					get = function(info) return E.db.datatexts.ActionBarPanels.ActionBarPanelFour.MouseOver end,
					set = function(info, value) E.db.datatexts.ActionBarPanels.ActionBarPanelFour.MouseOver = value; DT:MouseOver() end,
				},
				dataplacement = {
					type = "range",
					order = 5,
					name = "Data Places",
					min = 1, max = 3, step = 2,
					get = function(info) return E.db.datatexts.ActionBarPanels.ActionBarPanelFour.DataPlacements end,
					set = function(info, value) E.db.datatexts.ActionBarPanels.ActionBarPanelFour.DataPlacements = value; E:StaticPopup_Show("CONFIG_RL") end,
				},
				Template = {
					order = 4,
					type = "select",
					name = "Template",
					get = function(info) return E.db.datatexts.ActionBarPanels.ActionBarPanelFour.Template end,
					set = function(info, value) E.db.datatexts.ActionBarPanels.ActionBarPanelFour.Template = value; DT:SetTemplate(); E:StaticPopup_Show("CONFIG_RL") end,
					values = {
						['DEFAULT'] = 'Default',
						['TRANSPARENT'] = 'Transparent',
						['CColor'] = 'Class Color',
					},
				},
			}
		},
	}
}
end