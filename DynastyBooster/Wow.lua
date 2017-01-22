local ADDON_NAME, DGV = ...;

local MapData = DynastyCore.MapData;
local PlayerInfo = DynastyCore.PlayerInfo;
local GameInfo = DGV.GameInfo;

local NPCID_MATCH = 'Creature%-%d+%-%d+%-%d+%-%d+%-(%d+)';

local BlobFrame = CreateFrame('QuestPOIFrame',nil,UIParent);
BlobFrame:SetPoint('TOPLEFT');
BlobFrame:SetSize(10,10);

DGV:RegisterTaskType('G',{ -- GoTo
	Trackable = true,
	Merged = true,
	Render = function(self)
		local x,y,m,f = unpack(self.Location);
		m = tonumber(m);
		f = tonumber(f);
		local mapData = MapData:Get( tonumber(m) );
		if mapData then
			x,y = MapData:Untranslate( m,0,x,y )
			if x and y then
				x = x*100;
				y = y*100;
			end
			return format("Travel to [%d,%d] in %s", x, y, mapData.Name );
		end
		return format("Travel to [%d,%d].", x, y);
	end,
	GetProgress = function(self)
		if self.Completed then
			return 1;
		end
		local x,y,map,floor = unpack(self.Location);
		local map,floor = tonumber(map), 0;
		if MapData:IsSameContinent( map, PlayerInfo.Map ) and PlayerInfo.X and PlayerInfo.Y then
			--x,y = MapData:Translate( map, floor, x, y );
			local d = MapData:Distance( PlayerInfo.X, PlayerInfo.Y, x, y )
			if DGV.CurrentTask == self then
				if x and d < 15 then
					
					self.Completed = true;
					return 1;
				else
					self.StartDist = max(d,self.StartDist or d);
					return (self.StartDist-d)/self.StartDist;
				end
			end
		end
		return 0;
	end,
	GetObjective = function(self)
		return unpack(self.Data);
	end,
});
DGV:RegisterTaskType('T',{ -- Talk to
	Trackable = true,
	Render = function(self)
		local name = GameInfo:GetNPCName(self.Data[1]);
		return name and ("Speak with |cFF00FF44%s|r."):format(name);
	end,
	GetProgress = function(self)
		return ( tonumber((UnitGUID('npc') or ''):match(NPCID_MATCH)) == tonumber(self.Data[1]) ) and 1 or 0;
	end,
	GetObjective = function(self)
		return select(2,unpack(self.Data));
	end,
});
DGV:RegisterTaskType('A',{ -- Accept Quest
	Trackable = true,
	Important = true,
	Render = function(self)
		local name = GameInfo:GetQuestName(self.Data[1]);
		return name and ('Pickup |cFFFFFF00[%s]|r.'):format(name);
	end,
	GetProgress = function(self)
		local s = GameInfo:GetQuestState( self.Data[1] );
		return s == 'NONE' and 0 or 1;
	end,
	GetObjective = function(self)
		return select(2,unpack(self.Data));
	end,
});
DGV:RegisterTaskType('I',{ -- Interact with object (obsolete, just use talk-to and a render override string)
	Trackable = true,
	Render = function(self)
		local name = self.Data[1] or '';
		return ('Interact with %s'):format(name);
	end,
	GetProgress = function(self)
		return (UnitName('npc') == self.Data[1]) and 1 or 0
	end,
	GetObjective = function(self)
		return select(2,unpack(self.Data));
	end,
});
DGV:RegisterTaskType('C',{ -- Complete Quest
	Trackable = true,
	Important = true,
	Render = function(self)
		--GetQuestLogCompletionText?
		local name = GameInfo:GetQuestName(self.Data[1]);
		return name and ('Turn in |cFFFFFF00[%s]|r.'):format(name);
	end,
	GetProgress = function(self)
		local s = GameInfo:GetQuestState( self.Data[1] );
		return (s == 'COMPLETED' and 1) or 0;
	end,
	CanProgress = function(self)
		local s, i = GameInfo:GetQuestState( self.Data[1] )
		if s == 'ACTIVE' then
			for j = 1,GetNumQuestLeaderBoards(i) do
				if not select(3, GetQuestLogLeaderBoard( j, i )) then
					return false;
				end
			end
			return true;
		end
		return false;
	end,
	GetObjective = function(self)
		local id,x,y,map,floor,_ = unpack(self.Data);
		if x and y and map then -- Author override.
			return x,y,map,floor;
		end
		if MapData.SaveMapState() then
			map, floor = GetQuestWorldMapAreaID(self.Data[1]);
			SetMapByID(map or 0, floor);
			_,x,y = QuestPOIGetIconInfo(self.Data[1]);
			MapData.LoadMapState()
		end
		return x,y,map,floor;
	end,
});
DGV:RegisterTaskType('P',{ -- Quest Progress Tracker
	Trackable = true,
	Important = true,
	Render = function(self)
		-- Check quest log for quest
		local i = GetQuestLogIndexByID( self.Data[1] );
		local objective = tonumber(self.Data[2]);
		
		if i then -- quest is active
			if not objective then -- Legacy "Complete Quest" support
				for j = 1,GetNumQuestLeaderBoards(i) do
					if not select(3, GetQuestLogLeaderBoard( j, i )) then
						objective = j;
						break;
					end
				end
			else
				local desc, type, isCompleted = GetQuestLogLeaderBoard( objective, i );
				if desc then
					local v,m,text = desc:match("^(%d+)/(%d+) (.*)");
					if v and m and text then
						return format("%s - %d/%d",text,v,m)
					end
				end
			end
		end
		
		-- Check tooltip
		local text = GameInfo:GetQuestObjectiveText( self.Data[1], objective );
		if text then
			local n,text = text:match("(%d*)%s*x?%-?%s*(.*)");
			return text;
		end
		
		-- Quest tooltip is probably still loading, or the objective is not yet visible to the player. 
		return nil;
	end,
	GetProgress = function(self)
		local s, i = GameInfo:GetQuestState( self.Data[1] );
		local objective = tonumber(self.Data[2]);
		if s == 'ACTIVE' then
			
			if not objective then -- Legacy "Complete Quest" support
				for j = 1,GetNumQuestLeaderBoards(i) do
					if not select(3, GetQuestLogLeaderBoard( j, i )) then
						objective = j;
						break;
					end
				end
				if not objective then
					return 1;
				end
			end
			
			local desc, type, isCompleted = GetQuestLogLeaderBoard( objective, i );
			if isCompleted then
				return 1;
			elseif desc then -- try and extract progress from description.
				local v,m = desc:match("^(%d+)/(%d+)");
				return (tonumber(v) or 0)/(tonumber(m) or 1);
			else
				return 0;
			end
		end
		return (s == 'COMPLETED' and 1) or 0;
	end,
	CanProgress = function(self)
		local i = GetQuestLogIndexByID( self.Data[1] );
		local objective = tonumber(self.Data[2]);
		return i and ( (not objective) or GetQuestLogLeaderBoard( objective, i ) ) and true;
	end,
	GetObjective = function(self)
		local id,i,x,y,map,floor,_ = unpack(self.Data);
		if x and y and map then -- Author override.
			return x,y,map,floor;
		end
		if MapData.SaveMapState() then
			map, floor = GetQuestWorldMapAreaID(id); 
			SetMapByID(map or 0, floor); -- GetQuestWorldMapAreaID sets map to current zone anyway, but i think that's a bug, do this just in case.
			
			-- These are normally called by WorldMapFrame_OnEvent, but it's disabled atm.
			QuestMapUpdateAllQuests();
			QuestPOIUpdateIcons();
			
			BlobFrame:DrawNone();
			BlobFrame:DrawBlob(id, true);
			local logIndex = GetQuestLogIndexByID(id);
			local px,py = GetPlayerMapPosition('player');
			--if logIndex and logIndex == BlobFrame:UpdateMouseOverTooltip(px,py) then
				-- In quest area, do something other than hide arrow.
			--else
				_,x,y = QuestPOIGetIconInfo(id);
			--end
			
			MapData.LoadMapState()
		end
		return x,y,map,floor;
	end,
});
DGV:RegisterTaskType('S',{ -- String / Comment
	Trackable = true,
	Initialize = function(self)
		self.Important = not not self.Data[2];
	end,
	Render = function(self)
		return self.Data[1];
	end,
	GetProgress = function(self) return 0; end,
});
DGV:RegisterTaskType('H',{ -- Bind (Hearthstone)
	Trackable = true,
	Render = function(self)
		return self.Data[1] and "Bind at "..self.Data[1];
	end,
	GetProgress = function(self) return 0; end,
	GetObjective = function(self) end,
});

DGV:RegisterTaskType('F',{ -- Fly to
	Trackable = true,
	Render = function(self)
		return self.Data[1] and "Fly to "..self.Data[1];
	end,
	GetProgress = function(self) return 0; end,
	GetObjective = function(self) end,
});


-- Legacy Tasks
--[[
R = G	Run/Goto
A = A	Accept Quest
T = C	Turn in

C = _	Finish Quest (all objectives)
N = _	Loot an item

U = U	Use Item
h = H	Set Heathstone
f = _	Pickup Flightpath

--]]
DGV:RegisterTaskType('L',{ -- Legacy
}); 