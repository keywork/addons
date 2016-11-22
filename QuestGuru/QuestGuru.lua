--local addonName,addonTable = ...
--local DA = _G[addonName] -- for DebugAids.lua
QUESTGURU_VERSION = GetAddOnMetadata("QuestGuru", "Version");
local QGC_NAME = UnitName("player")
local QGC_LEVEL = UnitLevel("player")
local QGC_CLASS = UnitClass("player")
local QGC_FACTION = UnitFactionGroup("player");
CurrencyTracking_Player = UnitName("player");
CurrencyTracking_Server = GetRealmName();

local qgc = QuestGuru
local QGC_LOADMSG = "Activated |cFFFFA500QuestGuru v"..QUESTGURU_VERSION.."|r - |cFFFFD700Lazzy-Kilrogg(US)|r"

local ShowTooltips = "True"
local showLevels = "True"
local UndockWindow = "True"
local qgc = QuestGuru


QuestGuruSettings = {}
QuestGuruCollapsedHeaders = {}

local settings

qgc.quests = {}

BINDING_HEADER_QUESTGURU = "QuestGuru"
--BINDING_NAME_QUESTGURU = "Show / Hide QuestGuru"

function qgc:OnEvent(event)
	
	if event=="PLAYER_LOGIN" then
		local scrollFrame = qgc.scrollFrame
		print( QGC_LOADMSG )
		scrollFrame.update = qgc.UpdateLogList
		HybridScrollFrame_CreateButtons(scrollFrame, "QuestGuruListTemplate")
		-- hide our frame if default's popup detail log appears
		QuestLogPopupDetailFrame:HookScript("OnShow",function() qgc:HideWindow() end)
		QGC_FrameTitleText:SetFormattedText(TEXT("QuestGuru").." v"..QUESTGURU_VERSION.." for "..QGC_NAME..", level "..QGC_LEVEL.." "..QGC_CLASS)
		
		qgc:RegisterEvent("UPDATE_BINDINGS")
--	elseif event=="QUEST_DETAIL" then
		qgc:HideWindow()
	else
		local selected = GetQuestLogSelection()
		if selected==0 then
			qgc:SelectFirstQuest()
		else
			qgc:UpdateLogList()
			qgc:SelectQuestIndex(selected)
		end
	end
end


function qgc:OnShow()
--	DA.DEBUG(0,"qgc:OnShow()");
	if WorldMapFrame:IsVisible() then
		ToggleWorldMap() -- can't have world map up at same time due to potential details frame being up
	end
	if QuestLogPopupDetailFrame:IsVisible() then
		HideUIPanel(QuestLogPopupDetailFrame)
	end
	local selected = GetQuestLogSelection()
	if not selected or selected==0 then
		qgc:SelectFirstQuest()
	else
		qgc:SelectQuestIndex(selected)
	end
	
	SetPortraitTexture(QGC_FramePortrait, "player")
	qgc:RegisterEvent("QUEST_DETAIL")
	qgc:RegisterEvent("QUEST_LOG_UPDATE")
	qgc:RegisterEvent("QUEST_WATCH_LIST_CHANGED")
	qgc:RegisterEvent("SUPER_TRACKED_QUEST_CHANGED")
	qgc:RegisterEvent("GROUP_ROSTER_UPDATE")
	qgc:RegisterEvent("PARTY_MEMBER_ENABLE")
	qgc:RegisterEvent("PARTY_MEMBER_DISABLE")
	qgc:RegisterEvent("QUEST_POI_UPDATE")
	qgc:RegisterEvent("QUEST_WATCH_UPDATE")
	qgc:RegisterEvent("QUEST_ACCEPTED")
	qgc:RegisterEvent("UNIT_QUEST_LOG_CHANGED")
	if not tContains(UISpecialFrames,"QuestGuru") then
		tinsert(UISpecialFrames,"QuestGuru")
	end
	qgc.detail:ClearAllPoints()
	qgc.detail:SetPoint("TOPRIGHT",-32,-63)
	PlaySound("igQuestLogOpen")
end

