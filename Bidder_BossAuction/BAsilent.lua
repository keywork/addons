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

local BADKP = AceOO.Class(Bidder_DKP_BaseClass,"AceEvent-2.0","AceDebug-2.0")
--common functions
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
	local minbid = dkpinfo.minbid
	local mydkp = mypoints[dkpinfo.poolIndex]
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
   --All information is available on the button
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
	--[[
		{poolIndex, minbid, plus added info}
		dkp info contains
		mybid - num
		roundNum - num
		roundContinues -boolean
		lastBids - num
		lastCost - num
		roundTimer (ScheduledEvent ID)
		biddingOpen - boolean
	   ]]
   local itembutton = Bidder.Looting.itembuttons[dkpinfo.itemId]

	if itembutton then
		local r,g,b
		local dkpText,bidText,costText = self:GetButtonTexts(itembutton)
		--DKP Text
		local mypoints = Bidder.Looting.mypoints
		if mypoints ~= nil then
			local poolnames = Bidder.DKPBrowser.dkpinfo.poolnames
			local poolName = ""
			if poolnames then
				poolName = poolnames[dkpinfo.poolIndex]
			end 
			dkpText:SetText(string.format(L["You have %g %s points"],mypoints[dkpinfo.poolIndex],poolName))
		end  	
      -- Cost Text
      if dkpinfo.lastBids and dkpinfo.lastBids > 0 then
         if dkpinfo.mybid and dkpinfo.mybid == dkpinfo.lastCost and dkpinfo.lastTied then
            costText:SetText(string.format(L["Tied Last %g"],dkpinfo.lastCost))
				_,r,g,b = PC:GetRGBPercent("contested")				
            costText:SetTextColor(r,g,b)
         else
            costText:SetText(string.format(L["Last %g"],dkpinfo.lastCost))
				_,r,g,b = PC:GetRGBPercent("normal")
				costText:SetTextColor(r,g,b)				
         end         
         costText:Show()         
      else
         costText:SetText(string.format(L["Min %g"],dkpinfo.minbid))
			_,r,g,b = PC:GetRGBPercent("normal")
			costText:SetTextColor(r,g,b)			
         costText:Show()                  
      end
     -- My bid text
      if dkpinfo.mybid then         
         bidText:SetText(string.format(L["Bid %g"],dkpinfo.mybid))         
         if dkpinfo.lastCost then
            if dkpinfo.mybid < dkpinfo.lastCost 
                  or (dkpinfo.mybid == dkpinfo.lastCost and dkpinfo.lastTied) then
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
   end
      
	local statusText = ""	
   
   -- Small Yellow text
	if not dkpinfo.biddingOpen then
		self:Debug("bidding not open")
		if dkpinfo.lastBids ~= nil then
			statusText = statusText..string.format(L["%d bids, final cost: %g"],dkpinfo.lastBids,dkpinfo.lastCost)
		end		
	else
		if dkpinfo.round ~= nil then
			statusText = statusText..string.format(L["Round %d/%d next in "],dkpinfo.round,dkpinfo.numRounds)
		end
	
		local timeLeft
		_, timeLeft = self:IsEventScheduled(dkpinfo.roundTimer)
		if timeLeft~=nil then
			statusText = statusText..ceil(timeLeft)
		end
      
      if dkpinfo.lastBids then
         statusText = statusText..string.format(L["  (%d bids)"],dkpinfo.lastBids)
	   end
	end

   return statusText
end

function BADKP.prototype:StartRoundTimer(itemIndex,roundTime)
	--self:ScheduleRepeatingEvent(self.roundTimer, self.RoundExpired,silentrounds[self.currentRound],self)
	--isScheduled, timeLeft = self:IsEventScheduled(self.periodicEventId)
	--self:CancelScheduledEvent(self.roundTimer)
	self:Debug("starting round timer")
	local itembutton = Bidder.Looting.itembuttons[itemIndex]
	--debug
	--Bidder.Looting.itembuttons[1].dkpinfo
	local dkpinfo = itembutton.dkpinfo	
	local timerId = "DKPmon_BossAuction_item"..itemIndex
	dkpinfo.roundTimer = timerId	
	self:KillExistingTimers(itemIndex)			
	self:ScheduleRepeatingEvent(timerId, self.TimerExpired, roundTime,self,itemIndex)
	self:ScheduleRepeatingEvent(timerId.."sec", self.UpdateTimer,1,self, itemIndex)	
	itembutton:UpdateStatusText()
end

--it passes dkpinfo automatically!?
--when i put itembutton in there it confused acecomm

