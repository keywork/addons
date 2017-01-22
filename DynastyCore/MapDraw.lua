local ADDON_NAME, Core = ...;

local EventHandler = Core.EventHandler;
local MapData = Core.MapData;
local PlayerInfo = Core.PlayerInfo;
local Canvas = Core.Canvas;

local MapDraw = {};
Core.MapDraw = MapDraw;

local pairs
	= pairs;
local GetCurrentMapDungeonLevel,GetCurrentMapAreaID,GetCVar
	= GetCurrentMapDungeonLevel,GetCurrentMapAreaID,GetCVar;
local WorldMapFrame,Minimap
	= WorldMapFrame,Minimap;

local PI,TAU = PI,PI*2;

local MinimapSizes = {
	Inside = {[0]=150,120,90,60,40,25},
	Outside = {[0]=233+1/3,200,166+2/3,133+1/3,100,66+2/3},
}

local WorldMapCanvas;
local MinimapCanvas;
local Shapes = {};
local ShapesChanged;
local ShapesInCurrentArea = false; -- player actual area, for minimap.
local MinimapIsOutside = false;
local MinimapRadius = 0;
local MinimapShape = 'ROUND';
local MinimapShapeChanged = true;
local MinimapZoomChanged = true;
--local MinimapRect = {};
local MinimapSize = 0;

local RotateMinimap = false;

local Initialized = false;

function MapDraw:Init()
	WorldMapCanvas = CreateFrame('Frame',nil,WorldMapDetailFrame)
	WorldMapCanvas:SetAllPoints();
	MapW,MapH = WorldMapCanvas:GetSize();
	
	MinimapCanvas = CreateFrame('Frame',nil,Minimap);
	MinimapCanvas:SetAllPoints();
	Initialized = true;
end

function MapDraw:Add(map,floor,type,...)
	local s;
	if type == 'Line' then
		s = {Map=map,Floor=floor,Type=type};
		s.MapSX, s.MapSY, s.MapEX, s.MapEY = ...;
		s.SX, s.SY = MapData:Translate(map,floor,s.MapSX,s.MapSY);
		s.EX, s.EY = MapData:Translate(map,floor,s.MapEX,s.MapEY);
		if not (s.SX and s.SY and s.EX and s.EY) then
			return;
		end
	end
	if type == 'Circle' then
		s = {Map=map,Floor=floor,Type=type};
		s.MapX, s.MapY, s.R = ...;
		s.X, s.Y = MapData:Translate(map,floor,s.MapX,s.MapY);
		print('circle added ... ',map,floor,s.MapX,s.MapY);
		if not (s.X and s.Y) then
			return;
		end
		print('yep');
	end
	if not s then
		return;
	end
	Shapes[s] = true;
	ShapesChanged = true;
	return s;
end

function MapDraw:Show(s)
	Shapes[s] = true;
	ShapesChanged = true;
end

function MapDraw:Remove(s)
	Shapes[s] = nil;
	ShapesChanged = true;
end

local function intersectLineLine(a1x,a1y,a2x,a2y, b1x,b1y,b2x,b2y)
	local p = (b2y-b1y)*(a2x-a1x)-(b2x-b1x)*(a2y-a1y);
	if p == 0 then return end -- parallel
	local uat = (b2x-b1x)*(a1y-b1y)-(b2y-b1y)*(a1x-b1x);
	local ubt = (a2x-a1x)*(a1y-b1y)-(a2y-a1y)*(a1x-b1x);
	local ua = uat/p;
	local ub = ubt/p;
	return a1x+(uat/ub)*(a2x-a1x), a1y+(uat/ub)*(a2y-a1y), (ub>=0 and ub<=1 and ua>=0 and ua<=1);
end
-- returns farthest points on the line that overlap the circle (nil if no intersect).
local function intersectLineCircle(cx,cy,radius,x1,y1,x2,y2)
	local dx = x1-x2;
	local dy = y1-y2;
	local A = (dx*dx+dy*dy)*2;
	local B = (dx*(x1-cx)+dy*(y1-cy))*2;
	local C = (x1-cx)*(x1-cx)+(y1-cy)*(y1-cy)-radius*radius;
	local det = B*B-4*(A/2)*C;
	if A <= 0 or det < 0 then
		return; -- no overlap
	elseif det == 0 then
		local t = -B/A;
		x1 = x1+t*dx;
		y1 = y1+t*dy;
		return x1,y1,x1,y1; -- collinear with edge
	end
	local t1 = (-B+(det^0.5))/A;
	local t2 = (-B-(det^0.5))/A;
	local intersect = false;
	if t2 < 0 and t2 > -1 then
		x2 = x1+t2*dx;
		y2 = y1+t2*dy;
		intersect = true;
	end
	if t1 < 0 and t1 > -1 then
		x1 = x1+t1*dx;
		y1 = y1+t1*dy;
		intersect = true;
	end
	if (not intersect) and ((cx-x1)^2+(cy-y1)^2)^0.5 > radius then
		return -- no intersect, both points outside
	end
	return x1,y1,x2,y2;
