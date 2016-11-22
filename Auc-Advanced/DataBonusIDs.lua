--[[
	Auctioneer
	Version: 7.0.5637 (TasmanianThylacine)
	Revision: $Id: DataBonusIDs.lua 5557 2015-05-13 13:56:40Z brykrys $
	URL: http://auctioneeraddon.com/

	This is an addon for World of Warcraft that adds statistical history to the auction data that is collected
	when the auction is scanned, so that you can easily determine what price
	you will be able to sell an item for at auction or at a vendor whenever you
	mouse-over an item in the game

	License:
		This program is free software; you can redistribute it and/or
		modify it under the terms of the GNU General Public License
		as published by the Free Software Foundation; either version 2
		of the License, or (at your option) any later version.

		This program is distributed in the hope that it will be useful,
		but WITHOUT ANY WARRANTY; without even the implied warranty of
		MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
		GNU General Public License for more details.

		You should have received a copy of the GNU General Public License
		along with this program(see GPL.txt); if not, write to the Free Software
		Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

	Note:
		This AddOn's source code is specifically designed to work with
		World of Warcraft's interpreted AddOn system.
		You have an implicit license to use this AddOn with these facilities
		since that is its designated purpose as per:
		http://www.fsf.org/licensing/licenses/gpl-faq.html#InterpreterIncompat

	Install BonusID data to the core AucAdvanced.Data table

	Implemented as a separate file containg raw bonusID data, for ease of maintenance
	Auctioneer modules will normally compile the raw data into a more useable format, usually during "gameactive" event

	This is not a complete set of all BonusIDs, only a subset that may be of interest to Auctioneer
--]]

if not AucAdvanced then return end
local data = AucAdvanced.Data -- add to existing data table (created in CoreManifest)
if not data then return end

data.BonusSingleSuffixList = {
	486, --Crit
	487, -- Haste
	488, -- Mastery
	489, -- Multistrike
	490, -- Versatility
	491, -- Bonus Armor
	492, -- Spirit
}
-- BonusIDs representing pairs of secondary stats are not included (there are 420 of them)
-- instead Auctioneer handles suffixes with a dedicated function, AucAdvanced.API.GetNormalizedBonusIDSuffix

data.BonusPrimaryStatList = {
	517, -- +Agi
	550, -- +Str
	551, -- +Int
}

data.BonusTierList = {
	545, -- Epic upgrade
	566, -- Heroic
	567, -- Mythic
}

data.BonusCraftedStageList = {
	525, -- Stage 1 (basic item)
	526, -- Stage 2
	558, -- Stage 2
	527, -- Stage 3
	559, -- Stage 3
	593, -- Stage 4
	594, -- Stage 4
	617, -- Stage 5
	619, -- Stage 5
	618, -- Stage 6
	620, -- Stage 6
}

data.BonusWarforgedList = {
	560,
	561, -- Heroic
	562, -- Mythic
}

data.BonusSocketedList = {
	563,
	564, -- Heroic
	565, -- Mythic
}

data.BonusTertiaryStatList = {
	40, -- Avoidance
	41, -- Leech
	42, -- Speed
	43, -- Indestructible
}

AucAdvanced.RegisterRevision("$URL: http://svn.norganna.org/auctioneer/trunk/Auc-Advanced/DataBonusIDs.lua $", "$Rev: 5557 $")
