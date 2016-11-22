--[[
	Adopted for BossAuction by Arlo White aka Javek.
	
	Largely inherited from Bidder_ZSumAuction.
	Inherits GPL.
	
    Copyright Daniel D. Neilson, 2006

    This file is part of Bidder_ZSumAuction.

    Bidder_ZSumAuction is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    Bidder_ZSumAuction is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Bidder_ZSumAuction; if not, write to the Free Software
    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
]]

local L = gBADKP.L
local AceOO = gBADKP.AceOO
local PC = gBADKP.PC

local BADKP = AceOO.Class(Bidder_DKP_BaseClass)
--Common functions
BADKP.prototype.GetPlayerClass=gBADKP.GetPlayerClass
BADKP.prototype.OnLeftClick=gBADKP.OnLeftClick
BADKP.prototype.OnRightClick=gBADKP.OnRightClick
BADKP.prototype.GetButtonTexts=gBADKP.GetButtonTexts

--[[
  dkpInfo table:
    minbid -- number; minimum allowed bid on the item
    poolIndex -- number; pool from which to deduct points for the item
    mybid -- number; nil -> no bid, else value of the bid placed by the user
    highbid - number; value of the highest bid placed on the item. nil -> no bid placed yet
    highwho - string; name of the player with the highest bid
  
  (minbid & poolIndex added by BossAuction)
]]

function BADKP.prototype:IsBidValid(Val,dkpinfo)
	local mypoints = Bidder.Looting.mypoints
	local high = dkpinfo.highbid
	if high == nil then high = 0 end
	local minbid = dkpinfo.minbid
	local mydkp = mypoints[dkpinfo.poolIndex]

	if dkpinfo.mybid and Val <= dkpinfo.mybid then
		Bidder:Print(string.format(L["You must bid higher than your last bid of %g."],dkpinfo.mybid) )
	 	return false
	end
	if Val < minbid then
	 	if mydkp < minbid then
	 		Bidder:Print(string.format(L["You don't have enough dkp for the minimum bid of %g.  However, you may bid the minimum bid and go negative."],minbid))
		 	return false
	 	else
		 	Bidder:Print(string.format(L['The minimum bid is %g dkp.'],minbid) )
		 	return false
	 	end
 	end
	--Can always bid the min bid and go negative
	if Val ~= minbid and Val > mydkp then
	 	Bidder:Print(string.format(L["You only have %g dkp."],mydkp) )
	 	return false
	end
	if Val < high then 
	 	Bidder:Print(string.format(L['Note: You are under the high bid of %g'],high))
	end
 	-- set mybid so it doesn't revert in the dewdrop menu
	dkpinfo.mybid = Val
 	return true
end

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
function BADKP.prototype:FillTooltip(dkpinfo, mypoints)
   if dkpinfo.contested then
   	GameTooltip:AddLine(" ")
		GameTooltip:AddLine( string.format(L["Multiple winners |cFF%s(Contested)|r"],PC:GetHex("contested") ), 1.0, 0.819, 0.0)
		for _, name in ipairs(dkpinfo.contested) do
			GameTooltip:AddLine( string.format("|cFF%s%s|r", PC:GetHex(self:GetPlayerClass(name)), name) )
   	end
   end
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
function BADKP.prototype:GetStatusText(dkpinfo)
	--dkpinfo {poolIndex, minbid, plus added info}
	
	local itembutton = Bidder.Looting.itembuttons[dkpinfo.itemId]
	
	if itembutton then
		local r,g,b
		local dkpText,bidText,costText = self:GetButtonTexts(itembutton)
		
		-- DKP Text
		local mypoints = Bidder.Looting.mypoints
		if mypoints then
			local poolnames = Bidder.DKPBrowser.dkpinfo.poolnames
			local poolName = ""
			if poolnames then
				poolName = poolnames[dkpinfo.poolIndex]
			end 
			dkpText:SetText(string.format(L["You have %g %s points"],mypoints[dkpinfo.poolIndex],poolName))
		end
		
		-- My Bid
		if dkpinfo.mybid then
			bidText:SetText(string.format(L["Bid %g"],dkpinfo.mybid))
			
			if dkpinfo.highbid and dkpinfo.highbid == dkpinfo.mybid then
				if dkpinfo.contested then
					_,r,g,b = PC:GetRGBPercent("contested")
					bidText:SetTextColor(r,g,b)							
				else
					_,r,g,b = PC:GetRGBPercent("winner")
					bidText:SetTextColor(r,g,b)
				end				
			else
				_,r,g,b = PC:GetRGBPercent("normal")
				bidText:SetTextColor(r,g,b)					
			end
			bidText:Show()
		else
			bidText:Hide()
		end
		
		-- High Bid
		if dkpinfo.highbid then
			costText:SetText(string.format(L["High %g"],dkpinfo.highbid))
			if dkpinfo.contested then
				_,r,g,b = PC:GetRGBPercent("contested")
				costText:SetTextColor(r,g,b)
			else
				_,r,g,b = PC:GetRGBPercent("high")
				costText:SetTextColor(r,g,b)
			end
		else
			--no bids
			costText:SetText(string.format(L["Min %g"],dkpinfo.minbid))
			_,r,g,b = PC:GetRGBPercent("normal")
			costText:SetTextColor(r,g,b)			
		end
	end
	
	local statusText
   if dkpinfo.highbid then
		statusText = string.format(L["Winner: |cFF%s%s|r"], 
			PC:GetHex(self:GetPlayerClass(dkpinfo.highwho)), dkpinfo.highwho)
   else
	   statusText = L["No bids."]
	end
	   
   return statusText
