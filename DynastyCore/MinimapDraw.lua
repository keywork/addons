local ADDON_NAME, Core = ...;

local EventHandler = Core.EventHandler;
local MapData = Core.MapData;
local PlayerInfo = Core.PlayerInfo;
local Canvas = Core.Canvas;

local MapDraw = {};
Core.MapDraw = MapDraw;

local pairs,select,unpack
	= pairs,select,unpack;
local GetCurrentMapDungeonLevel,GetCurrentMapAreaID
	= GetCurrentMapDungeonLevel,GetCurrentMapAreaID;
local WorldMapFrame
	= WorldMapFrame;

local Initialized = false;
local WorldMapCanvas;
local Shapes = {};
local ShapesChanged = true;
local MapWidth,MapHeight;

function MapDraw:Init()
	if Initialized then return end
	
	WorldMapCanvas = CreateFrame('Frame',nil,WorldMapDetailFrame)
	WorldMapCanvas:SetAllPoints();
	MapWidth,MapHeight = WorldMapCanvas:GetSize();
	
	Initialized = true;
end

local function TranslateShape(shape,...)
	if shape == 'Line' then
		local sx,sy,ex,ey = ...;
		return shape, MapWidth*sx, -MapHeight*sy, MapWidth*ex, -MapHeight*ey;
	end
end

function MapDraw:Add(map,floor,...)
	local s = {map,floor,TranslateShape(...)};
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


function MapDraw:Update()
	Canvas:Clear(WorldMapCanvas);
	ShapesChanged = false;
	if not WorldMapFrame:IsShown() then
		return true;
	end
	local map = GetCurrentMapAreaID();
	local floor = GetCurrentMapDungeonLevel();
	for s in pairs(Shapes) do
		if s[1] == map and s[2] == floor then
			Canvas:Draw(WorldMapCanvas, select(3,unpack(s)));
		end
	end
	return true; -- for onupdate event call, turn off.
end

EventHandler:Register('WORLD_MAP_UPDATE',function()
	MapDraw:Update();
end);
EventHandler:Register('ON_UPDATE',function()
	if ShapesChanged then
		MinimapDraw:Update();
	end
end);