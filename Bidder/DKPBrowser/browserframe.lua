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

local BrowserFrame = {
   frame = nil,
   headerline = nil,
   headertext = {
      name = L["Player"],
      namecolour = Bidder:rgbToHex({r=1.0,g=0.819,b=0}),
      dkpcolour = Bidder:rgbToHex({r=1.0,g=0.819,b=0}),
      dkp = nil
   },
   dkplines = nil,
   nshowing = 0, -- How many lines we're displaying
   sortkeys = {
      [1] = "Class",
      [2] = "Name",
      [3] = "p1"
   },
   udscrollpos = 0, -- Up/down scroll position
   maxscroll = 0,

   dkpinfo = { -- Table of DKP information to display, in the order we wish to display it.
      npools = nil,
      poolnames = nil,
      db = nil
   },

   dkpcache = {
      checksum = nil,
      npools = nil,
      poolnames = nil,
      db = nil
   }
}
Bidder.DKPBrowser = BrowserFrame

Bidder.DBDefaults.DKPBrowser = {
   pos = {  x = (UIParent:GetWidth() / 2), y = (UIParent:GetHeight() / 2) },
   filters = { -- start off filtering nothing
   }
}

local MaxLinesToShow = 25

local dewdrop = AceLibrary("Dewdrop-2.0")
local validSorts = {
   ["Class"] = L["Class"], ["Name"] = L["Name"],
}
local dewOptions = {
   type = 'group',
   args = {
      sortkey1 = {
	 type = 'text', name = L['Primary sort key'],
	 desc = L['Select the primary sorting key'],
	 get = function() 
		  return BrowserFrame.sortkeys[1]
	       end,
	 set = function(v)
		  BrowserFrame.sortkeys[1] = v
		  BrowserFrame:ResortDKP(self)
	       end,
	 validate = validSorts,
	 order = 1
      },
      sortkey2 = {
	 type = 'text', name = L['Secondary sort key'],
	 desc = L['Select the secondary sorting key'],
	 get = function() 
		  return BrowserFrame.sortkeys[2]
	       end,
	 set = function(v)
		  BrowserFrame.sortkeys[2] = v
		  BrowserFrame:ResortDKP(self)
	       end,
	 validate = validSorts,
	 order = 2
      },
      sortkey3 = {
	 type = 'text', name = L['Teriary sort key'],
	 desc = L['Select the teriary sorting key'],
	 get = function() 
		  return BrowserFrame.sortkeys[3]
	       end,
	 set = function(v)
		  BrowserFrame.sortkeys[3] = v
		  BrowserFrame:ResortDKP()
	       end,
	 validate = validSorts,
	 order = 3
      },
      filters = {
	 type = 'group',
	 name = L['Classes to display'],
	 desc = L["Select the classes to display in the DKP standings"],
	 args = {
	    druid = {
	       type = 'toggle', name = L["Druid"], desc = L["Show druids"],
	       get = function() return not Bidder.db.realm.DKPBrowser.filters["DRUID"] end,
	       set = function(v) 
			Bidder.db.realm.DKPBrowser.filters["DRUID"] = not v
			BrowserFrame:CopyDKPInfo()
			BrowserFrame:ResortDKP()
			BrowserFrame:Show()
		     end,
	       order = 1
	    },
	    hunter = {
	       type = 'toggle', name = L["Hunter"], desc = L["Show hunters"],
	       get = function() return not Bidder.db.realm.DKPBrowser.filters["HUNTER"] end,
	       set = function(v) 
			Bidder.db.realm.DKPBrowser.filters["HUNTER"] = not v
			BrowserFrame:CopyDKPInfo()
			BrowserFrame:ResortDKP()
			BrowserFrame:Show()
		     end,
	       order = 2
	    },
	    mage = {
	       type = 'toggle', name = L["Mage"], desc = L["Show mages"],
	       get = function() return not Bidder.db.realm.DKPBrowser.filters["MAGE"] end,
	       set = function(v) 
			Bidder.db.realm.DKPBrowser.filters["MAGE"] = not v
			BrowserFrame:CopyDKPInfo()
			BrowserFrame:ResortDKP()
			BrowserFrame:Show()
		     end,
	       order = 3
	    },
      monk = {
         type = 'toggle', name = L["Monk"], desc = L["Show monks"],
         get = function() return not Bidder.db.realm.DKPBrowser.filters["MONK"] end,
         set = function(v) 
      Bidder.db.realm.DKPBrowser.filters["MONK"] = not v
      BrowserFrame:CopyDKPInfo()
      BrowserFrame:ResortDKP()
      BrowserFrame:Show()
         end,
         order = 4
      },
	    paladin = {
	       type = 'toggle', name = L["Paladin"], desc = L["Show paladins"],
	       get = function() return not Bidder.db.realm.DKPBrowser.filters["PALADIN"] end,
	       set = function(v) 
			Bidder.db.realm.DKPBrowser.filters["PALADIN"] = not v
			BrowserFrame:CopyDKPInfo()
			BrowserFrame:ResortDKP()
			BrowserFrame:Show()
		     end,
	       order = 5
	    },
	    priest = {
	       type = 'toggle', name = L["Priest"], desc = L["Show priests"],
	       get = function() return not Bidder.db.realm.DKPBrowser.filters["PRIEST"] end,
	       set = function(v) 
			Bidder.db.realm.DKPBrowser.filters["PRIEST"] = not v
			BrowserFrame:CopyDKPInfo()
			BrowserFrame:ResortDKP()
			BrowserFrame:Show()
		     end,
	       order = 6
	    },
	    rogue = {
	       type = 'toggle', name = L["Rogue"], desc = L["Show rogues"],
	       get = function() return not Bidder.db.realm.DKPBrowser.filters["ROGUE"] end,
	       set = function(v) 
			Bidder.db.realm.DKPBrowser.filters["ROGUE"] = not v
			BrowserFrame:CopyDKPInfo()
			BrowserFrame:ResortDKP()
			BrowserFrame:Show()
		     end,
	       order = 7
	    },
	    shaman = {
	       type = 'toggle', name = L["Shaman"], desc = L["Show shaman"],
	       get = function() return not Bidder.db.realm.DKPBrowser.filters["SHAMAN"] end,
	       set = function(v) 
			Bidder.db.realm.DKPBrowser.filters["SHAMAN"] = not v
			BrowserFrame:CopyDKPInfo()
			BrowserFrame:ResortDKP()
			BrowserFrame:Show()
		     end,
	       order = 8
	    },
	    warlock = {
	       type = 'toggle', name = L["Warlock"], desc = L["Show warlocks"],
	       get = function() return not Bidder.db.realm.DKPBrowser.filters["WARLOCK"] end,
	       set = function(v) 
			Bidder.db.realm.DKPBrowser.filters["WARLOCK"] = not v
			BrowserFrame:CopyDKPInfo()
			BrowserFrame:ResortDKP()
			BrowserFrame:Show()
		     end,
	       order = 9
	    },
	    warrior = {
	       type = 'toggle', name = L["Warrior"], desc = L["Show warriors"],
	       get = function() return not Bidder.db.realm.DKPBrowser.filters["WARRIOR"] end,
	       set = function(v) 
			Bidder.db.realm.DKPBrowser.filters["WARRIOR"] = not v
			BrowserFrame:CopyDKPInfo()
			BrowserFrame:ResortDKP()
			BrowserFrame:Show()
		     end,
	       order = 10
	    }
	 }
      }
   }
}

