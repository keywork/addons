--[[
	StupidBuffs2
		by Zyzx (Kilrogg-US)
	
	Modified from StupidBuff r4 by Muletia of Proudmoore
	Originally based on StupidMohawk v2 by Myrilandell of Lothar
]]--
local LibStub = assert(LibStub, "StupidBuffs2 requires LibStub.")
local frame = CreateFrame("Frame", nil, UIParent)
frame.name = "StupidBuffs2"
local StupidBuffs2 = LibStub("AceAddon-3.0"):NewAddon(frame, "StupidBuffs2", "AceEvent-3.0")

--[[
	Variable Definitions
]]--
local options = {
	name = "StupidBuffs2",
	desc = "StupidBuffs2",
	type = "group",
	args = {
		active = {
			order = 0,
			type = "toggle",
			name = "Enable StupidBuffs2",
			desc = "Toggle StupidBuffs on/off ( /sb active [on|off] )",
			set = function(info, v)
				SB2_OptionsDB["active"] = v
				if v == true then isact = "Enabled" else isact = "Disabled" end
				print("StupidBuffs2: Add-on " .. isact .. ".")
				return
			end,
			get = function(info) return SB2_OptionsDB["active"] end,
		},
		report = {
			order = 1,
			type = "toggle",
			name = "Show Chat Output",
			desc = "Toggle the chat output when buffs are removed ( /sb report [on|off] )",
			set = function(info, v) 
			  SB2_OptionsDB["report"] = v 
				if v == true then isact = "enabled" else isact = "disabled" end
				print("StupidBuffs2: Buff removal reporting " .. isact .. ".")
				return 
			end,
			get = function(info) return SB2_OptionsDB["report"] end,
		},
		split = {
			order = 2,
			type = "header",
			name = "Remove These (Stupid) Buffs: (one per line)",
			desc = "",
		},
		optframe = {
			order = 3,
			type = "input",
			multiline = 16,
			width = "full",
			cmdHidden = true,
			name = "",
			desc = "",
			set = function(info, v) SB2_OptionsDB["autoremove"] = { strsplit("[^\r\n]+", v) } return end,
			get = function() return table.concat(SB2_OptionsDB["autoremove"], "\n") end,
		},
		config = {
			type = "execute",
			name = "Configure",
			desc = "Open the StupidBuffs2 configuration screen".." ( /sb config )",
			func = function() return InterfaceOptionsFrame_OpenToCategory("StupidBuffs2") end,
			guiHidden = true,
		},
		reset = {
			type = "execute",
			name = "Default",
			desc = "Reset StupidBuffs2 back to default values".." ( /sb reset )",
			func = function() 
				SB2_OptionsDB = { }
				SB2_OptionsDB = Default_SB2_OptionsDB 
				print("StupidBuffs2: Defaults loaded.")
				return 
			end,
			guiHidden = true,
		},
		removeall = {
			order = 999,
			type = "execute",
			name = "Remove all buffs",
			desc = "Remove all buffs on you at the moment ( /sb removeall )",
			func = function() StupidBuffs2:RemoveAllBuffs() return end,
			guiHidden = true,
		},
	},
}

Default_SB2_OptionsDB = {
	autoremove = {
		"Mohawked!",
		"Jack-o'-Lanterned!",
		"Pirate Costume",
		"Leper Gnome Costume",
		"Bat Costume",
		"Ghost Costume",
		"Ninja Costume",
		"Wisp Costume",
		"Skeleton Costume",
		"Turkey Feathers",
		"Rabbit Costume",
	},
	active = true,
	report = true,
}

--[[
	Functions
]]--
function StupidBuffs2:OnInitialize()
	LibStub("AceConfig-3.0"):RegisterOptionsTable("StupidBuffs2", options, {"stupidbuffs2", "sb"})
	StupidBuffsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("StupidBuffs2");
  if SB2_OptionsDB then
		print("StupidBuffs2 loaded. /sb for options.")
	else
		SB2_OptionsDB = Default_SB2_OptionsDB
	 	print("StupidBuffs2 defaults loaded. /sb for options.")
	end
end

function StupidBuffs2:UNIT_AURA(event, unitid, ...)
	if unitid ~= "player" or SB2_OptionsDB["active"] == false then
		return
	else
	  if (UnitAffectingCombat("player") == 1 and true or false) then
		  return;
		end
		
		for _,v in pairs(SB2_OptionsDB["autoremove"]) do
			if UnitAura("player", v) then
				if SB2_OptionsDB["report"] == true then
					print(string.format("StupidBuffs2: Removed %s.", v))
				end
				CancelUnitBuff("player", v);
			end
		end
	end
end

function StupidBuffs2:PLAYER_REGEN_ENABLED(event, ...)
	if SB2_OptionsDB["active"] == false then
		return
	else

		for _,v in pairs(SB2_OptionsDB["autoremove"]) do
			if UnitAura("player", v) then
				if SB2_OptionsDB["report"] == true then
					print(string.format("StupidBuffs2: Removed %s.", v))
				end
				CancelUnitBuff("player", v);
			end
		end
	end
end


function StupidBuffs2:RemoveAllBuffs()
  if (UnitAffectingCombat("player") == 1 and true or false) then
    return;
  end

	count = 0
	for i=1,40 do
		local name = UnitBuff("player", i);
		if (name == nil) then
			if SB2_OptionsDB["report"] == true then
				print(string.format("StupidBuffs2: Removed %i buffs.", count))
			end
			return;
		end
		CancelUnitBuff("player", i);
		count = count + 1
	end
end

StupidBuffs2:RegisterEvent("UNIT_AURA");
StupidBuffs2:RegisterEvent("PLAYER_REGEN_ENABLED");
