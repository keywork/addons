--[[
    Copyright Daniel D. Neilson, 2006

    This file is part of Bidder_FCZS.

    Bidder_FCZS is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    Bidder_FCZS is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Bidder_FCZS; if not, write to the Free Software
    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
]]

--[[
      -- Every item is a fixed point cost, as dictated by a database of items.
      -- Points are awarded using zero-sum
      -- Supports an arbitrary number of "point pools"
]]


local AceOO = AceLibrary("AceOO-2.0")

local FCZS = AceOO.Class(Bidder_DKP_BaseClass)
local L = AceLibrary("AceLocale-2.2"):new("Bidder_FCZS")

--[[
FillTooltip()
Description:
  Called when an item in the Bidding Window is moused over to add the DKP-system specific information to the GameTooltip for the moused over item
Input:
  dkpinfo -- table;  same table returned from DKPmon:GetItemInfo() plus whatever else the DKP system added to track bidding
  mypoints -- table; This is the points table returned by the "RQP" communications command
Returns:
  Nothing
]]
function FCZS.prototype:FillTooltip(dkpinfo, mypoints)
   GameTooltip:AddLine(" ")
   GameTooltip:AddDoubleLine(string.format(L["DKP Cost = %g"], dkpinfo.cost),  dkpinfo.poolName,
                             1.0, 0.819, 0.0, 1.0, 0.819, 0.0) 
   GameTooltip:AddLine(string.format(L["Your DKP = %g"], mypoints[dkpinfo.poolIndex]),  1.0, 0.819, 0.0)
end

--[[
GetStatusText
Description:
  Return the status line text, for the LootItem button, of the item with the given dkpinfo
Input:
  dkpinfo -- table;  same table returned from DKPmon:GetItemInfo() plus whatever else the DKP system added to track bidding
Returns:
  String -- the text to be displayed; -cannot- be nil
]]
function FCZS.prototype:GetStatusText(dkpinfo)
   if dkpinfo.bidplaced then
      return L["Bid placed"]
   end
   return ""
end

--[[
OnLeftClick(dewOptions, itembutton, dkpinfo)
Description:
  Called when the user left clicks on an item in the bidding window
Input:
  dewOptions -- An Ace Options table to use if the DKP system needs to build a menu on a left click
  itembutton -- The LootItem object that made this call.
  dkpinfo -- table; same table returned from DKPmon:GetItemInfo() plus whatever else the DKP system added to track bidding
Returns:
  boolean -- true = display the dewdrop menu, false = don't display it
]]
function FCZS.prototype:OnLeftClick(dewOptions, itembutton, dkpinfo)
   -- A left click toggles whether we're bidding on the item
   if dkpinfo.bidplaced then dkpinfo.bidplaced = nil else dkpinfo.bidplaced = true end
   Bidder.Comm:SendToDKPmon("PB", { item = itembutton.id }, Bidder.Looting.lootmaster)
   itembutton:UpdateStatusText()
   return false
end

--[[
OnRightClick(dewOptions, itembutton, dkpinfo)
Description:
  Called when the user right clicks on an item in the bidding window
Input:
  dewOptions -- An Ace Options table to use if the DKP system needs to build a menu on a left click
  itembutton -- The LootItem object that made this call.
  dkpinfo -- table; same table returned from DKPmon:GetItemInfo() plus whatever else the DKP system added to track bidding
Returns:
  boolean -- true = display the dewdrop menu, false = don't display it
]]
function FCZS.prototype:OnRightClick(dewOptions, itembutton, dkpinfo)
   -- Points as currency does nothing on a right click
   return false
end

-- Last, but not least, create a FCZS object and register it to Bidder as a DKP system
local FCZSObj = FCZS:new()
Bidder.DKP:Register(FCZSObj, "FCZS", L["Fixed cost zero-sum"])
