local EFL = unpack(select(2, ...))
local _

local tinsert, tremove, pairs, ipairs, sort, tonumber = tinsert, tremove, pairs, ipairs, sort, tonumber
local format = format
local select, wipe, strtrim, strsplit, strmatch = select, wipe, strtrim, strsplit, strmatch
local GetLocale, BNConnected, BNGetFriendInfoByID, BNSetFriendNote, GetFriendInfo, SetFriendNotes, GetQuestDifficultyColor, CanCooperateWithToon = GetLocale, BNConnected, BNGetFriendInfoByID, BNSetFriendNote, GetFriendInfo, SetFriendNotes, GetQuestDifficultyColor, CanCooperateWithToon
local BNInviteFriend, BNGetFriendInfo, BNGetNumFriends, GetNumFriends, GetSelectedFriend, BNGetSelectedFriend, BNGetToonInfo = BNInviteFriend, BNGetFriendInfo, BNGetNumFriends, GetNumFriends, GetSelectedFriend, BNGetSelectedFriend, BNGetToonInfo

local LSM = LibStub('LibSharedMedia-3.0', true)

local FRIENDS_GROUP_NAME_COLOR = NORMAL_FONT_COLOR;

local INVITE_RESTRICTION_NO_TOONS = 0
local INVITE_RESTRICTION_CLIENT = 1
local INVITE_RESTRICTION_LEADER = 2
local INVITE_RESTRICTION_FACTION = 3
local INVITE_RESTRICTION_INFO = 4
local INVITE_RESTRICTION_NONE = 5

local FriendButtons = { count = 0 }
local GroupCount = 0
local GroupTotal = {}
local GroupOnline = {}
local GroupSorted = {}

local friend_popup_menus = { 'FRIEND', 'FRIEND_OFFLINE', 'BN_FRIEND', 'BN_FRIEND_OFFLINE' }
UnitPopupButtons['FRIEND_GROUP_NEW'] = { text = 'Create new group', dist = 0 }
UnitPopupButtons['FRIEND_GROUP_ADD'] = { text = 'Add to group', dist = 0, nested = 1 }
UnitPopupButtons['FRIEND_GROUP_DEL'] = { text = 'Remove from group', dist = 0, nested = 1 }
UnitPopupMenus['FRIEND_GROUP_ADD'] = { }
UnitPopupMenus['FRIEND_GROUP_DEL'] = { }

local function FriendGroups_GetTopButton(offset)
	local remaining = offset

	for i = 1, FriendButtons.count do
		local buttontype = FriendButtons[i].buttonType
		local buttonheight;
		if buttontype == FRIENDS_BUTTON_TYPE_WOW then
			buttonheight = FRIENDS_BUTTON_NORMAL_HEIGHT
		elseif buttontype == FRIENDS_BUTTON_TYPE_BNET then
			buttonheight = FRIENDS_BUTTON_NORMAL_HEIGHT
		else
			buttonheight = FRIENDS_BUTTON_HEADER_HEIGHT
		end

		if buttonheight >= remaining then
			return i - 1, remaining
		else
			remaining = remaining - buttonheight
		end
	end
end

local function FillGroups(groups, note, ...)
	wipe(groups)
	local n = select('#', ...)
	for i = 1, n do
		local v = select(i, ...)
		v = strtrim(v)
		groups[v] = true
	end
	if n == 0 then
		groups[''] = true
	end
	return note
end

local function NoteAndGroups(note, groups)
	if not note then
		return FillGroups(groups, '')
	end
	if groups then
		return FillGroups(groups, strsplit('#', note))
	end
	return strsplit('#', note)
end

local function CreateNote(note, groups)
	local value = ''
	if note then
		value = note
	end
	for group in pairs(groups) do
		value = value .. '#' .. group
	end
	return value
end

local function AddGroup(note, group)
	local groups = {}
	note = NoteAndGroups(note, groups)
	groups[''] = nil
	groups[group] = true

	return CreateNote(note, groups)
end

local function RemoveGroup(note, group)
	local groups = {}
	note = NoteAndGroups(note, groups)
	groups[''] = nil
	groups[group] = nil

	return CreateNote(note, groups)
end

local function IncrementGroup(group, online)
	if not GroupTotal[group] then
		GroupCount = GroupCount + 1
		GroupTotal[group] = 0
		GroupOnline[group] = 0
	end
	GroupTotal[group] = GroupTotal[group] + 1
	if online then
		GroupOnline[group] = GroupOnline[group] + 1
	end
