
-- Copied very liberally from XLoot which was copied from oSkin/Skinner

local _G = getfenv(0)

local backdrop = {
   bgFile = "Interface\\ChatFrame\\ChatFrameBackground", tile = true, tileSize = 16,
   edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 16,
   insets = {left = 4, right = 4, top = 4, bottom = 4},
}

local gradientOn = {"VERTICAL", .1, .1, .1, 0, .25, .25, .25, 1}
local gradientOff = {"VERTICAL", 0, 0, 0, 1, 0, 0, 0, 1}

-- Pickup settings from installed mods
local sdb = (Skinner and Skinner.db.profile or nil) or {
   BackdropBorder = {r = 0.5, g = 0.5, b = 0.5, a = 1},
   Backdrop = {r = 0, g = 0, b = 0, a = 0.9},
   FadeHeight = {enable = false, value = 500, force = false},
   Gradient = true,
}

local Skinning = {}
Bidder.FrameSkinner = Skinning

function Skinning:Skin(frame)
   if not frame then return end
   
   frame:SetBackdrop(backdrop)
   frame:SetBackdropBorderColor(sdb.BackdropBorder.r, sdb.BackdropBorder.g, sdb.BackdropBorder.b,sdb.BackdropBorder.a)
   frame:SetBackdropColor(sdb.Backdrop.r, sdb.Backdrop.g, sdb.Backdrop.b, ba or sdb.Backdrop.a)
   
   if not frame.tfade then frame.tfade = frame:CreateTexture(nil, "BORDER") end
   frame.tfade:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
   
   if sdb.FadeHeight.enable and sdb.FadeHeight.force then 
      fh = sdb.FadeHeight.value <= math.ceil(frame:GetHeight()) and sdb.FadeHeight.value or math.ceil(frame:GetHeight())
   end 
   
   frame.tfade:SetPoint("TOPLEFT", frame, "TOPLEFT", 4, -4)
   frame.tfade:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -4, 4)
   
   frame.tfade:SetBlendMode("ADD")
   frame.tfade:SetGradientAlpha(unpack(sdb.Gradient and gradientOn or gradientOff)) 
end

function Skinning:QualityBorder(button)
   local frame = button.wrapper or button
   local border = frame:CreateTexture(button:GetName() .. "QualBorder", "OVERLAY")
   border:SetTexture("Interface\\Buttons\\UI-ActionButton-Border")
   border:SetBlendMode("ADD")
   border:SetAlpha(0.5)
   border:SetHeight(button:GetHeight()*1.8)
   border:SetWidth(button:GetWidth()*1.8)
   border:SetPoint("CENTER", frame, "CENTER", 0, 1)
   border:Hide()
   return border
end

function Skinning:QualityBorderResize(frame, hmult, ymult, hoff, yoff)
   local border = _G[frame:GetName().."QualBorder"]
   local width, height = frame:GetWidth(), frame:GetHeight()
   border:SetHeight(height*(ymult or 1.62))
   border:SetWidth(width*(hmult or 1.72))
   border:SetPoint("CENTER", frame, "CENTER", hoff or 5, yoff or 1)
end

function Skinning:BackdropFrame(frame, bgcolor, bordercolor)
   frame:SetBackdrop({  bgFile = "Interface/Tooltips/UI-Tooltip-Background",
			edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
			tile = true, tileSize = 32, edgeSize = 15, 
			insets = { left = 4, right = 4, top = 4, bottom = 4 }})
   frame:SetBackdropColor(unpack(bgcolor))
   frame:SetBackdropBorderColor(unpack(bordercolor))
end

function Skinning:ItemButtonWrapper(button, woff, hoff, edgesize, borderinset)
   local wrapper = button.wrapper or CreateFrame("Frame", button:GetName().."Wrapper", button)
   wrapper:SetWidth(button:GetWidth()+(woff or 10))
   wrapper:SetHeight(button:GetHeight()+(hoff or 10))
   wrapper:ClearAllPoints()
   wrapper:SetPoint("CENTER", button, "CENTER")
   self:Skin(wrapper)
   if edgesize then
      local backdrop = wrapper:GetBackdrop()
      backdrop.edgeSize = edgesize
      wrapper:SetBackdrop(backdrop)
   end
   wrapper:SetBackdropColor(1, 1, 1, 0)
   wrapper:SetBackdropBorderColor(.7, .7, .7, 1)
   wrapper:Show()
   return wrapper
end

-- Substitute oSkin function, full credit to oSkin devs :)
function Skinning:oSkinTooltipModded(frame)
   if not frame.tfade then frame.tfade = frame:CreateTexture(nil, "BORDER") end
   frame.tfade:SetTexture("Interface\\ChatFrame\\ChatFrameBackground")
   
   frame.tfade:SetPoint("TOPLEFT", frame, "TOPLEFT",1,-1)
   frame.tfade:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT",-1,1)
   
   frame.tfade:SetBlendMode("ADD")
   frame.tfade.alphagradient = { "VERTICAL", .1, .1, .1, 0, .2, .2, .2, 0.6 }
   frame.tfade:SetGradientAlpha("VERTICAL", .1, .1, .1, 0, .2, .2, .2, 0.6)
   
   frame.tfade:SetPoint("TOPLEFT", frame, "TOPLEFT", 6, -6)
   frame.tfade:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", -6, -30)
end
