-- -------------------------------------------------------------------------- --
-- HelmNCloak by kunda                                                        --
-- -------------------------------------------------------------------------- --
--                                                                            --
-- Enhances the Equipment Manager to let you control the helm/cloak           --
-- visibility for each set.                                                   --
--                                                                            --
-- Usage:                                                                     --
-- Just click on the icons in the Equipment Manager to change the helm/cloak  --
-- visibility for that set. This helm/cloak setting is used when you equip a  --
-- set (you can double click on the default Buttons to equip a set).          --
--                                                                            --
-- Style matters!                                                             --
-- -------------------------------------------------------------------------- --

-- ---------------------------------------------------------------------------------------------------------------------
HelmNCloak_Data = {}                    -- SavedVariable options table

local HelmNCloak = CreateFrame("Frame") -- container
local GVAR = {}                         -- UI Widgets
local isLayout
-- ---------------------------------------------------------------------------------------------------------------------

-- ---------------------------------------------------------------------------------------------------------------------
local function ChangeSetDisplay(which, setID)
	local setName
	local setTexture
	for i = 1, GetNumEquipmentSets() do
		setName, setTexture = GetEquipmentSetInfo(i)
		if setName and setTexture then
			if i == setID then
				break
			end
		end
	end

	if not isLayout then HelmNCloak:SetupLayout() end

	if which == "helm" then
		if GVAR.MainFrame[setID] then
			if HelmNCloak_Data[setName].helm then
				GVAR.MainFrame[setID].HelmButtonNormalTexture:SetTexCoord(0, 0.5, 0.5, 1) -- (0/64, 32/64, 32/64, 64/64) -- helm hide
			else
				GVAR.MainFrame[setID].HelmButtonNormalTexture:SetTexCoord(0, 0.5, 0, 0.5) -- (0/64, 32/64, 0/64, 32/64) -- helm show
			end
		end
		HelmNCloak_Data[setName].helm = not HelmNCloak_Data[setName].helm
	else
		if GVAR.MainFrame[setID] then
			if HelmNCloak_Data[setName].cloak then
				GVAR.MainFrame[setID].CloakButtonNormalTexture:SetTexCoord(0.5, 1, 0.5, 1) -- (32/64, 64/64, 32/64, 64/64) -- cloak hide
			else
				GVAR.MainFrame[setID].CloakButtonNormalTexture:SetTexCoord(0.5, 1, 0, 0.5) -- (32/64, 64/64, 0/64, 32/64) -- cloak show
			end
		end
		HelmNCloak_Data[setName].cloak = not HelmNCloak_Data[setName].cloak
	end
end
-- ---------------------------------------------------------------------------------------------------------------------

-- ---------------------------------------------------------------------------------------------------------------------
local function UpdateHelmNCloak()
	local numSets = GetNumEquipmentSets()
	local IsHelm  = false
	local IsCloak = false
	if ShowingHelm()  then IsHelm  = true end
	if ShowingCloak() then IsCloak = true end

	if not isLayout then HelmNCloak:SetupLayout() end

	for i = 1, numSets do
		local setName, setTexture = GetEquipmentSetInfo(i)
		if setName and setTexture then

			if not HelmNCloak_Data[setName] then
				HelmNCloak_Data[setName] = {}
				HelmNCloak_Data[setName].helm = IsHelm
				HelmNCloak_Data[setName].cloak = IsCloak
			end

			if GVAR.MainFrame[i] then
				GVAR.MainFrame[i]:Show()
				if HelmNCloak_Data[setName].helm then
					GVAR.MainFrame[i].HelmButtonNormalTexture:SetTexCoord(0, 0.5, 0, 0.5) -- (0/64, 32/64, 0/64, 32/64) -- helm show
				else
					GVAR.MainFrame[i].HelmButtonNormalTexture:SetTexCoord(0, 0.5, 0.5, 1) -- (0/64, 32/64, 32/64, 64/64) -- helm hide
				end
				if HelmNCloak_Data[setName].cloak then
					GVAR.MainFrame[i].CloakButtonNormalTexture:SetTexCoord(0.5, 1, 0, 0.5) -- (32/64, 64/64, 0/64, 32/64) -- cloak show
				else
					GVAR.MainFrame[i].CloakButtonNormalTexture:SetTexCoord(0.5, 1, 0.5, 1) -- (32/64, 64/64, 32/64, 64/64) -- cloak hide
				end
			end

		end
	end

	for i = numSets + 1, MAX_EQUIPMENT_SETS_PER_PLAYER do
		if GVAR.MainFrame[i] then
			GVAR.MainFrame[i]:Hide()
		end
	end
