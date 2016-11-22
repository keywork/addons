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
   This is an ugly hack to get around a limitation of AceComm-2.0
   The way that AceComm seems to work is that unless an addon has registered
   to send messages with a particular prefix, no addon will recieve messages 
   on that prefix that they've registered to receive. 
   
   Stupid design, if you ask me. It unnecessarily limits the application area
   of the AceComm Library -- without using hacks to get around the bad design.
]]


BidderDKPStub = AceLibrary("AceAddon-2.0"):new("AceComm-2.0")

function BidderDKPStub:OnInitialize()
end

function BidderDKPStub:OnEnable()
   -- Register for communication
   local dkpmon_loaded = GetAddOnMetadata("DKPmon", "X-DkpMonLoaded")
   if dkpmon_loaded == nil then 
      self:SetCommPrefix(Bidder.Comm.DKPmonCommPrefix)
   end
   --[[ 
   self:RegisterComm(self.DKPmonCommPrefix, "GROUP")
   self:RegisterComm(self.DKPmonCommPrefix, "WHISPER")
   self:RegisterComm(self.DKPmonCommPrefix, "GUILD")
   ]]
end

function BidderDKPStub:OnDisable()
end

-- Called by DKPmon to claim the DKPmon message prefix for itself
function BidderDKPStub:DeregisterComm()
   self:SetCommPrefix("BidderDKPStubPrefixCrap")
end

-- Callback for AceComm-2.0
function BidderDKPStub:OnCommReceive()
end
