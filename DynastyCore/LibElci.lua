local ADDON_NAME, ADDON = ...;


local VERSION = 0.18;
if LibElci and LibElci.Version == VERSION then
	ADDON.LibElci = LibElci;
	return;
end


local unpack,setmetatable,getmetatable,abs,max,min,CreateFrame,select,floor,ceil
	= unpack,setmetatable,getmetatable,abs,max,min,CreateFrame,select,floor,ceil;
local C_Timer
	= C_Timer;

local LerpColor = function(a,b,v)
	return a[1]+(b[1]-a[1])*v, a[2]+(b[2]-a[2])*v, a[3]+(b[3]-a[3])*v, a[4]+(b[4]-a[4])*v;
end
local SetColor = function(c,r,g,b,a,d)
	c[1] = r or c[1] or (d and d[1]) or 0;
	c[2] = g or c[2] or (d and d[2]) or 0;
	c[3] = b or c[3] or (d and d[3]) or 0;
	c[4] = a or c[4] or (d and d[4]) or 1;
end

local LibElci = {};
ADDON.LibElci = LibElci;


local Styles = {};
local Components = {};
 -- TODO: check boxes, etc
Components.Frame = {
	Create = function(self,parent,name)
		local c = CreateFrame('Button',name,parent);
		c:EnableMouse(false);
		c:SetBackdrop({
			bgFile = "Interface\\Buttons\\WHITE8X8",
			edgeFile = "Interface\\Buttons\\WHITE8X8",
			edgeSize = 1,
		});
		c:SetBackdropColor(1,1,1,0.02);
		c:SetBackdropBorderColor(1,1,1,0.05);
		c.ShowSelf = function()c:Show();end
		c.HideSelf = function()c:Hide();end
		return c;
	end,
	Show = function(c)
		if c.ShowTicker then
			return;
		end
		local ta = c:GetAlpha();
		if c.HideTicker then
			ta = ta + ((10-c.HideTicker._remainingIterations)*0.1);
			c.HideTicker:Cancel();
			c.HideTicker = nil;
		end
		if c:IsShown() and c:GetAlpha() == ta then
			return;
		end
		local a = 0;
		c.ShowTicker = C_Timer.NewTicker(0.025,function(ticker)
			a = a+0.1;
			c:SetAlpha(a*ta);
			if ticker._remainingIterations <= 1 then
				c.ShowTicker = nil;
			end
		end,10)
		c:SetAlpha(0);
		c:SetShown(true);
	end,
	Hide = function(c)
		if c.ShowTicker then
			c.ShowTicker:Cancel();
			c.ShowTicker = nil;
		end
		local a = 1;
		c.HideTicker = c.HideTicker or C_Timer.NewTicker(0.025,function(ticker)
			if ticker._remainingIterations <= 1 then
				c:SetAlpha(1);
				c:SetShown(false);
				c.HideTicker = nil;
			else
				a = a-0.1;
				c:SetAlpha(a);
			end
		end,10)
	end,
	Resize = function(c,w,h,d)
		local sw,sh = c:GetSize();
		w,h = w or sw, h or sh;
		if w == sw and h == sh then
			if c.OnResize then
				c:OnResize();
			end
			return
		end
		
		local t = (d or 0.25)/0.025;
		local p = 0;
		if c.ResizeTicker then
			c.ResizeTicker:Cancel();
		end
		c.ResizeTicker = C_Timer.NewTicker(0.025,function()
			p = p+(1/t);
			c:SetSize(sw+((w-sw)*p),sh+((h-sh)*p));
			if p >= 1 then
				if w == 0 or h == 0 then
					c:SetShown(false);
				end
				c.ResizeTicker = nil;
			end
			if c.OnResize then c:OnResize() end
		end,t);
	end,
	Toggle = function(c,s)
		if s == nil then
			s = not c:IsShown();
		end
		if s then
			c:Show();
		else
			c:Hide();
		end
	end,
	Move = function(c,point,x,y,duration)
		local ap,rf,rp,ox,oy;
		point = point:upper();
		for i = 1, c:GetNumPoints() do
			ap,rf,rp,ox,oy = c:GetPoint(i);
			if ap == point then break end
		end
		if not ( ap and ap == point ) then
			return; -- anchor point not found
		end
		
		local t = (duration or 0.25)/0.025;
		local p = 0;
		x = x or ox;
		y = y or oy;
		
		c.MoveTicker = c.MoveTicker or {};
		if c.MoveTicker[point] then
			c.MoveTicker[point]:Cancel();
		end
		c.MoveTicker[point] = C_Timer.NewTicker(0.025,function()
			p = p+(1/t);
			if p >= 1 then
				c.MoveTicker[point] = nil;
			end
			c:SetPoint(point,rf,rp, ox+(x-ox)*p, oy+(y-oy)*p );
			if c.OnResize then
				c:OnResize();
			end
		end,t);
		
	end,
	-- Generic property transitioner
	Transition = function(c,prop,d,...)
		
		local get,set = c['Get'..prop],c['Set'..prop];
		if not (get and set) then
			return; -- Unhandled property.
		end
		
		local start = {get(c)}; -- ..
		local final = {...}; -- probably faster to use local select, but it gets heaps messy.
		
		print(prop,unpack(start));
		print(prop,unpack(final));
		
		local n = max(#start,#final);
		
		local changes = false;
		for i = 1, n do
			changes = changes or start[i] ~= final[i];
		end
		if not changes then return end
		
		if not c.TransTicker then
			c.TransTicker = {};
		end
		
		if c.TransTicker[prop] then
			c.TransTicker[prop]:Cancel();
		end
		
		local t = (d or 0.25)/0.025;
		local p = 0;
		local temp = {unpack(start)};
		c.TransTicker[prop] = C_Timer.NewTicker(0.025,function()
			p = p+(1/t);
			if p >= 1 then
				c.TransTicker[prop] = nil;
			end
			for i = 1, n do
				if start[i] ~= final[i] then
					temp[i] = start[i]+((final[i]-start[i])*p)
				end
			end
			print(unpack(temp));
			set(c,unpack(temp));
		end,t);
	end,
};
Components.Window = {
	Create = function(self,parent,name)
		local c = CreateFrame('Frame',name,parent);
		c:SetBackdrop({
			bgFile = "Interface\\Buttons\\WHITE8X8",
			edgeFile = "Interface\\Buttons\\WHITE8X8",
			edgeSize = 1,
			insets = {left = -1, right = -1, top = -1, bottom = -1},
		});
		c:EnableMouse(true);
		c:SetMovable(true);
		c:IsUserPlaced(true);
		c:SetClampedToScreen(true);
		c:RegisterForDrag('LeftButton');
		c:SetScript('OnDragStart', function(c) return c:IsMovable() and c:StartMoving(); end);
		c:SetScript('OnDragStop', c.StopMovingOrSizing);
		c:SetBackdropColor(0.02,0.02,0.02,1);
		c:SetBackdropBorderColor(0.3,0.3,0.3,1);
		c.ShowSelf = function()c:Show();end
		c.HideSelf = function()c:Hide();end
		return c;
	end,
	Show = Components.Frame.Show,
	Hide = Components.Frame.Hide,
	Resize = Components.Frame.Resize,
	Move = Components.Frame.Move,
	Transition = Components.Frame.Transition,
	Toggle = Components.Frame.Toggle,
};
Components.Button = {
	Create = function(self,parent,callback)
		local c = LibElci.Create(parent,'Frame');
		
		c:EnableMouse(true);
		
		c.Pressed = 0; -- 0 = not pressed, 1 = pressed
		c.Focused = 0; -- ranges from 0 to 1, depending on how long it's had focus.
		c.Step = -0.05; -- speed at which focus is altered (start negative)
		
		c.FocusLocked = false;
		c.Enabled = true;
		
		if callback then -- TODO: function check
			c.OnClick = callback;
		end
		c:SetScript('OnClick',function(...)
			return c.Enabled and c.OnClick and c.OnClick(...);
		end);
		c:SetScript('OnEnter',function()
			c.Step = abs(c.Step);
			c:Update();
			c:OnEnter();
		end);
		c:SetScript('OnLeave',function()
			c.Step = -abs(c.Step);
			c.Pressed = 0;
			c:Update();
			c:OnLeave();
		end);
		c:SetScript('OnMouseDown',function()
			c.Pressed = 1;
			c:Update();
		end);
		c:SetScript('OnMouseUp',function()
			c.Pressed = 0;
			c:Update();
		end);
		
		c.Color = {0.1,0.1,0.1,1};
		c.PushedColor = {0.3,0.3,0.3,1};
		
		--c.BorderColor = {0.12,0.12,0.12,1};
		--c.BorderPushedColor = {0.36,0.36,0.36,1};
		c.BorderFactor = 1.2;
		
		c.TextColor = {0.7,0.7,0.7,1};
		c.TextPushedColor = {1,1,1,1};
		
		c.Text = c:Create('FontString');
		c.Text:SetPoint('TOPLEFT',4,0);
		c.Text:SetPoint('BOTTOMRIGHT',-4,0);
		
		c:SetBackdrop({
			bgFile = "Interface\\Buttons\\GreyscaleRamp64",
			edgeFile = "Interface\\Buttons\\WHITE8X8",
			edgeSize = 1,
		});
		c.Texture = nil;
		
		self.Update(c);
		
		return c;
	end,
	SetTexture = function(c,t)
		c.Texture = t;
		if t then
			t:SetAllPoints(c);
		end
		c:Update();
	end,
	SetText = function(c,...)
		return c.Text:SetText(...);
	end,
	GetText = function(c,...)
		return c.Text:GetText(...);
	end,
	SetFont = function(c,...)
		return c.Text:SetFont(...);
	end,
	SetFontSize = function(c,...)
		return c.Text:SetFontSize(...);
	end,
	OnClick = nil,
	Click = function(c,...)
		c:GetScript('OnClick')(c,...);
		c:Update()
	end,
	SetColor = function(c,r,g,b,a)
		SetColor(c.Color,r,g,b,a);
		c:Update();
	end,
	SetPushedColor = function(c,r,g,b,a)
		SetColor(c.PushedColor,r,g,b,a);
		c:Update();
	end,
	SetBorderColor = function(c,r,g,b,a)
		c.BorderColor = c.BorderColor or {};
		SetColor(c.BorderColor,r,g,b,a);
		c:Update();
	end,
	SetBorderPushedColor = function(c,r,g,b,a)
		c.BorderPushedColor = c.BorderPushedColor or {};
		SetColor(c.BorderPushedColor,r,g,b,a);
		c:Update();
	end,
	SetTextColor = function(c,r,g,b,a)
		SetColor(c.TextColor,r,g,b,a);
		c:Update();
	end,
	SetTextPushedColor = function(c,r,g,b,a)
		SetColor(c.TextPushedColor,r,g,b,a);
		c:Update();
	end,
	Update = function(c,e)
		if not c.Enabled then
			c.Pressed = 0;
			c.Focused = 0;
		elseif c.FocusLocked then
			c.Focused = 1;
		else
			c.Focused = max(0,min(1,c.Focused+c.Step)); -- step focus
		end
		
		local v = min(1,c.Pressed+(0.6*c.Focused));
		local r,g,b,a = LerpColor(c.Color, c.PushedColor, v);
		if c.Texture then
			c.Texture:SetVertexColor(r,g,b,a);
		end
		c:SetBackdropColor(r,g,b,a);
		if c.BorderColor then
			c:SetBackdropBorderColor( LerpColor(c.BorderColor, c.BorderPushedColor or c.BorderColor, v) );
		else
			local f = c.BorderFactor;
			c:SetBackdropBorderColor( r*f, g*f, b*f, a*f );
		end
		c.Text:SetTextColor( LerpColor(c.TextColor, c.TextPushedColor, v) );
		
		if c.FocusLocked or c.Focused%1 == 0 then -- not currently transitioning focus
			if c:GetScript('OnUpdate') == c.Update then
				c:SetScript('OnUpdate',nil);
			end
		elseif not e then
			c:SetScript('OnUpdate',c.Update);
		end
		if c.OnUpdate then
			c:OnUpdate(v);
		end
	end,
	SetEnabled = function(c,e)
		c.Enabled = e;
		c:EnableMouse(e);
		c:SetAlpha(e and 1 or 0.3);
		c:Update();
	end,
	OnEnter = function()end,
	OnLeave = function()end,
	OnUpdate = nil,
};
Components.EditBox = {
	Create = function(self,parent,multiline)
		local c = CreateFrame('EditBox',nil,parent);
		c.Lines = 1;
		
		c.Focused = 0;
		c.Step = -0.05;
		c.Enabled = true;
		c:SetMultiLine(not not multiline);
		
		c.UpdateSelf = function()
			c:Update();
		end
		
		c.Value = '';
		c:SetScript('OnTextChanged',function(...)
			local v = c:GetText();
			if v == c.Value then return end
			c:OnTextChanged(v,c.Value);
			c.Value = v;
		end);
		
		c:SetScript('OnEscapePressed',function()
			c:ClearFocus();
			c:OnEscapePressed();
		end);
		c:SetScript('OnEnter',function()
			c.Step = abs(c.Step);
			c:Update();
			c:OnEnter();
		end);
		c:SetScript('OnEditFocusGained',function()
			if c.Value == '' then
				c.EmptyString:Hide();
			end
			c:GetScript('OnEnter')(c);
			c:OnEditFocusGained();
		end);
		c:SetScript('OnLeave',function()
			c.Step = -abs(c.Step);
			c:Update();
			c:OnLeave();
		end);
		c:SetScript('OnEditFocusLost',function()
			if c.Value == '' then
				c.EmptyString:Show();
			end
			if not c:IsMouseOver() then
				c:GetScript('OnLeave')(c);
			end
			c:OnEditFocusLost();
			-- switching editbox focus causes this script to trigger before focus is actually lost, which messes up the update.
			C_Timer.After(0.025,c.UpdateSelf);
		end);
		if not c:IsMultiLine() then
			c:SetScript('OnEnterPressed',function()
				if c.OnEnterPressed then
					c:OnEnterPressed();
				end
				if c.OnSubmit then
					c:OnSubmit(c:GetText());
					c.Value = '';
					c:SetText('');
					c:ClearFocus();
				end
			end)
		end
		c:SetAutoFocus(false);
		c:ClearFocus();
		c:SetTextInsets(4,4,2,2);
		
		c.Color = {0.075,0.075,0.075,1};
		c.BorderColor = {0.2,0.2,0.2,1};
		c.TextColor = {0.8,0.8,0.8,1};
		
		c:SetFont("Fonts\\ARIALN.TTF", 12);
		c:SetBackdrop({
			bgFile = "Interface\\Buttons\\WHITE8X8",
			edgeFile = "Interface\\Buttons\\WHITE8X8",
			edgeSize = 1,
		});
		c:SetShadowColor(0,0,0,1);
		c:SetShadowOffset(1,-1);
		
		c.TopShadow = c:CreateTexture();
		c.TopShadow:SetPoint('TOPLEFT',1,-1);
		c.TopShadow:SetPoint('RIGHT',-1,0);
		c.TopShadow:SetHeight(1);
		c.TopShadow:SetColorTexture(0,0,0,0.4)
		
		c.LeftShadow = c:CreateTexture();
		c.LeftShadow:SetPoint('TOP',c.TopShadow,'BOTTOM');
		c.LeftShadow:SetPoint('BOTTOMLEFT',1,1);
		c.LeftShadow:SetWidth(1);
		c.LeftShadow:SetColorTexture(0,0,0,0.4)
		
		c.EmptyString = c:CreateFontString();
		c.EmptyString:SetFont("Fonts\\ARIALN.TTF", 12);
		c.EmptyString:SetPoint('TOPLEFT',4,0);
		c.EmptyString:SetPoint('BOTTOMRIGHT',-4,0);
		c.EmptyString:SetJustifyH('LEFT');
		c.EmptyString:SetTextColor(1,1,1,0.3);
		c.EmptyString:SetShadowColor(0,0,0,0.4);
		c.EmptyString:SetShadowOffset(1,-1);
		
		self.Update(c);
		
		return c;
	end,
	OnUpArrow = function(c)end,
	OnDownArrow = function(c)end,
	OnEscapePressed = function(c)end,
	OnEditFocusGained = function(c)end,
	OnEditFocusLost = function(c)end,
	OnTextChanged = function(c,new,old)end,
	OnEnter = function(c)end,
	OnLeave = function(c)end,
	SetColor = Components.Button.SetColor,
	SetBorderColor = Components.Button.SetBorderColor,
	Show = Components.Frame.Show,
	Hide = Components.Frame.Hide,
	Toggle = Components.Frame.Toggle,
	SetEnabled = function(c,e)
		c.Enabled = e;
		c:EnableMouse(e);
		c:Update();
	end,
	--SetTextColor = Components.Button.SetTextColor,
	HookArrowKeys = function(c)
		c:SetHistoryLines(3);
		c:AddHistoryLine('\001');
		c:AddHistoryLine('\002');
		c:AddHistoryLine('\003');
		local p = 4;
		c:SetScript('OnTextChanged',function(...)
			local v = c:GetText();
			local b = v:byte();
			if b and b <= 3 then -- Trying to access line history (IE up/down keys)
				c[(p-b == 1 or p-b == -2) and 'OnUpArrow' or 'OnDownArrow'](c);
				p = b;
				return c:SetText(c.Value);
			end
			c:OnTextChanged(v,c.Value);
			c.Value = v;
		end);
	end,
	Update = function(c)
		c.Focused = c.Enabled and (c:HasFocus() and 1 or max(0,min(1,c.Focused+c.Step))) or 0;
		
		-- apply highlight
		local v,r,g,b,a = 1+(0.6*c.Focused);
		r,g,b,a = unpack(c.Color);
		c:SetBackdropColor(r*v,g*v,b*v,a*v);
		r,g,b,a = unpack(c.BorderColor);
		c:SetBackdropBorderColor(r*v,g*v,b*v,a*v);
		r,g,b,a = unpack(c.TextColor);
		c:SetTextColor(r*v,g*v,b*v,a*v);
		
		if c.Focused%1 == 0 then -- not currently transitioning focus
			c:SetScript('OnUpdate',nil);
		else
			c:SetScript('OnUpdate',c.Update);
		end
	end,
};
Components.ScrollBar = {
	-- TODO: bug with large scroll bars (when they are 80% bar), drag is inverted and all sorts of fucked.
	Create = function(self,parent,callback)
		local c = CreateFrame('Slider',nil,parent);
		c:SetScript('OnValueChanged',function(c,v)
			callback(v);
		end);
		c.Bar = c:CreateTexture();
		c:SetMinMaxValues(0,1);
		c:SetStepsPerPage(1);
		c:SetValueStep(1);
		
		c:SetWidth(6);
		c.Bar:SetWidth(6);
		c.Bar:SetColorTexture(0.3,0.3,0.3,1);
		c:SetThumbTexture(c.Bar);
		
		return c;
	end,
	Update = function(c)
		local pp,h,vMin,vMax = c:GetStepsPerPage(),c:GetHeight(),c:GetMinMaxValues();
		local height = max(6,min(h,h*(pp/(pp+vMax))));
		c.Bar:SetHeight(height);
		c:Step(0);
	end,
	Step = function(c,v)
		c:SetValue(c:GetValue()-v);
	end,
	ScrollTo = function(c,i)
		c:SetValue( i and min(i-1,max(i-c:GetStepsPerPage(),c:GetValue())) or (select(2,c:GetMinMaxValues())) );
	end,
};
Components.FontString = {
	Create = function(self,parent,size,flags,r,g,b,a,H,V)
		local c = parent:CreateFontString();
		c:SetFont('Fonts/ARIALN.TTF', size or 12, flags);
		 -- FRIZQT__.TTF
		 -- MORPHEUS.TTF
		c:SetJustifyH(H or 'CENTER');
		c:SetJustifyV(V or 'CENTER');
		c:SetTextColor(r or 1,g or 1,b or 1,a or 1);
		return c;
	end,
	SetFontSize = function(c,v)
		local f,s,p = c:GetFont();
		c:SetFont(f,v or s or 12,p);
	end,
	Show = Components.Frame.Show,
	Hide = Components.Frame.Hide,
	Move = Components.Frame.Move,
	Toggle = Components.Frame.Toggle,
};
Components.Texture = {
	Create = function(self,parent,...)
		local c = parent:CreateTexture();
		if (...) then
			c:SetTexture(...);
		end
		return c;
	end,
	Show = Components.Frame.Show,
	Hide = Components.Frame.Hide,
	Resize = Components.Frame.Resize,
	Move = Components.Frame.Move,
	Toggle = Components.Frame.Toggle,
};
Components.DropDownMenu = {
	Create = function(self,parent)
		local c = parent:Create('Button',function(c)
			c.Menu:Toggle()
			c.Closer._cancelled = false;
			c.Closer:_callback();
		end);
		c.Menu = c:Create('Frame');
		
		c.Value = nil;
		c.Buttons = {};
		c.MenuHeight = 3;
		
		c.Menu:SetFrameStrata('DIALOG');
		c.Menu:EnableMouse(true);
		c.Menu:SetScript('OnLeave',function() c:OnLeave() end);
		c.Menu:SetScript('OnEnter',function() c:OnEnter() end);
		c.Menu:SetPoint('TOPLEFT',c,'BOTTOMLEFT',0,-1);
		c.Menu:SetPoint('RIGHT');
		c.Menu:SetShown(false);
		
		c.Text:SetJustifyH('LEFT');
		
		c.Bar = c:CreateTexture();
		c.Bar:SetPoint('TOPRIGHT',-2,-2);
		c.Bar:SetPoint('BOTTOM',0,2);
		c.Bar:SetWidth(4);
		c.Bar:SetColorTexture(0.12,0.12,0.12,1);
		
		c.CloseTimer = 0;
		c.Closer = C_Timer.NewTicker(0.2,function()
			if not c.Menu:IsShown() then
				c.Closer:Cancel();
			end
			if c:HasFocus() then
				c.CloseTimer = 0;
				return;
			end
			c.CloseTimer = c.CloseTimer+0.2;
			if c.CloseTimer >= 2 then
				c.Menu:Hide();
				c.Closer:Cancel();
			end
		end);
		
		return c;
	end,
	AddOption = function(c,o)
		local h = o.Height or 18;
		local btn = c.Menu:Create('Button',function(btn)
			c:SetValue(o.Value);
		end);
		tinsert(c.Buttons,btn);
		btn.Options = o;
		btn.Value = o.Value;
		btn:SetText(o.Text or '');
		btn.Text:SetJustifyH('LEFT');
		btn:SetPoint('TOPLEFT',2,-(c.MenuHeight-1));
		btn:SetPoint('RIGHT',-2,0);
		btn:SetHeight(h);
		c.MenuHeight = c.MenuHeight+h+1;
		c.Menu:SetHeight(c.MenuHeight);
		return btn;
	end,
	Update = function(c)
		Components.Button.Update(c);
		c.Bar:SetColorTexture( c:GetBackdropBorderColor() );
	end,
	HasFocus = function(c)
		if c:IsMouseOver() or c.Menu:IsMouseOver() then
			return true;
		end
		for i,btn in pairs(c.Buttons) do
			if btn:IsMouseOver() or (btn.HasFocus and btn:HasFocus()) then
				return true;
			end
		end
	end,
	SetValue = function(c,v)
		if v == c.Value then return; end
		c.Value = v;
		for i,btn in pairs(c.Buttons) do
			if btn.Value == v then
				btn.FocusLocked = true;
				c:SetText( btn:GetText() );
			else
				btn.FocusLocked = false;
			end
			btn:Update();
		end
		c.Menu:Hide();
		c:OnValueChanged(v);
	end,
	OnValueChanged = function(c,v)end,
};
Components.DataTable = {
	Create = function(self,parent)
		local c = parent:Create('Frame');
		c.Columns = {};
		c.Rows = {};
		c.Data = {};
		c.SortedBy = nil;
		c.RowHeight = 18;
		c.Pos = 0;
		c.PerPage = 0;
		c.Enabled = true;
		c.Selected = {};
		c.MultiSelect = true;
		c.NoHeader = false;
		c.HideEmptyRows = false;
		
		c.ScrollBar = c:Create('ScrollBar',function(v)
			c.Pos = floor(v);
			c:Update();
		end);
		c:EnableMouseWheel(true);
		c:SetScript('OnMouseWheel',function(c,v)
			c.ScrollBar:Step(v*(IsControlKeyDown() and c.PerPage or 1));
		end);
		c:SetBackdropColor(0.04,0.04,0.04,1);
		c:SetBackdropBorderColor(1,1,1,0.1);
		c.ScrollBar:SetPoint('TOPRIGHT',-2,-2);
		c.ScrollBar:SetPoint('BOTTOM',0,2);
		
		return c;
	end,
	AddColumn = function(c,o)
		local i = #c.Columns+1;
		local col = c:Create('Button', function()
			c:Sort(i)
			c:Update();
		end);
		
		col:SetText(o.Text);
		col.Align = o.Align or 'CENTER';
		col.Text:SetJustifyH(col.Align);
		col.Comparator = o.Comparator;
		col.Render = o.Render;
		col:SetHeight(18);
		if c.NoHeader then
			col:Hide();
		end
		if o.Width then
			col:SetWidth(o.Width);
		else
			col:SetPoint('RIGHT',c.ScrollBar,'LEFT',-1,0);
		end
		if i > 1 then
			col:SetPoint('TOPLEFT', c.Columns[i-1], 'TOPRIGHT', 1, 0);
		else
			col:SetPoint('TOPLEFT',2,-2);
		end
		col.BorderColor = {0.18,0.18,0.18,1};
		col:SetBackdrop({
			bgFile = "Interface\\Buttons\\GreyscaleRamp64",
			edgeFile = "Interface\\Buttons\\WHITE8X8",
			edgeSize = 1,
			insets = {left = 2, right = 0, top = 2, bottom = 0},
		});
		col:SetEnabled(c.Enabled);
		c.Columns[i] = col;
	end,
	CreateRow = function(c,i)
		local row = c:Create('Button',function()
			-- TODO: right click menu
			c:SelectRow(i)
		end);
		row:SetBackdrop({
			bgFile = "Interface\\Buttons\\WHITE8X8",
			edgeFile = "Interface\\Buttons\\WHITE8X8",
			edgeSize = 1,
		});
		row.Cells = {};
		c.Rows[i] = row;
		return row;
	end,
	SelectRow = function(c,i)
		local data = c.Data[i+c.Pos];
		if not data then return end
		if not (c.MultiSelect and IsControlKeyDown()) then
			c.Selected = wipe(c.Selected);
		end
		c.Selected[i+c.Pos] = (not c.Selected[i+c.Pos]) or nil;
		c:Update();
		c:OnSelectionChanged();
	end,
	SelectAll = function(c)
		if not c.MultiSelect then return end
		for i,e in pairs(c.Data) do
			c.Selected[i] = true;
		end
		c:Update();
		c:OnSelectionChanged();
	end,
	CreateCell = function(c,row,i)
		local cell = CreateFrame('Frame',nil,row);
		cell:SetPoint('LEFT',c.Columns[i],'LEFT',0,0);
		cell:SetPoint('RIGHT',c.Columns[i],'RIGHT',0,0);
		cell:SetPoint('TOP',0,-1);
		cell:SetPoint('BOTTOM',0,1);
		cell:SetBackdrop({bgFile = "Interface\\Buttons\\WHITE8X8"});
		cell:SetBackdropColor(1,1,1,i%2==0 and 0.01 or 0);
		cell.Text = cell:CreateFontString();
		cell.Text:SetJustifyH(c.Columns[i].Align);
		cell.Text:SetPoint('TOPLEFT',4,0);
		cell.Text:SetPoint('BOTTOMRIGHT',-4,0);
		cell.Text:SetFont("Fonts\\ARIALN.TTF", 12, "");
		row.Cells[i] = cell;
		return cell;
	end,
	OnResize = function(c)
		c.PerPage = floor((c:GetHeight()-(c.NoHeader and 2 or 21))/(c.RowHeight+1));
		c.ScrollBar:SetStepsPerPage(c.PerPage);
		for i = 1, c.PerPage do
			local row = c.Rows[i] or c:CreateRow(i);
			local y = ((i-1)*(c.RowHeight+1))+(c.NoHeader and 2 or 21);
			row:SetPoint('TOPLEFT',2,-y);
			row:SetHeight(c.RowHeight);
			row:SetPoint('RIGHT',c.ScrollBar,'LEFT',-1,0);
			for j,header in pairs(c.Columns) do
				if not row.Cells[j] then c:CreateCell(row,j) end
			end
		end
		for i = c.PerPage+1, #c.Rows do
			if c.Rows[i] then
				c.Rows[i]:SetShown(false);
			end
		end
		c.ScrollBar:SetMinMaxValues(0,max(0,#c.Data-c.PerPage));
		c:Update();
	end,
	Update = function(c)
		c.ScrollBar:SetValue(c.Pos);
		c.ScrollBar:Update();
		for i,row in pairs(c.Rows) do
			local rowData = c.Data[c.Pos+i];
			row.Focused = 0;
			row.FocusLocked = false;
			if type(rowData) == 'table' then
				row:SetShown(true);
				if c.Selected[c.Pos+i] then
					row.Focused = 1;
					row.FocusLocked = true;
				end
				for j,cell in pairs(row.Cells) do
					local render = c.Columns[j].Render;
					if type(render) == 'function' then
						cell.Text:SetText(render(rowData[j],rowData,cell) or "");
					elseif type(render) == 'string' then
						cell.Text:SetText(rowData[render] or "");
					else
						cell.Text:SetText(rowData[j] or "");
					end
					cell:Show();
				end
				
				row.Color[4] = 0.5;
				--row.BorderColor[4] = 1;
				row.TextColor[4] = 1;
				row:SetEnabled(c.Enabled);
			else
				for k,cell in pairs(row.Cells) do
					cell:Hide();
				end
				row.Color[4] = 0.2;
				--row.BorderColor[4] = 0.2;
				row.TextColor[4] = 0.4;
				row:SetEnabled(false);
				if c.HideEmptyRows then
					row:SetShown(false);
				end
			end
		end
		if c.OnUpdate then
			c:OnUpdate();
		end
	end,
	Sort = function(c,s)
		if not (s and c.Columns[s]) then return end
		c.SortedBy = (s == c.SortedBy) and -s or s;
		s = abs(s);
		
		-- do sort
		local st = c.Columns[s].Comparator;
		sort(c.Data,
			(type(st) == 'function' and st) or
			(type(st) == 'number' and function(a,b) return (a[st] or 0) < (b[st] or 0); end) or
			(function(a,b) return (a[s] or 0) < (b[s] or 0); end)
		);
		
		-- reverse if needed
		if c.SortedBy < 0 then
			local n = #c.Data;
			for i = 1,ceil(n/2) do
				c.Data[(n-i)+1],c.Data[i] = c.Data[i],c.Data[(n-i)+1];
			end
		end
		
		-- update headers
		for i,btn in pairs(c.Columns) do
			btn.FocusLocked = i == s;
			btn:Update()
		end
		
		-- clear selection -- TODO: translate selection?
		wipe(c.Selected);
	end,
	DataChanged = function(c, skipsort)
		if c.SortedBy and not skipsort then
			c:Sort();
		end
		wipe(c.Selected);
		c.ScrollBar:SetMinMaxValues(0,max(0,#c.Data-c.PerPage));
		c.Pos = 0;
		c:Update();
		c:OnSelectionChanged();
	end,
	OnSelectionChanged = function(c)end,
};
Components.ProgressBar = {
	Create = function(self,parent)
		local c = parent:Create('Frame');
		
		c:SetBackdrop({
			bgFile = "Interface\\Buttons\\GreyscaleRamp64",
			edgeFile = "Interface\\Buttons\\WHITE8X8",
			edgeSize = 1,
			insets = {left = 2, right = 0, top = 2, bottom = 0},
		});
		c:SetBackdropColor(0.1,0.1,0.1,1);
		c:SetBackdropBorderColor(0.3,0.3,0.3,1);
		
		c.Bar = CreateFrame('StatusBar',nil,c);
		c.Bar:SetPoint('TOPLEFT',2,-2);
		c.Bar:SetPoint('BOTTOMRIGHT',-2,2);
		c.Bar:SetStatusBarTexture('Interface\\Buttons\\GreyscaleRamp64');
		c.Color = {1,1,1,1};
		
		c.Text = c:Create('Frame');
		c.Text:SetBackdrop(nil);
		c.Text:SetPoint('TOPLEFT',4,-3);
		c.Text:SetPoint('BOTTOMRIGHT',-4,4);
		for i, point in pairs({'Left','Center','Right'}) do
			c.Text[point] = c.Text:CreateFontString();
			local fs = c.Text[point];
			fs:SetFont('Fonts\\ARIALN.TTF', 12, nil);
			fs:SetShadowColor(0,0,0,1);
			fs:SetShadowOffset(1,-1);
			fs:SetJustifyH(point:upper());
			fs:SetAllPoints();
		end
		
		c.Flashing = nil;
		c.Animating = false;
		c.FlashEnabled = true;
		c.Value = 0;
		c.Min = 0;
		c.Max = 1;
		c.SmoothReverse = true;
		
		c.Bar:SetMinMaxValues(c.Min,c.Max);
		c.Bar:SetValue(c.Value);
		
		c.Bar:SetScript('OnValueChanged',function()
			c:OnValueChanged( c.Bar:GetValue() );
		end);
		
		return c;
	end,
	SetMinMaxValues = function(c,min,max)
		c.Min = min or c.Min;
		c.Max = max or c.Max;
		return c.Bar:SetMinMaxValues(c.Min,c.Max);
	end,
	GetValue = function(c)
		return c.Value;
	end,
	SetValue = function(c,v)
		v = max(c.Min,min(c.Max,v));
		if v <= c.Value and not c.SmoothReverse then
			c.Bar:SetValue(v);
		end
		c.Value = v;
		c:Update();
	end,
	SetColor = function(c,r,g,b,a)
		c.Color[1] = r or c.Color[1] or 1;
		c.Color[2] = g or c.Color[2] or 1;
		c.Color[3] = b or c.Color[3] or 1;
		c.Color[4] = a or c.Color[4] or 1;
		c.Bar:SetStatusBarColor(unpack(c.Color));
		c:Update();
	end,
	OnValueChanged = function(c,v)end,
	SetText = function(c,point,text)
		if c.Text[point] then
			c.Text[point]:SetText(text or '');
		end
	end,
	SetJustifyV = function(c,point,justify)
		if c.Text[point] then
			c.Text[point]:SetJustifyV(justify or 'CENTER');
		end
	end,
	Update = function(c,e)
		local v = c.Bar:GetValue();
		v = v+((c.Value-v)*0.1);
		c.Bar:SetValue(v);
		c.Animating = true;
		if abs(v-c.Value) <= 0.01 then
			c.Animating = false;
			c.Bar:SetValue(c.Value);
			if c:GetScript('OnUpdate') == c.Update then
				c:SetScript('OnUpdate',nil);
				-- Animation has ended, flash if bar is full.
				-- TODO: bar won't flash if stepping from 0.99+ to 1
				if c.FlashEnabled and c.Value >= c.Max and not c.Flashing then
					local r,g,b,a = unpack(c.Color);
					local p = 0;
					c.Flashing = C_Timer.NewTicker(0.025,function(t)
						p = p+0.05;
						c.Bar:SetStatusBarColor(r*p-p+1,g*p-p+1,b*p-p+1,a);
						if p >= 1 then
							c.Flashing = nil;
						end
					end,20);
				end
			end
		elseif not e then
			c:SetScript('OnUpdate',c.Update);
		end
	end,
	IsAnimating = function(c)
		return ( c.Animating or c.Flashing ) and true;
	end,
};
Components.ScrollFrame = {
	Create = function(self,parent)
		local c = parent:Create('Frame');
		
		c.ScrollFrame = CreateFrame('ScrollFrame',nil,c);
		c.ScrollFrame:SetPoint('TOPLEFT',2,-2);
		c.ScrollFrame:SetPoint('BOTTOMRIGHT',-9,2);
		
		c.Content = c:Create('Frame');
		c.Content:SetBackdrop(nil)
		c.Content:SetSize(1,1);
		
		c.ScrollFrame:SetScrollChild(c.Content);
		c.ScrollFactor = 10;
		
		c.ScrollBar = c:Create('ScrollBar',function(v)
			c.Pos = v*c.ScrollFactor;
			c:Update();
			if c.OnScroll then
				c:OnScroll();
			end
		end);
		c.ScrollBar:SetPoint('TOPRIGHT',-2,-2);
		c.ScrollBar:SetPoint('BOTTOM',0,2);
		
		c:EnableMouseWheel(true);
		c:EnableMouse(true);
		c:SetScript('OnMouseWheel',self.Scroll);
		
		c.Fade = CreateFrame('Frame',nil,c);
		c.Fade:SetPoint('TOPLEFT',1,-1);
		c.Fade:SetPoint('BOTTOMRIGHT',-1,1);
		
		c.Pos = 0;
		
		local lvl = c:GetFrameLevel();
		c.Fade:SetFrameLevel(lvl+2);
		c.ScrollBar:SetFrameLevel(lvl+3);
		
		-- Update queue keeps the frame from being spam updated during the same cycle
		-- also adds a delay to the last tick of a resize, which fixes heaps of issues.
		c.QueuedUpdate = nil;
		c.UpdateSelf = function()
			c.QueuedUpdate = nil;
			c:Update(true);
		end
		
		return c;
	end,
	SetContent = function(c,frame)
		c.Content = frame or c.Content;
		c.ScrollFrame:SetScrollChild(c.Content);
		c:Update();
	end,
	Scroll = function(c,v)
		c.Pos = max(0, min(c.ScrollFrame:GetVerticalScrollRange(), c.ScrollFrame:GetVerticalScroll()-(c.ScrollFactor*v)));
		if c.Pos == c.LastPos then return end
		c.LastPos = c.Pos;
		c.ScrollBar:SetValue(c.Pos/c.ScrollFactor);
		if c.OnScroll then
			c:OnScroll();
		end
	end,
	Update = function(c,noQueue)
		if c.QueuedUpdate then
			return -- we'll be updating on the next frame anyway.
		elseif not noQueue then
			C_Timer.After(0.025,c.UpdateSelf);
			c.QueuedUpdate = true;
		end
		
		c.ScrollFrame:UpdateScrollChildRect();
		local range = c.ScrollFrame:GetVerticalScrollRange();
		c.ScrollFrame:SetVerticalScroll( c.Pos );
		
		local height = c:GetHeight();
		local contentHeight = c.Content:GetHeight();
		if contentHeight-height > -0.1 then
			c.ScrollBar:Show();
			c.ScrollBar:SetStepsPerPage(height/c.ScrollFactor);
			c.ScrollBar:SetMinMaxValues(0,max(0,range/c.ScrollFactor));
			c.ScrollBar:Update();
			c.Content:SetWidth( c:GetWidth() - 8 );
			c.ScrollFrame:SetPoint('BOTTOMRIGHT',-9,2);
		else
			c.ScrollBar:Hide();
			c.Content:SetWidth( c:GetWidth() );
			c.ScrollFrame:SetPoint('BOTTOMRIGHT',-1,2);
		end
	end,
};

Components.Slider = {
	Create = function(self,parent,callback)
		local c = CreateFrame('Slider',nil,parent);
		c.Bar = c:CreateTexture();
		c:SetMinMaxValues(0,100);
		c:SetStepsPerPage(0);
		c:SetValueStep(1);
		
		c.OnValueChanged = callback;
		
		c.Bar:SetColorTexture(0.3,0.3,0.3,1);
		c:SetThumbTexture(c.Bar);
		
		c.Thickness = 6;
		c:SetSize(6,6);
		c.Bar:SetSize(6,6);
		
		c.Rail = c:CreateTexture();
		c.Rail:SetColorTexture(0.1,0.1,0.1,1)
		
		local SetOrientation = c.SetOrientation;
		c.SetOrientation = function(c,o,...)
			SetOrientation(c,o,...);
			o = c:GetOrientation();
			c.Rail:ClearAllPoints();
			if o == 'VERTICAL' then
				c.Rail:SetPoint('TOP');
				c.Rail:SetPoint('BOTTOM');
				c.Rail:SetWidth(c.Thickness/3);
			else
				c.Rail:SetPoint('LEFT');
				c.Rail:SetPoint('RIGHT');
				c.Rail:SetHeight(c.Thickness/3);
			end
		end
		c:SetOrientation('HORIZONTAL');
		
		c:SetValue(0);
		c:SetScript('OnValueChanged',function(c,v)
			return c.OnValueChanged and c:OnValueChanged(v);
		end);
		
		return c;
	end,
	SetThickness = function(c,v)
		c.Thickness = v;
		c:SetSize(v,v);
		c.Bar:SetSize(v,v);
	end,
	OnValueChanged = nil,
};

Components.ScrollingList = { -- this is shit, it's too specfic, probably easier to just add a handler to scrollframe that provides current visible area. 
	Create = function(self,parent)
		local c = parent:Create('ScrollFrame');
		c.Frames = {};
		c.LastPos = nil;
		c.Data = {};
		c.ItemHeight = 30;
		c.ItemSpacing = 2;
		c.DynamicHeight = nil;
		return c;
	end,
	Scroll = function(c,v)
		c.Pos = max(0,c.ScrollFrame:GetVerticalScroll()-(c.ScrollFactor*v));
		c.ScrollBar:SetValue(c.Pos/c.ScrollFactor);
		c:Update();
	end,
	InitButton = function(c,f)end,
	AddButton = function(c,o)
		local i = #c.Frames+1;
		local b = c.Content:Create('Button');
		c.Frames[i] = b;
		b.ButtonIndex = i;
		b:SetPoint('RIGHT',-4,0);
		b:SetPoint('LEFT',0,0);
		b:SetHeight(c.ItemHeight);
		if i ~= 1 then
			b:SetPoint('TOP',c.Frames[i-1],'BOTTOM',0,o or -2);
		end
		return b;
	end,
	Update = function(c,...)
		local Frames = c.Frames;
		
		local Data = c.Data;
		local Pos = max(0,c.Pos);
		
		local offset = 0;
		local start = 0;
		local total = 0;
		if c.DynamicHeight then
			local func = c.DynamicHeight;
			local total = 0;
			for i = 1,#Data do
				local h = func(i);
				total = total+h;
				if total >= Pos-h then
					start = i-1;
					offset = total-h;
				end
			end
		else
			total = #Data*c.ItemHeight;
			start = floor(Pos/c.ItemHeight);
			offset = start*c.ItemHeight;
		end
		
		c.Content:SetHeight(total);
		
		local n = ceil(c:GetHeight()/(c.ItemHeight+c.ItemSpacing));
		for i = #Frames, n do
			c:InitButton(c:AddButton());
		end
		
		Frames[1]:SetPoint('TOP',0,-offset);
		for i = 1, #Frames do
			local f = Frames[i];
			if GetMouseFocus() == f then
				f:OnEnter();
			end
			f.Index = start+i;
			local v = Data[f.Index];
			print(i,v);
			f:SetShown((v~=nil) and (c:PopulateFrame(f,v) or true));
			f:SetHeight( c.DynamicHeight and c.DynamicHeight(f.Index) or c.ItemHeight );
		end
		
		Components.ScrollFrame.Update(c,...);
	end,
	PopulateFrame = function(c,f,v)end,
};

LibElci.Version = VERSION;
LibElci.Create = function(p, comp, ...)
	local m = Components[comp];
	if not m then
		error('LibElci: Unknown Component "'..tostring(comp)..'"');
	end
	p = p==LibElci and UIParent or p;
	local c = m:Create(p, ...);
	if not m.__index then
		m.__index = m;
		setmetatable(m,getmetatable(c));
	end
	c.Super = getmetatable(m);
	c.SetStyle = function(c,s,...)
		local style = Styles[comp..(s or '')];
		return style and style(c,...);
	end
	setmetatable(c,m);
	c.Create = LibElci.Create;
	return c;
end

function LibElci:AddStyle(comp,n,h)
	if type(comp) ~= 'string' then return end
	Styles[comp..(n or '')] = h;
end

LibElci.Test = function()
	local Window = LibElci.Create(UIParent,'Window');
	Window:SetSize(500,300);
	Window:SetPoint('CENTER');

	local Frame = Window:Create('Frame');
	Frame:SetPoint('TOPLEFT',2,-2);
	Frame:SetSize(130,200);

	local Btn1 = Window:Create('Button',function()
		print('Button 1');
	end);
	Btn1:SetPoint('TOPLEFT',10,-10);
	Btn1:SetSize(80,18);
	Btn1:SetText('Enabled');

	local Btn2 = Window:Create('Button');
	Btn2:SetPoint('TOPLEFT',10,-30);
	Btn2:SetSize(80,18);
	Btn2:SetText('Disabled');
	Btn2:SetEnabled(false);

	local Btn3 = Window:Create('Button',function(c)
		c.FocusLocked = not c.FocusLocked;
		print('Button 3');
	end);
	Btn3:SetPoint('TOPLEFT',10,-50);
	Btn3:SetSize(80,18);
	Btn3:SetText('Locking');

	local EditBox = Window:Create('EditBox');
	EditBox:SetPoint('TOPLEFT',10,-80);
	EditBox:SetSize(100,18);

	local DDM = Window:Create('DropDownMenu');
	DDM.OnValueChanged = function(c,v) print(v) end
	DDM:SetPoint('TOPLEFT',10,-120);
	DDM:SetSize(100,18);

	DDM:AddOption({Value = 1, Text = 'Option One'});
	DDM:AddOption({Value = 2, Text = 'Option Two'});
	DDM:AddOption({Value = 3, Text = 'Option Three'});
	DDM:SetValue(2);

	local DT = Window:Create('DataTable');
	DT:AddColumn({
		Text = "Column 1",
		Width = 100,
		Align = 'LEFT',
	});
	DT:AddColumn({
		Text = "2",
		Width = 24,
	});
	DT:AddColumn({
		Text = "Column 3",
	});
	DT:SetSize(200,193);
	DT:SetPoint('TOPLEFT',134,-2);
	DT.Data = {
		{"Banana1",5,"Row1"},
		{"Apple2",63,"Row2"},
		{"Carrot3",73,"Row3"},
		{"Banana4",5,"Row1"},
		{"Apple5",9,"Row2"},
		{"Carrot6",5,"Row3"},
		{"Banana7",51,"Row1"},
		{"Apple8",25,"Row2"},
		{"Carrot9",35,"Row3"},
		{"Carrot10",45,"Row3"},
		{"Banana11",55,"Row1"},
		{"Apple12",65,"Row2"},
		{"Carrot13",5,"Row3"},
		{"Banana14",15,"Row1"},
		{"Apple15",35,"Row2"},
		{"Carrot16",45,"Row3"},
		{"Banana17",53,"Row1"},
		{"Apple18",52,"Row2"},
		{"Carrot19",51,"Row3"},
	};
	DT:OnResize();


	local ProgressBar = Window:Create('ProgressBar');
	ProgressBar:SetPoint('BOTTOMLEFT',2,2);
	ProgressBar:SetSize(300,20);
	ProgressBar.OnValueChanged = function(c,v)
		c:SetText('Center',format('%.01f%%',v*100));
	end
	ProgressBar:SetColor(0.3,0.6,0.1,1);


	local v = 0;
	C_Timer.NewTicker(1,function()
		v = v >= 1 and 0 or v+(random()/5);
		ProgressBar:SetValue(v);
	end)

--[[
	SF = Window:Create('ScrollFrame');
	SF:SetPoint('TOPLEFT',338,-2);
	SF:SetSize(100,200);

	local y = 0;
	for i = 0,100 do
		local b = SF.Content:CreateFontString();
		b:SetFont('Fonts\\ARIALN.TTF',12);
		b:SetPoint('TOPLEFT',0,-y);
		b:SetSize(80,18);
		b:SetText(i);
		y = y+19;
	end
	SF.Content:SetHeight(y-1);
	SF:Update()
	--]]
	
	local SL = Window:Create('ScrollingList');
	SL:SetPoint('TOPLEFT',338,-2);
	SL:SetSize(150,200);
	for i = 1,100 do
		SL.Data[i] = random();
	end
	for i = 1,10 do
		local btn = SL.Content:Create('Button');
		SL.Frames[i] = btn;
		btn.ButtonIndex = i;
		btn:SetPoint('RIGHT',-4,0);
		btn:SetPoint('LEFT',0,0);
		if i ~= 1 then
			btn:SetPoint('TOP',SL.Frames[i-1],'BOTTOM',0,-2);
		end
	end
	SL.PopulateFrame = function(c,f)
		f:SetText(f.Index..':'..f.ButtonIndex);
	end
	SL:Update();
	
end

