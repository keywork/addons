-- ElvUI Improved System Datatext
-- By: Lockslap, US - Bleeding Hollow
-- Basic functionality is from ElvUI's system datatext, with some improvements by myself.
local Frame = CreateFrame("frame")
local E, _, V, P, G = unpack(ElvUI); --Inport: Engine, Locales, PrivateDB, ProfileDB, GlobalDB
local DT = E:GetModule("DataTexts")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_SystemDT", false)
local EP = LibStub("LibElvUIPlugin-1.0")

local format = string.format
local sort = table.sort
local join = string.join

local int, int2 = 6, 5
local memoryTable = {}
local cpuTable = {}
local statusColors = {
	"|cff0CD809",
	"|cffE8DA0F",
	"|cffFF9000",
	"|cffD80909"
}

local enteredFrame = false
local bandwidthString = "%.2f Mbps"
local percentageString = "%.2f%%"
local homeLatencyString = "%d ms"
local kiloByteString = "%d kb"
local megaByteString = "%.2f mb"
local freedString = ""

-- static popup
StaticPopupDialogs["CONFIRM_RELOAD_UI"] = {
	text			= L["Reload UI?"],
	button1			= L["Yes"],
	button2			= L["No"],
	OnAccept		= function(self) ReloadUI() end,
	timeout			= 10,
	whileDead		= true,
	hideOnEscape	= true,
}

local function FormatMemory(memory)
	local mult = 10 ^ 1
	if memory > 999 then
		local mem = ((memory / 1024) * mult) / mult
		return format(megaByteString, mem)
	else
		local mem = (memory * mult) / mult
		return format(kiloByteString, mem)
	end
end

local function RebuildAddonList()
	local addonCount = GetNumAddOns()
	if addonCount == #memoryTable then return end
	
	memoryTable = {}
	cpuTable = {}
	for i = 1, addonCount do
		memoryTable[i] = {i, select(2, GetAddOnInfo(i)), 0, IsAddOnLoaded(i)}
		cpuTable[i] = {i, select(2, GetAddOnInfo(i)), 0, IsAddOnLoaded(i)}
	end
end

local function GetNumLoadedAddons()
	local loaded = 0
	for i = 1, GetNumAddOns() do
		if IsAddOnLoaded(i) then loaded = loaded + 1 end
	end
	return loaded
end

local function UpdateMemory()
	UpdateAddOnMemoryUsage()
	
	local addonMemory, totalMemory = 0, 0
	for i = 1, #memoryTable do
		addonMemory = GetAddOnMemoryUsage(memoryTable[i][1])
		memoryTable[i][3] = addonMemory
		totalMemory = totalMemory + addonMemory
	end
	
	sort(memoryTable, function(a, b)
		if a and b then
			return a[3] > b[3]
		end
	end)
	
	return totalMemory
end

local function UpdateCPU()
	UpdateAddOnCPUUsage()

	local addonCPU, totalCPU = 0, 0
	for i = 1, #cpuTable do
		addonCPU = GetAddOnCPUUsage(cpuTable[i][1])
		cpuTable[i][3] = addonCPU
		totalCPU = totalCPU + addonCPU
	end
	
	sort(cpuTable, function(a, b)
		if a and b then
			return a[3] > b[3]
		end
	end)
	
	return totalCPU
end