--[[
Create
Description:
  Build the frame for displaying the DKP standings
]]
function BrowserFrame:Create()
   if self.frame ~= nil then return end

   self.frame = CreateFrame("Frame", "BidderDKPBrowserFrame", UIParent)
   local f = self.frame
   f:SetFrameStrata("DIALOG")
   f:SetFrameLevel(5)
   f:SetWidth(200)
   f:SetHeight(150)

   -- Register right-click to bring up the dewdrop menu
   dewdrop:Register(f, 'children', dewOptions)

   f:SetMovable(1)
   f:EnableMouse(1)
   f:RegisterForDrag("LeftButton")
   f:SetScript("OnDragStart", function()
				 f:StartMoving()
			      end)
   f:SetScript("OnDragStop", function()
				f:StopMovingOrSizing()
				Bidder.db.realm.DKPBrowser.pos.x = f:GetLeft()
				Bidder.db.realm.DKPBrowser.pos.y = f:GetTop()
			     end)

   Bidder.FrameSkinner:BackdropFrame(f, {0, 0, 0, 0.7}, {0.7, 0.7, 0.7, 0.9} )
   f:ClearAllPoints()
   f:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", Bidder.db.realm.DKPBrowser.pos.x,  Bidder.db.realm.DKPBrowser.pos.y)
   Bidder.FrameSkinner:Skin(f)

   -- Title for the frame
   local t = f:CreateFontString()
   t:SetPoint("TOPLEFT", f, "TOPLEFT", 2, -5)
   t:SetPoint("TOPRIGHT",f,"TOPRIGHT",-10,-10)
   t:SetTextColor(1.0, 0.819, 0.0)
   t:SetJustifyH("CENTER")
   t:SetJustifyV("TOP")
   t:SetFontObject(GameFontNormal)
   t:SetText(L["Bidder: DKP Standings Browser"])
   
   local t2 = f:CreateFontString()
   t2:SetPoint("TOPLEFT",t,"BOTTOMLEFT")
   t2:SetPoint("TOPRIGHT",t,"BOTTOMRIGHT")
   t2:SetTextColor(1.0,0.819,0.0)
   t2:SetJustifyH("CENTER")
   t2:SetJustifyV("TOP")
   t2:SetFontObject(GameFontNormalSmall)
  -- t2:SetText(L["right-click for options"])

   -- Create the close-window button
   local b = CreateFrame("Button", nil, f, "UIPanelCloseButton")
   b:SetScript("OnClick", function() f:Hide() end)
   b:ClearAllPoints()
   b:SetPoint("TOPRIGHT", f, "TOPRIGHT", 3, 3)
   b:Show()

   -- Create the text lines
     -- Header first
   local l = self.TextLine:New(f, -26)
   self.headerline = l
   --l:SetPoint("TOPLEFT", f, "TOPLEFT", 10, 20)

    -- Now the dkp lines
   local i
   self.dkplines = {}
   for i = 1, MaxLinesToShow do
      l = self.TextLine:New(f, -(26+i*l:GetHeight()))
      --l:SetPoint("TOPLEFT", f, "TOPLEFT", 10, 20+(i-1)*l:GetHeight())
      table.insert(self.dkplines, l)
   end
   
   --Vertical Slider
   local slider = CreateFrame("Slider", nil, f)
   slider:SetOrientation("VERTICAL")
   slider:SetMinMaxValues(1,25) --TODO set num lines total
   slider:SetValueStep(1)
   slider:SetValue(1)
   slider:SetWidth(14)
   slider:SetPoint("TOPRIGHT",f,"TOPRIGHT", -5, -22)
   slider:SetPoint("BOTTOMRIGHT",f,"BOTTOMRIGHT", -5, 2)
   slider:SetThumbTexture("Interface\\Buttons\\UI-SliderBar-Button-Vertical")
   --<Backdrop bgFile="Interface\Buttons\UI-SliderBar-Background" edgeFile="Interface\Buttons\UI-SliderBar-Border" tile="true">
   slider:SetBackdrop( { 
	 bgFile = "Interface\\Buttons\\UI-SliderBar-Background", 
	 edgeFile = "Interface\\Buttons\\UI-SliderBar-Border", tile = true, tileSize = 8, edgeSize = 8, 
	 insets = { left = 3, right = 3, top = 6, bottom = 6 }
   })     
   slider:SetScript("OnValueChanged", function() self:VerticalScrollChanged(self, value) end)
   slider:Show()
   f.vSlider=slider
   
   -- Scrolling buttons
   b = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
   self.leftscrollbutton = b
   b:SetWidth(80); b:SetHeight(16)
   b:ClearAllPoints()
   b:SetPoint("BOTTOM", f, "BOTTOM", -45, 10)
   b:SetScript("OnClick", function() self:ScrollLeft() end)
   b:SetText(L["Scroll Left"])
   b:Show()

   b = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
   self.rightscrollbutton = b
   b:SetWidth(80); b:SetHeight(16)
   b:ClearAllPoints()
   b:SetPoint("BOTTOM", f, "BOTTOM", 45, 10)
   b:SetScript("OnClick", function() self:ScrollRight() end)
   b:SetText(L["Scroll Right"])
   b:Show()

   f:Hide()
