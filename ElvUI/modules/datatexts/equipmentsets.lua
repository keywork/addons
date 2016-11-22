local E, L, DF = unpack(select(2, ...)); --Engine
local DT = E:GetModule('DataTexts')

local displayNoSet = "No Set"
local displayPrefix = "Set: "
local menuTitle = "Equip Set"

local menuFrame = CreateFrame("Frame", "EquipmentSetDatatTextMenu", E.UIParent, "UIDropDownMenuTemplate")
local menuList = {}

local function SelectSet(button, setName)
	UseEquipmentSet(setName)
end

local function UpdateMenu()
	if GetNumEquipmentSets() > 0 then
		menuList = { { text = menuTitle, isTitle = true, notCheckable = true } }
		for index = 1, GetNumEquipmentSets() do
			local name, icon, _, isEquipped = GetEquipmentSetInfo(index)
			menuList[index + 1] = { text = name, icon = icon, checked = isEquipped, func = SelectSet, arg1 = name }
		end
	else
		menuList = { { text = displayNoSet, notCheckable = true } }
	end
end

local function UpdateText(text)
	for index = 1, GetNumEquipmentSets() do
		local name, _, _, isEquipped = GetEquipmentSetInfo(index)
		if isEquipped then
			text:SetText(displayPrefix .. name)
			return
		end
	end
	text:SetText(displayNoSet)
end

local function OnEvent(self, event, ...)
	UpdateText(self.text)
end

local function Click(self, btn)
	if btn == "RightButton" and GetNumEquipmentSets() > 0 then
		GameTooltip:Hide()
		UpdateMenu()
		EasyMenu(menuList, menuFrame, "cursor", 0, 0, "MENU", 2)
	else
		if not PaperDollFrame:IsVisible() then
			ToggleCharacter('PaperDollFrame')
		end
		if not CharacterFrame.Expanded then
			SetCVar('characterFrameCollapsed', '0')
			CharacterFrame_Expand()
		end
		if not _G[PAPERDOLL_SIDEBARS[3].frame]:IsShown() then
			-- TODO: find how to display Equipement Manager tab
		end
	end
end

local function OnEnter(self)
	DT:SetupTooltip(self)

	for index = 1, GetNumEquipmentSets() do
		local name, icon = GetEquipmentSetInfo(index)
		GameTooltip:AddLine(name, 1, 1, 1)
	end

	GameTooltip:Show()
end

--[[
	DT:RegisterDatatext(name, events, eventFunc, updateFunc, clickFunc, onEnterFunc)
	
	name - name of the datatext (required)
	events - must be a table with string values of event names to register 
	eventFunc - function that gets fired when an event gets triggered
	updateFunc - onUpdate script target function
	click - function to fire when clicking the datatext
	onEnterFunc - function to fire OnEnter
]]
DT:RegisterDatatext('Equipment Sets', {'PLAYER_ENTERING_WORLD', 'UNIT_INVENTORY_CHANGED', 'EQUIPMENT_SETS_CHANGED'}, OnEvent, nil, Click, nil)