local function OnEnter(self)
	DT:SetupTooltip(self)
	enteredFrame = true
	
	local cpuProfiling = GetCVar("scriptProfile") == "1"
	local bandwidth = GetAvailableBandwidth()
	local _, _, home_latency, world_latency = GetNetStats() 
	local shown = 0
	
	DT.tooltip:AddDoubleLine(L["Home Latency:"], format(homeLatencyString, home_latency), 0.69, 0.31, 0.31, 0.84, 0.75, 0.65)
	DT.tooltip:AddDoubleLine(L["World Latency:"], format(homeLatencyString, world_latency), 0.69, 0.31, 0.31, 0.84, 0.75, 0.65)
	if bandwidth ~= 0 then
		DT.tooltip:AddDoubleLine(L["Bandwidth"] , format(bandwidthString, bandwidth),0.69, 0.31, 0.31,0.84, 0.75, 0.65)
		DT.tooltip:AddDoubleLine(L["Download"] , format(percentageString, GetDownloadedPercentage() *100),0.69, 0.31, 0.31, 0.84, 0.75, 0.65)
		DT.tooltip:AddLine(" ")
	end
	
	DT.tooltip:AddDoubleLine(L["Loaded Addons:"], GetNumLoadedAddons(), 0.69, 0.31, 0.31, 0.84, 0.75, 0.65)
	DT.tooltip:AddDoubleLine(L["Total Addons:"], GetNumAddOns(), 0.69, 0.31, 0.31, 0.84, 0.75, 0.65)
	
	local totalMemory = UpdateMemory()
	local totalCPU = nil
	DT.tooltip:AddDoubleLine(L["Total Memory:"], FormatMemory(totalMemory), 0.69, 0.31, 0.31,0.84, 0.75, 0.65)
	if cpuProfiling then
		totalCPU = UpdateCPU()
		DT.tooltip:AddDoubleLine(L["Total CPU:"], format(homeLatencyString, totalCPU), 0.69, 0.31, 0.31,0.84, 0.75, 0.65)
	end
	
	if IsShiftKeyDown() or not cpuProfiling then
		DT.tooltip:AddLine(" ")
		for i = 1, #memoryTable do
			if E.db.sysdt.maxAddons - shown <= 1 then break end
			if (memoryTable[i][4]) then
				local red = memoryTable[i][3] / totalMemory
				local green = 1 - red
				DT.tooltip:AddDoubleLine(memoryTable[i][2], FormatMemory(memoryTable[i][3]), 1, 1, 1, red, green + .5, 0)
				shown = shown + 1
			end						
		end
	end
	
	if cpuProfiling and not IsShiftKeyDown() then
		shown = 0
		DT.tooltip:AddLine(" ")
		for i = 1, #cpuTable do
			if E.db.sysdt.maxAddons - shown <= 1 then break end
			if (cpuTable[i][4]) then
				local red = cpuTable[i][3] / totalCPU
				local green = 1 - red
				DT.tooltip:AddDoubleLine(cpuTable[i][2], format(homeLatencyString, cpuTable[i][3]), 1, 1, 1, red, green + .5, 0)
				shown = shown + 1
			end						
		end
		DT.tooltip:AddLine(" ")
		DT.tooltip:AddLine(L["(Hold Shift) Memory Usage"])
	end
	
	DT.tooltip:AddLine(" ")
	DT.tooltip:AddDoubleLine(L["Left Click:"], L["Garbage Collect"], 0.7, 0.7, 1.0, 1, 1, 1)
	DT.tooltip:AddDoubleLine(L["Right Click:"], L["Reload UI"], 0.7, 0.7, 1.0, 1, 1, 1)
	
	DT.tooltip:Show()	
end

local function OnLeave(self)
	enteredFrame = false
	DT.tooltip:Hide()
end

local function Update(self, t)
	int = int - t
	int2 = int2 - t
	
	if int <= 0 then
		RebuildAddonList()
		int = 10
	end
	
	if int2 <= 0 then
		local fps, fpsColor = floor(GetFramerate()), 4
		local latency = select(E.db.sysdt.latency == "world" and 4 or 3, GetNetStats())
		local latencyColor = 4
		
		-- determine latency color based on ping
		if latency < 150 then
			latencyColor = 1
		elseif latency >= 150 and latency < 300 then
			latencyColor = 2
		elseif latency >= 300 and latency < 500 then
			latencyColor = 3
		end
		
		-- determine fps color based on framerate
		if fps >= 30 then
			fpsColor = 1
		elseif fps >= 20 and fps < 30 then
			fpsColor = 2
		elseif fps >= 10 and fps < 20 then
			fpsColor = 3
		end
		
		-- set the datatext
		local fpsString = E.db.sysdt.showFPS and ("%s: %s%d|r "):format(L["FPS"], statusColors[fpsColor], fps) or ""
		local msString = E.db.sysdt.showMS and ("%s: %s%d|r "):format(L["MS"], statusColors[latencyColor], latency) or ""
		local memString = E.db.sysdt.showMemory and ("|cffffff00%s|r"):format(FormatMemory(UpdateMemory())) or ""
		self.text:SetText(join("", fpsString, msString, memString))
		int2 = 1
		
		if enteredFrame then OnEnter(self) end
	end
