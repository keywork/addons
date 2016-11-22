local E, L, V, P, G, _ = unpack(ElvUI); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB, Localize Underscore
local VAT = E:NewModule('VisualAuraTimers', 'AceEvent-3.0')
local A = E:GetModule('Auras');

-- Defaults
P['VAT'] = {
	['enable'] = true,
	['noduration'] = true,
	['position'] = 'BOTTOM',
	['spacing'] = 0,
	['barWidth'] = 6,
	['barHeight'] = 5,
	['enableStaticColor'] = false,
	['staticColor'] = {r = 0, g = 179/255, b = 1},
	['backdropColor'] = {r = 0.3, g = 0.3, b = 0.3},
	['useStatusbarTexture'] = true,
	['useBackdropTexture'] = true,
	['statusbarTexture'] = 'ElvUI Norm',
	['backdropTexture'] = 'ElvUI Norm',
	['showText'] = false,
	['tenable'] = true,
	['decimalThreshold'] = 4,
	['threshold'] = {
		['buffs'] = false,
		['buffsvalue'] = 5,
		['debuffs'] = true,
		['debuffsvalue'] = 10,
		['tempenchants'] = false,
		['tempenchantsvalue'] = 60,
	},
	['colors'] = {
		['expire'] = { r = 1, g = 0, b = 0 },
		['expireIndicator'] = { r = 0, g = 179/255, b = 1 },
		['seconds'] = { r = 0.93, g = 0.93, b = 0.93 },
		['secondsIndicator'] = { r = 0, g = 179/255, b = 1 },
		['minutes'] = { r = 0.93, g = 0.93, b = 0.93 },
		['minutesIndicator'] = { r = 0, g = 179/255, b = 1 },
		['hours'] = { r = 0.93, g = 0.93, b = 0.93 },
		['hoursIndicator'] = { r = 0, g = 179/255, b = 1 },
		['days'] = { r = 0.93, g = 0.93, b = 0.93 },
		['daysIndicator'] = { r = 0, g = 179/255, b = 1 },
		
		--ExactAuras support
		['hourminutes'] = { r = 0.93, g = 0.93, b = 0.93 },
		['hourminutesIndicator'] = { r = 0, g = 179/255, b = 1 },
	},
}

