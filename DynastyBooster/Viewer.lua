local ADDON_NAME, DGV = ...;

_G.DGV = DGV;

local EventHandler = DynastyCore.EventHandler;
local MapData = DynastyCore.MapData;

EventHandler:Register('ADDON_LOADED',function(name)
	if name ~= ADDON_NAME then return end
	
	EnableAddOn("DynastyBoosterAlliance");
	LoadAddOn("DynastyBoosterAlliance");
	EnableAddOn("DynastyBoosterHorde");
	LoadAddOn("DynastyBoosterHorde");
	
	DynastyGuideViewer_Saved = DynastyGuideViewer_Saved or {};
	DGV.Saved = DynastyGuideViewer_Saved;
	
	DynastyGuideViewer_GSaved = DynastyGuideViewer_GSaved or {};
	DGV.GSaved = DynastyGuideViewer_GSaved;
	
	DGV.GUI:Load();
	if DGV.Saved.LoadedGuide then
		DGV:LoadGuide(DGV.Saved.LoadedGuide);
	end
	DGV.GUI:Update();
	DGV.GUI:Hide();
	
	return true;
end);

EventHandler:Register('DYNASTY_ADDON_SELECTED',function(addon)
	if addon == ADDON_NAME then
		DGV.GUI:Show();
		if not DGV.GSaved.DontShowTips then
			DGV.GUI:ShowTips();
		end
	else
		-- hide self?
	end
end);

--[[
show arrow
use tomtom
auto turnin
auto pickup

--]]


DGV.LoadedGuide = nil;
DGV.Tasks = {};
DGV.BrowserDir = '';
DGV.StepSt = 0;
DGV.StepEn = 0;
DGV.GuideProgress = 0;
DGV.Content = {};

local TaskTypes = {};
DGV.TaskTypes = TaskTypes;
function DGV:RegisterTaskType(key,meta)
	meta.__index = meta;
	meta.Type = key;
	TaskTypes[key] = meta;
end

local Guides = {};
DGV.Guides = Guides;
function DGV:RegisterGuide( name, path, minlvl, desc, faction, nextGuide, tasks )
	if UnitFactionGroup('player') ~= faction and faction ~= 'Both' then
		return;
	end
	Guides[ path .. name ] = {
		Name = name,
		Path = path,
		MinLevel = minlvl,
		Description = desc,
		Faction = faction,
		Next = nextGuide,
		Tasks = tasks,
	};
end
function DGV:ParseTask(t)
	t = t:gsub('\\"','|');
	local key, dataRaw, suffixes = t:match("^[%s]*(.)%(([^%)]*)%)(.*)");
	if key and TaskTypes[key] then
		-- check for requirement
		if suffixes:match("?Class") then -- task is class specific
			local c1,c2 = UnitClass('player');
			if not (suffixes:match("?Class_"..c1) or suffixes:match("?Class_"..c2)) then
				return;
			end
		end
		if suffixes:match("?NotClass") then -- task is not available for specific class
			local c1,c2 = UnitClass('player');
			if suffixes:match("?NotClass_"..c1) or suffixes:match("?NotClass_"..c2) then
				return;
			end
		end
		
		local comment = suffixes:match(':"([^"]*)"');
		comment = comment and comment:gsub('|','"');
		
		-- Split Task Data
		local data = {};
		dataRaw = dataRaw:gsub('"[^"]*"',function(v)
			return v:gsub('|','"'):gsub(',','|');
		end)
		dataRaw:gsub("[^,]+",function(v)
			table.insert(data,v:gsub('|',','):trim(' "'));
		end);
		
		-- process location
		local location = suffixes:match('@%[([^%]]*)%]');
		if location then
			location = {strsplit(',',location)};
			if location[1]:sub(1,2) == '0.' then -- old location data, convert it to new format.
				location[1], location[2] = MapData:Translate(tonumber(location[3]),0,location[1],location[2]);
				location[4] = location[4] or 0;
			end
		end
		
		local task = setmetatable({
			Type = key,
			Raw = t,
			Data = data,
			Location = location,
			Indent = 0,
			Comment = comment,
		}, TaskTypes[key]);
		if task.Initialize then
			task:Initialize();
		end
		return task;
	else
		return -- malformed
	end
