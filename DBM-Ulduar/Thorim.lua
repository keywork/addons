local mod	= DBM:NewMod("Thorim", "DBM-Ulduar")
local L		= mod:GetLocalizedStrings()

mod:SetRevision(("$Revision: 209 $"):sub(12, -3))
mod:SetCreatureID(32865)
mod:SetEncounterID(1141)
mod:SetModelID(28977)
mod:SetUsedIcons(7)

mod:RegisterCombat("yell", L.YellPhase1)
mod:RegisterKill("yell", L.YellKill)

mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED",
	"CHAT_MSG_MONSTER_YELL",
	"SPELL_CAST_SUCCESS",
	"SPELL_DAMAGE"
)

local warnPhase2				= mod:NewPhaseAnnounce(2, 1)
local warnStormhammer			= mod:NewTargetAnnounce(62470, 2)
local warnLightningCharge		= mod:NewSpellAnnounce(62466, 2)
local warnUnbalancingStrike		= mod:NewTargetAnnounce(62130, 4)
local warningBomb				= mod:NewTargetAnnounce(62526, 4)

local specWarnOrb				= mod:NewSpecialWarningMove(62017)

mod:AddBoolOption("AnnounceFails", false, "announce")

local enrageTimer				= mod:NewBerserkTimer(369)
local timerStormhammer			= mod:NewCastTimer(16, 62042)--Cast timer? Review if i ever do this boss again.
local timerLightningCharge	 	= mod:NewCDTimer(16, 62466, nil, nil, nil, 2) 
local timerUnbalancingStrike	= mod:NewCDTimer(26, 62130, nil, "Tank", nil, 5)
local timerHardmode				= mod:NewTimer(175, "TimerHardmode", 62042)

mod:AddBoolOption("RangeFrame")
mod:AddSetIconOption("SetIconOnRunic", 62527, false)

local lastcharge				= {}
local phase2 = false

function mod:OnCombatStart(delay)
	enrageTimer:Start()
	timerHardmode:Start()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Show(10)
	end
	table.wipe(lastcharge)
	phase2 = false
end

local sortedFailsC = {}
local function sortFails1C(e1, e2)
	return (lastcharge[e1] or 0) > (lastcharge[e2] or 0)
end

function mod:OnCombatEnd()
	if self.Options.RangeFrame then
		DBM.RangeCheck:Hide()
	end
	if self.Options.AnnounceFails and DBM:GetRaidRank() >= 1 then
		local lcharge = ""
		for k, v in pairs(lastcharge) do
			table.insert(sortedFailsC, k)
		end
		table.sort(sortedFailsC, sortFails1C)
		for i, v in ipairs(sortedFailsC) do
			lcharge = lcharge.." "..v.."("..(lastcharge[v] or "")..")"
		end
		SendChatMessage(L.Charge:format(lcharge), "RAID")
		table.wipe(sortedFailsC)
	end
end


function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 62042 then 					-- Storm Hammer
		warnStormhammer:Show(args.destName)
	elseif args.spellId == 62130 then				-- Unbalancing Strike
		warnUnbalancingStrike:Show(args.destName)
	elseif args:IsSpellID(62526, 62527) then	-- Runic Detonation
		warningBomb:Show(args.destName)
		if self.Options.SetIconOnRunic then
			self:SetIcon(args.destName, 7, 5)
		end
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 62042 then 		-- Storm Hammer
		timerStormhammer:Schedule(2)
	elseif args.spellId == 62466 then   	-- Lightning Charge
		warnLightningCharge:Show()
		timerLightningCharge:Start()	
	elseif args.spellId == 62130 then	-- Unbalancing Strike
		timerUnbalancingStrike:Start()
	end
end


function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.YellPhase2 then		-- Bossfight (tank and spank)
		self:SendSync("Phase2")
	end
end

function mod:SPELL_DAMAGE(_, _, _, _, _, destName, destFlags, _, spellId)
	if spellId == 62017 then -- Lightning Shock
		if bit.band(destFlags, COMBATLOG_OBJECT_AFFILIATION_MINE) ~= 0
		and bit.band(destFlags, COMBATLOG_OBJECT_TYPE_PLAYER) ~= 0
		and self:AntiSpam(5) then
			specWarnOrb:Show()
		end
	elseif self.Options.AnnounceFails and spellId == 62466 and DBM:GetRaidRank() >= 1 and DBM:GetRaidUnitId(destName) ~= "none" and destName then
		lastcharge[destName] = (lastcharge[destName] or 0) + 1
		SendChatMessage(L.ChargeOn:format(destName), "RAID")
	end
end

function mod:OnSync(event, arg)
	if event == "Phase2" and not phase2 then
		phase2 = true
		warnPhase2:Show()
		enrageTimer:Stop()
		timerHardmode:Stop()
		enrageTimer:Start(300)
	end
end