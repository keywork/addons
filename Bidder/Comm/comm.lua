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
    All messages sent to/from DKPmon & Bidder have the following form in their parameters:
        param1 = number -- communication protocol version
        param2 = string -- target of the communication; "~all" for sending to everyone, name of the target player otherwise
        param3 = string -- communication command (ex: "OB" for "open bidding")
        param4 = parameters for the communication; can be a table, string, number, whatever
]]

local L = AceLibrary("AceLocale-2.2"):new("Bidder")

local Comm = {
   DKPmonCommPrefix = "DKPmon",
   DKPmonCommVer = 2.1,
   BidderCommPrefix = "Bidder",
   BidderCommVer = 2.1,
   queue = {},
   dispatchtable = {}, -- indexed by communication command, each element is a table:
   -- { func = the function to call to dispatch the command. This function must return true if the command was successfully dispatched, false if the command should be requeued.
   --   self = the object to pass as "self" }
   tablepool = {}
}
Bidder.Comm = Comm

-- Called from DKPmon:Enable() to initialize the comm system
function Comm:Enable()
   -- Register to receieve messages from DKPmon over GROUP/GUILD
   Bidder:RegisterComm(self.DKPmonCommPrefix, "GROUP")
   Bidder:RegisterComm(self.DKPmonCommPrefix, "GUILD")

   RegisterAddonMessagePrefix(self.DKPmonCommPrefix)
   RegisterAddonMessagePrefix(self.BidderCommPrefix)
   
   Bidder:StartMetro("BidderCommDispatch")
end

-- Register a communications command
-- If dispatchfunc is a member function of some table, then dispatchself must be that table
-- otherwise, the presence of the "self" parameter will mess all sorts of things up
function Comm:RegisterCommand(command, dispatchfunc, dispatchself)
   if self.dispatchtable[command] ~= nil then
      error(string.format(L["Communications command %s already registered."], command))
      return
   end
   if type(dispatchfunc) ~= "function" then
      error(string.format(L["Expected function for dispatchfunc, got %s instead."], type(dispatchfunc)))
   end
   self.dispatchtable[command] = { func = dispatchfunc, self = dispatchself }
end

--[[
GetTable
Description:
  Get a table from the table pool, or create one if the pool's empty
]]
function Comm:GetTable()
   local tab = table.remove(self.tablepool)
   if tab == nil then tab = {} end
   return tab
end

--[[
ReturnTable
Description:
  Return a table to the table pool
]]
function Comm:PoolTable(tab)
   table.insert(self.tablepool, tab)
end

--[[
SendToDKPmon
Description:
  Send the given message to other DKPmon addons via the desired addon channel.
Input:
  target -- either nil (for sending to all), or the name of a player to send the message to
  command -- string; the command being sent
  parameters -- the parameters for the command
  channel -- "GROUP", "GUILD" or nil (nil implies "GROUP"); the channel to send the message over
Output:
  None
]]
function Comm:SendToDKPmon(command, parameters, target, channel)
  if (command ~= "L") then
    --print("Send " .. command .. " to DKPMon in Bidder targeting " .. tostring(target) .. " in channel " .. tostring(channel))
  end
    --Bidder:Print("Sending Comm: "..command)
   if target == nil then target = "~all" end
   if channel == nil then channel = "GROUP" end
   --Bidder:Print("Targeting: "..target)
   local sent = Bidder:SendCommMessage(channel, self.DKPmonCommVer, target, command, parameters)
   if sent == true then
     --Bidder:Print("We are Sent") 
  end
   if sent == true and (target == "~all" or target == Bidder:GetFixedUpUnitName("player", true)) then
      if DKPmon ~= nil then
        if (command ~= "L") then
         --Bidder:Print("Bidder Send To DKPmon " .. command .. " Sent - now commReceive")
       end
	       DKPmon:OnCommReceive(self.DKPmonCommPrefix, Bidder:GetFixedUpUnitName("player", true), channel, self.DKPmonCommVer, target, command, parameters)
      else
        --Bidder:Print("No Send 1")
      end
   else
      --Bidder:Print("No Send")
   end