end
function DGV:LoadGuide(key)
	local g = Guides[key];
	if not g then
		return false, 'Guide not found.';
	end
	
	self.LoadedGuide = g;
	self.Saved.LoadedGuide = key;
	
	local tasks = {};
	(g.Tasks.."\n"):gsub("(.-)\n",function(line) -- loop through lines
		local task = DGV:ParseTask(line);
		if task then tinsert(tasks, task) end
	end)
	
	self.Tasks = tasks;
	self:CalcStep();
	return true;
end

-- Returns a GUI-Ready set of rows.
function DGV:GetContent()
	if not self.LoadedGuide then
		return self:GetBrowserContent();
	end
	return self.Content;
end

-- Itentifies Current-Objectives
-- Converts current tasks into GUI-Ready content.
function DGV:UpdateContent()
	local content = self.Content;
	wipe(content);
	if not (self.LoadedGuide and #self.Tasks > 0) then
		return
	end
	local completed = self.StepSt;
	local current = nil;
	local inherit = 0;
	local reload = false;
	local prev;
	for i = self.StepEn, self.StepSt, -1 do -- build content in reverse so it's easier to inherit progress
		local task = self.Tasks[i];
		if task and ((not task.CanProgress) or task:CanProgress()) then
			local p = task:GetProgress();
			inherit = task.Important and p or inherit;
			p = max(inherit,p);
			
			--local merged = (task.Merged and prev.Type == task.Type);
			
			if p >= 1 or task.Skipped then
				completed = completed+1;
			elseif task.Trackable then
				current = i;
			end
			
			--if not merged then
				local text = task:Render();
				tinsert(content, {
					Type = task.Type,
					LeftText = text,
					RightText = (task.Skipped and 'Skipped') or (p>=1 and 'Complete') or (p>0 and format('%d%%',p*100)) or '',
					Action = function()
						-- TODO: things
					end,
					Progress = (task.Skipped and 1) or p,
					SubText = task.Comment,
					Important = task.Important,
					Skipped = task.Skipped,
				});
				if not text then
					reload = true;
				end
			--end
			prev = task;
		end
	end
	
	-- flip content back to normal order.
	local n = #content;
	for i = 1,ceil(n/2) do
		content[(n-i)+1],content[i] = content[i],content[(n-i)+1];
	end
	
	-- TODO: can inline this, depends After()'s return.
	if reload and not self.ReloadQueued then -- At least one of the tasks failed to render (most likely still loading tooltip data), try again in a second.
		C_Timer.After(1, self.Update);
		self.ReloadQueued = true;
	end
	
	-- remove sequentail goto's
	
	self.CurrentTask = current and self.Tasks[current];
	self:UpdateObjective();
	self.GuideProgress = (completed-1)/#self.Tasks;
end

-- Refreshes the current objective (for the navigator mainly).
function DGV:UpdateObjective()
	local task = self.CurrentTask;
	if task and task.Location then
		local x,y,map,floor = unpack(task.Location);
		floor = floor or 0;
		local text = task:Render();
		if x and y and map and floor and text then
			self.Navigator:SetObjective( text, x, y, map, floor );
			return
		end
	end
	self.Navigator:ClearObjective();
end

function DGV.Update(...)
	local self = DGV;
	self.ReloadQueued = false;
	self:UpdateContent(); -- check current tasks progress
	self:UpdateObjective(); -- update objective incase current task changed
	self.GUI:Update(); -- update ui with current tasks possibly new progress
	if self:CalcStep() then -- determine new/next tasks (if all tasks are completed)
		self:UpdateContent(); -- update again with new/next tasks
		self.GUI:Update();
	end
end
EventHandler:Register('QUEST_LOG_UPDATE',DGV.Update);
EventHandler:Register('QUEST_POI_UPDATE',DGV.Update);
EventHandler:Register('GOSSIP_SHOW',DGV.Update);
EventHandler:Register('QUEST_DETAIL',DGV.Update);
EventHandler:Register('PLAYER_MAP_CHANGED',DGV.Update);


-- Determines which tasks should be displayed
function DGV:CalcStep()
	if not self.LoadedGuide then
		return
	end
	--[[
	local autoskip = 1;
	for i,task in pairs(self.Tasks) do
		if task.Important and (task:GetProgress() <= 0) and task.Type ~= 'G' then
			autoskip = i;
			break;
		end
	end
	--]]
	local st,en = 1,0;
	local pos = 1;
	local stepType;
	local stepComplete = true;
	for i,task in pairs(self.Tasks) do
		if task.Important then
			if task.Type ~= stepType then
				if not stepComplete then
					break;
				end
				stepType = task.Type;
				st = en+1;
			end
			en = i;
			local canProgress = ((not task.CanProgress) or task:CanProgress());
			stepComplete = stepComplete and ((task.Skipped or (task:GetProgress() >= 1)) or not canProgress);
		end
	end
	
	local changed = self.StepSt ~= st or self.StepEn ~= en;
	self.StepEn = en;
	self.StepSt = st;
	
	self:UpdateContent()
	
	if stepComplete then
		-- TODO: guide is finished
		if self.LoadedGuide.Next then DGV:LoadGuide(self.LoadedGuide.Next); end
	end
	
	return changed;
end

function DGV:GetBrowserContent()
	local dir = self.BrowserDir or '';
	
	if self:LoadGuide(dir) then
		self.BrowserDir = nil;
		return self:GetCurrentTasks();
	end
	
	local matches = {
		[1] = dir ~= '' and {
			LeftText = '..',
			Action = function()
				self:SelectBrowserContent(dir:match("(.*)/.-$") or '');
			end,
		} or nil,
	};
	
	local options = {};
	for key in pairs(Guides) do
		local str = key:match("^"..(dir:gsub('([%(%)%.%%%+%-%*%?%[%]%^%$])','%%%1')).."/([^/]*)");
		if str then
			options[str] = dir.."/"..str;
		end
	end
	
	for name, key in pairs(options) do
		local g = Guides[key];
		tinsert( matches, {
			LeftText = (g and '' or ' /') ..name,
			Action = function()
				self:SelectBrowserContent(key);
			end,
			SubText = (g and g.Description)
		});
	end
	
	return matches;
end

function DGV:SelectBrowserContent( key )
	if not self:LoadGuide(key) then
		self.BrowserDir = key;
	end
	self.GUI:Update();
end

function DGV:GetGuideProgress()
	return self.LoadedGuide and self.GuideProgress or 0;
end
function DGV:GetGuideTitle()
	return self.LoadedGuide and self.LoadedGuide.Name or self.BrowserDir;
end
function DGV:CanSkipTask()
	return self.CurrentTask and true;
end
function DGV:ShowBrowser()
	self.LoadedGuide = nil;
	self.CurrentTask = nil;
	
	self.LoadedGuide = nil;
	wipe(self.Tasks);
	self.StepSt = 0;
	self.StepEn = 0;
	self.GuideProgress = 0;
	
	self.Saved.LoadedGuide = nil;
	
	self.Update();
end

-- Flags current task as skipped
function DGV:SkipTask()
	if self.CurrentTask then
		self.CurrentTask.Skipped = true;
		self:Update();
	end
end
function DGV:ClearSkipped()
	for i,task in pairs(self.Tasks) do
		task.Skipped = nil;
	end
	self:Update();
end

do
	local old;
	C_Timer.NewTicker(1,function()
		if DGV.CurrentTask then
			DGV:UpdateObjective(); -- Mostly just to catch players entering quest areas.
			local p = DGV.CurrentTask:GetProgress();
			if p ~= oldp then
				oldp = p;
				DGV:Update();
			end
		end
	end)
	
end




--[[


local currentType = nil;
local tasks = {};
for i = pos, #task do
	if important then
		currentType = currentType or type;
		if currentType ~= type then
			break;
		end
	end
	tinsert( tasks, task );
end

if not currentType then
	guide is finished
else
	tasks = out task list;
end
function SetDRM()
	SetBinding('"','CLICK PlayerFrame:RightButton');
end

--]]
