local EventFrame = CreateFrame("Frame")
EventFrame:RegisterEvent("PLAYER_LOGIN")

local msg
local tracker
local playerid

local function CreateMsgFrame()
		msg = CreateFrame("MessageFrame", "ncKillingBlowMessageFrame", UIParent)
		msg:SetPoint("LEFT")
		msg:SetPoint("RIGHT")
		msg:SetPoint("CENTER")
		msg:SetHeight(31)
		msg:SetInsertMode("TOP")
		msg:SetFrameStrata("HIGH")
		msg:SetTimeVisible(1)
		msg:SetFadeDuration(1)
		msg:SetFont(STANDARD_TEXT_FONT, 30, "OUTLINE")
end

local function SetUpTracker()
		tracker = CreateFrame("Frame")
		tracker:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
		tracker:SetScript("OnEvent", function(_, _, _, event, _, guid)
				if event == "PARTY_KILL" and guid==playerid then
						msg:AddMessage("KILLING BLOW!", 1, 1, 0)
				end
		end)
end

EventFrame:SetScript("OnEvent", function(self, event, ...)
		if event == "PLAYER_LOGIN" then
				playerid = UnitGUID("player")
				CreateMsgFrame()
				SetUpTracker()
		end
end)