end

local function CropLineForMinimap(sx,sy,ex,ey,size)
	if (sx<0 and ex<0) or (sy<0 and ey<0) or (sx>size and ex>size) or (sy>size and ey>size) then
		return
	end
	local sInside = sx>0 and sy>0 and sx<size and sy<size;
	local eInside = ex>0 and ey>0 and ex<size and ey<size;
	local ci1x,ci1y,ci2x,ci2y;
	if MinimapShape == 'SQUARE' then
		if sInside and eInside then
			return sx,-sy,ex,-ey;
		end
	else -- do circle intersect checking, we'll probably need it
		ci1x,ci1y,ci2x,ci2y = intersectLineCircle( size/2,size/2,(size/2)*0.925, sx,sy, ex,ey );
		if MinimapShape == 'ROUND' then -- if map is fully round then we're done.
			if not (ci1x and ci1y and ci2x and ci2y) then
				return; -- no intersects
			end
			if RotateMinimap then -- rotation only works for round minimaps.
				local a = PlayerInfo.FacingDeg;
				local s,sT,cT,x,y = size/2,sin(a),cos(a);
				x,y = ci1x-s,ci1y-s;
				ci1x = s+((x*cT)-(y*sT));
				ci1y = s+((x*sT)+(y*cT));
				x,y = ci2x-s,ci2y-s;
				ci2x = s+((x*cT)-(y*sT));
				ci2y = s+((x*sT)+(y*cT));
			end
			return ci1x,-ci1y,ci2x,-ci2y; -- most common exit point (default ui)
		elseif ci1x == sx and ci1y == sy and ci2x == ex and ci2y == ey then
			return sx,-sy,ex,-ey; -- both points are inside the circle.
		elseif true then -- TODO: if both the corners the points are in are round then we're done
		end
	end
	
	-- calculate intersects for the minimap square.
	-- we'll need these to determine which corners the line is visible in.
	local si1x,si1y,si2x,si2y;
	--local size = size*0.9;
	for i = 1,4 do -- TODO: this shit doesn't work, fix it.
		local x,y = intersectLineLine(sx,sy,ex,ey,
			(i==4 and size or 0), -- 0001 left
			(i==3 and size or 0), -- 0010 top
			(i==2 and 0 or size), -- 1011 right
			(i==1 and 0 or size)  -- 0111 bottom
		);
		if x and y then
			if si1x then
				si2x,si2y = x,y;
				break;
			end
			si1x,si1y = x,y;
		end
	end
	
	if not (si1x or (sInside and eInside)) then -- line is fully out of scope
		return;
	elseif not si2x then -- one point was in scope
		if sInside then
			ex,ey = si1x,si1y;
		else
			sx,sy = si1x,si1y;
		end
	else
		sx,sy = si1x,si1y;
		ex,ey = si2x,si2y;
	end
	
	-- now we have 2 locations inside or on the edge of the minimap square.
	
	if MinimapShape == 'SQUARE' then
		return sx,-sy,ex,-ey;
	end
	
	--[[
	if startPoint corner is round then
		if not ci1x then -- line doesn't enter the circle at all
			return
		end
		sx,sy = the circle intersect for this corner (there will only be 1, because if there were two from the same corner we would of exited in the both-rounded-corners check)
	end
	do same for endpoint
	
	fucking done.
	--]]
end
function MapDraw:UpdateMinimap()
	if MinimapShapeChanged then
		--MinimapShape = (GetMinimapShape and GetMinimapShape()) or MinimapShape;
		MinimapShapeChanged = false;
		MinimapSize = MinimapCanvas:GetWidth();
		--MinimapH = MinimapCanvas:GetHeight()*MinimapScale;
	end
	MinimapZoomChanged = false;
	Canvas:Clear(MinimapCanvas);
	
	-- Update minimap rectangle
	local x,y = PlayerInfo.X, PlayerInfo.Y;
	local MmT,MmR,MmB,MmL = y+MinimapRadius,x-MinimapRadius,y-MinimapRadius,x+MinimapRadius;
	local MmSize = MinimapSize*(Minimap:GetEffectiveScale()^2);
	--MinimapRect[1] = y+MinimapRadius; -- Top
	--MinimapRect[2] = x-MinimapRadius; -- Right
	--MinimapRect[3] = y-MinimapRadius; -- Bottom
	--MinimapRect[4] = x+MinimapRadius; -- Left
	
	local map,floor = PlayerInfo.Map,PlayerInfo.Floor;
	local MinimapRadius = MinimapRadius;
	for s in pairs(Shapes) do
		if s.Map == map and s.Floor == floor then
			if s.Type == 'Line' then
				local sx,sy,ex,ey = s.SX,s.SY,s.EX,s.EY;
				sx = -(((sx-MmL))/MinimapRadius)*MmSize;
				sy = -(((sy-MmT))/MinimapRadius)*MmSize;
				ex = -(((ex-MmL))/MinimapRadius)*MmSize;
				ey = -(((ey-MmT))/MinimapRadius)*MmSize;
				local line = Canvas:Draw(MinimapCanvas, s.Type, CropLineForMinimap(sx,sy,ex,ey,MmSize*2));
				line:SetColor(1,1,1,0.5);
			elseif s.Type == 'Circle' then
				-- TODO: check if circle should show on minimap
			end
		end
	end
