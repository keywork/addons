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
   Class for registering DKP systems to DKPmon
]]

local Registry = { CurrentDKP = { obj = nil, id = nil} , db = {} }
Bidder.DKP = Registry

local AceOO = AceLibrary("AceOO-2.0")
local L = AceLibrary("AceLocale-2.2"):new("Bidder")

--[[
Register
Description:
  Register a DKP system object with DKPmon
Input:
  sysObj -- Class derived from DKPmon_DKP_BaseClass
  sysID -- internal identifier to use to identify this system
  name -- name of the system
Returns:
  None
]]
function Registry:Register(sysObj, sysID, name)
   -- Sanity checking
   if not AceOO.inherits(sysObj, Bidder_DKP_BaseClass) then
      error(string.format(L["Register DKP system -- DKP system with sysID %s does not inherit from the Bidder_DKP_BaseClass object"], tostring(sysID)))
      return
   end
   if type(sysID) ~= "number" and type(sysID) ~= "string" then
      error(L["Register DKP system -- second arg must be a string or number"])
      return
   end
   if self.db[sysID] ~= nil then
      error(string.format(L["Register DKP system -- %s already registered."], tostring(sysID)))
      return
   end
   self.db[sysID] = { obj = sysObj, name = name }
end

--[[
Get
Description:
  Return the object for the current DKP system
Input:
Returns:
  A child class of DKPmon_DKP_BaseClass
]]
function Registry:Get()
   return self.CurrentDKP.obj
end

--[[
GetDKPSystemID
Description:
  Find out the sysID of the currently selected DKP system
Input:
Returns:
  sysID -- The sysID used to register the current DKP system
]]
function Registry:GetDKPSystemID()
   return self.CurrentDKP.id
end

--[[
SetDKPSystem
Description:
  Set the current DKP system to the one registered under the given sysID
Input:
  sysID -- The sysID used to register the desired DKP system
Returns:
  boolean -- true if successful, false otherwise
]]
function Registry:SetDKPSystem(sysID)
   if self.db[sysID] == nil then
      error(string.format(L["DKP System %s not registered."], tostring(sysID)))
      return false
   end
   -- Make sure to clear the looting window, just in case.
   Bidder.Looting:Clear()
   
   self.CurrentDKP.id = sysID
   self.CurrentDKP.obj = self.db[sysID].obj
   return true
end

