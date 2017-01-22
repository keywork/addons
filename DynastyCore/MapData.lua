local ADDON_NAME, Core = ...;

local EventHandler = Core.EventHandler;

local select,atan2
	= select,atan2;
local GetCurrentMapAreaID,GetCurrentMapContinent,GetCurrentMapDungeonLevel,GetCurrentMapDungeonLevel,GetMapInfo,SetMapToCurrentZone,SetMapZoom,SetMapByID
	= GetCurrentMapAreaID,GetCurrentMapContinent,GetCurrentMapDungeonLevel,GetCurrentMapDungeonLevel,GetMapInfo,SetMapToCurrentZone,SetMapZoom,SetMapByID;
local GetMapNameByID,GetNumDungeonMapLevels,GetCurrentMapZone,GetNumMapOverlays,GetMapOverlayInfo,GetMapContinents,GetMapZones,SetDungeonMapLevel
	= GetMapNameByID,GetNumDungeonMapLevels,GetCurrentMapZone,GetNumMapOverlays,GetMapOverlayInfo,GetMapContinents,GetMapZones,SetDungeonMapLevel;
local WorldMapFrame = WorldMapFrame;
local RADEG = PI/180;

local MapData = {};
Core.MapData = MapData;

local data = {};
local zones = {};

-- TODO: micro dungeon scanner
--local MicroDungeonEntryPoints = {
	--ShrineofSevenStars = {811, 0.904575, 0.710943},
--};

function MapData:ScanAllMaps()
	--WorldMapFrame:UnregisterEvent('WORLD_MAP_UPDATE');
	for map = 1,2000 do
		if SetMapByID(map) then
			local d = {
				Name = GetMapNameByID(map),
				Continent = GetCurrentMapContinent(),
				IsDungeon = GetNumDungeonMapLevels() ~= nil,
				--DungeonLevel = GetCurrentMapDungeonLevel() - (DungeonUsesTerrainMap() and 1 or 0);
				Zone = GetCurrentMapZone(),
			};
			
			if d.IsDungeon then
				d.Floors = {GetNumDungeonMapLevels()};
				for i,f in pairs(d.Floors) do
					SetDungeonMapLevel(f);
					d[f] = {GetCurrentMapDungeonLevel()};
				end
			else -- outdoor map (scan for overlays)
				d[0] = {GetCurrentMapZone()};
				d.Overlays = {};
				for i = 1, GetNumMapOverlays() do
					d.Overlays[i] = {GetMapOverlayInfo(i)};
				end
			end
			
			-- Texture info
			local fileName, _, _, isMicro, microFileName = GetMapInfo();
			d.FileName = fileName;
			d.TileTexture = 'Interface/WorldMap/'..(isMicro and ('MicroDungeon/'..fileName..'/'..microFileName..'/'..microFileName) or (fileName..'/'..fileName));
				--..(d.DungeonLevel > 0 and (d.DungeonLevel..'_') or '');
			
			-- TODO: dungeons (non-micro) shouldn't have continents
			for i = 1,9 do -- Try find map continent.
				if d.Continent ~= -1 then break end
				ZoomOut();
				d.Continent = GetCurrentMapContinent();
			end
			data[map] = d;
		end
	end
	for c = 1, select('#', GetMapContinents()) do
		zones[c] = {};
		for z = 1, select('#', GetMapZones(c)) do
			SetMapZoom(c,z);
			zones[c][z] = GetCurrentMapAreaID();
		end
	end
	WorldMapFrame:RegisterEvent('WORLD_MAP_UPDATE');
end
function MapData:Expose()
	return data;
end

-- Map preservation stuff so the user can look around while we're abusing it.
local msOpen,msID,msContinent,msLevel,msMicro;
function MapData:SaveMapState()
	if msID then
		error('multi-save');
		return false;
	end
	msOpen = WorldMapFrame:IsShown();
	if msOpen then
		msID = GetCurrentMapAreaID();
		msContinent = GetCurrentMapContinent();
		msLevel = GetCurrentMapDungeonLevel();
		msMicro = select(5,GetMapInfo());
		WorldMapFrame:UnregisterEvent('WORLD_MAP_UPDATE');
		EventHandler.Silenced.WORLD_MAP_UPDATE = true;
	end
	return true;
end
function MapData:LoadMapState()
	if msOpen then
		if msMicro then -- hardmode engaged, player was viewing a micro dungeon
			-- there are only two ways to load a micro dungeon, clicking on it on the map (unavailable for most)
			-- or by being inside it and calling SetMapToCurrentZone.
			-- so if the map has no known entry point, we can be pretty sure that the player is inside it.
			--local ep = MicroDungeonEntryPoints[msMicro];
			--if ep then
			--	SetMapByID( ep[1] );
			--	ProcessMapClick( ep[2], ep[3] );
				-- DungeonMapLevel?
			--else
				SetMapToCurrentZone();
			--end
		else
			if msID == -1 then
				SetMapZoom(msContinent);
			else
				SetMapByID(msID or 0);
			end
			SetDungeonMapLevel(msLevel or 0);
		end
		WorldMapFrame:RegisterEvent('WORLD_MAP_UPDATE');
		EventHandler.Silenced.WORLD_MAP_UPDATE = nil;
		msID = nil;
	end
