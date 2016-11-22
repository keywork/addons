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

Bidder = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0", "AceDB-2.0", "AceComm-2.0",  "Metrognome-2.0", "FuBarPlugin-2.0")
local L = AceLibrary("AceLocale-2.2"):new("Bidder")

local BidderDBVer = 2.5

Bidder.DBDefaults = {
   namelist = {},
   dbversion = BidderDBVer
}

Bidder.hasIcon = "Interface\\Addons\\Bidder\\Bidder_icon.tga"
Bidder.cannotDetachTooltip = true
Bidder.cannotHideText = false

function Bidder:OnInitialize()
   self.OnMenuRequest = self.Options.fubar
   -- Set the console commands
   self:RegisterChatCommand({L["/bid"], L["/bidder"]}, self.Options.console)

   -- Called when the addon is loaded
   self:RegisterDB("BidderDB")
   self:RegisterDefaults('realm', self.DBDefaults)
   -- Perform out-of-date database check
   if self.db.realm.dbversion < BidderDBVer then
      -- Database is from a previous version of DKPmon
      -- Need to migrate it over.
      self:Print(L["Database version changed. Migrating to new format."])
      -- Just wipe out the old database.
      --self:TableDelete(self.db.realm)
      self.db.realm = DBDefaults
   end
  
   self:SetCommPrefix(self.Comm.BidderCommPrefix)
   self:RegisterMetro("BidderCommDispatch", function() Bidder.Comm:DispatchMessages() end)
   self:ChangeMetroRate("BidderCommDispatch", 1.0/20) -- Call it 20 times per second

   -- Metrognome for updating when the player's level reads as 0
   self:RegisterMetro("BidderUpdateBadPInfo", function() Bidder:UpdatePlayerInfo() end)
   self:ChangeMetroRate("BidderUpdateBadPInfo", 1.0)

   self.Comm:RegisterCommand("QR", Bidder.ReplyToRaidQuery, Bidder)
   self.Comm:RegisterCommand("QS", Bidder.ReplyToStandbyQuery, Bidder)
end

function Bidder:OnEnable()
   -- Determine whether this character is in the namelist yet.
   --  If it's not, add it.
   local charname = Bidder:GetFixedUpUnitName("player")
--   if self.db.realm.namelist[charname] == nil then
   local _, classname = UnitClass("player")
   local level = UnitLevel("player")
   local race = UnitRace("player")
   --local guild = GetGuildInfo("player")
   self.db.realm.namelist[charname] = { name = charname, class = classname, level = level, race = race, classhex = Bidder:getClassHex(classname) } -- guild = guild, 
--   end
   
   -- Build the Fubar menu for choosing your bidding name
   self:BuildFubarNamelist()
   -- Set the initial bidding name to the character's name
   self:SetBiddingName(charname)
   
   -- Called when the addon is enabled.
   --self:Print("Enabled")
   self.Comm:Enable()
   
   self.onstandby = false

   -- If the level read as zero, start up the PlayerInfo metrognome
   if level == 0 then
      self:StartMetro("BidderUpdateBadPInfo")
   end
end

function Bidder:OnDisable()
   
end

function Bidder:UpdatePlayerInfo()
   local charname = Bidder:GetFixedUpUnitName("player")
--   if self.db.realm.namelist[charname] == nil then
   local _, classname = UnitClass("player")
   local level = UnitLevel("player")
   local race = UnitRace("player")

   if level ~= 0 then
      self.db.realm.namelist[charname].name = charname
      self.db.realm.namelist[charname].level = level
      self.db.realm.namelist[charname].class = classname
      self.db.realm.namelist[charname].race = race
      self.db.realm.namelist[charname].classhex = Bidder:getClassHex(classname)
      self:StopMetro("BidderUpdateBadPInfo")
   end
end

function Bidder:SetBiddingName(name)
   self.biddingname = name
   --    self.myclass = self.db.realm.namelist[name].class
   if self.Looting.biddingOpen then
      self.Comm:SendToDKPmon("QP", self:CharInfoToString(name), self.Looting.lootmaster)
   end
   self.Looting:SetNameplateText()
end

function Bidder:BuildFubarNamelist()
   local validate = {}
   local name
   for name, _ in pairs(self.db.realm.namelist) do
      table.insert(validate, name)
   end
   local tab = { 
      type = 'text', 
      name = L['Set your bidding name'],
      desc = L["Choose the name that you're going to use for bidding."],
      get = function() return Bidder.biddingname end,
      set = function(v) Bidder:SetBiddingName(v) end,
      validate = validate
   }
   self.Options.fubar.args.bidname = tab
end

function Bidder:ReplyToRaidQuery(sender)
   Bidder.Comm:SendToDKPmon("RQR", self:CharInfoToString(self.biddingname), sender)
   return true
end

function Bidder:ReplyToStandbyQuery(sender)
   if self.onstandby then
      local _, class = UnitClass("player")
      Bidder.Comm:SendToDKPmon("RQS", { str = self:CharInfoToString(self.biddingname), c = class }, sender, "GUILD")
   end
   return true
end

--[[ AceDB-2.0 Methods ]]
function Bidder:OnProfileDisable()
   -- Called when the user changes profiles (before change)
end

function Bidder:OnProfileEnable()
   -- Called when the user changes profiles (after change)
   self:SetBiddingName(self.biddingname)
end

--[[
Called when icon is left-clicked
Shows bidding window if bidding is open, otherwise show's dkp
]]
function Bidder:OnClick()
   --Bidder:Print("Left Click Making Com Request")
	if self.Looting.biddingOpen then --and not self.Looting.frame:IsVisible() then

		self.Looting:Show()
	else
		Bidder.Comm:SendToDKPmon("RPDB", Bidder.DKPBrowser.dkpcache.checksum)
	end
end

function Bidder:GetFixedUpUnitName(name)
	if name == nil then
		return name
	else
		local fixedUpUnitName = GetUnitName(name, true)
		if string.match(fixedUpUnitName, "-") then
			return  fixedUpUnitName:gsub("%s+", "")
		else
			local realmName = GetRealmName(name)
			return fixedUpUnitName.."-"..realmName:gsub("%s+", "")
		end
	end
end