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
   The "base class" for all DKP systems
]]

local AceOO = AceLibrary("AceOO-2.0")

Bidder_DKP_BaseClass = AceOO.Interface ( { FillTooltip = "function", 
                                           GetStatusText = "function",
                                           OnLeftClick = "function",
                                           OnRightClick = "function" } )

--  Function prototypes

--[[
FillTooltip()
Description:
  Called when an item in the Bidding Window is moused over to add the DKP-system specific information to the GameTooltip for the moused over item
Input:
  dkpinfo -- table; same table returned from DKPmon:GetItemInfo() plus whatever else the DKP system added to track bidding
  mypoints -- table; This is the points table returned by the "RQP" communications command
Returns:
  Nothing
]]

--[[
GetStatusText
Description:
  Return the status line text, for the LootItem button, of the item with the given dkpinfo
Input:
  dkpinfo -- table;  same table returned from DKPmon:GetItemInfo() plus whatever else the DKP system added to track bidding
Returns:
  String -- the text to be displayed; -cannot- be nil
]]

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
