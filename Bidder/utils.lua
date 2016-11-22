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
    Generic utility functions
]]

local L = AceLibrary("AceLocale-2.2"):new("Bidder")

function Bidder:TableDelete(tab)
   local k,v
   for k,v in pairs(tab) do
      if type(tab[k]) == "table" then
	 self:TableDelete(tab[k])
      end
      tab[k] = nil
   end
end

-- Returns true if the given name is in our raid, false otherwise
function Bidder:NameInRaid(name)
   local i=1
   while i ~= 41 do
      local raidID = "raid"..i
      local rname = GetRaidRosterInfo(i)
      rname = Bidder:GetFixedUpUnitName("player", true)
      if rname == name then return true; end
      i = i + 1
   end
   return false
end

function Bidder:rgbToHex(rgb)
   return string.format("%02x%02x%02x", rgb.r*255, rgb.g*255, rgb.b*255)
end

function Bidder:getClassHex(class)
   return string.format("%02x%02x%02x", RAID_CLASS_COLORS[class].r*255, RAID_CLASS_COLORS[class].g*255, RAID_CLASS_COLORS[class].b*255)
end

-- serialize the table self.db.realm.namelist[name] into a single string to be sent over the network
-- with less bandwidth usage
-- Returns the string: "<name>|<class>|<level>|<race>"    (omitted: |<guild>)
function Bidder:CharInfoToString(name)
   local tab = self.db.realm.namelist[name]
   if tab == nil then error(L["Name not in database."]); return nil; end
   return string.format("%s|%s|%d|%s", tab.name, tab.class, tab.level, tab.race) -- , tab.guild or "-Not guilded-")
end

