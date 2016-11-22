local E, L, V, P, G = unpack(ElvUI);
local AB = E:GetModule('ActionBars')

local function EnablePushToActionBar()
	IconIntroTracker:RegisterEvent("SPELL_PUSHED_TO_ACTIONBAR")
	IconIntroTracker:Show()
	IconIntroTracker:SetParent(UIParent)
end
hooksecurefunc(AB, "DisableBlizzard", EnablePushToActionBar)