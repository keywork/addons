local ADDON = "Blizzard_TradeSkillUI"
local COOKING_SKILL_ID = 185
local CHEFS_HAT_ITEM_ID = 134020
local CHEFS_HAT_SPELL_ID = 67556
local CHEFS_HAT_SPELL_NAME = GetSpellInfo(CHEFS_HAT_SPELL_ID)

local function CanEquipChefsHat()
	return 
		-- missing the buff
		not UnitBuff("player", CHEFS_HAT_SPELL_NAME) and
		-- not inspecting someone elses trade skill
		not C_TradeSkillUI.IsTradeSkillLinked() and
		not C_TradeSkillUI.IsTradeSkillGuild() and
		-- must be Cooking
		C_TradeSkillUI.GetTradeSkillLine() == COOKING_SKILL_ID
end

local function WrapButton(widget, name)
	local button = CreateFrame("Button", nil, widget, "SecureActionButtonTemplate")
	button:SetAttribute("type", "toy")
	button:SetAttribute("toy", CHEFS_HAT_ITEM_ID)

	-- click logic based on tradeskill and hat status
	button:SetScript("PreClick", function()
		button:SetAttribute("type", CanEquipChefsHat() and widget:IsEnabled() and "toy" or "")
	end)

	button:SetScript("PostClick", function()
		widget:Click()
	end)

	-- placement
	button:SetFrameStrata("HIGH")
	button:SetAllPoints(widget)

	-- widget states passed down to the actual button
	button:SetScript("OnEnter", function(_, ...)
		widget:GetScript("OnEnter")(widget, ...)
		if widget:IsEnabled() then
			widget:SetButtonState("NORMAL")
		end
	end)

	button:SetScript("OnLeave", function(_, ...)
		widget:GetScript("OnLeave")(widget, ...)
		if widget:IsEnabled() then
			widget:UnlockHighlight()
		end
	end)

	button:SetScript("OnMouseDown", function(_, ...)
		widget:GetScript("OnMouseDown")(widget, ...)
		if widget:IsEnabled() then
			widget:SetButtonState("PUSHED")
			widget:LockHighlight()
		end
	end)

	button:SetScript("OnMouseUp", function(_, ...)
		widget:GetScript("OnMouseUp")(widget, ...)
		if widget:IsEnabled() then
			widget:SetButtonState("NORMAL")
		end
	end)
end

local function Init()
	WrapButton(TradeSkillFrame.DetailsFrame.CreateAllButton, "TradeSkillFrame.DetailsFrame.CreateAllButton")
	WrapButton(TradeSkillFrame.DetailsFrame.CreateButton, "TradeSkillFrame.DetailsFrame.CreateButton")
end

local frame = CreateFrame("Frame")

frame:SetScript("OnEvent", function(frame, event, name)
	if name == ADDON then
		frame:UnregisterAllEvents()
		Init()
	end
end)

if IsAddOnLoaded(ADDON) then
	Init()
else
	frame:RegisterEvent("ADDON_LOADED")
end
