local ADDON_NAME, DGV = ...;

if not DGV.DEBUG then
	return;
end

-- Author/Dev tools
local Tools = {};
DGV.Tools = Tools;

local MapData = DynastyCore.MapData;
local EventHandler = DynastyCore.EventHandler;
local PlayerInfo = DynastyCore.PlayerInfo;
local GameInfo = DGV.GameInfo;
local LibElci = DynastyCore.LibElci;

-- Map Connection Finder
local MCF = CreateFrame('Frame');
function Tools:MapConnectionFinder()
	local DB = {};
	EventHandler:Register('PLAYER_MAP_CHANGED', function(map, floor)
		local m1,m2 = (map or 0)+((floor or 0)/100), (PlayerInfo.Map or 0)+((PlayerInfo.Floor or 0)/100);
		if m1 == 0 or m2 == 0 then
			return -- missing data.
		end
		local key = (m1 > m2) and (m1.."-"..m2) or (m2.."-"..m1);
		DB[key] = DB[key] or {};
		tinsert(DB[key],{PlayerInfo.X or 0, PlayerInfo.Y or 0});
		local x,y = 0,0;
		for i,v in pairs(DB[key]) do
			x = x+v[1];
			y = y+v[2];
		end
		
		--Tools:Dump( format('{%d,%d,%s,%s}',m1,m2,x/#DB[key],y/#DB[key]) );
		
	end);
end
Tools:MapConnectionFinder()


local DumpBox = LibElci.Create(UIParent,'EditBox');
DumpBox:SetPoint('TOPLEFT',0,0);
DumpBox:SetSize(800,100);
DumpBox:SetMultiLine(true);
function DumpBox:OnTextChanged(v) self:SetShown(v ~= '') end
function Tools:Dump(text)
	DumpBox:Show();
	DumpBox:SetText(text);
end

function ZoneNameToMapID(zoneName)
	local mapId;
	for id, map in pairs(MapData:Expose()) do
		if map.FileName == zoneName or map.Name == zoneName then
			if mapId then -- multiple matches
				mapId = nil;
				break;
			end
			mapId = id;
		end
	end
	return mapId or zoneName;
end


-- f Get flight point |N|  Talk to Zaldaan to get a flight point (49.678, 49.251). | |Z|AzuremystIsle|,
-- T["Zaldaan",0.49678,0.49251,ZoneNameToMapID(zoneName)]:"Get the flight point."!
function Tools:Convert( replace, text )
	if not (text or DumpBox:IsShown()) then
		DumpBox:SetText('Paste old guide in here.');
		DumpBox:Show();
		return
	end
	local nobjectives = {};
	local qids = {};
	local qobjs = {};
	local objectiveCount = {};
	local old = text or DumpBox:GetText();
	local new = "";
	
	local lines = {strsplit('\n',old)};
	
	for i,raw in pairs(lines) do
		if raw:match("[^%s]") then
		
		-- Handle Type
		local data;
		local type = raw:sub(1,1);
		local qname = (raw:match("|Q|+([^|]+)") or raw:sub(2):match("[^|]+") or ''):trim();
		
		local ignoreLocation = false
		local qid = raw:match("|QID|+%s*(%d+)|") or qids[qname];
		local comment;
		
		--print(qname,qid);
		if type == 'U' and raw:match("Hearthstone") then
			type = nil;
		elseif type == 'A' then -- Accept Quest
			data = qid or 'UnknownQID';
			qids[qname] = data;
		elseif type == 'C' then -- Complete quest (not turn in)
			local objIndex;
			if qobjs[qid] then
				for j = 1,9 do
					if not qobjs[qid][j] then
						objIndex = j;
						break;
					end
				end
			end
			data = (qid or 'UnknownQID') .. (objIndex and (','..objIndex) or ''); -- final objective
			type = 'P';
			ignoreLocation = true;
		elseif type == 'T' then -- Turn in
			data = (qid or 'UnknownQID');
			type = 'C';
		elseif type == 'N' or type == 'K' then -- Quest Objective
			local objIndex = 'UnknownObjectiveIndex';
			local QO = raw:match("|QO|+([^|]+)");
			if qid and QO then
				nobjectives[qid] = (nobjectives[qid] or 0) + 1;
				qobjs[qid] = qobjs[qid] or {};
				
				QO = QO:gsub(':%s*%d+%s*/%s*%d+.*','');
				QO = QO:gsub('[Ss]lain','');
				QO = QO:trim():lower();
				
				for j = 1,9 do
					local text = GameInfo:GetQuestObjectiveText(qid,j)
					if text and text:lower():match(QO) then
						objIndex = j;
						qobjs[qid][j] = text;
						break;
					end
				end
			end
			
			if (not (qid and QO)) and raw:match('|L|+.-|') then -- loot some item
				type = 'G'
				ignoreLocation = false;
				comment = ':"'..(raw:match("|N|+(.-)|") or 'Unknown'):trim()..'"';
			else
				type = 'P';
				if replace and qid and nobjectives[qid] == 1 then
					objIndex = 1;
				end
				ignoreLocation = not not qid;
				data = (qid or 'UnknownQID')..','..objIndex;
			end
			
		else -- use basic instruction/waypoint
			type = 'G';
		end
		
		if type then
			
			
			-- Try and extract the comments
			local text = raw:match("|N|+([^|]+)");
			comment = comment or text and text:len() > 4 and (':"'..(text:trim())..'"') or '';
			
			-- Extract location
			local loc = '';
			if not ignoreLocation then
				data = data and (data..',') or '';
				local zoneName = raw:match("|Z|+([^|]+)|");
				local x,y = raw:match("%(%s*([%d%.]-)%s*,%s*([%d%.]-)%s*%)");
				if not (zoneName and tonumber(x) and tonumber(y)) then
					--print(format('Error: unable to determine location from task %d:"%s"',i,raw));
				else
					loc = format("%s,%s,%s",tonumber(x)/100,tonumber(y)/100,ZoneNameToMapID(zoneName) or "UnknownMap");
				end
			end
			
			local class = raw:match("|C|+([^|]+)");
			if class then
				comment = comment .. '?Class_'..class;
			end
			
			local converted = format("%s[%s%s]%s",type,data,loc,comment);
			new = new..converted..'\t\t\t\t\t{'..(raw:match("{(.-)}") or raw)..'}\n';
			
		end
		
		end
	end
	
	new = new:gsub('%(%s*(%d+)%.?(%d-)%s*,%s*(%d+)%.?(%d-)%s*%)',function(x1,x2,y1,y2)
		return format("(0.%s%s,0.%s%s)",x1,x2,y1,y2);
	end);
	if replace then
		DumpBox:SetText(new);
	end
	return new;
end



local thread = coroutine.create(function()
	local db = DynastyGuideViewer_GSaved.Quests or {};
	DynastyGuideViewer_GSaved.Quests = db;
	for i = 1,50000 do
		if not db[i] then
			local name = GameInfo:GetQuestName(i);
			if name then
				print(i,name);
				db[i] = name;
			end
			coroutine.yield();
		end
	end
	print('pass 2');
	for i = 1,50000 do
		if not db[i] then
			local name = GameInfo:GetQuestName(i);
			if name then
				print(i,name);
				db[i] = name;
			end
			coroutine.yield();
		end
	end
	print('finished');
end);

EventHandler:Register('ON_UPDATE', function()
	if SCAN_QUESTS and coroutine.status(thread) ~= "dead" then
		coroutine.resume(thread);
	end
end);


