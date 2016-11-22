local E, L, V, P, G, _ = unpack(ElvUI); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB
local CA = E:GetModule('ChannelAlerts')
local CH = E:GetModule('Chat')
local LSM = LibStub('LibSharedMedia-3.0')
local EP = LibStub("LibElvUIPlugin-1.0")
local addon, ns = ...
local gsub = string.gsub

-- Create incompatibility warning popup
E.PopupDialogs['CA_Incompatible'] = {
	text = "'ElvUI CustomChannelWarning' has been renamed to 'ElvUI ChannelAlerts'. You still have the old CustomChannelWarning enabled. Click Accept below to disable 'ElvUI CustomChannelWarning'",
	button1 = ACCEPT,
	OnAccept = function() DisableAddOn('ElvUI_CustomChannelWarning'); ReloadUI(); end,
	timeout = 0,
	whileDead = 1,
	preferredIndex = 3,
}

-- Function which monitors numbered channels 1-10 and plays sound
function CA:MonitorChannels(event, _, author, _, _, _, _, _, channelNumber, ...)
	if author == UnitName('player') then return end -- Don't play sound if the message is from yourself
	if event == 'CHAT_MSG_CHANNEL' and E.db.CA['channel'..channelNumber] ~= 'None' and not CH.SoundPlayed then
		PlaySoundFile(LSM:Fetch('sound', E.db.CA['channel'..channelNumber]), 'Master')
		CH.SoundPlayed = true
		CH.SoundTimer = CH:ScheduleTimer('ThrottleSound', E.db.CA.throttle.channels)
	end
end

-- Function which monitors guild channel and plays sound
function CA:MonitorGuild(event, _, author, ...)
	if author == UnitName('player') then return end -- Don't play sound if the message is from yourself
	if event == 'CHAT_MSG_GUILD' and E.db.CA.guild ~= 'None' and not CH.SoundPlayed then
		PlaySoundFile(LSM:Fetch('sound', E.db.CA.guild), 'Master')
		CH.SoundPlayed = true
		CH.SoundTimer = CH:ScheduleTimer('ThrottleSound', E.db.CA.throttle.guild)
	end
end

-- Function which monitors officer channel and plays sound
function CA:MonitorOfficer(event, _, author, ...)
	if author == UnitName('player') then return end -- Don't play sound if the message is from yourself
	if event == 'CHAT_MSG_OFFICER' and E.db.CA.officer ~= 'None' and not CH.SoundPlayed then
		PlaySoundFile(LSM:Fetch('sound', E.db.CA.officer), 'Master')
		CH.SoundPlayed = true
		CH.SoundTimer = CH:ScheduleTimer('ThrottleSound', E.db.CA.throttle.officer)
	end
end

--Table we store our 1-10 channels in: [1] = ChannelName
CA.Channels = {}

local function buildChannelList(...)
	for i = 1, select("#", ...), 2 do
		local id, name = select(i, ...)
		CA.Channels[id] = name
	end
end

--Function which updates the CA.Channels table
function CA:UpdateChannelTable(event, msg, _, _, _, _, _, _, chanID, chanName, ...)
	if msg == "YOU_LEFT" and CA.Channels[chanID] then
		CA.Channels[chanID] = nil
		CA:UpdateChannelsConfig()
	--YOU_JOINED seems to have been replaced by YOU_CHANGED in 6.0
	--Keep YOU_JOINED just in case, and also for backwards compatibility
	elseif msg == "YOU_JOINED" or msg == "YOU_CHANGED" then
		local name = gsub(chanName, " ", "")
		CA.Channels[chanID] = name
		CA:UpdateChannelsConfig()
	end
end

--Do stuff when entering world
function CA:PLAYER_ENTERING_WORLD()
	--Build CA.Channels table
	buildChannelList(GetChannelList())
	
	--Warn about incompatible addon
	if IsAddOnLoaded('ElvUI_CustomChannelWarning') then
		E:StaticPopup_Show('CA_Incompatible')
	end
end

--Function which gets executed when user presses "Update Channels" in config
function CA:UpdateChannelsConfig()
	if not CA.ConfigIsBuild then return; end
	local group = E.Options.args.blazeplugins.args.CA.args.alerts.args
	for i = 1, 10 do
		local channelName = CA.Channels[i]
		if channelName then
			group['channel'..i].name = channelName..L[' Alert']
			group['channel'..i].hidden = false
		else
			group['channel'..i].hidden = true
		end
	end
	LibStub('AceConfigRegistry-3.0-ElvUI'):NotifyChange('ElvUI')
end

-- Stuff to do when addon is initialized
function CA:OnInitialize()
	-- Register callback with LibElvUIPlugin
	EP:RegisterPlugin(addon, CA.InsertOptions)
	
	--ElvUI Chat is not enabled, stop right here!
	if E.private.chat.enable ~= true then return end
	
	-- Register monitoring functions
	self:RegisterEvent('CHAT_MSG_CHANNEL', 'MonitorChannels')
	self:RegisterEvent('CHAT_MSG_GUILD', 'MonitorGuild')
	self:RegisterEvent('CHAT_MSG_OFFICER', 'MonitorOfficer')
	
	-- Update CA.Channels table on channel joined/left
	self:RegisterEvent('CHAT_MSG_CHANNEL_NOTICE', 'UpdateChannelTable')
	
	--Initial setup
	self:RegisterEvent('PLAYER_ENTERING_WORLD')
end