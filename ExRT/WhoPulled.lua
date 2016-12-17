local GlobalAddonName, ExRT = ...

local module = ExRT.mod:New("WhoPulled",ExRT.L.WhoPulled,nil,true)
local ELib,L = ExRT.lib,ExRT.L

local bit_band, UnitAffectingCombat, IsEncounterInProgress = bit.band, UnitAffectingCombat, IsEncounterInProgress

module.db.lastPull = nil
module.db.lastBossName = nil
module.db.whoPulled = nil
module.db.isPet = nil

function module.options:Load()
	self:CreateTilte()
	
	local function UpdatePage()
		local pull = "-"
		if module.db.lastPull then
			pull = date("%d/%m/%Y %H:%M:%S",module.db.lastPull).." "..(module.db.lastBossName or "")
		end
	  	self.lastPull:SetText(L.WhoPulledlastPull..": "..pull)
	  	if module.db.isPet then
	  		self.name:SetText((module.db.whoPulled or "").." ("..PET.." "..module.db.isPet..")")
	  	else
	  		self.name:SetText(module.db.whoPulled or "")
	  	end
	end
	
	self.lastPull = ELib:Text(self,"",12):Point("TOP",0,-50):Top():Color()
	self.name = ELib:Text(self,"",18):Point("TOP",0,-65):Top():Color()
	
	self.OnShow_disableNil = true
	self:SetScript("OnShow",UpdatePage)
	
	UpdatePage()
end


function module.main:ADDON_LOADED()
	module:RegisterEvents('ENCOUNTER_START')
	module:RegisterEvents('ZONE_CHANGED_NEW_AREA')
	module.main:ZONE_CHANGED_NEW_AREA()
end

local bossUnits = {["boss1"]=true,["boss2"]=true,["boss3"]=true,["boss4"]=true,["boss5"]=true,}

local function Unregister()
	module:UnregisterEvents('UNIT_TARGET')
end

local affectedCombat = nil

function module.main:ENCOUNTER_START(encounterID, encounterName, difficultyID, groupSize)
	module.db.whoPulled = nil
	module.db.isPet = nil
	module.db.lastPull = time()
	module.db.lastBossName = encounterName
	if affectedCombat then
		module.db.whoPulled = affectedCombat
	else
		C_Timer.After(1,function()
			if affectedCombat then
				module.db.whoPulled = affectedCombat
			end
		end)
	end
	if true then
		return
	end
	for boss,_ in pairs(bossUnits) do
		local tGUID = UnitGUID(boss.."target")
		if tGUID and ExRT.F.Pets:getOwnerNameByGUID(tGUID) then
			module.db.isPet = UnitName(boss.."target")
			module.db.whoPulled = ExRT.F.Pets:getOwnerNameByGUID(tGUID)
			return
		end
		local tname = UnitName(boss.."target")
		if tname then
			module.db.whoPulled = tname
			return
		end
	end
	module:RegisterEvents('UNIT_TARGET')
	C_Timer.NewTimer(10,Unregister)
end

function module.main:UNIT_TARGET(unit)
	if unit and bossUnits[unit] then
		local tGUID = UnitGUID(unit.."target")
		if tGUID and ExRT.F.Pets:getOwnerNameByGUID(tGUID) then
			module.db.isPet = UnitName(unit.."target")
			module.db.whoPulled = ExRT.F.Pets:getOwnerNameByGUID(tGUID)
			module:UnregisterEvents('UNIT_TARGET')
			return
		end
		local tname = UnitName(unit.."target")
		if tname then
			module.db.whoPulled = tname
			module:UnregisterEvents('UNIT_TARGET')
		end
	end
end

local function ZoneNewFunction()
	local _, zoneType, difficulty, _, _, _, _, mapID = GetInstanceInfo()
	if zoneType == "raid" or zoneType == "party" then
		module:RegisterEvents('UNIT_FLAGS','PLAYER_REGEN_DISABLED','PLAYER_REGEN_ENABLED')
	else
		module:UnregisterEvents('UNIT_FLAGS','PLAYER_REGEN_DISABLED','PLAYER_REGEN_ENABLED')
	end
end

function module.main:ZONE_CHANGED_NEW_AREA()
	ExRT.F.ScheduleTimer(ZoneNewFunction, 2)
end

local function ClearAffectedCombat()
	affectedCombat = nil
end

function module.main:UNIT_FLAGS(unit)
	if not affectedCombat and UnitAffectingCombat(unit) and (unit:find("^raid") or unit:find("^party")) then
		affectedCombat = UnitName(unit)
		--print('Combat',affectedCombat)
		C_Timer.After(2,ClearAffectedCombat)
	end
end

function module.main:PLAYER_REGEN_DISABLED(unit)
	module:UnregisterEvents('UNIT_FLAGS')
end

function module.main:PLAYER_REGEN_ENABLED(unit)
	ZoneNewFunction()
end