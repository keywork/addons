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

local dewdrop = AceLibrary("Dewdrop-2.0")
    
local dewOptions = {} -- table for the dewdrop menu

local L = AceLibrary("AceLocale-2.2"):new("Bidder")

local LootFrame = { 
   itembuttons = {}, 
   nbuttons = 0, 
   nitems = 0, 
   biddingOpen = false, 
   lootmaster = nil, 
   mypoints = nil 
}
Bidder.Looting = LootFrame

Bidder.DBDefaults.LootFrame = {}
Bidder.DBDefaults.LootFrame.pos = { x = (UIParent:GetWidth() / 2), y = (UIParent:GetHeight() / 2) }


--[[
LootFrame:Create()
Description:
  Build the frame for handling looting/bidding/auctioning/etc via DKPmon
Input:
Returns:
]]
function LootFrame:Create()
   if self.frame then return end
   
   self.frame = CreateFrame("Frame", "BidderLootFrame", UIParent)
   self.frame:SetFrameStrata("DIALOG")
   self.frame:SetFrameLevel(7)
   self.frame:SetWidth(325)
   self.frame:SetHeight(45)
   
   self.frame:SetMovable(1)
   self.frame:EnableMouse(1)
   self.frame:RegisterForDrag("LeftButton")
   self.frame:SetScript("OnDragStart", function() LootFrame:DragStart() end)
   self.frame:SetScript("OnDragStop", function() LootFrame:DragStop() end)
   
   Bidder.FrameSkinner:BackdropFrame(self.frame, {0, 0, 0, 0.7}, {0.7, 0.7, 0.7, 0.9})
   
   self.frame:ClearAllPoints()
   self.frame:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", Bidder.db.realm.LootFrame.pos.x, Bidder.db.realm.LootFrame.pos.y)
   
   Bidder.FrameSkinner:Skin(self.frame)
   
   -- Create the close-window button
   local b = CreateFrame("Button", "BidderLootFrameCloseButton", self.frame)
   self.closebutton = b
   b:SetScript("OnClick", function() LootFrame.frame:Hide() end)
   --    b:SetFrameLevel(8)
   b:SetWidth(32); b:SetHeight(32)
   b:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up")
   b:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down")
   b:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight")
   b:ClearAllPoints()
   b:SetPoint("TOPRIGHT", self.frame, "TOPRIGHT", 3, 3)
   b:SetHitRectInsets(5, 5, 5, 5)
   b:Show()
   
   -- String to display the player's bidding name
   t = self.frame:CreateFontString()
   self.nameplate = t
   t:SetPoint("TOPLEFT",self.frame,"TOPLEFT",4,-5)
   t:SetPoint("BOTTOMRIGHT",self.frame,"TOPRIGHT",-25,-23)
   t:SetTextColor(1.0, 0.819, 0.0)
   t:SetJustifyH("CENTER")
   t:SetJustifyV("TOP")
   t:SetFontObject(GameFontNormal)
   self:SetNameplateText()
end

function LootFrame:SetNameplateText()
   if self.frame == nil then return end
   local tab = Bidder.db.realm.namelist[Bidder.biddingname]
   self.nameplate:SetText(string.format(L["Bidding with name: |cff%s%s|r"], tab.classhex, tab.name))
end

--[[
LootFrame:Show()
Description:
  Display the DKPmon looting window
Input:
Returns:
]]
function LootFrame:Show()
   self:Create()
   self.frame:Hide()
   local buttonheight = 0
   local width = 325
   local i
   for i = 1, self.nbuttons do
      self.itembuttons[i]:Hide()
   end
   for i = 1, self.nitems do
      width = math.max(width, self.itembuttons[i]:GetWidth()+20)
      self.itembuttons[i]:Show()
   end
   
   if self.nbuttons > 0 then
      buttonheight = self.itembuttons[1]:GetHeight()
   end
   self.frame:SetHeight(45 + buttonheight * self.nitems)
   self.frame:SetWidth(width)
   self.frame:Show()
end

--[[
LootFrame:Hide()
Description:
  Hide the DKPmon looting window
Input:
Returns:
]]
function LootFrame:Hide()
   if self.frame then self.frame:Hide() end
end

