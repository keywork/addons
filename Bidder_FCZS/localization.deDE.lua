--[[
    Copyright Daniel D. Neilson, 2006

    This file is part of Bidder_FCZS.

    Bidder_FCZS is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    Bidder_FCZS is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Bidder_FCZS; if not, write to the Free Software
    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
]]

--[[ 
 This translation by Holger Niederschulte
]]


local L = AceLibrary("AceLocale-2.2"):new("Bidder_FCZS")

local translations = {
   ["DKP Cost = %g"] = "DKP Kosten = %g",
   ["Your DKP = %g"] = "Deine DKP = %g",
   ["Bid placed"] = "Gebot gesetzt",
   ["Fixed cost zero-sum"] = "Festpreis-Nullsumme"
}

L:RegisterTranslations("deDE",
		       function() return translations end)