end

local function FriendGroups_OnFriendMenuClick(self)
	if not self.value then
		return
	end
	
	local add = strmatch(self.value, 'FGROUPADD_(.+)')
	local del = strmatch(self.value, 'FGROUPDEL_(.+)')
	local creating = self.value == 'FRIEND_GROUP_NEW'
	
	if add or del or creating then
		local dropdown = UIDROPDOWNMENU_INIT_MENU
		local source = OPEN_DROPDOWNMENUS[1] and OPEN_DROPDOWNMENUS[1].which or self.owner

		if source == 'BN_FRIEND' or source == 'BN_FRIEND_OFFLINE' then
			local note = select(13, BNGetFriendInfoByID(dropdown.presenceID))
			if creating then
				StaticPopup_Show('FRIEND_GROUP_CREATE', nil, nil, { id = dropdown.presenceID, note = note, set = BNSetFriendNote })
			else
				if add then
					note = AddGroup(note, add)
				else
					note = RemoveGroup(note, del)
				end
				BNSetFriendNote(dropdown.presenceID, note)
			end
		elseif source == 'FRIEND' or source == 'FRIEND_OFFLINE' then
			for i = 1, GetNumFriends() do
				local name, _, _, _, _, _, note = GetFriendInfo(i)
				if name == dropdown.name then
					if creating then
						StaticPopup_Show('FRIEND_GROUP_CREATE', nil, nil, { id = i, note = note, set = SetFriendNotes })
					else
						if add then
							note = AddGroup(note, add)
						else
							note = RemoveGroup(note, del)
						end
						SetFriendNotes(i, note)
					end
					break
				end
			end
		end
		FriendGroups_Update()
	end
	HideDropDownMenu(1)
end

local function FriendGroups_HideButtons()
	local dropdown = UIDROPDOWNMENU_INIT_MENU
	local hidden = false
	for index, value in ipairs(UnitPopupMenus[UIDROPDOWNMENU_MENU_VALUE] or UnitPopupMenus[dropdown.which]) do
		if value == 'FRIEND_GROUP_ADD' or value == 'FRIEND_GROUP_DEL' or value == 'FRIEND_GROUP_NEW' then
			if not dropdown.friendsList then
				UnitPopupShown[UIDROPDOWNMENU_MENU_LEVEL][index] = 0
				hidden = true
			end
		end
	end

	if not hidden then
		wipe(UnitPopupMenus['FRIEND_GROUP_ADD'])
		wipe(UnitPopupMenus['FRIEND_GROUP_DEL'])
		local groups = {}
		local note = nil

		if dropdown.presenceID then
			note = select(13, BNGetFriendInfoByID(dropdown.presenceID))
		else
			for i = 1, GetNumFriends() do
				local name, _, _, _, _, _, noteText = GetFriendInfo(i)
				if name == dropdown.name then
					note = noteText
					break
				end
			end
		end

		NoteAndGroups(note, groups)

		for _,group in ipairs(GroupSorted) do
			if group ~= '' and not groups[group] then
				local faux = 'FGROUPADD_' .. group
				UnitPopupButtons[faux] = { text = group, dist = 0 }
				tinsert(UnitPopupMenus['FRIEND_GROUP_ADD'], faux)
			end
		end

		for group in pairs(groups) do
			if group ~= '' then
				local faux = 'FGROUPDEL_' .. group
				UnitPopupButtons[faux] = { text = group, dist = 0 }
				tinsert(UnitPopupMenus['FRIEND_GROUP_DEL'], faux)
			end
		end
	end
end

local function FriendGroups_Rename(self, old)
	local input = self.editBox:GetText()
	if input == '' then
		return
	end

	local groups = {}

	for i = 1, BNGetNumFriends() do
		local presenceID, _, _, _, _, _, _, _, _, _, _, _, noteText = BNGetFriendInfo(i)
		local note = NoteAndGroups(noteText, groups)
		if groups[old] then
			groups[old] = nil
			groups[input] = true
			note = CreateNote(note, groups)
			BNSetFriendNote(presenceID, note)
		end
	end

	for i = 1, GetNumFriends() do
		local note = select(7, GetFriendInfo(i))
		note = NoteAndGroups(note, groups)
		if groups[old] then
			groups[old] = nil
			groups[input] = true
			note = CreateNote(note, groups)
			SetFriendNotes(i, note)
		end
	end
	FriendGroups_Update()
