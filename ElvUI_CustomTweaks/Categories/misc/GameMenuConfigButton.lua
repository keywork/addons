local E, L, V, P, G = unpack(ElvUI)
if not E.private["CustomTweaks"] or not E.private["CustomTweaks"]["GameMenuConfigButton"] then return end;
local S = E:GetModule("Skins")
local CT = E:GetModule("CustomTweaks")

--Cache global variables
local HideUIPanel = HideUIPanel

---
-- GLOBALS: GameMenuFrame, GameMenuButtonUIOptions
---

local ConfigButton = CreateFrame("Button", "ConfigButton", GameMenuFrame, "GameMenuButtonTemplate")
ConfigButton:Size(GameMenuButtonUIOptions:GetWidth(), GameMenuButtonUIOptions:GetHeight())
ConfigButton:Point("TOP", GameMenuButtonUIOptions, "BOTTOM", 0 , -1)
ConfigButton:SetText("|cff1784d1ElvUI Config|r")
local function OpenConfig()
	E:ToggleConfig() HideUIPanel(GameMenuFrame)
end
ConfigButton:SetScript("OnClick", OpenConfig)

if E.private.skins.blizzard.enable == true and E.private.skins.blizzard.misc == true then
	S:HandleButton(ConfigButton)
end

local function ResizeGameMenu()
	GameMenuFrame:Height(GameMenuFrame:GetHeight() + GameMenuButtonUIOptions:GetHeight())
end
GameMenuFrame:HookScript("OnShow", ResizeGameMenu)

GameMenuButtonKeybindings:ClearAllPoints()
GameMenuButtonKeybindings:Point("TOP", ConfigButton, "BOTTOM", 0, -1)