------------------------------------------------------------------------------
--	EPA by InKahootz
--    Special thanks to Slaren for GridStatusPriestAoe
------------------------------------------------------------------------------
local E, L, V, P, G, _ = unpack(ElvUI); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB, Localize Underscore
local EPA = E:NewModule('EPA', 'AceHook-3.0', 'AceEvent-3.0', 'AceConsole-3.0');
local UF = E:GetModule('UnitFrames');
local DTP
local EP = LibStub("LibElvUIPlugin-1.0")
local addon = ...
local AddOnName = select(1,addon)

E.EPAConfigs =  {}
EPA.frame = CreateFrame("Frame")
EPA:UnregisterAllEvents()
EPA.Title = "|cff1784d1ElvUI |r|cffFFFFFFPriestAoe|r"
EPA.Version = GetAddOnMetadata(AddOnName, 'Version')
EPA.TicketTracker = 'http://www.tukui.org/tickets/elvuipriestaoe/'
EPA.TexCoords = E.TexCoords
EPA.MyClass = E.myclass
EPA.MyName = E.myname
EPA.MyRealm = E.myrealm
EPA.MyGUID = E.myguid
EPA.Noop = function() return end

-- constants
local MAX_PLAYERS_PER_GROUP = 5
local TALENTTREE_PRIEST_DISCIPLINE = 1
local TALENTTREE_PRIEST_HOLY = 2
local TALENTTREE_DRUID_RESTORATION = 4
local SPELLID_COH = 204883
local SPELLID_POH = 596
local SPELLID_COP = 155245
local SPELLID_CH = 1064
local SPELLID_WG = 48438
local SPELLID_PWR = 194509
local GLYPH_COH = 55675
local GLYPH_CH  = 41522
local GLYPH_WG  = 62970
local ICON_COH = GetSpellTexture(SPELLID_COH)
local ICON_POH = GetSpellTexture(SPELLID_POH)
local ICON_CH = GetSpellTexture(SPELLID_CH)
local ICON_PWR = GetSpellTexture(SPELLID_PWR)
local ICON_WG = GetSpellTexture(SPELLID_WG)

local ICONTEXTURES = {
	['coh'] = ICON_COH,
	['poh'] = ICON_POH,
	['hn'] = ICON_HN,
	['ch'] = ICON_CH,
	['pwr'] = ICON_PWR,
	['wg'] = ICON_WG,
}

local SPELLMOD_COH = 2.6
local SPELLMOD_POH = 2
local SPELLMOD_HN  = 1.125
local SPELLMOD_CH  = 4
local SPELLMOD_PWR  = 2.5
local SPELLMOD_WG  = 2.38

-- locals
local UnitGUID, UnitPosition, UnitDistanceSquared, GetSpellCooldown, UnitHealth, UnitHealthMax, UnitIsVisible, UnitIsDeadOrGhost, UnitIsConnected, UnitIsEnemy, UnitIsCharmed, UnitIsUnit, UnitBuff, UnitGetIncomingHeals =
	UnitGUID, UnitPosition, UnitDistanceSquared, GetSpellCooldown, UnitHealth, UnitHealthMax, UnitIsVisible, UnitIsDeadOrGhost, UnitIsConnected, UnitIsEnemy, UnitIsCharmed, UnitIsUnit, UnitBuff, UnitGetIncomingHeals
local GetSpellCritChance, GetSpellBonusHealing, GetCombatRatingBonus, GetVersatilityBonus, GetSpecialization, GetNumGroupMembers, GetRaidRosterInfo, IsInRaid, IsInGroup, UnitExists, UnitInRaid, UnitInRange, GetSpellInfo =
	GetSpellCritChance, GetSpellBonusHealing, GetCombatRatingBonus, GetVersatilityBonus, GetSpecialization, GetNumGroupMembers, GetRaidRosterInfo, IsInRaid, IsInGroup, UnitExists, UnitInRaid, UnitInRange, GetSpellInfo
local math_min, math_max, math_floor, sqrt, tinsert, tsort, select, pairs, twipe, print, tostring, GetTime = 
	math.min, math.max, math.floor, sqrt, table.insert, table.sort, select, pairs, table.wipe, print, tostring, GetTime

-- Raid Settings
local raidvisibility = SecureCmdOptionParse(E.db.unitframe.units.raid.visibility)
local raidgroups = E.db.unitframe.units.raid.numGroups
local raid40visibility = SecureCmdOptionParse(E.db.unitframe.units.raid40.visibility)
local raid40groups = E.db.unitframe.units.raid40.numGroups
local curRaidGroup = ""
local frameHeader
if raidvisibility=="show" then
	curRaidGroup = ""
	frameHeader = "raid"
elseif raid40visibility == "show" then
	curRaidGroup = "40"
	frameHeader = "raid40"
end
-- local data
local settings, settings_coh, settings_poh, settings_ch, settings_hn, settings_pwr, settings_wg, settings_debug
local num_enabled = 0

-- Spell Unit locals
local coh_prev_best = {
	uid = nil,
	guid = nil,
	amount = -1
}

local pwr_prev_best = {
	uid = nil,
	guid = nil,
	amount = -1
}

local wg_prev_best = {
	uid = nil,
	guid = nil,
	amount = -1
}

local poh_prev_best = {
	uid = nil,
	guid = nil,
	amount = -1
}

local spellname_gopoh

local coh_targets = 5
local coh_coef_madd
local coh_coef_m

local poh_coef_madd
local poh_coef_m

local hn_coef_madd
local hn_coef_m

local ch_coef_madd
local ch_coef_m
local ch_range

local wg_targets = 6

local pwr_targets = 3