end

local function FriendGroups_Create(self, data)
	local input = self.editBox:GetText()
	if input == '' then
		return
	end
	local note = AddGroup(data.note, input)
	data.set(data.id, note)
end

StaticPopupDialogs['FRIEND_GROUP_RENAME'] = {
	text = 'Enter new group name',
	button1 = ACCEPT,
	button2 = CANCEL,
	hasEditBox = 1,
	OnAccept = FriendGroups_Rename,
	EditBoxOnEnterPressed = function(self)
		local parent = self:GetParent()
		FriendGroups_Rename(parent, parent.data)
		parent:Hide()
	end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1
}

StaticPopupDialogs['FRIEND_GROUP_CREATE'] = {
	text = 'Enter new group name',
	button1 = ACCEPT,
	button2 = CANCEL,
	hasEditBox = 1,
	OnAccept = FriendGroups_Create,
	EditBoxOnEnterPressed = function(self)
		local parent = self:GetParent()
		FriendGroups_Create(parent, parent.data)
		parent:Hide()
	end,
	timeout = 0,
	whileDead = 1,
	hideOnEscape = 1
}

local function InviteOrGroup(clickedgroup, invite)
local groups = {}
	for i = 1, BNGetNumFriends() do
		local presenceID, _, _, _, _, toonID, _, _, _, _, _, _, noteText = BNGetFriendInfo(i)
		local note = NoteAndGroups(noteText, groups)
		if groups[clickedgroup] then
			if invite and toonID then
				BNInviteFriend(toonID)
			elseif not invite then
				groups[clickedgroup] = nil
				note = CreateNote(note, groups)
				BNSetFriendNote(presenceID, note)
			end
		end
	end
	for i = 1, GetNumFriends() do
		local name, _, _, _, connected, _, noteText = GetFriendInfo(i)
		local note = NoteAndGroups(noteText, groups)
		if groups[clickedgroup] then
			if invite and connected then
				InviteUnit(name)
			elseif not invite then
				groups[clickedgroup] = nil
				note = CreateNote(note, groups)
				SetFriendNotes(i, note)
			end
		end
	end
end

local FriendGroups_Menu = CreateFrame('Frame', 'FriendGroups_Menu')
FriendGroups_Menu.displayMode = 'MENU'

local menu_items = {
	[1] = {
		{ text = '', notCheckable = true, isTitle = true },
		{ text = 'Invite all to party', notCheckable = true, func = function(self, menu, clickedgroup) InviteOrGroup(clickedgroup, true) end },
		{ text = 'Rename group', notCheckable = true, func = function(self, menu, clickedgroup) StaticPopup_Show('FRIEND_GROUP_RENAME', nil, nil, clickedgroup) end },
		{ text = 'Remove group', notCheckable = true, func = function(self, menu, clickedgroup) InviteOrGroup(clickedgroup, false) end },
	}
}
 
FriendGroups_Menu.initialize = function(self, level)
	if not menu_items[level] then return end
	for _, items in ipairs(menu_items[level]) do
		local info = UIDropDownMenu_CreateInfo()
		for prop, value in pairs(items) do
			info[prop] = value ~= '' and value or UIDROPDOWNMENU_MENU_VALUE ~= '' and UIDROPDOWNMENU_MENU_VALUE or '[No Group]'
		end
		info.arg1 = k
		info.arg2 = UIDROPDOWNMENU_MENU_VALUE
		UIDropDownMenu_AddButton(info, level)
	end
end

function FriendGroups_OnClick(self, button)
	local group = self.text:GetText() or ''
	if button == 'RightButton' then
		ToggleDropDownMenu(1, group, FriendGroups_Menu, 'cursor', 0, 0)
	else
		EnhancedFriendsListOptions['CollapsedGroups'][group] = not EnhancedFriendsListOptions['CollapsedGroups'][group]
		FriendGroups_Update()
	end
end

