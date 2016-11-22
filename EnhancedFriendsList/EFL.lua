local EFL = unpack(select(2,...))
local _

local pairs, tonumber = pairs, tonumber
local format = format
local Locale = GetLocale()
local GetFriendInfo, BNGetFriendInfo, BNGetToonInfo, BNConnected, GetQuestDifficultyColor, CanCooperateWithToon = GetFriendInfo, BNGetFriendInfo, BNGetToonInfo, BNConnected, GetQuestDifficultyColor, CanCooperateWithToon

local LSM = LibStub('LibSharedMedia-3.0', true)

function EFL:ClassColorCode(class)
	for k, v in pairs(LOCALIZED_CLASS_NAMES_MALE) do
		if class == v then
			class = k
		end
	end
	if Locale ~= 'enUS' then
		for k, v in pairs(LOCALIZED_CLASS_NAMES_FEMALE) do
			if class == v then
				class = k
			end
		end
	end
	local color = RAID_CLASS_COLORS[class]
	if not color then
		return format('|cFF%02x%02x%02x', 255, 255, 255)
	else
		return format('|cFF%02x%02x%02x', color.r*255, color.g*255, color.b*255)
	end
end

function EFL:BasicUpdateFriends()
	local TexturePath = EnhancedFriendsListOptions.TexturePath
	local scrollFrame = FriendsFrameFriendsScrollFrame
	local offset = HybridScrollFrame_GetOffset(scrollFrame)
	local buttons = scrollFrame.buttons
	local numButtons = #buttons
	for i = 1, numButtons do
		local Cooperate = false
		local button = buttons[i]
		local nameText, nameColor, infoText, broadcastText
		local canInvite = FriendsFrame_HasInvitePermission()

		if button.buttonType == FRIENDS_BUTTON_TYPE_WOW then
			local name, level, class, area, connected, status, note = GetFriendInfo(button.id)
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
			FriendsFrame_SummonButton_Update(button.summonButton)
		elseif button.buttonType == FRIENDS_BUTTON_TYPE_BNET and BNConnected() then
			local presenceID, presenceName, battleTag, isBattleTagPresence, toonName, toonID, client, isOnline, lastOnline, isAFK, isDND, messageText, noteText, isRIDFriend, messageTime, canSoR = BNGetFriendInfo(button.id)
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
					if (level == nil or tonumber(level) == nil) then level = 0 end
					local classcolor = EFL:ClassColorCode(class)
					local diff = level ~= 0 and format('|cff%02x%02x%02x', GetQuestDifficultyColor(level).r * 255, GetQuestDifficultyColor(level).g * 255, GetQuestDifficultyColor(level).b * 255) or '|cFFFFFFFF'
					nameText = format('%s |cFFFFFFFF(|r%s%s|r - %s %s%s|r|cFFFFFFFF)|r', nameText, classcolor, characterName, LEVEL, diff, level)
					Cooperate = CanCooperateWithToon(toonID, HasTravelPass())
				elseif client == BNET_CLIENT_SC2 then
					nameText = format('|cFFC495DD%s|r', nameText)
				elseif client == BNET_CLIENT_D3 then
					nameText = format('|cFFC41F3B%s|r', nameText)
				else
					nameText = format('%s', nameText)
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
				nameColor = FRIENDS_BNET_NAME_COLOR
			else
				button.background:SetTexture(FRIENDS_OFFLINE_BACKGROUND_COLOR.r, FRIENDS_OFFLINE_BACKGROUND_COLOR.g, FRIENDS_OFFLINE_BACKGROUND_COLOR.b, FRIENDS_OFFLINE_BACKGROUND_COLOR.a)
				button.status:SetTexture(EFL.StatusIcons[EnhancedFriendsListOptions["StatusIconPack"]].Offline)
				nameColor = FRIENDS_GRAY_COLOR
				if lastOnline == 0 then
					infoText = FRIENDS_LIST_OFFLINE
				else
					infoText = format(BNET_LAST_ONLINE_TIME, FriendsFrame_GetLastOnline(lastOnline))
				end
			end
			FriendsFrame_SummonButton_Update(button.summonButton)
		end

		if button.summonButton:IsShown() then
			button.gameIcon:SetPoint('TOPRIGHT', -50, -2)
		else
			button.gameIcon:SetPoint('TOPRIGHT', -21, -2)
		end

		if nameText then
			button.name:SetText(nameText)
			button.name:SetTextColor(nameColor.r, nameColor.g, nameColor.b)
			button.info:SetText(infoText)
			button.info:SetTextColor(.49, .52, .54)
			if Cooperate then
				button.info:SetTextColor(1, .96, .45)
			end
			if LSM then
				button.name:SetFont(LSM:Fetch('font', EnhancedFriendsListOptions.NameFont), EnhancedFriendsListOptions.NameFontSize, EnhancedFriendsListOptions.NameFontFlag)
				button.info:SetFont(LSM:Fetch('font', EnhancedFriendsListOptions.InfoFont), EnhancedFriendsListOptions.InfoFontSize, EnhancedFriendsListOptions.InfoFontFlag)
			end
		end
	end
end

function EFL:Basic()
	hooksecurefunc('HybridScrollFrame_Update', EFL.BasicUpdateFriends)
	hooksecurefunc('FriendsFrame_UpdateFriends', EFL.BasicUpdateFriends)
end