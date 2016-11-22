-- variables

local NEWS_GUILD_ACHIEVEMENT = 0;
local NEWS_PLAYER_ACHIEVEMENT = 1;
local NEWS_DUNGEON_ENCOUNTER = 2;
local NEWS_ITEM_LOOTED = 3;
local NEWS_ITEM_CRAFTED = 4;
local NEWS_ITEM_PURCHASED = 5;
local NEWS_GUILD_LEVEL = 6;
local NEWS_GUILD_CREATE = 7;

local waiting_for_combat_end = false;
local waiting_for_news = false;
local stored_motd = nil;

local motd_to_save = "";
local event_to_save = nil;

local GuildNewsTexCoords = {
	dot = { 0.64257813, 0.68359375, 0.18750000, 0.23046875 },
	goldBG = { 0.56054688, 0.99609375, 0.24218750, 0.46679688 },
	gLine = { 0.00195313, 0.81835938, 0.01953125, 0.03320313 }
}

local defaults = {
	motd = "",
	event = nil
}

GuildNews_SavedVar = GuildNews_SavedVar or defaults

-- functions

function GuildNews_EventsEqual(event1, event2)
	for i,v in ipairs(event1) do 
		if (i ~= 1 and event2[i] ~= v) then
			return false;
		end
	end
	return true;
end

function GuildNews_BuildList(self)
	local name, icon = "","";
	self.unlockList = {};
	self.currItem = 1;

	local numGuildNews = GetNumGuildNews();
	local numButtons = 6;
	local count = 0;
	local first_event = -1;

	for index = 1, numGuildNews do
		if (count <= numButtons) then
			local isSticky, isHeader, newsType, text1, text2, id, data, data2, weekday, day, month, year = GetGuildNewsInfo(index);
			if ( newsType == nil) then
				return;
			end
			if ( isHeader ~= true ) then
				text1 = text1 or UNKNOWN;
				local icon = nil;
				local subIcon = nil;
				local itemLink = nil;
				local event_date = date("%d %B %Y", time{year=year, month=month+1, day=day+1, hour=0});
				if ( text2 and text2 ~= UNKNOWN ) then
					if ( newsType == NEWS_ITEM_LOOTED ) then
						icon = "Interface\\Icons\\inv_misc_bag_10";
					elseif ( newsType == NEWS_ITEM_CRAFTED ) then 
						icon = "Interface\\Icons\\trade_blacksmithing";
					elseif ( newsType == NEWS_ITEM_PURCHASED ) then
						icon = "Interface\\Icons\\inv_misc_coin_02";
					elseif ( newsType == NEWS_PLAYER_ACHIEVEMENT ) then
						text2 = ACHIEVEMENT_COLOR_CODE.."["..text2.."]|r";
						icon = "Interface\\Icons\\spell_holy_heroism";
					elseif ( newsType == NEWS_GUILD_ACHIEVEMENT ) then
						text1 = ACHIEVEMENT_COLOR_CODE.."["..text2.."]|r";	-- only using achievement name
						icon = "Interface\\Icons\\achievement_bg_winwsg_3-0";
					elseif ( newsType == NEWS_DUNGEON_ENCOUNTER ) then
						text2 = "|cffd10000["..text2.."]|r";
						icon = "Interface\\Icons\\spell_holy_championsbond";
					elseif ( newsType == NEWS_GUILD_LEVEL ) then
						icon = "Interface\\Icons\\achievement_bg_winwsg_3-0";
						subIcon = SUBICON_TEXCOOR_ARROW;
					end
				elseif ( newsType ~= NEWS_GUILD_CREATE ) then
					text2 = UNKNOWN;
					icon = "Interface\\Icons\\inv_misc_questionmark";
					if ( newsType == NEWS_GUILD_ACHIEVEMENT ) then
						text1 = text2;	-- only using achievement name
						icon = "Interface\\Icons\\achievement_bg_winwsg_3-0";
					end
				end
				local text = format(_G["GUILD_NEWS_FORMAT"..newsType], text1, text2);
				
				local event = { GetGuildNewsInfo(index) };
				if (count == 0) then
					first_event = index;
				end
				if (GuildNews_SavedVar.event ~= nil and GuildNews_EventsEqual(event, GuildNews_SavedVar.event)) then
					count = numButtons + 1;
				else
					if (count == numButtons) then
						self.unlockList[#self.unlockList +1] = {
											icon="",
											subIcon=nil,
											text="And more...",
											subText="",
											link="";
										};
					else
						self.unlockList[#self.unlockList +1] = {
											icon=icon,
											subIcon=subIcon,
											text=text,
											subText=event_date,
											link=itemLink;
										};
					end
					count = count + 1;
				end
			end
		end
	end
	
	if (first_event ~= -1) then
		event_to_save = { GetGuildNewsInfo(first_event) };
	end
end