function FriendGroups_Update()
	for i = 1, BNGetNumFriends() do
		local presenceID, _, _, _, _, _, _, _, _, _, _, messageText, noteText = BNGetFriendInfo(i)
		noteText = noteText or ''
		messageText = messageText or ''
		local _, group = NoteAndGroups(noteText)
		if string.match(messageText, '[%(%[]OQ[%)%]].*') and not group then
			noteText = AddGroup(noteText, 'oQueue')
			BNSetFriendNote(presenceID, noteText)
			return
		end
	end

	local numBNetTotal, numBNetOnline = BNGetNumFriends()
	local numBNetOffline = numBNetTotal - numBNetOnline
	local numWoWTotal, numWoWOnline = GetNumFriends()
	local numWoWOffline = numWoWTotal - numWoWOnline

	FriendsMicroButtonCount:SetText(numBNetOnline + numWoWOnline)
	if not FriendsListFrame:IsShown() then
		return
	end

	wipe(FriendButtons)
	wipe(GroupTotal)
	wipe(GroupOnline)
	wipe(GroupSorted)
	GroupCount = 0

	local BnetFriendGroups = {}
	local WowFriendGroups = {}

	local buttonCount = 0

	for i = 1, numBNetTotal do
		if not BnetFriendGroups[i] then
			BnetFriendGroups[i] = {}
		end
		local _, _, _, _, _, _, _, isOnline, _, _, _, _, noteText = BNGetFriendInfo(i)
		NoteAndGroups(noteText, BnetFriendGroups[i])
		for group in pairs(BnetFriendGroups[i]) do
			IncrementGroup(group, isOnline)
			if not EnhancedFriendsListOptions['CollapsedGroups'][group] then
				buttonCount = buttonCount + 1
			end
		end
	end

	for i = 1, numWoWTotal do
		if not WowFriendGroups[i] then
			WowFriendGroups[i] = {}
		end
		local _, _, _, _, connected, _, note = GetFriendInfo(i)
		NoteAndGroups(note, WowFriendGroups[i])
		for group in pairs(WowFriendGroups[i]) do
			IncrementGroup(group, connected)
			if not EnhancedFriendsListOptions['CollapsedGroups'][group] then
				buttonCount = buttonCount + 1
			end
		end
	end

	buttonCount = buttonCount + GroupCount

	if buttonCount > #FriendButtons then
		for i = #FriendButtons + 1, buttonCount do
			FriendButtons[i] = {}
		end
	end

	for group in pairs(GroupTotal) do
		tinsert(GroupSorted, group)
	end

	sort(GroupSorted)

	if GroupSorted[1] == '' then
		tremove(GroupSorted, 1)
		tinsert(GroupSorted, '')
	end

	local index = 0
	for _,group in ipairs(GroupSorted) do
		index = index + 1

		FriendButtons[index].buttonType = FRIENDS_BUTTON_TYPE_HEADER
		FriendButtons[index].text = group
		if not EnhancedFriendsListOptions['CollapsedGroups'][group] then
			for i = 1, numBNetOnline do
				if BnetFriendGroups[i][group] then
					index = index + 1
					FriendButtons[index].buttonType = FRIENDS_BUTTON_TYPE_BNET
					FriendButtons[index].id = i
				end
			end
			for i = 1, numWoWOnline do
				if WowFriendGroups[i][group] then
				index = index + 1
				FriendButtons[index].buttonType = FRIENDS_BUTTON_TYPE_WOW
				FriendButtons[index].id = i
				end
			end
			for i = numBNetOnline + 1, numBNetTotal do
				if BnetFriendGroups[i][group] then
					index = index + 1
					FriendButtons[index].buttonType = FRIENDS_BUTTON_TYPE_BNET
					FriendButtons[index].id = i
				end
			end
			for i = numWoWOnline + 1, numWoWTotal do
				if WowFriendGroups[i][group] then
					index = index + 1
					FriendButtons[index].buttonType = FRIENDS_BUTTON_TYPE_WOW
					FriendButtons[index].id = i
				end
			end
		end
	end
	FriendButtons.count = index

	local selectedFriend = 0

	if index > 0 then
		if FriendsFrame.selectedFriendType == FRIENDS_BUTTON_TYPE_WOW then
			selectedFriend = GetSelectedFriend()
		elseif FriendsFrame.selectedFriendType == FRIENDS_BUTTON_TYPE_BNET then
			selectedFriend = BNGetSelectedFriend()
		end
		if selectedFriend == 0 then
			FriendsFrame_SelectFriend(FriendButtons[1].buttonType, 1)
			selectedFriend = 1
		end
		
		local isOnline
		if FriendsFrame.selectedFriendType == FRIENDS_BUTTON_TYPE_WOW then
			local name, level, class, area
			name, level, class, area, isOnline = GetFriendInfo(selectedFriend)
		elseif FriendsFrame.selectedFriendType == FRIENDS_BUTTON_TYPE_BNET then
			local presenceID, presenceName, battleTag, isBattleTagPresence, toonName, toonID, client
			presenceID, presenceName, battleTag, isBattleTagPresence, toonName, toonID, client, isOnline = BNGetFriendInfo(selectedFriend)
			if not presenceName then
				isOnline = false
			end
		end
		if isOnline then
			FriendsFrameSendMessageButton:Enable()
		else
			FriendsFrameSendMessageButton:Disable()
		end
	else
		FriendsFrameSendMessageButton:Disable()
	end
	FriendsFrame.selectedFriend = selectedFriend
	FriendGroups_UpdateFriends()
