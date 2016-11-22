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

local translations = {
   ["Bidder"] = true,

   -- Lootframe
   ["Bidding with name: |cff%s%s|r"] = true,

   -- Options table: Console commands
   ["query"] = true,
   ['Query the raid leaders for your current points.'] = true,
   ["showdkp"] = true,
   ["Browse your raid's DKP standings."] = true,
   ["show"] = true,
   ["Show the bidding window."] = true,
   ["togglestandby"] = true,
   ['Toggle whether you are on standby.'] = true,
   ['modules'] = true,
   ['List the DKP system modules you have installed.'] = true,
   ['Modules installed:'] = true,

   -- Options table: Fubar items
   ['Query points'] = true,
   ['Query the raid leaders for your current points.'] = true,
   ['Show DKP'] = true,
   ["Browse your raid's DKP standings."] = true,
   ['Show window'] = true,
   ['Show the bidding window.'] = true,
   ['Raid standby'] = true,
   ['Toggle whether you are on standby.'] = true,

   -- Communications
   ["Communications command %s already registered."] = true,
   ["Expected function for dispatchfunc, got %s instead."] = true,
   
   -- Main:
   ["/bid"] = true,
   ["/bidder"] = true,
   ["Database version changed. Migrating to new format."] = true,
   ["Set your bidding name"] = true,
   ["Choose the name that you're going to use for bidding."] = true,

   -- DKP system registry
   ["Register DKP system -- DKP system with sysID %s does not inherit from the Bidder_DKP_BaseClass object"] = true,
   ["Register DKP system -- second arg must be a string or number"] = true,
   ["Register DKP system -- %s already registered."] = true,
   ["DKP System %s not registered."] = true,

   -- Fixed DKP module
   ["DKP Cost = %g"] = true,
   ["Your DKP = %g"] = true,
   ["Bid placed"] = true,
   ["Fixed DKP"] = true,

   -- DKP browser
   ["Player"] = true,
   ["Class"] = true,
   ["Name"] = true,
   ["Primary sort key"] = true,
   ["Select the primary sorting key"] = true,
   ['Secondary sort key'] = true,
   ['Select the secondary sorting key'] = true,
   ['Teriary sort key'] = true,
   ['Select the teriary sorting key'] = true,
   ['Classes to display'] = true,
   ["Select the classes to display in the DKP standings"] = true,
   ["Druid"] = true, ["Show druids"] = true,
   ["Hunter"] = true, ["Show hunters"] = true,
   ["Monk"] = true, ["Show monks"] = true,
   ["Mage"] = true, ["Show mages"] = true,
   ["Paladin"] = true, ["Show paladins"] = true,
   ["Priest"] = true, ["Show priests"] = true,
   ["Rogue"] = true, ["Show rogues"] = true,
   ["Shaman"] = true, ["Show shaman"] = true,
   ["Warlock"] = true, ["Show warlocks"] = true,
   ["Warrior"] = true,  ["Show warriors"] = true,
   ["Bidder: DKP Standings Browser"] = true,
   ["right-click for options"] = true,
   ["Scroll Left"] = true, ["Scroll Right"] = true,
   ["Error -- received message to display DKP browser with wrong checksum (%g)"] = true,
   
   -- Utils
   ["Name not in database."] = true,
}

L:RegisterTranslations("enUS",
		       function() return translations end)