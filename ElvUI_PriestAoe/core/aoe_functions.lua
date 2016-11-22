local VUHDO_getCustomDestCluster;
local VUHDO_RAID;
function VUHDO_aoeAdvisorInitLocalOverrides()
	VUHDO_getCustomDestCluster = _G["VUHDO_getCustomDestCluster"];
	sIsIncoming = VUHDO_CONFIG["AOE_ADVISOR"]["subInc"];
	sIsCooldown = VUHDO_CONFIG["AOE_ADVISOR"]["isCooldown"];
	sIsIncCastTimeOnly = VUHDO_CONFIG["AOE_ADVISOR"]["subIncOnlyCastTime"];
	sIsPerGroup = VUHDO_CONFIG["AOE_ADVISOR"]["isGroupWise"];

	VUHDO_RAID = _G["VUHDO_RAID"];
end



local VUHDO_SPELL_ID_COH = 34861;
local VUHDO_SPELL_ID_POH = 596;
local VUHDO_SPELL_ID_CH = 1064;
local VUHDO_SPELL_ID_WG = 48438;
local VUHDO_SPELL_ID_TQ = 740;
local VUHDO_SPELL_ID_LOD = 85222;
local VUHDO_SPELL_ID_HR = 82327;
local VUHDO_SPELL_ID_CB = 123986;

VUHDO_AOE_SPELLS = {

	-- Circle of Healing
	["coh"] = {
		--["present"] = false,
		["id"] = VUHDO_SPELL_ID_COH,
		["base"] = (4599 + 5082) * 0.5, -- MOPok
		["divisor"] = 10365,
		["icon"] = (GetSpellTexture(VUHDO_SPELL_ID_COH)),
		["name"] = (GetSpellInfo(VUHDO_SPELL_ID_COH)),
		["avg"] = 0,
		["max_targets"] = 5,
		["degress"] = 1,
		["rangePow"] = 30 * 30, -- MOPok
		["isRadial"] = true,
		["areTargetsRandom"] = true,
		--["isSourcePlayer"] = false,
		["isDestRaid"] = true,
		["thresh"] = 15000,
		["cone"] = 360,
		["checkCd"] = true,
		["time"] = select(7, GetSpellInfo(VUHDO_SPELL_ID_COH)) or 0,
	},

	-- Prayer of Healing
	["poh"] = {
		--["present"] = false,
		["id"] = VUHDO_SPELL_ID_POH,
		["base"] = (8450 + 8927) * 0.5, -- MOP
		["divisor"] = 10368,
		["icon"] = (GetSpellTexture(VUHDO_SPELL_ID_POH)),
		["name"] = (GetSpellInfo(VUHDO_SPELL_ID_POH)),
		["avg"] = 0,
		["max_targets"] = 5,
		["degress"] = 1,
		["rangePow"] = 20 * 20,
		["isRadial"] = true,
		["areTargetsRandom"] = true,
		--["isSourcePlayer"] = false,
		["isDestRaid"] = false,
		["thresh"] = 20000,
		["cone"] = 360,
		--["checkCd"] = false,
		["time"] = select(7, GetSpellInfo(VUHDO_SPELL_ID_POH)) or 0,
	},

	-- Chain Heal
	["ch"] = {
		--["present"] = false,
		["id"] = VUHDO_SPELL_ID_CH,
		["base"] = (5135  + 5865) * 0.5, -- MOP
		["divisor"] = 10035,
		["icon"] = (GetSpellTexture(VUHDO_SPELL_ID_CH)),
		["name"] = (GetSpellInfo(VUHDO_SPELL_ID_CH)),
		["avg"] = 0,
		["max_targets"] = 4,
		["degress"] = 0.66,
		["rangePow"] = 40 * 40,
		["jumpRangePow"] = 11 * 11,
		--["isRadial"] = false,
		["areTargetsRandom"] = false,
		--["isSourcePlayer"] = false,
		["isDestRaid"] = true,
		["thresh"] = 15000,
		["cone"] = 360,
		--["checkCd"] = false,
		["time"] = select(7, GetSpellInfo(VUHDO_SPELL_ID_CH)) or 0,
	},

	-- Wild Growth
	["wg"] = {
		--["present"] = false,
		["id"] = VUHDO_SPELL_ID_WG,
		["base"] = 6930,
		["divisor"] = 9345, -- MOP
		["icon"] = (GetSpellTexture(VUHDO_SPELL_ID_WG)),
		["name"] = (GetSpellInfo(VUHDO_SPELL_ID_WG)),
		["avg"] = 0,
		["max_targets"] = 6,
		["degress"] = 1,
		["rangePow"] = 30 * 30,
		["isRadial"] = true,
		["areTargetsRandom"] = true,
		--["isSourcePlayer"] = false,
		["isDestRaid"] = true,
		["thresh"] = 15000,
		["cone"] = 360,
		["checkCd"] = true,
		["time"] = select(7, GetSpellInfo(VUHDO_SPELL_ID_WG)) or 0,
	},

	-- Tranqulity
	["tq"] = {
		--["present"] = false,
		["id"] = VUHDO_SPELL_ID_TQ,
		["base"] = 9037, -- MOP
		["divisor"] = 9345,
		["icon"] = (GetSpellTexture(VUHDO_SPELL_ID_TQ)),
		["name"] = (GetSpellInfo(VUHDO_SPELL_ID_TQ)),
		["avg"] = 0,
		["max_targets"] = 40,
		["degress"] = 1,
		["rangePow"] = 40 * 40,
		["isRadial"] = true,
		["areTargetsRandom"] = false,
		["isSourcePlayer"] = true,
		["isDestRaid"] = true,
		["thresh"] = 15000,
		["cone"] = 360,
		["checkCd"] = true,
		["time"] = select(7, GetSpellInfo(VUHDO_SPELL_ID_TQ)) or 0,
	},

	-- Light of Dawn
	["lod"] = {
		--["present"] = false,
		["id"] = VUHDO_SPELL_ID_LOD,
		["base"] = (2027 + 2257) * 3 * 0.5, -- MOP
		["divisor"] = 4859,
		["icon"] = (GetSpellTexture(VUHDO_SPELL_ID_LOD)),
		["name"] = (GetSpellInfo(VUHDO_SPELL_ID_LOD)),
		["avg"] = 0,
		["max_targets"] = 5,
		["degress"] = 1,
		["rangePow"] = 30 * 30,
		["isRadial"] = true,
		["areTargetsRandom"] = true,
		["isSourcePlayer"] = true,
		["isDestRaid"] = true,
		["thresh"] = 8000,
		["cone"] = 180,
		--["checkCd"] = false,
		["time"] = select(7, GetSpellInfo(VUHDO_SPELL_ID_LOD)) or 0,
	},

	-- Chi Burst
	["cb"] = {
		--["present"] = false,
		["id"] = VUHDO_SPELL_ID_CB,
		["base"] = (325 + 972) * 0.5,
		["divisor"] = 1.267, -- 1/78,9% Atk
		["icon"] = (GetSpellTexture(VUHDO_SPELL_ID_CB)),
		["name"] = (GetSpellInfo(VUHDO_SPELL_ID_CB)),
		["avg"] = 0,
		["max_targets"] = 6,
		["degress"] = 1,
		["rangePow"] = 4, -- not POW actually
		--["isRadial"] = true,
		["areTargetsRandom"] = false,
		["isLinear"] = true,
		["isSourcePlayer"] = true,
		["isDestRaid"] = true,
		["thresh"] = 10000,
		["isHealsPlayer"] = true,
		--["cone"] = 15,
		["checkCd"] = true,
		["time"] = select(7, GetSpellInfo(VUHDO_SPELL_ID_CB)) or 0,
	},
};
local VUHDO_AOE_SPELLS = VUHDO_AOE_SPELLS;


