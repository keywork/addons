local E, L, V, P, G, _ = unpack(ElvUI); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB
local TTOS = E:NewModule('TooltipOffset')
local TT = E:GetModule('Tooltip');
local EP = LibStub("LibElvUIPlugin-1.0")
local addon, ns = ...

--Defaults
P['tooltip']['mouseOffsetX'] = 0
P['tooltip']['mouseOffsetY'] = 0
P['tooltip']['cursorAnchorLoc'] = "BOTTOM"

--Functions to hook
function TTOS:GameTooltip_SetDefaultAnchor(tt, parent)
	if E.private.tooltip.enable ~= true then return end
	
	if InCombatLockdown() and E.db.tooltip.visibility.combat then
		tt:Hide()
		return
	end
	
	if (parent and tt) then
		tt:SetOwner(parent, "ANCHOR_NONE")
		tt:ClearAllPoints()
	end
	
	if(not E:HasMoverBeenMoved('TooltipMover')) then
		if ElvUI_ContainerFrame and ElvUI_ContainerFrame:IsShown() then
			tt:SetPoint('BOTTOMRIGHT', ElvUI_ContainerFrame, 'TOPRIGHT', 0, 18)	
		elseif RightChatPanel:GetAlpha() == 1 and RightChatPanel:IsShown() then
			tt:SetPoint('BOTTOMRIGHT', RightChatPanel, 'TOPRIGHT', 0, 18)		
		else
			tt:SetPoint('BOTTOMRIGHT', RightChatPanel, 'BOTTOMRIGHT', 0, 18)
		end
	else
		local point = E:GetScreenQuadrant(TooltipMover)
		if point == "TOPLEFT" then
			tt:SetPoint("TOPLEFT", TooltipMover, "BOTTOMLEFT", 1, -4)
		elseif point == "TOPRIGHT" then
			tt:SetPoint("TOPRIGHT", TooltipMover, "BOTTOMRIGHT", -1, -4)
		elseif point == "BOTTOMLEFT" or point == "LEFT" then
			tt:SetPoint("BOTTOMLEFT", TooltipMover, "TOPLEFT", 1, 18)
		else
			tt:SetPoint("BOTTOMRIGHT", TooltipMover, "TOPRIGHT", -1, 18)
		end
	end
end

---[[ update functions
function TTOS.GameTooltip_OnUpdate(tt)
--[[	
	local unitName, unit = tt:GetUnit()
	local owner = tt:GetOwner()
	owner = owner:GetName() or tostring(owner)
	print("GTT unitName: ", unitName, " GTT unit: ", unit, " owner: ", owner," numPoints: ", tt:GetNumPoints())
--]]	
	if(tt:GetAnchorType() ~= "ANCHOR_NONE") then return end
	
	if (E.db.tooltip.cursorAnchor) then
		local owner = tt:GetOwner()
		if (owner == UIParent) then
			TTOS:AnchorFrameToMouse(tt)
		else
			local unitName, unit = tt:GetUnit()
			if (unitName ~= nil) then
				TTOS:AnchorFrameToMouse(tt)
			elseif (tt:GetNumPoints() == 0) then
				tt:ClearAllPoints();
				tt:SetPoint("BOTTOMRIGHT",owner,"TOPLEFT");
			end
		end	
	end
end

function TTOS:AnchorFrameToMouse(frame)
	local x, y = GetCursorPosition();
	local effScale = frame:GetEffectiveScale();

	frame:ClearAllPoints();
	frame:SetPoint(E.db.tooltip.cursorAnchorLoc,UIParent,"BOTTOMLEFT",(x / effScale + E.db.tooltip.mouseOffsetX),(y / effScale + E.db.tooltip.mouseOffsetY));
end

-- Options
function TTOS:InjectOptions()
	E.Options.args.tooltip.args.general.args.offset = {
		order = 30,
		type = "group",
		name = "Cursor Offset",
		guiInline = true,
		get = function(info) return E.db.tooltip[ info[#info] ] end,
		set = function(info, value) E.db.tooltip[ info[#info] ] = value; end,
		args = {
			mouseOffsetX = {
				order = 31,
				type = 'range',
				name = 'Tooltip X-offset',
				desc = 'Offset the tooltip on the X-axis.',
				min = -200, max = 200, step = 1,
				disabled = function() return not E.db.tooltip.cursorAnchor end,
			},
			mouseOffsetY = {
				order = 32,
				type = 'range',
				name = 'Tooltip Y-offset',
				desc = 'Offset the tooltip on the Y-axis.',
				min = -200, max = 200, step = 1,
				disabled = function() return not E.db.tooltip.cursorAnchor end,
			},
			cursorAnchorLoc = {
				order = 33,
				type = 'select',
				name = 'Cursor Anchor Location',
				desc = 'This sets where the cursor is anchored to the tooltip.',
				values = {
					['CENTER'] = "CENTER",
					['BOTTOM'] = "BOTTOM",
					['TOP'] = "TOP",
					['LEFT'] = "LEFT",
					['RIGHT'] = "RIGHT",
					['BOTTOMLEFT'] = "BOTTOMLEFT",
					['BOTTOMRIGHT'] = "BOTTOMRIGHT",
					['TOPLEFT'] = "TOPLEFT",
					['TOPRIGHT'] = "TOPRIGHT"			
				},
				disabled = function() return not E.db.tooltip.cursorAnchor end,
			},
		},
	}
end

function TTOS:Initialize()
	--Register plugin so options are properly inserted when config is loaded
	EP:RegisterPlugin(addon, TTOS.InjectOptions)
	
	if E.private.tooltip.enable ~= true then return end
	hooksecurefunc(TT, "GameTooltip_SetDefaultAnchor", TTOS.GameTooltip_SetDefaultAnchor)
	GameTooltip:HookScript("OnUpdate",TTOS.GameTooltip_OnUpdate)
end

E:RegisterModule(TTOS:GetName())