end

function FriendGroups_UpdateFriends()
	local scrollFrame = FriendsFrameFriendsScrollFrame
	local offset = HybridScrollFrame_GetOffset(scrollFrame)
	local buttons = scrollFrame.buttons
	local numButtons = #buttons
	local numFriendButtons = FriendButtons.count
	local height
	local usedHeight = 0
	FriendsFrameOfflineHeader:Hide()
	for i = 1, numButtons do
		local Cooperate = false
		local nameText, nameColor, infoText, broadcastText
		local canInvite = FriendsFrame_HasInvitePermission()
		local button = buttons[i]
		local index = offset + i
		if index <= numFriendButtons then
			button.buttonType = FriendButtons[index].buttonType
			button.id = FriendButtons[index].id
			height = FRIENDS_BUTTON_NORMAL_HEIGHT

			button.status:Show()
			button.status:SetSize(16, 16)
			button.background:Show()
			button.background:SetAlpha(1.0)
			button.info:Show()
			button.name:SetJustifyH('LEFT')
			button.text:Hide()

			if FriendButtons[index].buttonType == FRIENDS_BUTTON_TYPE_WOW then
				local name, level, class, area, connected, status, note = GetFriendInfo(FriendButtons[index].id)
				broadcastText = nil
				if connected then
					button.background:SetTexture(FRIENDS_WOW_BACKGROUND_COLOR.r, FRIENDS_WOW_BACKGROUND_COLOR.g, FRIENDS_WOW_BACKGROUND_COLOR.b, FRIENDS_WOW_BACKGROUND_COLOR.a)
					if status == '' then
						button.status:SetTexture(EFL.StatusIcons[EnhancedFriendsListOptions["StatusIconPack"]].Online)
					elseif status == CHAT_FLAG_AFK then
						button.status:SetTexture(EFL.StatusIcons[EnhancedFriendsListOptions["StatusIconPack"]].AFK)
					elseif status == CHAT_FLAG_DND then
						button.status:SetTexture(EFL.StatusIcons[EnhancedFriendsListOptions["StatusIconPack"]].DND)
					end
					name = EFL:ClassColorCode(class)..name..'|r'
					nameText = format('%s%s - (%s - %s %s)', EFL:ClassColorCode(class), name, class, LEVEL, level)
					nameColor = FRIENDS_WOW_NAME_COLOR
					Cooperate = true
				else
					button.background:SetTexture(FRIENDS_OFFLINE_BACKGROUND_COLOR.r, FRIENDS_OFFLINE_BACKGROUND_COLOR.g, FRIENDS_OFFLINE_BACKGROUND_COLOR.b, FRIENDS_OFFLINE_BACKGROUND_COLOR.a)
					button.status:SetTexture(EFL.StatusIcons[EnhancedFriendsListOptions["StatusIconPack"]].Offline)
					nameText = name
					nameColor = FRIENDS_GRAY_COLOR
				end
				infoText = area
				button.gameIcon:Hide()
				FriendsFrame_SummonButton_Update(button.summonButton)
				button:SetScript('OnClick', FriendsFrameFriendButton_OnClick)
			elseif FriendButtons[index].buttonType == FRIENDS_BUTTON_TYPE_BNET and BNConnected() then
				local presenceID, presenceName, battleTag, isBattleTagPresence, toonName, toonID, client, isOnline, lastOnline, isAFK, isDND, messageText, noteText, isRIDFriend, messageTime, canSoR = BNGetFriendInfo(FriendButtons[index].id)
				local realmName, realmID, faction, race, class, zoneName, level, gameText
				broadcastText = messageText
				local characterName = toonName
				if presenceName then
					nameText = presenceName
					if isOnline and not characterName and battleTag then
						characterName = battleTag
					end
				elseif givenName then
					nameText = givenName
				else
					nameText = UNKNOWN
				end

				if characterName then
					_, _, _, realmName, realmID, faction, race, class, _, zoneName, level, gameText = BNGetToonInfo(toonID)
					if client == BNET_CLIENT_WOW then
						local classcolor = EFL:ClassColorCode(class)
						if (level == nil or tonumber(level) == nil) then level = 0 end
						local diff = level ~= 0 and format('|cff%02x%02x%02x', GetQuestDifficultyColor(level).r * 255, GetQuestDifficultyColor(level).g * 255, GetQuestDifficultyColor(level).b * 255) or '|cFFFFFFFF'
						nameText = format('%s |cFFFFFFFF(|r%s%s|r - %s %s%s|r|cFFFFFFFF)|r', nameText, classcolor, characterName, LEVEL, diff, level)
						Cooperate = CanCooperateWithToon(toonID, HasTravelPass())
					elseif client == BNET_CLIENT_SC2 then
						nameText = format('|cFFC495DD%s|r |cFFFFFFFF(|r%s|r|cFFFFFFFF)|r', nameText, characterName)
					elseif client == BNET_CLIENT_D3 then
						nameText = format('|cFFC41F3B%s|r |cFFFFFFFF(|r%s|r|cFFFFFFFF)|r', nameText, characterName)
					else
						nameText = format('%s |cFFFFFFFF(|r%s|r|cFFFFFFFF)|r', nameText, characterName)
					end
				end

				if isOnline then
					button.background:SetTexture(FRIENDS_BNET_BACKGROUND_COLOR.r, FRIENDS_BNET_BACKGROUND_COLOR.g, FRIENDS_BNET_BACKGROUND_COLOR.b, FRIENDS_BNET_BACKGROUND_COLOR.a)
					if isAFK then
						button.status:SetTexture(EFL.StatusIcons[EnhancedFriendsListOptions["StatusIconPack"]].AFK)
					elseif isDND then
						button.status:SetTexture(EFL.StatusIcons[EnhancedFriendsListOptions["StatusIconPack"]].DND)
					else
						button.status:SetTexture(EFL.StatusIcons[EnhancedFriendsListOptions["StatusIconPack"]].Online)
					end
					if client == BNET_CLIENT_WOW then
						if not zoneName or zoneName == '' then
							infoText = UNKNOWN
						else
							if realmName == EFL.MyRealm then
								infoText = zoneName
							else
								infoText = format('%s - %s', zoneName, realmName)
							end
						end
						button.gameIcon:SetTexture(EFL.GameIcons[EnhancedFriendsListOptions["GameIconPack"]][faction])
					elseif client ~= BNET_CLIENT_WOW then
						button.gameIcon:SetTexture(EFL.GameIcons[EnhancedFriendsListOptions["GameIconPack"]][client])
					end
					if client ~= BNET_CLIENT_WOW then
						infoText = gameText
					end
					button.gameIcon:Show()
					nameColor = FRIENDS_BNET_NAME_COLOR
				else
					button.background:SetTexture(FRIENDS_OFFLINE_BACKGROUND_COLOR.r, FRIENDS_OFFLINE_BACKGROUND_COLOR.g, FRIENDS_OFFLINE_BACKGROUND_COLOR.b, FRIENDS_OFFLINE_BACKGROUND_COLOR.a)
					button.status:SetTexture(EFL.StatusIcons[EnhancedFriendsListOptions["StatusIconPack"]].Offline)
					nameColor = FRIENDS_GRAY_COLOR
					button.gameIcon:Hide()
					if (not lastOnline or lastOnline == 0 or time() - lastOnline >= 31104000) == 0 then
						infoText = FRIENDS_LIST_OFFLINE
					else
						infoText = format(BNET_LAST_ONLINE_TIME, FriendsFrame_GetLastOnline(lastOnline))
					end
				end
				FriendsFrame_SummonButton_Update(button.summonButton)
				button:SetScript('OnClick', FriendsFrameFriendButton_OnClick)
			else
				height = FRIENDS_BUTTON_HEADER_HEIGHT
				nameText = nil
				local title
				local group = FriendButtons[index].text
				if group == '' then
					title = format('[%s %s]', NO, GROUP)
				else
					title = group
				end
				button.text:SetText(title)
				button.text:Show()
				local counts = format('(%s/%s)', GroupOnline[group], GroupTotal[group])
				button.name:SetText(counts)
				button.name:SetJustifyH('RIGHT')
				button.name:Show()
				button.name:SetTextColor(FRIENDS_GROUP_NAME_COLOR.r, FRIENDS_GROUP_NAME_COLOR.g, FRIENDS_GROUP_NAME_COLOR.b)
				button:SetScript('OnClick', FriendGroups_OnClick)
				if EnhancedFriendsListOptions['CollapsedGroups'][group] then
					button.status:SetTexture('Interface\\Buttons\\UI-PlusButton-UP')
				else
					button.status:SetTexture('Interface\\Buttons\\UI-MinusButton-UP')
				end
				button.status:SetSize(13, 13)
				button.info:SetText(group)
				button.info:Hide()
				button.gameIcon:Hide()
				button.background:SetTexture('Interface\\FriendsFrame\\UI-FriendsFrame-OnlineDivider')
				button.background:SetAlpha(0.4)
				button.travelPassButton:Hide()
			end

			if button.summonButton:IsShown() then
				button.gameIcon:SetPoint('TOPRIGHT', -50, -2)
			else
				button.gameIcon:SetPoint('TOPRIGHT', -21, -2)
			end

			if FriendsFrame.selectedFriendType == FriendButtons[index].buttonType and FriendsFrame.selectedFriend == FriendButtons[index].id then
				button:LockHighlight()
			else
				button:UnlockHighlight()
			end

			if nameText then
				button.name:SetText(nameText)
				button.name:SetTextColor(nameColor.r, nameColor.g, nameColor.b);
				button.info:SetText(infoText)
				button.info:SetTextColor(.49, .52, .54)
				if Cooperate then
					button.info:SetTextColor(1, .96, .45)
				end
				if LSM then
					button.name:SetFont(LSM:Fetch('font', EnhancedFriendsListOptions.NameFont), EnhancedFriendsListOptions.NameFontSize, EnhancedFriendsListOptions.NameFontFlag)
					button.info:SetFont(LSM:Fetch('font', EnhancedFriendsListOptions.InfoFont), EnhancedFriendsListOptions.InfoFontSize, EnhancedFriendsListOptions.InfoFontFlag)
				end
				button:Show()
			elseif FriendButtons[index].buttonType == FRIENDS_BUTTON_TYPE_HEADER then
				button:Show()
			else
				button:Hide()
			end

			if FriendsTooltip.button == button then
				FriendsFrameTooltip_Show(button)
			end

			button:SetHeight(height)
			usedHeight = usedHeight + height

			if GetMouseFocus() == button then
				FriendsFrameTooltip_Show(button)
			end
		else
			button:Hide()
		end
	end
