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

local L = AceLibrary("AceLocale-2.2"):new("Bidder")

-- Ace Options table for the console commands & fubar menu
Bidder.Options = {}

-- Options table for the console commands
Bidder.Options.console = {
   type = 'group',
   args = {
      query = {
	 type = 'execute',
	 name = L['query'],
	 desc = L['Query the raid leaders for your current points.'],
	 func = function() Bidder.Comm:SendToDKPmon("QC", Bidder.biddingname) end
      },
      showdkp = {
	 type = 'execute',
	 name = L['showdkp'],
	 desc = L["Browse your raid's DKP standings."],
	 func = function() Bidder.Comm:SendToDKPmon("RPDB", Bidder.DKPBrowser.dkpcache.checksum) end
      },
      show = {
	 type = 'execute',
	 name = L['show'],
	 desc = L['Show the bidding window.'],
	 func = function() if Bidder.Looting.biddingOpen then Bidder.Looting:Show() end end
      },
      gostandby = {
	 type = 'toggle',
	 name = L['togglestandby'],
	 desc = L['Toggle whether you are on standby.'],
	 get = function() return Bidder.onstandby end,
	 set = function(v) Bidder.onstandby = v end
      },
      modules = {
         type = 'execute',
	 name = L['modules'],
	 desc = L['List the DKP system modules you have installed.'],
         func = function()
                   local modules = Bidder.DKP.db
                   local id, tab
                   Bidder:Print(L['Modules installed:'])
                   for id, tab in pairs(modules) do
                       Bidder:Print(tab.name)
                   end
                end
      }
   }
}

-- Options table for the fubar menu
Bidder.Options.fubar = {
   type = 'group',
   args = {
      query = {
	 type = 'execute',
	 name = L['Query points'],
	 desc = L['Query the raid leaders for your current points.'],
	 func = function() Bidder.Comm:SendToDKPmon("QC", Bidder.biddingname) end,
	 order = 2
      },
      showdkp = {
	 type = 'execute',
	 name = L['Show DKP'],
	 desc = L["Browse your raid's DKP standings."],
	 func = function() Bidder.Comm:SendToDKPmon("RPDB", Bidder.DKPBrowser.dkpcache.checksum) end,
	 order = 3
      },
      show = {
	 type = 'execute',
	 name = L['Show window'],
	 desc = L['Show the bidding window.'],
	 func = function() if Bidder.Looting.biddingOpen then Bidder.Looting:Show() end end,
	 order = 1
      },
      gostandby = {
	 type = 'toggle',
	 name = L['Raid standby'],
	 desc = L['Toggle whether you are on standby.'],
	 get = function() return Bidder.onstandby end,
	 set = function(v) Bidder.onstandby = v end,
	 order = 4
      }
   }
}