end

-- Map Textures
-- Returns a list of texture info to display the map.
function MapData:GetTextures( map, floor )
	map, floor = data[map], floor or 0;
	if not (map and map[floor]) then return end
	local t = {};
	local tilePrefix = map.TileTexture..(floor>0 and (floor..'_') or '');
	for i = 1,GetNumberOfDetailTiles() do
		t[i] = {tilePrefix..i,0,((i-1)%4)*256,math.floor((i-1)/4)*256,256,256};
	end
	if map.Overlays then
		-- thanks blizzard for making this so simple...
		local ceil,log,log2 = math.ceil,math.log,math.log(2);
		for i, overlay in pairs(map.Overlays) do
			local file, fw,fh, xo,yo = unpack(overlay);
			local cols,rows = ceil(fw/256),ceil(fh/256);
			local index = 1;
			for y = 1, rows do
				local ch = (y == rows) and (2^ceil(log(1+((fh-1)%256))/log2)) or 256;
				for x = 1,cols do
					local cw = (x == cols) and (2^ceil(log(1+((fw-1)%256))/log2)) or 256;
					t[#t+1] = {file..index,1,xo+(x-1)*256,yo+(y-1)*256,cw,ch};
					index = index + 1;
				end
				
			end
		end
	end
	return t;
end

-- Map handling functions
function MapData:Get( map, floor )
	return floor and data[map][floor] or data[map];
end
function MapData:IsSameContinent( map1, map2 )
	map1 = data[map1];
	map2 = data[map2];
	return map1 and map2 and map1.Continent == map2.Continent;
end
function MapData:GetMapZone(map)
	local d = data[map];
	if d then
		return d.Zone, d.Continent;
	end
end
function MapData:GetZoneMap(z,c)
	return c and z and zones[c] and zones[c][z];
end

function MapData:Translate( map,floor,x,y ) 
	local d = map and floor and data[map] and data[map][floor];
	if d and d[2] and d[3] then
		local mx, my = d[2], d[3];
		return mx+(d[4]-mx)*x,my+(d[5]-my)*y;
	end
end

function MapData:Untranslate( map,floor,x,y ) -- wtf is this?
	local d = map and floor and data[map] and data[map][floor];
	if d then
		local mx, my = d[2], d[3];
		return 1-((x-mx)/(d[4]-mx)), 1-((y-my)/(d[5]-my));
	end
end

function MapData:GetMapPosition( map,floor,cx,cy )
	local d = data[map][floor];
	if d then
		local mx,my = d[2], d[3];
		return (cx-mx)/(d[4]-mx), (cy-my)/(d[5]-my);
	end
end

function MapData:GetSize( map, floor )
	if not data[map] then
		return 0,0;
	end
	local d = data[map][floor or 0];
	if d then
		return d[2]-d[4], d[3]-d[5];
	end
end
MapData.MapArea = MapData.GetSize;

function MapData:GetDistance( sMap, sFloor, sX, sY, dMap, dFloor, dX, dY )
	if not ( sMap and sFloor and sX and sY and dMap and dFloor and dX and dY )
	or not self:IsSameContinent( sMap, dMap ) then
		return;
	end
	local x1,y1 = self:Translate( sMap, sFloor, sX, sY );
	local x2,y2 = self:Translate( dMap, dFloor, dX, dY );
	return self:Distance(x1,y1,x2,y2);
end
function MapData:Distance(x1,y1,x2,y2,angle)
	local x = x2-x1;
	local y = y2-y1;
	return (x^2+y^2)^0.5, angle and (atan2(x,y)*RADEG);
end

-- p = DynastyCore.PlayerInfo;
-- 0,0 = 32_32 (topleft corner)
-- 256,256 = 31,31
-- -256,-256 = 33,33
DERP = UIParent:CreateTexture();
DERP:SetPoint('CENTER');
DERP:SetSize(256,256)
-- /run DERP:SetTexture('World/Minimaps/Azeroth/map30_48')
-- /dump DynastyCore.MapData:GetMinimapTile( 14 )
function MapData:GetMinimapTile( m )
	local tsize = 34133.33312 / 64; -- size of map, 64x64 grid .. tile size
	
	m = m or Core.PlayerInfo.Map;
	local x = Core.PlayerInfo.X;
	local y = Core.PlayerInfo.Y;
	local d = data[m][0];
	print(x,y);
	local tx = floor(32-(x/tsize));
	local ty = floor(32-(y/tsize));
	
	DERP:SetTexture('World/Minimaps/'..data[m].FileName..'/map'..tx..'_'..ty);
	return 'World/Minimaps/'..data[m].FileName..'/map'..tx..'_'..ty;
end

--[[
-- WoW's lua implementation floors non-integral numbers for bit ops, can save some calls there.
local function enc(x,y)
	return bit.lshift(x*1e4,16)+floor(y*1e4);
end
local function dec(v)
	return bit.rshift(v,16), bit.band(0xFFFF,v);
end
--]]