end

--[[
]]
function BrowserFrame:Show()
   if self.frame == nil then self:Create() end
   self.frame:Hide()
   self:SetLinesText(self)
   
   local width, height
   width = self.headerline:GetWidth() + 20 + 16
   height = self.headerline:GetHeight()*(1+self.nshowing) + 20 + 12
   if self.dkpinfo.npools > self.TextLine.maxPools then
      height = height + 20
      self.leftscrollbutton:Show()
      self.rightscrollbutton:Show()
   else
      self.leftscrollbutton:Hide()
      self.rightscrollbutton:Hide()
   end
   self.frame:SetHeight(math.max(height, 80))
   self.frame:SetWidth(math.max(width, 200))

   -- Show only the frames we need to show
   local i
   for i = 1, self.nshowing do
    self.dkplines[i]:Show()
   end
   for i = self.nshowing+1, MaxLinesToShow do
    self.dkplines[i]:Hide()
   end
   self.frame:Show()
end

function BrowserFrame:Hide()
   self.frame:Hide()
end

function BrowserFrame:VerticalScrollChanged(self, value)
   self.udscrollpos = self.frame.vSlider:GetValue()
   self:SetLinesText(self)
end

function BrowserFrame:ScrollLeft()
   local i
   self.headerline:ScrollLeft()
   for i = 1, self.nshowing do
      self.dkplines[i]:ScrollLeft()
   end
end

function BrowserFrame:ScrollRight()
   local i
   self.headerline:ScrollRight()
   for i = 1, self.nshowing do
      self.dkplines[i]:ScrollRight()
   end
end

