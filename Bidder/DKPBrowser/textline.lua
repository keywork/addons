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


local TextLine = {}
Bidder.DKPBrowser.TextLine = TextLine

local NameStrWidth = 175
local DKPStrWidth = 75

local NumDKPStrings = 5

TextLine.maxPools = NumDKPStrings
--[[
New
Description:
  Allocate a TextLine frame for the DKPBrowser window
Input:
  parent -- frame; the frame to make the parent of this frame
]]
function TextLine:New(parent, y)
   local line = {}
   line.frame = CreateFrame("Frame", "BidderTextLine"..y, parent)
   local f = line.frame
   
   f:ClearAllPoints()
   f:SetPoint("TOPLEFT", parent, "TOPLEFT", 10, y)
   
   f:SetHeight(12)
   f:SetWidth(NameStrWidth + NumDKPStrings*DKPStrWidth)
      
   local t = f:CreateFontString()
   t:SetWidth(NameStrWidth)
   t:SetFontObject(GameFontNormalSmall)
   t:SetTextColor(1,1,1)
   t:ClearAllPoints()
   t:SetPoint("LEFT", f, "LEFT", 0, 0)
   t:SetJustifyH("LEFT")
   t:SetNonSpaceWrap(false)
   t:Show()
   line.namestr = t
   
   local i
   line.dkpstrs = {}
   for i = 1, NumDKPStrings do
      t = f:CreateFontString()
      t:SetWidth(DKPStrWidth)
      t:SetFontObject(GameFontNormalSmall)
      t:SetTextColor(1,1,1)
      t:ClearAllPoints()
      t:SetPoint("LEFT", f, "LEFT", NameStrWidth + (i-1)*DKPStrWidth, 0)
      t:SetJustifyH("CENTER")
      t:SetNonSpaceWrap(false)
      table.insert(line.dkpstrs, t)
   end

   line.textinfo = {
      scrollpos = 0,
      numdkps = 0,
      numdkpsshown = 0,
      namestr = nil, -- string to display in namestr
      dkpstrs = { -- table of strings to display in the dkpstrs
      }
   }
    setmetatable(line, { __index = TextLine })
   return line
end

--function TextLine:SetPoint(...) self.frame:ClearAllPoints(); self.frame:SetPoint(...) end
function TextLine:SetPoint(pt,par,rpt,x,y) self.frame:ClearAllPoints(); self.frame:SetPoint(pt,par,rpt,x,y) end
function TextLine:SetWidth(a) self.frame:SetWidth(a) end
function TextLine:GetWidth() return self.frame:GetWidth() end
function TextLine:SetHeight(a) self.frame:SetHeight(a) end
function TextLine:GetHeight() return self.frame:GetHeight() end
function TextLine:Show() self.frame:Show() end
function TextLine:Hide() self.frame:Hide() end

--[[
SetInfo
Description:
  Set the text fields up for this text line
Input:
  infotab -- table: {
                name = <string>, -- string for namestr
                namecolour = <string>, -- hex code for the name string
                dkpcolour <string>, -- hex code for the dkp string colours
                dkp = {
		   <number/string>, <number/string>, ...
		} -- values for the dkp strings
             }
]]
function TextLine:SetInfo(infotab)
   self.textinfo.numdkps = #infotab.dkp
   self.textinfo.numdkpsshown = math.min(NumDKPStrings, self.textinfo.numdkps)

   if self.textinfo.scrollpos + self.textinfo.numdkpsshown > self.textinfo.numdkps then
      self.textinfo.scrollpos = 0
   end
   
   self.textinfo.namestr = string.format("|cff%s%s|r", infotab.namecolour, infotab.name)
   self.textinfo.dkpstrs = {}
   local i
   for i = 1, self.textinfo.numdkps do
      table.insert(self.textinfo.dkpstrs, 
		   string.format("|cff%s%s|r", infotab.dkpcolour, tostring(infotab.dkp[i])))
   end

   for i = 1, NumDKPStrings do
      self.dkpstrs[i]:Hide()
   end
   self:SetWidth(NameStrWidth + self.textinfo.numdkpsshown*DKPStrWidth)
   self:SetStrings()
end

function TextLine:SetStrings()
   self.namestr:SetText(self.textinfo.namestr)
   self.namestr:Show()
   local i
   for i = 1, self.textinfo.numdkpsshown do
      self.dkpstrs[i]:SetText(self.textinfo.dkpstrs[i+self.textinfo.scrollpos])
      self.dkpstrs[i]:Show()
   end
end

function TextLine:ScrollRight()
   self.textinfo.scrollpos = math.min(self.textinfo.scrollpos+1, self.textinfo.numdkps-self.textinfo.numdkpsshown)
   self:SetStrings()
end

function TextLine:ScrollLeft()
   self.textinfo.scrollpos = math.max(0, self.textinfo.scrollpos-1)
   self:SetStrings()
end