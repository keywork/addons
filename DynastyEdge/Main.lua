local ADDON_NAME, EDGE = ...;

local EventHandler = DynastyCore.EventHandler;
local GUI = EDGE.GUI;

EDGE.Debug = true; -- TODO:

EventHandler:Register('ADDON_LOADED',function(name)
	if name ~= ADDON_NAME then return end
	
	GUI:Load();
	GUI:Update();
	
	return true;
end);

EventHandler:Register('DYNASTY_ADDON_SELECTED',function(addon)
	if addon == ADDON_NAME then
		GUI:Show();
	else
		-- hide self?
	end
end);

local Mode;
local Selected = {
	Class = nil,
	Act = nil,
	Spec = nil,
	Page = nil,
};

function EDGE:GetMode()
	return Mode or 'ClassSelect';
end
function EDGE:SetMode(m)
	if m == 'ClassSelect' then
		wipe(Selected);
	end
	Mode = m;
end

function EDGE:GetSelection()
	return Selected.Class, Selected.Act, Selected.Spec;
end

function EDGE:SelectActivity(act)
	if not Selected.Class then
		return
	end
	Selected.Act = act;
	self:SetMode('SpecSelect');
end
function EDGE:SelectClass(class)
	if not self.ClassIcons[class] then
		return
	end
	Selected.Class = class;
	self:SetMode('ActivitySelect');
end
function EDGE:SelectSpec(spec)
	if not (Selected.Class and Selected.Act) then
		return
	end
	Selected.Spec = spec;
	self:SelectPage(1);
	self:SetMode('Info');
end
function EDGE:CanSelectSpec(spec)
	return not not self:Get(Selected.Class, Selected.Act, spec);
end

function EDGE:SelectPage(index)
	local info = self:Get(Selected.Class, Selected.Act, Selected.Spec);
	if not (info and info.Pages[index]) then
		return
	end
	Selected.Page = index;
end


local db = {};
function EDGE:Register(key,pages)
	local class,act,spec,rec = key:match("^(.-):(.-):(.-)(*?)$");
	if not (class and act and spec) then
		return;
	end
	db[class] = db[class] or {};
	db[class][act] = db[class][act] or {};
	local t = {
		Pages = {},
		Recommended = not not rec,
	};
	for i,info in pairs(pages) do
		
		local content = info[2];
		local frame = CreateFrame('Frame');
		frame:SetShown(false);
		frame:SetWidth(306);
		local fs = frame:CreateFontString();
		frame.Text = fs;
		fs:SetAllPoints()
		fs:SetNonSpaceWrap(true)
		fs:SetFont('Fonts\\ARIALN.TTF',12);
		fs:SetShadowColor(0,0,0,1);
		fs:SetShadowOffset(1,-1);
		fs:SetTextColor(1,1,1,1);
		fs:SetJustifyH('LEFT');
		fs:SetJustifyV('TOP');
		
		if type( content ) == 'function' then
			if not content(frame) then
				content = nil;
			end
		elseif type( content ) == 'string' then
			fs:SetText(content);
			frame:SetHeight(80+fs:GetStringHeight())
		end
		
		if content then
			t.Pages[i] = {
				Title = info[1],
				Frame = frame, -- TODO: render if function, convert if text
			};
		end
	end
	db[class][act][spec] = t;
end
function EDGE:Get(class,act,spec)
	if not (class and act and spec) then
		return;
	end
	return db[class] and db[class][act] and db[class][act][spec];
end


function EDGE:GetSelectedPage()
	if not Selected.Page then
		return '';
	end
	local info = self:Get(Selected.Class, Selected.Act, Selected.Spec);
	return info and info.Pages[Selected.Page];
end
function EDGE:GetPageList()
	local info = self:Get(Selected.Class, Selected.Act, Selected.Spec);
	return info and info.Pages;
end
function EDGE:IsRecommended(spec)
	local info = self:Get(Selected.Class, Selected.Act, spec);
	return info and info.Recommended;
end