local update_timer = 0
local num_groups = 1
local test_of_faith_mul
local roster
local player_group
local player_data = {}
local currentSpecializationInteger

local unitIDToFrame = {}
local metatable = { __call = function(table, key)
	if table[key] then
		return table[key][1], table[key][2], table[key][3]
	end
end }
setmetatable(unitIDToFrame,metatable)
--[[
local function print(...)
	DEFAULT_CHAT_FRAME:AddMessage("|cff1784d1PriestAoe|r: " .. table.concat({...}, " "))
end
]]

local function getOptions()
	for _, func in pairs(E.EPAConfigs) do
		func()
	end
end

function EPA:Initialize()
	EP:RegisterPlugin(addon, getOptions)
	EPA:RegisterChatCommand("eparoster", "PrintRoster")
	EPA:RegisterEvent("PLAYER_TALENT_UPDATE", "UpdateTalents")
	EPA:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED", "UpdateTalents")
	EPA:RegisterEvent("PLAYER_EQUIPMENT_CHANGED", "UpdateCoefs")
	EPA:RegisterEvent("GROUP_ROSTER_UPDATE", "UpdateRoster")
	EPA:RegisterEvent("PLAYER_ENTERING_WORLD", "UpdateRoster")
	EPA.frame:SetScript("OnUpdate", function(_, elapsed) return self:OnUpdate(elapsed) end)
	
	settings = E.db.epa
	settings_coh = E.db.epa.coh
	settings_poh = E.db.epa.poh
	settings_ch  = E.db.epa.ch
	settings_pwr  = E.db.epa.pwr
	settings_wg   = E.db.epa.wg
	settings_debug = E.db.epa.debug
	
	EPA.icons = {}
	EPA.EmphasizeGlowFrameBuffer = {}
	self:CreateIcons()
	self:UpdateRoster()
	self:CreateEmphasizeFrames()
	self:UpdateTalents()
	
	EPA:RegisterEvent("PLAYER_LOGOUT", function() settings_debug.testmode = false end)
end

function EPA:ToggleTestMode(enable)
	local playerID
	if IsInRaid() then
		playerID = "raid1"
	else 
		playerID = "player"
	end
	if enable then
		if EPA.MyClass == "PRIEST" then
			self:SendStatusGained(playerID,'poh', settings_poh.numtargets, 100)
			self:SendStatusGained(playerID,'coh', coh_targets, 100)
			self:SendStatusGained(playerID,'pwr', settings_pwr.numtargets, 100)
		elseif EPA.MyClass == "SHAMAN" then
			self:SendStatusGained(playerID,'ch', 4, 100)
		elseif EPA.MyClass == "DRUID" then
			self:SendStatusGained(playerID,'wg', wg_targets, 100)
		end
	else
		self:SendStatusLost(playerID,'poh')
		self:SendStatusLost(nil,'coh')
		self:SendStatusLost(nil,'ch')
		self:SendStatusLost(nil,'pwr')
		self:SendStatusLost(nil,'wg')
	end
end

function EPA:OnStatusDisable(status)
	if num_enabled > 0 then
		if status == "coh" then
			EPA:SendStatusLost(nil, 'coh')
			--if Emphasize then Emphasize:DeemphasizeAllUnits("priestaoe_coh") end
			num_enabled = num_enabled - 1
		elseif status == "poh" then
			EPA:ClearPoHStatus()
			--if Emphasize then Emphasize:DeemphasizeAllUnits("priestaoe_poh") end
			num_enabled = num_enabled - 1
		elseif status == "ch" then
			EPA:SendStatusLost(nil, 'ch')
			num_enabled = num_enabled - 1
		elseif status == "pwr" then
			EPA:SendStatusLost(nil, 'pwr')
			num_enabled = num_enabled - 1
		elseif status == "wg" then
			EPA:SendStatusLost(nil, 'wg')
			num_enabled = num_enabled - 1
		end

		if num_enabled == 0 then
			EPA.frame:SetScript("OnUpdate", nil)
			EPA:UnregisterEvent("PLAYER_TALENT_UPDATE")
			EPA:UnregisterEvent("PLAYER_EQUIPMENT_CHANGED")
			EPA:UnregisterEvent("GROUP_ROSTER_UPDATE")
		end
	end
end

function UF:Construct_EmphasizeGlow(frame)
	frame:CreateShadow('Default')
	local x = frame.shadow
	frame.shadow = nil
	x:Hide()
	
	return x
end

function EPA:CreateIcons()
	local names = {'poh', 'coh', 'ch', 'pwr', 'wg'}
	for _, icon in pairs(names) do
		local size = E.db.unitframe.units['raid'.. curRaidGroup].priestaoe[icon].size
		local color = E.db.epa[icon].color

		local button = CreateFrame("Button", "EPA_"..icon, EPA.frame)
		button:SetFrameStrata("MEDIUM")
		button:SetBackdropBorderColor(color.r,color.g,color.b)
		button:EnableMouse(false)
		button:SetSize(size,size);
		button:SetTemplate();
		button.texture = button:CreateTexture(nil, "ARTWORK")
		if E.db.epa[icon].style == 'coloredIcon' then
			button.texture:SetTexture(E["media"].blankTex);
			button.texture:SetInside()
			button.texture:SetVertexColor(color.r, color.g, color.b);
			button:SetAlpha(color.a)
		elseif E.db.epa[icon].style == 'texturedIcon' then
			button.texture:SetTexCoord(.05, .95, .05, .95)
			button.texture:SetVertexColor(1, 1, 1)
			button.texture:SetTexture(ICONTEXTURES[icon])
			button.texture:SetInside()
			button:SetAlpha(color.a)
		end
		local text = button:CreateFontString("OVERLAY")
		text:FontTemplate(nil,(size-5),"OUTLINE")
		text:SetPoint('CENTER', 1, 1)
		text:SetJustifyH("CENTER")
		button.text = text
		
		button.unit = nil
		button.show = false
		EPA.icons[icon] = button
	end
