--[[
    Copyright Daniel D. Neilson, 2006

    This file is part of Bidder.

    Bidder is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    Bidder is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Bidder; if not, write to the Free Software
    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
]]

local _G = getfenv(0)

local dewdrop = AceLibrary("Dewdrop-2.0")
local dewOptions = {} -- table for the dewdrop menu

local LootItem = {}
Bidder.LootItem = LootItem

--[[
New
Description:
  Create a new loot item button frame.
Input:
  parent -- frame to use as the parent of the button
  id     -- number; loot id of the button (integer, and > 0)
Returns:
  frame -- the frame created for the item
]]
function LootItem:New(parent, id)
   -- Written with guidance from XLoot:AddLootFrame
   local item = { id = id }
   
   local frame = CreateFrame("Frame", "BidderLootItem"..id, parent)
   item.frame = frame 
   local button = CreateFrame(LootButton1:GetObjectType(), "BidderLootItem"..id.."Button", frame, "LootButtonTemplate")
   item.button = button
   button.lootitem = item
   
   item.itemname = _G["BidderLootItem"..id.."ButtonText"]
   item.statusline = button:CreateFontString("BidderLootItem"..id.."ButtonDescription", "ARTWORK", "GameFontNormalSmall")
   
   local font = {item.itemname:GetFont()}
   font[2] = 10
   
   item.itemname:SetDrawLayer("OVERLAY")
   item.itemname:SetJustifyH("LEFT")
   item.itemname:SetHeight(10)
   item.itemname:SetWidth(300)
   item.itemname:ClearAllPoints()
   item.itemname:SetPoint("TOPLEFT", button, "TOPLEFT", 42, -8)
   
   item.statusline:SetDrawLayer("OVERLAY")
   item.statusline:SetFont(unpack(font))
   item.statusline:SetJustifyH("LEFT")
   item.statusline:SetHeight(10)    
   item.statusline:SetWidth(300)
   item.statusline:ClearAllPoints()
   item.statusline:SetPoint("TOPLEFT", button, "TOPLEFT", 45, -19)
   
   button:SetHitRectInsets(0, -210, 0, -1)
   
   local border = Bidder.FrameSkinner:QualityBorder(button)
   local fborder = Bidder.FrameSkinner:QualityBorder(frame)
   button.wrapper = Bidder.FrameSkinner:ItemButtonWrapper(button, 6, 6)
   fborder:SetHeight(fborder:GetHeight() -3)
   fborder:SetPoint("CENTER", frame, "CENTER", 4, 0.5)
   fborder:SetAlpha(0.3)
   frame:SetWidth(350)
   frame:SetHeight(button:GetHeight()+1)
   button:ClearAllPoints()
   frame:ClearAllPoints()
   frame:SetPoint("TOPLEFT", parent, "TOPLEFT", 10, -40 - (id-1)*(frame:GetHeight()+5))
   
   button:SetPoint("LEFT", frame, "LEFT")
   button:SetScript("OnClick", function(s, bclicked) s.lootitem:OnClick(bclicked) end)
   button:SetScript("PostClick", function(s, bclicked) if bclicked == "LeftButton" and IsControlKeyDown() then DressUpItemLink(item.iteminfo.link) end end)
   button:SetScript("OnEnter", function(s) s.lootitem:ShowTooltip() end)
   
   --Skin
   Bidder.FrameSkinner:Skin(frame)
   
   button:DisableDrawLayer("ARTWORK")
   button:Hide()
   frame:Hide()
   
   setmetatable(item, { __index = LootItem })
   return item
end

--[[
Show
Description:
  Show the button
Input:
Returns:
]]
function LootItem:Show()
   self.frame:Show()
   self.button:Show()
end

--[[
Hide
Description:
  Hide the button
Input:
Returns:
]]
function LootItem:Hide()
   self.frame:Hide()
   self.button:Hide()
end


--[[
GetHeight, GetWidth
Description:
  Return the height & width of the button, respectively
Input:
Returns:
]]
function LootItem:GetHeight()
   return self.button.wrapper:GetHeight()
end
function LootItem:GetWidth()
   return self.frame:GetWidth()
end

--[[
SetItem
Description:
  Set the item information for this button
Input:
  itemlink -- string; the itemlink for the item
  dkpinfo  -- table; the table containing information needed by the DKP system for this item
Returns:
None
]]
function LootItem:SetItem(itemlink, dkpinfo)
   local name, link, quality, iLevel, reqLevel, class, subClass, maxStack, equipSlot, texture, vendorPrice = GetItemInfo(itemlink);
   if name == nil then
      _,_,name = string.find(itemlink, "|h%[(.+)%]|h")
   end
   if quality == nil then
      quality = 4 -- Assume epic quality
   end
   self.dkpinfo = dkpinfo
   self.iteminfo = { 
      name = name, 
      link = itemlink, 
      quality = quality,
      colour = Bidder:rgbToHex(ITEM_QUALITY_COLORS[quality]),
      colourrgb = { r=ITEM_QUALITY_COLORS[quality].r, g=ITEM_QUALITY_COLORS[quality].g, b=ITEM_QUALITY_COLORS[quality].b }, 
      texture = texture
   }
   SetItemButtonTexture(self.button, self.iteminfo.texture)
   self.itemname:SetTextColor(self.iteminfo.colourrgb.r, self.iteminfo.colourrgb.g, self.iteminfo.colourrgb.b)
   self.itemname:SetText(self.iteminfo.name)
   self:UpdateStatusText()
end

--[[
UpdateStatusText
Description:
  Update the statusline text to reflect the current winner and # of bidders.
Input:
Returns:
]]
function LootItem:UpdateStatusText()
   self.statusline:SetText(Bidder.DKP:Get():GetStatusText(self.dkpinfo))
end

--[[
ShowTooltip
Description:
  Display the tooltip for the item associated with this button
Input:
Returns:
]]
function LootItem:ShowTooltip()
   GameTooltip:SetOwner(self.frame, "ANCHOR_RIGHT")
   GameTooltip:SetHyperlink(self.iteminfo.link)
   Bidder.DKP:Get():FillTooltip(self.dkpinfo, Bidder.Looting.mypoints)
   GameTooltip:Show()
   CursorUpdate()
end

--[[
    OnClick
Description:
  OnClick event handler for this button
Input:
  buttonclicked -- string; which button was clicked.
Returns:
]]
function LootItem:OnClick(buttonclicked)
   --Bidder:TableDelete(dewOptions)
   dewOptions = {}
   if buttonclicked == "LeftButton" then
      if IsControlKeyDown() then return end -- dressing room function
      dewOptions.type = "group"
      dewOptions.args = {}
      if Bidder.DKP:Get():OnLeftClick(dewOptions, self, self.dkpinfo) then
	 dewdrop:Open(self.button, 'children', dewOptions, 'point', "TOPLEFT", 'relativePoint', "TOPRIGHT")
      end
      return
   end
   if buttonclicked == "RightButton" then
      dewOptions.type = "group"
      dewOptions.args = {}
      if Bidder.DKP:Get():OnRightClick(dewOptions, self, self.dkpinfo) then
	 dewdrop:Open(self.button, 'children', dewOptions, 'point', "TOPLEFT", 'relativePoint', "TOPRIGHT")
      end
      return
   end
end