-- no need to watch these events while log isn't on screen
function qgc:OnHide()
	-- only keep this window in UISpecialFrames while it's up
	for i=#UISpecialFrames,1,-1 do
		if UISpecialFrames[i]=="QuestGuru" then
			tremove(UISpecialFrames,i)
		end
	end
	qgc:UnregisterEvent("QUEST_DETAIL")
	qgc:UnregisterEvent("QUEST_LOG_UPDATE")
	qgc:UnregisterEvent("QUEST_WATCH_LIST_CHANGED")
	qgc:UnregisterEvent("SUPER_TRACKED_QUEST_CHANGED")
	qgc:UnregisterEvent("GROUP_ROSTER_UPDATE")
	qgc:UnregisterEvent("PARTY_MEMBER_ENABLE")
	qgc:UnregisterEvent("PARTY_MEMBER_DISABLE")
	qgc:UnregisterEvent("QUEST_POI_UPDATE")
	qgc:UnregisterEvent("QUEST_WATCH_UPDATE")
	qgc:UnregisterEvent("QUEST_ACCEPTED")
	qgc:UnregisterEvent("UNIT_QUEST_LOG_CHANGED")
	PlaySound("igQuestLogClose")
	-- expand all headers when window hides so default doesn't lose track of collapsed quests
	local index = 1
	while index<=GetNumQuestLogEntries() do
		local _,_,_,isHeader,isCollapsed = GetQuestLogTitle(index)
		if isHeader and isCollapsed then
			ExpandQuestHeader(index)
		end
		index = index + 1
	end
end

-- this shows the update frame whose purpose is to run UpdateLog below on the next frame
-- this prevents multiple events firing at once from recreating the log every event
function qgc:UpdateLogList()
	qgc.update:Show()
end