end

local function Click(self, button)
	if button == "LeftButton" then
		local preCollect = UpdateMemory()
		collectgarbage("collect")
		Update(self, 20)
		local postCollect = UpdateMemory()
		if E.db.sysdt.announceFreed then
			DEFAULT_CHAT_FRAME:AddMessage(freedString:format(FormatMemory(preCollect - postCollect)), 1.0, 1.0, 1.0)
		end
	elseif button == "RightButton" then
		StaticPopup_Show("CONFIRM_RELOAD_UI")
	end
end

local function ValueColorUpdate(hex, r, g, b)
	freedString = join("", hex, "ElvUI|r", " ", L["Garbage Collection Freed"], " ", "|cff00ff00%s|r")  
end
E["valueColorUpdateFuncs"][ValueColorUpdate] = true

P["sysdt"] = {
	["maxAddons"]		= 6,
	["showFPS"]			= true,
	["showMS"]			= true,
	["latency"]			= "home",
	["showMemory"]		= false,
	["announceFreed"]	= true,
}

local function InjectOptions()
	if not E.Options.args.lockslap then
		E.Options.args.lockslap = {
			type = "group",
			order = -2,
			name = L["Plugins by |cff9382c9Lockslap|r"],
			args = {
				thanks = {
					type = "description",
					order = 1,
					name = L["Thanks for using and supporting my work!  -- |cff9382c9Lockslap|r\n\n|cffff0000If you find any bugs, or have any suggestions for any of my addons, please open a ticket at that particular addon's page on CurseForge."],
				},
			},
		}
	elseif not E.Options.args.lockslap.args.thanks then
		E.Options.args.lockslap.args.thanks = {
			type = "description",
			order = 1,
			name = L["Thanks for using and supporting my work!  -- |cff9382c9Lockslap|r\n\n|cffff0000If you find any bugs, or have any suggestions for any of my addons, please open a ticket at that particular addon's page on CurseForge."],
		}
	end
	
	-- inject our config into elvui's config window
	E.Options.args.lockslap.args.impsysdt = {
		type = "group",
		name = L["Improved System Datatext"],
		get = function(info) return E.db.sysdt[info[#info]] end,
		set = function(info, value) E.db.sysdt[info[#info]] = value; DT:LoadDataTexts() end,
		args = {
			maxAddons = {
				type = "range",
				order = 1,
				name = L["Max Addons"],
				desc = L["Maximum number of addons to show in the tooltip."],
				min = 1, max = 50, step = 1,
			},
			announceFreed = {
				type = "toggle",
				order = 2,
				name = L["Announce Freed"],
				desc = L["Announce how much memory was freed by the garbage collection."],
			},
			showFPS = {
				type = "toggle",
				order = 3,
				name = L["Show FPS"],
				desc = L["Show FPS on the datatext."],
			},
			showMemory = {
				type = "toggle",
				order = 4,
				name = L["Show Memory"],
				desc = L["Show total addon memory on the datatext."]
			},
			showMS = {
				type = "toggle",
				order = 5,
				name = L["Show Latency"],
				desc = L["Show latency on the datatext."],
			},
			latency = {
				type = "select",
				order = 6,
				name = L["Latency Type"],
				desc = L["Display world or home latency on the datatext.  Home latency refers to your realm server.  World latency refers to the current world server."],
				disabled = function() return not E.db.sysdt.showMS end,
				values = {
					["home"] = L["Home"],
					["world"] = L["World"],
				}
			},
		}
	}
end

EP:RegisterPlugin(..., InjectOptions)
DT:RegisterDatatext("Improved System", nil, nil, Update, Click, OnEnter, OnLeave)