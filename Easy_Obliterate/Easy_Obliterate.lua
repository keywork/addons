--Easy Obliterate by Motig
LoadAddOn("Blizzard_ObliterumUI")

local addonVersion = 19
local currentPage = 1
local selectedButton = nil
local previousSelectedButton = nil
local itemCache = {}
local itemButtons = {}
local eligibleItems = {}
local lastEligibleItemCount = -1
local autoSelect = false
local ashLooted = false
local failedItems = {}
local itemIgnoreList = {}
local ashStats = {}
local showGetItemError = false
local lastItem = {itemID = 0, itemLevel = 0, ashAamount = 0}
local currentItem = {itemID = 0, itemLevel = 0}
local currentLineID = nil
local showAshStats = true

local textColor = {r='0.99999779462814', g='0.12548992037773', b='0.12548992037773', a='0.99999779462814'}
local function dprint(text) if _eadebug then print(text) end end

local tooltipFrame = CreateFrame('GameTooltip', "EasyObliterateTooltipReader", nil, "GameTooltipTemplate")
tooltipFrame:SetOwner(UIParent, "ANCHOR_NONE")

local function getAshForItemID(itemID, itemLevel)
    if ashStats[itemID] and ashStats[itemID][itemLevel] then
        return ashStats[itemID][itemLevel].averageAsh, ashStats[itemID][itemLevel].obliterateCount
    else
        return 0
    end
end

local function getSelectedButton()
    local id = (selectedButton-1)%#itemButtons
    return itemButtons[id+1]
end

local function getSelectedButtonID()
    local id = (selectedButton-1)%#itemButtons
    return id+1
end

local function getPreviousSelectedButton()
    local id = (previousSelectedButton-1)%#itemButtons
    return itemButtons[id+1]
end

local function inIgnoreList(link)
    for k,v in pairs(itemIgnoreList) do if v == link then return k end end return false
end

local function getEligibleAshTotal()
    local totalA = 0
    for i = 1, #eligibleItems do
        if ashStats[eligibleItems[i].itemID] then
            for k,v in pairs(ashStats[eligibleItems[i].itemID]) do
                totalA = totalA + v.averageAsh
            end
        end
    end
    return totalA
end

--This is gross but is done to not have to maintain a list of items that can be obliterated.
local function itemEligible(itemID)
    if itemCache[itemID] ~= nil then
        return itemCache[itemID]
    else     
        tooltipFrame:ClearLines()      
        if GetItemInfo(itemID) then
            tooltipFrame:SetItemByID(itemID)
            for i = tooltipFrame:NumLines(), tooltipFrame:NumLines()-3, -1 do
                if i >= 1 then
                    local text = _G["EasyObliterateTooltipReaderTextLeft"..i]:GetText()                  
                    if text == ITEM_OBLITERATEABLE_NOT then
                        itemCache[itemID] = false
                        return false
                    elseif text == ITEM_OBLITERATEABLE then
                        itemCache[itemID] = true
                        return true
                    end
                end
            end
            return false
        else
            table.insert(failedItems, itemID)
            return false
        end
    end
end

