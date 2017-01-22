local ADDON_NAME, Core = ...;

-- Define Locals
local GetCurrentMapAreaID,GetCurrentMapDungeonLevel,SetMapToCurrentZone,UnitPosition,GetPlayerFacing
	= GetCurrentMapAreaID,GetCurrentMapDungeonLevel,SetMapToCurrentZone,UnitPosition,GetPlayerFacing;
local PI, TAU = math.pi, math.pi*2;

local MapData = Core.MapData;
local EventHandler = Core.EventHandler;

local Info = {};
Core.PlayerInfo = Info;
--[[ Obsolete by UnitPosition
C_Timer.NewTicker(0.25, function()
	local saved = Viewer.MapData.SaveMapState()
	
	SetMapToCurrentZone();
	local x,y = GetPlayerMapPosition('player');
	if x ~= Info.X and y ~= Info.Y then
		Info.X, Info.Y = x,y;
		Info.Map = GetCurrentMapAreaID();
		Info.Floor = GetCurrentMapDungeonLevel();
		Viewer.EventHandler:Trigger('PLAYER_MOVED');
	end
	
	if saved then
		Viewer.MapData.LoadMapState()
	end
end);
--]]

local MapChanged = false;

local function UpdatePosition()
	local y,x = UnitPosition('Player');
	if not (x and y) then
		x,y = 0,0;
	end
	Info.X, Info.Y = x,y;
	--Info.MapX, Info.MapY = MapData:GetMapPosition(Info.Map,Info.Floor,x,y); -- too slow (can speed it up by cacheing map data;
	--if MapData:SaveMapState() then
	--	SetMapToCurrentZone();
	--	Info.MapX, Info.MapY = GetPlayerMapPosition('player');
	--	MapData:LoadMapState();
	--end
end

local function UpdateFacing()
	Info.Facing = GetPlayerFacing() or 0;
	Info.FacingDeg = 360*(Info.Facing/TAU);
	Info.FacingNormal = PI-((Info.Facing+PI)%TAU);
	if not Info.Moving then return end
	UpdatePosition();
end
UpdateFacing();

EventHandler:Register("ON_UPDATE",UpdateFacing);
EventHandler:Register('PLAYER_STARTED_MOVING',function() Info.Moving = true; end)
EventHandler:Register('PLAYER_STOPPED_MOVING',function() Info.Moving = false; end)

local function UpdateLocation()
	if MapData:SaveMapState() then
		SetMapToCurrentZone();
		local map = GetCurrentMapAreaID();
		local floor = GetCurrentMapDungeonLevel();
		MapData:LoadMapState();
		if Info.Map ~= map or Info.Floor ~= floor then
			UpdatePosition();
			Info.Map, Info.Floor = map, floor;
			EventHandler:Trigger('PLAYER_MAP_CHANGED', map, floor);
		end
	end
end
EventHandler:Register('ZONE_CHANGED',UpdateLocation);
EventHandler:Register('ZONE_CHANGED_INDOORS',UpdateLocation);
EventHandler:Register('ZONE_CHANGED_NEW_AREA',UpdateLocation);
EventHandler:Register('PLAYER_ENTERING_WORLD',UpdateLocation);

--[[
function Info.DumpLocation()
	local x,y,m,f = Info.X,Info.Y,Info.Map,Info.Floor;
	print(x,y,m,f);
	print( MapData:Translate(m,f,x,y) );
	StaticPopup_Show('GOSSIP_ENTER_CODE').editBox:SetText( strjoin(',',x,y,m,f) )
end
--]]

-- TODO: class, spec, ilvl, exp, etc.