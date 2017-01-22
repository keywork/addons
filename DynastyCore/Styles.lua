local ADDON_NAME, Core = ...;
local LibElci = Core.LibElci;

local BACKDROP_NOISE = {
	bgFile = 'Interface/AddOns/DynastyCore/Media/Noise',
	edgeFile = "Interface/Buttons/WHITE8X8",
	edgeSize = 1,
};

LibElci:AddStyle('Button','Dynasty',function(c,icon)
	c:SetBackdrop(BACKDROP_NOISE);
	c:SetColor(0.6,0.3,0.15,1);
	c:SetPushedColor(1,0.6,0.3,1);
	c:SetBorderColor(0.36,0.18,0.09,0.6);
	c:SetBorderPushedColor(0.6,0.36,0.18,0.6);
	c:SetTextPushedColor(1,0.7,0,1)
	c.Text:SetShadowColor(0,0,0,0.5);
	c.Text:SetShadowOffset(1,-1);
	
	c.Shadow = c.Shadow or c:CreateTexture();
	c.Shadow:SetColorTexture(0,0,0,0.7);
	c.Shadow:SetPoint('BOTTOMLEFT',1,-2);
	c.Shadow:SetPoint('TOPRIGHT',1,-1);
	c.Shadow:SetDrawLayer('BACKGROUND',-1);
	
	c.Gradient = c.Gradient or c:CreateTexture();
	c.Gradient:SetPoint('TOPLEFT');
	c.Gradient:SetPoint('BOTTOMRIGHT');
	c.Gradient:SetColorTexture(1,1,1,1);
	c.Gradient:SetGradientAlpha("VERTICAL",0,0,0,0.5,0,0,0,0);
	
	if icon then
		c.Icon = c:Create('Texture');
		c.Icon:SetPoint('TOPLEFT',3,-3);
		c.Icon:SetSize(16,16);
		c.Icon:SetTexCoord(0.075,0.925,0.075,0.925);
		c.Text:ClearAllPoints();
		c.Text:SetPoint('LEFT',c.Icon,'RIGHT',4,0);
		c.Text:SetJustifyH('LEFT');
	end
end);

LibElci:AddStyle('EditBox','Dynasty',function(c)
	c:SetBackdrop(BACKDROP_NOISE);
	c:SetColor(0.6,0.3,0.15,1);
	c:SetBorderColor(0.2,0.1,0.05,1);
end);

LibElci:AddStyle('Window','Dynasty',function(c,addCloseBtn)
	c:SetBackdrop({
		bgFile = 'Interface/AddOns/DynastyCore/Media/Noise',
		edgeFile = "Interface/Addons/DynastyCore/Media/Edge1",
		edgeSize = 8,
		tile = true,
		tileSize = 140,
		insets = {left=7,right=7,top=7,bottom=7},
	});
	c:SetBackdropColor(0.3,0.15,0.075,1);
	
	if addCloseBtn then
		local HeaderBtnBG = c:CreateTexture();
		HeaderBtnBG:SetColorTexture(0.2,0.1,0.05,1);
		HeaderBtnBG:SetPoint('TOPRIGHT',-6,-6);
		HeaderBtnBG:SetSize(20,10);
		
		local CloseBtn = c:Create('Button',c.HideSelf);
		CloseBtn:SetSize(18,9);
		CloseBtn:SetPoint('TOPRIGHT',-7,-6);
		CloseBtn:SetColor(0.3,0.05,0.05,1);
		CloseBtn:SetPushedColor(0.6,0.3,0.3,1);
		CloseBtn:SetBorderColor(0,0,0,0.4);
	end
end);

LibElci:AddStyle('Frame','Dynasty',function(c)
	c:SetBackdrop({
		bgFile = 'Interface/AddOns/DynastyCore/Media/Noise',
		edgeFile = "Interface/Buttons/WHITE8X8",
		edgeSize = 1,
	});
	c:SetBackdropColor(0.25,0.1,0.05,0.6);
	c:SetBackdropBorderColor(1,0.5,0.25,0.08);
end);