--[[    
LootFrame:DragStart()
Description:
  Called when the user clicks on the DKPmon looting window to begin moving it around
Input:
Returns:
]]
function LootFrame:DragStart()
   self.frame:StartMoving()
end

--[[
LootFrame:DragStop()
Description:
  Called when the user stops dragging the window around. Saves the position of the window to the AceDB
Input:
Returns:
]]
function LootFrame:DragStop()
   self.frame:StopMovingOrSizing()
   Bidder.db.realm.LootFrame.pos.x = self.frame:GetLeft()
   Bidder.db.realm.LootFrame.pos.y = self.frame:GetTop()
end

--[[
LootFrame:Clear()
Description:
  Called to clear all items from the loot window, and hide the window if it's shown.
Input:
Returns:
]]
function LootFrame:Clear()
   if self.frame == nil then return end -- nothing to do
   self.nitems = 0
   if self.frame:IsVisible() == 1 then self:Hide() end
end

--[[
LootFrame:ReceiveOpenBidding()
Description:
  Called when a "OB" command is received from DKPmon. This starts the process of openning bidding.
Input:
  sender -- the person who openned bidding
  params -- table; paramters for the "OB" command. See design doc for information
Returns:
  true
]]
function LootFrame:ReceiveOpenBidding(sender, params)
   -- Check that we have the module for the desired DKP system in place.
   if Bidder.DKP:SetDKPSystem(params.sysID) == false then
      -- We can't join this bidding cycle.
      return true
   end
   -- Save the information on the items for later reference.
   --if self.iteminfo ~= nil then Bidder:TableDelete(self.iteminfo) end
   --if self.mypoints ~= nil then Bidder:TableDelete(self.mypoints) end
   self.mypoints = nil
   self.iteminfo = params.iteminfo
   
   -- *************************************************
   -- HACK to get around AceComm bug with not receiving itemlinks that aren't in the local cache
--   local info
--   for _, info in ipairs(self.iteminfo) do
--      info.link = string.gsub(info.link, "@@@@", "|")
--   end
   -- *************************************************

   self.lootmaster = sender
   -- Send the request for our points
   Bidder.Comm:SendToDKPmon("QP", Bidder:CharInfoToString(Bidder.biddingname), sender)
   return true
end
Bidder.Comm:RegisterCommand("OB", LootFrame.ReceiveOpenBidding, LootFrame)

--[[
LootFrame:ReceivePointsResults()
Description:
  Called when a "RQP" command is received from DKPmon. This will give us our point totals, so that we can begin the bidding process.
Input:
Returns:
  true
]]
function LootFrame:ReceivePointsResults(sender, params)
   if sender ~= self.lootmaster then return true end
   if self.mypoints ~= nil then 
      -- If mypoints isn't nil, then bidding was already open.
      -- That means that this message was received as the result of a change in bidding name.
      -- So, just update the points table and move on.
      --Bidder:TableDelete(self.mypoints)
      self.mypoints = params
		--Update button status text in case module displays points information
		for i = 1, self.nitems do
			self.itembuttons[i]:UpdateStatusText()
		end
      return true
   end
   self.mypoints = params
   -- Configure the bidding window
   if self.frame == nil then self:Create() end
   local index, info
   self.nitems = 0
   for index, info in ipairs(self.iteminfo) do
      if (self.nbuttons == self.nitems) then
	 self.nbuttons = self.nbuttons + 1
	 self.itembuttons[self.nbuttons] = Bidder.LootItem:New(self.frame, self.nbuttons)
      end
      self.itembuttons[index]:SetItem(info.link, info.dkp)
      self.nitems = self.nitems + 1
   end
   self:Show()
   self.biddingOpen = true
   return true
end
Bidder.Comm:RegisterCommand("RQP", LootFrame.ReceivePointsResults, LootFrame)

--[[
LootFrame:ReceivePCloseBiddingointsResults()
Description:
  Called when a "C" command is received from DKPmon. This will close all bidding.
Input:
Returns:
  true
]]
function LootFrame:CloseBidding(sender, params)
   if sender ~= self.lootmaster then return true end
   self.nitems = 0
   self.biddingOpen = false
   self:Hide()
   return true
end
Bidder.Comm:RegisterCommand("C", LootFrame.CloseBidding, LootFrame)