-- called from the OnUpdate of qgc.update
function qgc:UpdateLog()
	qgc.update:Hide() -- immediately stop the OnUpdate
	-- gather quests into a working table (qgc.quests) to skip over collapsed headers
	wipe(qgc.quests)
	qgc.expanded = nil
	
	local numQuests = 0
	for index=1,GetNumQuestLogEntries() do
	local questTitle, level, suggestedGroup, isHeader, isCollapsed, isComplete, frequency, questID, startEvent, displayQuestID, isOnMap, hasLocalPOI, isTask, isBounty, isStory, isHidden = GetQuestLogTitle(index)
		if not isHidden then
			table.insert(qgc.quests,{index,questTitle,level,suggestedGroup,isHeader,isCollapsed,isComplete,frequency,questID})
			if not isHeader then
				numQuests = numQuests + 1
			end
		end
	end

	-- next remove any quest headers that have no quests
	local hasQuests
	for index=#qgc.quests,1,-1 do
		if qgc.quests[index][5] then -- this is a header
			if not hasQuests then -- with no quests beneath it
				tremove(qgc.quests,index) -- remove the header
			end
			hasQuests = nil -- reset flag to look for quests
		else
			hasQuests = true -- this is a quest, keep the header this is beneath
		end
	end

	-- next flag quests to be removed due to collapsed headers (can't tremove since have to loop forward)
	local skipping
	for index=1,#qgc.quests do
		if qgc.quests[index][5] then -- this is a header
			skipping = QuestGuruCollapsedHeaders[qgc.quests[index][2]] -- [2] is questTitle
			if not skipping then
				qgc.expanded = true -- at least one header is expanded (for all quest +/- choice)
			end
		elseif skipping then
			qgc.quests[index] = false
		end
	end
	-- then strip out flagged quests (doing this backside since we need to remove backwards)
	for index=#qgc.quests,1,-1 do
		if qgc.quests[index]==false then
			tremove(qgc.quests,index)
		end
	end

	-- finally update left frame
	local numEntries = #qgc.quests
	local scrollFrame = qgc.scrollFrame
	local offset = HybridScrollFrame_GetOffset(scrollFrame)
	local buttons = scrollFrame.buttons
	local selectedIndex = GetQuestLogSelection()

	qgc.count.text:SetText(format("%s \124cffffffff%d/%d",QUESTS_COLON,numQuests,MAX_QUESTLOG_QUESTS))

	for i=1, #buttons do
		local index = i + offset
		local button = buttons[i]
		if ( index <= numEntries ) then
			local entry, questTitle, level, suggestedGroup, isHeader, isCollapsed, isComplete, frequency, questID = unpack(qgc.quests[index])

			button.index = entry -- this is the questLogIndex
			button.questID = questID
			button.isHeader = isHeader
			button.isCollapsed = isCollapsed
			button.questTitle = questTitle

			button.normalText:SetWidth(275)
			local maxWidth = 275 -- we may shrink normalText to accomidate check and tag icons

			local color = isHeader and QuestDifficultyColors["header"] or GetQuestDifficultyColor(level)
			if not isHeader and selectedIndex==entry then
				button:SetNormalFontObject("GameFontHighlight")
				button.selected:SetVertexColor(color.r,color.g,color.b)
				button.selected:Show()
			else
				button:SetNormalFontObject(color.font)
				button.selected:Hide()
			end

			if isHeader then
				button:SetText(questTitle)
				button:SetNormalTexture(isCollapsed and "Interface\\Buttons\\UI-PlusButton-Up" or "Interface\\Buttons\\UI-MinusButton-Up")
				button:SetHighlightTexture("Interface\\Buttons\\UI-PlusButton-Hilight")
				button.check:Hide()
				button.tag:Hide()
				button.groupMates:Hide()
			else
--				if QuestGuruSettings.ShowLevels then
				button:SetText(format("  [%d] %s",level,questTitle))
--				else
--					button:SetText(format("  %s",questTitle))
--				end
				button:SetNormalTexture("")
				button:SetHighlightTexture("")
				-- if quest is tracked, show check and shorted max normalText width
				if IsQuestWatched(entry) then
					maxWidth = maxWidth - 16
					button.check:Show()
				else
					button.check:Hide()
				end
				-- display an icon to note what type of quest it is
				-- tag. daily icon can be alone or before other icons except for COMPLETED or FAILED
				local tagID
				local questTagID, tagName = GetQuestTagInfo(questID)
				if isComplete and isComplete<0 then
					tagID = "FAILED"
				elseif isComplete and isComplete>0 then
					tagID = "COMPLETED"
				elseif questTagID and questTagID==QUEST_TAG_ACCOUNT then
					local factionGroup = GetQuestFactionGroup(questID)
					if factionGroup then
						tagID = "ALLIANCE"
						if factionGroup==LE_QUEST_FACTION_HORDE then
							tagID = "HORDE"
						end
					else
						tagID = QUEST_TAG_ACCOUNT;
					end
				elseif frequency==LE_QUEST_FREQUENCY_DAILY and (not isComplete or isComplete==0) then
					tagID = "DAILY"
				elseif frequency==LE_QUEST_FREQUENCY_WEEKLY and (not isComplete or isComplete==0) then
					tagID = "WEEKLY"
				elseif questTagID then
					tagID = questTagID
				end
				button.tagID = nil
				button.tag:Hide()
				if tagID then -- this is a special type of quest
					maxWidth = maxWidth - 16
					local tagCoords = QUEST_TAG_TCOORDS[tagID]
					if tagCoords then
						button.tagID = tagID
						button.tag:SetTexCoord(unpack(tagCoords))
						button.tag:Show()
					end
				end

				-- If not a header see if any nearby group mates are on this quest
				local partyMembersOnQuest = 0
				for j=1,GetNumSubgroupMembers() do
					if IsUnitOnQuest(entry,"party"..j) then
						partyMembersOnQuest = partyMembersOnQuest + 1
					end
				end
				if partyMembersOnQuest>0 then
					button.groupMates:SetText("["..partyMembersOnQuest.."]")
					button.partyMembersOnQuest = partyMembersOnQuest
					button.groupMates:Show()
				else
					button.partyMembersOnQuest = nil
					button.groupMates:Hide()
				end

			end

			-- limit normalText width to the maxWidth
			button.normalText:SetWidth(min(maxWidth,button.normalText:GetStringWidth()))

			button:Show()
		else
			button:Hide()
		end
	end

	if numEntries==0 then
		qgc.scrollFrame:Hide()
		qgc.emptyLog:Show()
		qgc.detail:Hide()
	else
		qgc.scrollFrame:Show()
		qgc.emptyLog:Hide()
		qgc.scrollFrame.expandAll:SetNormalTexture(qgc.expanded and "Interface\\Buttons\\UI-MinusButton-Up" or "Interface\\Buttons\\UI-PlusButton-Up")
	end

	qgc:UpdateControlButtons()

	HybridScrollFrame_Update(scrollFrame, 16*numEntries, 16)
end

--list entry handling 

function qgc:ListEntryOnClick()
	local index = self.index
	if self.isHeader then
		QuestGuruCollapsedHeaders[self.questTitle] = not QuestGuruCollapsedHeaders[self.questTitle] or nil
	else
		if IsModifiedClick("CHATLINK") and ChatEdit_GetActiveWindow() then
			local link = GetQuestLink(self.questID)
			if link then
				ChatEdit_InsertLink(link)
			end
		elseif IsModifiedClick("QUESTWATCHTOGGLE") then
			qgc:ToggleWatch(index)
		else
			qgc:SelectQuestIndex(index)
		end
	end
	qgc:UpdateLogList()
end

function qgc:ToggleWatch(index)
	if not index then
		index = GetQuestLogSelection()
	end
	if index>0 then
		if IsQuestWatched(index) then -- already watched, remove from watch
			RemoveQuestWatch(index)
			QuestGuru.Track:SetText("Track")
		else -- not watched, see if there's room to add, add if so
			if GetNumQuestWatches() >= MAX_WATCHABLE_QUESTS then
				UIErrorsFrame:AddMessage(format(QUEST_WATCH_TOO_MANY,MAX_WATCHABLE_QUESTS),1,0.1,0.1,1)
			else
				AddQuestWatch(index)
				QuestGuru.Track:SetText("UnTrack")
			end
		end
	end
end


--if ( IsQuestWatched(questLogSelection) ) then
--		QuestMapFrame.DetailsFrame.Track:SetText(UNTRACK_QUEST_ABBREV);
--		QuestLogPopupDetailFrame.Track:SetText(UNTRACK_QUEST_ABBREV);
--	else
--		QuestMapFrame.DetailsFrame.Track:SetText(TRACK_QUEST_ABBREV);
--		QuestLogPopupDetailFrame.Track:SetText(TRACK_QUEST_ABBREV);
--	end

-- tooltip
function qgc:ListEntryOnEnter()
	local index = self.index

	if self.isHeader or not index then
		return
	end

	GameTooltip:SetOwner(self,"ANCHOR_RIGHT")
	GameTooltip:AddLine((GetQuestLogTitle(index)),1,.82,0)

	local title, level, suggestedGroup, isHeader, isCollapsed, isComplete, frequency, questID, startEvent, displayQuestID, isOnMap, hasLocalPOI = GetQuestLogTitle(self.index)

	-- quest tag tooltip info (shameless copy-paste from QuestMapFrame.lua)
	local tagID, tagName = GetQuestTagInfo(questID);
	if ( tagName ) then
		local factionGroup = GetQuestFactionGroup(questID);
		-- Faction-specific account quests have additional info in the tooltip
		if ( tagID == QUEST_TAG_ACCOUNT and factionGroup ) then
			local factionString = FACTION_ALLIANCE;
			if ( factionGroup == LE_QUEST_FACTION_HORDE ) then
				factionString = FACTION_HORDE;
			end
			tagName = format("%s (%s)", tagName, factionString);
		end
		GameTooltip:AddLine(tagName, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
		if ( QUEST_TAG_TCOORDS[tagID] ) then
			local questTypeIcon;
			if ( tagID == QUEST_TAG_ACCOUNT and factionGroup ) then
				questTypeIcon = QUEST_TAG_TCOORDS["ALLIANCE"];
				if ( factionGroup == LE_QUEST_FACTION_HORDE ) then
					questTypeIcon = QUEST_TAG_TCOORDS["HORDE"];
				end
			else
				questTypeIcon = QUEST_TAG_TCOORDS[tagID];
			end
			GameTooltip:AddTexture("Interface\\QuestFrame\\QuestTypeIcons", unpack(questTypeIcon));
		end
	end
	if ( frequency == LE_QUEST_FREQUENCY_DAILY ) then
		GameTooltip:AddLine(DAILY, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
		GameTooltip:AddTexture("Interface\\QuestFrame\\QuestTypeIcons", unpack(QUEST_TAG_TCOORDS["DAILY"]));
	elseif ( frequency == LE_QUEST_FREQUENCY_WEEKLY ) then
		GameTooltip:AddLine(WEEKLY, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
		GameTooltip:AddTexture("Interface\\QuestFrame\\QuestTypeIcons", unpack(QUEST_TAG_TCOORDS["WEEKLY"]));
	end
	if ( isComplete and isComplete < 0 ) then
		GameTooltip:AddLine(FAILED, RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b);
		GameTooltip:AddTexture("Interface\\QuestFrame\\QuestTypeIcons", unpack(QUEST_TAG_TCOORDS["FAILED"]));	
	end

	-- list members on quest if they exist
	if self.partyMembersOnQuest then
		GameTooltip:AddLine(PARTY_QUEST_STATUS_ON,1,.82,0)
		for j=1,GetNumSubgroupMembers() do
			if IsUnitOnQuest(index,"party"..j) then
				GameTooltip:AddLine(GetUnitName("party"..j),.9,.9,.9)
			end
		end
	end

	-- description
	if isComplete and isComplete>0 then
		if ( IsBreadcrumbQuest(self.questID) ) then
			GameTooltip:AddLine(GetQuestLogCompletionText(self.index), 1, 1, 1, true);
		else
			GameTooltip:AddLine(QUEST_WATCH_QUEST_READY, 1, 1, 1, true);
		end
	else
		local _, objectiveText = GetQuestLogQuestText(index)
		GameTooltip:AddLine(objectiveText,.85,.85,.85,true)
		local requiredMoney = GetQuestLogRequiredMoney(index)
		local numObjectives = GetNumQuestLeaderBoards(index)
		for i=1,numObjectives do
			local text, objectiveType, finished = GetQuestLogLeaderBoard(i,index)
			if ( text ) then
				local color = HIGHLIGHT_FONT_COLOR
				if ( finished ) then
					color = GRAY_FONT_COLOR
				end
				GameTooltip:AddLine(QUEST_DASH..text, color.r, color.g, color.b, true)
			end
		end
		if ( requiredMoney > 0 ) then
			local playerMoney = GetMoney()
			local color = HIGHLIGHT_FONT_COLOR
			if ( requiredMoney <= playerMoney ) then
				playerMoney = requiredMoney
				color = GRAY_FONT_COLOR
			end
			GameTooltip:AddLine(QUEST_DASH..GetMoneyString(playerMoney).." / "..GetMoneyString(requiredMoney), color.r, color.g, color.b);
		end

	end
	GameTooltip:Show()
end

-- selection

function qgc:SelectQuestIndex(index)

	SelectQuestLogEntry(index)

	StaticPopup_Hide("ABANDON_QUEST")
	StaticPopup_Hide("ABANDON_QUEST_WITH_ITEMS")
	SetAbandonQuest()

	if ( index == 0 ) then
		qgc.selectedIndex = nil
		QuestGuruDetailScrollFrame:Hide()
	elseif index>0 and index<=GetNumQuestLogEntries() and not select(4,GetQuestLogTitle(index)) then
		QuestGuruDetailScrollFrame:Show()
		QuestInfo_Display(QUEST_TEMPLATE_LOG, QuestGuruDetailScrollChildFrame)
		QuestGuruDetailScrollFrameScrollBar:SetValue(0) -- scroll to top
	end
		if IsQuestWatched(index) then -- already watched, remove from watch
			QuestGuru.Track:SetText("UnTrack")
		else -- not watched, see if there's room to add, add if so
			QuestGuru.Track:SetText("Track")
		end
	
	qgc:UpdateLogList()
end

-- selects the first quest in the log (if any)
function qgc:SelectFirstQuest()
	for i=1,GetNumQuestLogEntries() do
		if not select(4,GetQuestLogTitle(i)) then
			qgc:SelectQuestIndex(i)
			return
		end
	end
	qgc:SelectQuestIndex(0) -- if we reached here, select nothing
end

--[[ control buttons ]]

function qgc:UpdateControlButtons()
	local selectionIndex = GetQuestLogSelection()
	if selectionIndex==0 then
		qgc.abandon:Disable()
		qgc.push:Disable()
		qgc.Track:Disable()
	else
		local questID = select(8,GetQuestLogTitle(selectionIndex))
		qgc.abandon:SetEnabled(GetAbandonQuestName() and CanAbandonQuest(questID))
		qgc.push:SetEnabled(GetQuestLogPushable() and IsInGroup())
		qgc.Track:Enable()
	end
end

function qgc:ExpandAllOnClick()
	if not qgc.expanded then
		wipe(QuestGuruCollapsedHeaders)
	else
		for i=1,GetNumQuestLogEntries() do
			local questTitle,_,_,isHeader = GetQuestLogTitle(i)
			if isHeader then
				QuestGuruCollapsedHeaders[questTitle] = true
			end
		end
	end
	qgc:UpdateLogList()
end

--[[ map button ]]

function qgc:ShowMap()
	qgc:HideWindow() -- can't let map quest details fight with our details
	local selectionIndex = GetQuestLogSelection()
	if selectionIndex==0 then
		ToggleWorldMap()
		HideUIPanel(QuestLogFrame)
	else
		local questID = select(8,GetQuestLogTitle(selectionIndex))
		if not WorldMapFrame:IsVisible() then
			ToggleWorldMap()
		end
--		QuestMapFrame_ShowQuestDetails(questID)
	end
end

function qgc:ToggleWindow()
		QuestGuru:SetShown(not QuestGuru:IsVisible())
	if QuestGuru:IsVisible() then
		HideUIPanel(QuestGuru)
	else
		ShowUIPanel(QuestGuru)
	end
end

function qgc:HideWindow()
	if QuestGuruSettings.UndockWindow then
		QuestGuru:Hide()
	else
		HideUIPanel(QuestGuru)
	end
end