function BrowserFrame:SetLinesText(self)
   -- Set the header's text
   self.headerline:SetInfo(self.headertext)
   local i
   local cache = self.dkpinfo.db
   for i = 1, self.nshowing do
      self.dkplines[i]:SetInfo(cache[i+math.floor(self.udscrollpos)])
   end
end


--[[
Support functions for sorting the displayed DKP list
]]

local function CompareFunc(t1, t2)
    local i
    for i = 1, 3 do
       local key = BrowserFrame.sortkeys[i]
       local v1, v2
       if key == "Class" then 
         v1,v2 = t1.class, t2.class
       else 
        if key == "Name" then 
          v1,v2 = t1.name, t2.name
        else
          local pool = tonumber(string.sub(key,2))
          -- For DKP we want the sort to be in decending order, so flip v1 & v2
          v2,v1 = t1.dkp[pool], t2.dkp[pool]
        end
       end
       if v1 > v2 then return false end
       if v1 < v2 then return true end
    end
    return false -- the two are equal wrt the sort keys
end

--[[
ResortDKP
Description:
  This function sorts the DKP listing according to the current sort keys, and then updates the display
]]
function BrowserFrame:ResortDKP()
   if self.dkpinfo.db == nil then return end
   table.sort(self.dkpinfo.db, CompareFunc)
   self:SetLinesText(self)
   if self.frame:IsVisible() then self.frame:Show() end
end

function BrowserFrame:CopyDKPInfo()
   self.dkpinfo.npools = self.dkpcache.npools
   local i, str
   self.dkpinfo.poolnames = {}
   for i, str in ipairs(self.dkpcache.poolnames) do
      self.dkpinfo.poolnames[i] = str
   end

   -- Copy over the database according to our filters.
   self.dkpinfo.db = {}
   local tab
   local filtertab = Bidder.db.realm.DKPBrowser.filters
   for i, tab in ipairs(self.dkpcache.db) do
      if filtertab[tab.class] ~= true then -- if we're not to filter, we insert the entry
	 table.insert(self.dkpinfo.db, tab)
      end
   end

   -- Update the validSorts table
   local i, pName
   for i, pName in ipairs(self.dkpinfo.poolnames) do
      validSorts['p'..tostring(i)] = pName
   end

   -- Update the header text
   self.headertext.dkp = self.dkpinfo.poolnames
   self.nshowing = math.min(MaxLinesToShow, #self.dkpinfo.db)
   self.udscrollpos = 0   
   self.maxscroll = math.max(0, #self.dkpinfo.db - MaxLinesToShow)
   --Update Slider
   local slider = self.frame.vSlider
   if self.maxscroll == 0 then
      slider:Hide()
   else
      slider:SetMinMaxValues(1,self.maxscroll)
      slider:SetValue(1)
      slider:Show()
   end
end

--[[
ReceiveShowBrowserFrame
Description:
  Receive and process a "DPDB" command. This tells us to display our DKP browser window.
]]
function BrowserFrame:ReceiveShowBrowserFrame(sender, params)
   if params ~= self.dkpcache.checksum then
      Bidder:Print(string.format(L["Error -- received message to display DKP browser with wrong checksum (%g)"], params)) 
      return true
   end
   -- TODO:  self:Show()
   --Bidder:Print("DKP Browser not yet implemented")
   if self.frame == nil then self:Create() end
   self:CopyDKPInfo()
   self:ResortDKP(self)
   self:Show()
   return true
end
Bidder.Comm:RegisterCommand("DPDB", BrowserFrame.ReceiveShowBrowserFrame, BrowserFrame)

--[[
ReceiveDKPInfo
Description:
  Receive and process a received "PDB" command from DKPmon.
  This command broadcasts the current DKP standings
]]
function BrowserFrame:ReceiveDKPInfo(sender, params)
   -- Do we already have this information?
   if params.checksum == self.dkpcache.checksum then return true end
   local cache = self.dkpcache
  
   cache.checksum = params.checksum
   cache.npools = #params.poolnames
   cache.poolnames = params.poolnames

   cache.db = {}
   local str
   for _, str in ipairs(params.db) do
      local parse = { strsplit("|", str) }
      local tab = {
	 name = parse[1],
	 class = parse[2],
	 namecolour = Bidder:getClassHex(parse[2]),
	 dkp = {},
	 dkpcolour = "ffffff" -- white text
      }
      local i
      for i = 3, #parse do
	 table.insert(tab.dkp, tonumber(parse[i]))
      end
      table.insert(cache.db, tab)
   end

   if self.frame and self.frame:IsVisible() then
      self:CopyDKPInfo()
      self:ResortDKP(self)
      self:Show()
   end
 
   return true
end
Bidder.Comm:RegisterCommand("PDB", BrowserFrame.ReceiveDKPInfo, BrowserFrame)