end

function MapDraw:UpdateWorldMap()
	if not Initialized then return end
	
	Canvas:Clear(WorldMapCanvas);
	if not WorldMapFrame:IsShown() then
		return true;
	end
	
	--local z,mapX,mapY,mapW,mapH = GetCurrentMapZone();
	--if not ( mapX and mapY and mapW and mapH ) then return end
	--mapW,mapH = mapW-mapX,mapH-mapY;
	local map = GetCurrentMapAreaID();
	local floor = GetCurrentMapDungeonLevel();
	local CanvasW,CanvasH = WorldMapCanvas:GetSize();
	
	for s in pairs(Shapes) do
		if s.Map == map and s.Floor == floor then
			if s.Type == 'Line' then
				--local sx = ((s[4]-mapX)/mapW)*CanvasW;
				--local sy = ((s[5]-mapY)/mapH)*CanvasH;
				--local ex = ((s[6]-mapX)/mapW)*CanvasW;
				--local ey = ((s[7]-mapY)/mapH)*CanvasH;
				--Canvas:Draw(WorldMapCanvas,'Line',sx,-sy,ex,-ey,10);
				Canvas:Draw(WorldMapCanvas, 'Line', s.MapSX*CanvasW, -s.MapSY*CanvasH, s.MapEX*CanvasW, -s.MapEY*CanvasH, 10);
			elseif s.Type == 'Circle' then
				Canvas:Draw(WorldMapCanvas, 'Circle', s.MapX*CanvasW, -s.MapY*CanvasH, s.R);
			end
		end
	end
	return true; -- for onupdate event call, turn off.
end


hooksecurefunc(Minimap,'SetMaskTexture',function() MinimapShapeChanged = true; end);
hooksecurefunc(Minimap,'SetZoom',function(self,z)
	MinimapRadius = (MinimapIsOutside and MinimapSizes.Outside or MinimapSizes.Inside)[z];
	MinimapZoomChanged = true;
	--if not (MapYardRatioX and MapYardRatioY) then return end
	--MinimapRadiusX = MinimapRadiusYards * MapYardRatioX;
	--MinimapRadiusY = MinimapRadiusYards * MapYardRatioY;
end)

EventHandler:Register('WORLD_MAP_UPDATE',function()
	MapDraw:UpdateWorldMap();
end);
EventHandler:Register('ON_UPDATE',function()
	if ShapesChanged then
		local map,floor = PlayerInfo.Map, PlayerInfo.Floor;
		ShapesInCurrentArea = false;
		for s in pairs(Shapes) do
			if s.Map == map and s.Floor == floor then
				ShapesInCurrentArea = true;
				break;
			end
		end
		MapDraw:UpdateWorldMap();
	end
	if (ShapesInCurrentArea and (PlayerInfo.Moving or RotateMinimap)) or ShapesChanged or MinimapZoomChanged or MinimapShapeChanged then
		MapDraw:UpdateMinimap();
	end
	ShapesChanged = false;
end);
EventHandler:Register('PLAYER_MAP_CHANGED',function(map,floor)
	ShapesChanged = true;
end);
EventHandler:Register('MINIMAP_UPDATE_ZOOM',function() -- when switching indoors/outdoors
	local z = Minimap:GetZoom();
	if GetCVar("minimapZoom") == GetCVar("minimapInsideZoom") then
		Minimap:SetZoom(z+(z<2 and 1 or -1));
	end
	MinimapIsOutside = GetCVar("minimapZoom")+0 == Minimap:GetZoom();
	Minimap:SetZoom(z);
end);

EventHandler:Register('CVAR_UPDATE',function(var,val)
	RotateMinimap = GetCVar('rotateminimap') == '1';
	MinimapShapeChanged = true;
end);
EventHandler:Trigger('CVAR_UPDATE');