end

function EPA:CreateEmphasizeFrames()
	for i = 1, UF[frameHeader]:GetNumChildren() do
		local child = select(i, UF[frameHeader]:GetChildren())
		
		local maxChildren
		if not UF.db.units[frameHeader].raidWideSorting then
			maxChildren = MAX_PLAYERS_PER_GROUP
		else
			maxChildren = child:GetNumChildren()
		end

		for j = 1, maxChildren do
			local frame = child[j]
			if frame then
				frame.EmphasizeGlow = UF:Construct_EmphasizeGlow(child)
				frame.EmphasizeGlow:SetBackdropBorderColor(255, 255, 255)
			end
		end
	end
end


function EPA:RetextureIcons(icon)
	button = EPA.icons[icon]
	local color = E.db.epa[icon].color
	if E.db.epa[icon].style == 'coloredIcon' then
		button.texture:SetTexture(E["media"].blankTex);
		button.texture:SetInside()
		button.texture:SetVertexColor(color.r, color.g, color.b);
		button:SetAlpha(color.a)
	elseif E.db.epa[icon].style == 'texturedIcon' then
		button.texture:SetTexCoord(.05, .95, .05, .95)
		button.texture:SetVertexColor(1, 1, 1)
		button.texture:SetTexture(ICONTEXTURES[icon])
		button.texture:SetInside()
		button:SetAlpha(color.a)
	end
end

function EPA:ApplyIconOptions()
	local names = {'poh', 'coh', 'ch', 'pwr', 'wg'}
	for _, icon in pairs(names) do
		local anchor = E.db.unitframe.units['raid'.. curRaidGroup].priestaoe[icon].attachTo
		local offsetx, offsety = E.db.unitframe.units['raid'.. curRaidGroup].priestaoe[icon].xOffset, E.db.unitframe.units['raid'.. curRaidGroup].priestaoe[icon].yOffset
		local size = E.db.unitframe.units['raid'.. curRaidGroup].priestaoe[icon].size
		local color = E.db.epa[icon].color
		local button = EPA.icons[icon]
		local parent = button:GetParent()
		button:SetAlpha(color.a)	
		button.text:FontTemplate(nil,(size-5),"OUTLINE")
		button:SetSize(size,size);
		button:Point("CENTER", parent, anchor, offsetx, offsety)
		if numtargets ~= nil then button.text:SetText(numtargets) end
	end
end