end

--[[
SendToBidder
Description:
  Send the given message to other Bidder addons via the desired addon channel.
Input:
  target -- either nil (for sending to all), or the name of a player to send the message to
  command -- string; the command being sent
  parameters -- the parameters for the command
  channel -- "GROUP", "GUILD" or nil (nil implies "GROUP"); the channel to send the message over
Output:
  None
]]
function Comm:SendToBidder(command, parameters, target, channel)
  --Bidder:Print("Receiving Command: "..command)
  if (command ~= "L") then
    --print("Send " .. command .. " to Bidder in Bidder targeting " .. tostring(target) .. " in channel " .. tostring(channel))
  end
   if target == nil then target = "~all" end
   if channel == nil then channel = "GROUP" end
   local sent = Bidder:SendCommMessage(channel, self.BidderCommVer, target, command, parameters)
   if sent == true and (target == "~all" or target == Bidder:GetFixedUpUnitName("player", true)) then
      if (command ~= "L") then
        --Bidder:Print("Bidder Send To Bidder " .. command .. " Sent - now commReceive")
      end
      self:OnCommReceive(self.DKPmonCommPrefix, Bidder:GetFixedUpUnitName("player",true), channel, self.BidderCommVer, target, command, parameters)
   end
end

function Comm:EchoString(sender, msg)
   Bidder:Print(msg)
   return true
end
Comm:RegisterCommand("M", Comm.EchoString, Comm)

--[[
DispatchMessages
Description:
  Called multiple times per second, via a metrognome, to dispatch queued receieved messages
Input:
  None
Output:
  None
]]
function Comm:DispatchMessages()
   local cmd = table.remove(self.queue,1)
   local requeue = nil
   while cmd ~= nil do
      if self.dispatchtable[cmd.cmd] ~= nil then
	 local f, s = self.dispatchtable[cmd.cmd].func, self.dispatchtable[cmd.cmd].self
	 local ret
	 if s ~= nil then ret = f(s, cmd.sender, cmd.params)
	 else ret = f(cmd.sender, cmd.params)
	 end
	 if ret ~= true then
	    if requeue == nil then requeue = {} end
	    table.insert(requeue, cmd)
	 else
	    self:PoolTable(cmd)
	 end
      else
	 -- unregistered command was received. Just silently ignore it.
	 self:PoolTable(cmd)
      end
      cmd = table.remove(self.queue, 1)
   end
   if requeue ~= nil then self.queue = requeue end
end

--[[
AceComm-2.0 message receiving callback
]]
function Comm:OnCommReceive(prefix, sender, distribution, ver, target, command, parameters)
    if (command ~= "L") then
      --Bidder:Print("Bidder CommReceive Got message to "..target.." " .. Bidder:GetFixedUpUnitName("player", true).. " from "..sender.." with command "..command.." and parameter type "..type(parameters))
    end
   -- Check the target
   if target ~= "~all" and target ~= Bidder:GetFixedUpUnitName("player", true) then 
      return 
   end
   -- Queue the message if the communication protocol's compatible
   if (prefix == self.DKPmonCommPrefix and ver == self.DKPmonCommVer) then
      --print "Message Queued"
      -- (prefix == self.BidderCommPrefix and ver == self.BidderCommVer) then (Bidder doesn't care about Bidder messages)
      local tab = self:GetTable()  
      tab.sender = sender
      tab.cmd = command
      tab.params = parameters
      table.insert(self.queue, tab)
      return
   end
end

function Bidder:OnCommReceive(prefix, sender, distribution, ver, target, command, parameters)
   --Bidder:Print("Got message to "..target.." from "..sender.." with command "..command.." and parameter type "..type(parameters))
   self.Comm:OnCommReceive(prefix, sender, distribution, ver, target, command, parameters)
end