LibElci:AddStyle('ScrollFrame','Dynasty',function(c)
	c:SetBackdrop({
		bgFile = 'Interface/AddOns/DynastyCore/Media/Noise',
		edgeFile = "Interface/Buttons/WHITE8X8",
		edgeSize = 1,
	});
	c:SetBackdropColor(0.25,0.1,0.05,0.6);
	c:SetBackdropBorderColor(1,0.5,0.25,0.08);
	c.ScrollBar.Bar:SetColorTexture(0.6,0.3,0.15,0.2);
end);

LibElci:AddStyle('DataTable','Dynasty',function(c)
	c:SetBackdrop({
		bgFile = 'Interface/AddOns/DynastyCore/Media/Noise',
		edgeFile = "Interface/Buttons/WHITE8X8",
		edgeSize = 1,
	});
	c:SetBackdropColor(0.25,0.1,0.05,0.6);
	c:SetBackdropBorderColor(1,0.5,0.25,0.08);
	c.ScrollBar.Bar:SetColorTexture(0.6,0.3,0.15,0.2);
	c.HideEmptyRows = true;
	for i,r in pairs(c.Rows) do
		r:SetStyle('Dynasty');
	end
end);

LibElci:AddStyle('DropDownMenu','Dynasty',function(c)
	c:SetBackdrop(BACKDROP_NOISE);
	c:SetColor(0.6,0.3,0.15,1);
	c:SetPushedColor(1,0.6,0.3,1);
	c:SetBorderColor(0.36,0.18,0.09,0.6);
	c:SetBorderPushedColor(0.6,0.36,0.18,0.6);
	c:SetTextPushedColor(1,0.7,0,1)
	c.Text:SetShadowColor(0,0,0,0.75);
	c.Text:SetShadowOffset(1,-1);
	c.Menu:SetBackdrop(BACKDROP_NOISE);
	c.Menu:SetBackdropColor(0.6,0.3,0.15,1);
	c.Menu:SetBackdropBorderColor(0.36,0.18,0.09,0.6);
	
	c.Menu.Shadow = c.Menu.Shadow or c.Menu:CreateTexture();
	c.Menu.Shadow:SetColorTexture(0,0,0,0.5);
	c.Menu.Shadow:SetPoint('BOTTOMLEFT',2,-2);
	c.Menu.Shadow:SetPoint('TOPRIGHT',1,-1);
	c.Menu.Shadow:SetDrawLayer('BACKGROUND',-1);
	
	c.Gradient = c.Gradient or c:CreateTexture();
	c.Gradient:SetAllPoints();
	c.Gradient:SetTexture(1,1,1,1);
	c.Gradient:SetGradientAlpha("VERTICAL",0,0,0,0.4,0,0,0,0);
	
	c.Shadow = c.Shadow or c:CreateTexture();
	c.Shadow:SetColorTexture(0,0,0,0.5);
	c.Shadow:SetPoint('BOTTOMLEFT',1,-1);
	c.Shadow:SetPoint('TOPRIGHT',1,-1);
	c.Shadow:SetDrawLayer('BACKGROUND',-1);
	
	for i,btn in pairs(c.Buttons) do
		btn:SetColor(0.12,0.06,0.03,0.8);
		btn:SetBorderColor(0,0,0,0.2);
		btn:SetPushedColor(0.3,0.15,0.075,1);
		btn.Text:SetShadowColor(0,0,0,1);
		btn.Text:SetShadowOffset(1,-1);
	end
end);

LibElci:AddStyle('Slider','Dynasty',function(c)
	c.Rail:SetColorTexture(0.6,0.36,0.18,0.5);
	c.Rail:SetGradient('VERTICAL',1,1,1,0.25,0.25,0.25);
	c.Bar:SetColorTexture(0.6,0.36,0.18,0.8);
	c.Bar:SetSize(8,3);
end)

-- helper function for cutting up texture file.
local NewTexture = function( p,x,y,w,h )
	local t = p:CreateTexture();
	t:SetTexture('Interface\\AddOns\\DynastyCore\\Media\\Textures');
	t:SetTexCoord( x/1024, (x+w)/1024, y/128, (y+h)/128 );
	t:SetSize(w,h);
	return t;
