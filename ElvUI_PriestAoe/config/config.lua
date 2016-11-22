local E, L, V, P, G = unpack(ElvUI); 
local UF = E:GetModule("UnitFrames")
local EPA = E:GetModule('EPA')

local Order = 0
local function getOrder()
	Order = Order +1
	return Order
end

local function configTable()
	local auraAnchors = {
		TOP = 'TOP',
		BOTTOM = 'BOTTOM',
		LEFT = 'LEFT',
		RIGHT = 'RIGHT',
		CENTER = 'CENTER',
		TOPLEFT = 'TOPLEFT',
		TOPRIGHT = 'TOPRIGHT',
		BOTTOMRIGHT = 'BOTTOMRIGHT',
		BOTTOMLEFT = 'BOTTOMLEFT',
	};

	E.Options.args.epa = {
		order = getOrder(),
		type = 'group',
		childGroups = "tab",
		name = EPA.Title,
		args = {
			extras = {
				order = getOrder(),
				type = 'group',
				name = '',
				--get = function(info) return AS:CheckOption(info[#info]) end,
				--set = function(info, value) AS:SetOption(info[#info], value) end,
				guiInline = true,
				args = {
					frequency = {
						order = getOrder(),
						type = "range",
						name = "Refresh Rate",
						desc = "Seconds between status refreshes",
						width = "full",
						get = function () return E.private.epa.cycle_time end,
						set = function (_, v) E.private.epa.cycle_time = v end,
						min = 0.25,
						max = 5,
						step = 0.05,
					},
					first_groups_only = {
						order = getOrder(),
						type = "toggle",
						name = "First Groups Only",
						desc = "Depending on the raid size, checks only the first groups to improve performance",
						get = function () return E.db.epa.first_groups_only end,
						set = function (_, v) E.db.epa.first_groups_only = v; EPA:UpdateNumGroups() end,
					},
					targets_hit = {
						order = getOrder(),
						type = "select",
						style = "radio",
						name = "Icon Text",
						desc = "Set the information you want shown on the icon.",
						get = function () return E.db.epa.targets_hit end,
						set = function (_, v) E.db.epa.targets_hit = v end,
						values = {
							['targets'] = "Targets hit",
							['overheal'] = "Overheal %",
							['none'] = "Nothing",
						},
					},
					desc = {
							name = "Note about new thresholds: Overheal is based on how much it will overheal. PoH fully healing 4 targets counts as 20%. Glyphed CoH no overheal 4 targets is still 33% overheal. It's based on the predicted heal divided by maximum heal possible.",
							order = getOrder(),
							type = 'description',
							width = "full",
					},
				}
			}
		}
	}
	--[[@alpha@
	E.Options.args.epa.args.debug = {
		order = getOrder(),
		type = 'group',
		name = 'Test Mode',
		guiInline = true,
		args = {
			one = {
				order = getOrder(),
				type = 'toggle',
				name = 'Debug One',
				get = function () return E.db.epa.debug.one end,
				set = function (_, v) E.db.epa.debug.one = v end,	
				},			
			two = {
				order = getOrder(),
				type = 'toggle',
				name = 'Debug Two (Gain,Lost)',
				get = function () return E.db.epa.debug.two end,
				set = function (_, v) E.db.epa.debug.two = v end,	
				},			
			three = {
				order = getOrder(),
				type = 'toggle',
				name = 'Debug Three (Visib)',
				get = function () return E.db.epa.debug.three end,
				set = function (_, v) E.db.epa.debug.three = v end,	
				},			
			four = {
				order = getOrder(),
				type = 'toggle',
				name = 'Debug Four',
				get = function () return E.db.epa.debug.four end,
				set = function (_, v) E.db.epa.debug.four = v end,	
				},
			test = {
				order = getOrder(),
				type = 'toggle',
				name = 'Test Mode',
				get = function () return E.db.epa.debug.testmode end,
				set = function (_, v) E.db.epa.debug.testmode = v; EPA:ToggleTestMode(v) end,	
				},
			}
	}
	--@end-alpha@]]
	E.Options.args.epa.args.coh = {
		type = 'group',
		name = 'Circle of Healing',
		order = getOrder(),
		--get = function(info) return AS:CheckOption(info[#info]) end,
		--set = function(info, value) AS:SetOption(info[#info], value) end,
		args = {
			coh_enable = {
						order = getOrder(),
						type = "toggle",
						name = "Enable",
						desc = "Enable Circle of Healing",
						get = function()
						return E.db.epa.coh.enable
						end,
						set = function(_, v)
							E.db.epa.coh.enable = v
								if not v then
									if EPA.OnStatusDisable then
										EPA:OnStatusDisable("coh")
									end
								end
						end,
			},
			coh_icon_style = {
							name = "Style",
							order = getOrder(),
							type = "select",
							get = function() return E.db.epa.coh.style end,
							set = function(_, v) E.db.epa.coh.style = v; EPA:RetextureIcons('coh')end, 
							values = {
									['texturedIcon'] = "Textured Icon",
									['coloredIcon'] = "Colored Icon",
							},
			},
			coh_color = {
						name = "Color",
						order = getOrder(),
						type = "color",
						get = function()
							local c = E.db.epa.coh.color
							return c.r, c.g, c.b
						end,
						set = function(_, r, g, b)
							local c = E.db.epa.coh.color
							c.r, c.g, c.b = r, g, b
						end,
			},
			coh_opacity = {
						name = "Opacity",
						desc = "Opacity for Circle of Healing",
						order = getOrder(),
						type = "range",
						min = 0.05,
						max = 1,
						step = 0.05,
						isPercent = true,
						get = function() local color = E.db.epa.coh.color return color.a end,
						set = function(_, a) local color = E.db.epa.coh.color color.a = a or 1 end,
							--func = function() GridStatus:ResetClassColors() end,
						},			
			coh_threshold = {
						order = getOrder(),
						type = "range",
						name = "Overheal threshold",
						desc = "Show when less than this % of overheal will occur. 100 will always show the icon.",
						softMax = 100,
						min = 0,
						step = 1,
						width = "full",
						get = function () return E.db.epa.coh.threshold end,
						set = function (_, v) E.db.epa.coh.threshold = v end,
			},
			coh_hidecd = {
						order = getOrder(),
						type = "toggle",
						name = "Hide while on cooldown",
						desc = "Hide status while Circle of Healing is on cooldown",
						width = "full",
						get = function () return E.db.epa.coh.hidecd end,
						set = function (_, arg) E.db.epa.coh.hidecd = arg end,
			},
			raidoptions = {
				order = getOrder(),
				type = 'group',
				name = "Raid Options",
				inline = true,
				get = function(info) return E.db.unitframe.units['raid']['priestaoe']['coh'][ info[#info] ] end,
				set = function(info, value) E.db.unitframe.units['raid']['priestaoe']['coh'][ info[#info] ] = value; EPA:ApplyIconOptions(); end,
				args = {
					enable = {
						type = 'toggle',
						order = getOrder(),
						name = 'Enable',
					},	
					attachTo = {
						type = 'select',
						order = getOrder(),
						name = 'Position',
						values = auraAnchors,
					},
					size = {
						type = 'range',
						name = 'Size',
						order = getOrder(),
						min = 8, max = 30, step = 1,
					},				
					xOffset = {
						order = getOrder(),
						type = 'range',
						name = 'xOffset',
						min = -50, max = 50, step = 1,
					},
					yOffset = {
						order = getOrder(),
						type = 'range',
						name = 'yOffset',
						min = -50, max = 50, step = 1,
					},	
					test = {
						order = getOrder(),
						type = 'toggle',
						name = 'Test Mode',
						get = function () return E.db.epa.debug.testmode end,
						set = function (_, v) E.db.epa.debug.testmode = v; EPA:ToggleTestMode(v) end,	
					}
				}
			},
			raid40options = {
				order = getOrder(),
				type = 'group',
				name = "Raid 40 Options",
				guiInline = true,
				get = function(info) return E.db.unitframe.units['raid40']['priestaoe']['coh'][ info[#info] ] end,
				set = function(info, value) E.db.unitframe.units['raid40']['priestaoe']['coh'][ info[#info] ] = value; EPA:ApplyIconOptions(); end,
				args = {
					enable = {
						type = 'toggle',
						order = getOrder(),
						name = 'Enable',
					},	
					attachTo = {
						type = 'select',
						order = getOrder(),
						name = 'Position',
						values = auraAnchors,
					},
					size = {
						type = 'range',
						name = 'Size',
						order = getOrder(),
						min = 8, max = 30, step = 1,
					},				
					xOffset = {
						order = getOrder(),
						type = 'range',
						name = 'xOffset',
						min = -50, max = 50, step = 1,
					},
					yOffset = {
						order = getOrder(),
						type = 'range',
						name = 'yOffset',
						min = -50, max = 50, step = 1,
					},	
					test = {
						order = getOrder(),
						type = 'toggle',
						name = 'Test Mode',
						get = function () return E.db.epa.debug.testmode end,
						set = function (_, v) E.db.epa.debug.testmode = v; EPA:ToggleTestMode(v) end,	
					}
				}
			}
		}
	}
	E.Options.args.epa.args.poh = {
		type = 'group',
		name = 'Prayer of Healing',
		order = getOrder(),
		--get = function(info) return AS:CheckOption(info[#info]) end,
		--set = function(info, value) AS:SetOption(info[#info], value) end,
		guiInline = false,
		args = {
			poh_enable = {
						order = getOrder(),
						type = "toggle",
						name = "Enable",
						desc = "Enable Prayer of Healing",
						get = function()
						return E.db.epa.poh.enable
						end,
						set = function(_, v)
							E.db.epa.poh.enable = v
								if not v then
									if EPA.OnStatusDisable then
										EPA:OnStatusDisable("poh")
									end
								end
						end,					
			},
			poh_icon_style = {
							name = "Style",
							order = getOrder(),
							type = "select",
							get = function() return E.db.epa.poh.style end,
							set = function(_, v) E.db.epa.poh.style = v; EPA:RetextureIcons('poh') end, 
							values = {
									['texturedIcon'] = "Textured Icon",
									['coloredIcon'] = "Colored Icon",
							},
			},
			poh_color = {
						name = "Color",
						order = getOrder(),
						type = "color",
						get = function()
							local c = E.db.epa.poh.color
							return c.r, c.g, c.b
						end,
						set = function(_, r, g, b)
							local c = E.db.epa.poh.color
							c.r, c.g, c.b = r, g, b
						end,
			},
			poh_opacity = {
						name = "Opacity",
						desc = "Opacity for Prayer of Healing",
						order = getOrder(),
						type = "range",
						min = 0.05,
						max = 1,
						step = 0.05,
						isPercent = true,
						get = function() local color = E.db.epa.poh.color return color.a end,
						set = function(_, a) local color = E.db.epa.poh.color color.a = a or 1 end,
							--func = function() GridStatus:ResetClassColors() end,
			},			
			poh_threshold = {
						order = getOrder(),
						type = "range",
						name = "Overheal threshold",
						desc = "Show when less than this % of overheal will occur. 100 will always show the icon.",
						softMax = 100,
						min = 0,
						step = 1,
						width = "full",
						get = function () return E.db.epa.poh.threshold end,
						set = function (_, v) E.db.epa.poh.threshold = v end,
			},
			poh_incomingheals = {
						order = getOrder(),
						type = "toggle",
						name = "Subtract incoming heals",
						desc = "Subtracts incoming heals from the health deficit before making the calculations. Can be helpful on chain casts to know the next target to hit. Recommend refresh rate < 0.75sec",
						width = "full",
						get = function () return E.db.epa.poh.incoming_heals end,
						set = function (_, v) E.db.epa.poh.incoming_heals = v end,
			},
			raidoptions = {
				order = getOrder(),
				type = 'group',
				guiInline = true,
				name = 'POH Icon Options',
				get = function(info) return E.db.unitframe.units['raid']['priestaoe']['poh'][ info[#info] ] end,
				set = function(info, value) E.db.unitframe.units['raid']['priestaoe']['poh'][ info[#info] ] = value; EPA:ApplyIconOptions(); end,
				args = {
					enable = {
						type = 'toggle',
						order = getOrder(),
						name = 'Enable',
					},	
					attachTo = {
						type = 'select',
						order = getOrder(),
						name = 'Position',
						values = auraAnchors,
					},
					size = {
						type = 'range',
						name = 'Size',
						order = getOrder(),
						min = 8, max = 30, step = 1,
					},				
					xOffset = {
						order = getOrder(),
						type = 'range',
						name = 'xOffset',
						min = -50, max = 50, step = 1,
					},
					yOffset = {
						order = getOrder(),
						type = 'range',
						name = 'yOffset',
						min = -50, max = 50, step = 1,
					},
					test = {
						order = getOrder(),
						type = 'toggle',
						name = 'Test Mode',
						get = function () return E.db.epa.debug.testmode end,
						set = function (_, v) E.db.epa.debug.testmode = v; EPA:ToggleTestMode(v) end,
						},
					},
				},
			raid40options = {
				order = getOrder(),
				type = 'group',
				name = "Raid 40 Options",
				guiInline = true,
				get = function(info) return E.db.unitframe.units['raid40']['priestaoe']['poh'][ info[#info] ] end,
				set = function(info, value) E.db.unitframe.units['raid40']['priestaoe']['poh'][ info[#info] ] = value; EPA:ApplyIconOptions(); end,
				args = {
					enable = {
						type = 'toggle',
						order = getOrder(),
						name = 'Enable',
					},	
					attachTo = {
						type = 'select',
						order = getOrder(),
						name = 'Position',
						values = auraAnchors,
					},
					size = {
						type = 'range',
						name = 'Size',
						order = getOrder(),
						min = 8, max = 30, step = 1,
					},				
					xOffset = {
						order = getOrder(),
						type = 'range',
						name = 'xOffset',
						min = -50, max = 50, step = 1,
					},
					yOffset = {
						order = getOrder(),
						type = 'range',
						name = 'yOffset',
						min = -50, max = 50, step = 1,
					},	
					test = {
						order = getOrder(),
						type = 'toggle',
						name = 'Test Mode',
						get = function () return E.db.epa.debug.testmode end,
						set = function (_, v) E.db.epa.debug.testmode = v; EPA:ToggleTestMode(v) end,	
					},
				},
			},
		}
	}
	E.Options.args.epa.args.ch = {
		type = 'group',
		name = 'Chain Heal',
		order = getOrder(),
		--get = function(info) return AS:CheckOption(info[#info]) end,
		--set = function(info, value) AS:SetOption(info[#info], value) end,
		guiInline = false,
		args = {
			desc = {
					name = "NOTE: Chain Heal is a more intensive search than all the other modules and is disabled by default. Refresh rate recommended to be 1 sec or more.",
					order = getOrder(),
					type = 'description',
					width = "full",
			},
					
			ch_enable = {
						order = getOrder(),
						type = "toggle",
						name = "Enable",
						desc = "Enable Chain Heal",
						get = function()
						return E.db.epa.ch.enable
						end,
						set = function(_, v)
							E.db.epa.ch.enable = v
								if not v then
									if EPA.OnStatusDisable then
										EPA:OnStatusDisable("ch")
									end
								end
						end,
			},
			ch_icon_style = {
							name = "Style",
							order = getOrder(),
							type = "select",
							get = function() return E.db.epa.ch.style end,
							set = function(_, v) E.db.epa.ch.style = v; EPA:RetextureIcons('ch') end, 
							values = {
									['texturedIcon'] = "Textured Icon",
									['coloredIcon'] = "Colored Icon",
							},
			},
			ch_color = {
						name = "Color",
						order = getOrder(),
						type = "color",
						get = function()
							local c = E.db.epa.ch.color
							return c.r, c.g, c.b
						end,
						set = function(_, r, g, b)
							local c = E.db.epa.ch.color
							c.r, c.g, c.b = r, g, b
						end,
			},
			ch_opacity = {
						name = "Opacity",
						desc = "Opacity for Chain Heal",
						order = getOrder(),
						type = "range",
						min = 0.05,
						max = 1,
						step = 0.05,
						isPercent = true,
						get = function() local color = E.db.epa.ch.color return color.a end,
						set = function(_, a) local color = E.db.epa.ch.color color.a = a or 1 end,
							--func = function() GridStatus:ResetClassColors() end,
			},
			ch_threshold = {
						order = getOrder(),
						type = "range",
						name = "Overheal threshold",
						desc = "Show when less than this % of overheal will occur. 100 will always show the icon.",
						softMax = 100,
						min = 0,
						step = 1,
						width = "full",
						get = function () return E.db.epa.ch.threshold end,
						set = function (_, v) E.db.epa.ch.threshold = v end,
			},
			--[[ch_minjump = {
						order = getOrder(),
						type = "range",
						name = "Jump threshold",
						desc = "Only consider targets that will result in at least this number of Chain Heal jumps.",
						max = 3,
						min = 1,
						step = 1,
						get = function () return E.db.epa.ch.minjump end,
						set = function (_, v) E.db.epa.ch.minjump = v end,
			},
			ch_maxhealth = {
						order = getOrder(),
						type = "range",
						name = "Health threshold",
						desc = "Only consider targets below this percentage of health.",
						max = 100,
						min = 1,
						step = 1,
						get = function () return E.db.epa.ch.maxhealth end,
						set = function (_, v) E.db.epa.ch.maxhealth = v end,
			},]]
			iconoptions = {
				order = getOrder(),
				type = 'group',
				name = 'CH Icon Options',
				guiInline = true,
				get = function(info) return E.db.unitframe.units['raid']['priestaoe']['ch'][ info[#info] ] end,
				set = function(info, value) E.db.unitframe.units['raid']['priestaoe']['ch'][ info[#info] ] = value; EPA:ApplyIconOptions(); end,
				args = {
					enable = {
						type = 'toggle',
						order = getOrder(),
						name = 'Enable',
					},	
					attachTo = {
						type = 'select',
						order = getOrder(),
						name = 'Position',
						values = auraAnchors,
					},
					size = {
						type = 'range',
						name = 'Size',
						order = getOrder(),
						min = 8, max = 30, step = 1,
					},
					xOffset = {
						order = getOrder(),
						type = 'range',
						name = 'xOffset',
						min = -50, max = 50, step = 1,
					},
					yOffset = {
						order = getOrder(),
						type = 'range',
						name = 'yOffset',
						min = -50, max = 50, step = 1,
					},
					test = {
						order = getOrder(),
						type = 'toggle',
						name = 'Test Mode',
						get = function () return E.db.epa.debug.testmode end,
						set = function (_, v) E.db.epa.debug.testmode = v; EPA:ToggleTestMode(v) end,	
					},
				},
			},
			raid40options = {
				order = getOrder(),
				type = 'group',
				name = "Raid 40 Options",
				guiInline = true,
				get = function(info) return E.db.unitframe.units['raid40']['priestaoe']['ch'][ info[#info] ] end,
				set = function(info, value) E.db.unitframe.units['raid40']['priestaoe']['ch'][ info[#info] ] = value; EPA:ApplyIconOptions(); end,
				args = {
					enable = {
						type = 'toggle',
						order = getOrder(),
						name = 'Enable',
					},	
					attachTo = {
						type = 'select',
						order = getOrder(),
						name = 'Position',
						values = auraAnchors,
					},
					size = {
						type = 'range',
						name = 'Size',
						order = getOrder(),
						min = 8, max = 30, step = 1,
					},				
					xOffset = {
						order = getOrder(),
						type = 'range',
						name = 'xOffset',
						min = -50, max = 50, step = 1,
					},
					yOffset = {
						order = getOrder(),
						type = 'range',
						name = 'yOffset',
						min = -50, max = 50, step = 1,
					},	
					test = {
						order = getOrder(),
						type = 'toggle',
						name = 'Test Mode',
						get = function () return E.db.epa.debug.testmode end,
						set = function (_, v) E.db.epa.debug.testmode = v; EPA:ToggleTestMode(v) end,	
					},
				},
			},
		}
	}
	E.Options.args.epa.args.pwr = {
		type = 'group',
		name = 'Power Word Radiance',
		order = getOrder(),
		--get = function(info) return AS:CheckOption(info[#info]) end,
		--set = function(info, value) AS:SetOption(info[#info], value) end,
		guiInline = false,
		args = {
			pwr_enable = {
						order = getOrder(),
						type = "toggle",
						name = "Enable",
						desc = "Enable PW: Radiance",
						get = function()
						return E.db.epa.pwr.enable
						end,
						set = function(_, v)
							E.db.epa.pwr.enable = v
								if not v then
									if EPA.OnStatusDisable then
										EPA:OnStatusDisable("pwr")
									end
								end
						end,					
			},
			pwr_icon_style = {
							name = "Style",
							order = getOrder(),
							type = "select",
							get = function() return E.db.epa.pwr.style end,
							set = function(_, v) E.db.epa.pwr.style = v; EPA:RetextureIcons('pwr') end, 
							values = {
									['texturedIcon'] = "Textured Icon",
									['coloredIcon'] = "Colored Icon",
							},
			},
			pwr_color = {
						name = "Color",
						order = getOrder(),
						type = "color",
						get = function()
							local c = E.db.epa.pwr.color
							return c.r, c.g, c.b
						end,
						set = function(_, r, g, b)
							local c = E.db.epa.pwr.color
							c.r, c.g, c.b = r, g, b
						end,
			},
			--[[pwr_numtargets = {
						name = "Min Targets",
						desc = "Minimum number to show icon",
						order = getOrder(),
						type = "range",
						min = 1,
						max = 6,
						step = 1,
						get = function() return E.db.epa.pwr.numtargets end,
						set = function(_, v) E.db.epa.pwr.numtargets = v end,
			},]]
			pwr_opacity = {
						name = "Opacity",
						desc = "Opacity for Holy Radiance",
						order = getOrder(),
						type = "range",
						min = 0.05,
						max = 1,
						step = 0.05,
						isPercent = true,
						get = function() local color = E.db.epa.pwr.color return color.a end,
						set = function(_, a) local color = E.db.epa.pwr.color color.a = a or 1 end,
							--func = function() GridStatus:ResetClassColors() end,
			},			
			pwr_threshold = {
						order = getOrder(),
						type = "range",
						name = "Overheal threshold",
						desc = "Show when less than this % of overheal will occur. 100 will always show the icon.",
						softMax = 100,
						min = 0,
						step = 1,
						width = "full",
						get = function () return E.db.epa.pwr.threshold end,
						set = function (_, v) E.db.epa.pwr.threshold = v end,
			},
			iconoptions = {
				order = getOrder(),
				type = 'group',
				name = 'PWR Icon Options',
				guiInline = true,
				get = function(info) return E.db.unitframe.units['raid']['priestaoe']['pwr'][ info[#info] ] end,
				set = function(info, value) E.db.unitframe.units['raid']['priestaoe']['pwr'][ info[#info] ] = value; EPA:ApplyIconOptions(); end,
				args = {
					enable = {
						type = 'toggle',
						order = getOrder(),
						name = 'Enable',
					},	
					attachTo = {
						type = 'select',
						order = getOrder(),
						name = 'Position',
						values = auraAnchors,
					},
					size = {
						type = 'range',
						name = 'Size',
						order = getOrder(),
						min = 8, max = 30, step = 1,
					},				
					xOffset = {
						order = getOrder(),
						type = 'range',
						name = 'xOffset',
						min = -50, max = 50, step = 1,
					},
					yOffset = {
						order = getOrder(),
						type = 'range',
						name = 'yOffset',
						min = -50, max = 50, step = 1,
					},	
					test = {
						order = getOrder(),
						type = 'toggle',
						name = 'Test Mode',
						get = function () return E.db.epa.debug.testmode end,
						set = function (_, v) E.db.epa.debug.testmode = v; EPA:ToggleTestMode(v) end,	
					},		
				},
			},
			raid40options = {
				order = getOrder(),
				type = 'group',
				name = "Raid 40 Options",
				guiInline = true,
				get = function(info) return E.db.unitframe.units['raid40']['priestaoe']['pwr'][ info[#info] ] end,
				set = function(info, value) E.db.unitframe.units['raid40']['priestaoe']['pwr'][ info[#info] ] = value; EPA:ApplyIconOptions(); end,
				args = {
					enable = {
						type = 'toggle',
						order = getOrder(),
						name = 'Enable',
					},	
					attachTo = {
						type = 'select',
						order = getOrder(),
						name = 'Position',
						values = auraAnchors,
					},
					size = {
						type = 'range',
						name = 'Size',
						order = getOrder(),
						min = 8, max = 30, step = 1,
					},				
					xOffset = {
						order = getOrder(),
						type = 'range',
						name = 'xOffset',
						min = -50, max = 50, step = 1,
					},
					yOffset = {
						order = getOrder(),
						type = 'range',
						name = 'yOffset',
						min = -50, max = 50, step = 1,
					},	
					test = {
						order = getOrder(),
						type = 'toggle',
						name = 'Test Mode',
						get = function () return E.db.epa.debug.testmode end,
						set = function (_, v) E.db.epa.debug.testmode = v; EPA:ToggleTestMode(v) end,	
					},
				},
			},
		}
	}
	E.Options.args.epa.args.wg = {
		type = 'group',
		name = 'Wild Growth',
		order = getOrder(),
		--get = function(info) return AS:CheckOption(info[#info]) end,
		--set = function(info, value) AS:SetOption(info[#info], value) end,
		guiInline = false,
		args = {
			wg_enable = {
						order = getOrder(),
						type = "toggle",
						name = "Enable",
						desc = "Enable Wild Growth",
						get = function()
						return E.db.epa.wg.enable
						end,
						set = function(_, v)
							E.db.epa.wg.enable = v
								if not v then
									if EPA.OnStatusDisable then
										EPA:OnStatusDisable("wg")
									end
								end
						end,
			},
			wg_icon_style = {
							name = "Style",
							order = getOrder(),
							type = "select",
							get = function() return E.db.epa.wg.style end,
							set = function(_, v) E.db.epa.wg.style = v; EPA:RetextureIcons('wg') end, 
							values = {
									['texturedIcon'] = "Textured Icon",
									['coloredIcon'] = "Colored Icon",
							},
			},
			wg_color = {
						name = "Color",
						order = getOrder(),
						type = "color",
						get = function()
							local c = E.db.epa.wg.color
							return c.r, c.g, c.b
						end,
						set = function(_, r, g, b)
							local c = E.db.epa.wg.color
							c.r, c.g, c.b = r, g, b
						end,
			},
			wg_opacity = {
						name = "Opacity",
						desc = "Opacity for Wild Growth",
						order = getOrder(),
						type = "range",
						min = 0.05,
						max = 1,
						step = 0.05,
						isPercent = true,
						get = function() local color = E.db.epa.wg.color return color.a end,
						set = function(_, a) local color = E.db.epa.wg.color color.a = a or 1 end,
							--func = function() GridStatus:ResetClassColors() end,
						},			
			wg_threshold = {
						order = getOrder(),
						type = "range",
						name = "Overheal Threshold",
						desc = "Show WG when less than this % of overheal will occur. 100 will always show the icon, pending other settings!",
						softMax = 100,
						min = 0,
						step = 1,
						width = "full",
						get = function () return E.db.epa.wg.threshold end,
						set = function (_, v) E.db.epa.wg.threshold = v end,
			},
			wg_hidecd = {
						order = getOrder(),
						type = "toggle",
						name = "Hide while on cooldown",
						desc = "Hide status while Wild Growth is on cooldown",
						width = "full",
						get = function () return E.db.epa.wg.hidecd end,
						set = function (_, arg) E.db.epa.wg.hidecd = arg end,
			},
			iconoptions = {
				order = getOrder(),
				type = 'group',
				name = 'WG Icon Options',
				guiInline = true,
				get = function(info) return E.db.unitframe.units['raid']['priestaoe']['wg'][ info[#info] ] end,
				set = function(info, value) E.db.unitframe.units['raid']['priestaoe']['wg'][ info[#info] ] = value; EPA:ApplyIconOptions(); end,
				args = {
					enable = {
						type = 'toggle',
						order = getOrder(),
						name = 'Enable',
					},	
					attachTo = {
						type = 'select',
						order = getOrder(),
						name = 'Position',
						values = auraAnchors,
					},
					size = {
						type = 'range',
						name = 'Size',
						order = getOrder(),
						min = 8, max = 30, step = 1,
					},				
					xOffset = {
						order = getOrder(),
						type = 'range',
						name = 'xOffset',
						min = -50, max = 50, step = 1,
					},
					yOffset = {
						order = getOrder(),
						type = 'range',
						name = 'yOffset',
						min = -50, max = 50, step = 1,
					},	
					test = {
						order = getOrder(),
						type = 'toggle',
						name = 'Test Mode',
						get = function () return E.db.epa.debug.testmode end,
						set = function (_, v) E.db.epa.debug.testmode = v; EPA:ToggleTestMode(v) end,	
					},		
				},
			},
			raid40options = {
				order = getOrder(),
				type = 'group',
				name = "Raid 40 Options",
				guiInline = true,
				get = function(info) return E.db.unitframe.units['raid40']['priestaoe']['wg'][ info[#info] ] end,
				set = function(info, value) E.db.unitframe.units['raid40']['priestaoe']['wg'][ info[#info] ] = value; EPA:ApplyIconOptions(); end,
				args = {
					enable = {
						type = 'toggle',
						order = getOrder(),
						name = 'Enable',
					},	
					attachTo = {
						type = 'select',
						order = getOrder(),
						name = 'Position',
						values = auraAnchors,
					},
					size = {
						type = 'range',
						name = 'Size',
						order = getOrder(),
						min = 8, max = 30, step = 1,
					},				
					xOffset = {
						order = getOrder(),
						type = 'range',
						name = 'xOffset',
						min = -50, max = 50, step = 1,
					},
					yOffset = {
						order = getOrder(),
						type = 'range',
						name = 'yOffset',
						min = -50, max = 50, step = 1,
					},	
					test = {
						order = getOrder(),
						type = 'toggle',
						name = 'Test Mode',
						get = function () return E.db.epa.debug.testmode end,
						set = function (_, v) E.db.epa.debug.testmode = v; EPA:ToggleTestMode(v) end,	
					},
				},
			}
		}
	}
	E.Options.args.unitframe.args['raid'].args.priestaoe = {
				order = getOrder(),
				type = 'group',
				name = 'ElvUI Priest AoE',
				get = function(info) return E.db.unitframe.units['raid']['priestaoe'][ info[#info] ] end,
				set = function(info, value) E.db.unitframe.units['raid']['priestaoe'][ info[#info] ] = value; end,
				args = {
					poh = {
						order = getOrder(),
						type = 'group',
						name = 'Prayer of Healing',
						get = function(info) return E.db.unitframe.units['raid']['priestaoe']['poh'][ info[#info] ] end,
						set = function(info, value) E.db.unitframe.units['raid']['priestaoe']['poh'][ info[#info] ] = value; EPA:ApplyIconOptions(); end,
						args = {
							enable = {
								type = 'toggle',
								order = getOrder(),
								name = 'Enable',
							},	
							attachTo = {
								type = 'select',
								order = getOrder(),
								name = 'Position',
								values = auraAnchors,
							},
							size = {
								type = 'range',
								name = 'Size',
								order = getOrder(),
								min = 8, max = 30, step = 1,
							},				
							xOffset = {
								order = getOrder(),
								type = 'range',
								name = 'xOffset',
								min = -50, max = 50, step = 1,
							},
							yOffset = {
								order = getOrder(),
								type = 'range',
								name = 'yOffset',
								min = -50, max = 50, step = 1,
							},
							test = {
								order = getOrder(),
								type = 'toggle',
								name = 'Test Mode',
								get = function () return E.db.epa.debug.testmode end,
								set = function (_, v) E.db.epa.debug.testmode = v; EPA:ToggleTestMode(v) end,
								},
							},
					},
					coh = {
						order = getOrder(),
						type = 'group',
						name = 'Circle of Healing',
						get = function(info) return E.db.unitframe.units['raid']['priestaoe']['coh'][ info[#info] ] end,
						set = function(info, value) E.db.unitframe.units['raid']['priestaoe']['coh'][ info[#info] ] = value; EPA:ApplyIconOptions(); end,
						args = {
							enable = {
								type = 'toggle',
								order = getOrder(),
								name = 'Enable',
							},	
							attachTo = {
								type = 'select',
								order = getOrder(),
								name = 'Position',
								values = auraAnchors,
							},
							size = {
								type = 'range',
								name = 'Size',
								order = getOrder(),
								min = 8, max = 30, step = 1,
							},				
							xOffset = {
								order = getOrder(),
								type = 'range',
								name = 'xOffset',
								min = -50, max = 50, step = 1,
							},
							yOffset = {
								order = getOrder(),
								type = 'range',
								name = 'yOffset',
								min = -50, max = 50, step = 1,
							},	
							test = {
								order = getOrder(),
								type = 'toggle',
								name = 'Test Mode',
								get = function () return E.db.epa.debug.testmode end,
								set = function (_, v) E.db.epa.debug.testmode = v; EPA:ToggleTestMode(v) end,	
							},		
						},
					},
					ch = {
						order = getOrder(),
						type = 'group',
						name = 'CH Icon Options',
						get = function(info) return E.db.unitframe.units['raid']['priestaoe']['ch'][ info[#info] ] end,
						set = function(info, value) E.db.unitframe.units['raid']['priestaoe']['ch'][ info[#info] ] = value; EPA:ApplyIconOptions(); end,
						args = {
							enable = {
								type = 'toggle',
								order = getOrder(),
								name = 'Enable',
							},	
							attachTo = {
								type = 'select',
								order = getOrder(),
								name = 'Position',
								values = auraAnchors,
							},
							size = {
								type = 'range',
								name = 'Size',
								order = getOrder(),
								min = 8, max = 30, step = 1,
							},
							xOffset = {
								order = getOrder(),
								type = 'range',
								name = 'xOffset',
								min = -50, max = 50, step = 1,
							},
							yOffset = {
								order = getOrder(),
								type = 'range',
								name = 'yOffset',
								min = -50, max = 50, step = 1,
							},
							test = {
								order = getOrder(),
								type = 'toggle',
								name = 'Test Mode',
								get = function () return E.db.epa.debug.testmode end,
								set = function (_, v) E.db.epa.debug.testmode = v; EPA:ToggleTestMode(v) end,	
							},
						},
					},
					pwr = {
						order = getOrder(),
						type = 'group',
						name = 'PWR Icon Options',
						get = function(info) return E.db.unitframe.units['raid']['priestaoe']['pwr'][ info[#info] ] end,
						set = function(info, value) E.db.unitframe.units['raid']['priestaoe']['pwr'][ info[#info] ] = value; EPA:ApplyIconOptions(); end,
						args = {
							enable = {
								type = 'toggle',
								order = getOrder(),
								name = 'Enable',
							},	
							attachTo = {
								type = 'select',
								order = getOrder(),
								name = 'Position',
								values = auraAnchors,
							},
							size = {
								type = 'range',
								name = 'Size',
								order = getOrder(),
								min = 8, max = 30, step = 1,
							},				
							xOffset = {
								order = getOrder(),
								type = 'range',
								name = 'xOffset',
								min = -50, max = 50, step = 1,
							},
							yOffset = {
								order = getOrder(),
								type = 'range',
								name = 'yOffset',
								min = -50, max = 50, step = 1,
							},	
							test = {
								order = getOrder(),
								type = 'toggle',
								name = 'Test Mode',
								get = function () return E.db.epa.debug.testmode end,
								set = function (_, v) E.db.epa.debug.testmode = v; EPA:ToggleTestMode(v) end,	
							},		
						},
					},
					wg = {
						order = getOrder(),
						type = 'group',
						name = 'WG Icon Options',
						get = function(info) return E.db.unitframe.units['raid']['priestaoe']['wg'][ info[#info] ] end,
						set = function(info, value) E.db.unitframe.units['raid']['priestaoe']['wg'][ info[#info] ] = value; EPA:ApplyIconOptions(); end,
						args = {
							enable = {
								type = 'toggle',
								order = getOrder(),
								name = 'Enable',
							},	
							attachTo = {
								type = 'select',
								order = getOrder(),
								name = 'Position',
								values = auraAnchors,
							},
							size = {
								type = 'range',
								name = 'Size',
								order = getOrder(),
								min = 8, max = 30, step = 1,
							},				
							xOffset = {
								order = getOrder(),
								type = 'range',
								name = 'xOffset',
								min = -50, max = 50, step = 1,
							},
							yOffset = {
								order = getOrder(),
								type = 'range',
								name = 'yOffset',
								min = -50, max = 50, step = 1,
							},	
							test = {
								order = getOrder(),
								type = 'toggle',
								name = 'Test Mode',
								get = function () return E.db.epa.debug.testmode end,
								set = function (_, v) E.db.epa.debug.testmode = v; EPA:ToggleTestMode(v) end,	
							},		
						},
					},
				},
	}

	E.Options.args.unitframe.args['raid40'].args.priestaoe = {
		order = getOrder(),
		type = 'group',
		name = 'ElvUI Priest AoE',
		get = function(info) return E.db.unitframe.units['raid40']['priestaoe'][ info[#info] ] end,
		set = function(info, value) E.db.unitframe.units['raid40']['priestaoe'][ info[#info] ] = value; end,
		args = {
			poh = {
				order = getOrder(),
				type = 'group',
				name = 'Prayer of Healing',
				get = function(info) return E.db.unitframe.units['raid40']['priestaoe']['poh'][ info[#info] ] end,
				set = function(info, value) E.db.unitframe.units['raid40']['priestaoe']['poh'][ info[#info] ] = value; EPA:ApplyIconOptions(); end,
				args = {
					enable = {
						type = 'toggle',
						order = getOrder(),
						name = 'Enable',
					},	
					attachTo = {
						type = 'select',
						order = getOrder(),
						name = 'Position',
						values = auraAnchors,
					},
					size = {
						type = 'range',
						name = 'Size',
						order = getOrder(),
						min = 8, max = 30, step = 1,
					},				
					xOffset = {
						order = getOrder(),
						type = 'range',
						name = 'xOffset',
						min = -50, max = 50, step = 1,
					},
					yOffset = {
						order = getOrder(),
						type = 'range',
						name = 'yOffset',
						min = -50, max = 50, step = 1,
					},
					test = {
						order = getOrder(),
						type = 'toggle',
						name = 'Test Mode',
						get = function () return E.db.epa.debug.testmode end,
						set = function (_, v) E.db.epa.debug.testmode = v; EPA:ToggleTestMode(v) end,
						},
					},
			},
			coh = {
				order = getOrder(),
				type = 'group',
				name = 'Circle of Healing',
				get = function(info) return E.db.unitframe.units['raid40']['priestaoe']['coh'][ info[#info] ] end,
				set = function(info, value) E.db.unitframe.units['raid40']['priestaoe']['coh'][ info[#info] ] = value; EPA:ApplyIconOptions(); end,
				args = {
					enable = {
						type = 'toggle',
						order = getOrder(),
						name = 'Enable',
					},	
					attachTo = {
						type = 'select',
						order = getOrder(),
						name = 'Position',
						values = auraAnchors,
					},
					size = {
						type = 'range',
						name = 'Size',
						order = getOrder(),
						min = 8, max = 30, step = 1,
					},				
					xOffset = {
						order = getOrder(),
						type = 'range',
						name = 'xOffset',
						min = -50, max = 50, step = 1,
					},
					yOffset = {
						order = getOrder(),
						type = 'range',
						name = 'yOffset',
						min = -50, max = 50, step = 1,
					},	
					test = {
						order = getOrder(),
						type = 'toggle',
						name = 'Test Mode',
						get = function () return E.db.epa.debug.testmode end,
						set = function (_, v) E.db.epa.debug.testmode = v; EPA:ToggleTestMode(v) end,	
					},		
				},
			},
			ch = {
				order = getOrder(),
				type = 'group',
				name = 'CH Icon Options',
				get = function(info) return E.db.unitframe.units['raid40']['priestaoe']['ch'][ info[#info] ] end,
				set = function(info, value) E.db.unitframe.units['raid40']['priestaoe']['ch'][ info[#info] ] = value; EPA:ApplyIconOptions(); end,
				args = {
					enable = {
						type = 'toggle',
						order = getOrder(),
						name = 'Enable',
					},	
					attachTo = {
						type = 'select',
						order = getOrder(),
						name = 'Position',
						values = auraAnchors,
					},
					size = {
						type = 'range',
						name = 'Size',
						order = getOrder(),
						min = 8, max = 30, step = 1,
					},
					xOffset = {
						order = getOrder(),
						type = 'range',
						name = 'xOffset',
						min = -50, max = 50, step = 1,
					},
					yOffset = {
						order = getOrder(),
						type = 'range',
						name = 'yOffset',
						min = -50, max = 50, step = 1,
					},
					test = {
						order = getOrder(),
						type = 'toggle',
						name = 'Test Mode',
						get = function () return E.db.epa.debug.testmode end,
						set = function (_, v) E.db.epa.debug.testmode = v; EPA:ToggleTestMode(v) end,	
					},
				},
			},
			pwr = {
				order = getOrder(),
				type = 'group',
				name = 'PWR Icon Options',
				get = function(info) return E.db.unitframe.units['raid40']['priestaoe']['pwr'][ info[#info] ] end,
				set = function(info, value) E.db.unitframe.units['raid40']['priestaoe']['pwr'][ info[#info] ] = value; EPA:ApplyIconOptions(); end,
				args = {
					enable = {
						type = 'toggle',
						order = getOrder(),
						name = 'Enable',
					},	
					attachTo = {
						type = 'select',
						order = getOrder(),
						name = 'Position',
						values = auraAnchors,
					},
					size = {
						type = 'range',
						name = 'Size',
						order = getOrder(),
						min = 8, max = 30, step = 1,
					},				
					xOffset = {
						order = getOrder(),
						type = 'range',
						name = 'xOffset',
						min = -50, max = 50, step = 1,
					},
					yOffset = {
						order = getOrder(),
						type = 'range',
						name = 'yOffset',
						min = -50, max = 50, step = 1,
					},	
					test = {
						order = getOrder(),
						type = 'toggle',
						name = 'Test Mode',
						get = function () return E.db.epa.debug.testmode end,
						set = function (_, v) E.db.epa.debug.testmode = v; EPA:ToggleTestMode(v) end,	
					},		
				},
			},
			wg = {
				order = getOrder(),
				type = 'group',
				name = 'WG Icon Options',
				get = function(info) return E.db.unitframe.units['raid40']['priestaoe']['wg'][ info[#info] ] end,
				set = function(info, value) E.db.unitframe.units['raid40']['priestaoe']['wg'][ info[#info] ] = value; EPA:ApplyIconOptions(); end,
				args = {
					enable = {
						type = 'toggle',
						order = getOrder(),
						name = 'Enable',
					},	
					attachTo = {
						type = 'select',
						order = getOrder(),
						name = 'Position',
						values = auraAnchors,
					},
					size = {
						type = 'range',
						name = 'Size',
						order = getOrder(),
						min = 8, max = 30, step = 1,
					},				
					xOffset = {
						order = getOrder(),
						type = 'range',
						name = 'xOffset',
						min = -50, max = 50, step = 1,
					},
					yOffset = {
						order = getOrder(),
						type = 'range',
						name = 'yOffset',
						min = -50, max = 50, step = 1,
					},
					test = {
						order = getOrder(),
						type = 'toggle',
						name = 'Test Mode',
						get = function () return E.db.epa.debug.testmode end,
						set = function (_, v) E.db.epa.debug.testmode = v; EPA:ToggleTestMode(v) end,	
					},
				},
			},
		},
	}
end

table.insert(E.EPAConfigs, configTable)