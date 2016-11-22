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

--[[
   "Fixed DKP" DKP system.
      -- Every item is a fixed point cost, as dictated by a database of items.
      -- Points are awarded on a boss-kill basis, with each boss awarding a fixed number of points to members in the raid.
      -- Supports an arbitrary number of "point pools"
]]

--[[
dkpinfo table contents for this DKP system:
]]

local AceOO = AceLibrary("AceOO-2.0")
local L = AceLibrary("AceLocale-2.2"):new("Bidder")

local FDKP = AceOO.Class(Bidder_DKP_BaseClass)

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
function FDKP.prototype:FillTooltip(dkpinfo, mypoints)
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
function FDKP.prototype:GetStatusText(dkpinfo)
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
function FDKP.prototype:OnLeftClick(dewOptions, itembutton, dkpinfo)
   -- A left click toggles whether we're bidding on the item
   if dkpinfo.bidplaced then 
      dkpinfo.bidplaced = nil 
   else 
      dkpinfo.bidplaced = true 
   end
   --print ("OnLeftClick")
   --print (tostring(dkpinfo.bidplaced))
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
function FDKP.prototype:OnRightClick(dewOptions, itembutton, dkpinfo)
   -- Points as currency does nothing on a right click
   return false
end

-- Last, but not least, create a FDKP object and register it to Bidder as a DKP system
local FDKPObj = FDKP:new()
Bidder.DKP:Register(FDKPObj, "FDKP", L["Fixed DKP"]) --"Points as Currency")