end
-- ---------------------------------------------------------------------------------------------------------------------

-- ---------------------------------------------------------------------------------------------------------------------
function HelmNCloak:SetupLayout()
	if isLayout then return end
	if not GVAR.MainFrame then GVAR.MainFrame = {} end
	for i = 1, MAX_EQUIPMENT_SETS_PER_PLAYER do
		if not GVAR.MainFrame[i] and _G["PaperDollEquipmentManagerPaneButton"..i] then
			GVAR.MainFrame[i] = CreateFrame("Frame", nil, _G["PaperDollEquipmentManagerPaneButton"..i])
			GVAR.MainFrame[i]:ClearAllPoints()
			GVAR.MainFrame[i]:SetPoint("TOPRIGHT", "PaperDollEquipmentManagerPaneButton"..i, "TOPRIGHT", -2, 0)
			GVAR.MainFrame[i]:SetFrameLevel(_G["PaperDollEquipmentManagerPaneButton"..i]:GetFrameLevel()+10)
			GVAR.MainFrame[i]:SetWidth(32)
			GVAR.MainFrame[i]:SetHeight(16)
			GVAR.MainFrame[i]:Hide()

			GVAR.MainFrame[i].CloakButton = CreateFrame("Button", nil, GVAR.MainFrame[i])
			GVAR.MainFrame[i].CloakButton:ClearAllPoints()
			GVAR.MainFrame[i].CloakButton:SetPoint("TOPRIGHT", GVAR.MainFrame[i], "TOPRIGHT", 0, 0)
			GVAR.MainFrame[i].CloakButton:SetWidth(16)
			GVAR.MainFrame[i].CloakButton:SetHeight(16)
			GVAR.MainFrame[i].CloakButton:SetScript("OnClick", function() ChangeSetDisplay("cloak", i) end)
			GVAR.MainFrame[i].CloakButtonNormalTexture = GVAR.MainFrame[i].CloakButton:CreateTexture(nil, "BACKGROUND")
			GVAR.MainFrame[i].CloakButtonNormalTexture:SetAllPoints(GVAR.MainFrame[i].CloakButton)
			GVAR.MainFrame[i].CloakButtonNormalTexture:SetTexture("Interface\\AddOns\\HelmNCloak\\HelmNCloak-texture")
			GVAR.MainFrame[i].CloakButton:SetNormalTexture(GVAR.MainFrame[i].CloakButtonNormalTexture)
			GVAR.MainFrame[i].CloakButtonHighlightTexture = GVAR.MainFrame[i].CloakButton:CreateTexture(nil, "BACKGROUND")
			GVAR.MainFrame[i].CloakButtonHighlightTexture:SetAllPoints(GVAR.MainFrame[i].CloakButton)
			GVAR.MainFrame[i].CloakButtonHighlightTexture:SetTexture("Interface\\Buttons\\UI-Common-MouseHilight")
			GVAR.MainFrame[i].CloakButtonHighlightTexture:SetVertexColor(1.0, 1.0, 1.0, 0.4)
			GVAR.MainFrame[i].CloakButtonHighlightTexture:SetTexCoord(5/32, 27/32, 5/32, 27/32)
			GVAR.MainFrame[i].CloakButton:SetHighlightTexture(GVAR.MainFrame[i].CloakButtonHighlightTexture)
			GVAR.MainFrame[i].CloakButton:SetScript("OnEnter", function()
				GameTooltip:SetOwner(GVAR.MainFrame[i].CloakButton, "ANCHOR_RIGHT", 0, 0)
				GameTooltip:AddLine(SHOW_CLOAK)
				GameTooltip:Show()
			end)
			GVAR.MainFrame[i].CloakButton:SetScript("OnLeave", function()
				GameTooltip:Hide()
			end)

			GVAR.MainFrame[i].HelmButton = CreateFrame("Button", nil, GVAR.MainFrame[i])
			GVAR.MainFrame[i].HelmButton:ClearAllPoints()
			GVAR.MainFrame[i].HelmButton:SetPoint("RIGHT", GVAR.MainFrame[i].CloakButton, "LEFT", 0, 0)
			GVAR.MainFrame[i].HelmButton:SetWidth(16)
			GVAR.MainFrame[i].HelmButton:SetHeight(16)
			GVAR.MainFrame[i].HelmButton:SetScript("OnClick", function() ChangeSetDisplay("helm", i) end)
			GVAR.MainFrame[i].HelmButtonNormalTexture = GVAR.MainFrame[i].HelmButton:CreateTexture(nil, "BACKGROUND")
			GVAR.MainFrame[i].HelmButtonNormalTexture:SetAllPoints(GVAR.MainFrame[i].HelmButton)
			GVAR.MainFrame[i].HelmButtonNormalTexture:SetTexture("Interface\\AddOns\\HelmNCloak\\HelmNCloak-texture")
			GVAR.MainFrame[i].HelmButton:SetNormalTexture(GVAR.MainFrame[i].HelmButtonNormalTexture)
			GVAR.MainFrame[i].HelmButtonHighlightTexture = GVAR.MainFrame[i].HelmButton:CreateTexture(nil, "BACKGROUND")
			GVAR.MainFrame[i].HelmButtonHighlightTexture:SetAllPoints(GVAR.MainFrame[i].HelmButton)
			GVAR.MainFrame[i].HelmButtonHighlightTexture:SetTexture("Interface\\Buttons\\UI-Common-MouseHilight")
			GVAR.MainFrame[i].HelmButtonHighlightTexture:SetVertexColor(1.0, 1.0, 1.0, 0.4)
			GVAR.MainFrame[i].HelmButtonHighlightTexture:SetTexCoord(5/32, 27/32, 5/32, 27/32)
			GVAR.MainFrame[i].HelmButton:SetHighlightTexture(GVAR.MainFrame[i].HelmButtonHighlightTexture)
			GVAR.MainFrame[i].HelmButton:SetScript("OnEnter", function()
				GameTooltip:SetOwner(GVAR.MainFrame[i].HelmButton, "ANCHOR_RIGHT", 0, 0)
				GameTooltip:AddLine(SHOW_HELM)
				GameTooltip:Show()
			end)
			GVAR.MainFrame[i].HelmButton:SetScript("OnLeave", function()
				GameTooltip:Hide()
			end)
			if i == MAX_EQUIPMENT_SETS_PER_PLAYER then
				isLayout = true
			end
		end
	end
	if isLayout then
		UpdateHelmNCloak()
	end