end

-- Last, but not least, create a BADKP object and register it to Bidder as a DKP system
local BADKPObj = BADKP:new()
Bidder.DKP:Register(BADKPObj, "BossAuction", L["Boss Auction: Open Bid"])

-- Register our special communication for when a new bid is placed on an item.
-- This communication command is sent from DKPmon whenever a new bid is received on an item
-- Params:
--   Table with fields:
--   item -- number; index of the item the bid is for
--   bid -- number; amount of the bid
--   bidder -- string; name of the person who placed the bid
--   contested -- table; list of people who share the high bid on an item

function BADKPObj:ReceiveNewBid(sender, params)
   local itembutton = Bidder.Looting.itembuttons[params.item]
   local dkpinfo = itembutton.dkpinfo

   if params.bid > (dkpinfo.highbid or 0) then
      dkpinfo.highbid = params.bid
      dkpinfo.highwho = params.bidder
   end
   if params.bidder == Bidder.biddingname then
      dkpinfo.mybid = params.bid
   end
   dkpinfo.contested = params.contested
   itembutton:UpdateStatusText()
   return true
end
Bidder.Comm:RegisterCommand("BADKP_RNB", BADKPObj.ReceiveNewBid, BADKPObj)


-- Register our special communication for when the auctioneer removes a bidder from the list.
-- This command will be sent informing all of the bidders that there is a new minimum bid
-- that is likely to be lower than the previous min bid.
-- Params:
--   Table with fields:
--     item -- number; index of the item the bid is for
--     bid -- number; amount of the new min bid
--     bidder -- string OR nil; name of the person who placed the bid, nil if there is no min bidder anymore.
function BADKPObj:ReceiveRemoveBid(sender, params)
   local itembutton = Bidder.Looting.itembuttons[params.item]
   local dkpinfo = itembutton.dkpinfo

   dkpinfo.highbid = params.bid
   dkpinfo.highwho = params.bidder
   dkpinfo.contested = params.contested
   
   -- I was removed
   if params.removed and params.removed == Bidder.biddingname then
   		Bidder:Print(string.format(L["Your bid on item %g was removed by the dkp manager."],params.item))
   		dkpinfo.mybid = nil
		local f = itembutton.bidEntryFrame
		if f ~= nil then
			f:SetText("")
		end		
   end
   --If no bids now or the highbid is below our old one reset our bid
   if dkpinfo.highbid == nil or (dkpinfo.mybid and dkpinfo.highbid <= dkpinfo.mybid) then
   		dkpinfo.mybid = nil
   end
   --I'm the new high bidder
   if params.bidder ~= nil and params.bidder == Bidder.biddingname then
      dkpinfo.mybid = params.bid
   end
   itembutton:UpdateStatusText()
   return true
end
Bidder.Comm:RegisterCommand("BADKP_RB", BADKPObj.ReceiveRemoveBid, BADKPObj)