local function getEligibleItems()
   eligibleItems = {}
   failedItems = {}
   C_TradeSkillUI.ClearPendingObliterateItem()
   
   for bag = 0, 4 do
      for i = 1, GetContainerNumSlots(bag) do
         local itemID = GetContainerItemID(bag, i)
         --if itemLink and itemEligible(itemLink, itemID) then
         --if itemID and itemEligible(itemLink, itemID) then
         if itemID and itemEligible(itemID) then
            local texture, itemCount, locked, quality, readable, lootable, itemLink, isFiltered = GetContainerItemInfo(bag, i)
            table.insert(eligibleItems, {bag = bag, index = i, itemLink = itemLink, itemTexture = texture, itemCount = itemCount, itemID = itemID, itemQuality = quality, itemName = string.match(itemLink, "%[(.+)%]")})
         end
      end
   end
   
   local ignoredItems = {}
   local availableItems = {}
   
    for i = 1, #eligibleItems do
        if inIgnoreList(eligibleItems[i].itemLink) then
            table.insert(ignoredItems, eligibleItems[i])
        else
            table.insert(availableItems, eligibleItems[i])
        end
    end
   
    --Sort ignored and unignored items seperately and join.
    table.sort(ignoredItems, function(a, b)
        return a.itemName < b.itemName
    end)
    
    table.sort(availableItems, function(a, b)
        return a.itemName < b.itemName
    end)
    
    eligibleItems = {}
    for i = 1, #ignoredItems do
        eligibleItems[i] = ignoredItems[i]
        eligibleItems[i].ignore = true
    end
    
    for i = 1, #availableItems do
        eligibleItems[#ignoredItems+i] = availableItems[i]
    end

    if #failedItems > 0 and showGetItemError then
        showGetItemError = false
        if _eadebug then for i = 1, #failedItems do print(failedItems[i]) end end
        DEFAULT_CHAT_FRAME:AddMessage('Easy Obliterate: Failed to retrieve item info for some items. Usually this happens if you open the forge too soon after logging in. They will appear as you obliterate items or if you open the forge at a later time if they can be obliterated.')
    end
end

local function updateItemButtons(forceAnim)
    local playAnim = false
    if lastEligibleItemCount ~= #eligibleItems or forceAnim then
        lastEligibleItemCount = #eligibleItems
        playAnim = true
    end
    
    for i = 1, #itemButtons do      
        local id = ((currentPage-1)*#itemButtons)+i
        if eligibleItems[id] then
            SetItemButtonTexture(itemButtons[i], eligibleItems[id].itemTexture)
            SetItemButtonCount(itemButtons[i], eligibleItems[id].itemCount);
            SetItemButtonQuality(itemButtons[i], eligibleItems[id].itemQuality, eligibleItems[id].itemLink)
            SetItemButtonDesaturated(itemButtons[i], false)
            itemButtons[i].itemRef = id
            itemButtons[i].icon:Show()
            itemButtons[i].ignoredTexture:Hide()

            if playAnim then
                itemButtons[i].glowAnimation:Play()
            end

            if eligibleItems[id].ignore then
                itemButtons[i].IconBorder:SetVertexColor(0.5, 0.5, 0.5)
                SetItemButtonDesaturated(itemButtons[i], true)
                itemButtons[i].ignoredTexture:Show()
            end
        else
            SetItemButtonCount(itemButtons[i], 0)
            SetItemButtonQuality(itemButtons[i], 0)
            itemButtons[i].itemRef = nil
            itemButtons[i].icon:Hide()
            itemButtons[i].ignoredTexture:Hide()
        end
    end
   
    if selectedButton then
        if selectedButton > (currentPage-1)*#itemButtons and selectedButton <= ((currentPage-1)*#itemButtons)+#itemButtons then
            SetItemButtonDesaturated(getSelectedButton(), true)
            AnimatedShine_Start(getSelectedButton())
        else
            AnimatedShine_Stop(getSelectedButton())       
        end
    end
end

local function selectNextItem()
    dprint('Attempting to find next item.')
    if #eligibleItems > 0 then
        if previousSelectedButton then
            dprint('Found a previous button')
            if eligibleItems[previousSelectedButton] and not eligibleItems[previousSelectedButton].ignore then
                dprint('previous button turned into a new item so we can click again')
                getPreviousSelectedButton():Click()
            else
                dprint('previous button is now nill or should be ignored so lets find the next button to click')
                local foundButton = false
                for i = #eligibleItems, 1, -1 do
                    if not eligibleItems[i].ignore then
                        previousSelectedButton = i
                        foundButton = true
                        break
                    end
                end
                if foundButton then
                    dprint('Found next button')
                    getPreviousSelectedButton():Click()
                else
                    dprint('We someone ended up with no button to click')
                end
            end
        else
            dprint('Did not find a previous button')
            itemButtons[1]:Click()
        end
    end
end

local mainFrame = CreateFrame('Frame', nil, ObliterumForgeFrame)
mainFrame:SetPoint('TOP', ObliterumForgeFrame, 'BOTTOM', 0, 16)
mainFrame:SetSize(ObliterumForgeFrame:GetWidth()-16, 264) --248
mainFrame:EnableMouse(true)
mainFrame:SetFrameLevel(ObliterumForgeFrame:GetFrameLevel()-1)
mainFrame:SetBackdrop({
      bgFile="Interface\\FrameGeneral\\UI-Background-Marble", 
      edgeFile='Interface/Tooltips/UI-Tooltip-Border', 
      tile = false, tileSize = 16, edgeSize = 16,
      insets = { left = 4, right = 4, top = 4, bottom = 4 }}
)

mainFrame.totalText = mainFrame:CreateFontString()
mainFrame.totalText:SetFontObject("GameFontHighlight")
mainFrame.totalText:SetText("Total: 55")
mainFrame.totalText:SetPoint('BOTTOMLEFT', 16, 12)

mainFrame.buttons = {}
for i = 1, 2 do
   mainFrame.buttons[i] = CreateFrame('Button', nil, mainFrame)
   if i == 1 then
      mainFrame.buttons[i]:SetNormalTexture('Interface/Buttons/UI-SpellbookIcon-PrevPage-Up')
      mainFrame.buttons[i]:SetPushedTexture('Interface/Buttons/UI-SpellbookIcon-PrevPage-Down')
      mainFrame.buttons[i]:SetDisabledTexture('Interface/Buttons/UI-SpellbookIcon-PrevPage-Disabled')
      mainFrame.buttons[i]:SetPoint("BOTTOMRIGHT", -60, 6)
   else
      mainFrame.buttons[i]:SetNormalTexture('Interface/Buttons/UI-SpellbookIcon-NextPage-Up')
      mainFrame.buttons[i]:SetPushedTexture('Interface/Buttons/UI-SpellbookIcon-NextPage-Down')
      mainFrame.buttons[i]:SetDisabledTexture('Interface/Buttons/UI-SpellbookIcon-NextPage-Disabled')
   end
   mainFrame.buttons[i]:SetHighlightTexture('Interface/Buttons/UI-Common-MouseHilight', 'ADD')
   mainFrame.buttons[i]:SetSize(24, 24)
end

local itemName = ObliterumForgeFrame:CreateFontString()
itemName:SetFontObject("GameFontHighlight")
itemName:SetPoint('CENTER', ObliterumForgeFrame.ItemSlot, 'TOP', 0, 42)

local itemLevel = ObliterumForgeFrame:CreateFontString()
itemLevel:SetFontObject("GameFontHighlight")
itemLevel:SetPoint('TOP', itemName, 'BOTTOM', 0, -4)


local ashText = CreateFrame('Frame', nil, ObliterumForgeFrame)
ashText:SetSize(104, 24)
ashText:EnableMouse(true)
--ashText:SetPoint('LEFT', ObliterumForgeFrame.ItemSlot, 'RIGHT', 20, 0)
ashText:SetPoint('TOP', ObliterumForgeFrame.ItemSlot, 'BOTTOM', 0, -12)
ashText:Hide()

ashText.fs = ashText:CreateFontString()
ashText.fs:SetFontObject("GameFontHighlight")
ashText.fs:SetPoint('CENTER')

local ashTotalText = CreateFrame('Frame', nil, ashText)
ashTotalText:SetSize(104, 10)
ashTotalText:EnableMouse(true)
ashTotalText:SetPoint('TOP', ashText, 'BOTTOM', 0, 0)

ashTotalText.fs = ashTotalText:CreateFontString()
ashTotalText.fs:SetFontObject("GameFontHighlight")
ashTotalText.fs:SetPoint('CENTER')

ashText:SetScript('OnEnter', function()
    GameTooltip:SetOwner(ashText, "ANCHOR_TOPRIGHT")
    GameTooltip:AddLine('|cFFFF0000Min|r/|cFFFFAA00Average|r/|cFF00FF00Max|r Ash for this item.', 1, 1, 1)
    GameTooltip:AddLine('Obliterate atleast 3 items before these stats become visible.')
    GameTooltip:Show()
end)

ashText:SetScript('OnLeave', function()
    GameTooltip:Hide()
end)

ashTotalText:SetScript('OnEnter', function()
    GameTooltip:SetOwner(ashTotalText, "ANCHOR_TOPRIGHT")
    GameTooltip:AddLine('Estimated ash for all of these items in your bags.', 1, 1, 1)
    GameTooltip:AddLine('Obliterate atleast 3 items before these stats become visible.')
    GameTooltip:Show()
end)

ashTotalText:SetScript('OnLeave', function()
    GameTooltip:Hide()
end)

ashTextToggle = CreateFrame('Button', nil, ObliterumForgeFrame)
ashTextToggle:SetPoint('CENTER', ObliterumForgeFrameInset, 'BOTTOMRIGHT', -20, 20)
ashTextToggle:SetSize(32, 32)

ashTextToggle.n = ashTextToggle:CreateTexture()
ashTextToggle.n:SetTexture("Interface\\common\\help-i")
ashTextToggle.n:SetAllPoints()

ashTextToggle.g = ashTextToggle:CreateTexture(nil, 'OVERLAY')
ashTextToggle.g:SetTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")
ashTextToggle.g:SetBlendMode("ADD")
ashTextToggle.g:SetAllPoints()
ashTextToggle.g:Hide()

--ashTextToggle:SetHighlightTexture(ashTextToggle.h)

ashTextToggle:SetScript('OnEnter', function(self)
    self.g:Show()
    GameTooltip:SetOwner(ashTextToggle, "ANCHOR_TOPRIGHT")
    GameTooltip:AddLine('Toggle display of ash stats when an item is selected.', 1, 1, 1)
    GameTooltip:Show()
end)

ashTextToggle:SetScript('OnLeave', function(self)
    self.g:Hide()
    GameTooltip:Hide()
end)

ashTextToggle:SetScript('OnClick', function(self)
    if showAshStats then
        showAshStats = false
        self.n:SetDesaturated(true)
        if itemName:IsVisible() then ashText:Hide() end
    else
        showAshStats = true
        self.n:SetDesaturated(false)
        if itemName:IsVisible() then ashText:Show() end
    end
    --self.g:Hide()
end)


    

local function hideSelection()
    if selectedButton then
        SetItemButtonDesaturated(getSelectedButton(), false)
        AnimatedShine_Stop(getSelectedButton())
        previousSelectedButton = selectedButton
        selectedButton = nil
    end
    itemName:Hide()
    itemLevel:Hide()
    
    ashText:Hide()
end

mainFrame.autoLoot = ObliterumForgeFrame:CreateFontString()
mainFrame.autoLoot:SetFontObject("GameFontHighlight")
mainFrame.autoLoot:SetText("Auto Loot:")
mainFrame.autoLoot:SetPoint('LEFT', ObliterumForgeFramePortrait, 'RIGHT', 20, -20)

mainFrame.autoLootCheck = CreateFrame('CheckButton', nil, ObliterumForgeFrame, "UICheckButtonTemplate")
mainFrame.autoLootCheck:SetPoint('LEFT', mainFrame.autoLoot, 'RIGHT', 0, -2)
mainFrame.autoLootCheck:SetSize(28, 28)
mainFrame.autoLootCheck:SetScript('OnClick', function(self)
    if GetCVar('autoLootDefault') == '1' then
        DEFAULT_CHAT_FRAME:AddMessage('Easy Obliterate: Auto Loot option cannot be disabled when you have auto loot enabled in interface settings.')
        self:SetChecked(true)
    end
end)

mainFrame.autoLootCheck:SetScript('OnEnter', function(self)
    GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
    GameTooltip:SetText('Automatically loot Obliterum Ash?')
    GameTooltip:Show()
end)

mainFrame.autoLootCheck:SetScript('OnLeave', function(self)
    GameTooltip:Hide()
end)

mainFrame.autoSelect = ObliterumForgeFrame:CreateFontString()
mainFrame.autoSelect:SetFontObject("GameFontHighlight")
mainFrame.autoSelect:SetText("Auto Select:")
mainFrame.autoSelect:SetPoint('LEFT', mainFrame.autoLoot, 'RIGHT', 50, 0)

mainFrame.autoSelectCheck = CreateFrame('CheckButton', nil, ObliterumForgeFrame, "UICheckButtonTemplate")
mainFrame.autoSelectCheck:SetPoint('LEFT', mainFrame.autoSelect, 'RIGHT', 0, -2)
mainFrame.autoSelectCheck:SetSize(28, 28)
mainFrame.autoSelectCheck:SetScript('OnClick', function(self)
    if self:GetChecked() then
        autoSelect = true
        ashLooted = true
        --[[
        if not selectedButton then
            selectNextItem()
        end
        --]]
    else
        autoSelect = false
        ashLooted = true
        --C_TradeSkillUI.ClearPendingObliterateItem()
    end
end)

mainFrame.autoSelectCheck:SetScript('OnEnter', function(self)
    GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
    GameTooltip:SetText('Automatically select the next item to obliterate?\n|cFFFFFFFFWARNING: Make sure you don\'t obliterate any items you want to keep!|r')
    GameTooltip:Show()
end)

mainFrame.autoSelectCheck:SetScript('OnLeave', function(self)
    GameTooltip:Hide()
end)

mainFrame.pageNumber = mainFrame:CreateFontString()
mainFrame.pageNumber:SetFontObject("GameFontHighlight")
mainFrame.pageNumber:SetText("1/1")
mainFrame.pageNumber:SetPoint('LEFT', mainFrame.buttons[1], 'RIGHT', 2, 0)
mainFrame.buttons[2]:SetPoint('LEFT', mainFrame.pageNumber, 'RIGHT', 4, 0)

--[[
mainFrame.statsButton = CreateFrame('Button', nil, mainFrame, 'GameMenuButtonTemplate')
mainFrame.statsButton:SetSize(110, 22)
mainFrame.statsButton:SetText('Statistics')
mainFrame.statsButton:SetPoint('BOTTOM', 0, 6)
-]]

local contentFrame = CreateFrame('ScrollFrame', nil, mainFrame)
contentFrame:SetSize(mainFrame:GetWidth()-16, 256-64+16)
contentFrame:SetPoint('TOP', 0, -24-16+16)
contentFrame:SetBackdrop({
      bgFile="Interface\\FrameGeneral\\UI-Background-Marble", 
      edgeFile='Interface/Tooltips/UI-Tooltip-Border', 
      tile = false, tileSize = 16, edgeSize = 16,
      insets = { left = 4, right = 4, top = 4, bottom = 4 }}
)
contentFrame:SetBackdropBorderColor(1, 1, 0, 1)

local ignoreTip = contentFrame:CreateFontString()
ignoreTip:SetFontObject("GameFonthighlight")
ignoreTip:SetText("Right click an item to ignore it")
ignoreTip:SetTextColor(0.9, 0.9, 0.9, 1)
ignoreTip:SetPoint('TOP', 0, -8)

local function showTooltip(self)
    if self.itemRef then
        if not eligibleItems[self.itemRef].ignore then
            GameTooltip:SetOwner(self, "ANCHOR_MOUSE");
            GameTooltip:SetHyperlink(eligibleItems[self.itemRef].itemLink)
            GameTooltip:AddLine('Left Click to add to the Obliterum Forge.', 1, 1, 1);
            GameTooltip:AddLine('Right Click to ignore/unignore this item.', 1, 1, 1);
            GameTooltip:Show()
        else
            GameTooltip:SetOwner(self, "ANCHOR_MOUSE");
            GameTooltip:SetText(eligibleItems[self.itemRef].itemName)
            GameTooltip:AddLine('|cFFFFFFFFThis item is on your ignore list.|r')           
            GameTooltip:Show()        
        end
    end
end

local function hideTooltip(self)
   if self.itemRef then
      GameTooltip:Hide()
   end
end

local function addItemToForge(self, button)
    if not ashLooted then
        DEFAULT_CHAT_FRAME:AddMessage('Easy Obliterate: Closing loot window.')
        CloseLoot()
        return
    end

    if self.itemRef then
        if button == 'LeftButton' then
            if not eligibleItems[self.itemRef].ignore then
                if selectedButton then
                    if selectedButton ~= self.itemRef then
                        hideSelection()
                        selectedButton = self.itemRef
                        UseContainerItem(eligibleItems[self.itemRef].bag, eligibleItems[self.itemRef].index)       
                    elseif selectedButton == self.itemRef then
                        C_TradeSkillUI.ClearPendingObliterateItem()
                    end
                else
                    selectedButton = self.itemRef
                    UseContainerItem(eligibleItems[self.itemRef].bag, eligibleItems[self.itemRef].index)
                end
                hideTooltip(self)
                PlaySound("igMainMenuOptionCheckBoxOn")
            end               
        elseif button == 'RightButton' then
            PlaySound("igMainMenuOptionCheckBoxOn")
            if not eligibleItems[self.itemRef].ignore then
                --itemIgnoreList[eligibleItems[self.itemRef].itemLink] = true
                table.insert(itemIgnoreList, eligibleItems[self.itemRef].itemLink)
                --DEFAULT_CHAT_FRAME:AddMessage('Easy Obliterate: Added '..eligibleItems[self.itemRef].itemName..' to ignored items.')

                for i = 1, #itemButtons do
                    if itemButtons[i].itemRef then
                        if eligibleItems[itemButtons[i].itemRef].itemLink == eligibleItems[self.itemRef].itemLink then
                            itemButtons[i].IconBorder:SetVertexColor(0.5, 0.5, 0.5)
                            SetItemButtonDesaturated(itemButtons[i], true)
                            eligibleItems[itemButtons[i].itemRef].ignore = true
                            itemButtons[i].ignoredTexture:Show()
                        end
                    end
                end
            elseif eligibleItems[self.itemRef].ignore then
                local k = inIgnoreList(eligibleItems[self.itemRef].itemLink)
                if k then
                    table.remove(itemIgnoreList, k)
                    --DEFAULT_CHAT_FRAME:AddMessage('Easy Obliterate: Removed '..eligibleItems[self.itemRef].itemName..' from ignored items.')
                    for i = 1, #itemButtons do
                        if itemButtons[i].itemRef then
                            if eligibleItems[itemButtons[i].itemRef].itemLink == eligibleItems[self.itemRef].itemLink then
                                SetItemButtonQuality(itemButtons[i], eligibleItems[itemButtons[i].itemRef].itemQuality, eligibleItems[itemButtons[i].itemRef].itemLink)
                                SetItemButtonDesaturated(itemButtons[i], false)
                                itemButtons[i].ignoredTexture:Hide()                                
                            end
                        end
                    end
                end               
            end
            getEligibleItems()
            updateItemButtons(true)
            if GameTooltip:IsVisible() then showTooltip(self) end
        end     
    end
end

local function createItemButton(i)
    local frame = CreateFrame('Button', 'EasyObliterateItemButton'..i, contentFrame, "ItemButtonTemplate")
    frame:RegisterForClicks('LeftButtonUp', 'RightButtonUp')
    frame.bg = frame:CreateTexture(nil, 'BACKGROUND')
    frame.bg:SetTexture("Interface\\Buttons\\UI-EmptySlot-Disabled")
    frame.bg:SetSize(54, 54)
    frame.bg:SetPoint('CENTER')

    frame.shine = CreateFrame('Frame', frame:GetName().."Shine", frame, "AnimatedShineTemplate")
    frame.shine:SetAllPoints()

    frame.glow = frame:CreateTexture(nil, 'OVERLAY')
    frame.glow:SetColorTexture(1, 1, 1, 0.8)
    frame.glow:SetAllPoints()
    frame.glow:SetAlpha(0)

    frame.glowAnimation = frame.glow:CreateAnimationGroup()
    frame.glowAnimation[1] = frame.glowAnimation:CreateAnimation("Alpha")
    frame.glowAnimation[1]:SetDuration(0.2)
    frame.glowAnimation[1]:SetFromAlpha(0.8)
    frame.glowAnimation[1]:SetToAlpha(0)
    frame.glowAnimation[1]:SetOrder(1)
    
    frame.ignoredTexture = frame:CreateTexture(nil, 'OVERLAY')
    frame.ignoredTexture:SetTexture("Interface\\PetBattles\\DeadPetIcon")
    frame.ignoredTexture:SetSize(12, 12)
    frame.ignoredTexture:SetAlpha(0.8)
    frame.ignoredTexture:SetPoint('TOPLEFT', 1, -1)
  
    frame.itemRef = nil

    frame:SetScript('OnEnter', showTooltip)
    frame:SetScript('OnLeave', hideTooltip)
    frame:SetScript('OnClick', addItemToForge)

    return frame
end

--ItemButtons
for i = 0, 27 do
   local spacing = math.floor(((contentFrame:GetWidth()-16)-(7*32))/7)
   local perRow = 7
   local maxRows = 4
   local x = 16 + i%perRow*(32+spacing)
   local y = -30 - math.floor(i/7)*42
   
   itemButtons[i+1] = createItemButton(i+1)
   itemButtons[i+1]:SetSize(32, 32)     
   itemButtons[i+1]:SetPoint('TOPLEFT', x, y)
end

local function getMaxPage()
    local maxPage = math.ceil(#eligibleItems/#itemButtons)
    if maxPage == 0 then maxPage = 1 end
    return maxPage
end

local function updateText()
   mainFrame.totalText:SetText("Total: "..#eligibleItems)
   mainFrame.pageNumber:SetText(currentPage.."/"..getMaxPage())
end

local function updatePageButtons()
   if currentPage == getMaxPage() then
      mainFrame.buttons[2]:Disable()
   else
      mainFrame.buttons[2]:Enable()
   end
   
   if currentPage == 1 then
      mainFrame.buttons[1]:Disable()
   else
      mainFrame.buttons[1]:Enable()
   end
end

local function updateContentFrame()
    if currentPage > getMaxPage() then
        currentPage = getMaxPage()
    end
    updateItemButtons()
    updateText()
    updatePageButtons()
end

local function populateFrame()
    getEligibleItems()  
    updateContentFrame()
    if autoSelect and ashLooted then
        selectNextItem()
    end
end

mainFrame.buttons[1]:SetScript('OnClick', function()
    C_TradeSkillUI.ClearPendingObliterateItem() 
    currentPage = currentPage - 1      
    updateContentFrame()
end)

mainFrame.buttons[2]:SetScript('OnClick', function()
    C_TradeSkillUI.ClearPendingObliterateItem()  
    currentPage = currentPage + 1
    updateContentFrame()
end)

local function showSelection()
    local link = C_TradeSkillUI.GetPendingObliterateItemLink()
    if link then     
        if not selectedButton or eligibleItems[getSelectedButton().itemRef].itemLink ~= link then
            for i = 1, #itemButtons do
                if eligibleItems[itemButtons[i].itemRef].itemLink == link then
                    if selectedButton then hideSelection() end
                    selectedButton = i
                    break
                end
            end
        end
        
        itemName:SetText(link)
        local _,_,_, iLvl = GetItemInfo(link)
        itemLevel:SetText(iLvl)
        itemName:Show()
        itemLevel:Show()
        

        
        local totalCount = 0
        for i = 1, #eligibleItems do
            if eligibleItems[i].itemLink == link then
                totalCount = totalCount + eligibleItems[i].itemCount
            end
        end
        
        if ashStats[C_TradeSkillUI.GetPendingObliterateItemID()] and ashStats[C_TradeSkillUI.GetPendingObliterateItemID()][iLvl] and totalCount > 0 then
            if ashStats[C_TradeSkillUI.GetPendingObliterateItemID()][iLvl].obliterateCount >= 3 then
                local itemID = C_TradeSkillUI.GetPendingObliterateItemID()
                --ashText.fs:SetText('= '..string.format("%.2f", ashStats[itemID][iLvl].averageAsh)..' ('..string.format("%.2f", (ashStats[itemID][iLvl].averageAsh*totalCount))..')')
                --ashText.fs:SetText(ashStats[itemID][iLvl].minAsh..' - '..ashStats[itemID][iLvl].maxAsh)
                
                ashTotalText.fs:SetText('('..string.format("%.1f", (ashStats[itemID][iLvl].averageAsh*totalCount))..')')
                ashText.fs:SetText('|cFFFF0000'..ashStats[itemID][iLvl].minAsh..'|r'..'/'..'|cFFFFAA00'..string.format("%.1f", ashStats[itemID][iLvl].averageAsh)..'|r'..'/'..'|cFF00FF00'..ashStats[itemID][iLvl].maxAsh..'|r')
            else
                ashTotalText.fs:SetText('(?)')
                ashText.fs:SetText('|cFFFF0000?|r/|cFFFFAA00?|r/|cFF00FF00?|r')               
            end
        else
            ashTotalText.fs:SetText('(?)')
            ashText.fs:SetText('|cFFFF0000?|r/|cFFFFAA00?|r/|cFF00FF00?|r')
        end
        
        if showAshStats then
            ashText:Show()
        end


        
        AnimatedShine_Start(getSelectedButton(), 1, 1, 0.4)
        SetItemButtonDesaturated(getSelectedButton(), true)
        
        currentItem.itemID = C_TradeSkillUI.GetPendingObliterateItemID()
        currentItem.itemLevel = iLvl
    else
        mainFrame:RegisterEvent('GET_ITEM_INFO_RECEIVED');
        dprint('Awaiting GET_ITEM_INFO_RECEIVED')
    end
end

local function updateAshStats(itemID, itemLevel, ashCount)
    if not itemID or not itemLevel then return end
    ashCount = tonumber(ashCount)
    
    if not ashStats[itemID] then ashStats[itemID] = {} end
    if not ashStats[itemID][itemLevel] then ashStats[itemID][itemLevel] = {minAsh = 100, maxAsh = 0, averageAsh = 0, obliterateCount = 0} end
    
    if ashCount < ashStats[itemID][itemLevel].minAsh then ashStats[itemID][itemLevel].minAsh = ashCount end
    if ashCount > ashStats[itemID][itemLevel].maxAsh then ashStats[itemID][itemLevel].maxAsh = ashCount end
    
    ashStats[itemID][itemLevel].averageAsh = ((ashStats[itemID][itemLevel].averageAsh*ashStats[itemID][itemLevel].obliterateCount)+ashCount)/(ashStats[itemID][itemLevel].obliterateCount + 1)
    ashStats[itemID][itemLevel].obliterateCount = ashStats[itemID][itemLevel].obliterateCount + 1
end

mainFrame:SetScript('OnEvent', function(self, event, ...)
    dprint(event)
    if event == 'BAG_UPDATE_DELAYED' then       
        populateFrame()       
    elseif event == 'LOOT_OPENED' then
        local lootIcon, _, lootQuantity = GetLootSlotInfo(1)
        if lootIcon == 1341655 then
            lastItem.ashAmount = lootQuantity
            if mainFrame.autoLootCheck:GetChecked() then
                LootSlot(1)
                --CloseLoot()
            end
        end    
    elseif event == 'CHAT_MSG_LOOT' then
        local lootstring = ...
        local itemID = string.match(lootstring, "Hitem:(%d+):")
        --local ashAmount = string.match(lootstring, "x(%d+).") or 1
        if itemID == '136342' and not ashLooted then
            ashLooted = true
            updateAshStats(lastItem.itemID, lastItem.itemLevel, lastItem.ashAmount)
            --Add to statistics
        end
    elseif event == 'OBLITERUM_FORGE_PENDING_ITEM_CHANGED' then
        if C_TradeSkillUI.GetPendingObliterateItemLink() then
            if not inIgnoreList(C_TradeSkillUI.GetPendingObliterateItemLink()) then
                showSelection()
            else
                C_TradeSkillUI.ClearPendingObliterateItem()
                DEFAULT_CHAT_FRAME:AddMessage('Easy Obliterate: This item is on your ignore list!')
            end
        else
            hideSelection()
        end
    elseif event == 'UNIT_SPELLCAST_START' then
        local unitTag, spellName, rank, lineID, spellID = ...
        --If we're obliterating store the currently selected item and the lineid
        if spellID == C_TradeSkillUI.GetObliterateSpellID() then
            currentLineID = lineID
            
            ObliterumForgeFrame.ObliterateButton:Disable()
        end
    elseif event == 'UNIT_SPELLCAST_INTERRUPTED' then
        local unitTag, spellName, rank, lineID, spellID = ...
        if lineID == currentLineID and spellID == C_TradeSkillUI.GetObliterateSpellID() then
            curentLineID = nil
            ObliterumForgeFrame.ObliterateButton:Enable()
        end
    elseif event == 'UNIT_SPELLCAST_SUCCEEDED' then
        local unitTag, spellName, rank, lineID, spellID = ...
        if lineID == currentLineID and spellID == C_TradeSkillUI.GetObliterateSpellID() then   
            lastItem.itemID = currentItem.itemID
            lastItem.itemLevel = currentItem.itemLevel
            lastItem.ashAmount = 0
        
            if not ashLooted then
                --This should never happen it means we never received our ash. Bug with the fel forge, I'm pretty sure it's not caused by Easy Obliterate.
                StaticPopup_Show ("EasyObliterate_AshNotFound")
            end
            
            ashLooted = false
        end
    elseif event == 'GET_ITEM_INFO_RECEIVED' then
		self:UnregisterEvent('GET_ITEM_INFO_RECEIVED')
        showSelection()
    elseif event == 'ADDON_LOADED' then
        local name = ...
        if name == 'Easy_Obliterate' then
            if EasyObliterate_Data then
                dprint('Easy Obliterate: Loaded _DATA')
                ashStats = EasyObliterate_Data.ashStats
                
                if EasyObliterate_Data.addonVersion == 16 then
                    ashStats = {}
                    StaticPopup_Show ("EasyObliterate_AshStatsWiped")
                end
            else
                dprint('Easy Obliterate: Created _DATA')
                ashStats = {}
            end
            
           if EasyObliterate_IgnoreList then 
                dprint('Easy Obliterate: IgnoreList found')
                itemIgnoreList = EasyObliterate_IgnoreList
            else
                dprint('Easy Obliterate: IgnoreList CREATED')
                itemIgnoreList = {}
            end
            
            mainFrame:UnregisterEvent('ADDON_LOADED')
        end
    elseif event == 'PLAYER_LOGOUT' then
        EasyObliterate_Data = {ashStats = ashStats, addonVersion = addonVersion}
        EasyObliterate_IgnoreList = itemIgnoreList
    end
end)

savedOnShow = ObliterumForgeFrame:GetScript('OnShow')
savedOnHide = ObliterumForgeFrame:GetScript('OnHide')
mainFrame:RegisterEvent('ADDON_LOADED')
mainFrame:RegisterEvent('PLAYER_LOGOUT')




ObliterumForgeFrame:SetScript('OnShow', function(self)
    savedOnShow(self)
    mainFrame:RegisterEvent('BAG_UPDATE_DELAYED')
    mainFrame:RegisterEvent('LOOT_OPENED')
    mainFrame:RegisterEvent('CHAT_MSG_LOOT')
    mainFrame:RegisterEvent('OBLITERUM_FORGE_PENDING_ITEM_CHANGED')
    mainFrame:RegisterUnitEvent('UNIT_SPELLCAST_SUCCEEDED', 'player')
    mainFrame:RegisterUnitEvent('UNIT_SPELLCAST_START', 'player')
    mainFrame:RegisterUnitEvent('UNIT_SPELLCAST_INTERRUPTED', 'player')

    currentPage = 1
    hideSelection()
    
    showGetItemError = true
    populateFrame()
    
    if GetCVar('autoLootDefault') == '1' then
        mainFrame.autoLootCheck:SetChecked(true)
    end
    
    ashLooted = true
    autoSelect = false
    mainFrame.autoSelectCheck:SetChecked(false)
    previousSelectedButton = nil
    selectedButton = nil
end)

ObliterumForgeFrame:SetScript('OnHide', function(self)
      savedOnHide(self)
      mainFrame:UnregisterEvent('BAG_UPDATE_DELAYED')
      mainFrame:UnregisterEvent('LOOT_OPENED')
      mainFrame:UnregisterEvent('CHAT_MSG_LOOT')
      mainFrame:UnregisterEvent('OBLITERUM_FORGE_PENDING_ITEM_CHANGED')
      mainFrame:UnregisterEvent('UNIT_SPELLCAST_SUCCEEDED')
      mainFrame:UnregisterEvent('UNIT_SPELLCAST_START')
      mainFrame:UnregisterEvent('UNIT_SPELLCAST_INTERRUPTED')
end)

BINDING_HEADER_EASYOBLITERATEHEAD = "Easy Obliterate"
_G["BINDING_NAME_CLICK EasyObliterate:LeftButton"] = "Obliterate Item"

local b = CreateFrame('Button', 'EasyObliterate', nil, 'SecureActionButtonTemplate')
b:SetAttribute('type', 'click')
b:SetAttribute('clickbutton', ObliterumForgeFrame.ObliterateButton)

StaticPopupDialogs["EasyObliterate_AshNotFound"] = {
   text = 'Easy Obliterate\n\n It seems you did not receive ash from your previous item. If this keeps happening try relogging or restarting the game.',
   button1 = "Ok",
   timeout = 0,
   whileDead = true,
   hideOnEscape = true,
   preferredIndex = 3,
}

StaticPopupDialogs["EasyObliterate_AshStatsWiped"] = {
   text = 'Easy Obliterate\n\n Due to a bug, ash stats were sometimes calculated the wrong way when you were close to 1000 ash in your bags. Ash stats have been reset for that reason, sorry for the inconvience.',
   button1 = "Ok",
   timeout = 0,
   editBoxWidth = 350,
   whileDead = true,
   hideOnEscape = true,
   preferredIndex = 3,
}