end
-- ---------------------------------------------------------------------------------------------------------------------

-- ---------------------------------------------------------------------------------------------------------------------
local function LayoutRepos()
	if not isLayout then HelmNCloak:SetupLayout() end

	-- this function looks a little bit messy but it works
	local scrollOffset = HybridScrollFrame_GetOffset(PaperDollEquipmentManagerPane)

	if scrollOffset == 0 then
		for i = 1, MAX_EQUIPMENT_SETS_PER_PLAYER do
			if GVAR.MainFrame[i] then
				local button = "PaperDollEquipmentManagerPaneButton"..i
					if _G[button] then
					GVAR.MainFrame[i]:SetParent(button)
					GVAR.MainFrame[i]:SetPoint("TOPRIGHT", button, "TOPRIGHT", -2, 0)
					GVAR.MainFrame[i]:SetFrameLevel(_G[button]:GetFrameLevel()+10)
					GVAR.MainFrame[i]:Show()
				end
			end
		end
	elseif scrollOffset > 0 then
		local x = 1
		for i = 1+scrollOffset, MAX_EQUIPMENT_SETS_PER_PLAYER do
			if GVAR.MainFrame[i] then
				local button = "PaperDollEquipmentManagerPaneButton"..x
				if _G[button] then
					GVAR.MainFrame[i]:SetParent(button)
					GVAR.MainFrame[i]:SetPoint("TOPRIGHT", button, "TOPRIGHT", -2, 0)
					GVAR.MainFrame[i]:SetFrameLevel(_G[button]:GetFrameLevel()+10)
					GVAR.MainFrame[i]:Show()
				end
			end
			x = x + 1
		end
		if GVAR.MainFrame[scrollOffset] then
			GVAR.MainFrame[scrollOffset]:Hide()
		end
	end

	-- hide last button if "Add New Set" button is shown
	local numSets = GetNumEquipmentSets();
	local numRows = numSets;
	if (numSets < MAX_EQUIPMENT_SETS_PER_PLAYER) then
		numRows = numRows + 1;  -- "Add New Set" button
	end
	if numRows > numSets then
		if GVAR.MainFrame[numRows] then
			GVAR.MainFrame[numRows]:Hide()
		end
	end
