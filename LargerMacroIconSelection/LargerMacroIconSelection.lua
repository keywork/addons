--[[
LargerMacroIconSelection
Copyright (C) 2016 Xinhuan, Ketho

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
]]

LargerMacroIconSelection = CreateFrame("Frame")
local f = LargerMacroIconSelection
local LibAIS = LibStub("LibAdvancedIconSelector-1.0-LMIS")

local NAME, S = ...
local L = S.L
local _G = _G
local db

local ICONS_PER_ROW, ICON_ROWS, ICONS_SHOWN
local previousbuttons = 0

local popup_regions, sf_regions = {}, {}
local origSize, origNum = {}, {}
local activeFrame = {}

local searchObject, activeSearch
local searchIcons = {}

local GB_ICON_FILENAMES

-- Put this in global namespace for consistency/simplicity
function GetGuildBankIconInfo(index)
	return GB_ICON_FILENAMES[index]
end

-- Remove custom/duplicate icons from icon packs
-- until Blizzard fixes their non-FileDataID icon support
GetLooseMacroItemIcons = function() end
GetLooseMacroIcons = function() end

local defaults = {
	width = 10,
	height = 10,
}

local LibAIS_options = {
	sectionOrder = {"FileDataIcons"},
}

local frames = {
	MacroPopupScrollFrame = function() return {
			icons_per_row = "NUM_ICONS_PER_ROW", -- 10
			icon_rows = "NUM_ICON_ROWS", -- 9
			icons_shown = "NUM_MACRO_ICONS_SHOWN", -- 90
			icon_row_height = MACRO_ICON_ROW_HEIGHT, -- 36
			geticoninfo = "GetSpellorMacroIconInfo",
			button = "MacroPopupButton",
			template = "MacroPopupButtonTemplate",
			update = "MacroPopupFrame_Update",
			okaybutton = MacroPopupOkayButton,
			editbox = MacroPopupEditBox,
		}
	end,
	GearManagerDialogPopupScrollFrame = function() return {
			icons_per_row = "NUM_GEARSET_ICONS_PER_ROW", -- 10
			icon_rows = "NUM_GEARSET_ICON_ROWS", -- 9
			icons_shown = "NUM_GEARSET_ICONS_SHOWN", -- 90
			icon_row_height = GEARSET_ICON_ROW_HEIGHT, -- 36
			geticoninfo = "GetEquipmentSetIconInfo",
			button = "GearManagerDialogPopupButton",
			template = "GearSetPopupButtonTemplate",
			update = "GearManagerDialogPopup_Update",
			okaybutton = GearManagerDialogPopupOkay,
			editbox = GearManagerDialogPopupEditBox,
		}
	end,
	GuildBankPopupScrollFrame = function() return {
			icons_per_row = "NUM_GUILDBANK_ICONS_PER_ROW", -- 10
			icon_rows = "NUM_GUILDBANK_ICON_ROWS", -- 9
			icons_shown = "NUM_GUILDBANK_ICONS_SHOWN", -- 90
			icon_row_height = GUILDBANK_ICON_ROW_HEIGHT, -- 36
			geticoninfo = "GetGuildBankIconInfo", -- custom
			button = "GuildBankPopupButton",
			template = "GuildBankPopupButtonTemplate",
			update = "GuildBankPopupFrame_Update",
			okaybutton = GuildBankPopupOkayButton,
			editbox = GuildBankPopupEditBox,
		}
	end,
}

-- Save memory by only loading FileData when needed
local function LoadFileData(addon)
	if not S.FileData then
		local loaded, reason = LoadAddOn(addon)
		
		if not loaded then
			if reason == "DISABLED" then
				EnableAddOn(addon, true)
				LoadAddOn(addon)
			else
				error(addon.." is "..reason)
			end
		end
		S.FileData = _G[addon]:GetFileData()
	end
end

local function RefreshMouseFocus()
	local focus = GetMouseFocus()
	if focus and focus:GetObjectType() == "CheckButton" then
		local parent = focus:GetParent()
		if parent and frames[parent.ScrollFrame] then
			focus:GetScript("OnEnter")(focus)
		end
	end
end

