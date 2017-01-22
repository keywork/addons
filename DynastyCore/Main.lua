local ADDON_NAME, Core = ...;

_G.DynastyCore = Core;

local LibElci = Core.LibElci;
local EventHandler = Core.EventHandler;
local MapData = Core.MapData;
local MapDraw = Core.MapDraw;

EventHandler:Register('PLAYER_LOGIN',function()
	MapData:ScanAllMaps();
	MapDraw:Init();
	return true;
end)

local ADDONS = {
	'DynastyTycoon',
	'DynastyEdge', --_G.DynastyEdge_MainWindow:Show();
	'DynastyImpulse',
	'DynastyBooster',
};

-- Create GUI

local Icon = LibElci.Create(UIParent,'Frame','DynastyCore_Icon');
Icon:SetSize(24,24);
Icon:SetPoint('CENTER');
Icon:SetBackdrop({});
Icon:SetFrameStrata("HIGH");
Icon:SetMovable(true);
Icon:IsUserPlaced(true);
Icon:RegisterForDrag('LeftButton');
Icon.Border = Icon:Create('Texture','Interface/COMMON/portrait-ring-withbg');
Icon.Border:SetDrawLayer('BORDER');
Icon.Border:SetPoint('CENTER');
Icon.Border:SetSize(64,64);
Icon.Texture = Icon:Create('Texture','Interface/AddOns/DynastyCore/Media/Logo');
Icon.Texture:SetDrawLayer('ARTWORK');
Icon.Texture:SetTexCoord(0,45/128,0,89/128);
Icon.Texture:SetSize(22.5,44.5);
Icon.Texture:SetPoint('BOTTOM',0,0);
Icon.Texture:SetDesaturated(true);
Icon:SetScript('OnMouseDown',function()
	Icon.Texture:SetSize(20.5,40.5);
	Icon.Texture:SetPoint('BOTTOM',0,1);
end);
Icon:SetScript('OnMouseUp',function()
	Icon.Texture:SetSize(22.5,44.5);
	Icon.Texture:SetPoint('BOTTOM',0,0);
end);

do
local minimapShapes = {
	["ROUND"] = {true, true, true, true},
	["SQUARE"] = {false, false, false, false},
	["CORNER-TOPLEFT"] = {false, false, false, true},
	["CORNER-TOPRIGHT"] = {false, false, true, false},
	["CORNER-BOTTOMLEFT"] = {false, true, false, false},
	["CORNER-BOTTOMRIGHT"] = {true, false, false, false},
	["SIDE-LEFT"] = {false, true, false, true},
	["SIDE-RIGHT"] = {true, false, true, false},
	["SIDE-TOP"] = {false, false, true, true},
	["SIDE-BOTTOM"] = {true, true, false, false},
	["TRICORNER-TOPLEFT"] = {false, true, true, true},
	["TRICORNER-TOPRIGHT"] = {true, false, true, true},
	["TRICORNER-BOTTOMLEFT"] = {true, true, false, true},
	["TRICORNER-BOTTOMRIGHT"] = {true, true, true, false},
}

local function RepositionIcon(self) -- DBIcon-1.0
	local mx, my = Minimap:GetCenter();
	local s = Minimap:GetEffectiveScale();
	local cx, cy = GetCursorPosition();
	local angle = math.atan2((cy/s) - my, (cx/s) - mx)
	local x, y, q = math.cos(angle), math.sin(angle), 1
	if x < 0 then q = q + 1 end
	if y > 0 then q = q + 2 end
	local minimapShape = GetMinimapShape and GetMinimapShape() or "ROUND"
	local quadTable = minimapShapes[minimapShape]
	if quadTable[q] then
		x, y = x*80, y*80
	else
		local diagRadius = 103.13708498985; --math.sqrt(2*(80)^2)-10
		x = math.max(-80, math.min(x*diagRadius, 80))
		y = math.max(-80, math.min(y*diagRadius, 80))
	end
	Icon:ClearAllPoints();
	Icon:SetPoint("CENTER", Minimap, "CENTER", x, y);