end
-- ---------------------------------------------------------------------------------------------------------------------

-- ---------------------------------------------------------------------------------------------------------------------
local function DeleteSet(setName)
	HelmNCloak_Data[setName] = nil
	UpdateHelmNCloak()
end
-- ---------------------------------------------------------------------------------------------------------------------

-- ---------------------------------------------------------------------------------------------------------------------
local function SaveSet()
	UpdateHelmNCloak()
end
-- ---------------------------------------------------------------------------------------------------------------------

-- ---------------------------------------------------------------------------------------------------------------------
local function SwitchSet(setName)
	if not setName then return end
	if not HelmNCloak_Data[setName] then return end

	if EquipmentSetContainsLockedItems(setName) or UnitCastingInfo("player") then
		return
	end	
	
	local IsHelm  = false
	local IsCloak = false
	if ShowingHelm()  then IsHelm  = true end
	if ShowingCloak() then IsCloak = true end
	if HelmNCloak_Data[setName].helm  ~= IsHelm  then ShowHelm(HelmNCloak_Data[setName].helm)   end
	if HelmNCloak_Data[setName].cloak ~= IsCloak then ShowCloak(HelmNCloak_Data[setName].cloak) end
end
-- ---------------------------------------------------------------------------------------------------------------------

-- ---------------------------------------------------------------------------------------------------------------------
local function OnEvent(self, event)
	if event == "PLAYER_ENTERING_WORLD" then
		PaperDollEquipmentManagerPane:HookScript("OnShow", function() HelmNCloak:SetupLayout() end)
		PaperDollEquipmentManagerPaneScrollBar:HookScript("OnValueChanged", LayoutRepos)
		hooksecurefunc("DeleteEquipmentSet", DeleteSet)
		hooksecurefunc("SaveEquipmentSet", SaveSet)
		hooksecurefunc("ModifyEquipmentSet", SaveSet)
		hooksecurefunc("UseEquipmentSet", SwitchSet)
		HelmNCloak:UnregisterEvent("PLAYER_ENTERING_WORLD")
	end
end
-- ---------------------------------------------------------------------------------------------------------------------

HelmNCloak:RegisterEvent("PLAYER_ENTERING_WORLD")
HelmNCloak:SetScript("OnEvent", OnEvent)