local ADDON_NAME, DGV = ...;

local Navigator = {};
DGV.Navigator = Navigator;

local Obj = {};

local cos, sin, abs, PI, TAU, floor, format, tonumber
	= math.cos, math.sin, math.abs, math.pi, math.pi*2, math.floor, format, tonumber;
local MapData = DynastyCore.MapData;
local PlayerInfo = DynastyCore.PlayerInfo;
local EventHandler = DynastyCore.EventHandler;
local LibElci = DynastyCore.LibElci;
local GUI = DGV.GUI;

local Frame = LibElci.Create(UIParent,'Window','DGV_Navigator');
Frame:SetClampedToScreen(true);
Frame:SetBackdrop({});
Frame:SetPoint('TOP',0,-100);
Frame:SetSize(250,120);
Frame:SetScale(0.8)

local Arrow = Frame:CreateTexture();
Arrow:SetTexture('Interface\\AddOns\\'..ADDON_NAME..'\\Arrow2');
Arrow:SetPoint('TOP');
Arrow:SetSize( 130, 65 );

local ObjFS = Frame:CreateFontString();
ObjFS:SetFont('Fonts\\ARIALN.TTF', 14, '');
ObjFS:SetPoint('TOP',Arrow,'BOTTOM');
ObjFS:SetShadowColor(0,0,0,0.75)
ObjFS:SetShadowOffset(1, -1)

local DistFS = Frame:CreateFontString();
DistFS:SetFont('Fonts\\ARIALN.TTF', 14, '');
DistFS:SetPoint('TOP',ObjFS,'BOTTOM');
DistFS:SetShadowColor(0,0,0,0.75)
DistFS:SetShadowOffset(1, -1)

function Navigator:SetObjective( text, x, y, map, floor )
	map = tonumber(map);
	floor = tonumber(floor);
	if not ( map and floor and x and y ) then
		-- DEBUG: Invalid Objective Data
		return;
	elseif Obj.X == x and Obj.Y == y and Obj.Map == map and Obj.Floor == floor and Obj.Text == text then
		return; -- Discard same location.
	end
	
	Obj.cX, Obj.cY = x,y;--MapData:Translate( map, floor, x, y );
	
	if Obj.cX and Obj.cY then
		Obj.Text = text;
		Obj.X = x;
		Obj.Y = y;
		Obj.Map = map;
		Obj.Floor = floor;
		if not self:Update() then
			-- not same continent
		end
	else
		self:ClearObjective();
	end
end
function Navigator:ClearObjective()
	wipe(Obj);
	self:Update();
end

-- Slow updates, calculates the direction we should be facing and the distance to the objective.
function Navigator:Update()
	if Obj.Map and GUI:IsShown() and MapData:IsSameContinent( Obj.Map, PlayerInfo.Map ) then
		Frame:Show();
		ObjFS:SetText( Obj.Text );
		return true;
	else
		Frame:Hide();
		return false;
	end
end

C_Timer.NewTicker(0.5, Navigator.Update)

local angle = 0;
--local scale = 1;
EventHandler:Register("ON_UPDATE",function()
	if not ( Obj.cX and Obj.cY and PlayerInfo.X and PlayerInfo.Y ) then
		return
	end
	local Dist, Dir = MapData:Distance( PlayerInfo.X, PlayerInfo.Y, Obj.cX, Obj.cY, true );
	if Dist and Dir then
		
		local yaw = PlayerInfo.FacingNormal+Dir;
		yaw = (yaw>PI or yaw<-PI) and yaw%(yaw>0 and -PI or PI) or yaw;
		
		local d = yaw-angle;
		angle = angle + ((d>PI and TAU) or (d<-PI and -TAU) or 0); -- warp
		angle = angle + ((yaw - angle)*0.25); -- lerp
		
		DistFS:SetText(format("(%d yards)",Dist));
		
		-- Set Arrow
		local p = angle/TAU;
		local i = floor(89*(p%1)+0.5);
		local x,y = i%9, floor(i/9);
		Arrow:SetTexCoord(
			(130/2048)*x,(130/2048)*(x+1),
			(65/1024)*y, (65/1024)*(y+1)
		);
		local v = abs(0.5-abs(p))/0.5;
		Arrow:SetVertexColor(0.2+0.6*(1-v),0.3+0.6*v,0,1);
	end
end);