end

Icon:SetScript('OnDragStart', function()
	Icon:SetScript("OnUpdate", RepositionIcon);
	Icon.Texture:SetSize(20.5,40.5);
	Icon.Texture:SetPoint('BOTTOM',0,1);
	Icon:StartMoving();
end);

Icon:SetScript('OnDragStop', function()
	Icon:SetScript("OnUpdate", nil);
	Icon.Texture:SetSize(22.5,44.5);
	Icon.Texture:SetPoint('BOTTOM',0,0);
	Icon:StopMovingOrSizing();
end);

end

local Flyout = Icon:Create('Frame');
Icon:SetScript('OnLeave',function()
	Icon.Texture:SetDesaturated(not Flyout.Open);	
end);
Icon:SetScript('OnEnter',function()
	Icon.Texture:SetDesaturated(false);
end);

Flyout:SetSize(1,21);
Flyout:SetShown(false);
Flyout:SetPoint('RIGHT',Icon,'LEFT',-2,0);
Flyout:SetBackdrop({});
Flyout.Nipple = Flyout:Create('Texture','Interface/AddOns/DynastyCore/Media/Flyout');
Flyout.Nipple:SetTexCoord(0,31/32,0,21/32);
Flyout.Nipple:SetSize(31*0.5,21*0.5);
Flyout.Nipple:SetPoint('RIGHT',Flyout,'LEFT');
Flyout.Bar = Flyout:Create('Texture','Interface/AddOns/DynastyCore/Media/Flyout');
Flyout.Bar:SetTexCoord(31/32,1,0,21/32);
Flyout.Bar:SetHeight(21*0.5);
Flyout.Bar:SetPoint('LEFT',Flyout.Nipple,'RIGHT');
Flyout.Bar:SetPoint('RIGHT');
Flyout.Width = 4;
function Flyout.Toggle()
	Flyout.Open = not Flyout.Open;
	if Flyout.Open then
		Flyout:Show();
		Flyout:Resize(Flyout.Width,nil);
	else
		Flyout:Hide();
		Flyout:Resize(1,nil);
	end
end
Icon:SetScript('OnClick',function()
	if IsShiftKeyDown() and DynastyDev then
		return DynastyDev.MainWindow:Show()
	end
	Flyout.Toggle();
end);

Flyout.Buttons = {};
for i,name in pairs(ADDONS) do
	local loadable, reason = select(4,GetAddOnInfo(name));
	
	local btn = Flyout:Create('Button',function()
		EnableAddOn(name);
		LoadAddOn(name);
		EventHandler:Trigger('DYNASTY_ADDON_SELECTED',name);
		Flyout.Toggle();
		Icon.Texture:SetDesaturated(not Flyout.Open);
	end);
	btn:SetPoint('CENTER',Flyout,'LEFT',Flyout.Width+12,0);
	btn:SetSize(24,24);
	btn:SetBackdrop({
		bgFile='Interface/COMMON/Indicator-Gray',
		insets = {left = -4, right = -4, top = -3, bottom = -5},
	});
	btn.Icon = btn:Create('Texture','Interface/AddOns/DynastyCore/Media/Icons');
	btn.Icon:SetTexCoord( ((i-1)*32)/128, (i*32)/128, 0, 1 );
	btn.Icon:SetAllPoints();
	
	btn:SetText(name:sub(8));
	btn.Text:SetFont('Fonts\\ARIALN.TTF', 10);
	btn.Text:SetShadowColor(0,0,0,0.75)
	btn.Text:SetShadowOffset(1, -1)
	btn.Text:ClearAllPoints();
	btn.Text:SetPoint('BOTTOM',btn,'TOP',0,-2);
	btn.Text:SetSize(100,20);
	btn.Text:SetShown(false);
	
	if loadable or reason == 'DISABLED' or reason == 'DEMAND_LOADED' then
		btn:SetColor(1,1,1,1);
		btn.OnEnter = function()
			if Icon:IsMouseOver() then
				return; -- cursor still over main button (flyout animation?)
			end
			btn:Resize(32,32,0.1)
			btn.Text:SetShown(true);
		end
		btn.OnLeave = function()
			btn:Resize(24,24,0.1)
			btn.Text:SetShown(false);
		end
	else
		btn.Icon:SetDesaturated(true);
		btn.Icon:SetVertexColor(1,1,1,0.25);
		btn:SetEnabled(false);
	end
	
	Flyout.Width = Flyout.Width + 26;
	Flyout.Buttons[i] = btn;