function VAT:InsertOptions()
	if not E.Options.args.blazeplugins then
		E.Options.args.blazeplugins = {
			order = -2,
			type = 'group',
			name = 'Plugins (by Blazeflack)',
			args = {},
		}
	end
	E.Options.args.blazeplugins.args.VAT = {
		order = 50,
		type = 'group',
		name = 'VisualAuraTimers',
		childGroups = 'tab',
		disabled = function() return not E.private.auras.enable end,
		args = {
			statusbar = {
				order = 1,
				type = 'group',
				name = L['Statusbar Options'],
				get = function(info) return E.db.VAT[ info[#info] ] end,
				set = function(info, value) E.db.VAT[ info[#info] ] = value; A:UpdateHeader(ElvUIPlayerBuffs); A:UpdateHeader(ElvUIPlayerDebuffs) end,
				args = {
					info1 = {
						order = 1,
						type = 'header',
						name = L['Statusbar Options'],
					},
					general = {
						type = 'group',
						order = 2,
						name = L['General Options'],
						guiInline = true,
						args = {
							enable = {
								type = 'toggle',
								order = 2,
								name = L['Enable'],
								desc = L['Show timers as bars instead of text.'],
							},
							noduration = {
								type = 'toggle',
								order = 3,
								name = L['No Duration'],
								desc = L['Show bars for auras without a duration.'],
								disabled = function() return not E.db.VAT.enable end,
							},
						},
					},
					posAndSize = {
						type = 'group',
						order = 3,
						name = L['Position and Size'],
						guiInline = true,
						args = {
							position = {
								type = 'select',
								order = 1,
								name = L['Statusbar Position'],
								desc = L['Choose where you want the statusbar to be positioned. If you position it on the left or right side of the icon I advice you to increase Horizontal Spacing for Buffs and Debuffs. Changing this requires you to reload UI.'],
								disabled = function() return not E.db.VAT.enable end,
								values = {
									['TOP'] = L['Above Icons'],
									['BOTTOM'] = L['Below Icons'],
									['LEFT'] = L['Left Side of Icons'],
									['RIGHT'] = L['Right Side of Icons'],
								},
							},
							spacing = {
								order = 2,
								type = 'range',
								name = L['Statusbar Spacing'],
								desc = L['Additional spacing between icon and statusbar. If a negative value is chosen then the statusbar is shown inside the icon. Changing this requires you to reload UI.'],
								min = -20, max = 20, step = 1,
								disabled = function() return not E.db.VAT.enable end,
							},
							spacer1 = {
								type = 'description',
								order = 3,
								name = '',
							},
							barHeight = {
								type = 'range',
								order = 4,
								name = L['Statusbar Height'],
								desc = L['Height of the statusbar frame (default: 5). Changing this requires you to reload UI.'],
								min = 3, max = 20, step = 1,
								disabled = function() return not E.db.VAT.enable or (E.db.VAT.position == 'LEFT') or (E.db.VAT.position == 'RIGHT') end,
							},
							barWidth = {
								type = 'range',
								order = 5,
								name = L['Statusbar Width'],
								desc = L['Width of the statusbar frame (default: 6). Changing this requires you to reload UI.'],
								min = 3, max = 20, step = 1,
								disabled = function() return not E.db.VAT.enable or (E.db.VAT.position == 'BOTTOM') or (E.db.VAT.position == 'TOP') end,
							},
						},
					},
					textures = {
						type = 'group',
						order = 4,
						name = L['Textures'],
						guiInline = true,
						args = {
							useStatusbarTexture = {
								type = 'toggle',
								order = 1,
								name = L['Use Statusbar Texture'],
								desc = L['Allows you to choose which texture to use for statusbars. If disabled, no texture will be used.'],
								disabled = function() return not E.db.VAT.enable end,
							},
							statusbarTexture = {
								type = 'select',
								dialogControl = 'LSM30_Statusbar',
								order = 2,
								name = L['Statusbar Texture'],
								disabled = function() return (not E.db.VAT.useStatusbarTexture or not E.db.VAT.enable) end,
								values = AceGUIWidgetLSMlists.statusbar,
							},
							spacer1 = {
								type = 'description',
								order = 3,
								name = '',
							},
							useBackdropTexture = {
								type = 'toggle',
								order = 4,
								name = L['Use Backdrop Texture'],
								desc = L['Allows you to choose which texture to use for statusbar backdrops. If disabled, no texture will be used.'],
								disabled = function() return not E.db.VAT.enable end,
							},
							backdropTexture = {
								type = 'select',
								dialogControl = 'LSM30_Statusbar',
								order = 5,
								name = L['Statusbar Backdrop Texture'],

								disabled = function() return (not E.db.VAT.useBackdropTexture or not E.db.VAT.enable) end,
								values = AceGUIWidgetLSMlists.statusbar,
							},
						},
					},
					colors = {
						type = 'group',
						order = 5,
						name = L['Colors'],
						guiInline = true,
						args = {
							enableStaticColor = {
								type = 'toggle',
								order = 1,
								name = L['Enable Static Color'],
								desc = L['Changes the statusbar to use a static color instead of going from green to red the lower duration it has.'],
								disabled = function() return not E.db.VAT.enable end,
							},
							staticColor = {
								type = 'color',
								order = 2,
								name = L['Static Statusbar Color'],
								desc = L['Choose which color you want your statusbars to use.'],
								hasAlpha = false,
								disabled = function() return (not E.db.VAT.enableStaticColor or not E.db.VAT.enable) end,
								get = function(info)
									local t = E.db.VAT[ info[#info] ]
									return t.r, t.g, t.b, t.a
								end,
								set = function(info, r, g, b)
									E.db.VAT[ info[#info] ] = {}
									local t = E.db.VAT[ info[#info] ]
									t.r, t.g, t.b = r, g, b
								end,
							},
							backdropColor = {
								type = 'color',
								order = 3,
								name = L['Statusbar Backdrop Color'],
								desc = L['Choose which color you want the statusbar backdrops to use. Tip: use light colors for dark statusbar colors and vice versa.'],
								hasAlpha = false,
								disabled = function() return not E.db.VAT.enable end,
								get = function(info)
									local t = E.db.VAT[ info[#info] ]
									return t.r, t.g, t.b, t.a
								end,
								set = function(info, r, g, b)
									E.db.VAT[ info[#info] ] = {}
									local t = E.db.VAT[ info[#info] ]
									t.r, t.g, t.b = r, g, b
								end,
							},
						},
					},
				},
			},
			timer = {
				type = 'group',
				order = 2,
				name = L['Text Options'],
				get = function(info) return E.db.VAT[ info[#info] ] end,
				set = function(info, value) E.db.VAT[ info[#info] ] = value; end,
				args = {
					info2 = {
						order = 1,
						type = 'header',
						name = L['Text Options'],
					},
					showText = {
						type = 'toggle',
						order = 2,
						name = L['Always Show Text'],
						desc = L['Show text in addition to statusbars. (You might need to move the text by changing the offset in the Buffs and Debuffs section)'],
						disabled = function() return not E.db.VAT.enable end,
					},
					tenable = {
						type = 'toggle',
						order = 3,
						name = L['Text Threshold'],
						desc = L['Switch to text based timers when duration goes below threshold'],
						disabled = function() return (E.db.VAT.showText or not E.db.VAT.enable) end,
					},
					decimalThreshold = {
						type = 'range',
						order = 4,
						name = L["Decimal Threshold"],
						desc = L['Threshold before the timer changes color and goes into decimal form. Set to -1 to disable.'],
						min = -1, max = 30, step = 1,
					},
					spacer3 = {
						type = 'description',
						order = 5,
						name = '',
					},
					threshold = {
						type = 'group',
						name = L['Text Threshold'],
						order = 6,
						guiInline = true,
						get = function(info) return E.db.VAT.threshold[ info[#info] ] end,
						set = function(info, value) E.db.VAT.threshold[ info[#info] ] = value end,
						disabled = function() return (not E.db.VAT.tenable or not E.db.VAT.enable) end,
						args = {
							buffs = {
								type = 'toggle',
								order = 1,
								name = L['Buffs'],
								desc = L['If enabled, the timers on your buffs will switch to text when duration goes below set threshold.'],
								disabled = function() return (E.db.VAT.showText or not E.db.VAT.tenable or not E.db.VAT.enable) end,
							},
							debuffs = {
								type = 'toggle',
								order = 2,
								name = L['Debuffs'],
								desc = L['If enabled, the timers on your debuffs will switch to text when duration goes below set threshold.'],
								disabled = function() return (E.db.VAT.showText or not E.db.VAT.tenable or not E.db.VAT.enable) end,
							},
							tempenchants = {
								type = 'toggle',
								order = 3,
								name = L['Temporary Enchants'],
								desc = L['If enabled, the timers on your temporary enchant(s) will switch to text when duration goes below set threshold.'],
								disabled = function() return (E.db.VAT.showText or not E.db.VAT.tenable or not E.db.VAT.enable) end,
							},
							spacer4 = {
								type = 'description',
								order = 4,
								name = '',
							},
							buffsvalue = {
								type = 'range',
								order = 5,
								name = L['Buffs Threshold'],
								desc = L['Threshold in seconds before status bar based timers turn to text.'],
								disabled = function() return (E.db.VAT.showText or not E.db.VAT.threshold.buffs or not E.db.VAT.tenable or not E.db.VAT.enable) end,
								min = 0, max = 180, step = 1,
							},
							debuffsvalue = {
								type = 'range',
								order = 6,
								name = L['Debuffs Threshold'],
								desc = L['Threshold in seconds before status bar based timers turn to text.'],
								disabled = function() return (E.db.VAT.showText or not E.db.VAT.threshold.debuffs or not E.db.VAT.tenable or not E.db.VAT.enable) end,
								min = 0, max = 60, step = 1,
							},
							tempenchantsvalue = {
								type = 'range',
								order = 7,
								name = L['Temp. Threshold'],
								desc = L['Threshold in seconds before status bar based timers turn to text.'],
								disabled = function() return (E.db.VAT.showText or not E.db.VAT.threshold.tempenchants or not E.db.VAT.tenable or not E.db.VAT.enable) end,
								min = 0, max = 300, step = 1,
							},
						},
					},
					colors = {
						order = 7,
						type = 'group',
						name = L['Colors'],
						guiInline = true,
						args = {
							numbers = {
								order = 1,
								type = 'group',
								guiInline = true,
								name = L['Numbers'],
								args = {
									restoreColors = {
										order = 1,
										type = 'execute',
										name = L['Restore Defaults'],
										func = function()
											E.db.VAT.colors.expire = P['VAT']['colors'].expire;
											E.db.VAT.colors.seconds = P['VAT']['colors'].seconds;
											E.db.VAT.colors.minutes = P['VAT']['colors'].minutes;
											E.db.VAT.colors.hours = P['VAT']['colors'].hours;
											E.db.VAT.colors.days = P['VAT']['colors'].days;
											E.db.VAT.colors.hourminutes = P['VAT']['colors'].hourminutes;
											VAT:UpdateTimerColors()
										end,
									},
									spacer5 = {
										type = 'description',
										order = 2,
										name = '',
									},
									expire = {
										type = 'color',
										order = 3,
										name = L['Expiring'],
										desc = L['Color when the text is about to expire'],
										get = function(info)
											local t = E.db.VAT.colors[ info[#info] ]
											return t.r, t.g, t.b, t.a
										end,
										set = function(info, r, g, b)
											E.db.VAT.colors[ info[#info] ] = {}
											local t = E.db.VAT.colors[ info[#info] ]
											t.r, t.g, t.b = r, g, b
											VAT:UpdateTimerColors()
										end,					
									},
									seconds = {
										type = 'color',
										order = 4,
										name = L['Seconds'],
										desc = L['Color when the text is in the seconds format.'],
										get = function(info)
											local t = E.db.VAT.colors[ info[#info] ]
											return t.r, t.g, t.b, t.a
										end,
										set = function(info, r, g, b)
											E.db.VAT.colors[ info[#info] ] = {}
											local t = E.db.VAT.colors[ info[#info] ]
											t.r, t.g, t.b = r, g, b
											VAT:UpdateTimerColors()
										end,				
									},
									minutes = {
										type = 'color',
										order = 5,
										name = L['Minutes'],
										desc = L['Color when the text is in the minutes format.'],
										get = function(info)
											local t = E.db.VAT.colors[ info[#info] ]
											return t.r, t.g, t.b, t.a
										end,
										set = function(info, r, g, b)
											E.db.VAT.colors[ info[#info] ] = {}
											local t = E.db.VAT.colors[ info[#info] ]
											t.r, t.g, t.b = r, g, b
											VAT:UpdateTimerColors()
										end,				
									},
									hours = {
										type = 'color',
										order = 6,
										name = L['Hours'],
										desc = L['Color when the text is in the hours format.'],
										get = function(info)
											local t = E.db.VAT.colors[ info[#info] ]
											return t.r, t.g, t.b, t.a
										end,
										set = function(info, r, g, b)
											E.db.VAT.colors[ info[#info] ] = {}
											local t = E.db.VAT.colors[ info[#info] ]
											t.r, t.g, t.b = r, g, b
											VAT:UpdateTimerColors()
										end,				
									},	
									days = {
										type = 'color',
										order = 7,
										name = L['Days'],
										desc = L['Color when the text is in the days format.'],
										get = function(info)
											local t = E.db.VAT.colors[ info[#info] ]
											return t.r, t.g, t.b, t.a
										end,
										set = function(info, r, g, b)
											E.db.VAT.colors[ info[#info] ] = {}
											local t = E.db.VAT.colors[ info[#info] ]
											t.r, t.g, t.b = r, g, b
											VAT:UpdateTimerColors()
										end,				
									},
									hourminutes = {
										type = 'color',
										order = 8,
										name = L['Hour/Minutes'],
										desc = L['Color when the text is in the HH:MM format (provided by the ExactAuras addon).'],
										get = function(info)
											local t = E.db.VAT.colors[ info[#info] ]
											return t.r, t.g, t.b, t.a
										end,
										set = function(info, r, g, b)
											E.db.VAT.colors[ info[#info] ] = {}
											local t = E.db.VAT.colors[ info[#info] ]
											t.r, t.g, t.b = r, g, b
											VAT:UpdateTimerColors()
										end,				
									},
								},
							},
							dateIndicator = {
								order = 2,
								type = 'group',
								guiInline = true,
								name = L['Indicator (s, m, h, d)'],
								args = {
									restoreColors = {
										order = 1,
										type = 'execute',
										name = L['Restore Defaults'],
										func = function()
											E.db.VAT.colors.expireIndicator = P['VAT']['colors'].expireIndicator;
											E.db.VAT.colors.secondsIndicator = P['VAT']['colors'].secondsIndicator;
											E.db.VAT.colors.minutesIndicator = P['VAT']['colors'].minutesIndicator;
											E.db.VAT.colors.hoursIndicator = P['VAT']['colors'].hoursIndicator;
											E.db.VAT.colors.daysIndicator = P['VAT']['colors'].daysIndicator;
											E.db.VAT.colors.hourminutesIndicator = P['VAT']['colors'].hourminutesIndicator;
											VAT:UpdateTimerColors()
										end,
									},
									spacer6 = {
										type = 'description',
										order = 2,
										name = '',
									},
									expireIndicator = {
										type = 'color',
										order = 3,
										name = L['Expiring'],
										desc = L['Color when the text is about to expire'],
										get = function(info)
											local t = E.db.VAT.colors[ info[#info] ]
											return t.r, t.g, t.b, t.a
										end,
										set = function(info, r, g, b)
											E.db.VAT.colors[ info[#info] ] = {}
											local t = E.db.VAT.colors[ info[#info] ]
											t.r, t.g, t.b = r, g, b
											VAT:UpdateTimerColors()
										end,					
									},
									secondsIndicator = {
										type = 'color',
										order = 4,
										name = L['Seconds'],
										desc = L['Color when the text is in the seconds format.'],
										get = function(info)
											local t = E.db.VAT.colors[ info[#info] ]
											return t.r, t.g, t.b, t.a
										end,
										set = function(info, r, g, b)
											E.db.VAT.colors[ info[#info] ] = {}
											local t = E.db.VAT.colors[ info[#info] ]
											t.r, t.g, t.b = r, g, b
											VAT:UpdateTimerColors()
										end,				
									},
									minutesIndicator = {
										type = 'color',
										order = 5,
										name = L['Minutes'],
										desc = L['Color when the text is in the minutes format.'],
										get = function(info)
											local t = E.db.VAT.colors[ info[#info] ]
											return t.r, t.g, t.b, t.a
										end,
										set = function(info, r, g, b)
											E.db.VAT.colors[ info[#info] ] = {}
											local t = E.db.VAT.colors[ info[#info] ]
											t.r, t.g, t.b = r, g, b
											VAT:UpdateTimerColors()
										end,				
									},
									hoursIndicator = {
										type = 'color',
										order = 6,
										name = L['Hours'],
										desc = L['Color when the text is in the hours format.'],
										get = function(info)
											local t = E.db.VAT.colors[ info[#info] ]
											return t.r, t.g, t.b, t.a
										end,
										set = function(info, r, g, b)
											E.db.VAT.colors[ info[#info] ] = {}
											local t = E.db.VAT.colors[ info[#info] ]
											t.r, t.g, t.b = r, g, b
											VAT:UpdateTimerColors()
										end,				
									},	
									daysIndicator = {
										type = 'color',
										order = 7,
										name = L['Days'],
										desc = L['Color when the text is in the days format.'],
										get = function(info)
											local t = E.db.VAT.colors[ info[#info] ]
											return t.r, t.g, t.b, t.a
										end,
										set = function(info, r, g, b)
											E.db.VAT.colors[ info[#info] ] = {}
											local t = E.db.VAT.colors[ info[#info] ]
											t.r, t.g, t.b = r, g, b
											VAT:UpdateTimerColors()
										end,				
									},
									hourminutesIndicator = {
										type = 'color',
										order = 8,
										name = L['Hour/Minutes'],
										desc = L['Color when the text is in the HH:MM format (provided by the ExactAuras addon).'],
										get = function(info)
											local t = E.db.VAT.colors[ info[#info] ]
											return t.r, t.g, t.b, t.a
										end,
										set = function(info, r, g, b)
											E.db.VAT.colors[ info[#info] ] = {}
											local t = E.db.VAT.colors[ info[#info] ]
											t.r, t.g, t.b = r, g, b
											VAT:UpdateTimerColors()
										end,				
									},
								},
							},
						},
					},
				},
			},
		},
	}
end

E:RegisterModule(VAT:GetName())