--Called every second to update text
function BADKP.prototype:UpdateTimer(itemIndex)
 	if not Bidder.Looting.biddingOpen then
		--Kill all timers
		self:CancelAllScheduledEvents()
		return
	end
	
	local itembutton = Bidder.Looting.itembuttons[itemIndex]
	if not itembutton.dkpinfo.biddingOpen then
		self:Debug("Bidding not open, ending timers")
		self:TimerExpired(itemIndex)		
		return
	end
	itembutton:UpdateStatusText()
	
end

--Called when round timer expires
function BADKP.prototype:TimerExpired(itemIndex)
	if not Bidder.Looting.biddingOpen then
		--Kill all timers
		self:CancelAllScheduledEvents()
		return
	end
		
	local itembutton = Bidder.Looting.itembuttons[itemIndex]
	self:Debug("TimerExpired() ending bidder timer events for item")
	self:KillExistingTimers(itemIndex)
	itembutton:UpdateStatusText()	
end

function BADKP.prototype:KillExistingTimers(itemIndex)
	local timerId = "DKPmon_BossAuction_item"..itemIndex
	if self:IsEventScheduled(timerId) then
		self:CancelScheduledEvent(timerId)
	end
	if self:IsEventScheduled(timerId.."sec") then
		self:CancelScheduledEvent(timerId.."sec")
	end			
end

-- Last, but not least, create a BADKP object and register it to Bidder as a DKP system
local BADKPObj = BADKP:new()
Bidder.DKP:Register(BADKPObj, "BossAuctionSilent", L["Boss Auction: Silent Bid"])


--------------------
-- Comm Functions --
--------------------
--[[
DKPmon.Comm:SendToBidder("BADKPS_ER", { item = itembutton.id, bids = numBids, cost = highCost })
DKPmon.Comm:SendToBidder("BADKPS_NR", { item = itembutton.id, time=silentrounds[self.currentRound]})
DKPmon.Comm:SendToBidder("BADKPS_RC", { item = itembutton.id })
]]


function BADKPObj:ReceiveNewRound(sender,params)
--	if not self:IsDebugging() then
--		self:SetDebugging(true)
--		self:Debug("Bidder_BossAuction silent bid debugging on")
--	end
	
	self:Debug("ReceiveNewRound")
	local itembutton = Bidder.Looting.itembuttons[params.item]
	if itembutton == nil or not Bidder.Looting.biddingOpen then		
		--this happens at the beginning as it loads the buttons
		self:Debug("itembutton nil, trying again in 0.1 sec")
		self:ScheduleEvent(self.ReceiveNewRound,0.1,self,sender,params)
		return true
	end
	
	self:Debug("round initializing")
	local dkpinfo = itembutton.dkpinfo
	dkpinfo.round = params.round
	dkpinfo.numRounds = params.numRounds
	dkpinfo.biddingOpen = true
 	self:StartRoundTimer(params.item,params.time)	
	return true
end
Bidder.Comm:RegisterCommand("BADKPS_NR", BADKPObj.ReceiveNewRound, BADKPObj)

function BADKPObj:ReceiveEndRound(sender,params)
	self:Debug("ReceiveEndRound")
	local itembutton = Bidder.Looting.itembuttons[params.item]
	if itembutton == nil then
		self:KillExistingTimers(params.item)
		return true
	end
	
	local dkpinfo = itembutton.dkpinfo
	
	dkpinfo.lastBids = params.bids
	dkpinfo.lastCost = params.cost
   dkpinfo.lastTied = params.tied
	self:Debug(string.format("end round biddingOpen = false, bids %d, cost %g,tied %s",
	   dkpinfo.lastBids,dkpinfo.lastCost,dkpinfo.lastTied and "true" or "false"))
	dkpinfo.biddingOpen = false
	self:KillExistingTimers(params.item)
	itembutton:UpdateStatusText()
	return true
end
Bidder.Comm:RegisterCommand("BADKPS_ER", BADKPObj.ReceiveEndRound, BADKPObj)

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
	
   -- I was removed
   if params.removed and params.removed == Bidder.biddingname then
		Bidder:Print(string.format(L["Your bid on item %g was removed by the dkp manager."],params.item))
		dkpinfo.mybid = nil
		itembutton:UpdateStatusText()
		local f = itembutton.bidEntryFrame
		if f ~= nil then
			f:SetText("")
		end
   end
   return true
end
Bidder.Comm:RegisterCommand("BADKPS_RB", BADKPObj.ReceiveRemoveBid, BADKPObj)

gBADKP = nil

