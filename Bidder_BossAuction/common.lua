--[[
This file is for all methods common between the silent and open
bidding variations of Bidder_BossAuction.

gBADKP = global BossAuction DKP, these methods are brought into the
silent/open bidding modules in their files.
]]

gBADKP = {}

local AceOO = AceLibrary("AceOO-2.0")
local L = AceLibrary("AceLocale-2.2"):new("Bidder_BossAuction")
local PC = AceLibrary("PaintChips-2.0")
--PC:RegisterColor("name","FF00FF")
PC:RegisterColor("contested","FF0000")
PC:RegisterColor("winner","00FF00")
PC:RegisterColor("high","4AC4EF")
PC:RegisterColor("normal",1.0,0.82,0)

gBADKP.AceOO = AceOO
gBADKP.L = L
gBADKP.PC = PC

function gBADKP:GetPlayerClass(playerName)
	if not self.classNameCache then
		self.classNameCache = {}
	end
	local className = self.classNameCache[playerName]
	if className then return className end
	
	local i
	for i = 1, GetNumGroupMembers() do
		name, _, _, _, _, className, _, _, _, _, _ = GetRaidRosterInfo(i);
		if name == playerName then
			self.classNameCache[playerName] = className
			return className
		end
	end
	return nil
end

--[[
OnLeftClick(dewOptions, itembutton, dkpinfo)
Description:
  Called when the user left clicks on an item in the bidding window
Input:
  dewOptions -- An Ace Options table to use if the DKP system needs to build a menu on a left click
  itembutton -- The LootItem object that made this call.
  dkpinfo -- table; same table returned from DKPmon:GetItemInfo() plus whatever else the DKP system added to track bidding
Returns:
  boolean -- true = display the dewdrop menu, false = don't display it
]]
function gBADKP:OnLeftClick(dewOptions, itembutton, dkpinfo)
   local f = itembutton.bidEntryFrame
   if f == nil then
		f = CreateFrame("EditBox",nil,itembutton.frame)
		f:SetPoint("TOPLEFT",itembutton.frame,"TOPRIGHT",2,0)
		f:SetAutoFocus(false)
		f:SetMultiLine(false)
		f:SetNumeric(true)
		f:SetFontObject(GameFontNormal)
		f:SetTextInsets(5,5,1,1)
		f:SetWidth(50)
		f:SetHeight(25)
		f:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background", 
					edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
					tile = true, tileSize = 16, edgeSize = 16, 
					insets = { left = 4, right = 4, top = 4, bottom = 4 }});
		f:SetBackdropColor(0,0,0,1);
		f:SetScript("OnEscapePressed",
		function()
			f:ClearFocus()
		end)
	
		f:SetScript("OnEnterPressed",
		function()
			local x = f:GetNumber()
			local dkpSys = Bidder.DKP:Get()
			--don't use self use Bidder:DKP as self references the self when this function was made	
			if dkpSys:IsBidValid(x,itembutton.dkpinfo) then
				Bidder.Comm:SendToDKPmon("PB", { item = itembutton.id, dkp = { bid = x } }, Bidder.Looting.lootmaster)				
				itembutton.dkpinfo.mybid = x
            itembutton:UpdateStatusText()
			else
				--revert to old bid
				if itembutton.dkpinfo.mybid ~= nil then
					f:SetNumber(itembutton.dkpinfo.mybid)
				end
			end
		end)
		
		f:SetScript("OnEditFocusLost",
		function()
			if itembutton.dkpinfo.mybid ~= nil then
				f:SetNumber(itembutton.dkpinfo.mybid)
			end
		end)
		
		f:SetScript("OnHide",
		function()
			f:Hide()
		end)
		
		f:SetScript("OnShow",
		function()
			if itembutton.dkpinfo.mybid ~= nil then
				f:SetNumber(itembutton.dkpinfo.mybid)
			else
				f:SetText("")
			end
		end)
		
		itembutton.bidEntryFrame = f
	end
	
	f:Show()
	f:SetFocus()
	--don't show dewdrop
   	return false
end

--[[
OnRightClick(dewOptions, itembutton, dkpinfo)
Description:
  Called when the user right clicks on an item in the bidding window
Input:
  dewOptions -- An Ace Options table to use if the DKP system needs to build a menu on a left click
  itembutton -- The LootItem object that made this call.
  dkpinfo -- table; same table returned from DKPmon:GetItemInfo() plus whatever else the DKP system added to track bidding
Returns:
  boolean -- true = display the dewdrop menu, false = don't display it
]]
function gBADKP:OnRightClick(dewOptions, itembutton, dkpinfo)
   -- Points as currency does nothing on a right click
   return false
end


function gBADKP:GetButtonTexts(itembutton)
	local dkpText
	local lootingFrame = Bidder.Looting.frame
	if lootingFrame then
		dkpText = lootingFrame.dkpText
		if not dkpText then
		   local t = lootingFrame:CreateFontString()
			lootingFrame.dkpText = t
			dkpText = t
			t:SetPoint("TOPLEFT",Bidder.Looting.nameplate,"BOTTOMLEFT",0,0)
			t:SetPoint("BOTTOMRIGHT",Bidder.Looting.nameplate,"TOPRIGHT",0,-25)
			t:SetTextColor(1.0, 0.82, 0.0)
			t:SetJustifyH("CENTER")
			t:SetJustifyV("TOP")
			t:SetFontObject(GameFontNormal)
		end
	end
	
	local bidText = itembutton.bidText
	local costText = itembutton.costText
	if not bidText then
		local ibf = itembutton.frame
		
		local fs = ibf:CreateFontString(nil,"OVERLAY","GameFontNormal")
		fs:SetPoint("TOPRIGHT",ibf,"TOPRIGHT",-6,-5)
		fs:SetPoint("BOTTOM",ibf,"CENTER")
		fs:SetPoint("LEFT",ibf,"LEFT")
		fs:SetJustifyH("RIGHT")
		fs:SetJustifyV("TOP")      
		itembutton.bidText = fs
		bidText = fs         
		
		fs = ibf:CreateFontString(nil,"OVERLAY","GameFontHighlight")
		fs:SetPoint("BOTTOMRIGHT",ibf,"BOTTOMRIGHT",-6,5)
		fs:SetPoint("TOP",ibf,"CENTER")
		fs:SetPoint("LEFT",ibf,"LEFT")
		fs:SetJustifyH("RIGHT")
		fs:SetJustifyV("BOTTOM")      
		itembutton.costText = fs
		costText = fs                  
	end
	return dkpText,bidText,costText
end