end

function EFL:FriendGroups()
	FriendsFrameFriendsScrollFrame.dynamic = FriendGroups_GetTopButton
	hooksecurefunc('FriendsList_Update', FriendGroups_Update)
	hooksecurefunc('UnitPopup_HideButtons', FriendGroups_HideButtons)
	hooksecurefunc('UnitPopup_OnClick', FriendGroups_OnFriendMenuClick)
	hooksecurefunc('FriendsFrame_UpdateFriends', FriendGroups_UpdateFriends)
	hooksecurefunc('HybridScrollFrame_Update', FriendGroups_UpdateFriends)

	FriendsFrameFriendsScrollFrame.buttons[1]:SetHeight(FRIENDS_BUTTON_HEADER_HEIGHT)
	HybridScrollFrame_CreateButtons(FriendsFrameFriendsScrollFrame, 'FriendsFrameButtonTemplate')

	tremove(UnitPopupMenus['BN_FRIEND'], 5)

	for _,menu in ipairs(friend_popup_menus) do
		tinsert(UnitPopupMenus[menu], #UnitPopupMenus[menu], 'FRIEND_GROUP_NEW')
		tinsert(UnitPopupMenus[menu], #UnitPopupMenus[menu], 'FRIEND_GROUP_ADD')
		tinsert(UnitPopupMenus[menu], #UnitPopupMenus[menu], 'FRIEND_GROUP_DEL')
	end
end