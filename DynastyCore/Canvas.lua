local ADDON_NAME, Core = ...;

local Canvas = {};
Core.Canvas = Canvas;

local SHAPES = {};
SHAPES.Line = {
	Setup = function(line,c) -- run once
		line.Texture = c:CreateTexture();
		line.Texture:SetTexture('Interface/AddOns/DynastyCore/Media/Line.blp');
		line.Shadow = c:CreateTexture();
		line.Shadow:SetTexture('Interface/AddOns/DynastyCore/Media/Line.blp');
		line.Shadow:SetVertexColor(0,0,0,0.4);
	end,
	Init = function(line)
		line:SetColor(1,1,1,1);
		line:SetLayer(1); -- TODO: fix shaow overlap
	end,
	Draw = function(line,c)
		local sx,sy,ex,ey,w = unpack(line);
		if sx == ex and sy == ey then
			line:SetShown(false);
			line.Active = false;
			return;
		end
		
		w = w or 14;
		local dx,dy = ex-sx, ey-sy;
		local cx,cy = (sx+ex)/2, (sy+ey)/2;
		if dx < 0 then
			dx,dy = -dx,-dy;
		end
		local l = ((dx*dx)+(dy*dy))^0.5;
		local s,c = -dy/l, dx/l;
		local sc = s*c;
		local Bwid, Bhgt, BLx, BLy, TLx, TLy, TRx, TRy, BRx, BRy;
		if (dy >= 0) then
			Bwid = ((l * c) - (w * s));
			Bhgt = ((w * c) - (l * s));
			BLx, BLy, BRy = (w / l) * sc, s * s, (l / w) * sc;
			BRx, TLx, TLy, TRx = 1 - BLy, BLy, 1 - BRy, 1 - BLx; 
			TRy = BRx;
		else
			Bwid = ((l * c) + (w * s));
			Bhgt = ((w * c) + (l * s));
			BLx, BLy, BRx = s * s, -(l / w) * sc, 1 + (w / l) * sc;
			BRy, TLx, TLy, TRy = BLx, 1 - BRx, 1 - BLx, 1 - BLy;
			TRx = TLy;
		end
		Bwid = Bwid*0.51;
		Bhgt = Bhgt*0.51;
		if not pcall(line.Texture.SetTexCoord, line.Texture, TLx, TLy, BLx, BLy, TRx, TRy, BRx, BRy) then
			line.Texture:SetTexCoord(0,0,0,0); -- coords are fucked, TODO: find limits
		end
		line.Texture:SetPoint('TOPLEFT',cx-Bwid,cy+Bhgt);
		line.Texture:SetSize(Bwid*2,Bhgt*2);
		if not pcall(line.Shadow.SetTexCoord, line.Shadow, TLx, TLy, BLx, BLy, TRx, TRy, BRx, BRy) then
			line.Shadow:SetTexCoord(0,0,0,0); -- coords are fucked
		end
		line.Shadow:SetPoint('TOPLEFT',(cx-Bwid)+2,(cy+Bhgt)-3);
		line.Shadow:SetSize(Bwid*2,Bhgt*2);
	end,
	SetShown = function(line,show)
		line.Texture:SetShown(show);
		line.Shadow:SetShown(show);
	end,
	SetColor = function(line,...)
		line.Texture:SetVertexColor(...)
	end,
	SetLayer = function(line,layer)
		line.Texture:SetDrawLayer('OVERLAY');
		line.Shadow:SetDrawLayer('BACKGROUND');
	end,
	Translate = function(line,ox,oy,ow,oh,nx,ny,nw,nh)
		
	end,
};
SHAPES.Circle = {
	Setup = function(circle,c)
		circle.Texture = c:CreateTexture();
		circle.Texture:SetTexture('Interface/BUTTONS/GreyscaleRamp64');
		circle.Texture:SetMask('Interface/CharacterFrame/TempPortraitAlphaMask');
		circle.Shadow = c:CreateTexture();
		circle.Shadow:SetTexture('Interface/BUTTONS/GreyscaleRamp64');
		circle.Shadow:SetMask('Interface/CharacterFrame/TempPortraitAlphaMask');
		circle.Shadow:SetVertexColor(0,0,0,0.4);
		circle.Shadow:SetPoint('CENTER',circle.Texture,'CENTER',0,0);
	end,
	Init = function(circle)
		circle:SetColor(1,1,1,1);
		circle:SetLayer(1); -- TODO: fix shaow overlap
	end,
	
	Draw = function(circle,c)
		local x,y,r = unpack(circle);
		if r == 0 or not r then
			circle:SetShown(false);
			circle.Active = false;
			return;
		end
		circle.Texture:SetSize(r*2,r*2);
		--circle.Shadow:SetSize(r*2,r*2);
		circle.Shadow:SetSize(30,30);
		circle.Texture:SetPoint('TOPLEFT',x-r,y+r);
	end,
	
	SetShown = function(circle,show)
		circle.Texture:SetShown(show);
		circle.Shadow:SetShown(show);
	end,
	SetColor = function(circle,...)
		circle.Texture:SetVertexColor(...)
	end,
	SetLayer = function(circle,layer)
		circle.Texture:SetDrawLayer('OVERLAY');
		circle.Shadow:SetDrawLayer('BACKGROUND');
	end,
	Translate = function(circle,ox,oy,ow,oh,nx,ny,nw,nh)
		
	end,
}

for type,mt in pairs(SHAPES) do
	mt.Type = type;
	mt.__index = mt;
end

-- Shape Database/Cache
local DB = {};

function Canvas:Clear(c)
	if not DB[c] then return end
	for i,shape in pairs(DB[c]) do
		shape:SetShown(false);
		shape.Active = false;
	end
end

function Canvas:Draw(c,type,...)
	if not (type and SHAPES[type]) then return end
	DB[c] = DB[c] or {};
	local shapes,s = DB[c];
	for i,shape in pairs(shapes) do
		if shape.Type == type and not shape.Active then
			s = shape;
			s:Init();
			break;
		end
	end
	if not s then -- spawn new shape
		s = {};
		setmetatable(s, SHAPES[type]);
		shapes[#shapes+1] = s;
		s:Setup(c);
	end
	s.Active = true;
	s:SetShown(true)
	s[1],s[2],s[3],s[4],s[5],s[6],s[7],s[8],s[9] = ...; -- faster than looping selects
	s:Draw(c);
	return s;
end

function Canvas:Update(c)
	if not DB[c] then return end
	for i,shape in pairs(DB[c]) do
		shape:Draw();
	end
end