end
Flyout.Width = Flyout.Width + 4;

function Flyout:OnResize()
	local w = self:GetWidth();
	for i, btn in pairs(self.Buttons) do
		if w > i*26 then
			btn:Show();
		else
			btn:SetShown(false);
		end
	end
end
--[[


-- Adds scanner button to auction search ui.
EventHandler:Register('ADDON_LOADED',function(name)
	if name ~= 'Blizzard_AuctionUI' then return end
	
	local loadable, reason = select(4,GetAddOnInfo('DynastyTycoon'));
	if not (loadable or reason == 'DISABLED' or reason == 'DEMAND_LOADED') then
		return true; -- tycoon not installed, don't need to show the button.
	end
	
	local btn = LibElci.Create(AuctionFrameBrowse,'Button',function(btn)
		if not IsAddOnLoaded('DynastyTycoon') then
			EnableAddOn('DynastyTycoon');
			LoadAddOn('DynastyTycoon');
			EventHandler:Trigger('DYNASTY_ADDON_SELECTED',name);
		end
		if DynastyTycoon and DynastyTycoon.Scanner and DynastyTycoon.Scanner:CanStart() then
			DynastyTycoon.Scanner:Start();
		end
	end);
	
	btn:SetPoint('TOPRIGHT',-110,-44);
	btn:SetBackdrop({});
	btn:SetSize(30,30);
	local texture = btn:CreateTexture();
	texture:SetTexture('Interface/AddOns/DynastyCore/Media/Textures');
	texture:SetTexCoord( 700/1024, (700+40)/1024, 0/128, (0+40)/128 );
	texture:SetSize(40,40);
	btn:SetTexture(texture);
	btn:SetColor(1,1,1,1);
	btn:SetPushedColor(1,0.8,0,1);
	
	local swipe = CreateFrame("Cooldown", nil, btn);
	swipe:SetPoint('CENTER');
	swipe:SetSize(48,48);
	swipe:SetSwipeTexture('Interface/COMMON/StreamBackground');
	swipe:SetSwipeColor(0,0,0,1);
	
	btn.UpdateCooldown = function()
		local isReady, startTime, duration = select(2,CanSendAuctionQuery()), 0, 0;
		
		
		if not (DynastyTycoon and DynastyTycoon.Scanner) then return end
		local isReady, startTime, duration = DynastyTycoon.Scanner:CanStart();
		swipe:SetCooldown( startTime, duration );
		
		btn:SetEnabled( select(2,CanSendAuctionQuery()) and isReady );
	end
	
	EventHandler:Register('AUCTION_HOUSE_SHOW',btn.UpdateCooldown);
	EventHandler:Register('TYCOON_SCAN_STARTED',function()
		btn:UpdateCooldown(); -- Get-all query sent, cooldown now available.
	end);
	
	btn:UpdateCooldown()
	return true;
end);
if IsAddOnLoaded('Blizzard_AuctionUI') then -- auctinhouse ui is already loaded
	EventHandler:Trigger('ADDON_LOADED','Blizzard_AuctionUI'); -- fake call to setup frames.
end

--]]