end

function Core:StyleMainWindow(f, opts)
	f:SetBackdrop(nil);
	
	-- Frame Art
	local TL = NewTexture(f,0,0,158,72);
	TL:SetPoint('TOPLEFT');
	local TR = NewTexture(f,496,0,158,72);
	TR:SetPoint('TOPRIGHT');
	
	local TLS = NewTexture(f,158,0,142,72);
	TLS:SetPoint('TOPLEFT',TL,'TOPRIGHT');
	local TRS = NewTexture(f,354,0,142,72);
	TRS:SetPoint('TOPRIGHT',TR,'TOPLEFT');
	
	local icon;
	if opts.IconX then
		icon = NewTexture(f,opts.IconX,opts.IconY,40,40);
		icon:SetPoint('TOP',0,-8);
		icon:SetDrawLayer('ARTWORK',2)
		local TM = NewTexture(f,300,0,54,72);
		TM:SetPoint('TOP');
		TLS:SetPoint('RIGHT',TM,'LEFT');
		TRS:SetPoint('LEFT',TM,'RIGHT');
	else
		TLS:SetPoint('RIGHT',f,'CENTER');
		TRS:SetPoint('LEFT',f,'CENTER');
	end
	
	
	local R = NewTexture(f,0,72,20,1);
	R:SetPoint('TOPLEFT',0,-72);
	R:SetPoint('BOTTOM',0,27);
	
	local L = NewTexture(f,634,72,20,1);
	L:SetPoint('TOPRIGHT',0,-72);
	L:SetPoint('BOTTOM',0,27);
	
	local BL = NewTexture(f,0,73,180,27);
	BL:SetPoint('BOTTOMLEFT');
	local BR = NewTexture(f,474,73,180,27);
	BR:SetPoint('BOTTOMRIGHT');
	local BM = NewTexture(f,300,73,54,27);
	BM:SetPoint('LEFT',BL,'RIGHT');
	BM:SetPoint('RIGHT',BR,'LEFT');
	
	local C = f:CreateTexture();
	C:SetColorTexture(12/256,4/256,2/256);
	C:SetPoint('TOPLEFT',20,-72);
	C:SetPoint('BOTTOMRIGHT',-20,27);
	
	local CloseBtn = f:Create('Button',f.HideSelf);
	CloseBtn:SetBackdrop({});
	CloseBtn:SetColor(1,0,0);
	CloseBtn:SetPushedColor(1,1,0);
	CloseBtn:SetTexture( NewTexture(CloseBtn,654,0,17,16) );
	CloseBtn:SetSize(17,16);
	CloseBtn:SetPoint('TOPRIGHT',-22,-3);
	
	
	if opts.Resize then
		local Resizer = CreateFrame('Button',nil,f);
		Resizer:SetMovable(true);
		Resizer:SetSize(24,24);
		Resizer:SetPoint('BOTTOMRIGHT');
		Resizer:RegisterForDrag('LeftButton');
		Resizer:SetScript('OnDragStart', function(c)
			local sx,sy = c:GetCenter();
			local sw,sh = f:GetSize()
			local x,y = f:GetCenter();
			f:ClearAllPoints();
			
			f:SetPoint('TOPLEFT',x-(sw/2),-(f:GetParent():GetHeight()-(y+(sh/2))));
			c:SetScript('OnUpdate',function(c)
				local x,y = c:GetCenter();
				f:SetSize(max(f.MinWidth or 370, sw+(x-sx)), max(f.MinHeight or 100, sh-(y-sy)));
			end)
			c:StartMoving();
		end);
		Resizer:SetScript('OnDragStop', function(c)
			c:SetScript('OnUpdate',nil);
			c:StopMovingOrSizing();
			c:ClearAllPoints();
			c:SetPoint('BOTTOMRIGHT',f,'BOTTOMRIGHT',-4,4);
		end);
	end
end