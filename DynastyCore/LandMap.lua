local ADDON_NAME, Core = ...;

if true then return end

local floor
	= floor;

local UnitPosition
	= UnitPosition;

local PlayerInfo = Core.PlayerInfo;
local MapData = Core.MapData;
local MapDraw = Core.MapDraw;
local EventHandler = Core.EventHandler;
local LibElci = Core.LibElci;

--[[

packed state:
0xFFFF map
0xFF floor
0xF z
top 4 bits unused.

(map*0x10000)+(floor*0x100)+z

[map/level/z] key
vertices: {x+y, x+y, x+y, ...}
connections: {type+i1+i2, type+i1+i2, ...}

unpacked state: (loaded for current map/level)
nodes: {
	{player-node, {outgoing-connections}}
	{x,y, {outgoing-connections}}
}


[map] => {
	[level] => {
		[z] => {0xXXXXYYYY, ....}, // normalised continent position
		[z] => {},
	}
	[level] => {
	}
	...
	connections = {
		[level+z+i]+[level+z+i]+[type], 
	}
}

START:
building = true

EVERY-FRAME/MOVE:
if building ~= true then return end
if player is not within [radius] yards of a vertex, or force drop
	if up/down mode is set then
		level = level [+-] 1
		add connector between levels
	end
	add vertex here
end

UP/DOWN buttons:
connect-mode = up/down

]]
local VERTICES = {};
local RUNNING = false;
local RADIUS = 10;

local function AddVertex(forced)
	
	local m,f = PlayerInfo.Map, PlayerInfo.Floor;
	local y,x = UnitPosition('Player');
	x,y = floor(x+0.5),floor(y+0.5);
	
	if not forced then -- check if any other vertices are in range, if so: do nothing.
		for i,v in pairs(VERTICES) do
			local d = ((v.x-x)^2+(v.y-y)^2)^0.5;
			if d < (RADIUS/1.5) then return end -- still within radius of another vertex.
		end
	end
	
	VERTICES[#VERTICES+1] = {x=x,y=y};
	local mx,my = MapData:Untranslate( m,f,x,y );
	MapDraw:Add(m,f,'Circle', mx,my,2);
	
	print(x,y);
end

C_Timer.NewTicker(0.05, function()
	if not RUNNING then return end
	AddVertex();
end)


do
local window = LibElci.Create(UIParent,'Window');
window:SetSize(300,200);
window:SetPoint('CENTER');

local cframe = window:Create('Frame');
cframe:SetPoint('BOTTOMRIGHT',-2,2);
cframe:SetPoint('TOPRIGHT',-2,-2);
cframe:SetWidth(100);

local sbtn = cframe:Create('Button',function(c)
	RUNNING = not RUNNING;
	if RUNNING then c:SetColor(0.2,0.05,0.05,1);
	else c:SetColor(0.05,0.3,0.05,0.6); end
end);
sbtn:SetPoint('BOTTOM',0,4);
sbtn:SetSize(90,20);
sbtn:SetColor(0.05,0.3,0.05,0.6);
sbtn:SetPushedColor(1,1,1);
sbtn:SetText('Start / Stop');

local fbtn = cframe:Create('Button',AddVertex);
fbtn:SetPoint('TOP',0,-4);
fbtn:SetSize(90,20);
fbtn:SetText('Add Vertex');

end