local function UpdateSearchPopup(sf)
	sf:GetParent().selectedIcon = nil
	sf:SetVerticalScroll(0)
	
	-- Updating clears the EditBox; remember the macro name
	local text = frames[sf].editbox:GetText()
	_G[frames[sf].update]()
	frames[sf].editbox:SetText(text)
	
	if sf == GearManagerDialogPopupScrollFrame and #searchIcons > 0 then
		f:UpdateButtons(sf, #searchIcons)
	end
	RefreshMouseFocus()
	-- The Blizzard UI remembers the ScrollFrame offset id instead
	-- of the previously selected icon when starting a new search
	if sf == MacroPopupScrollFrame then
		MacroFrameSelectedMacroButtonIcon:SetTexture("Interface\\Icons\\INV_MISC_QUESTIONMARK")
	end
end

local function InitSearch()
	if not searchObject then
		searchObject = LibAIS:CreateSearch(LibAIS_options)
		
		searchObject:SetScript("OnSearchStarted", function(self)
			wipe(searchIcons)
		end)
		
		searchObject:SetScript("OnSearchResultAdded", function(self, texture, _, _, _, FileDataID)
			tinsert(searchIcons, FileDataID)
		end)
		
		searchObject:SetScript("OnSearchComplete", function(self)
			if activeSearch then
				local popup = activeSearch:GetParent()
				if not popup:IsShown() then return end
				
				if #searchIcons == 0 then
					popup.SearchBox:SetTextColor(1, 0, 0)
				else
					popup.SearchBox:SetTextColor(1, 1, 1)
				end
				UpdateSearchPopup(activeSearch)
				activeSearch = nil
			end
		end)
	end
end

local function ClearSearch()
	activeSearch = nil
	wipe(searchIcons)
	searchObject:Stop()
end

function f:OnEvent(event, addon)
	if addon == NAME then
		LargerMacroIconSelectionDB = LargerMacroIconSelectionDB or CopyTable(defaults)
		db = LargerMacroIconSelectionDB
		
		ICONS_PER_ROW = db.width
		ICON_ROWS = db.height
		ICONS_SHOWN = ICONS_PER_ROW * ICON_ROWS
		
		self:Initialize(GearManagerDialogPopupScrollFrame)
		
		-- Someone else made it load before us
		if IsAddOnLoaded("Blizzard_MacroUI") then
			self:Initialize(MacroPopupScrollFrame)
		end
		
	elseif addon == "Blizzard_MacroUI" then
		self:Initialize(MacroPopupScrollFrame)
		
	elseif addon == "Blizzard_GuildBankUI" then
		if IsGuildLeader() then
			self:Initialize(GuildBankPopupScrollFrame)
		end
	end
end

f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", f.OnEvent)

function f:Initialize(sf)
	local popup = sf:GetParent()
	popup.ScrollFrame = sf
	
	-- Only initialize when the popupframe shows
	popup:HookScript("OnShow", function()
		if activeFrame[sf] then return end
		
		LoadFileData("LargerMacroIconSelectionData")
		InitSearch()
		frames[sf] = frames[sf:GetName()]()
		
		-- Group the anonymous textures into a table before adding more regions
		popup_regions[sf] = {popup:GetRegions()}
		sf_regions[sf] = {sf:GetRegions()}
		
		origSize[sf] = {
			width = popup:GetWidth(),
			height = popup:GetHeight(),
			sfwidth = sf:GetWidth(),
			sfheight = sf:GetHeight(),
		}
		
		origNum[sf] = {
			icons_per_row = _G[frames[sf].icons_per_row],
			icon_rows = _G[frames[sf].icon_rows],
			icons_shown =  _G[frames[sf].icons_shown],
		}
		
		-- Movable
		popup:SetMovable(true)
		popup:SetClampedToScreen(true)
		popup:SetFrameStrata("HIGH") -- Up from "Medium", GearManager was hidden behind stuff
		
		popup:EnableMouse(true) -- GearManager not mouse enabled
		popup:RegisterForDrag("LeftButton")
		popup:SetScript("OnDragStart", popup.StartMoving)
		popup:SetScript("OnDragStop", popup.StopMovingOrSizing)
		
		-- Update GameTooltip when scrollling
		sf:HookScript("OnMouseWheel", RefreshMouseFocus)
		
		if popup == GuildBankPopupFrame then
			-- Can not make the Guild Bank support icon search; at least support GameTooltip info
			-- Since the guild bank gets the icon info locally in the update func
			GB_ICON_FILENAMES = {}
			GB_ICON_FILENAMES[1] = "INV_MISC_QUESTIONMARK"
			
			GetMacroItemIcons(GB_ICON_FILENAMES)
			GetMacroIcons(GB_ICON_FILENAMES)
		else
			local eb = CreateFrame("EditBox", "$parentSearchBox", popup, "InputBoxTemplate")
			eb:SetPoint("BOTTOMLEFT", 70, 15)
			eb:SetPoint("RIGHT", frames[sf].okaybutton, "LEFT", 0, 0)
			eb:SetHeight(15)
			eb:SetFrameLevel(70) -- FrameStrata or level changed in 7.1
			popup.SearchBox = eb
			
			-- No idea why fontstrings are drawn below the popup frame in 7.1
			-- Using the OVERLAY layer didnt help; workaround by parenting to editbox instead
			local searchLabel = eb:CreateFontString()
			searchLabel:SetFontObject("GameFontNormal")
			searchLabel:SetPoint("RIGHT", eb, "LEFT", -5, 0)
			searchLabel:SetText(SEARCH..":")
			
			local linkLabel = eb:CreateFontString()
			linkLabel:SetFontObject("GameFontNormal")
			linkLabel:SetPoint("RIGHT", frames[sf].okaybutton, "LEFT", -5, -1)
			linkLabel:SetTextColor(.62, .62, .62)
			
			eb:SetScript("OnTextChanged", function(self, userInput)
				local text = self:GetText()
				
				if strfind(text, "[:=]") then -- Search by spell/item/achievement id
					local link, id = text:lower():match("(%a+)[:=](%d+)")
					local linkSearch
					ClearSearch()
					
					if link == "spell" and id then
						linkSearch = S.FileData[select(3, GetSpellInfo(id))]
					elseif link == "item" and id then
						linkSearch = S.FileData[select(5, GetItemInfoInstant(id))]
					elseif link == "achievement" and id then
						-- Returns the texture path instead of FileDataID
						local path = select(10, GetAchievementInfo(id))
						linkSearch = path and path:lower():match("interface\\icons\\(.+)")
					elseif link == "filedata" and id then
						linkSearch = S.FileData[tonumber(id)]
					end
					
					if linkSearch then
						searchIcons[1] = linkSearch
						eb:SetTextColor(1, 1, 1)
						linkLabel:SetText(linkSearch)
					else
						searchIcons[1] = "INV_MISC_QUESTIONMARK"
						eb:SetTextColor(1, 0, 0)
						linkLabel:SetText()
					end
					UpdateSearchPopup(sf)
				else
					eb:SetTextColor(1, 1, 1)
					linkLabel:SetText()
					
					if #text > 0 then -- Search by texture name
						searchObject:SetSearchParameter(text)
						activeSearch = sf
					else
						ClearSearch()
						UpdateSearchPopup(sf)
					end
				end
			end)
			
			-- Something changed in 7.1; :ClearFocus() on SearchBox does not work anymore(?)
			eb:SetScript("OnEnterPressed", function()
				frames[sf].editbox:SetFocus()
			end)
			
			eb:SetScript("OnEscapePressed", function()
				frames[sf].editbox:SetFocus()
			end)
			
			popup:HookScript("OnHide", function()
				ClearSearch()
				eb:SetText("")
				eb:SetTextColor(1, 1, 1)
				linkLabel:SetText()
			end)
			
			-- Update scrollbar for the filtered icons
			hooksecurefunc(frames[sf].update, function()
				if #searchIcons > 0 then
					FauxScrollFrame_Update(sf, ceil(#searchIcons / ICONS_PER_ROW), ICON_ROWS, frames[sf].icon_row_height)
				end
			end)
			
			local isGearManager = (popup == GearManagerDialogPopup)
			
			-- Prehook GetIconInfo for search functionality 
			local oldGetIconInfo = _G[frames[sf].geticoninfo]
			_G[frames[sf].geticoninfo] = function(index)
				if #searchIcons > 0 then
					-- GearManager does not cope well with nil values
					return searchIcons[index] or isGearManager and "INV_MISC_QUESTIONMARK"
				else
					return oldGetIconInfo(index)
				end
			end
			
			-- Support shift-clicking links to the search box
			-- maybe also hide StackSplitFrame but will have to hook ContainerFrameItemButton_OnModifiedClick
			hooksecurefunc("ChatEdit_InsertLink", function(text)
				if text then
					if eb:IsVisible() then
						eb:SetText(strmatch(text, "H(%l+:%d+)") or "")
					end
				end
			end)
		end
		
		self:UpdateButtons(sf)
		self:UpdateTextures(sf)
		-- Only initialized with OnShow, update again
		_G[frames[sf].update]()
		
		activeFrame[sf] = true
	end)
end

function f:UpdateButtons(sf, amount)
	local popup = sf:GetParent()
	local button = frames[sf].button
	local template = frames[sf].template
	-- The GearManager does not like nil values
	-- so we have to manually hide the buttons for them, at least when we show just a few icons
	local numIcons = amount and min(amount, ICONS_SHOWN) or ICONS_SHOWN
	
	-- Set the frame specific globals to the new values
	_G[frames[sf].icons_per_row] = ICONS_PER_ROW
	_G[frames[sf].icon_rows] = ICON_ROWS
	_G[frames[sf].icons_shown] = ICONS_SHOWN
	
	local isGearManager = (popup == GearManagerDialogPopup)
	
	for i = 1, numIcons do
		local b = _G[button..i]
		
		if not b then -- Create button
			b = CreateFrame("CheckButton", button..i, popup, template)
			b:SetID(i) -- Assign corresponding Id
			
			if isGearManager then
				tinsert(popup.buttons, b)
			end
		end
		
		-- Position buttons
		if i > 1 then
			b:ClearAllPoints()
			if i % ICONS_PER_ROW == 1 then
				b:SetPoint("TOPLEFT", _G[button..(i-ICONS_PER_ROW)], "BOTTOMLEFT", 0, -8)
			else
				b:SetPoint("LEFT", _G[button..i-1], "RIGHT", 10, 0)
			end
		end
		
		-- Show icon information
		b:SetScript("OnEnter", function(self)
			GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT")
			
			local id = FauxScrollFrame_GetOffset(sf)*ICONS_PER_ROW + self:GetID()
			GameTooltip:AddLine(id)
			
			local texture = _G[frames[sf].geticoninfo](id)
			GameTooltip:AddLine(type(texture) == "number" and S.FileData[texture] or texture, 1, 1, 1)
			GameTooltip:Show()
		end)
		
		b:SetScript("OnLeave", function(self)
			GameTooltip:Hide()
		end)
	end
	
	-- Hide any superfluous buttons
	for i = numIcons + 1, (amount and ICONS_SHOWN or previousbuttons) do
		local b = _G[button..i]
		if b then
			b:Hide()
		end
	end
end

-- In 7.1 Blizzard shows 90 icons, with 9th row half visible
-- and an extra empty row as the very last row to make up for it
function f:UpdateTextures(sf)	
	local popup = sf:GetParent()
	local button = frames[sf].button
	
	-- Calculate the extra width and height due to the new size
	local extrawidth = (_G[button.."1"]:GetWidth() + 10) * (ICONS_PER_ROW - origNum[sf].icons_per_row)
	local extraheight = (_G[button.."1"]:GetHeight() + 8) * (ICON_ROWS - origNum[sf].icon_rows) + 30
	
	-- Resize the frames
	local size = origSize[sf]
	popup:SetWidth(size.width + extrawidth)
	popup:SetHeight(size.height + extraheight)
	sf:SetWidth(size.sfwidth + extrawidth)
	sf:SetHeight(size.sfheight + extraheight)
end

for i, v in pairs({"lmis", "largermacro", "largermacroicon", "largermacroiconselection"}) do
	_G["SLASH_LARGERMACROICONSELECTION"..i] = "/"..v
end

SlashCmdList.LARGERMACROICONSELECTION = function(msg)
	local width, height = strmatch(msg, "(%d+)[^%d]+(%d+)")
	width = floor(tonumber(width) or 0)
	height = floor(tonumber(height) or 0)
	
	if width >= 5 and height >= 4 then
		-- Avoid outgrowing the screen (1920x1080, normal UI Scale)
		width = min(width, 40)
		height = min(height, 21)
		print(L.SETTING_VALUES:format(width, height))
		
		db.width = width
		db.height = height
		
		previousbuttons = ICONS_SHOWN or 0
		ICONS_PER_ROW = width
		ICON_ROWS = height
		ICONS_SHOWN = ICONS_PER_ROW * ICON_ROWS
		
		for k, v in pairs(frames) do
			if type(v) == "table" then
				f:UpdateButtons(k)
				f:UpdateTextures(k)
				if k:GetParent():IsShown() then
					_G[frames[k].update]()
				end
			end
		end
	else
		print( format("%s |cffADFF2F%s|r", NAME, GetAddOnMetadata(NAME, "Version")) )
		print(L.USAGE)
		print(L.USAGE_VALUES)
		print(L.CURRENT_VALUES:format(db.width, db.height))
	end
end