local function VUHDO_sortClusterComparator(aUnit, anotherUnit)
	return VUHDO_RAID[aUnit]["healthmax"] - VUHDO_RAID[aUnit]["health"]
		> VUHDO_RAID[anotherUnit]["healthmax"] - VUHDO_RAID[anotherUnit]["health"];
end




--
local tWinnerUnit, tInfo, tWinnerMissLife;
local tCurrMissLife;
local function VUHDO_getMostDeficitUnitOutOf(anIncludeList, anExcludeList)
	tWinnerUnit = nil;
	tWinnerMissLife = -1;

	for _, tUnit in pairs(anIncludeList) do
		if not anExcludeList[tUnit] then
			tInfo = VUHDO_RAID[tUnit];
			if tInfo and tInfo["healthmax"] - tInfo["health"] > tWinnerMissLife then
				tWinnerUnit = tUnit;
				tWinnerMissLife = tInfo["healthmax"] - tInfo["health"];
			end
		end
	end
	return tWinnerUnit;
end

local tDistance, tNumber, tInfo;
local tStart, tDuration;
function VUHDO_getUnitsInRadialClusterWith(aUnit, aYardsPow, anArray, aCdSpell)
	twipe(anArray);

	if aCdSpell then
		tStart, tDuration = GetSpellCooldown(aCdSpell);
		tDuration = tDuration or 0;

		if tDuration > 1.5 then -- Don't remove clusters for gcd
			tStart = tStart or 0;
			if tStart + tDuration > GetTime() then
				return anArray;
			end
		end
	end

	tInfo = VUHDO_RAID[aUnit];
	if tInfo and not VUHDO_CLUSTER_BLACKLIST[aUnit] then
		anArray[1] = aUnit;-- Source is always part of the cluster
	end
	if VUHDO_MAP_WIDTH == 0 or not VUHDO_COORD_DELTAS[aUnit] then
		return anArray;
	end

	for tOtherUnit, tDeltas in pairs(VUHDO_COORD_DELTAS[aUnit]) do
		tDistance = (((tDeltas[1] or 0) * VUHDO_MAP_WIDTH) ^ 2)  + (((tDeltas[2] or 0) * VUHDO_MAP_WIDTH / 1.5) ^ 2);
		if tDistance <= aYardsPow and not VUHDO_CLUSTER_BLACKLIST[tOtherUnit] then
			anArray[#anArray + 1] = tOtherUnit;
		end
	end

	tsort(anArray, VUHDO_sortClusterComparator);
	return anArray;
end
local VUHDO_getUnitsInRadialClusterWith = VUHDO_getUnitsInRadialClusterWith;

--
local tNextJumps = { };
local tExcludeList = { };
local tNumJumps = 0;
function VUHDO_getUnitsInChainClusterWith(aUnit, aYardsPow, anArray, aMaxTargets, aCdSpell)
	twipe(anArray);
	twipe(tExcludeList)
	for tCnt = 1, aMaxTargets do
		anArray[tCnt] = aUnit;
		tExcludeList[aUnit] = true;
		VUHDO_getUnitsInRadialClusterWith(aUnit, aYardsPow, tNextJumps, aCdSpell);
		aUnit = VUHDO_getMostDeficitUnitOutOf(tNextJumps, tExcludeList);
		if not aUnit then break; end
	end
	return anArray;
end

local tDestCluster = { };
local tInfo, tSrcInfo, tNumArray;
local tSrcGroup;
function VUHDO_getCustomDestCluster(aUnit, anArray, anIsSourcePlayer, anIsRadial, aRangePow, aNumMaxTargets, aHealthLimit, anIsRaid, aCdSpell, aCone, aJumpRangePow)
	twipe(anArray);
	if anIsSourcePlayer and aUnit ~= "player" then return 0; end

	tSrcInfo = VUHDO_RAID[aUnit];
	if not tSrcInfo or tSrcInfo["isPet"] or "focus" == aUnit or "target" == aUnit then return 0; end

	VUHDO_getUnitsInChainClusterWith(aUnit, aJumpRangePow, tDestCluster, aNumMaxTargets, aCdSpell)

	tSrcGroup = tSrcInfo["group"];
	for _, tUnit in pairs(tDestCluster) do
		tInfo = VUHDO_RAID[tUnit];
		if tInfo and tInfo["healthmax"] > 0 and not tInfo["dead"] and tInfo["health"] / tInfo["healthmax"] <= aHealthLimit then
			if (anIsRaid or tInfo["group"] == tSrcGroup) and VUHDO_isInConeInFrontOf(tUnit, aCone) then -- all raid members or in same group
				anArray[#anArray + 1] = tUnit;
				if #anArray == aNumMaxTargets then break; end
			end
		end
	end

	return #anArray;
end
local VUHDO_getCustomDestCluster = VUHDO_getCustomDestCluster;


local function VUHDO_getBestUnitForAoeGroup(anAoeInfo, aPlayerModi, aGroup)
	tBestUnit = nil;
	tBestTotal = -1;

	for tCnt = 1, #aGroup do
		tInfo = aGroup[tCnt];
		if VUHDO_RAID[tInfo] then	tInfo = VUHDO_RAID[tInfo]; end

		if tInfo["baseRange"] then
			if tIsLinear then
				VUHDO_getUnitsInLinearCluster(tInfo["unit"], tCluster, tRangePow, tMaxTargets, tIsHealsPlayer, tCdSpell);
			else
				VUHDO_getCustomDestCluster(tInfo["unit"], tCluster,
					tIsSourcePlayer, tIsRadial, tRangePow,
					tMaxTargets, 101, tIsDestRaid, -- 101% = no health limit
					tCdSpell,	tCone, tJumpRangePow
				);
			end

			if #tCluster > 1 then
				tCurrTotal = VUHDO_sumClusterHealing(tCluster, tSpellHeal, tDegress, tTime);

				if tCurrTotal > tBestTotal and tCurrTotal >= tThresh then
					tBestTotal = tCurrTotal;
					tBestUnit = tInfo["unit"];
				end
			end

		end
	end

	return tBestUnit, tBestTotal;
end