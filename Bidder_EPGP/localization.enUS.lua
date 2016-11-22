--[[
    Lack of Copyright Karl Schmidt, 2007

    This file is part of Bidder_EPGP.

    DKPmon_EPGP is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    DKPmon_EPGP is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with DKPmon_EPGP; if not, write to the Free Software
    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
    
    Many thanks to Daniel D. Neilson for Bidder_FCZS and Arlo White for 
    Bidder_BossAuction, whose coding work I am shamelessly ripping off and
    without whom Bidder_EPGP would not be here
]]

local L = AceLibrary("AceLocale-2.2"):new("Bidder_EPGP")

local translations = {
   ["GP Value = %g"] = true,
   ["Your Priority Value (EP/GP) = %g"] = true,
   ["Need bid placed"] = true,
   ["Greed bid placed"] = true,
   ["Effort Points/Gear Points"] = true
}

L:RegisterTranslations("enUS",
		       function() return translations end)