function GuildNews_Onload(self)
	self:RegisterEvent("GUILD_NEWS_UPDATE");
	self:RegisterEvent("GUILD_MOTD");
	self:RegisterEvent("PLAYER_LEAVE_COMBAT");
	self:RegisterEvent("ADDON_LOADED");
end

function GuildNews_OnEvent(self, event, ...)
    local motd = ...;
	if (event == "GUILD_NEWS_UPDATE" and waiting_for_news) then
		if (InCombatLockdown()) then
			waiting_for_combat_end = true;
		else
			GuildNews:Hide();
			GuildNews:Show();
		end
		waiting_for_news = false;
	elseif (event == "GUILD_MOTD" and GuildNews_CheckForNewMotD(motd)) then
		stored_motd = motd;
		QueryGuildNews();
		waiting_for_news = true;
	elseif (event == "ADDON_LOADED" and GuildNews_CheckForNewMotD()) then
		stored_motd = GetGuildRosterMOTD();
		QueryGuildNews();
		waiting_for_news = true;
	elseif (event == "PLAYER_LEAVE_COMBAT" and waiting_for_combat_end) then
		GuildNews:Hide();
		GuildNews:Show();
		waiting_for_combat_end = false;
	end
end

function GuildNews_CheckForNewMotD(new_motd)
	local motd;
	motd = new_motd or GetGuildRosterMOTD();
	if (motd ~= "" and motd ~= GuildNews_SavedVar.motd) then
		return true;
	end
	return false;
end

function GuildNews_SavePosition()
	GuildNews:StopMovingOrSizing()
	GuildNews_SavedVar.x = GuildNews:GetLeft();
	GuildNews_SavedVar.y = GuildNews:GetTop();
end

function GuildNews_OnShow(self)
	GuildNews_BuildList(self);
	motd_to_save = stored_motd;
	
	local GuildName, RankName, Rank = GetGuildInfo("player");

	if (GuildNews_SavedVar.x ~= nil) then
		GuildNews:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", GuildNews_SavedVar.x, GuildNews_SavedVar.y)
	end
	
	self.guildNameText:SetText(GuildName);
	self.motdText:SetFormattedText(stored_motd,self.level);

	self.goldBG:SetTexCoord(unpack(GuildNewsTexCoords.goldBG));
	self.dot:SetTexCoord(unpack(GuildNewsTexCoords.dot));

	self.goldBG:SetVertexColor(0.7, 0.02, 0.02);
	self.dot:SetVertexColor(1, 1, 0.2);
	
	self.motdText:SetTextColor(1, 1, 0.9);

	self:SetMovable(true)
	self:EnableMouse(true)
	self:RegisterForDrag("RightButton")
	self:SetScript("OnDragStart", self.StartMoving)
	self:SetScript("OnDragStop", GuildNews_SavePosition)
	
	local i = 1;
	local displayFrame = _G["GuildNewsUnlockFrame1"];
	while i <=  #self.unlockList do	
		if not displayFrame then -- make frames as needed
			displayFrame = CreateFrame("FRAME", "GuildNewsUnlockFrame"..i, GuildNews, "GuildNewsTemplate");
			displayFrame:SetPoint("TOP",  _G["GuildNewsUnlockFrame"..(i-1)], "BOTTOM", 0, -1);
			displayFrame:SetAlpha(0.0);
		end
		i = i+1;		
		displayFrame = _G["GuildNewsUnlockFrame"..i];
	end
	self:SetHeight(65);
	self.fadeIn:Play();
end

function GuildNews_OnHide(self)
	local displayFrame = _G["GuildNewsUnlockFrame1"];
	local i = 1;
	while displayFrame do 	
		if displayFrame.sideAnimIn:IsPlaying() then
			displayFrame.sideAnimIn:Stop();
		end				
		displayFrame:SetAlpha(0.0);
		i = i+1;
		displayFrame = _G["GuildNewsUnlockFrame"..i];
	end	
end


function GuildNews_AnimStep(self)

	if self.currItem > 1 then
		_G["GuildNewsUnlockFrame"..(self.currItem-1)]:SetAlpha(1.0);
	end	

	if self.currItem <= #self.unlockList then
		local spellInfo = self.unlockList[self.currItem];
		local displayFrame = _G["GuildNewsUnlockFrame"..self.currItem];
		displayFrame.name:SetText(spellInfo.text);
		displayFrame.flavorText:SetText(spellInfo.subText);
		displayFrame.icon:SetTexture(spellInfo.icon);
		if (spellInfo.subIcon ~= nil) then 
			displayFrame.subIcon:SetTexCoord(unpack(spellInfo.subIcon));
			displayFrame.subIcon:Show();
		else
			displayFrame.subIcon:Hide();
		end
		displayFrame.sideAnimIn:Play();
		self.currItem = self.currItem+1;
		self:SetHeight(self:GetHeight()+45);
	end
end

function GuildNews_Remove()
	GuildNews_SavedVar.motd = motd_to_save;
	GuildNews_SavedVar.event = event_to_save;
	GuildNews.fadeOut:Play();
end