local roster = {}
function EPA:UpdateRoster()
	self:UpdateNumGroups()
	twipe(roster)
	twipe(unitIDToFrame)
	twipe(player_data)
	roster = { [1] = {}, [2] = {}, [3] = {}, [4] = {}, [5] = {}, [6] = {}, [7] = {}, [8] = {} }

	local grouptype = (IsInRaid() and "raid") or (IsInGroup() and "party")
	if grouptype then
		for i = 1, GetNumGroupMembers() do
			local name, _, group = GetRaidRosterInfo(i)
			if grouptype == "party" then i = i - 1 end
			local unitid = grouptype .. i
			if i == 0 then unitid = "player" end
			if name and UnitExists(unitid) then
				tinsert(roster[group], unitid)
				--[[if UnitIsUnit("player", unitid) then  --holy nova stuff
					player_group = group
				end]]
				player_data[unitid] = {
					guid = UnitGUID(unitid),
					deficit = 0,
					percent = 1,
					incoming = 0,
					healmod = 1,
					--inrange = {}, -- list CH can jump to
					positionx = nil,
					positiony = nil,
				}
			end
		end
	end

	for i = 1, UF[frameHeader]:GetNumChildren() do
		local child = select(i, UF[frameHeader]:GetChildren())
		
		local maxChildren
		if not UF.db.units[frameHeader].raidWideSorting then
			maxChildren = 5
		else
			maxChildren = child:GetNumChildren()
		end

		for j = 1, maxChildren do
			local frame = child[j]
			if frame and frame:IsVisible() and UnitExists(frame.unit) then
				unitIDToFrame[frame.unit] = {i,j,frame}
			end
		end
	end
	--print("roster updated:", #roster[1], #roster[2], #roster[3], #roster[4], #roster[5], #roster[6], #roster[7], #roster[8])
end

function EPA:UpdateTalents()
	currentSpecializationInteger = GetSpecialization();
	if (EPA.MyClass == "PRIEST") then
		if (currentSpecializationInteger == TALENTTREE_PRIEST_HOLY) then
			if (select(4,GetTalentInfo(7,3,1))) then -- row, column, specGroupIndex (always 1 for active spec)
				coh_targets = 5
			else
				coh_targets = nil
			end
		elseif (currentSpecializationInteger == TALENTTREE_PRIEST_DISCIPLINE) then
			if (select(4, GetTalentInfo(7,3,1))) then
				pwr_targets = 5
			else
				pwr_targets = 3
			end
		end
	end
	

	-- lost coh? clear status
	if settings_coh.enable and not coh_targets then
		self:ClearCoHStatus()
	end

	-- update ranges
	if (EPA.MyClass == "SHAMAN") then
		ch_range = 30
	end
	
	if (EPA.MyClass == "DRUID") and (currentSpecializationInteger == TALENTTREE_DRUID_RESTORATION) then
		-- check if player has coh glyph
		wg_targets = 6
	else
		wg_targets = nil
	end
	
	if settings_wg.enable and not wg_targets then
		self:ClearWGStatus()
	end
	
	-- update spell coefs
	self:UpdateCoefs()
end

function EPA:UpdateNumGroups()
	if ElvUF_Raid:IsShown() then
		frameHeader = "raid"
	elseif ElvUF_Raid40:IsShown() then
		frameHeader = "raid40"
	else
		frameHeader = "raid"
	end

	raidvisibility = E.db.unitframe.units.raid.enable and SecureCmdOptionParse(E.db.unitframe.units.raid.visibility)
	raid40visibility = E.db.unitframe.units.raid40.enable and SecureCmdOptionParse(E.db.unitframe.units.raid40.visibility)
	raidgroups = E.db.unitframe.units.raid.numGroups
	raid40groups = E.db.unitframe.units.raid40.numGroups
	if raidvisibility=="show" then
		curRaidGroup = ""
	elseif raid40visibility == "show" then
		curRaidGroup = "40"
	end

	self:ClearCoHStatus()
	self:ClearPoHStatus()
	self:ClearCHStatus()
	self:ClearPWRStatus()
	self:ClearWGStatus()
	if settings.first_groups_only then
		if raidvisibility == "show" then
			num_groups = raidgroups
		elseif raid40visibility == "show" then
			num_groups = raid40groups
		end
	else
		num_groups = 8
	end
end

function EPA:ComputeDistance(x1, y1, x2, y2)
	local dist
	if x1 and y1 and x2 and y2 then
		local xDelta = x1 - x2
		local yDelta = y1 - y2
		dist = sqrt(xDelta*xDelta + yDelta*yDelta)
	end
	return dist
end

function EPA:ClearCoHStatus()
	if coh_prev_best.guid then
		--if Emphasize then Emphasize:DeemphasizeUnit(coh_prev_best.guid, "priestaoe_coh") end
		coh_prev_best.guid = nil
		coh_prev_best.uid = nil
		coh_prev_best.amount = -1
	end
	EPA:SendStatusLost(nil, 'coh')
end

function EPA:ClearPoHStatus()
	EPA:SendStatusLost(nil, 'poh')
end

function EPA:ClearCHStatus()
	self:SendStatusLost(nil, 'ch')
end

function EPA:ClearPWRStatus()
	self:SendStatusLost(nil, 'pwr')
end

function EPA:ClearWGStatus()
	if wg_prev_best.guid then
		--if Emphasize then Emphasize:DeemphasizeUnit(coh_prev_best.guid, "priestaoe_coh") end
		wg_prev_best.guid = nil
		wg_prev_best.uid = nil
		wg_prev_best.amount = -1
	end
	self:SendStatusLost(nil, 'wg')
end

function EPA:PrintRoster()
	self:print_r(roster)
end

-- debug
local updateDisplayStartTime = nil
local CPUTimeElapsed = nil
local debugStartTime = 0
local debug_frame = nil
local debug_fs = nil
local debugprofilestop = debugprofilestop

local function start_timing()
	if not debug_frame then
		debug_frame = CreateFrame("Frame", "gridstatuspriestaoe_performance_monitor", UIParent)
		debug_fs = debug_frame:CreateFontString(nil, "OVERLAY")
		debug_fs:SetFont(STANDARD_TEXT_FONT, 18,"THICKOUTLINE")
		debug_fs:SetPoint("LEFT", UIParent, "LEFT")
		debug_fs:SetText("GridStatusPriestAoe performance monitor")
	end
	-- holding variable to assign both debugStartTime and DisplayUpdateTime
	local currentTime = debugprofilestop()
	debugStartTime = currentTime
	if updateDisplayStartTime == nil then
		updateDisplayStartTime = currentTime
		CPUTimeElapsed = 0
	end
end

local function end_timing()
	local currentTime = debugprofilestop()
	CPUTimeElapsed = CPUTimeElapsed + (currentTime - debugStartTime)

	local timeElapsedSinceDisplayUpdate = currentTime - updateDisplayStartTime
	-- Update the frame every 1000 milliseconds
	if timeElapsedSinceDisplayUpdate >= 1000 then
		debug_fs:SetText(string.format("%0.8fms %d", CPUTimeElapsed/timeElapsedSinceDisplayUpdate, timeElapsedSinceDisplayUpdate))

		CPUTimeElapsed = 0
		updateDisplayStartTime = nil
	end
end
-- debug end

function EPA:OnUpdate(elapsed)
	update_timer = update_timer + elapsed

	-- check for coh cooldown here to update faster, but not too fast
	if update_timer >= 0.05 then
		if coh_prev_best.guid and settings_coh.enable and settings_coh.hidecd and coh_targets and not self:IsSpellReady(SPELLID_COH) then
			self:ClearCoHStatus()
		end

		if wg_prev_best.guid and settings_wg.enable and settings_wg.hidecd and wg_targets and not self:IsSpellReady(SPELLID_WG) then
			self:ClearWGStatus()
		end
	end
	--[===[@alpha@
	start_timing();
	--@end-alpha@]===]
	if update_timer >= E.private.epa.cycle_time then
		update_timer = 0
		EPA:RefreshAll()

		if settings_debug.testmode then return end
		
		if (EPA.MyClass == "PRIEST" and currentSpecializationInteger == TALENTTREE_PRIEST_HOLY) and settings_coh.enable and
			(not settings_coh.hidecd or self:IsSpellReady(SPELLID_COH)) and
			coh_targets then
			self:RefreshCoH()
		end
		
		if (EPA.MyClass == "PRIEST" and currentSpecializationInteger == TALENTTREE_PRIEST_HOLY) and settings_poh.enable then
			self:RefreshPoH()
		end

		if (EPA.MyClass == "PRIEST" and currentSpecializationInteger == TALENTTREE_PRIEST_DISCIPLINE) and settings_pwr.enable then
			self:RefreshPWR()
		end
		
		if EPA.MyClass == "SHAMAN" and settings_ch.enable then
			self:RefreshCH()
		end

		if (EPA.MyClass == "DRUID" and currentSpecializationInteger == 4) and settings_wg.enable and
			(not settings_coh.hidecd or self:IsSpellReady(SPELLID_WG)) and
			wg_targets then
			self:RefreshWG()
		end
	end

	--[===[@alpha@
	end_timing()
	--@end-alpha@]===]
end

local function DistanceSq(x1, y1, x2, y2)
	local xx = x2 - x1
	local yy = y2 - y1

	return xx*xx + yy*yy
end

function EPA:IsValidTarget(unitid)
	return not UnitIsDeadOrGhost(unitid) and
				UnitIsConnected(unitid) and
				UnitIsVisible(unitid) and
				not (UnitIsCharmed(unitid) and UnitIsEnemy("player", unitid))
end

local function IsUnitInRange(unitid)
	if UnitIsUnit(unitid, "player") then
		return true
	else
		return UnitInRange(unitid)
	end
end

function EPA:RefreshAll()
	if not UnitPosition("player") then
		-- only happens if map is nil
		
		if settings_coh.enable then
			self:ClearCoHStatus()
		end
		
		if settings_poh.enable then
			self:ClearPoHStatus()
		end
		
		if settings_ch.enable then
			self:ClearCHStatus()
		end
		
		if settings_pwr.enable then
			self:ClearCHStatus()
		end
		
		if settings_wg.enable then
			self:ClearCHStatus()
		end
			
		-- if settings_hn.enable then
			-- self:ClearHnStatus()
		-- end
		
		twipe(player_data)
		return
	end
	--local ctime = GetTime()
	--local poh_time = select(7, GetSpellInfo(SPELLID_POH)) / 1000 -- Prayer of Healing cast time, in seconds

	twipe(player_data)

	-- cache player data
	for group = 1, num_groups do
		for _, unitid in pairs(roster[group]) do
			if EPA:IsValidTarget(unitid) then
				local health = UnitHealth(unitid)
				local health_max = UnitHealthMax(unitid)
				local percenth = health / health_max
				local cguid = UnitGUID(unitid)
				local data = player_data[unitid]
				local x, y = UnitPosition(unitid)
				player_data[unitid] = {
						guid = cguid,
						deficit = health_max - health,
						percent = percenth,
						incoming = self:GetIncomingHeals(unitid),
						healmod = 1,
						inrange = {}, -- list CH can jump to
						positionx = x,
						positiony = y,
					}
			end
		end
	end

	-- make list of players in range of everyone
	if EPA.MyClass == "SHAMAN" then
		for unitid, data in pairs(player_data) do
			for tunitid, tdata in pairs(player_data) do
				local dist = EPA:ComputeDistance(data.positionx,data.positiony,tdata.positionx,tdata.positiony) or 100
				if dist < ch_range and tunitid ~= unitid then
					--[[if tdata.inrange[unitid] == nil then -- Don't dupe entries
						tinsert(tdata.inrange, unitid)		--insert target into unit's 'inrange'
					end]]
					if data.inrange[tunitid] == nil then -- Don't dupe entries
						tinsert(data.inrange, tunitid)		--insert target into unit's 'inrange'
					end
				end
			end
		end
	end

end

-- Circle of Healing
local function CohSortTargets(x, y)
	return x.percent < y.percent -- sort Lowest percetange health first
end

-- Things spellInfoTable will need

function EPA:GetBestUnitForHeal(spellInfoTable)
	-- if radial (most healing spells)
	-- if chain (chain heal)
end

local targets = {}
function EPA:RefreshCoH()
	local player_data = player_data

	local coh_avg = self:GetCohAvg()

	local coh_best_uid = nil
	local coh_best_amount = -1
	local coh_best_pdata = nil
	local coh_best_dists = nil
	local coh_best_targets = nil


	for unitid, p1 in pairs(player_data) do
		if IsUnitInRange(unitid) then
			twipe(targets)
			for tunitid, p2 in pairs(player_data) do
				local dist = unitid == tunitid and 0 or EPA:ComputeDistance(p1.positionx,p1.positiony,p2.positionx,p2.positiony) or 100
				if dist <= 30 and p2.deficit > 0 then
					local amount = math_min(p2.deficit, coh_avg * p2.healmod)
					if amount > 0 then
						tinsert(targets, { amount = amount, percent = p2.percent, dist = dist })
					end
				end
			end

			-- order candidate targets, get best
			if #targets > (coh_targets or 5) then
				tsort(targets, CohSortTargets)
			end

			local dists = 0
			local hsum = 0
			for ti = 1, math_min(coh_targets or 5, #targets) do
				hsum = hsum + targets[ti].amount
				dists = math_max(dists, targets[ti].dist)
			end
			-- dists = dists / math_min(coh_targets or 5, #targets)

			-- select best, buy try to keep same target
			if hsum > coh_best_amount or
					(hsum == coh_best_amount and (
						unitid == coh_prev_best.uid or
						(coh_best_uid ~= coh_prev_best.uid and dists < coh_best_dists)
						)) then
				coh_best_uid = unitid
				coh_best_amount = hsum
				coh_best_pdata = p1
				coh_best_dists = dists
				coh_best_targets = #targets
			end
		end
	end

	-- send status to best
	local overheal = (1- coh_best_amount/(coh_avg * coh_targets)) * 100
	if coh_best_uid ~= coh_prev_best.uid or overheal > settings_coh.threshold then
		self:ClearCoHStatus()
	end

	if coh_best_uid and overheal <= settings_coh.threshold then
		if coh_prev_best.uid ~= coh_best_uid or coh_prev_best.guid ~= coh_best_pdata.guid or coh_prev_best.amount ~= coh_best_amount then
			EPA:SendStatusGained(coh_best_uid, 'coh', math_min(coh_best_targets, coh_targets), overheal)
		end
		coh_prev_best.uid = coh_best_uid
		coh_prev_best.guid = coh_best_pdata.guid
		coh_prev_best.amount = coh_best_amount
	end
end

-- Prayer of Healing
function EPA:RefreshPoH()
	local player_data = player_data
	local poh_avg = self:GetPohAvg()
	local poh_best_uid = nil
	local poh_best_amount = -1
	local poh_best_pdata = nil
	local poh_best_dists = nil
	local poh_best_targets = nil

	for unitid, p1 in pairs(player_data) do
		if IsUnitInRange(unitid) then
			twipe(targets)
			for tunitid, p2 in pairs(player_data) do
				local dist = unitid == tunitid and 0 or EPA:ComputeDistance(p1.positionx,p1.positiony,p2.positionx,p2.positiony) or 100
				if dist <= 20 and p2.deficit > 0 then
					local amount = math_min(p2.deficit, poh_avg * p2.healmod)
					if amount > 0 then
						tinsert(targets, { amount = amount, percent = p2.percent, dist = dist })
					end
				end
			end

			-- order candidate targets, get best
			if #targets > 5 then
				tsort(targets, CohSortTargets)
			end

			local dists = 0
			local hsum = 0
			for ti = 1, math_min(5, #targets) do
				hsum = hsum + targets[ti].amount
				dists = math_max(dists, targets[ti].dist)
			end
			-- dists = dists / math_min(poh_targets or 5, #targets)

			-- select best, buy try to keep same target
			if hsum > poh_best_amount or
					(hsum == poh_best_amount and (
						unitid == poh_prev_best.uid or
						(poh_best_uid ~= poh_prev_best.uid and dists < poh_best_dists)
						)) then
				poh_best_uid = unitid
				poh_best_amount = hsum
				poh_best_pdata = p1
				poh_best_dists = dists
				poh_best_targets = #targets
			end
		end
	end

		-- send status to best
	local overheal = (1 - poh_best_amount/(poh_avg * 5)) * 100
	--print('poh uid ', poh_best_uid ~= poh_prev_best.uid)
	if poh_best_uid ~= poh_prev_best.uid or overheal > settings_poh.threshold then
		self:ClearPoHStatus()
	end

	if poh_best_uid and overheal <= settings_poh.threshold then
		if poh_prev_best.uid ~= poh_best_uid or poh_prev_best.guid ~= poh_best_pdata.guid or poh_prev_best.amount ~= poh_best_amount then
			EPA:SendStatusGained(poh_best_uid, 'poh', min(poh_best_targets, 5), overheal)
		end
		poh_prev_best.uid = poh_best_uid
		poh_prev_best.guid = poh_best_pdata.guid
		poh_prev_best.amount = poh_best_amount
	end
	--[[
	if Emphasize and settings_poh.emphasize then
		if best_group_amount and best_group_amount > settings_poh.threshold then
			if poh_prev_best ~= best_group_guid then
				self:ClearPohEmphasizeStatus()
				poh_prev_best = best_group_guid
				Emphasize:EmphasizeUnit(best_group_guid, "priestaoe_poh", settings_poh.emphasize_priority, settings_poh.emphasize_color)
			end
		else
			self:ClearPohEmphasizeStatus()
		end
	end--]]
end

-- Chain Heal
local excludeList = {}
function EPA:RefreshCH()
	local player_data = player_data
	local ch_avg = self:GetChAvg()
	local ch_best_uid = nil
	local ch_best_pdata = nil
	local ch_best_jumps = 0
	local mastery = GetMasteryEffect()/100

	local function depthSearch(inrange, numjumps, averageHeal)
		local totalHealing = 0
		local localHealing = 0
		local hold, data
		if numjumps ~= 0 then
			for _, unitid in pairs(inrange) do
				local exclude = true
				for i, v in pairs(excludeList) do
					if v == unitid then exclude = false end
				end
				if exclude then
					table.insert(excludeList, unitid)
					totalHealing = depthSearch(player_data[unitid].inrange, numjumps - 1, excludeList)
				end
			end
		end
		local ch_actual = averageHeal * .7^(4-numjumps) -- 30% decrease each
		for _, unitid in pairs(inrange) do
			data = player_data[unitid]
			hold = math_min(data.deficit, (ch_actual * (1 + (1 - data.percent)*mastery)))
			if hold > localHealing then
				localHealing = hold
			end
		end
		return totalHealing + localHealing
	end

	local curbest = nil
	local curbest_unitid = nil
	for unitid, p1 in pairs(player_data) do
		if IsUnitInRange(unitid) then
			local curjumps = 1
			twipe(excludeList)
			table.insert(excludeList, unitid)
			local amount = depthSearch(p1.inrange, 3, ch_avg)
			local total = amount + math_min(p1.deficit, ch_avg) 
			--print(total, amount)
			if (not curbest) or (total > curbest.deficit) then
				curbest = p1
				curbest_unitid = unitid
				curbest.deficit = total
			end

			-- Check if we found a better target, based on number of jumps and health deficit
			if curbest and (curjumps >= ch_best_jumps) and ((not ch_best_pdata) or (curbest.deficit > ch_best_pdata.deficit)) then
				ch_best_pdata = curbest
				ch_best_uid = curbest_unitid
				ch_best_jumps = curjumps --+ 1
			end
		end
	end

	self:ClearCHStatus()
	local overheal = 101
	if ch_best_pdata then
		overheal = math_min((1 - ch_best_pdata.deficit/(ch_avg * 4)) * 100, 100)
	end
	if overheal <= settings_ch.threshold then
		--[[self.core:SendStatusGained(	ch_best_pdata.guid, 
						"alert_chainhealtarget",
						settings.priority,
						nil,
						settings.color,
						tostring(ch_best_jumps),
						1, 
						nil,
						ICON_CH)--]]
		self:SendStatusGained(ch_best_uid, 'ch', math_floor(ch_best_pdata.deficit / ch_avg), overheal)
		--[[if settings.showjumps then
			for _, tunitid in pairs(ch_best_pdata.inrange) do
				if tunitid ~= ch_best_uid then
					local p1 = player_data[tunitid]
					self.core:SendStatusGained(	p1.guid, 
									"alert_chainhealtarget",
									settings.priority,
									nil,
									settings.color2,
									tostring(ch_best_jumps),
									1, 
									nil,
									ICON_CH)
				end
			end
		end
	--]]
	end
end

local PWRtargets = {}
function EPA:RefreshPWR()
	local player_data = player_data
	local pwr_avg = self:GetPwrAvg()

	local pwr_best_uid = nil
	local pwr_best_amount = -1
	local pwr_best_pdata = nil
	local pwr_best_dists = nil
	local pwr_best_targets = ""
	for unitid, p1 in pairs(player_data) do
		if IsUnitInRange(unitid) then
			twipe(PWRtargets)
			for tunitid, p2 in pairs(player_data) do
				local dist = unitid == tunitid and 0 or EPA:ComputeDistance(p1.positionx,p1.positiony,p2.positionx,p2.positiony) or 100
				if dist <= 40 and p2.deficit > 0 then
					if p2.deficit > 0 then
						tinsert(PWRtargets, { deficit = p2.deficit, percent = p2.percent, dist = dist })
					end
				end
			end

			-- order candidate PWRtargets, get best
			if #PWRtargets > pwr_targets then
				tsort(PWRtargets, CohSortTargets)
			end

			local dists = 0
			local totalProjectedHealing = math_min(p1.deficit, pwr_avg)
			for i = 1, math_min(pwr_targets, #PWRtargets) do
				totalProjectedHealing = totalProjectedHealing + math_min(PWRtargets[i].amount, pwr_avg)
				dists = dists + math_max(dists, PWRtargets[i].dist)
			end
			dists = dists / math_min(pwr_targets, #PWRtargets)

			-- select best, buy try to keep same target
			if totalProjectedHealing > pwr_best_amount or
				(totalProjectedHealing == pwr_best_amount and 
					(unitid == pwr_prev_best.uid or
					(pwr_best_uid ~= pwr_prev_best.uid and dists < pwr_best_dists))) then
						pwr_best_uid = unitid
						pwr_best_amount = totalProjectedHealing
						pwr_best_pdata = p1
						pwr_best_dists = dists
						pwr_best_targets = #PWRtargets
			end
		end
	end

	-- send status to best
	local overheal = math.min((1 - (pwr_best_amount/(pwr_avg * pwr_targets))) * 100, 100)
	if (pwr_best_uid ~= pwr_prev_best.uid or overheal >= settings_pwr.threshold) then
		self:ClearPWRStatus()
	end
	if pwr_best_uid and overheal <= settings_pwr.threshold then
		EPA:SendStatusGained(pwr_best_uid, 'pwr', pwr_best_targets, overheal)
		
		pwr_prev_best.uid = pwr_best_uid
		pwr_prev_best.amount = pwr_best_amount
	end
end

local targets = {}
function EPA:RefreshWG()
	local player_data = player_data

	local wg_avg = self:GetWGAvg()

	local wg_best_uid = nil
	local wg_best_amount = -1
	local wg_best_pdata = nil
	local wg_best_dists = nil
	local wg_best_targets = nil

	for unitid, p1 in pairs(player_data) do
		if IsUnitInRange(unitid) then
			twipe(targets)
			for tunitid, p2 in pairs(player_data) do
				local dist = unitid == tunitid and 0 or EPA:ComputeDistance(p1.positionx,p1.positiony,p2.positionx,p2.positiony) or 0
				if dist <= 30 and p2.deficit > 0 then
					local amount = math_min(p2.deficit, wg_avg * p2.healmod)
					if amount > 0 then
						tinsert(targets, { amount = amount, percent = p2.percent, dist = dist })
					end
				end
			end

			-- order candidate targets, get best
			if #targets > (wg_targets or 5) then
				tsort(targets, CohSortTargets)
			end

			local dists = 0
			local hsum = 0
			for ti = 1, math_min(wg_targets or 5, #targets) do
				hsum = hsum + targets[ti].amount
				dists = math_max(dists, targets[ti].dist)
			end
			-- dists = dists / math_min(wg_targets or 5, #targets)

			-- select best, buy try to keep same target
			if hsum > wg_best_amount or
					(hsum == wg_best_amount and (
						unitid == wg_prev_best.uid or
						(wg_best_uid ~= wg_prev_best.uid and dists < wg_best_dists)
						)) then
				wg_best_uid = unitid
				wg_best_amount = hsum
				wg_best_pdata = p1
				wg_best_dists = dists
				wg_best_targets = #targets
			end
		end
	end

	-- send status to best
	local overheal = math.min((1 - wg_best_amount/(wg_avg * wg_targets))*100, 100)
	if wg_best_uid ~= wg_prev_best.uid or overheal >= settings_wg.threshold then
		self:ClearWGStatus()
	end

	if wg_best_uid and overheal <= settings_wg.threshold then
		if wg_prev_best.uid ~= wg_best_uid or wg_prev_best.guid ~= wg_best_pdata.guid or wg_prev_best.amount ~= wg_best_amount then
			EPA:SendStatusGained(wg_best_uid, 'wg', wg_best_targets, overheal)
		end
		wg_prev_best.uid = wg_best_uid
		wg_prev_best.guid = wg_best_pdata.guid
		wg_prev_best.amount = wg_best_amount
	end
end

function EPA:SendStatusGained(uid,icon,numtargets,overheal)
	local i,j,parent = unitIDToFrame(uid)
	if parent.unit then
		local button = EPA.icons[icon]
		local anchor = E.db.unitframe.units['raid'.. curRaidGroup].priestaoe[icon].attachTo
		local offsetx, offsety = E.db.unitframe.units['raid'.. curRaidGroup].priestaoe[icon].xOffset, E.db.unitframe.units['raid'.. curRaidGroup].priestaoe[icon].yOffset
		local textset = settings.targets_hit
		local text = (textset=="none" and "") or (textset == "targets" and numtargets) or (textset == "overheal" and floor(overheal))
		button.text:SetText(text)
		button:SetParent(parent)
		button:Point("CENTER", parent, anchor, offsetx, offsety)
		button.unit = uid
		button.show = true
		button:Show()

		if false then -- Emphasize
			parent.EmphasizeGlow:Show()
			EPA.EmphasizeGlowFrameBuffer[icon] = parent;
		end
	end
end

function EPA:SendStatusLost(uid, icon)
	local button = EPA.icons[icon]
	button.unit = nil
	button.show = false
	button:Hide()
	button:ClearAllPoints()
	button:SetParent(nil)

	if false then -- Emphasize
		local frame = EPA.EmphasizeGlowFrameBuffer[icon]
		if frame then
			frame.EmphasizeGlow:Hide()
		end
	end
end

function EPA:HasGlyph(gid)
	for i = 2,6,2 do
		local _, _, _, id = GetGlyphSocketInfo(i)
		if id and gid == id then
			return true
		end
	end
	return false
end

function EPA:IsSpellReady(spellID)
	local start, duration = GetSpellCooldown(spellID)

	-- ignore global cooldown, show if ready or less than 0.5 secs of cooldown remaining
	if start == 0 or duration <= 1.5 or ((duration - (GetTime() - start)) <= 0.5) then
		return true
	end

	return false
end

function EPA:GetIncomingHeals(unitid)
	if settings_poh.enable and settings_poh.incoming_heals then
		return (UnitGetIncomingHeals(unitid) or 0)
	end
	return 0
end

function EPA:UpdateCoefs()
	local archangel = 1 + (((select(15, UnitBuff("player","Archangel")) or 0)/100));
	local tof = (UnitBuff("player","Twist of Fate") and 1.15) or 1 

	-- Prayer of Healing
	poh_coef_m = archangel * tof
	poh_coef_madd = 0

	coh_coef_madd = 0.1
	coh_coef_m = 1


	hn_coef_madd = 0
	hn_coef_m = 1
end

function EPA:GetSpellAvg(spellmod)
	--local spellcrit = GetSpellCritChance(2)
	local SP = GetSpellBonusHealing()
	local Versatility = 1 + (GetCombatRatingBonus(CR_VERSATILITY_DAMAGE_DONE) + GetVersatilityBonus(CR_VERSATILITY_DAMAGE_DONE))/100

	local total = (SP * spellmod * Versatility)
	-- total = total * (1 + spellcrit / 200.0) -- apply crit

	return math_floor(total + 0.5)
end

function EPA:GetCohAvg()
	return self:GetSpellAvg(SPELLMOD_COH * 1.1) -- Some hidden holy buff, 10%
end

function EPA:GetPohAvg()
	return self:GetSpellAvg(SPELLMOD_POH)
end

function EPA:GetHnAvg()
	return self:GetSpellAvg(SPELLMOD_HN)
end

function EPA:GetChAvg()
	local unleash = UnitBuff("player",GetSpellInfo(73685)) and 1.3 or 1
	return self:GetSpellAvg(SPELLMOD_CH * 1.25 * unleash) -- 25% Shaman buff
end

function EPA:GetPwrAvg()
	return self:GetSpellAvg(SPELLMOD_PWR) -- 25% Holy buff
end

function EPA:GetWGAvg()
	local healvalue = self:GetSpellAvg(SPELLMOD_WG*1.1)
	--SoTF
	local sotf = (UnitBuff("player",GetSpellInfo(114108)) and 2) or 1
	local haste = 1 + GetHaste()/100 
	return healvalue*sotf*haste
end

function EPA:print_r ( t )
    local print_r_cache={}
    local function sub_print_r(t,indent)
        if (print_r_cache[tostring(t)]) then
            print(indent.."*"..tostring(t))
        else
            print_r_cache[tostring(t)]=true
            if (type(t)=="table") then
                for pos,val in pairs(t) do
                    if (type(val)=="table") then
                        print(indent.."["..pos.."] => "..tostring(t).." {")
                        sub_print_r(val,indent..string.rep(" ",string.len(pos)+8))
                        print(indent..string.rep(" ",string.len(pos)+6).."}")
                    else
                        print(indent.."["..pos.."] =>* "..tostring(val))
                    end
                end
            else
                print(indent..tostring(t))
            end
        end
    end
    sub_print_r(t," ")
end 

E:RegisterModule(EPA:GetName())