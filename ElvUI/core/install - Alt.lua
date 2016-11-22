local E, L, V, P, G, _ = unpack(select(2, ...)); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB, Localize Underscore

--Cache global variables
--Lua functions
local _G = _G
local unpack = unpack
local format = format
--WoW API / Variables
local CreateFrame = CreateFrame
local IsAddOnLoaded = IsAddOnLoaded
local GetScreenWidth = GetScreenWidth
local SetCVar = SetCVar
local PlaySoundFile = PlaySoundFile
local ReloadUI = ReloadUI
local UIFrameFadeOut = UIFrameFadeOut
local ChatFrame_AddMessageGroup = ChatFrame_AddMessageGroup
local ChatFrame_RemoveAllMessageGroups = ChatFrame_RemoveAllMessageGroups
local ChatFrame_AddChannel = ChatFrame_AddChannel
local ChatFrame_RemoveChannel = ChatFrame_RemoveChannel
local ChangeChatColor = ChangeChatColor
local ToggleChatColorNamesByClassGroup = ToggleChatColorNamesByClassGroup
local FCF_ResetChatWindows = FCF_ResetChatWindows
local FCF_SetLocked = FCF_SetLocked
local FCF_DockFrame, FCF_UnDockFrame = FCF_DockFrame, FCF_UnDockFrame
local FCF_OpenNewWindow = FCF_OpenNewWindow
local FCF_SavePositionAndDimensions = FCF_SavePositionAndDimensions
local FCF_GetChatWindowInfo = FCF_GetChatWindowInfo
local FCF_SetWindowName = FCF_SetWindowName
local FCF_StopDragging = FCF_StopDragging
local FCF_SetChatWindowFontSize = FCF_SetChatWindowFontSize
local CLASS, CONTINUE, PREVIOUS = CLASS, CONTINUE, PREVIOUS
local NUM_CHAT_WINDOWS = NUM_CHAT_WINDOWS
local LOOT, GENERAL, TRADE = LOOT, GENERAL, TRADE
local GUILD_EVENT_LOG = GUILD_EVENT_LOG
local RAID_CLASS_COLORS = RAID_CLASS_COLORS
local CUSTOM_CLASS_COLORS = CUSTOM_CLASS_COLORS

--Global variables that we don't cache, list them here for the mikk's Find Globals script
-- GLOBALS: ElvUIInstallFrame, InstallStepComplete, InstallStatus, InstallNextButton, InstallPrevButton
-- GLOBALS: InstallOption1Button, InstallOption2Button, InstallOption3Button, InstallOption4Button
-- GLOBALS: LeftChatToggleButton, RightChatToggleButton, RightChatDataPanel
-- GLOBALS: ChatFrame1, ChatFrame2, ChatFrame3, InterfaceOptionsActionBarsPanelPickupActionKeyDropDown

local CURRENT_PAGE = 0
local MAX_PAGE = 9

local function SetupChat()
	InstallStepComplete.message = L["Chat Set"]
	InstallStepComplete:Show()
	--FCF_ResetChatWindows() TEMP DISABLE.. ERROR
	FCF_ResetChatWindows()

	FCF_SetLocked(ChatFrame1, 1)
	FCF_DockFrame(ChatFrame2)
	FCF_SetLocked(ChatFrame2, 1)

	FCF_OpenNewWindow("Dialog")
	FCF_DockFrame(ChatFrame3)
	FCF_SetLocked(ChatFrame3, 1)

	FCF_OpenNewWindow("Guild-Group-Raid-Social")
	FCF_UnDockFrame(ChatFrame4)
	FCF_SetLocked(ChatFrame4, 1)
	ChatFrame4:Show()

	for i = 1, NUM_CHAT_WINDOWS do
		local frame = _G[format("ChatFrame%s", i)]
		local chatFrameId = frame:GetID()
		local chatName = FCF_GetChatWindowInfo(chatFrameId)

		-- Relocating chat outputs
		if i == 1 then
			frame:ClearAllPoints()
			frame:Point("BOTTOMLEFT", LeftChatDataPanel, "TOPLEFT", 1, 3)
		-- elseif i == 4 and chatName == "Guild-Group-Raid-Social" then
		elseif i == 4 then
			frame:ClearAllPoints()
			-- frame:Point("BOTTOMLEFT", RightChatDataPanel, "TOPLEFT", 1, 3)
			frame:Point("BOTTOMRIGHT", RightChatDataPanel, "BOTTOMRIGHT", 1, 3)
		end

		FCF_SavePositionAndDimensions(frame)
		FCF_StopDragging(frame)

		-- Setting default DecUI font size
		FCF_SetChatWindowFontSize(nil, frame, 12)

		-- Renaming General
		if i == 1 then
			FCF_SetWindowName(frame, "General-Local")
		end
	end

	-- Setup the General-Local chat frame
	ChatFrame_RemoveAllMessageGroups(ChatFrame1);
	ChatFrame_AddChannel(ChatFrame1, L['Trade'])
	ChatFrame_AddChannel(ChatFrame1, "General")
	ChatFrame_AddChannel(ChatFrame1, "LocalDefense")
	ChatFrame_AddChannel(ChatFrame1, "GuildRecruitment")
	ChatFrame_AddChannel(ChatFrame1, "LookingForGroup")
	ChatFrame_AddMessageGroup(ChatFrame1, "SAY")
	ChatFrame_AddMessageGroup(ChatFrame1, "EMOTE")
	ChatFrame_AddMessageGroup(ChatFrame1, "YELL")
	ChatFrame_AddMessageGroup(ChatFrame1, "ERRORS")
	ChatFrame_AddMessageGroup(ChatFrame1, "COMBAT_XP_GAIN")
	ChatFrame_AddMessageGroup(ChatFrame1, "COMBAT_GUILD_XP_GAIN")
	ChatFrame_AddMessageGroup(ChatFrame1, "COMBAT_HONOR_GAIN")
	ChatFrame_AddMessageGroup(ChatFrame1, "COMBAT_FACTION_CHANGE")
	ChatFrame_AddMessageGroup(ChatFrame1, "COMBAT_MISC_INFO")
	ChatFrame_AddMessageGroup(ChatFrame1, "ARENA_POINTS")
	ChatFrame_AddMessageGroup(ChatFrame1, "TARGETICONS")
	ChatFrame_AddMessageGroup(ChatFrame1, "LOOT")
	ChatFrame_AddMessageGroup(ChatFrame1, "MONEY")
	ChatFrame_AddMessageGroup(ChatFrame1, "SKILL")
	ChatFrame_AddMessageGroup(ChatFrame1, "CURRENCY")
	ChatFrame_AddMessageGroup(ChatFrame1, "OPENING")
	ChatFrame_AddMessageGroup(ChatFrame1, "ACHIEVEMENT")

	-- Setup the Dialog chat frame
	ChatFrame_RemoveAllMessageGroups(ChatFrame3);
	ChatFrame_AddMessageGroup(ChatFrame3, "MONSTER_SAY")
	ChatFrame_AddMessageGroup(ChatFrame3, "MONSTER_EMOTE")
	ChatFrame_AddMessageGroup(ChatFrame3, "MONSTER_YELL")
	ChatFrame_AddMessageGroup(ChatFrame3, "MONSTER_WHISPER")
	ChatFrame_AddMessageGroup(ChatFrame3, "MONSTER_BOSS_EMOTE")
	ChatFrame_AddMessageGroup(ChatFrame3, "MONSTER_BOSS_WHISPER")
	ChatFrame_AddMessageGroup(ChatFrame3, "RAID_BOSS_EMOTE")
	ChatFrame_AddMessageGroup(ChatFrame3, "RAID_BOSS_WHISPER")

	-- Setup the Guild-Group-Social chat frame
	ChatFrame_RemoveAllMessageGroups(ChatFrame4);
	ChatFrame_AddMessageGroup(ChatFrame4, "GUILD")
	ChatFrame_AddMessageGroup(ChatFrame4, "GUILD_ACHIEVEMENT")
	ChatFrame_AddMessageGroup(ChatFrame4, "GUILD_ANNOUNCEMENT")
	ChatFrame_AddMessageGroup(ChatFrame4, "PARTY")
	ChatFrame_AddMessageGroup(ChatFrame4, "PARTY_LEADER")
	ChatFrame_AddMessageGroup(ChatFrame4, "RAID")
	ChatFrame_AddMessageGroup(ChatFrame4, "RAID_LEADER")
	ChatFrame_AddMessageGroup(ChatFrame4, "RAID_WARNING")
	ChatFrame_AddMessageGroup(ChatFrame4, "BATTLEGROUND")
	ChatFrame_AddMessageGroup(ChatFrame4, "BATTLEGROUND_LEADER")
	ChatFrame_AddMessageGroup(ChatFrame4, "INSTANCE_CHAT")
	ChatFrame_AddMessageGroup(ChatFrame4, "INSTANCE_CHAT_LEADER")
	ChatFrame_AddMessageGroup(ChatFrame4, "BG_HORDE")
	ChatFrame_AddMessageGroup(ChatFrame4, "BG_ALLIANCE")
	ChatFrame_AddMessageGroup(ChatFrame4, "BG_NEUTRAL")
	ChatFrame_AddMessageGroup(ChatFrame4, "WHISPER")
	ChatFrame_AddMessageGroup(ChatFrame4, "BN_WHISPER")
	ChatFrame_AddMessageGroup(ChatFrame4, "BN_CONVERSATION")
	ChatFrame_AddMessageGroup(ChatFrame4, "BN_INLINE_TOAST_ALERT")
	ChatFrame_AddMessageGroup(ChatFrame4, "BN_WHISPER_PLAYER_OFFLINE")
	ChatFrame_AddMessageGroup(ChatFrame4, "BN_WHISPER_INFORM")
	ChatFrame_AddMessageGroup(ChatFrame4, "OFFICER")
	ChatFrame_AddMessageGroup(ChatFrame4, "AFK")
	ChatFrame_AddMessageGroup(ChatFrame4, "DND")
	ChatFrame_AddMessageGroup(ChatFrame4, "IGNORED")
	ChatFrame_AddMessageGroup(ChatFrame4, "CHANNEL_JOIN")
	ChatFrame_AddMessageGroup(ChatFrame4, "CHANNEL_LEAVE")
	ChatFrame_AddMessageGroup(ChatFrame4, "SYSTEM")

	-- Enable ClassColor automatically on login and on each character without doing /configure every time
	ToggleChatColorNamesByClassGroup(true, "SAY")
	ToggleChatColorNamesByClassGroup(true, "EMOTE")
	ToggleChatColorNamesByClassGroup(true, "YELL")
	ToggleChatColorNamesByClassGroup(true, "GUILD")
	ToggleChatColorNamesByClassGroup(true, "OFFICER")
	ToggleChatColorNamesByClassGroup(true, "GUILD_ACHIEVEMENT")
	ToggleChatColorNamesByClassGroup(true, "ACHIEVEMENT")
	ToggleChatColorNamesByClassGroup(true, "WHISPER")
	ToggleChatColorNamesByClassGroup(true, "PARTY")
	ToggleChatColorNamesByClassGroup(true, "PARTY_LEADER")
	ToggleChatColorNamesByClassGroup(true, "RAID")
	ToggleChatColorNamesByClassGroup(true, "RAID_LEADER")
	ToggleChatColorNamesByClassGroup(true, "RAID_WARNING")
	ToggleChatColorNamesByClassGroup(true, "BATTLEGROUND")
	ToggleChatColorNamesByClassGroup(true, "BATTLEGROUND_LEADER")
	ToggleChatColorNamesByClassGroup(true, "INSTANCE_CHAT")
	ToggleChatColorNamesByClassGroup(true, "INSTANCE_CHAT_LEADER")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL1")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL2")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL3")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL4")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL5")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL6")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL7")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL8")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL9")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL10")
	ToggleChatColorNamesByClassGroup(true, "CHANNEL11")

	--Adjust Chat Colors
	--General
	ChangeChatColor("CHANNEL1", 181/255, 213/255, 215/255)
	--Trade
	ChangeChatColor("CHANNEL2", 204/255, 199/255, 251/255)
	--Local Defense
	ChangeChatColor("CHANNEL3", 232/255, 228/255, 121/255)
	--LFG
	ChangeChatColor("CHANNEL4", 195/255, 230/255, 232/255)
	--Custom
	ChangeChatColor("CHANNEL5", 215/255, 222/255, 225/255)
	--Custom
	ChangeChatColor("CHANNEL6", 204/255, 80/255, 255/255)
	--Custom
	ChangeChatColor("CHANNEL7", 195/255, 230/255, 232/255)
	--Custom
	ChangeChatColor("CHANNEL8", 255/255, 192/255, 192/255)
	--Custom
	ChangeChatColor("CHANNEL9", 255/255, 192/255, 192/255)
	--Custom
	ChangeChatColor("CHANNEL10", 255/255, 192/255, 192/255)

	if E.Chat then
		E.Chat:PositionChat(true)
		if E.db['RightChatPanelFaded'] then
			RightChatToggleButton:Click()
		end

		if E.db['LeftChatPanelFaded'] then
			LeftChatToggleButton:Click()
		end
	end
end

local function SetupCVars()
	SetCVar("ShowClassColorInNameplate", 1)
	SetCVar("screenshotQuality", 10)
	SetCVar("screenshotFormat", "png")
	SetCVar("chatMouseScroll", 1)
	SetCVar("chatStyle", "classic")
	SetCVar("WholeChatWindowClickable", 0)
	SetCVar("showTutorials", 0)
	SetCVar("UberTooltips", 1)
	SetCVar("threatWarning", 3)
	SetCVar('alwaysShowActionBars', 1)
	SetCVar('lockActionBars', 1)
	SetCVar("buffDurations", 1)
	SetCVar("scriptErrors", 1)
	SetCVar("autoDismountFlying", 0)
	SetCVar("autoQuestWatch", 1)
	SetCVar("autoQuestProgress", 1)
	SetCVar("removeChatDelay", 1)
	SetCVar("showVKeyCastbar", 1)
	SetCVar("showArenaEnemyFrames", 0)
	SetCVar("cameraSmoothStyle", 0)
	SetCVar("cameraTerrainTilt", 0)
	SetCVar("cameraWaterCollision", 0)
	SetCVar("MaxSpellStartRecoveryoffset", 0)
	SetCVar("reducedLagTolerance", 1)
	SetCVar("nameplateShowFriends", 0)
	SetCVar("nameplateShowFriendlyPets", 0)
	SetCVar("nameplateShowFriendlyGuardians", 0)
	SetCVar("nameplateShowFriendlyTotems", 0)
	SetCVar("nameplateShowEnemies", 1)
	SetCVar("nameplateShowEnemyPets", 1)
	SetCVar("nameplateShowEnemyGuardians", 1)
	SetCVar("nameplateShowEnemyTotems", 1)
	SetCVar("lootUnderMouse", 0)
	SetCVar("autoSelfCast", 1)
	SetCVar("AutoLootDefault", 1)
	SetCVar("chatBubblesParty", 1)
	SetCVar("chatBubbles", 1)
	SetCVar("UnitNameOwn", 0)
	SetCVar("UnitNameNPC", 0)
	SetCVar("UnitNameNonCombatCreatureName", 0)
	SetCVar("UnitNamePlayerGuild", 0)
	SetCVar("UnitNamePlayerPVPTitle", 0)
	SetCVar("UnitNameFriendlyPlayerName", 0)
	SetCVar("UnitNameFriendlyPetName", 0)
	SetCVar("UnitNameFriendlyGuardianName", 0)
	SetCVar("UnitNameFriendlyTotemName", 0)
	SetCVar("UnitNameEnemyPlayerName", 0)
	SetCVar("UnitNameEnemyPetName", 0)
	SetCVar("UnitNameEnemyGuardianName", 0)
	SetCVar("UnitNameEnemyTotemName", 0)
	SetCVar("streamStatusMessage", 1)
	SetCVar("lockedWorldMap", 0)
	SetCVar("assistAttack", 1)
	SetCVar("cameraBobbing", 1)
	-- SetCVar("cameraDistanceMax", 60) --FAIL
	SetCVar("cameraSavedDistance", 50.000000) --Wonder how long this will last...
	SetCVar("cameraDistanceMaxFactor", 60)
	SetCVar("cameraDistanceMoveSpeed", 50)
	SetCVar("cameraDistanceSmoothSpeed", 50)
	SetCVar("disableServerNagle", 1)
-- Maximum GFX Quality Accessible
	SetCVar("processAffinityMask", 255)
	SetCVar("maxFPS", 120)
	SetCVar("maxFPSBk", 120)
	SetCVar("gxApi", "D3D11")
	SetCVar("gxRefresh", 120)
	SetCVar("gxVSync", 1)
	SetCVar("gxWindow", 1)
	SetCVar("gxMaximize", 1)
	-- SetCVar("gxTripleBuffer", 1)
	SetCVar("gxFixLag", 1)
	-- SetCVar("gxTextureCacheSize", 5120)
	-- SetCVar("shadowTextureSize", 5120)
	SetCVar("emphasizeMySpellEffects", 1)
	SetCVar("showfootprintparticles", 1)
	SetCVar("ffxGlow", 1)
	-- SetCVar("reflectionMode", 3.000000)
	-- SetCVar("rippleDetail", 2.000000)
	-- SetCVar("shadowMode", 4)
	-- SetCVar("SkyCloudLOD", 3)
	-- SetCVar("ssao", 3)
	-- SetCVar("ssaoBlur", 2)
	-- SetCVar("sunshafts", 2.000000)
	-- SetCVar("terrainMipLevel", 1)
	-- SetCVar("timingMethod", 2)
	-- SetCVar("waterDetail", 3.000000)
	-- SetCVar("weatherDensity", 3)
	-- SetCVar("hwDetect", 0)
	-- SetCVar("videoOptionsVersion", 11)
	-- SetCVar("farclip", 1500.000000)
	-- SetCVar("refraction", 2.000000)
	-- SetCVar("projectedTextures", 1)
	-- SetCVar("environmentDetail", 150.000000)
	-- SetCVar("groundEffectFade", 1277)
	-- SetCVar("groundEffectDist", 500.000000)
	-- SetCVar("groundEffectDensity", 256.000000)
	-- SetCVar("particleDensity", 100.000000)
	-- SetCVar("textureFilteringMode", 5)
	-- SetCVar("graphicsQuality", 10)
	-- SetCVar("terrainLodDist", 650)
	-- SetCVar("shadowinstancing", 1)
	-- SetCVar("colorChatNamesByClass", 1)
	-- SetCVar("objectselectioncircle", 1)
	-- SetCVar("wmoLodDist", 550)
	-- SetCVar("componentTextureLevel", 0)
	-- SetCVar("ResampleQuality", 1)
	-- SetCVar("MSAAQuality", 3,0)
	-- SetCVar("graphicsViewDistance", 1)
	-- SetCVar("ffxAntiAliasingMode", 3)
	-- SetCVar("physicsLevel", 2)
	-- SetCVar("horizonStart", 300.000000)
	-- SetCVar("particleMTDensity", 100.000000)
	-- SetCVar("shadowSoft", 1.000000)
	-- SetCVar("DepthBasedOpacity", 1.000000)
	-- SetCVar("terrainTextureLod", 1.000000)
	-- SetCVar("worldBaseMip", 1)
	-- SetCVar("OutlineEngineMode", 2.000000)
	-- SetCVar("lightMode", 2.000000)
	-- SetCVar("lodObjectCullSize", 10.000000)
	-- SetCVar("lodObjectCullDist", 35.000000)
	-- SetCVar("lodObjectMinSize", 30.000000)
	-- SetCVar("graphicsTextureResolution", 3)
	-- SetCVar("graphicsTextureFiltering", 6)
	-- SetCVar("graphicsEnvironmentDetail", 10)
	-- SetCVar("graphicsGroundClutter", 10)
	-- SetCVar("graphicsShadowQuality", 6)
	-- SetCVar("graphicsParticleDensity", 4)
-- Maximum GFX Quality Accessible Raid-Specific
	-- SetCVar RAIDsettingsEnabled "1"
	-- SetCVar RAIDgraphicsQuality "10"
	-- SetCVar raidGraphicsTextureFiltering "6"
	-- SetCVar raidGraphicsProjectedTextures "2"
	-- SetCVar raidGraphicsViewDistance "10"
	-- SetCVar raidGraphicsEnvironmentDetail "10"
	-- SetCVar raidGraphicsGroundClutter "10"
	-- SetCVar raidGraphicsShadowQuality "6"
	-- SetCVar raidGraphicsLiquidDetail "4"
	-- SetCVar raidGraphicsSunshafts "3"
	-- SetCVar raidGraphicsParticleDensity "4"
	-- SetCVar raidGraphicsSSAO "4"
	-- SetCVar raidGraphicsDepthEffects "4"
	-- SetCVar raidGraphicsLightingQuality "3"
	-- SetCVar raidGraphicsOutlineMode "3"
	-- SetCVar RAIDfarclip "10000.000000"
	-- SetCVar RAIDWaterDetail "3.000000"
	-- SetCVar RAIDSSAO "3.000000"
	-- SetCVar RAIDDepthBasedOpacity "1.000000"
	-- SetCVar RAIDgroundEffectDensity "256.000000"
	-- SetCVar RAIDgroundEffectDist "320.000000"
	-- SetCVar RAIDshadowMode "4.000000"
	-- SetCVar RAIDterrainLodDist "850.000000"
	-- SetCVar RAIDterrainTextureLod "0.000000"
	-- SetCVar RAIDwmoLodDist "550.000000"
	-- SetCVar RAIDterrainMipLevel "0.000000"
	-- SetCVar RAIDworldBaseMip "0.000000"
	-- SetCVar RAIDtextureFilteringMode "5.000000"
	-- SetCVar RAIDprojectedTextures "1.000000"
	-- SetCVar RAIDenvironmentDetail "150.000000"
	-- SetCVar RAIDshadowTextureSize "2048.000000"
	-- SetCVar RAIDshadowSoft "1.000000"
	-- SetCVar RAIDreflectionMode "3.000000"
	-- SetCVar RAIDrippleDetail "2.000000"
	-- SetCVar RAIDsunShafts "2.000000"
	-- SetCVar RAIDparticleDensity "100.000000"
	-- SetCVar RAIDparticleMTDensity "100.000000"
	-- SetCVar RAIDrefraction "2.000000"
	-- SetCVar RAIDOutlineEngineMode "2.000000"
	-- SetCVar RAIDLightMode "2.000000"
	-- SetCVar RAIDlodObjectCullSize "10.000000"
	-- SetCVar RAIDlodObjectCullDist "35.000000"
	-- SetCVar RAIDlodObjectMinSize "30.000000"
	-- SetCVar RAIDcomponentTextureLevel "0.000000"
	-- SetCVar RAIDweatherDensity "3.000000"
-- Sound
	SetCVar("Sound_NumChannels", 64)
	SetCVar("Sound_EnableReverb", 1)
	SetCVar("Sound_EnableErrorSpeech", 0)
	SetCVar("Sound_ZoneMusicNoDelay", 1)
	SetCVar("Sound_EnableSoundWhenGameIsInBG", 1)
	SetCVar("FootstepSounds", 1)
-- Miscellaneous Tweaks
	SetCVar("autoUnshift", 1)
	SetCVar("violenceLevel", 5)
	SetCVar('SpamFilter', 0)
	SetCVar("nameplateShowSelf", 0)
	SetCVar('taintLog', 0)
	SetCVar("statusTextDisplay", "BOTH")
	ShowAccountAchievements(1)
-- Backup values
	-- SetCVar("farclip", 1300)
	-- SetCVar("shadowTextureSize", 2048)
-- The following are no longer accessible, or have been changed in the client :(
	-- SetCVar("ConversationMode", "inline")
	-- SetCVar("bloatthreat", 0)
	-- SetCVar("bloattest", 0)
	-- SetCVar("CombatDamage", 1)
	-- SetCVar("CombatHealing", 1)
	-- SetCVar("consolidateBuffs", 0)
	-- SetCVar("CombatHealing", 0)
	-- SetCVar("CombatDamage", 0)
	-- SetCVar("enableCombatText", 0)
	-- SetCVar("fctSpellMechanics", 0)
	-- SetCVar("gxDepthBits", 32)
	-- SetCVar("gxColorBits", 32)
	-- SetCVar("alternateResourceText", 1)
	-- SetCVar("showGameTips", 1)
	-- SetCVar("horizonFarClipScale", 6)
	-- SetCVar("overridefarclip", 1)
	-- SetCVar("horizonfarclip", 6226)
	-- SetCVar("detailDoodadAlpha", 100)
	-- SetCVar("smallcull", 0)
	-- SetCVar("SpellEffectLevel", 100)
	-- SetCVar("characterAmbient", 0)
	-- SetCVar("raidFramesDisplayIncomingHeals", 1)
	-- SetCVar("gxmultisample", 1)
	-- SetCVar("mapQuestDifficulty", 1)
	-- SetCVar("extShadowQuality", 5)
	-- SetCVar("maxLOD", 3)
	-- SetCVar("M2Faster", 3)
	-- SetCVar("UIFaster", 3)
	InterfaceOptionsActionBarsPanelPickupActionKeyDropDown:SetValue('SHIFT')
	InterfaceOptionsActionBarsPanelPickupActionKeyDropDown:RefreshValue()
	InstallStepComplete.message = L["CVars Set"]
	InstallStepComplete:Show()
end

function E:GetColor(r, b, g, a)
	return { r = r, b = b, g = g, a = a }
end

function E:SetupPixelPerfect(enabled, noMsg)
	E.private.general.pixelPerfect = enabled;

	if (E.PixelMode ~= enabled) then
		E:StaticPopup_Show('PIXELPERFECT_CHANGED')
	end

	if not noMsg then
		if not E.db.movers then E.db.movers = {}; end
		E.db.unitframe.fontSize = 12;
		E.db.actionbar.bar1.backdrop = false;
		E.db.actionbar.bar2.backdrop = false;
		E.db.actionbar.bar3.backdrop = false;
		E.db.actionbar.bar4.backdrop = false;
		E.db.actionbar.bar5.backdrop = false;
		E.db.actionbar.barPet.backdrop = false;
		E.db.actionbar.stanceBar.backdrop = false;
		E.db.actionbar.bar1.buttonspacing = 2;
		E.db.actionbar.bar2.buttonspacing = 2;
		E.db.actionbar.bar3.buttonspacing = 2;
		E.db.actionbar.bar4.buttonspacing = 2;
		E.db.actionbar.bar5.buttonspacing = 2;
		E.db.actionbar.barPet.buttonspacing = 2;
		E.db.actionbar.stanceBar.buttonspacing = 2;
		E.db.datatexts.ActionBarPanels.ActionBarPanelOne.Enabled = true;
		E.db.datatexts.ActionBarPanels.ActionBarPanelTwo.Enabled = true;
		E.db.datatexts.ActionBarPanels.ActionBarPanelThree.Enabled = true;
		E.db.general.topPanel = false
		E.db.general.bottomPanel = false
		-- E.db.unitframe.units.target.combobar.DetachFromFrame = true;
		E:GetModule('Layout'):BottomPanelVisibility()
	end

	if noMsg then
		if enabled then
			if not E.db.movers then E.db.movers = {}; end
			E.db.unitframe.fontSize = 12;
			E.db.actionbar.bar1.backdrop = false
			E.db.actionbar.bar2.backdrop = true;
			E.db.actionbar.bar3.backdrop = true;
			E.db.actionbar.bar4.backdrop = true;
			E.db.actionbar.bar5.backdrop = true;
			E.db.actionbar.barPet.backdrop = true;
			E.db.actionbar.stanceBar.backdrop = true;
			E.db.actionbar.bar1.buttonspacing = 2;
			E.db.actionbar.bar2.buttonspacing = 2;
			E.db.actionbar.bar3.buttonspacing = 2;
			E.db.actionbar.bar4.buttonspacing = 2;
			E.db.actionbar.bar5.buttonspacing = 2;
			E.db.actionbar.barPet.buttonspacing = 2;
			E.db.actionbar.stanceBar.buttonspacing = 2;
			E.db.databars.reputation.width = 205
			E.db.databars.experience.width = 205
			E.db.movers.ReputationBarMover = "TOPMMHolderBOTTOM21"
			E.db.movers.ExperienceBarMover = "TOPMMHolderBOTTOM2-12"
			E.db.datatexts.ActionBarPanels.ActionBarPanelOne.Enabled = true;
			E.db.datatexts.ActionBarPanels.ActionBarPanelTwo.Enabled = true;
			E.db.datatexts.ActionBarPanels.ActionBarPanelThree.Enabled = true;
			E.db.general.topPanel = false
			E.db.general.bottomPanel = false
			E.db.unitframe.units.player.classbar.DetachFromFrame = true;
			E:GetModule('Layout'):BottomPanelVisibility()
		else
			E.db.unitframe.fontSize = 12;
			E.db.actionbar.bar1.backdrop = false
			E.db.actionbar.bar2.backdrop = true;
			E.db.actionbar.bar3.backdrop = true;
			E.db.actionbar.bar4.backdrop = true;
			E.db.actionbar.bar5.backdrop = true;
			E.db.actionbar.barPet.backdrop = true;
			E.db.actionbar.stanceBar.backdrop = true;
			E.db.actionbar.bar1.buttonspacing = 2;
			E.db.actionbar.bar2.buttonspacing = 2;
			E.db.actionbar.bar3.buttonspacing = 2;
			E.db.actionbar.bar4.buttonspacing = 2;
			E.db.actionbar.bar5.buttonspacing = 2;
			E.db.actionbar.barPet.buttonspacing = 2;
			E.db.actionbar.stanceBar.buttonspacing = 2;
			E.db.datatexts.ActionBarPanels.ActionBarPanelOne.Enabled = true;
			E.db.datatexts.ActionBarPanels.ActionBarPanelTwo.Enabled = true;
			E.db.datatexts.ActionBarPanels.ActionBarPanelThree.Enabled = true;
		end
	end

	if InstallStepComplete and not noMsg then
		InstallStepComplete.message = L["Pixel Perfect Set"]
		InstallStepComplete:Show()
		E:UpdateAll(true)
	end

	E.PixelMode = enabled
end

function E:SetupTheme(theme, noDisplayMsg)
	local classColor = E.myclass == 'PRIEST' and E.PriestColors or (CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[E.myclass] or RAID_CLASS_COLORS[E.myclass])

	E.private.theme = theme

	--Set colors, styling
	if theme == "classic" then
		E.db.unitframe.fontSize = 12;
		E.db.general.bordercolor = E:GetColor(.31, .31, .31)
		E.db.general.backdropcolor = E:GetColor(.1, .1, .1)
		E.db.general.backdropfadecolor = E:GetColor(.06, .06, .06, .8)
		E.db.unitframe.colors.healthclass = false
		E.db.unitframe.colors.health = E:GetColor(.31, .31, .31)
		E.db.unitframe.colors.auraBarBuff = E:GetColor(.31, .31, .31)
		E.db.unitframe.colors.castColor = E:GetColor(.31, .31, .31)
		E.db.unitframe.colors.castClassColor = false
		E.db.unitframe.units.player.power.offset = 6;
		E.db.unitframe.units.target.power.offset = 6;
		E.db.unitframe.units.targettarget.power.offset = 5;
		E.db.unitframe.units.targettargettarget.power.offset = 5;
		E.db.unitframe.units.pettarget.power.offset = 5;
		E.db.unitframe.units.pet.power.offset = 5;
		E.db.unitframe.units.focustarget.power.offset = 5;
		E.db.unitframe.units.focus.power.offset = 6;
		E.db.unitframe.units.party.power.offset = 6;
		E.db.unitframe.units.raid.power.offset = 6;
		E.db.unitframe.units.raid.power.offset = 6;
		E.db.unitframe.units.boss.power.offset = 6;
		E.db.unitframe.units.arena.power.offset = 6;
		E.db.databars.experience.mouseover = false;
		E.db.databars.reputation.mouseover = false;
		E.db.databars.artifact.mouseover = false;
		E.db.databars.honor.mouseover = false;
		E.db.actionbar.showGrid = true;
		E.db.datatexts.ActionBarPanels.ActionBarPanelOne.Template = "DEFAULT"
		E.db.datatexts.ActionBarPanels.ActionBarPanelTwo.Template = "DEFAULT"
		E.db.datatexts.ActionBarPanels.ActionBarPanelThree.Template = "DEFAULT"
		E.db.datatexts.ActionBarPanels.ActionBarPanelFour.Template = "DEFAULT"
		E.db.datatexts.ActionBarPanels.TopPanel.Enabled = true;
		E.db.datatexts.ActionBarPanels.BottomPanel.Enabled = true;
		E.db.datatexts.Backgrounds.LeftBG.Template = "DEFAULT";
		E.db.datatexts.Backgrounds.RightBG.Template = "DEFAULT";
		E.db.datatexts.Backgrounds.BottomBG.Template = "DEFAULT";
		--E.db.locplus.trans = false;
		E.db.datatexts.panelTransparency = false;
		E.db.chat.panelTabTransparency = false;
		E.db.chat.fontOutline = "NONE"
		E.db.unitframe.colors.transparentHealth = false;
		E.db.unitframe.colors.transparentPower = false;
		E.db.unitframe.colors.transparentAurabars = false;
		E.db.unitframe.colors.transparentCastbar = false;
		E.db.unitframe.units.player.infoPanel.transparent = false;
		E.db.unitframe.units.pet.infoPanel.transparent = false;
		E.db.unitframe.units.pettarget.infoPanel.transparent = false;
		E.db.unitframe.units.target.infoPanel.transparent = false;
		E.db.unitframe.units.targettarget.infoPanel.transparent = false;
		E.db.unitframe.units.targettargettarget.infoPanel.transparent = false;
		E.db.unitframe.units.focus.infoPanel.transparent = false;
		E.db.unitframe.units.focustarget.infoPanel.transparent = false;
		E.db.unitframe.units.arena.infoPanel.transparent = false;
		E.db.unitframe.units.boss.infoPanel.transparent = false;
		E.db.unitframe.units.raid.infoPanel.transparent = false;
		E.db.unitframe.units.raid40.infoPanel.transparent = false;
		--E.db.unitframe.units.raidpet.infoPanel.transparent = false;
	elseif theme == "classiconebarcoolline" then
		E.db.unitframe.fontSize = 12;
		E.db.general.bordercolor = E:GetColor(.31, .31, .31)
		E.db.general.backdropcolor = E:GetColor(.1, .1, .1)
		E.db.general.backdropfadecolor = E:GetColor(.06, .06, .06, .8)
		E.db.unitframe.colors.healthclass = false
		E.db.unitframe.colors.health = E:GetColor(.31, .31, .31)
		E.db.unitframe.colors.auraBarBuff = E:GetColor(.31, .31, .31)
		E.db.unitframe.colors.castColor = E:GetColor(.31, .31, .31)
		E.db.unitframe.colors.castClassColor = false
		E.db.unitframe.units.player.power.offset = 6;
		E.db.unitframe.units.target.power.offset = 6;
		E.db.unitframe.units.targettarget.power.offset = 5;
		E.db.unitframe.units.targettargettarget.power.offset = 5;
		E.db.unitframe.units.pettarget.power.offset = 5;
		E.db.unitframe.units.pet.power.offset = 5;
		E.db.unitframe.units.focustarget.power.offset = 5;
		E.db.unitframe.units.focus.power.offset = 6;
		E.db.unitframe.units.party.power.offset = 6;
		E.db.unitframe.units.raid.power.offset = 6;
		E.db.unitframe.units.raid.power.offset = 6;
		E.db.unitframe.units.boss.power.offset = 6;
		E.db.unitframe.units.arena.power.offset = 6;
		E.db.databars.experience.mouseover = false;
		E.db.databars.reputation.mouseover = false;
		E.db.databars.artifact.mouseover = false;
		E.db.databars.honor.mouseover = false;
		E.db.actionbar.showGrid = true;
		E.db.datatexts.ActionBarPanels.ActionBarPanelOne.Template = "DEFAULT"
		E.db.datatexts.ActionBarPanels.ActionBarPanelTwo.Template = "DEFAULT"
		E.db.datatexts.ActionBarPanels.ActionBarPanelThree.Template = "DEFAULT"
		E.db.datatexts.ActionBarPanels.ActionBarPanelFour.Template = "DEFAULT"
		E.db.datatexts.ActionBarPanels.TopPanel.Enabled = true;
		E.db.datatexts.ActionBarPanels.BottomPanel.Enabled = true;
		E.db.datatexts.Backgrounds.LeftBG.Template = "DEFAULT";
		E.db.datatexts.Backgrounds.RightBG.Template = "DEFAULT";
		E.db.datatexts.Backgrounds.BottomBG.Template = "DEFAULT";
		--E.db.locplus.trans = false;
		E.db.datatexts.panelTransparency = false;
		E.db.chat.panelTabTransparency = false;
		E.db.chat.fontOutline = "NONE"
		E.db.unitframe.colors.transparentHealth = false;
		E.db.unitframe.colors.transparentPower = false;
		E.db.unitframe.colors.transparentAurabars = false;
		E.db.unitframe.colors.transparentCastbar = false;
		E.db.unitframe.units.player.infoPanel.transparent = false;
		E.db.unitframe.units.pet.infoPanel.transparent = false;
		E.db.unitframe.units.pettarget.infoPanel.transparent = false;
		E.db.unitframe.units.target.infoPanel.transparent = false;
		E.db.unitframe.units.targettarget.infoPanel.transparent = false;
		E.db.unitframe.units.targettargettarget.infoPanel.transparent = false;
		E.db.unitframe.units.focus.infoPanel.transparent = false;
		E.db.unitframe.units.focustarget.infoPanel.transparent = false;
		E.db.unitframe.units.arena.infoPanel.transparent = false;
		E.db.unitframe.units.boss.infoPanel.transparent = false;
		E.db.unitframe.units.raid.infoPanel.transparent = false;
		E.db.unitframe.units.raid40.infoPanel.transparent = false;
		--E.db.unitframe.units.raidpet.infoPanel.transparent = false;
	elseif theme == "class" then
		E.db.unitframe.fontSize = 12;
		E.db.general.bottomPanel = false;
		E.db.general.bordercolor = E:GetColor(classColor.r, classColor.b, classColor.g)
		E.db.general.backdropcolor = E:GetColor(.1, .1, .1)
		E.db.general.backdropfadecolor = E:GetColor(.06, .06, .06, .8)
		E.db.unitframe.colors.auraBarBuff = E:GetColor(classColor.r, classColor.b, classColor.g)
		E.db.unitframe.colors.healthclass = true
		E.db.unitframe.colors.castClassColor = true
		E.db.unitframe.units.player.power.offset = 0;
		E.db.unitframe.units.target.power.offset = 0;
		E.db.unitframe.units.targettarget.power.offset = 0;
		E.db.unitframe.units.targettargettarget.power.offset = 0;
		E.db.unitframe.units.pettarget.power.offset = 0;
		E.db.unitframe.units.pet.power.offset = 0;
		E.db.unitframe.units.focustarget.power.offset = 0;
		E.db.unitframe.units.focus.power.offset = 0;
		E.db.unitframe.units.party.power.offset = 0;
		E.db.unitframe.units.raid.power.offset = 0;
		E.db.unitframe.units.raid.power.offset = 0;
		E.db.unitframe.units.boss.power.offset = 0;
		E.db.unitframe.units.arena.power.offset = 0;
		E.db.databars.experience.mouseover = false;
		E.db.databars.reputation.mouseover = false;
		E.db.databars.artifact.mouseover = false;
		E.db.databars.honor.mouseover = false;
		E.db.actionbar.showGrid = true;
		E.db.datatexts.ActionBarPanels.ActionBarPanelOne.Template = "DEFAULT"
		E.db.datatexts.ActionBarPanels.ActionBarPanelTwo.Template = "DEFAULT"
		E.db.datatexts.ActionBarPanels.ActionBarPanelThree.Template = "DEFAULT"
		E.db.datatexts.ActionBarPanels.ActionBarPanelFour.Template = "DEFAULT"
		E.db.datatexts.ActionBarPanels.TopPanel.Enabled = true;
		E.db.datatexts.ActionBarPanels.BottomPanel.Enabled = true;
		E.db.datatexts.Backgrounds.LeftBG.Template = "CColor";
		E.db.datatexts.Backgrounds.RightBG.Template = "CColor";
		E.db.datatexts.Backgrounds.BottomBG.Template = "CColor";
		--E.db.locplus.trans = false;
		E.db.datatexts.panelTransparency = false;
		E.db.chat.panelTabTransparency = false;
		E.db.chat.fontOutline = "NONE"
		E.db.unitframe.colors.transparentHealth = false;
		E.db.unitframe.colors.transparentPower = false;
		E.db.unitframe.colors.transparentAurabars = false;
		E.db.unitframe.colors.transparentCastbar = false;
		E.db.unitframe.units.player.infoPanel.transparent = false;
		E.db.unitframe.units.pet.infoPanel.transparent = false;
		E.db.unitframe.units.pettarget.infoPanel.transparent = false;
		E.db.unitframe.units.target.infoPanel.transparent = false;
		E.db.unitframe.units.targettarget.infoPanel.transparent = false;
		E.db.unitframe.units.targettargettarget.infoPanel.transparent = false;
		E.db.unitframe.units.focus.infoPanel.transparent = false;
		E.db.unitframe.units.focustarget.infoPanel.transparent = false;
		E.db.unitframe.units.arena.infoPanel.transparent = false;
		E.db.unitframe.units.boss.infoPanel.transparent = false;
		E.db.unitframe.units.raid.infoPanel.transparent = false;
		E.db.unitframe.units.raid40.infoPanel.transparent = false;
		--E.db.unitframe.units.raidpet.infoPanel.transparent = false;
	elseif theme == "classonebarcoolline" then
		E.db.unitframe.fontSize = 12;
		E.db.general.bottomPanel = false;
		E.db.general.bordercolor = E:GetColor(classColor.r, classColor.b, classColor.g)
		E.db.general.backdropcolor = E:GetColor(.1, .1, .1)
		E.db.general.backdropfadecolor = E:GetColor(.06, .06, .06, .8)
		E.db.unitframe.colors.auraBarBuff = E:GetColor(classColor.r, classColor.b, classColor.g)
		E.db.unitframe.colors.healthclass = true
		E.db.unitframe.colors.castClassColor = true
		E.db.unitframe.units.player.power.offset = 0;
		E.db.unitframe.units.target.power.offset = 0;
		E.db.unitframe.units.targettarget.power.offset = 0;
		E.db.unitframe.units.targettargettarget.power.offset = 0;
		E.db.unitframe.units.pettarget.power.offset = 0;
		E.db.unitframe.units.pet.power.offset = 0;
		E.db.unitframe.units.focustarget.power.offset = 0;
		E.db.unitframe.units.focus.power.offset = 0;
		E.db.unitframe.units.party.power.offset = 0;
		E.db.unitframe.units.raid.power.offset = 0;
		E.db.unitframe.units.raid.power.offset = 0;
		E.db.unitframe.units.boss.power.offset = 0;
		E.db.unitframe.units.arena.power.offset = 0;
		E.db.databars.experience.mouseover = false;
		E.db.databars.reputation.mouseover = false;
		E.db.databars.artifact.mouseover = false;
		E.db.databars.honor.mouseover = false;
		E.db.actionbar.showGrid = true;
		E.db.datatexts.ActionBarPanels.ActionBarPanelOne.Template = "DEFAULT"
		E.db.datatexts.ActionBarPanels.ActionBarPanelTwo.Template = "DEFAULT"
		E.db.datatexts.ActionBarPanels.ActionBarPanelThree.Template = "DEFAULT"
		E.db.datatexts.ActionBarPanels.ActionBarPanelFour.Template = "DEFAULT"
		E.db.datatexts.ActionBarPanels.TopPanel.Enabled = true;
		E.db.datatexts.ActionBarPanels.BottomPanel.Enabled = true;
		E.db.datatexts.Backgrounds.LeftBG.Template = "CColor";
		E.db.datatexts.Backgrounds.RightBG.Template = "CColor";
		E.db.datatexts.Backgrounds.BottomBG.Template = "CColor";
		--E.db.locplus.trans = false;
		E.db.datatexts.panelTransparency = false;
		E.db.chat.panelTabTransparency = false;
		E.db.chat.fontOutline = "NONE"
		E.db.unitframe.colors.transparentHealth = false;
		E.db.unitframe.colors.transparentPower = false;
		E.db.unitframe.colors.transparentAurabars = false;
		E.db.unitframe.colors.transparentCastbar = false;
		E.db.unitframe.units.player.infoPanel.transparent = false;
		E.db.unitframe.units.pet.infoPanel.transparent = false;
		E.db.unitframe.units.pettarget.infoPanel.transparent = false;
		E.db.unitframe.units.target.infoPanel.transparent = false;
		E.db.unitframe.units.targettarget.infoPanel.transparent = false;
		E.db.unitframe.units.targettargettarget.infoPanel.transparent = false;
		E.db.unitframe.units.focus.infoPanel.transparent = false;
		E.db.unitframe.units.focustarget.infoPanel.transparent = false;
		E.db.unitframe.units.arena.infoPanel.transparent = false;
		E.db.unitframe.units.boss.infoPanel.transparent = false;
		E.db.unitframe.units.raid.infoPanel.transparent = false;
		E.db.unitframe.units.raid40.infoPanel.transparent = false;
		--E.db.unitframe.units.raidpet.infoPanel.transparent = false;
	elseif theme == "transparent" then
		E.db.unitframe.fontSize = 12;
		E.db.general.topPanel = false;
		E.db.general.bottomPanel = false;
		E.db.general.bordercolor = E:GetColor(.1, .1, .1)
		E.db.general.backdropfadecolor = E:GetColor(.054, .054, .054, .6)
		E.db.unitframe.colors.healthclass = false;
		E.db.unitframe.colors.health = E:GetColor(.1, .1, .1)
		E.db.unitframe.colors.castColor = E:GetColor(.1, .1, .1)
		E.db.general.backdropcolor = E:GetColor(0.18, 0.18, 0.18)
		E.db.unitframe.colors.auraBarBuff = E:GetColor(classColor.r, classColor.b, classColor.g)
		E.db.unitframe.colors.castClassColor = true;
		E.db.databars.experience.mouseover = true;
		E.db.databars.reputation.mouseover = true;
		E.db.databars.artifact.mouseover = true;
		E.db.databars.honor.mouseover = true;
		-- E.db.actionbar.showGrid = false;
		E.db.datatexts.ActionBarPanels.ActionBarPanelOne.Template = "TRANSPARENT"
		E.db.datatexts.ActionBarPanels.ActionBarPanelTwo.Template = "TRANSPARENT"
		E.db.datatexts.ActionBarPanels.ActionBarPanelThree.Template = "TRANSPARENT"
		E.db.datatexts.ActionBarPanels.ActionBarPanelFour.Template = "TRANSPARENT"
		E.db.datatexts.ActionBarPanels.TopPanel.Enabled = false;
		E.db.datatexts.ActionBarPanels.BottomPanel.Enabled = false;
		E.db.datatexts.Backgrounds.LeftBG.Template = "TRANSPARENT";
		E.db.datatexts.Backgrounds.RightBG.Template = "TRANSPARENT";
		E.db.datatexts.Backgrounds.BottomBG.Template = "TRANSPARENT";
		--E.db.locplus.trans = true;
		E.db.datatexts.panelTransparency = true;
		E.db.chat.panelTabTransparency = true;
		E.db.chat.fontOutline = "OUTLINE"
		E.db.unitframe.colors.transparentHealth = true
		E.db.unitframe.colors.transparentPower = true
		E.db.unitframe.colors.transparentAurabars = true
		E.db.unitframe.colors.transparentCastbar = true;
		E.db.unitframe.units.player.infoPanel.transparent = true;
		E.db.unitframe.units.pet.infoPanel.transparent = true;
		E.db.unitframe.units.pettarget.infoPanel.transparent = true;
		E.db.unitframe.units.target.infoPanel.transparent = true;
		E.db.unitframe.units.targettarget.infoPanel.transparent = true;
		E.db.unitframe.units.targettargettarget.infoPanel.transparent = true;
		E.db.unitframe.units.focus.infoPanel.transparent = true;
		E.db.unitframe.units.focustarget.infoPanel.transparent = true;
		E.db.unitframe.units.party.infoPanel.transparent = true;
		E.db.unitframe.units.arena.infoPanel.transparent = true;
		E.db.unitframe.units.boss.infoPanel.transparent = true;
		E.db.unitframe.units.raid.infoPanel.transparent = true;
		E.db.unitframe.units.raid40.infoPanel.transparent = true;
		--E.db.unitframe.units.raidpet.infoPanel.transparent = true;
	elseif theme == "transparentonebarcoolline" then
		E.db.unitframe.fontSize = 12;
		E.db.general.topPanel = false;
		E.db.general.bottomPanel = false;
		E.db.general.bordercolor = E:GetColor(.1, .1, .1)
		E.db.general.backdropcolor = E:GetColor(.09, .09, .09)
		E.db.general.backdropfadecolor = E:GetColor(.054, .054, .054, .7)
		E.db.unitframe.colors.auraBarBuff = E:GetColor(classColor.r, classColor.b, classColor.g)
		E.db.unitframe.colors.castClassColor = true;
		E.db.unitframe.colors.healthclass = false
		E.db.unitframe.colors.health = E:GetColor(.1, .1, .1)
		E.db.unitframe.colors.castColor = E:GetColor(.1, .1, .1)
		E.db.databars.experience.mouseover = true;
		E.db.databars.reputation.mouseover = true;
		E.db.databars.artifact.mouseover = true;
		E.db.databars.honor.mouseover = true;
		-- E.db.actionbar.showGrid = false;
		E.db.datatexts.ActionBarPanels.ActionBarPanelOne.Template = "TRANSPARENT"
		E.db.datatexts.ActionBarPanels.ActionBarPanelTwo.Template = "TRANSPARENT"
		E.db.datatexts.ActionBarPanels.ActionBarPanelThree.Template = "TRANSPARENT"
		E.db.datatexts.ActionBarPanels.ActionBarPanelFour.Template = "TRANSPARENT"
		E.db.datatexts.ActionBarPanels.TopPanel.Enabled = false;
		E.db.datatexts.ActionBarPanels.BottomPanel.Enabled = false;
		E.db.datatexts.Backgrounds.LeftBG.Template = "TRANSPARENT";
		E.db.datatexts.Backgrounds.RightBG.Template = "TRANSPARENT";
		E.db.datatexts.Backgrounds.BottomBG.Template = "TRANSPARENT";
		--E.db.locplus.trans = true;
		E.db.datatexts.panelTransparency = true;
		E.db.chat.panelTabTransparency = true;
		E.db.chat.fontOutline = "OUTLINE"
		E.db.unitframe.colors.transparentHealth = true
		E.db.unitframe.colors.transparentPower = true
		E.db.unitframe.colors.transparentAurabars = true
		E.db.unitframe.colors.transparentCastbar = true;
		E.db.unitframe.units.player.infoPanel.transparent = true;
		E.db.unitframe.units.pet.infoPanel.transparent = true;
		E.db.unitframe.units.pettarget.infoPanel.transparent = true;
		E.db.unitframe.units.target.infoPanel.transparent = true;
		E.db.unitframe.units.targettarget.infoPanel.transparent = true;
		E.db.unitframe.units.targettargettarget.infoPanel.transparent = true;
		E.db.unitframe.units.focus.infoPanel.transparent = true;
		E.db.unitframe.units.focustarget.infoPanel.transparent = true;
		E.db.unitframe.units.party.infoPanel.transparent = true;
		E.db.unitframe.units.arena.infoPanel.transparent = true;
		E.db.unitframe.units.boss.infoPanel.transparent = true;
		E.db.unitframe.units.raid.infoPanel.transparent = true;
		E.db.unitframe.units.raid40.infoPanel.transparent = true;
		--E.db.unitframe.units.raidpet.infoPanel.transparent = true;
	elseif theme == "darker" then
		E.db.unitframe.fontSize = 12;
		E.db.general.topPanel = false;
		E.db.general.bottomPanel = false;
		E.db.general.bordercolor = E:GetColor(.1, .1, .1)
		E.db.general.backdropcolor = E:GetColor(.1, .1, .1)
		E.db.general.backdropfadecolor = E:GetColor(.054, .054, .054, .8)
		E.db.unitframe.colors.auraBarBuff = E:GetColor(classColor.r, classColor.b, classColor.g)
		E.db.unitframe.colors.castClassColor = true;
		E.db.unitframe.colors.healthclass = false
		E.db.unitframe.colors.health = E:GetColor(.1, .1, .1)
		E.db.unitframe.colors.castColor = E:GetColor(.1, .1, .1)
		E.db.databars.experience.mouseover = false;
		E.db.databars.reputation.mouseover = false;
		E.db.databars.artifact.mouseover = false;
		E.db.databars.honor.mouseover = false;
		E.db.actionbar.showGrid = true;
		E.db.datatexts.ActionBarPanels.ActionBarPanelOne.Template = "DEFAULT"
		E.db.datatexts.ActionBarPanels.ActionBarPanelTwo.Template = "DEFAULT"
		E.db.datatexts.ActionBarPanels.ActionBarPanelThree.Template = "DEFAULT"
		E.db.datatexts.ActionBarPanels.ActionBarPanelFour.Template = "DEFAULT"
		E.db.datatexts.ActionBarPanels.TopPanel.Enabled = true;
		E.db.datatexts.ActionBarPanels.BottomPanel.Enabled = true;
		E.db.datatexts.Backgrounds.LeftBG.Template = "DEFAULT";
		E.db.datatexts.Backgrounds.RightBG.Template = "DEFAULT";
		E.db.datatexts.Backgrounds.BottomBG.Template = "DEFAULT";
		--E.db.locplus.trans = false;
		E.db.datatexts.panelTransparency = false;
		E.db.chat.panelTabTransparency = false;
		E.db.chat.fontOutline = "NONE"
		E.db.unitframe.colors.transparentHealth = false;
		E.db.unitframe.colors.transparentPower = false;
		E.db.unitframe.colors.transparentAurabars = true;
		E.db.unitframe.colors.transparentCastbar = true;
		E.db.unitframe.units.player.infoPanel.transparent = false;
		E.db.unitframe.units.pet.infoPanel.transparent = false;
		E.db.unitframe.units.pettarget.infoPanel.transparent = false;
		E.db.unitframe.units.target.infoPanel.transparent = false;
		E.db.unitframe.units.targettarget.infoPanel.transparent = false;
		E.db.unitframe.units.targettargettarget.infoPanel.transparent = false;
		E.db.unitframe.units.focus.infoPanel.transparent = false;
		E.db.unitframe.units.focustarget.infoPanel.transparent = false;
		E.db.unitframe.units.party.infoPanel.transparent = false;
		E.db.unitframe.units.arena.infoPanel.transparent = false;
		E.db.unitframe.units.boss.infoPanel.transparent = false;
		E.db.unitframe.units.raid.infoPanel.transparent = false;
		E.db.unitframe.units.raid40.infoPanel.transparent = false;
		--E.db.unitframe.units.raidpet.infoPanel.transparent = false;
	elseif theme == "darkeronebarcoolline" then
		E.db.unitframe.fontSize = 12;
		E.db.general.topPanel = false;
		E.db.general.bottomPanel = false;
		E.db.general.bordercolor = E:GetColor(.1, .1, .1)
		E.db.general.backdropcolor = E:GetColor(.1, .1, .1)
		E.db.general.backdropfadecolor = E:GetColor(.054, .054, .054, .8)
		E.db.unitframe.colors.auraBarBuff = E:GetColor(classColor.r, classColor.b, classColor.g)
		E.db.unitframe.colors.castClassColor = true;
		E.db.unitframe.colors.healthclass = false
		E.db.unitframe.colors.health = E:GetColor(.1, .1, .1)
		E.db.unitframe.colors.castColor = E:GetColor(.1, .1, .1)
		E.db.databars.experience.mouseover = false;
		E.db.databars.reputation.mouseover = false;
		E.db.databars.artifact.mouseover = false;
		E.db.databars.honor.mouseover = false;
		E.db.actionbar.showGrid = true;
		E.db.datatexts.ActionBarPanels.ActionBarPanelOne.Template = "DEFAULT"
		E.db.datatexts.ActionBarPanels.ActionBarPanelTwo.Template = "DEFAULT"
		E.db.datatexts.ActionBarPanels.ActionBarPanelThree.Template = "DEFAULT"
		E.db.datatexts.ActionBarPanels.ActionBarPanelFour.Template = "DEFAULT"
		E.db.datatexts.ActionBarPanels.TopPanel.Enabled = true;
		E.db.datatexts.ActionBarPanels.BottomPanel.Enabled = true;
		E.db.datatexts.Backgrounds.LeftBG.Template = "DEFAULT";
		E.db.datatexts.Backgrounds.RightBG.Template = "DEFAULT";
		E.db.datatexts.Backgrounds.BottomBG.Template = "DEFAULT";
		--E.db.locplus.trans = false;
		E.db.datatexts.panelTransparency = false;
		E.db.chat.panelTabTransparency = false;
		E.db.chat.fontOutline = "NONE"
		E.db.unitframe.colors.transparentHealth = false;
		E.db.unitframe.colors.transparentPower = false;
		E.db.unitframe.colors.transparentAurabars = true;
		E.db.unitframe.colors.transparentCastbar = true;
		E.db.unitframe.units.player.infoPanel.transparent = false;
		E.db.unitframe.units.pet.infoPanel.transparent = false;
		E.db.unitframe.units.pettarget.infoPanel.transparent = false;
		E.db.unitframe.units.target.infoPanel.transparent = false;
		E.db.unitframe.units.targettarget.infoPanel.transparent = false;
		E.db.unitframe.units.targettargettarget.infoPanel.transparent = false;
		E.db.unitframe.units.focus.infoPanel.transparent = false;
		E.db.unitframe.units.focustarget.infoPanel.transparent = false;
		E.db.unitframe.units.party.infoPanel.transparent = false;
		E.db.unitframe.units.arena.infoPanel.transparent = false;
		E.db.unitframe.units.boss.infoPanel.transparent = false;
		E.db.unitframe.units.raid.infoPanel.transparent = false;
		E.db.unitframe.units.raid40.infoPanel.transparent = false;
		--E.db.unitframe.units.raidpet.infoPanel.transparent = false;
	elseif theme == "defaultonebarcoolline" then
		E.db.unitframe.fontSize = 12;
		E.db.general.bottomPanel = false;
		E.db.general.bordercolor = E:GetColor(.1, .1, .1)
		E.db.general.backdropcolor = E:GetColor(.1, .1, .1)
		E.db.general.backdropfadecolor = E:GetColor(.054, .054, .054, .8)
		E.db.unitframe.colors.healthclass = true;
		E.db.unitframe.colors.auraBarBuff = E:GetColor(classColor.r, classColor.b, classColor.g)
		E.db.unitframe.colors.health = E:GetColor(.1, .1, .1)
		E.db.unitframe.colors.castColor = E:GetColor(.1, .1, .1)
		E.db.general.backdropcolor = E:GetColor(0.18, 0.18, 0.18)
		E.db.unitframe.colors.auraBarBuff = E:GetColor(classColor.r, classColor.b, classColor.g)
		E.db.unitframe.colors.castClassColor = true;
		E.db.unitframe.units.player.power.offset = 0;
		E.db.unitframe.units.target.power.offset = 0;
		E.db.unitframe.units.targettarget.power.offset = 0;
		E.db.unitframe.units.targettargettarget.power.offset = 0;
		E.db.unitframe.units.pettarget.power.offset = 0;
		E.db.unitframe.units.pet.power.offset = 0;
		E.db.unitframe.units.focustarget.power.offset = 0;
		E.db.unitframe.units.focus.power.offset = 0;
		E.db.unitframe.units.party.power.offset = 0;
		E.db.unitframe.units.raid.power.offset = 0;
		E.db.unitframe.units.raid.power.offset = 0;
		E.db.unitframe.units.boss.power.offset = 0;
		E.db.unitframe.units.arena.power.offset = 0;
		E.db.databars.experience.mouseover = false;
		E.db.databars.reputation.mouseover = false;
		E.db.databars.artifact.mouseover = false;
		E.db.databars.honor.mouseover = false;
		E.db.actionbar.showGrid = true;
		E.db.datatexts.ActionBarPanels.ActionBarPanelOne.Template = "DEFAULT"
		E.db.datatexts.ActionBarPanels.ActionBarPanelTwo.Template = "DEFAULT"
		E.db.datatexts.ActionBarPanels.ActionBarPanelThree.Template = "DEFAULT"
		E.db.datatexts.ActionBarPanels.ActionBarPanelFour.Template = "DEFAULT"
		E.db.datatexts.ActionBarPanels.TopPanel.Enabled = true;
		E.db.datatexts.ActionBarPanels.BottomPanel.Enabled = true;
		E.db.datatexts.Backgrounds.LeftBG.Template = "DEFAULT";
		E.db.datatexts.Backgrounds.RightBG.Template = "DEFAULT";
		E.db.datatexts.Backgrounds.BottomBG.Template = "DEFAULT";
		--E.db.locplus.trans = false;
		E.db.datatexts.panelTransparency = false;
		E.db.chat.panelTabTransparency = false;
		E.db.chat.fontOutline = "NONE"
		E.db.unitframe.colors.transparentHealth = false;
		E.db.unitframe.colors.transparentPower = false;
		E.db.unitframe.colors.transparentAurabars = false;
		E.db.unitframe.colors.transparentCastbar = false;
		E.db.unitframe.units.player.infoPanel.transparent = false;
		E.db.unitframe.units.pet.infoPanel.transparent = false;
		E.db.unitframe.units.pettarget.infoPanel.transparent = false;
		E.db.unitframe.units.target.infoPanel.transparent = false;
		E.db.unitframe.units.targettarget.infoPanel.transparent = false;
		E.db.unitframe.units.targettargettarget.infoPanel.transparent = false;
		E.db.unitframe.units.focus.infoPanel.transparent = false;
		E.db.unitframe.units.focustarget.infoPanel.transparent = false;
		E.db.unitframe.units.party.infoPanel.transparent = false;
		E.db.unitframe.units.arena.infoPanel.transparent = false;
		E.db.unitframe.units.boss.infoPanel.transparent = false;
		E.db.unitframe.units.raid.infoPanel.transparent = false;
		E.db.unitframe.units.raid40.infoPanel.transparent = false;
		--E.db.unitframe.units.raidpet.infoPanel.transparent = false;
	else
		E.db.unitframe.fontSize = 12;
		E.db.general.bottomPanel = false;
		E.db.general.bordercolor = E:GetColor(.1, .1, .1)
		E.db.general.backdropcolor = E:GetColor(.1, .1, .1)
		E.db.general.backdropfadecolor = E:GetColor(.054, .054, .054, .8)
		E.db.unitframe.colors.healthclass = true;
		E.db.unitframe.colors.auraBarBuff = E:GetColor(classColor.r, classColor.b, classColor.g)
		E.db.unitframe.colors.health = E:GetColor(.1, .1, .1)
		E.db.unitframe.colors.castColor = E:GetColor(.1, .1, .1)
		E.db.general.backdropcolor = E:GetColor(0.18, 0.18, 0.18)
		E.db.unitframe.colors.auraBarBuff = E:GetColor(classColor.r, classColor.b, classColor.g)
		E.db.unitframe.colors.castClassColor = true;
		E.db.unitframe.units.player.power.offset = 0;
		E.db.unitframe.units.target.power.offset = 0;
		E.db.unitframe.units.targettarget.power.offset = 0;
		E.db.unitframe.units.targettargettarget.power.offset = 0;
		E.db.unitframe.units.pettarget.power.offset = 0;
		E.db.unitframe.units.pet.power.offset = 0;
		E.db.unitframe.units.focustarget.power.offset = 0;
		E.db.unitframe.units.focus.power.offset = 0;
		E.db.unitframe.units.party.power.offset = 0;
		E.db.unitframe.units.raid.power.offset = 0;
		E.db.unitframe.units.raid.power.offset = 0;
		E.db.unitframe.units.boss.power.offset = 0;
		E.db.unitframe.units.arena.power.offset = 0;
		E.db.databars.experience.mouseover = false;
		E.db.databars.reputation.mouseover = false;
		E.db.databars.artifact.mouseover = false;
		E.db.databars.honor.mouseover = false;
		E.db.actionbar.showGrid = true;
		E.db.datatexts.ActionBarPanels.ActionBarPanelOne.Template = "DEFAULT"
		E.db.datatexts.ActionBarPanels.ActionBarPanelTwo.Template = "DEFAULT"
		E.db.datatexts.ActionBarPanels.ActionBarPanelThree.Template = "DEFAULT"
		E.db.datatexts.ActionBarPanels.ActionBarPanelFour.Template = "DEFAULT"
		E.db.datatexts.ActionBarPanels.TopPanel.Enabled = true;
		E.db.datatexts.ActionBarPanels.BottomPanel.Enabled = true;
		E.db.datatexts.Backgrounds.LeftBG.Template = "DEFAULT";
		E.db.datatexts.Backgrounds.RightBG.Template = "DEFAULT";
		E.db.datatexts.Backgrounds.BottomBG.Template = "DEFAULT";
		--E.db.locplus.trans = false;
		E.db.datatexts.panelTransparency = false;
		E.db.chat.panelTabTransparency = false;
		E.db.chat.fontOutline = "NONE"
		E.db.unitframe.colors.transparentHealth = false;
		E.db.unitframe.colors.transparentPower = false;
		E.db.unitframe.colors.transparentAurabars = false;
		E.db.unitframe.colors.transparentCastbar = false;
		E.db.unitframe.units.player.infoPanel.transparent = false;
		E.db.unitframe.units.pet.infoPanel.transparent = false;
		E.db.unitframe.units.pettarget.infoPanel.transparent = false;
		E.db.unitframe.units.target.infoPanel.transparent = false;
		E.db.unitframe.units.targettarget.infoPanel.transparent = false;
		E.db.unitframe.units.targettargettarget.infoPanel.transparent = false;
		E.db.unitframe.units.focus.infoPanel.transparent = false;
		E.db.unitframe.units.focustarget.infoPanel.transparent = false;
		E.db.unitframe.units.party.infoPanel.transparent = false;
		E.db.unitframe.units.arena.infoPanel.transparent = false;
		E.db.unitframe.units.boss.infoPanel.transparent = false;
		E.db.unitframe.units.raid.infoPanel.transparent = false;
		E.db.unitframe.units.raid40.infoPanel.transparent = false;
		--E.db.unitframe.units.raidpet.infoPanel.transparent = false;
	end

	--Value Color
	if theme == "classic" then
		E.db.general.valuecolor = E:GetColor(classColor.r, classColor.b, classColor.g)
	elseif theme == "class" then
		E.db.general.valuecolor = E:GetColor(classColor.r, classColor.b, classColor.g)
	else
		E.db.general.valuecolor = E:GetColor(classColor.r, classColor.b, classColor.g)
	end

	if not noDisplayMsg then
		E:UpdateAll(true)
	end

	if InstallStatus then
		-- InstallStatus:SetStatusBarColor(unpack(E['media'].rgbvaluecolor))
		if InstallStepComplete and not noDisplayMsg then
			InstallStepComplete.message = L["Theme Set"]
			InstallStepComplete:Show()
		end
	end
end

function E:SetupResolution(noDataReset)
	if not noDataReset then
		E:ResetMovers('')
	end

	if self == 'low' then
		if not E.db.movers then E.db.movers = {}; end
		if not noDataReset then
			E.db.chat.panelWidth = 350
			E.db.chat.panelHeight = 123
			E.db.chat.panelWidthRight = 350
			E.db.chat.panelHeightRight = 123
			E:CopyTable(E.db.actionbar, P.actionbar)
			E.db.actionbar.bar3.enabled = false;
			E.db.actionbar.bar5.enabled = false;
			E.db.datatexts.ActionBarPanels.ActionBarPanelOne.Enabled = true;
			E.db.datatexts.ActionBarPanels.ActionBarPanelTwo.Enabled = false;
			E.db.datatexts.ActionBarPanels.ActionBarPanelThree.Enabled = false;
		end

		if not noDataReset then
			E.db.auras.wrapAfter = 10;
		end

		if not noDataReset then
			E:CopyTable(E.db.unitframe.units, P.unitframe.units)
			E.db.unitframe.fontSize = 12
			E.db.unitframe.units.player.width = 240;
			E.db.unitframe.units.player.castbar.width = 240;
			E.db.unitframe.units.player.health.text_format = "[healthcolor][health:current]"
			E.db.unitframe.units.target.width = 240;
			E.db.unitframe.units.target.castbar.width = 240;
			E.db.unitframe.units.player.classbar.DetachFromFrame = true;
			-- E.db.unitframe.units.target.combobar.detachFromFrame = false;
			E.db.unitframe.units.target.health.text_format = '[healthcolor][health:current]'
			E.db.unitframe.units.pet.power.enable = false;
			E.db.unitframe.units.pet.width = 740;
			E.db.unitframe.units.targettarget.debuffs.enable = false;
			E.db.unitframe.units.targettarget.power.enable = false;
			E.db.unitframe.units.targettarget.width = 240;
			E.db.unitframe.units.boss.width = 200;
			E.db.unitframe.units.boss.castbar.width = 200;
			E.db.unitframe.units.arena.width = 200;
			E.db.unitframe.units.arena.castbar.width = 200;
			E.db.movers.ElvUF_PlayerMover = "BOTTOMLEFTElvUIParentBOTTOM-450240"
			E.db.movers.ElvUF_TargetMover = "BOTTOMRIGHTElvUIParentBOTTOM450240"
			E.db.movers.ElvUF_PetMover = "LEFTElvUF_PlayerLEFT-1300"
			E.db.movers.ElvUF_PetTargetMover = "TOPElvUF_PetTOP040"
			E.db.movers.ElvUF_FocusMover = "BOTTOMLEFTElvUF_PlayerTOPLEFT0360"
			E.db.movers.ElvUF_TargetTargetMover = "BOTTOMElvUF_TargetBOTTOM0-66"
			E.db.movers.ElvUF_Raid40Mover = "BOTTOMElvUIParentBOTTOM0150"
			E.db.movers.ElvUF_RaidMover = "BOTTOMElvUIParentBOTTOM0150"
			E.db.movers.ElvUF_PartyMover = "BOTTOMElvUIParentBOTTOM0215"
			E.db.movers.TotemBarMover = "BOTTOMElvUF_PlayerBOTTOM-200-66"
			E.db.movers.ShiftAB = "BOTTOMElvUF_PlayerBOTTOM0-66"
			E.db.movers.PetAB = "BOTTOMElvUI_Bar1BOTTOM057"
			E.db.movers.BossButton = "CENTERElvUIParentCENTER1000"
			E.db.movers.ArenaHeaderMover = "BOTTOMRIGHTElvUF_TargetBOTTOMRIGHT60200"
			E.db.movers.BossHeaderMover = "BOTTOMRIGHTElvUF_TargetBOTTOMRIGHT60266"
			E.db.unitframe.units.party.health.frequentUpdates = true;
			E.db.unitframe.units.party.health.text = true;
			E.db.unitframe.units.party.name.position = 'TOP';
			E.db.unitframe.units.party.roleIcon.enable = true;
			E.db.unitframe.units.party.healPrediction = true;
			E.db.unitframe.units.party.petsGroup.enable = true;
			E.db.unitframe.units.party.growthDirection = 'RIGHT_DOWN';
			E.db.unitframe.units.party.health.orientation = 'VERTICAL';
			E.db.unitframe.units.party.xOffset = 3;
			E.db.unitframe.units.party.health.text_format = "[healthcolor][health:deficit]"
			E.db.unitframe.units.party.health.position = 'BOTTOM';
			E.db.unitframe.units.party.name.position = 'TOP';
			E.db.unitframe.units.party.name.text_format = "[namecolor][name:medium]";
			E.db.unitframe.units.party.buffs.anchorPoint = 'TOPLEFT';
			E.db.unitframe.units.party.buffs.perrow = 3;
			E.db.unitframe.units.party.buffs.sizeOverride = 0;
			E.db.unitframe.units.party.debuffs.anchorPoint = 'BOTTOMRIGHT';
			E.db.unitframe.units.party.debuffs.perrow = 3;
			E.db.unitframe.units.party.debuffs.sizeOverride = 0;
			E.db.unitframe.units.party.debuffs.useFilter = 'Blacklist';
			E.db.unitframe.units.party.petsGroup.enable = true;
			E.db.unitframe.units.party.petsGroup.initialAnchor = 'BOTTOM';
			E.db.unitframe.units.party.petsGroup.anchorPoint = 'BOTTOM';
			E.db.unitframe.units.party.petsGroup.xOffset = 0;
			E.db.unitframe.units.party.petsGroup.yOffset = -26;
			E.db.unitframe.units.pettarget.enable = false;
			E.db.unitframe.units.party.targetsGroup.enable = true;
			E.db.unitframe.units.party.targetsGroup.initialAnchor = 'TOP';
			E.db.unitframe.units.party.targetsGroup.anchorPoint = 'TOP';
			E.db.unitframe.units.party.targetsGroup.xOffset = 0;
			E.db.unitframe.units.party.targetsGroup.yOffset = 26;
			E.db.unitframe.units.party.width = 69;
			E.db.unitframe.units.party.petsGroup.width = 69;
			E.db.unitframe.units.party.targetsGroup.width = 69;
			E.db.unitframe.units.party.height = 46;
			E.db.unitframe.units.party.petsGroup.height = 30;
			E.db.unitframe.units.party.targetsGroup.height = 30;
		end

		local isPixel = E.private.general.pixelPerfect and not E.global.tukuiMode
		local xOffset = isPixel and 103 or 106;
		local yOffset = isPixel and 125 or 135;
		local yOffsetSmall = isPixel and 76 or 80;

		-- E.db.movers.ElvUF_PlayerMover = "BOTTOM,ElvUIParent,BOTTOM,"..-xOffset..","..yOffset
		-- E.db.movers.ElvUF_TargetTargetMover = "BOTTOM,ElvUIParent,BOTTOM,"..xOffset..","..yOffsetSmall
		-- E.db.movers.ElvUF_TargetMover = "BOTTOM,ElvUIParent,BOTTOM,"..xOffset..","..yOffset
		-- E.db.movers.ElvUF_PetMover = "BOTTOM,ElvUIParent,BOTTOM,"..-xOffset..","..yOffsetSmall
		-- E.db.movers.ElvUF_FocusMover = "BOTTOM,ElvUIParent,BOTTOM,310,332"

		E.db.lowresolutionset = true;
	elseif not noDataReset then
		E.db.chat.panelWidth = P.chat.panelWidth
		E.db.chat.panelHeight = P.chat.panelHeight
		E:CopyTable(E.db.actionbar, P.actionbar)
		E:CopyTable(E.db.unitframe.units, P.unitframe.units)
		E:SetupPixelPerfect(E.PixelMode, true)
		E.db.auras.wrapAfter = P.auras.wrapAfter;
		E.db.databars.reputation.width = P.databars.reputation.width
		E.db.databars.experience.width = P.databars.experience.width
		E.db.lowresolutionset = nil;
	end

	if not noDataReset and E.private.theme then
		E:SetupTheme(E.private.theme, true)
	end

	E:UpdateAll(true)

	if InstallStepComplete and not noDataReset then
		InstallStepComplete.message = L["Resolution Style Set"]
		InstallStepComplete:Show()
	end
end

function E:SetupLayout(layout, noDataReset)
	--Unitframes
	if not noDataReset then
		E:CopyTable(E.db.unitframe.units, P.unitframe.units)
	end

	-- if not noDataReset then
		-- E:ResetMovers('')
		-- if not E.db.movers then E.db.movers = {} end
		-- E.db.actionbar.bar2.enabled = E.db.lowresolutionset
		-- if E.PixelMode then
			-- E.db.movers.ElvAB_2 = "BOTTOM,ElvUIParent,BOTTOM,0,38"
		-- else
			-- E.db.movers.ElvAB_2 = "BOTTOM,ElvUIParent,BOTTOM,0,40"
		-- end
		-- if not E.db.lowresolutionset then
			-- E.db.actionbar.bar3.buttons = 12
			-- E.db.actionbar.bar5.buttons = 12
			-- E.db.actionbar.bar4.enabled = true
		-- end
	-- end

	if layout == 'healer' then
		if not IsAddOnLoaded('Clique') then
			E:StaticPopup_Show("CLIQUE_ADVERT")
		end

		if not noDataReset then
			E.db.unitframe.units.party.health.frequentUpdates = true;
			E.db.unitframe.units.raid.health.frequentUpdates = true;
			E.db.unitframe.units.raid.health.frequentUpdates = true;
			E.db.unitframe.units.raid.health.frequentUpdates = true;
			E.db.unitframe.units.party.health.text = true;
			E.db.unitframe.units.raid.health.text = true;
			E.db.unitframe.units.raid.health.text = true;
			E.db.unitframe.units.raid.health.text = true;
			E.db.unitframe.units.party.name.position = 'TOP';
			E.db.unitframe.units.raid.name.position = 'TOP';
			E.db.unitframe.units.raid.name.position = 'TOP';
			E.db.unitframe.units.raid.name.position = 'TOP';
			E.db.unitframe.units.party.roleIcon.enable = true;
			E.db.unitframe.units.raid.roleIcon.enable = true;
			E.db.unitframe.units.raid.roleIcon.enable = true;
			E.db.unitframe.units.raid.roleIcon.enable = true;
			E.db.unitframe.units.party.healPrediction = true;
			E.db.unitframe.units.raid.healPrediction = true;
			E.db.unitframe.units.raid.healPrediction = true;
			E.db.unitframe.units.raid.healPrediction = true;
			E.db.unitframe.units.party.petsGroup.enable = true;
			E.db.unitframe.units.party.growthDirection = 'RIGHT_DOWN';
			E.db.unitframe.units.party.health.orientation = 'VERTICAL';
			E.db.unitframe.units.raid.health.orientation = 'VERTICAL';
			E.db.unitframe.units.raid.health.orientation = 'VERTICAL';
			E.db.unitframe.units.raid.health.orientation = 'VERTICAL';
			E.db.unitframe.units.player.portrait.camDistanceScale = 3;
			E.db.unitframe.units.player.classbar.height = 6;
			E.db.unitframe.units.player.classbar.detachedWidth = 100;
			E.db.unitframe.units.player.classbar.DetachFromFrame = true;
			E.db.unitframe.units.player.classbar.fill = "fill";
			E.db.unitframe.units.player.power.position = "RIGHT";
			E.db.unitframe.units.player.power.xOffset = 0;
			E.db.unitframe.units.player.power.yOffset = 0;
			E.db.unitframe.units.player.health.position = "LEFT";
			E.db.unitframe.units.player.health.xOffset = 0;
			E.db.unitframe.units.player.health.yOffset = 0;
			E.db.unitframe.units.player.name.position = "CENTER";
			E.db.unitframe.units.player.name.xOffset = 0;
			E.db.unitframe.units.player.name.yOffset = 0;
			E.db.unitframe.units.player.buffs.yOffset = 0;
			E.db.unitframe.units.player.debuffs.yOffset = 0;
			E.db.unitframe.units.player.pvp.position = "TOP";
			E.db.unitframe.units.player.height = 41;
			E.db.unitframe.units.player.width = 270;
			E.db.unitframe.units.player.aurabar.enable = true;
			E.db.unitframe.units.player.aurabar.attachTo = "FRAME"
			E.db.unitframe.units.player.stagger.enable = true;
			E.db.unitframe.units.pet.height = 38;
			E.db.unitframe.units.pet.width = 135;
			E.db.unitframe.units.pet.debuffs.attachTo = "FRAME";
			E.db.unitframe.units.pet.debuffs.anchorPoint = "LEFT";
			E.db.unitframe.units.pettarget.height = 38;
			E.db.unitframe.units.pettarget.width = 135;
			E.db.unitframe.units.pettarget.debuffs.attachTo = "FRAME";
			E.db.unitframe.units.pettarget.debuffs.anchorPoint = "LEFT";
			-- E.db.unitframe.units.bodyguard.height = 38;
			-- E.db.unitframe.units.bodyguard.width = 135;
			E.db.unitframe.units.targettarget.height = 38;
			E.db.unitframe.units.targettarget.width = 135;
			E.db.unitframe.units.targettarget.debuffs.attachTo = "FRAME";
			E.db.unitframe.units.targettarget.debuffs.anchorPoint = "RIGHT";
			E.db.unitframe.units.targettargettarget.height = 38;
			E.db.unitframe.units.targettargettarget.width = 135;
			E.db.unitframe.units.targettargettarget.buffs.enable = true;
			E.db.unitframe.units.targettargettarget.debuffs.enable = true;
			E.db.unitframe.units.targettargettarget.debuffs.attachTo = "FRAME";
			E.db.unitframe.units.targettargettarget.debuffs.anchorPoint = "RIGHT";
			E.db.unitframe.units.target.portrait.camDistanceScale = 3;
			-- E.db.unitframe.units.target.combobar.height = 6;
			-- E.db.unitframe.units.target.combobar.detachedWidth = 100;
			-- E.db.unitframe.units.target.combobar.detachFromFrame = true;
			-- E.db.unitframe.units.target.combobar.fill = "fill";
			E.db.unitframe.units.target.power.position = "LEFT";
			E.db.unitframe.units.target.power.xOffset = 0;
			E.db.unitframe.units.target.power.yOffset = 0;
			E.db.unitframe.units.target.health.position = "RIGHT";
			E.db.unitframe.units.target.health.xOffset = 0;
			E.db.unitframe.units.target.health.yOffset = 0;
			E.db.unitframe.units.target.name.position = "CENTER";
			E.db.unitframe.units.target.name.xOffset = 0;
			E.db.unitframe.units.target.name.yOffset = 0;
			E.db.unitframe.units.target.buffs.yOffset = 0;
			E.db.unitframe.units.target.debuffs.yOffset = 0;
			E.db.unitframe.units.target.height = 41;
			E.db.unitframe.units.target.width = 270;
			E.db.unitframe.units.target.aurabar.enable = true;
			E.db.unitframe.units.target.buffs.anchorPoint = "TOPRIGHT";
			E.db.unitframe.units.target.debuffs.anchorPoint = "TOPLEFT";
			E.db.unitframe.units.target.smartAuraDisplay = "DISABLED";
			E.db.unitframe.units.focus.width = 220;
			E.db.unitframe.units.focus.debuffs.anchorPoint = "TOPRIGHT";
			E.db.unitframe.units.focus.buffs.anchorPoint = "TOPLEFT";
			E.db.unitframe.units.focustarget.width = 95;
			E.db.unitframe.units.boss.portrait.camDistanceScale = 3;
			E.db.auras.buffs.growthDirection = "RIGHT_DOWN";
			E.db.auras.buffs.wrapAfter = 12;
			E.db.auras.debuffs.maxWraps = 1;
			E.db.auras.debuffs.growthDirection = "RIGHT_DOWN";
			E.db.auras.debuffs.wrapAfter = 12;
			E.db.datatexts.ActionBarPanels.ActionBarPanelTwo.Enabled = false;
			E.db.datatexts.ActionBarPanels.ActionBarPanelThree.Enabled = false;
			E.db.actionbar.bar3.buttonsPerRow = 12;
			E.db.actionbar.bar5.buttonsPerRow = 12;
			E.db.bags.xOffset = 0;
			E.db.bags.xOffsetBank = 0;
			E.db.bags.yOffset = 110;
			E.db.bags.yOffsetBank = 110;
			E.db.bags.alignToChat = true;
			E.db.bags.bagBar.sortDirection = "ASCENDING";
			E.db.bags.bagBar.growthDirection = "HORIZONTAL";
			E.db.bags.bagBar.mouseover = true;
			E.db.chat.panelWidth = 407;
			E.db.chat.panelHeight = 137;
			E.db.unitframe.units.party.health.frequentUpdates = true;
			E.db.unitframe.units.party.health.text = true;
			E.db.unitframe.units.party.name.position = 'TOP';
			E.db.unitframe.units.party.roleIcon.enable = true;
			E.db.unitframe.units.party.healPrediction = true;
			E.db.unitframe.units.party.petsGroup.enable = true;
			E.db.unitframe.units.party.growthDirection = 'RIGHT_DOWN';
			E.db.unitframe.units.party.health.orientation = 'VERTICAL';
			E.db.unitframe.units.party.xOffset = 3;
			E.db.unitframe.units.party.health.text_format = "[healthcolor][health:deficit]"
			E.db.unitframe.units.party.health.position = 'BOTTOM';
			E.db.unitframe.units.party.name.position = 'TOP';
			E.db.unitframe.units.party.name.text_format = "[namecolor][name:medium]";
			E.db.unitframe.units.party.buffs.anchorPoint = 'TOPLEFT';
			E.db.unitframe.units.party.buffs.perrow = 3;
			E.db.unitframe.units.party.buffs.sizeOverride = 0;
			E.db.unitframe.units.party.debuffs.anchorPoint = 'BOTTOMRIGHT';
			E.db.unitframe.units.party.debuffs.perrow = 3;
			E.db.unitframe.units.party.debuffs.sizeOverride = 0;
			E.db.unitframe.units.party.debuffs.useFilter = 'Blacklist';
			E.db.unitframe.units.party.petsGroup.enable = true;
			E.db.unitframe.units.party.petsGroup.initialAnchor = 'BOTTOM';
			E.db.unitframe.units.party.petsGroup.anchorPoint = 'BOTTOM';
			E.db.unitframe.units.party.petsGroup.xOffset = 0;
			E.db.unitframe.units.party.petsGroup.yOffset = -26;
			E.db.unitframe.units.party.targetsGroup.enable = true;
			E.db.unitframe.units.party.targetsGroup.initialAnchor = 'TOP';
			E.db.unitframe.units.party.targetsGroup.anchorPoint = 'TOP';
			E.db.unitframe.units.party.targetsGroup.xOffset = 0;
			E.db.unitframe.units.party.targetsGroup.yOffset = 26;
			E.db.unitframe.units.party.petsGroup.width = 69;
			E.db.unitframe.units.party.targetsGroup.width = 69;
			E.db.unitframe.units.party.height = 46;
			E.db.unitframe.units.party.width = 69;
			E.db.unitframe.units.party.xOffset = 3;
			E.db.unitframe.units.party.horizontalSpacing = 3;
			E.db.unitframe.units.party.petsGroup.height = 30;
			E.db.unitframe.units.party.targetsGroup.height = 30;
			E.db.unitframe.units.raid.width = 69;
			E.db.unitframe.units.raid.height = 36;
			E.db.unitframe.units.raid40.width = 69;
			E.db.unitframe.units.raid40.height = 36;
			E.db.unitframe.units.raidpet.width = 69;
			E.db.unitframe.units.raidpet.height = 30;
			E.db.unitframe.units.raid.xOffset = 3;
			E.db.unitframe.units.raid.horizontalSpacing = 3;
			E.db.unitframe.units.raid40.xOffset = 3;
			E.db.unitframe.units.raid40.horizontalSpacing = 3;
			E.db.unitframe.units.raidpet.xOffset = 3;
			E.db.unitframe.units.raidpet.horizontalSpacing = 3;
			E.db.unitframe.units.raid.health.frequentUpdates = true;
			E.db.unitframe.units.raid.health.text = true;
			E.db.unitframe.units.raid.name.position = 'TOP';
			E.db.unitframe.units.raid.roleIcon.enable = true;
			E.db.unitframe.units.raid.healPrediction = true;
			E.db.unitframe.units.raid.health.orientation = 'VERTICAL';
			E.db.movers.ElvUF_PartyMover = "BOTTOMElvUIParentBOTTOM0310"
		end

		if not E.db.movers then E.db.movers = {}; end
		local xOffset = GetScreenWidth() * 0.34375
		if E.db.lowresolutionset then
		if not E.db.movers then E.db.movers = {}; end
			E.db.movers.ElvUF_PlayerMover = "BOTTOMLEFTElvUIParentBOTTOM-450240"
			E.db.movers.ElvUF_TargetMover = "BOTTOMRIGHTElvUIParentBOTTOM450240"
			E.db.movers.ElvUF_PetMover = "LEFTElvUF_PlayerLEFT-1300"
			E.db.movers.ElvUF_PetTargetMover = "TOPElvUF_PetTOP040"
			E.db.movers.ElvUF_FocusMover = "BOTTOMLEFTElvUF_PlayerTOPLEFT0360"
			E.db.movers.ElvUF_TargetTargetMover = "BOTTOMElvUF_TargetBOTTOM0-66"
			E.db.movers.ElvUF_Raid40Mover = "BOTTOMElvUIParentBOTTOM0150"
			E.db.movers.ElvUF_RaidMover = "BOTTOMElvUIParentBOTTOM0150"
			E.db.movers.ElvUF_PartyMover = "BOTTOMElvUIParentBOTTOM0215"
			E.db.movers.TotemBarMover = "BOTTOMElvUF_PlayerBOTTOM-200-66"
			E.db.movers.ShiftAB = "BOTTOMElvUF_PlayerBOTTOM0-66"
			E.db.movers.PetAB = "BOTTOMElvUI_Bar1BOTTOM057"
			E.db.movers.BossButton = "CENTERElvUIParentCENTER1000"
			E.db.movers.ArenaHeaderMover = "BOTTOMRIGHTElvUF_TargetBOTTOMRIGHT60200"
			E.db.movers.BossHeaderMover = "BOTTOMRIGHTElvUF_TargetBOTTOMRIGHT60266"
			E.db.unitframe.units.party.health.frequentUpdates = true;
			E.db.unitframe.units.party.health.text = true;
			E.db.unitframe.units.party.name.position = 'TOP';
			E.db.unitframe.units.party.roleIcon.enable = true;
			E.db.unitframe.units.party.healPrediction = true;
			E.db.unitframe.units.party.petsGroup.enable = true;
			E.db.unitframe.units.party.growthDirection = 'RIGHT_DOWN';
			E.db.unitframe.units.party.health.orientation = 'VERTICAL';
			E.db.unitframe.units.party.xOffset = 3;
			E.db.unitframe.units.party.health.text_format = "[healthcolor][health:deficit]"
			E.db.unitframe.units.party.health.position = 'BOTTOM';
			E.db.unitframe.units.party.name.position = 'TOP';
			E.db.unitframe.units.party.name.text_format = "[namecolor][name:medium]";
			E.db.unitframe.units.party.buffs.anchorPoint = 'TOPLEFT';
			E.db.unitframe.units.party.buffs.perrow = 3;
			E.db.unitframe.units.party.buffs.sizeOverride = 0;
			E.db.unitframe.units.party.debuffs.anchorPoint = 'BOTTOMRIGHT';
			E.db.unitframe.units.party.debuffs.perrow = 3;
			E.db.unitframe.units.party.debuffs.sizeOverride = 0;
			E.db.unitframe.units.party.debuffs.useFilter = 'Blacklist';
			E.db.unitframe.units.party.petsGroup.enable = true;
			E.db.unitframe.units.party.petsGroup.initialAnchor = 'BOTTOM';
			E.db.unitframe.units.party.petsGroup.anchorPoint = 'BOTTOM';
			E.db.unitframe.units.party.petsGroup.xOffset = 0;
			E.db.unitframe.units.party.petsGroup.yOffset = -26;
			E.db.unitframe.units.pettarget.enable = false;
			E.db.unitframe.units.player.classbar.DetachFromFrame = true;
			-- E.db.unitframe.units.target.combobar.detachFromFrame = false;
			E.db.unitframe.units.party.targetsGroup.enable = true;
			E.db.unitframe.units.party.targetsGroup.initialAnchor = 'TOP';
			E.db.unitframe.units.party.targetsGroup.anchorPoint = 'TOP';
			E.db.unitframe.units.party.targetsGroup.xOffset = 0;
			E.db.unitframe.units.party.targetsGroup.yOffset = 26;
			E.db.unitframe.units.party.width = 69;
			E.db.unitframe.units.party.petsGroup.width = 69;
			E.db.unitframe.units.party.targetsGroup.width = 69;
			E.db.unitframe.units.party.height = 46;
			E.db.unitframe.units.party.petsGroup.height = 30;
			E.db.unitframe.units.party.targetsGroup.height = 30;
		elseif not E.db.lowresolutionset and (layout == 'healer') then
			E.db.movers.ElvUF_PartyMover = "BOTTOMElvUIParentBOTTOM0310"
		end
	elseif E.db.lowresolutionset then
		if not E.db.movers then E.db.movers = {}; end
			E.db.movers.ElvUF_PlayerMover = "BOTTOMLEFTElvUIParentBOTTOM-450240"
			E.db.movers.ElvUF_TargetMover = "BOTTOMRIGHTElvUIParentBOTTOM450240"
			E.db.movers.ElvUF_PetMover = "LEFTElvUF_PlayerLEFT-1300"
			E.db.movers.ElvUF_PetTargetMover = "TOPElvUF_PetTOP040"
			E.db.movers.ElvUF_FocusMover = "BOTTOMLEFTElvUF_PlayerTOPLEFT0360"
			E.db.movers.ElvUF_TargetTargetMover = "BOTTOMElvUF_TargetBOTTOM0-66"
			E.db.movers.ElvUF_Raid40Mover = "BOTTOMElvUIParentBOTTOM0150"
			E.db.movers.ElvUF_RaidMover = "BOTTOMElvUIParentBOTTOM0150"
			E.db.movers.ElvUF_PartyMover = "BOTTOMElvUIParentBOTTOM0215"
			E.db.movers.TotemBarMover = "BOTTOMElvUF_PlayerBOTTOM-200-66"
			E.db.movers.ShiftAB = "BOTTOMElvUF_PlayerBOTTOM0-66"
			E.db.movers.PetAB = "BOTTOMElvUI_Bar1BOTTOM057"
			E.db.movers.BossButton = "CENTERElvUIParentCENTER1000"
			E.db.movers.ArenaHeaderMover = "BOTTOMRIGHTElvUF_TargetBOTTOMRIGHT60200"
			E.db.movers.BossHeaderMover = "BOTTOMRIGHTElvUF_TargetBOTTOMRIGHT60266"
			E.db.unitframe.units.party.health.frequentUpdates = true;
			E.db.unitframe.units.party.health.text = true;
			E.db.unitframe.units.party.name.position = 'TOP';
			E.db.unitframe.units.party.roleIcon.enable = true;
			E.db.unitframe.units.party.healPrediction = true;
			E.db.unitframe.units.party.petsGroup.enable = true;
			E.db.unitframe.units.party.growthDirection = 'RIGHT_DOWN';
			E.db.unitframe.units.party.health.orientation = 'VERTICAL';
			E.db.unitframe.units.party.xOffset = 3;
			E.db.unitframe.units.party.health.text_format = "[healthcolor][health:deficit]"
			E.db.unitframe.units.party.health.position = 'BOTTOM';
			E.db.unitframe.units.party.name.position = 'TOP';
			E.db.unitframe.units.party.name.text_format = "[namecolor][name:medium]";
			E.db.unitframe.units.party.buffs.anchorPoint = 'TOPLEFT';
			E.db.unitframe.units.party.buffs.perrow = 3;
			E.db.unitframe.units.party.buffs.sizeOverride = 0;
			E.db.unitframe.units.party.debuffs.anchorPoint = 'BOTTOMRIGHT';
			E.db.unitframe.units.party.debuffs.perrow = 3;
			E.db.unitframe.units.party.debuffs.sizeOverride = 0;
			E.db.unitframe.units.party.debuffs.useFilter = 'Blacklist';
			E.db.unitframe.units.party.petsGroup.enable = true;
			E.db.unitframe.units.party.petsGroup.initialAnchor = 'BOTTOM';
			E.db.unitframe.units.party.petsGroup.anchorPoint = 'BOTTOM';
			E.db.unitframe.units.party.petsGroup.xOffset = 0;
			E.db.unitframe.units.party.petsGroup.yOffset = -26;
			E.db.unitframe.units.pettarget.enable = false;
			E.db.unitframe.units.party.targetsGroup.enable = true;
			E.db.unitframe.units.party.targetsGroup.initialAnchor = 'TOP';
			E.db.unitframe.units.party.targetsGroup.anchorPoint = 'TOP';
			E.db.unitframe.units.party.targetsGroup.xOffset = 0;
			E.db.unitframe.units.party.targetsGroup.yOffset = 26;
			E.db.unitframe.units.party.width = 69;
			E.db.unitframe.units.party.petsGroup.width = 69;
			E.db.unitframe.units.party.targetsGroup.width = 69;
			E.db.unitframe.units.party.height = 46;
			E.db.unitframe.units.party.petsGroup.height = 30;
			E.db.unitframe.units.party.targetsGroup.height = 30;
	else
		if not noDataReset then
			E:ResetMovers('')
			E:SetupPixelPerfect(E.PixelMode, true)
		end
	end

	if layout == 'nouveauheal' then
		if not IsAddOnLoaded('Clique') then
			E:StaticPopup_Show("CLIQUE_ADVERT")
		end

		if not noDataReset then
			E.db.unitframe.units.party.health.frequentUpdates = true;
			E.db.unitframe.units.raid.health.frequentUpdates = true;
			E.db.unitframe.units.raid.health.frequentUpdates = true;
			E.db.unitframe.units.raid.health.frequentUpdates = true;
			E.db.unitframe.units.party.health.text = true;
			E.db.unitframe.units.raid.health.text = true;
			E.db.unitframe.units.raid.health.text = true;
			E.db.unitframe.units.raid.health.text = true;
			E.db.unitframe.units.party.name.position = 'TOP';
			E.db.unitframe.units.raid.name.position = 'TOP';
			E.db.unitframe.units.raid.name.position = 'TOP';
			E.db.unitframe.units.raid.name.position = 'TOP';
			E.db.unitframe.units.party.roleIcon.enable = true;
			E.db.unitframe.units.raid.roleIcon.enable = true;
			E.db.unitframe.units.raid.roleIcon.enable = true;
			E.db.unitframe.units.raid.roleIcon.enable = true;
			E.db.unitframe.units.party.healPrediction = true;
			E.db.unitframe.units.raid.healPrediction = true;
			E.db.unitframe.units.raid.healPrediction = true;
			E.db.unitframe.units.raid.healPrediction = true;
			E.db.unitframe.units.party.petsGroup.enable = true;
			E.db.unitframe.units.party.growthDirection = 'RIGHT_DOWN';
			E.db.unitframe.units.party.health.orientation = 'VERTICAL';
			E.db.unitframe.units.raid.health.orientation = 'VERTICAL';
			E.db.unitframe.units.raid.health.orientation = 'VERTICAL';
			E.db.unitframe.units.raid.health.orientation = 'VERTICAL';
			E.db.unitframe.units.player.portrait.camDistanceScale = 3;
			E.db.unitframe.units.player.classbar.height = 6;
			E.db.unitframe.units.player.classbar.detachedWidth = 100;
			E.db.unitframe.units.player.classbar.DetachFromFrame = true;
			E.db.unitframe.units.player.classbar.fill = "fill";
			E.db.unitframe.units.player.power.position = "RIGHT";
			E.db.unitframe.units.player.power.xOffset = 0;
			E.db.unitframe.units.player.power.yOffset = 0;
			E.db.unitframe.units.player.health.position = "LEFT";
			E.db.unitframe.units.player.health.xOffset = 0;
			E.db.unitframe.units.player.health.yOffset = 0;
			E.db.unitframe.units.player.name.position = "CENTER";
			E.db.unitframe.units.player.name.xOffset = 0;
			E.db.unitframe.units.player.name.yOffset = 0;
			E.db.unitframe.units.player.buffs.enable = true;
			E.db.unitframe.units.player.buffs.yOffset = 0;
			E.db.unitframe.units.player.buffs.attachTo = "FRAME";
			E.db.unitframe.units.player.buffs.sizeOverride = 0;
			E.db.unitframe.units.player.buffs.sortDirection = "DESCENDING";
			E.db.unitframe.units.player.debuffs.yOffset = 0;
			E.db.unitframe.units.player.debuffs.enable = true;
			E.db.unitframe.units.player.debuffs.attachTo = "BUFFS";
			E.db.unitframe.units.player.debuffs.sortDirection = "DESCENDING";
			E.db.unitframe.units.player.debuffs.sizeOverride = 0;
			E.db.unitframe.units.player.pvp.position = "TOP";
			E.db.unitframe.units.player.height = 41;
			E.db.unitframe.units.player.width = 270;
			E.db.unitframe.units.player.aurabar.enable = true;
			E.db.unitframe.units.player.aurabar.attachTo = "DEBUFFS"
			E.db.unitframe.units.player.stagger.enable = true;
			E.db.unitframe.units.player.buffs.anchorPoint = "TOPLEFT";
			E.db.unitframe.units.player.debuffs.anchorPoint = "TOPRIGHT";
			E.db.unitframe.units.pet.height = 38;
			E.db.unitframe.units.pet.width = 135;
			E.db.unitframe.units.pet.debuffs.attachTo = "FRAME";
			E.db.unitframe.units.pet.debuffs.anchorPoint = "LEFT";
			E.db.unitframe.units.pettarget.height = 38;
			E.db.unitframe.units.pettarget.width = 135;
			E.db.unitframe.units.pettarget.debuffs.attachTo = "FRAME";
			E.db.unitframe.units.pettarget.debuffs.anchorPoint = "LEFT";
			-- E.db.unitframe.units.bodyguard.height = 38;
			-- E.db.unitframe.units.bodyguard.width = 135;
			E.db.unitframe.units.targettarget.height = 38;
			E.db.unitframe.units.targettarget.width = 135;
			E.db.unitframe.units.targettarget.debuffs.attachTo = "FRAME";
			E.db.unitframe.units.targettarget.debuffs.anchorPoint = "RIGHT";
			E.db.unitframe.units.targettargettarget.height = 38;
			E.db.unitframe.units.targettargettarget.width = 135;
			E.db.unitframe.units.targettargettarget.buffs.enable = true;
			E.db.unitframe.units.targettargettarget.debuffs.enable = true;
			E.db.unitframe.units.targettargettarget.debuffs.attachTo = "FRAME";
			E.db.unitframe.units.targettargettarget.debuffs.anchorPoint = "RIGHT";
			E.db.unitframe.units.target.portrait.camDistanceScale = 3;
			-- E.db.unitframe.units.target.combobar.height = 6;
			-- E.db.unitframe.units.target.combobar.detachedWidth = 100;
			-- E.db.unitframe.units.target.combobar.detachFromFrame = true;
			-- E.db.unitframe.units.target.combobar.fill = "fill";
			E.db.unitframe.units.target.power.position = "LEFT";
			E.db.unitframe.units.target.power.xOffset = 0;
			E.db.unitframe.units.target.power.yOffset = 0;
			E.db.unitframe.units.target.health.position = "RIGHT";
			E.db.unitframe.units.target.health.xOffset = 0;
			E.db.unitframe.units.target.health.yOffset = 0;
			E.db.unitframe.units.target.name.position = "CENTER";
			E.db.unitframe.units.target.name.xOffset = 0;
			E.db.unitframe.units.target.name.yOffset = 0;
			E.db.unitframe.units.target.buffs.enable = true;
			E.db.unitframe.units.target.buffs.yOffset = 0;
			E.db.unitframe.units.target.buffs.attachTo = "FRAME";
			E.db.unitframe.units.target.buffs.sizeOverride = 0;
			E.db.unitframe.units.target.buffs.sortDirection = "DESCENDING";
			E.db.unitframe.units.target.debuffs.yOffset = 0;
			E.db.unitframe.units.target.debuffs.enable = true;
			E.db.unitframe.units.target.debuffs.attachTo = "BUFFS";
			E.db.unitframe.units.target.debuffs.sortDirection = "DESCENDING";
			E.db.unitframe.units.target.debuffs.sizeOverride = 0;
			E.db.unitframe.units.target.height = 41;
			E.db.unitframe.units.target.width = 270;
			E.db.unitframe.units.target.aurabar.enable = true;
			E.db.unitframe.units.target.aurabar.attachTo = "DEBUFFS"
			E.db.unitframe.units.target.buffs.anchorPoint = "TOPRIGHT";
			E.db.unitframe.units.target.debuffs.anchorPoint = "TOPLEFT";
			E.db.unitframe.units.target.smartAuraDisplay = "DISABLED";
			E.db.unitframe.units.focus.width = 220;
			E.db.unitframe.units.focus.debuffs.anchorPoint = "TOPRIGHT";
			E.db.unitframe.units.focus.buffs.anchorPoint = "TOPLEFT";
			E.db.unitframe.units.focustarget.width = 95;
			E.db.unitframe.units.boss.portrait.camDistanceScale = 3;
			E.db.auras.buffs.growthDirection = "RIGHT_DOWN";
			E.db.auras.buffs.wrapAfter = 12;
			E.db.auras.debuffs.maxWraps = 1;
			E.db.auras.debuffs.growthDirection = "RIGHT_DOWN";
			E.db.auras.debuffs.wrapAfter = 12;
			E.db.datatexts.ActionBarPanels.ActionBarPanelTwo.Enabled = false;
			E.db.datatexts.ActionBarPanels.ActionBarPanelThree.Enabled = false;
			E.db.actionbar.bar3.buttonsPerRow = 12;
			E.db.actionbar.bar5.buttonsPerRow = 12;
			E.db.bags.xOffset = 0;
			E.db.bags.xOffsetBank = 1276;
			E.db.bags.yOffset = -23;
			E.db.bags.yOffsetBank = 390;
			E.db.bags.alignToChat = false;
			E.db.bags.bagWidth = 640;
			E.db.bags.bankWidth = 640;
			E.db.bags.bagBar.sortDirection = "ASCENDING";
			E.db.bags.bagBar.growthDirection = "HORIZONTAL";
			E.db.bags.bagBar.mouseover = true;
			E.db.chat.panelWidth = 407;
			E.db.chat.panelHeight = 137;
			E.db.unitframe.units.party.health.frequentUpdates = true;
			E.db.unitframe.units.party.health.text = true;
			E.db.unitframe.units.party.name.position = 'TOP';
			E.db.unitframe.units.party.roleIcon.enable = true;
			E.db.unitframe.units.party.healPrediction = true;
			E.db.unitframe.units.party.petsGroup.enable = true;
			E.db.unitframe.units.party.growthDirection = 'RIGHT_DOWN';
			E.db.unitframe.units.party.health.orientation = 'VERTICAL';
			E.db.unitframe.units.party.xOffset = 3;
			E.db.unitframe.units.party.health.text_format = "[healthcolor][health:deficit]"
			E.db.unitframe.units.party.health.position = 'BOTTOM';
			E.db.unitframe.units.party.name.position = 'TOP';
			E.db.unitframe.units.party.name.text_format = "[namecolor][name:medium]";
			E.db.unitframe.units.party.buffs.anchorPoint = 'TOPLEFT';
			E.db.unitframe.units.party.buffs.perrow = 3;
			E.db.unitframe.units.party.buffs.sizeOverride = 0;
			E.db.unitframe.units.party.debuffs.anchorPoint = 'BOTTOMRIGHT';
			E.db.unitframe.units.party.debuffs.perrow = 3;
			E.db.unitframe.units.party.debuffs.sizeOverride = 0;
			E.db.unitframe.units.party.debuffs.useFilter = 'Blacklist';
			E.db.unitframe.units.party.petsGroup.enable = true;
			E.db.unitframe.units.party.petsGroup.initialAnchor = 'BOTTOM';
			E.db.unitframe.units.party.petsGroup.anchorPoint = 'BOTTOM';
			E.db.unitframe.units.party.petsGroup.xOffset = 0;
			E.db.unitframe.units.party.petsGroup.yOffset = -26;
			E.db.unitframe.units.party.targetsGroup.enable = true;
			E.db.unitframe.units.party.targetsGroup.initialAnchor = 'TOP';
			E.db.unitframe.units.party.targetsGroup.anchorPoint = 'TOP';
			E.db.unitframe.units.party.targetsGroup.xOffset = 0;
			E.db.unitframe.units.party.targetsGroup.yOffset = 26;
			E.db.unitframe.units.party.petsGroup.width = 69;
			E.db.unitframe.units.party.targetsGroup.width = 69;
			E.db.unitframe.units.party.height = 46;
			E.db.unitframe.units.party.width = 69;
			E.db.unitframe.units.party.xOffset = 3;
			E.db.unitframe.units.party.horizontalSpacing = 3;
			E.db.unitframe.units.party.petsGroup.height = 30;
			E.db.unitframe.units.party.targetsGroup.height = 30;
			E.db.unitframe.units.raid.width = 69;
			E.db.unitframe.units.raid.height = 36;
			E.db.unitframe.units.raid40.width = 69;
			E.db.unitframe.units.raid40.height = 36;
			E.db.unitframe.units.raidpet.width = 69;
			E.db.unitframe.units.raidpet.height = 30;
			E.db.unitframe.units.raid.xOffset = 3;
			E.db.unitframe.units.raid.horizontalSpacing = 3;
			E.db.unitframe.units.raid40.xOffset = 3;
			E.db.unitframe.units.raid40.horizontalSpacing = 3;
			E.db.unitframe.units.raidpet.xOffset = 3;
			E.db.unitframe.units.raidpet.horizontalSpacing = 3;
			E.db.unitframe.units.raid.health.frequentUpdates = true;
			E.db.unitframe.units.raid.health.text = true;
			E.db.unitframe.units.raid.name.position = 'TOP';
			E.db.unitframe.units.raid.roleIcon.enable = true;
			E.db.unitframe.units.raid.healPrediction = true;
			E.db.unitframe.units.raid.health.orientation = 'VERTICAL';
		end

		if not E.db.movers then E.db.movers = {}; end
		 --Make sure we account for EyeFinity or other scenarious where ElvUIParent is not the same size as UIParent
		local xOffset = ((GetScreenWidth() - E.diffGetLeft - E.diffGetRight) * 0.34375)

		if E.PixelMode then
			E.db.movers.ElvUF_PlayerMover = "BOTTOMLEFTElvUIParentBOTTOM-450240"
			E.db.movers.ElvUF_TargetMover = "BOTTOMRIGHTElvUIParentBOTTOM450240"
			E.db.movers.ElvUF_PetMover = "LEFTElvUF_PlayerLEFT-1300"
			E.db.movers.ElvUF_PetTargetMover = "TOPElvUF_PetTOP040"
			E.db.movers.ElvUF_FocusMover = "BOTTOMLEFTElvUF_PlayerTOPLEFT0360"
			E.db.movers.ElvUF_TargetTargetMover = "BOTTOMElvUF_TargetBOTTOM0-66"
			E.db.movers.ElvUF_Raid40Mover = "BOTTOMElvUIParentBOTTOM0150"
			E.db.movers.ElvUF_RaidMover = "BOTTOMElvUIParentBOTTOM0150"
			E.db.movers.ElvUF_PartyMover = "BOTTOMElvUIParentBOTTOM0215"
			E.db.movers.TotemBarMover = "BOTTOMElvUF_PlayerBOTTOM-200-66"
			E.db.movers.ShiftAB = "BOTTOMElvUF_PlayerBOTTOM0-66"
			E.db.movers.PetAB = "BOTTOMElvUI_Bar1BOTTOM057"
			E.db.movers.BossButton = "CENTERElvUIParentCENTER1000"
			E.db.movers.ArenaHeaderMover = "BOTTOMRIGHTElvUF_TargetBOTTOMRIGHT60200"
			E.db.movers.BossHeaderMover = "BOTTOMRIGHTElvUF_TargetBOTTOMRIGHT60266"
			E.db.unitframe.units.party.health.frequentUpdates = true;
			E.db.unitframe.units.party.health.text = true;
			E.db.unitframe.units.party.name.position = 'TOP';
			E.db.unitframe.units.party.roleIcon.enable = true;
			E.db.unitframe.units.party.healPrediction = true;
			E.db.unitframe.units.party.petsGroup.enable = true;
			E.db.unitframe.units.party.growthDirection = 'RIGHT_DOWN';
			E.db.unitframe.units.party.health.orientation = 'VERTICAL';
			E.db.unitframe.units.party.xOffset = 3;
			E.db.unitframe.units.party.health.text_format = "[healthcolor][health:deficit]"
			E.db.unitframe.units.party.health.position = 'BOTTOM';
			E.db.unitframe.units.party.name.position = 'TOP';
			E.db.unitframe.units.party.name.text_format = "[namecolor][name:medium]";
			E.db.unitframe.units.party.buffs.anchorPoint = 'TOPLEFT';
			E.db.unitframe.units.party.buffs.perrow = 3;
			E.db.unitframe.units.party.buffs.sizeOverride = 0;
			E.db.unitframe.units.party.debuffs.anchorPoint = 'BOTTOMRIGHT';
			E.db.unitframe.units.party.debuffs.perrow = 3;
			E.db.unitframe.units.party.debuffs.sizeOverride = 0;
			E.db.unitframe.units.party.debuffs.useFilter = 'Blacklist';
			E.db.unitframe.units.party.petsGroup.enable = true;
			E.db.unitframe.units.party.petsGroup.initialAnchor = 'BOTTOM';
			E.db.unitframe.units.party.petsGroup.anchorPoint = 'BOTTOM';
			E.db.unitframe.units.party.petsGroup.xOffset = 0;
			E.db.unitframe.units.party.petsGroup.yOffset = -26;
			E.db.unitframe.units.pettarget.enable = false;
			E.db.unitframe.units.player.classbar.DetachFromFrame = true;
			-- E.db.unitframe.units.target.combobar.detachFromFrame = false;
			E.db.unitframe.units.party.targetsGroup.enable = true;
			E.db.unitframe.units.party.targetsGroup.initialAnchor = 'TOP';
			E.db.unitframe.units.party.targetsGroup.anchorPoint = 'TOP';
			E.db.unitframe.units.party.targetsGroup.xOffset = 0;
			E.db.unitframe.units.party.targetsGroup.yOffset = 26;
			E.db.unitframe.units.party.width = 69;
			E.db.unitframe.units.party.petsGroup.width = 69;
			E.db.unitframe.units.party.targetsGroup.width = 69;
			E.db.unitframe.units.party.height = 46;
			E.db.unitframe.units.party.petsGroup.height = 30;
			E.db.unitframe.units.party.targetsGroup.height = 30;
		elseif not E.db.lowresolutionset and (layout == 'nouveauheal') then
		end
	elseif E.db.lowresolutionset then
		if not E.db.movers then E.db.movers = {}; end
			E.db.movers.ElvUF_PlayerMover = "BOTTOMLEFTElvUIParentBOTTOM-450240"
			E.db.movers.ElvUF_TargetMover = "BOTTOMRIGHTElvUIParentBOTTOM450240"
			E.db.movers.ElvUF_PetMover = "LEFTElvUF_PlayerLEFT-1300"
			E.db.movers.ElvUF_PetTargetMover = "TOPElvUF_PetTOP040"
			E.db.movers.ElvUF_FocusMover = "BOTTOMLEFTElvUF_PlayerTOPLEFT0360"
			E.db.movers.ElvUF_TargetTargetMover = "BOTTOMElvUF_TargetBOTTOM0-66"
			E.db.movers.ElvUF_Raid40Mover = "BOTTOMElvUIParentBOTTOM0150"
			E.db.movers.ElvUF_RaidMover = "BOTTOMElvUIParentBOTTOM0150"
			E.db.movers.ElvUF_PartyMover = "BOTTOMElvUIParentBOTTOM0215"
			E.db.movers.TotemBarMover = "BOTTOMElvUF_PlayerBOTTOM-200-66"
			E.db.movers.ShiftAB = "BOTTOMElvUF_PlayerBOTTOM0-66"
			E.db.movers.PetAB = "BOTTOMElvUI_Bar1BOTTOM057"
			E.db.movers.BossButton = "CENTERElvUIParentCENTER1000"
			E.db.movers.ArenaHeaderMover = "BOTTOMRIGHTElvUF_TargetBOTTOMRIGHT60200"
			E.db.movers.BossHeaderMover = "BOTTOMRIGHTElvUF_TargetBOTTOMRIGHT60266"
			E.db.unitframe.units.party.health.frequentUpdates = true;
			E.db.unitframe.units.party.health.text = true;
			E.db.unitframe.units.party.name.position = 'TOP';
			E.db.unitframe.units.party.roleIcon.enable = true;
			E.db.unitframe.units.party.healPrediction = true;
			E.db.unitframe.units.party.petsGroup.enable = true;
			E.db.unitframe.units.party.growthDirection = 'RIGHT_DOWN';
			E.db.unitframe.units.party.health.orientation = 'VERTICAL';
			E.db.unitframe.units.party.xOffset = 3;
			E.db.unitframe.units.party.health.text_format = "[healthcolor][health:deficit]"
			E.db.unitframe.units.party.health.position = 'BOTTOM';
			E.db.unitframe.units.party.name.position = 'TOP';
			E.db.unitframe.units.party.name.text_format = "[namecolor][name:medium]";
			E.db.unitframe.units.party.buffs.anchorPoint = 'TOPLEFT';
			E.db.unitframe.units.party.buffs.perrow = 3;
			E.db.unitframe.units.party.buffs.sizeOverride = 0;
			E.db.unitframe.units.party.debuffs.anchorPoint = 'BOTTOMRIGHT';
			E.db.unitframe.units.party.debuffs.perrow = 3;
			E.db.unitframe.units.party.debuffs.sizeOverride = 0;
			E.db.unitframe.units.party.debuffs.useFilter = 'Blacklist';
			E.db.unitframe.units.party.petsGroup.enable = true;
			E.db.unitframe.units.party.petsGroup.initialAnchor = 'BOTTOM';
			E.db.unitframe.units.party.petsGroup.anchorPoint = 'BOTTOM';
			E.db.unitframe.units.party.petsGroup.xOffset = 0;
			E.db.unitframe.units.party.petsGroup.yOffset = -26;
			E.db.unitframe.units.pettarget.enable = false;
			E.db.unitframe.units.party.targetsGroup.enable = true;
			E.db.unitframe.units.party.targetsGroup.initialAnchor = 'TOP';
			E.db.unitframe.units.party.targetsGroup.anchorPoint = 'TOP';
			E.db.unitframe.units.party.targetsGroup.xOffset = 0;
			E.db.unitframe.units.party.targetsGroup.yOffset = 26;
			E.db.unitframe.units.party.width = 69;
			E.db.unitframe.units.party.petsGroup.width = 69;
			E.db.unitframe.units.party.targetsGroup.width = 69;
			E.db.unitframe.units.party.height = 46;
			E.db.unitframe.units.party.petsGroup.height = 30;
			E.db.unitframe.units.party.targetsGroup.height = 30;
	else
		if not noDataReset then
			E:ResetMovers('')
			E:SetupPixelPerfect(E.PixelMode, true)
		end
	end

	if layout == 'blizzard' then
		if not noDataReset then
			E.db.unitframe.fontSize = 11;
			E.db.unitframe.font = "AgencyFB Bold";
			E.db.chat.font = "AgencyFB Bold";
			E.db.chat.tabFontSize = 11;
			E.db.chat.tabFont = "AgencyFB Bold";
			E.db.tooltip.healthBar.height = 11;
			E.db.tooltip.healthBar.font = "AgencyFB Bold";
			E.db.datatexts.fontSize = 11;
			E.db.datatexts.font = "AgencyFB Bold";
			E.db.general.fontSize = 11;
			E.db.general.font = "AgencyFB Bold";
			E.db.actionbar.fontSize = 11;
			E.db.actionbar.font = "AgencyFB Bold";
			E.db.unitframe.fontSize = 11;
			E.db.unitframe.font = "AgencyFB Bold";
			E.db.chat.font = "AgencyFB Bold";
			E.db.chat.tabFontSize = 11;
			E.db.chat.tabFont = "AgencyFB Bold";
			E.db.tooltip.healthBar.height = 11;
			E.db.tooltip.healthBar.font = "AgencyFB Bold";
			E.db.datatexts.fontSize = 11;
			E.db.datatexts.font = "AgencyFB Bold";
			E.db.general.fontSize = 11;
			E.db.general.font = "AgencyFB Bold";
			E.db.actionbar.fontSize = 11;
			E.db.actionbar.font = "AgencyFB Bold";
			E.db.unitframe.units.player.portrait.camDistanceScale = 2.5;
			E.db.unitframe.units.player.classbar.detachedWidth = 100;
			E.db.unitframe.units.player.classbar.DetachFromFrame = true;
			E.db.unitframe.units.player.classbar.fill = "fill";
			E.db.unitframe.units.player.pvp.position = "TOPRIGHT";
			E.db.unitframe.units.player.aurabar.enable = false;
			E.db.unitframe.units.pettarget.width = 98;
			E.db.unitframe.units.target.portrait.camDistanceScale = 2.5;
			E.db.unitframe.units.target.aurabar.enable = false;
			E.db.unitframe.units.target.smartAuraDisplay = "DISABLED";
			E.db.unitframe.units.target.debuffs.anchorPoint = "BOTTOMLEFT";
			E.db.unitframe.units.target.buffs.anchorPoint = "BOTTOMRIGHT";
			E.db.unitframe.units.target.buffs.yOffset = -7;
			E.db.unitframe.units.focus.debuffs.anchorPoint = "BOTTOMRIGHT";
			E.db.unitframe.units.focus.buffs.anchorPoint = "BOTTOMLEFT";
			E.db.unitframe.units.boss.portrait.camDistanceScale = 2.5;
			E.db.unitframe.units.boss.portrait.rotation = 300;
			E.db.unitframe.units.targettargettarget.width = 98;
			E.db.auras.buffs.growthDirection = "LEFT_DOWN";
			E.db.auras.buffs.wrapAfter = 8;
			E.db.auras.debuffs.maxWraps = 2;
			E.db.auras.debuffs.growthDirection = "LEFT_DOWN";
			E.db.auras.debuffs.wrapAfter = 8;
			E.db.bags.xOffset = 0;
			E.db.bags.xOffsetBank = 0;
			E.db.bags.yOffset = 110;
			E.db.bags.yOffsetBank = 110;
			E.db.bags.alignToChat = true;
			E.db.bags.bagBar.mouseover = true;
		end
		if not E.db.movers then E.db.movers = {}; end
	end

	if layout == 'nouveaufull' then
		if not noDataReset then
			E.db.unitframe.fontSize = 12;
			E.db.unitframe.font = "AgencyFB Bold";
			E.db.chat.font = "AgencyFB Bold";
			E.db.chat.tabFontSize = 12;
			E.db.chat.tabFont = "AgencyFB Bold";
			E.db.tooltip.healthBar.height = 13;
			E.db.tooltip.healthBar.font = "AgencyFB Bold";
			E.db.datatexts.fontSize = 12;
			E.db.datatexts.font = "AgencyFB Bold";
			E.db.general.fontSize = 12;
			E.db.general.font = "AgencyFB Bold";
			E.db.databars.experience.mouseover = false;
			E.db.databars.reputation.mouseover = false;
			E.db.general.glossTex = "Aluminium";
			E.db.general.normTex = "Aluminium";
			E.db.actionbar.fontSize = 12;
			E.db.actionbar.font = "AgencyFB Bold";
			E.db.actionbar.bar3.mouseover = false;
			E.db.actionbar.bar4.mouseover = true;
			E.db.actionbar.bar5.mouseover = false;
			E.db.actionbar.bar3.buttonsPerRow = 6;
			E.db.actionbar.bar3.buttons = 12;
			E.db.actionbar.bar3.point = "TOPLEFT";
			E.db.actionbar.bar5.buttonsPerRow = 6;
			E.db.actionbar.bar5.buttons = 12;
			E.db.actionbar.bar5.point = "TOPLEFT";
			-- E.db.unitframe.units.player.portrait.camDistanceScale = 3;
			E.db.unitframe.units.player.classbar.height = 7;
			E.db.unitframe.units.player.classbar.detachedWidth = 100;
			E.db.unitframe.units.player.classbar.DetachFromFrame = true;
			E.db.unitframe.units.player.classbar.fill = "fill";
			E.db.unitframe.units.player.castbar.insideInfoPanel = false;
			E.db.unitframe.units.player.power.position = "RIGHT";
			E.db.unitframe.units.player.power.xOffset = -2;
			E.db.unitframe.units.player.power.yOffset = -1;
			E.db.unitframe.units.player.power.attachTextTo = "Health";
			E.db.unitframe.units.player.health.position = "LEFT";
			E.db.unitframe.units.player.health.xOffset = 5;
			E.db.unitframe.units.player.health.yOffset = -1;
			E.db.unitframe.units.player.health.attachTextTo = "Health";
			E.db.unitframe.units.player.name.position = "CENTER";
			E.db.unitframe.units.player.name.xOffset = 0;
			E.db.unitframe.units.player.name.yOffset = -1;
			E.db.unitframe.units.player.name.attachTextTo = "Health";
			E.db.unitframe.units.player.buffs.enable = true;
			E.db.unitframe.units.player.buffs.attachTo = "FRAME";
			E.db.unitframe.units.player.buffs.anchorPoint = "BOTTOMLEFT";
			E.db.unitframe.units.player.buffs.sortDirection = "ASCENDING";
			E.db.unitframe.units.player.buffs.sizeOverride = 30;
			E.db.unitframe.units.player.buffs.perrow = 8;
			E.db.unitframe.units.player.buffs.yOffset = 0;
			E.db.unitframe.units.player.debuffs.yOffset = 0;
			E.db.unitframe.units.player.debuffs.enable = true;
			E.db.unitframe.units.player.debuffs.attachTo = "BUFFS";
			E.db.unitframe.units.player.debuffs.anchorPoint = "BOTTOMLEFT";
			E.db.unitframe.units.player.debuffs.sortDirection = "DESCENDING";
			E.db.unitframe.units.player.debuffs.sizeOverride = 30;
			E.db.unitframe.units.player.debuffs.perrow = 7;
			E.db.unitframe.units.player.pvp.position = "TOP";
			E.db.unitframe.units.player.height = 48;
			E.db.unitframe.units.player.width = 300;
			E.db.unitframe.units.player.aurabar.enable = true;
			E.db.unitframe.units.player.aurabar.attachTo = "FRAME"
			E.db.unitframe.units.player.stagger.enable = true;
			E.db.unitframe.units.player.infoPanel.enable = true;
			E.db.unitframe.units.player.infoPanel.height = 7;
			-- E.db.unitframe.units.player.infoPanel.transparent = true;
			E.db.unitframe.units.pet.infoPanel.enable = true;
			E.db.unitframe.units.pet.infoPanel.height = 7;
			E.db.unitframe.units.pet.castbar.insideInfoPanel = false;
			E.db.unitframe.units.pet.height = 48;
			E.db.unitframe.units.pet.width = 80;
			E.db.unitframe.units.pet.buffs.enable = true;
			E.db.unitframe.units.pet.buffs.attachTo = "FRAME";
			E.db.unitframe.units.pet.buffs.anchorPoint = "TOPLEFT";
			E.db.unitframe.units.pet.buffs.sortDirection = "ASCENDING";
			E.db.unitframe.units.pet.buffs.sizeOverride = 0;
			E.db.unitframe.units.pet.buffs.perrow = 3;
			E.db.unitframe.units.pet.debuffs.enable = true;
			E.db.unitframe.units.pet.debuffs.attachTo = "BUFFS";
			E.db.unitframe.units.pet.debuffs.anchorPoint = "TOPRIGHT";
			E.db.unitframe.units.pet.debuffs.sortDirection = "DESCENDING";
			E.db.unitframe.units.pet.debuffs.sizeOverride = 0;
			E.db.unitframe.units.pet.debuffs.perrow = 3;
			E.db.unitframe.units.pet.name.position = "CENTER";
			E.db.unitframe.units.pet.name.xOffset = 0;
			E.db.unitframe.units.pet.name.yOffset = -1;
			E.db.unitframe.units.pet.name.attachTextTo = "Health";
			E.db.unitframe.units.pettarget.infoPanel.enable = true;
			E.db.unitframe.units.pettarget.infoPanel.height = 7;
			E.db.unitframe.units.pettarget.height = 48;
			E.db.unitframe.units.pettarget.width = 80;
			E.db.unitframe.units.pettarget.buffs.enable = false;
			E.db.unitframe.units.pettarget.debuffs.enable = false;
			E.db.unitframe.units.pettarget.name.position = "CENTER";
			E.db.unitframe.units.pettarget.name.xOffset = 0;
			E.db.unitframe.units.pettarget.name.yOffset = -1;
			E.db.unitframe.units.pettarget.name.attachTextTo = "Health";
			E.db.unitframe.units.targettarget.infoPanel.enable = true;
			E.db.unitframe.units.targettarget.infoPanel.height = 7;
			E.db.unitframe.units.targettarget.height = 48;
			E.db.unitframe.units.targettarget.width = 80;
			E.db.unitframe.units.targettarget.buffs.enable = true;
			E.db.unitframe.units.targettarget.buffs.attachTo = "FRAME";
			E.db.unitframe.units.targettarget.buffs.anchorPoint = "TOPRIGHT";
			E.db.unitframe.units.targettarget.buffs.sortDirection = "ASCENDING";
			E.db.unitframe.units.targettarget.buffs.sizeOverride = 0;
			E.db.unitframe.units.targettarget.buffs.perrow = 3;	
			E.db.unitframe.units.targettarget.debuffs.enable = true;
			E.db.unitframe.units.targettarget.debuffs.attachTo = "BUFFS";
			E.db.unitframe.units.targettarget.debuffs.anchorPoint = "TOPLEFT";
			E.db.unitframe.units.targettarget.debuffs.sortDirection = "DESCENDING";
			E.db.unitframe.units.targettarget.debuffs.sizeOverride = 0;
			E.db.unitframe.units.targettarget.debuffs.perrow = 3;
			E.db.unitframe.units.targettarget.name.position = "CENTER";
			E.db.unitframe.units.targettarget.name.xOffset = 0;
			E.db.unitframe.units.targettarget.name.yOffset = -1;
			E.db.unitframe.units.targettarget.name.attachTextTo = "Health";
			E.db.unitframe.units.targettargettarget.infoPanel.enable = true;
			E.db.unitframe.units.targettargettarget.infoPanel.height = 7;
			E.db.unitframe.units.targettargettarget.height = 48;
			E.db.unitframe.units.targettargettarget.width = 80;
			E.db.unitframe.units.targettargettarget.buffs.enable = false;
			E.db.unitframe.units.targettargettarget.debuffs.enable = false;
			E.db.unitframe.units.targettargettarget.name.position = "CENTER";
			E.db.unitframe.units.targettargettarget.name.xOffset = 0;
			E.db.unitframe.units.targettargettarget.name.yOffset = -1;
			E.db.unitframe.units.targettargettarget.name.attachTextTo = "Health";
			E.db.unitframe.units.boss.height = 40;
			E.db.unitframe.units.boss.width = 240;
			E.db.unitframe.units.boss.spacing = 52;
			E.db.unitframe.units.boss.castbar.height = 20;
			E.db.unitframe.units.boss.castbar.width = 240;
			E.db.unitframe.units.boss.health.yOffset = 2;
			E.db.unitframe.units.boss.raidicon.attachTo	= "LEFT";
			E.db.unitframe.units.boss.raidicon.yOffset = 0;
			E.db.unitframe.units.boss.buffs.enable = true;
			E.db.unitframe.units.boss.buffs.attachTo = "FRAME";
			E.db.unitframe.units.boss.buffs.anchorPoint = "TOPRIGHT";
			E.db.unitframe.units.boss.buffs.sortDirection = "ASCENDING";
			E.db.unitframe.units.boss.buffs.sizeOverride = 29;
			E.db.unitframe.units.boss.buffs.perrow = 4;
			E.db.unitframe.units.boss.buffs.xOffset = 0;
			E.db.unitframe.units.boss.debuffs.enable = true;
			E.db.unitframe.units.boss.debuffs.attachTo = "FRAME";
			E.db.unitframe.units.boss.debuffs.anchorPoint = "TOPLEFT";
			E.db.unitframe.units.boss.debuffs.sortDirection = "DESCENDING";
			E.db.unitframe.units.boss.debuffs.sizeOverride = 29;
			E.db.unitframe.units.boss.debuffs.perrow = 4;
			E.db.unitframe.units.boss.debuffs.xOffset = 0;
			E.db.unitframe.units.boss.portrait.camDistanceScale = 3;
			E.db.unitframe.units.boss.infoPanel.enable = true;
			E.db.unitframe.units.boss.infoPanel.height = 7;
			E.db.unitframe.units.boss.castbar.insideInfoPanel = false;
			E.db.unitframe.units.arena.height = 40;
			E.db.unitframe.units.arena.width = 240;
			E.db.unitframe.units.arena.spacing = 52;
			E.db.unitframe.units.arena.infoPanel.enable = true;
			E.db.unitframe.units.arena.infoPanel.height = 7;
			E.db.unitframe.units.arena.castbar.insideInfoPanel = false;
			E.db.unitframe.units.arena.castbar.height = 20;
			E.db.unitframe.units.arena.castbar.width = 240;
			E.db.unitframe.units.arena.health.yOffset = 2;
			E.db.unitframe.units.arena.buffs.enable = true;
			E.db.unitframe.units.arena.buffs.attachTo = "FRAME";
			E.db.unitframe.units.arena.buffs.anchorPoint = "TOPRIGHT";
			E.db.unitframe.units.arena.buffs.sortDirection = "ASCENDING";
			E.db.unitframe.units.arena.buffs.sizeOverride = 29;
			E.db.unitframe.units.arena.buffs.perrow = 4;
			E.db.unitframe.units.arena.buffs.xOffset = 0;
			E.db.unitframe.units.arena.debuffs.enable = true;
			E.db.unitframe.units.arena.debuffs.attachTo = "FRAME";
			E.db.unitframe.units.arena.debuffs.anchorPoint = "TOPLEFT";
			E.db.unitframe.units.arena.debuffs.sortDirection = "DESCENDING";
			E.db.unitframe.units.arena.debuffs.sizeOverride = 29;
			E.db.unitframe.units.arena.debuffs.perrow = 4;
			E.db.unitframe.units.arena.debuffs.xOffset = 0;
			E.db.unitframe.units.arena.portrait.camDistanceScale = 3;
			-- E.db.unitframe.units.target.portrait.camDistanceScale = 3;
			-- E.db.unitframe.units.target.combobar.height = 7;
			-- E.db.unitframe.units.target.combobar.detachedWidth = 100;
			-- E.db.unitframe.units.target.combobar.detachFromFrame = true;
			-- E.db.unitframe.units.target.combobar.fill = "fill";
			E.db.unitframe.units.target.power.position = "LEFT";
			E.db.unitframe.units.target.power.xOffset = 3;
			E.db.unitframe.units.target.power.yOffset = -1;
			E.db.unitframe.units.target.power.attachTextTo = "Health";
			E.db.unitframe.units.target.health.position = "RIGHT";
			E.db.unitframe.units.target.health.xOffset = -2;
			E.db.unitframe.units.target.health.yOffset = -1;
			E.db.unitframe.units.target.health.attachTextTo = "Health";
			E.db.unitframe.units.target.name.position = "CENTER";
			E.db.unitframe.units.target.name.xOffset = 0;
			E.db.unitframe.units.target.name.yOffset = -1;
			E.db.unitframe.units.target.name.attachTextTo = "Health";
			E.db.unitframe.units.target.buffs.enable = true;
			E.db.unitframe.units.target.buffs.attachTo = "FRAME";
			E.db.unitframe.units.target.buffs.anchorPoint = "BOTTOMRIGHT";
			E.db.unitframe.units.target.buffs.sortDirection = "ASCENDING";
			E.db.unitframe.units.target.buffs.sizeOverride = 30;
			E.db.unitframe.units.target.buffs.perrow = 8;
			E.db.unitframe.units.target.buffs.yOffset = 0;
			E.db.unitframe.units.target.debuffs.yOffset = 0;
			E.db.unitframe.units.target.debuffs.enable = true;
			E.db.unitframe.units.target.debuffs.attachTo = "BUFFS";
			E.db.unitframe.units.target.debuffs.anchorPoint = "BOTTOMRIGHT";
			E.db.unitframe.units.target.debuffs.sortDirection = "DESCENDING";
			E.db.unitframe.units.target.debuffs.sizeOverride = 30;
			E.db.unitframe.units.target.debuffs.perrow = 7;
			E.db.unitframe.units.target.height = 48;
			E.db.unitframe.units.target.width = 300;
			E.db.unitframe.units.target.aurabar.enable = true;
			E.db.unitframe.units.target.aurabar.attachTo = "FRAME";
			E.db.unitframe.units.target.smartAuraDisplay = "DISABLED";
			E.db.unitframe.units.target.infoPanel.enable = true;
			E.db.unitframe.units.target.infoPanel.height = 7;
			E.db.unitframe.units.target.castbar.insideInfoPanel = false;
			E.db.unitframe.units.focus.height = 48;
			E.db.unitframe.units.focus.width = 220;
			E.db.unitframe.units.focus.debuffs.anchorPoint = "TOPRIGHT";
			E.db.unitframe.units.focus.buffs.anchorPoint = "TOPLEFT";
			E.db.unitframe.units.focus.infoPanel.enable = true;
			E.db.unitframe.units.focus.infoPanel.height = 7;
			E.db.unitframe.units.focus.castbar.insideInfoPanel = false;
			E.db.unitframe.units.focus.power.position = "RIGHT";
			E.db.unitframe.units.focus.power.xOffset = 1;
			E.db.unitframe.units.focus.power.yOffset = -1;
			E.db.unitframe.units.focus.power.attachTextTo = "Health";
			E.db.unitframe.units.focus.health.position = "LEFT";
			E.db.unitframe.units.focus.health.xOffset = 5;
			E.db.unitframe.units.focus.health.yOffset = -1;
			E.db.unitframe.units.focus.health.attachTextTo = "Health";
			E.db.unitframe.units.focus.name.position = "CENTER";
			E.db.unitframe.units.focus.name.xOffset = 0;
			E.db.unitframe.units.focus.name.yOffset = -1;
			E.db.unitframe.units.focus.name.attachTextTo = "Health";
			E.db.unitframe.units.focustarget.height = 48;
			E.db.unitframe.units.focustarget.width = 95;
			E.db.unitframe.units.focustarget.infoPanel.enable = true;
			E.db.unitframe.units.focustarget.infoPanel.height = 7;
			E.db.unitframe.units.focustarget.name.position = "CENTER";
			E.db.unitframe.units.focustarget.name.xOffset = 0;
			E.db.unitframe.units.focustarget.name.yOffset = -1;
			E.db.unitframe.units.focustarget.name.attachTextTo = "Health";
			E.db.unitframe.units.party.height = 40;
			E.db.unitframe.units.party.petsGroup.height = 40;
			E.db.unitframe.units.party.targetsGroup.height = 40;
			E.db.unitframe.units.party.infoPanel.enable = true;
			E.db.unitframe.units.party.infoPanel.height = 7;
			E.db.unitframe.units.party.rdebuffs.fontSize = 12;
			E.db.unitframe.units.party.rdebuffs.size = 18;
			E.db.unitframe.units.party.roleIcon.yOffset = 3;
			E.db.unitframe.units.raid.infoPanel.enable = true;
			E.db.unitframe.units.raid.infoPanel.height = 7;
			E.db.unitframe.units.raid.rdebuffs.fontSize = 12;
			E.db.unitframe.units.raid.rdebuffs.size = 18;
			E.db.unitframe.units.raid.roleIcon.yOffset = 3;
			E.db.unitframe.units.raid.name.position = "CENTER";
			E.db.unitframe.units.raid.name.xOffset = 0;
			E.db.unitframe.units.raid.name.yOffset = 5;
			E.db.unitframe.units.raid.name.attachTextTo = "Health";
			E.db.unitframe.units.raid40.infoPanel.enable = true;
			E.db.unitframe.units.raid40.infoPanel.height = 7;
			E.db.unitframe.units.raid40.rdebuffs.fontSize = 12;
			E.db.unitframe.units.raid40.rdebuffs.size = 18;
			E.db.unitframe.units.raid40.roleIcon.yOffset = 3;
			E.db.unitframe.units.raid40.name.position = "CENTER";
			E.db.unitframe.units.raid40.name.xOffset = 0;
			E.db.unitframe.units.raid40.name.yOffset = 5;
			E.db.unitframe.units.raid40.name.attachTextTo = "Health";
			E.db.unitframe.units.raidpet.rdebuffs.fontSize = 12;
			E.db.unitframe.units.raidpet.rdebuffs.size = 18;
			E.db.unitframe.units.raidpet.numGroups = 3;
			E.db.unitframe.units.raidpet.name.position = "CENTER";
			E.db.unitframe.units.raidpet.name.xOffset = 0;
			E.db.unitframe.units.raidpet.name.yOffset = 4;
			E.db.unitframe.units.raidpet.name.attachTextTo = "Health";
			E.db.auras.buffs.growthDirection = "RIGHT_DOWN";
			E.db.auras.buffs.wrapAfter = 12;
			E.db.auras.debuffs.maxWraps = 1;
			E.db.auras.debuffs.growthDirection = "RIGHT_DOWN";
			E.db.auras.debuffs.wrapAfter = 12;
			E.db.datatexts.ActionBarPanels.ActionBarPanelTwo.Enabled = false;
			E.db.datatexts.ActionBarPanels.ActionBarPanelThree.Enabled = false;
			E.db.datatexts.ActionBarPanels.TopPanel.Enabled = false;
			E.db.datatexts.ActionBarPanels.BottomPanel.Enabled = false;
			E.db.datatexts.ActionBarPanels.TopPanel.Height = 14;
			E.db.datatexts.ActionBarPanels.BottomPanel.Height = 14;
			E.db.datatexts.Backgrounds.LeftBG.Enabled = true;
			E.db.datatexts.Backgrounds.LeftBG.XOff = -56;
			E.db.datatexts.Backgrounds.LeftBG.Height = 82;
			E.db.datatexts.Backgrounds.LeftBG.PetHide = true;
			E.db.datatexts.Backgrounds.LeftBG.YOff = 11;
			E.db.datatexts.Backgrounds.LeftBG.Width = 640;
			E.db.datatexts.Backgrounds.RightBG.Enabled = true;
			E.db.datatexts.Backgrounds.RightBG.XOff = 56;
			E.db.datatexts.Backgrounds.RightBG.Height = 82;
			E.db.datatexts.Backgrounds.RightBG.PetHide = true;
			E.db.datatexts.Backgrounds.RightBG.YOff = 11;
			E.db.datatexts.Backgrounds.RightBG.Width = 640;
			E.db.datatexts.Backgrounds.BottomBG.PetHide = true;
			E.db.datatexts.Backgrounds.BottomBG.Height = 100;
			E.db.datatexts.Backgrounds.BottomBG.YOff = 3;
			E.db.datatexts.Backgrounds.BottomBG.Enabled = true;
			E.db.datatexts.Backgrounds.BottomBG.Width = 440;
			E.db.bags.alignToChat = false;
			E.db.bags.xOffsetBank = 984;
			E.db.bags.yOffsetBank = -31;
			E.db.bags.xOffset = 5;
			E.db.bags.yOffset = 112;
			E.db.bags.bagWidth = 424;
			E.db.bags.bankWidth = 500;
			E.db.chat.panelWidth = 407;
			E.db.chat.panelHeight = 142;
			E.db.chat.panelHeightRight = 142;
		end
		if not E.db.movers then E.db.movers = {}; end
	end

	if layout == 'nouveauphys' then
		if not noDataReset then
			E.db.unitframe.fontSize = 12;
			E.db.unitframe.font = "AgencyFB Bold";
			E.db.chat.font = "AgencyFB Bold";
			E.db.chat.tabFontSize = 12;
			E.db.chat.tabFont = "AgencyFB Bold";
			E.db.tooltip.healthBar.height = 13;
			E.db.tooltip.healthBar.font = "AgencyFB Bold";
			E.db.datatexts.fontSize = 12;
			E.db.datatexts.font = "AgencyFB Bold";
			E.db.general.fontSize = 12;
			E.db.general.font = "AgencyFB Bold";
			E.db.general.glossTex = "Aluminium";
			E.db.general.normTex = "Aluminium";
			E.db.actionbar.fontSize = 12;
			E.db.actionbar.font = "AgencyFB Bold";
			E.db.actionbar.bar1.backdrop = false;
			E.db.actionbar.bar2.backdrop = false;
			E.db.actionbar.bar3.backdrop = false;
			E.db.actionbar.bar4.backdrop = false;
			E.db.actionbar.bar5.backdrop = false;
			E.db.actionbar.barPet.backdrop = false;
			E.db.actionbar.stanceBar.backdrop = false;
			E.db.actionbar.bar1.showGrid = true;
			E.db.actionbar.bar2.showGrid = true;
			E.db.actionbar.bar3.showGrid = true;
			E.db.actionbar.bar4.showGrid = true;
			E.db.actionbar.bar5.showGrid = true;
			E.db.actionbar.bar3.mouseover = false;
			E.db.actionbar.bar4.mouseover = true;
			E.db.actionbar.bar5.mouseover = false;
			E.db.actionbar.bar1.buttonspacing = 1;
			E.db.actionbar.bar2.buttonspacing = 1;
			E.db.actionbar.bar3.buttonspacing = 1;
			E.db.actionbar.bar4.buttonspacing = 1;
			E.db.actionbar.bar5.buttonspacing = 1;
			E.db.actionbar.barPet.buttonspacing = 1;
			E.db.unitframe.units.player.portrait.camDistanceScale = 3;
			E.db.unitframe.units.player.classbar.height = 6;
			E.db.unitframe.units.player.classbar.detachedWidth = 100;
			E.db.unitframe.units.player.classbar.DetachFromFrame = true;
			E.db.unitframe.units.player.classbar.fill = "fill";
			E.db.unitframe.units.player.power.position = "RIGHT";
			E.db.unitframe.units.player.power.xOffset = -2;
			E.db.unitframe.units.player.power.yOffset = 0;
			E.db.unitframe.units.player.health.position = "LEFT";
			E.db.unitframe.units.player.health.xOffset = 5;
			E.db.unitframe.units.player.health.yOffset = 0;
			E.db.unitframe.units.player.name.position = "CENTER";
			E.db.unitframe.units.player.name.xOffset = 0;
			E.db.unitframe.units.player.name.yOffset = 0;
			E.db.unitframe.units.player.buffs.enable = true;
			E.db.unitframe.units.player.buffs.attachTo = "FRAME";
			E.db.unitframe.units.player.buffs.anchorPoint = "BOTTOMLEFT";
			E.db.unitframe.units.player.buffs.sortDirection = "ASCENDING";
			E.db.unitframe.units.player.buffs.sizeOverride = 30;
			E.db.unitframe.units.player.buffs.perrow = 8;
			E.db.unitframe.units.player.buffs.yOffset = 0;
			E.db.unitframe.units.player.debuffs.yOffset = 0;
			E.db.unitframe.units.player.debuffs.enable = true;
			E.db.unitframe.units.player.debuffs.attachTo = "BUFFS";
			E.db.unitframe.units.player.debuffs.anchorPoint = "BOTTOMLEFT";
			E.db.unitframe.units.player.debuffs.sortDirection = "DESCENDING";
			E.db.unitframe.units.player.debuffs.sizeOverride = 30;
			E.db.unitframe.units.player.debuffs.perrow = 7;
			E.db.unitframe.units.player.pvp.position = "TOP";
			E.db.unitframe.units.player.height = 40;
			E.db.unitframe.units.player.width = 300;
			E.db.unitframe.units.player.aurabar.enable = true;
			E.db.unitframe.units.player.aurabar.attachTo = "FRAME"
			E.db.unitframe.units.player.stagger.enable = true;
			E.db.unitframe.units.pet.height = 40;
			E.db.unitframe.units.pet.width = 80;
			E.db.unitframe.units.pet.buffs.enable = true;
			E.db.unitframe.units.pet.buffs.attachTo = "FRAME";
			E.db.unitframe.units.pet.buffs.anchorPoint = "TOPLEFT";
			E.db.unitframe.units.pet.buffs.sortDirection = "ASCENDING";
			E.db.unitframe.units.pet.buffs.sizeOverride = 0;
			E.db.unitframe.units.pet.buffs.perrow = 3;
			E.db.unitframe.units.pet.debuffs.enable = true;
			E.db.unitframe.units.pet.debuffs.attachTo = "BUFFS";
			E.db.unitframe.units.pet.debuffs.anchorPoint = "TOPRIGHT";
			E.db.unitframe.units.pet.debuffs.sortDirection = "DESCENDING";
			E.db.unitframe.units.pet.debuffs.sizeOverride = 0;
			E.db.unitframe.units.pet.debuffs.perrow = 3;
			E.db.unitframe.units.pettarget.height = 40;
			E.db.unitframe.units.pettarget.width = 80;
			E.db.unitframe.units.pettarget.buffs.enable = true;
			E.db.unitframe.units.pettarget.buffs.attachTo = "FRAME";
			E.db.unitframe.units.pettarget.buffs.anchorPoint = "BOTTOMLEFT";
			E.db.unitframe.units.pettarget.buffs.sortDirection = "ASCENDING";
			E.db.unitframe.units.pettarget.buffs.sizeOverride = 0;
			E.db.unitframe.units.pettarget.buffs.perrow = 3;
			E.db.unitframe.units.pettarget.debuffs.enable = true;
			E.db.unitframe.units.pettarget.debuffs.attachTo = "BUFFS";
			E.db.unitframe.units.pettarget.debuffs.anchorPoint = "BOTTOMLEFT";
			E.db.unitframe.units.pettarget.debuffs.sortDirection = "DESCENDING";
			E.db.unitframe.units.pettarget.debuffs.sizeOverride = 0;
			E.db.unitframe.units.pettarget.debuffs.perrow = 3;
			-- E.db.unitframe.units.bodyguard.height = 40;
			-- E.db.unitframe.units.bodyguard.width = 80;
			E.db.unitframe.units.targettarget.height = 40;
			E.db.unitframe.units.targettarget.width = 80;
			E.db.unitframe.units.targettarget.buffs.enable = true;
			E.db.unitframe.units.targettarget.buffs.attachTo = "FRAME";
			E.db.unitframe.units.targettarget.buffs.anchorPoint = "TOPRIGHT";
			E.db.unitframe.units.targettarget.buffs.sortDirection = "ASCENDING";
			E.db.unitframe.units.targettarget.buffs.sizeOverride = 0;
			E.db.unitframe.units.targettarget.buffs.perrow = 3;	
			E.db.unitframe.units.targettarget.debuffs.enable = true;
			E.db.unitframe.units.targettarget.debuffs.attachTo = "BUFFS";
			E.db.unitframe.units.targettarget.debuffs.anchorPoint = "TOPLEFT";
			E.db.unitframe.units.targettarget.debuffs.sortDirection = "DESCENDING";
			E.db.unitframe.units.targettarget.debuffs.sizeOverride = 0;
			E.db.unitframe.units.targettarget.debuffs.perrow = 3;
			E.db.unitframe.units.targettargettarget.height = 40;
			E.db.unitframe.units.targettargettarget.width = 80;
			E.db.unitframe.units.targettargettarget.buffs.enable = true;
			E.db.unitframe.units.targettargettarget.buffs.attachTo = "FRAME";
			E.db.unitframe.units.targettargettarget.buffs.anchorPoint = "BOTTOMRIGHT";
			E.db.unitframe.units.targettargettarget.buffs.sortDirection = "ASCENDING";
			E.db.unitframe.units.targettargettarget.buffs.sizeOverride = 0;
			E.db.unitframe.units.targettargettarget.buffs.perrow = 3;
			E.db.unitframe.units.targettargettarget.debuffs.enable = true;
			E.db.unitframe.units.targettargettarget.debuffs.attachTo = "BUFFS";
			E.db.unitframe.units.targettargettarget.debuffs.anchorPoint = "BOTTOMLEFT";
			E.db.unitframe.units.targettargettarget.debuffs.sortDirection = "DESCENDING";
			E.db.unitframe.units.targettargettarget.debuffs.sizeOverride = 0;
			E.db.unitframe.units.targettargettarget.debuffs.perrow = 3;
			E.db.unitframe.units.boss.height = 26;
			E.db.unitframe.units.boss.width = 192;
			E.db.unitframe.units.boss.spacing = 24;
			E.db.unitframe.units.boss.castbar.height = 18;
			E.db.unitframe.units.boss.castbar.width = 192;
			E.db.unitframe.units.boss.health.yOffset = 0;
			E.db.unitframe.units.boss.raidicon.attachTo	= "LEFT";
			E.db.unitframe.units.boss.raidicon.yOffset = 0;
			E.db.unitframe.units.boss.buffs.enable = true;
			E.db.unitframe.units.boss.buffs.attachTo = "FRAME";
			E.db.unitframe.units.boss.buffs.anchorPoint = "TOPRIGHT";
			E.db.unitframe.units.boss.buffs.sortDirection = "ASCENDING";
			E.db.unitframe.units.boss.buffs.sizeOverride = 23;
			E.db.unitframe.units.boss.buffs.perrow = 4;
			E.db.unitframe.units.boss.buffs.xOffset = 0;
			E.db.unitframe.units.boss.debuffs.enable = true;
			E.db.unitframe.units.boss.debuffs.attachTo = "FRAME";
			E.db.unitframe.units.boss.debuffs.anchorPoint = "TOPLEFT";
			E.db.unitframe.units.boss.debuffs.sortDirection = "DESCENDING";
			E.db.unitframe.units.boss.debuffs.sizeOverride = 23;
			E.db.unitframe.units.boss.debuffs.perrow = 4;
			E.db.unitframe.units.boss.debuffs.xOffset = 0;
			E.db.unitframe.units.boss.portrait.camDistanceScale = 3;
			E.db.unitframe.units.arena.height = 26;
			E.db.unitframe.units.arena.width = 192;
			E.db.unitframe.units.arena.spacing = 24;
			E.db.unitframe.units.arena.castbar.height = 18;
			E.db.unitframe.units.arena.castbar.width = 192;
			E.db.unitframe.units.arena.health.yOffset = 0;
			E.db.unitframe.units.arena.buffs.enable = true;
			E.db.unitframe.units.arena.buffs.attachTo = "FRAME";
			E.db.unitframe.units.arena.buffs.anchorPoint = "TOPRIGHT";
			E.db.unitframe.units.arena.buffs.sortDirection = "ASCENDING";
			E.db.unitframe.units.arena.buffs.sizeOverride = 23;
			E.db.unitframe.units.arena.buffs.perrow = 4;
			E.db.unitframe.units.arena.buffs.xOffset = 0;
			E.db.unitframe.units.arena.debuffs.enable = true;
			E.db.unitframe.units.arena.debuffs.attachTo = "FRAME";
			E.db.unitframe.units.arena.debuffs.anchorPoint = "TOPLEFT";
			E.db.unitframe.units.arena.debuffs.sortDirection = "DESCENDING";
			E.db.unitframe.units.arena.debuffs.sizeOverride = 23;
			E.db.unitframe.units.arena.debuffs.perrow = 4;
			E.db.unitframe.units.arena.debuffs.xOffset = 0;
			E.db.unitframe.units.arena.portrait.camDistanceScale = 3;
			E.db.unitframe.units.target.portrait.camDistanceScale = 3;
			-- E.db.unitframe.units.target.combobar.height = 6;
			-- E.db.unitframe.units.target.combobar.detachedWidth = 100;
			-- E.db.unitframe.units.target.combobar.detachFromFrame = true;
			-- E.db.unitframe.units.target.combobar.fill = "fill";
			E.db.unitframe.units.target.power.position = "LEFT";
			E.db.unitframe.units.target.power.xOffset = 3;
			E.db.unitframe.units.target.power.yOffset = 0;
			E.db.unitframe.units.target.health.position = "RIGHT";
			E.db.unitframe.units.target.health.xOffset = -2;
			E.db.unitframe.units.target.health.yOffset = 0;
			E.db.unitframe.units.target.name.position = "CENTER";
			E.db.unitframe.units.target.name.xOffset = 0;
			E.db.unitframe.units.target.name.yOffset = 0;
			E.db.unitframe.units.target.buffs.enable = true;
			E.db.unitframe.units.target.buffs.attachTo = "FRAME";
			E.db.unitframe.units.target.buffs.anchorPoint = "BOTTOMRIGHT";
			E.db.unitframe.units.target.buffs.sortDirection = "ASCENDING";
			E.db.unitframe.units.target.buffs.sizeOverride = 30;
			E.db.unitframe.units.target.buffs.perrow = 8;
			E.db.unitframe.units.target.buffs.yOffset = 0;
			E.db.unitframe.units.target.debuffs.yOffset = 0;
			E.db.unitframe.units.target.debuffs.enable = true;
			E.db.unitframe.units.target.debuffs.attachTo = "BUFFS";
			E.db.unitframe.units.target.debuffs.anchorPoint = "BOTTOMRIGHT";
			E.db.unitframe.units.target.debuffs.sortDirection = "DESCENDING";
			E.db.unitframe.units.target.debuffs.sizeOverride = 30;
			E.db.unitframe.units.target.debuffs.perrow = 7;
			E.db.unitframe.units.target.height = 40;
			E.db.unitframe.units.target.width = 300;
			E.db.unitframe.units.target.aurabar.enable = true;
			E.db.unitframe.units.target.aurabar.attachTo = "FRAME";
			E.db.unitframe.units.target.smartAuraDisplay = "DISABLED";
			E.db.unitframe.units.focus.width = 192;
			E.db.unitframe.units.focus.debuffs.anchorPoint = "TOPRIGHT";
			E.db.unitframe.units.focus.buffs.anchorPoint = "TOPLEFT";
			E.db.unitframe.units.focustarget.width = 80;
			E.db.auras.buffs.growthDirection = "RIGHT_DOWN";
			E.db.auras.buffs.wrapAfter = 12;
			E.db.auras.debuffs.maxWraps = 1;
			E.db.auras.debuffs.growthDirection = "RIGHT_DOWN";
			E.db.auras.debuffs.wrapAfter = 12;
			E.db.datatexts.ActionBarPanels.ActionBarPanelTwo.Enabled = false;
			E.db.datatexts.ActionBarPanels.ActionBarPanelThree.Enabled = false;
			E.db.actionbar.bar3.buttonsPerRow = 12;
			E.db.actionbar.bar5.buttonsPerRow = 12;
			E.db.bags.alignToChat = false;
			E.db.bags.xOffsetBank = 986;
			E.db.bags.yOffsetBank = -24;
			E.db.bags.xOffset = 0;
			E.db.bags.yOffset = 113;
			E.db.bags.bagWidth = 407;
			E.db.bags.bankWidth = 520;
			E.db.chat.panelWidth = 407;
			E.db.chat.panelWidthRight = 407;
			E.db.chat.panelHeight = 94;
			E.db.chat.panelHeightRight = 94;
		end
		if not E.db.movers then E.db.movers = {}; end
	end

	if layout == 'nouveaucast' then
		if not noDataReset then
			E.db.unitframe.fontSize = 12;
			E.db.unitframe.font = "AgencyFB Bold";
			E.db.chat.font = "AgencyFB Bold";
			E.db.chat.tabFontSize = 12;
			E.db.chat.tabFont = "AgencyFB Bold";
			E.db.tooltip.healthBar.height = 13;
			E.db.tooltip.healthBar.font = "AgencyFB Bold";
			E.db.datatexts.fontSize = 12;
			E.db.datatexts.font = "AgencyFB Bold";
			E.db.general.fontSize = 12;
			E.db.general.font = "AgencyFB Bold";
			E.db.databars.experience.mouseover = false;
			E.db.databars.reputation.mouseover = false;
			E.db.actionbar.fontSize = 12;
			E.db.actionbar.font = "AgencyFB Bold";
			E.db.unitframe.units.player.portrait.camDistanceScale = 3;
			E.db.unitframe.units.player.classbar.height = 6;
			E.db.unitframe.units.player.classbar.detachedWidth = 100;
			E.db.unitframe.units.player.classbar.DetachFromFrame = true;
			E.db.unitframe.units.player.classbar.fill = "fill";
			E.db.unitframe.units.player.power.position = "RIGHT";
			E.db.unitframe.units.player.power.xOffset = -2;
			E.db.unitframe.units.player.power.yOffset = -1;
			E.db.unitframe.units.player.health.position = "LEFT";
			E.db.unitframe.units.player.health.xOffset = 5;
			E.db.unitframe.units.player.health.yOffset = -1;
			E.db.unitframe.units.player.name.position = "CENTER";
			E.db.unitframe.units.player.name.xOffset = 0;
			E.db.unitframe.units.player.name.yOffset = -1;
			E.db.unitframe.units.player.buffs.enable = true;
			E.db.unitframe.units.player.buffs.attachTo = "FRAME";
			E.db.unitframe.units.player.buffs.anchorPoint = "BOTTOMLEFT";
			E.db.unitframe.units.player.buffs.sortDirection = "ASCENDING";
			E.db.unitframe.units.player.buffs.sizeOverride = 32;
			E.db.unitframe.units.player.buffs.perrow = 8;
			E.db.unitframe.units.player.buffs.yOffset = 0;
			E.db.unitframe.units.player.debuffs.yOffset = 0;
			E.db.unitframe.units.player.debuffs.enable = true;
			E.db.unitframe.units.player.debuffs.attachTo = "BUFFS";
			E.db.unitframe.units.player.debuffs.anchorPoint = "BOTTOMLEFT";
			E.db.unitframe.units.player.debuffs.sortDirection = "DESCENDING";
			E.db.unitframe.units.player.debuffs.sizeOverride = 32;
			E.db.unitframe.units.player.debuffs.perrow = 7;
			E.db.unitframe.units.player.pvp.position = "TOP";
			E.db.unitframe.units.player.height = 41;
			E.db.unitframe.units.player.width = 300;
			E.db.unitframe.units.player.aurabar.enable = true;
			E.db.unitframe.units.player.aurabar.attachTo = "FRAME"
			E.db.unitframe.units.player.stagger.enable = true;
			E.db.unitframe.units.pet.height = 41;
			E.db.unitframe.units.pet.width = 80;
			E.db.unitframe.units.pet.buffs.enable = true;
			E.db.unitframe.units.pet.buffs.attachTo = "FRAME";
			E.db.unitframe.units.pet.buffs.anchorPoint = "TOPLEFT";
			E.db.unitframe.units.pet.buffs.sortDirection = "ASCENDING";
			E.db.unitframe.units.pet.buffs.sizeOverride = 0;
			E.db.unitframe.units.pet.buffs.perrow = 3;
			E.db.unitframe.units.pet.debuffs.enable = true;
			E.db.unitframe.units.pet.debuffs.attachTo = "BUFFS";
			E.db.unitframe.units.pet.debuffs.anchorPoint = "TOPRIGHT";
			E.db.unitframe.units.pet.debuffs.sortDirection = "DESCENDING";
			E.db.unitframe.units.pet.debuffs.sizeOverride = 0;
			E.db.unitframe.units.pet.debuffs.perrow = 3;
			E.db.unitframe.units.pettarget.height = 41;
			E.db.unitframe.units.pettarget.width = 80;
			E.db.unitframe.units.pettarget.buffs.enable = true;
			E.db.unitframe.units.pettarget.buffs.attachTo = "FRAME";
			E.db.unitframe.units.pettarget.buffs.anchorPoint = "BOTTOMLEFT";
			E.db.unitframe.units.pettarget.buffs.sortDirection = "ASCENDING";
			E.db.unitframe.units.pettarget.buffs.sizeOverride = 0;
			E.db.unitframe.units.pettarget.buffs.perrow = 3;
			E.db.unitframe.units.pettarget.debuffs.enable = true;
			E.db.unitframe.units.pettarget.debuffs.attachTo = "BUFFS";
			E.db.unitframe.units.pettarget.debuffs.anchorPoint = "BOTTOMLEFT";
			E.db.unitframe.units.pettarget.debuffs.sortDirection = "DESCENDING";
			E.db.unitframe.units.pettarget.debuffs.sizeOverride = 0;
			E.db.unitframe.units.pettarget.debuffs.perrow = 3;
			-- E.db.unitframe.units.bodyguard.height = 41;
			-- E.db.unitframe.units.bodyguard.width = 80;
			E.db.unitframe.units.targettarget.height = 41;
			E.db.unitframe.units.targettarget.width = 80;
			E.db.unitframe.units.targettarget.buffs.enable = true;
			E.db.unitframe.units.targettarget.buffs.attachTo = "FRAME";
			E.db.unitframe.units.targettarget.buffs.anchorPoint = "TOPRIGHT";
			E.db.unitframe.units.targettarget.buffs.sortDirection = "ASCENDING";
			E.db.unitframe.units.targettarget.buffs.sizeOverride = 0;
			E.db.unitframe.units.targettarget.buffs.perrow = 3;	
			E.db.unitframe.units.targettarget.debuffs.enable = true;
			E.db.unitframe.units.targettarget.debuffs.attachTo = "BUFFS";
			E.db.unitframe.units.targettarget.debuffs.anchorPoint = "TOPLEFT";
			E.db.unitframe.units.targettarget.debuffs.sortDirection = "DESCENDING";
			E.db.unitframe.units.targettarget.debuffs.sizeOverride = 0;
			E.db.unitframe.units.targettarget.debuffs.perrow = 3;
			E.db.unitframe.units.targettargettarget.height = 41;
			E.db.unitframe.units.targettargettarget.width = 80;
			E.db.unitframe.units.targettargettarget.buffs.enable = true;
			E.db.unitframe.units.targettargettarget.buffs.attachTo = "FRAME";
			E.db.unitframe.units.targettargettarget.buffs.anchorPoint = "BOTTOMRIGHT";
			E.db.unitframe.units.targettargettarget.buffs.sortDirection = "ASCENDING";
			E.db.unitframe.units.targettargettarget.buffs.sizeOverride = 0;
			E.db.unitframe.units.targettargettarget.buffs.perrow = 3;
			E.db.unitframe.units.targettargettarget.debuffs.enable = true;
			E.db.unitframe.units.targettargettarget.debuffs.attachTo = "BUFFS";
			E.db.unitframe.units.targettargettarget.debuffs.anchorPoint = "BOTTOMLEFT";
			E.db.unitframe.units.targettargettarget.debuffs.sortDirection = "DESCENDING";
			E.db.unitframe.units.targettargettarget.debuffs.sizeOverride = 0;
			E.db.unitframe.units.targettargettarget.debuffs.perrow = 3;
			E.db.unitframe.units.boss.height = 34;
			E.db.unitframe.units.boss.width = 240;
			E.db.unitframe.units.boss.spacing = 55;
			E.db.unitframe.units.boss.castbar.height = 14;
			E.db.unitframe.units.boss.castbar.width = 240;
			E.db.unitframe.units.boss.health.yOffset = 2;
			E.db.unitframe.units.boss.raidicon.attachTo	= "LEFT";
			E.db.unitframe.units.boss.raidicon.yOffset = 0;
			E.db.unitframe.units.boss.buffs.enable = true;
			E.db.unitframe.units.boss.buffs.attachTo = "FRAME";
			E.db.unitframe.units.boss.buffs.anchorPoint = "TOPRIGHT";
			E.db.unitframe.units.boss.buffs.sortDirection = "ASCENDING";
			E.db.unitframe.units.boss.buffs.sizeOverride = 29;
			E.db.unitframe.units.boss.buffs.perrow = 4;
			E.db.unitframe.units.boss.buffs.xOffset = 0;
			E.db.unitframe.units.boss.debuffs.enable = true;
			E.db.unitframe.units.boss.debuffs.attachTo = "FRAME";
			E.db.unitframe.units.boss.debuffs.anchorPoint = "TOPLEFT";
			E.db.unitframe.units.boss.debuffs.sortDirection = "DESCENDING";
			E.db.unitframe.units.boss.debuffs.sizeOverride = 29;
			E.db.unitframe.units.boss.debuffs.perrow = 4;
			E.db.unitframe.units.boss.debuffs.xOffset = 0;
			E.db.unitframe.units.boss.portrait.camDistanceScale = 3;
			E.db.unitframe.units.arena.height = 34;
			E.db.unitframe.units.arena.width = 240;
			E.db.unitframe.units.arena.spacing = 55;
			E.db.unitframe.units.arena.castbar.height = 14;
			E.db.unitframe.units.arena.castbar.width = 240;
			E.db.unitframe.units.arena.health.yOffset = 2;
			E.db.unitframe.units.arena.buffs.enable = true;
			E.db.unitframe.units.arena.buffs.attachTo = "FRAME";
			E.db.unitframe.units.arena.buffs.anchorPoint = "TOPRIGHT";
			E.db.unitframe.units.arena.buffs.sortDirection = "ASCENDING";
			E.db.unitframe.units.arena.buffs.sizeOverride = 29;
			E.db.unitframe.units.arena.buffs.perrow = 4;
			E.db.unitframe.units.arena.buffs.xOffset = 0;
			E.db.unitframe.units.arena.debuffs.enable = true;
			E.db.unitframe.units.arena.debuffs.attachTo = "FRAME";
			E.db.unitframe.units.arena.debuffs.anchorPoint = "TOPLEFT";
			E.db.unitframe.units.arena.debuffs.sortDirection = "DESCENDING";
			E.db.unitframe.units.arena.debuffs.sizeOverride = 29;
			E.db.unitframe.units.arena.debuffs.perrow = 4;
			E.db.unitframe.units.arena.debuffs.xOffset = 0;
			E.db.unitframe.units.arena.portrait.camDistanceScale = 3;
			E.db.unitframe.units.target.portrait.camDistanceScale = 3;
			-- E.db.unitframe.units.target.combobar.height = 6;
			-- E.db.unitframe.units.target.combobar.detachedWidth = 100;
			-- E.db.unitframe.units.target.combobar.detachFromFrame = true;
			-- E.db.unitframe.units.target.combobar.fill = "fill";
			E.db.unitframe.units.target.power.position = "LEFT";
			E.db.unitframe.units.target.power.xOffset = 3;
			E.db.unitframe.units.target.power.yOffset = -1;
			E.db.unitframe.units.target.health.position = "RIGHT";
			E.db.unitframe.units.target.health.xOffset = -2;
			E.db.unitframe.units.target.health.yOffset = -1;
			E.db.unitframe.units.target.name.position = "CENTER";
			E.db.unitframe.units.target.name.xOffset = 0;
			E.db.unitframe.units.target.name.yOffset = -1;
			E.db.unitframe.units.target.buffs.enable = true;
			E.db.unitframe.units.target.buffs.attachTo = "FRAME";
			E.db.unitframe.units.target.buffs.anchorPoint = "BOTTOMRIGHT";
			E.db.unitframe.units.target.buffs.sortDirection = "ASCENDING";
			E.db.unitframe.units.target.buffs.sizeOverride = 32;
			E.db.unitframe.units.target.buffs.perrow = 8;
			E.db.unitframe.units.target.buffs.yOffset = 0;
			E.db.unitframe.units.target.debuffs.yOffset = 0;
			E.db.unitframe.units.target.debuffs.enable = true;
			E.db.unitframe.units.target.debuffs.attachTo = "BUFFS";
			E.db.unitframe.units.target.debuffs.anchorPoint = "BOTTOMRIGHT";
			E.db.unitframe.units.target.debuffs.sortDirection = "DESCENDING";
			E.db.unitframe.units.target.debuffs.sizeOverride = 32;
			E.db.unitframe.units.target.debuffs.perrow = 7;
			E.db.unitframe.units.target.height = 41;
			E.db.unitframe.units.target.width = 300;
			E.db.unitframe.units.target.aurabar.enable = true;
			E.db.unitframe.units.target.aurabar.attachTo = "FRAME";
			E.db.unitframe.units.target.smartAuraDisplay = "DISABLED";
			E.db.unitframe.units.focus.width = 220;
			E.db.unitframe.units.focus.debuffs.anchorPoint = "TOPRIGHT";
			E.db.unitframe.units.focus.buffs.anchorPoint = "TOPLEFT";
			E.db.unitframe.units.focustarget.width = 95;
			E.db.auras.buffs.growthDirection = "RIGHT_DOWN";
			E.db.auras.buffs.wrapAfter = 12;
			E.db.auras.debuffs.maxWraps = 1;
			E.db.auras.debuffs.growthDirection = "RIGHT_DOWN";
			E.db.auras.debuffs.wrapAfter = 12;
			E.db.datatexts.ActionBarPanels.ActionBarPanelTwo.Enabled = false;
			E.db.datatexts.ActionBarPanels.ActionBarPanelThree.Enabled = false;
			E.db.actionbar.bar3.buttonsPerRow = 12;
			E.db.actionbar.bar5.buttonsPerRow = 12;
			E.db.bags.alignToChat = false;
			E.db.bags.xOffsetBank = 988;
			E.db.bags.yOffsetBank = -23;
			E.db.bags.bagWidth = 424;
			E.db.bags.bankWidth = 500;
			E.db.chat.panelWidth = 407;
			E.db.chat.panelHeight = 94;
			E.db.chat.panelHeightRight = 94;
		end
		if not E.db.movers then E.db.movers = {}; end
	end

	if layout == 'nouveauminimal' then
		if not noDataReset then
			E.db.unitframe.fontSize = 12;
			E.db.unitframe.font = "AgencyFB Bold";
			E.db.chat.font = "AgencyFB Bold";
			E.db.chat.tabFontSize = 12;
			E.db.chat.tabFont = "AgencyFB Bold";
			E.db.tooltip.healthBar.height = 13;
			E.db.tooltip.healthBar.font = "AgencyFB Bold";
			E.db.datatexts.fontSize = 12;
			E.db.datatexts.font = "AgencyFB Bold";
			E.db.general.fontSize = 12;
			E.db.general.font = "AgencyFB Bold";
			E.db.databars.experience.mouseover = false;
			E.db.databars.reputation.mouseover = false;
			E.db.general.glossTex = "Aluminium";
			E.db.general.normTex = "Aluminium";
			E.db.actionbar.fontSize = 12;
			E.db.actionbar.font = "AgencyFB Bold";
			E.db.actionbar.bar3.mouseover = false;
			E.db.actionbar.bar4.mouseover = true;
			E.db.actionbar.bar5.mouseover = false;
			E.db.actionbar.bar3.buttonsPerRow = 3;
			E.db.actionbar.bar3.buttons = 6;
			E.db.actionbar.bar3.point = "TOPLEFT";
			E.db.actionbar.bar5.buttonsPerRow = 3;
			E.db.actionbar.bar5.buttons = 6;
			E.db.actionbar.bar5.point = "BOTTOMLEFT";
			-- E.db.unitframe.units.player.portrait.camDistanceScale = 3;
			E.db.unitframe.units.player.classbar.height = 7;
			E.db.unitframe.units.player.classbar.detachedWidth = 100;
			E.db.unitframe.units.player.classbar.DetachFromFrame = true;
			E.db.unitframe.units.player.classbar.fill = "fill";
			E.db.unitframe.units.player.castbar.insideInfoPanel = false;
			E.db.unitframe.units.player.power.position = "RIGHT";
			E.db.unitframe.units.player.power.xOffset = -2;
			E.db.unitframe.units.player.power.yOffset = -1;
			E.db.unitframe.units.player.power.attachTextTo = "Health";
			E.db.unitframe.units.player.health.position = "LEFT";
			E.db.unitframe.units.player.health.xOffset = 5;
			E.db.unitframe.units.player.health.yOffset = -1;
			E.db.unitframe.units.player.health.attachTextTo = "Health";
			E.db.unitframe.units.player.name.position = "CENTER";
			E.db.unitframe.units.player.name.xOffset = 0;
			E.db.unitframe.units.player.name.yOffset = -1;
			E.db.unitframe.units.player.name.attachTextTo = "Health";
			E.db.unitframe.units.player.buffs.enable = true;
			E.db.unitframe.units.player.buffs.attachTo = "FRAME";
			E.db.unitframe.units.player.buffs.anchorPoint = "BOTTOMLEFT";
			E.db.unitframe.units.player.buffs.sortDirection = "ASCENDING";
			E.db.unitframe.units.player.buffs.sizeOverride = 30;
			E.db.unitframe.units.player.buffs.perrow = 8;
			E.db.unitframe.units.player.buffs.yOffset = 0;
			E.db.unitframe.units.player.debuffs.yOffset = 0;
			E.db.unitframe.units.player.debuffs.enable = true;
			E.db.unitframe.units.player.debuffs.attachTo = "BUFFS";
			E.db.unitframe.units.player.debuffs.anchorPoint = "BOTTOMLEFT";
			E.db.unitframe.units.player.debuffs.sortDirection = "DESCENDING";
			E.db.unitframe.units.player.debuffs.sizeOverride = 30;
			E.db.unitframe.units.player.debuffs.perrow = 7;
			E.db.unitframe.units.player.pvp.position = "TOP";
			E.db.unitframe.units.player.height = 48;
			E.db.unitframe.units.player.width = 300;
			E.db.unitframe.units.player.aurabar.enable = true;
			E.db.unitframe.units.player.aurabar.attachTo = "FRAME"
			E.db.unitframe.units.player.stagger.enable = true;
			E.db.unitframe.units.player.infoPanel.enable = true;
			E.db.unitframe.units.player.infoPanel.height = 7;
			E.db.unitframe.units.pet.infoPanel.enable = true;
			E.db.unitframe.units.pet.infoPanel.height = 7;
			E.db.unitframe.units.pet.castbar.insideInfoPanel = false;
			E.db.unitframe.units.pet.height = 48;
			E.db.unitframe.units.pet.width = 80;
			E.db.unitframe.units.pet.buffs.enable = true;
			E.db.unitframe.units.pet.buffs.attachTo = "FRAME";
			E.db.unitframe.units.pet.buffs.anchorPoint = "TOPLEFT";
			E.db.unitframe.units.pet.buffs.sortDirection = "ASCENDING";
			E.db.unitframe.units.pet.buffs.sizeOverride = 0;
			E.db.unitframe.units.pet.buffs.perrow = 3;
			E.db.unitframe.units.pet.debuffs.enable = true;
			E.db.unitframe.units.pet.debuffs.attachTo = "BUFFS";
			E.db.unitframe.units.pet.debuffs.anchorPoint = "TOPRIGHT";
			E.db.unitframe.units.pet.debuffs.sortDirection = "DESCENDING";
			E.db.unitframe.units.pet.debuffs.sizeOverride = 0;
			E.db.unitframe.units.pet.debuffs.perrow = 3;
			E.db.unitframe.units.pet.name.position = "CENTER";
			E.db.unitframe.units.pet.name.xOffset = 0;
			E.db.unitframe.units.pet.name.yOffset = -1;
			E.db.unitframe.units.pet.name.attachTextTo = "Health";
			E.db.unitframe.units.pettarget.infoPanel.enable = true;
			E.db.unitframe.units.pettarget.infoPanel.height = 7;
			E.db.unitframe.units.pettarget.height = 48;
			E.db.unitframe.units.pettarget.width = 80;
			E.db.unitframe.units.pettarget.buffs.enable = false;
			E.db.unitframe.units.pettarget.debuffs.enable = false;
			E.db.unitframe.units.pettarget.name.position = "CENTER";
			E.db.unitframe.units.pettarget.name.xOffset = 0;
			E.db.unitframe.units.pettarget.name.yOffset = -1;
			E.db.unitframe.units.pettarget.name.attachTextTo = "Health";
			E.db.unitframe.units.targettarget.infoPanel.enable = true;
			E.db.unitframe.units.targettarget.infoPanel.height = 7;
			E.db.unitframe.units.targettarget.height = 48;
			E.db.unitframe.units.targettarget.width = 80;
			E.db.unitframe.units.targettarget.buffs.enable = true;
			E.db.unitframe.units.targettarget.buffs.attachTo = "FRAME";
			E.db.unitframe.units.targettarget.buffs.anchorPoint = "TOPRIGHT";
			E.db.unitframe.units.targettarget.buffs.sortDirection = "ASCENDING";
			E.db.unitframe.units.targettarget.buffs.sizeOverride = 0;
			E.db.unitframe.units.targettarget.buffs.perrow = 3;	
			E.db.unitframe.units.targettarget.debuffs.enable = true;
			E.db.unitframe.units.targettarget.debuffs.attachTo = "BUFFS";
			E.db.unitframe.units.targettarget.debuffs.anchorPoint = "TOPLEFT";
			E.db.unitframe.units.targettarget.debuffs.sortDirection = "DESCENDING";
			E.db.unitframe.units.targettarget.debuffs.sizeOverride = 0;
			E.db.unitframe.units.targettarget.debuffs.perrow = 3;
			E.db.unitframe.units.targettarget.name.position = "CENTER";
			E.db.unitframe.units.targettarget.name.xOffset = 0;
			E.db.unitframe.units.targettarget.name.yOffset = -1;
			E.db.unitframe.units.targettarget.name.attachTextTo = "Health";
			E.db.unitframe.units.targettargettarget.infoPanel.enable = true;
			E.db.unitframe.units.targettargettarget.infoPanel.height = 7;
			E.db.unitframe.units.targettargettarget.height = 48;
			E.db.unitframe.units.targettargettarget.width = 80;
			E.db.unitframe.units.targettargettarget.buffs.enable = false;
			E.db.unitframe.units.targettargettarget.debuffs.enable = false;
			E.db.unitframe.units.targettargettarget.name.position = "CENTER";
			E.db.unitframe.units.targettargettarget.name.xOffset = 0;
			E.db.unitframe.units.targettargettarget.name.yOffset = -1;
			E.db.unitframe.units.targettargettarget.name.attachTextTo = "Health";
			E.db.unitframe.units.boss.height = 40;
			E.db.unitframe.units.boss.width = 240;
			E.db.unitframe.units.boss.spacing = 52;
			E.db.unitframe.units.boss.castbar.height = 20;
			E.db.unitframe.units.boss.castbar.width = 240;
			E.db.unitframe.units.boss.health.yOffset = 2;
			E.db.unitframe.units.boss.raidicon.attachTo	= "LEFT";
			E.db.unitframe.units.boss.raidicon.yOffset = 0;
			E.db.unitframe.units.boss.buffs.enable = true;
			E.db.unitframe.units.boss.buffs.attachTo = "FRAME";
			E.db.unitframe.units.boss.buffs.anchorPoint = "TOPRIGHT";
			E.db.unitframe.units.boss.buffs.sortDirection = "ASCENDING";
			E.db.unitframe.units.boss.buffs.sizeOverride = 29;
			E.db.unitframe.units.boss.buffs.perrow = 4;
			E.db.unitframe.units.boss.buffs.xOffset = 0;
			E.db.unitframe.units.boss.debuffs.enable = true;
			E.db.unitframe.units.boss.debuffs.attachTo = "FRAME";
			E.db.unitframe.units.boss.debuffs.anchorPoint = "TOPLEFT";
			E.db.unitframe.units.boss.debuffs.sortDirection = "DESCENDING";
			E.db.unitframe.units.boss.debuffs.sizeOverride = 29;
			E.db.unitframe.units.boss.debuffs.perrow = 4;
			E.db.unitframe.units.boss.debuffs.xOffset = 0;
			E.db.unitframe.units.boss.portrait.camDistanceScale = 3;
			E.db.unitframe.units.boss.infoPanel.enable = true;
			E.db.unitframe.units.boss.infoPanel.height = 7;
			E.db.unitframe.units.boss.castbar.insideInfoPanel = false;
			E.db.unitframe.units.arena.height = 40;
			E.db.unitframe.units.arena.width = 240;
			E.db.unitframe.units.arena.spacing = 52;
			E.db.unitframe.units.arena.infoPanel.enable = true;
			E.db.unitframe.units.arena.infoPanel.height = 7;
			E.db.unitframe.units.arena.castbar.insideInfoPanel = false;
			E.db.unitframe.units.arena.castbar.height = 20;
			E.db.unitframe.units.arena.castbar.width = 240;
			E.db.unitframe.units.arena.health.yOffset = 2;
			E.db.unitframe.units.arena.buffs.enable = true;
			E.db.unitframe.units.arena.buffs.attachTo = "FRAME";
			E.db.unitframe.units.arena.buffs.anchorPoint = "TOPRIGHT";
			E.db.unitframe.units.arena.buffs.sortDirection = "ASCENDING";
			E.db.unitframe.units.arena.buffs.sizeOverride = 29;
			E.db.unitframe.units.arena.buffs.perrow = 4;
			E.db.unitframe.units.arena.buffs.xOffset = 0;
			E.db.unitframe.units.arena.debuffs.enable = true;
			E.db.unitframe.units.arena.debuffs.attachTo = "FRAME";
			E.db.unitframe.units.arena.debuffs.anchorPoint = "TOPLEFT";
			E.db.unitframe.units.arena.debuffs.sortDirection = "DESCENDING";
			E.db.unitframe.units.arena.debuffs.sizeOverride = 29;
			E.db.unitframe.units.arena.debuffs.perrow = 4;
			E.db.unitframe.units.arena.debuffs.xOffset = 0;
			E.db.unitframe.units.arena.portrait.camDistanceScale = 3;
			-- E.db.unitframe.units.target.portrait.camDistanceScale = 3;
			-- E.db.unitframe.units.target.combobar.height = 7;
			-- E.db.unitframe.units.target.combobar.detachedWidth = 100;
			-- E.db.unitframe.units.target.combobar.detachFromFrame = true;
			-- E.db.unitframe.units.target.combobar.fill = "fill";
			E.db.unitframe.units.target.power.position = "LEFT";
			E.db.unitframe.units.target.power.xOffset = 3;
			E.db.unitframe.units.target.power.yOffset = -1;
			E.db.unitframe.units.target.power.attachTextTo = "Health";
			E.db.unitframe.units.target.health.position = "RIGHT";
			E.db.unitframe.units.target.health.xOffset = -2;
			E.db.unitframe.units.target.health.yOffset = -1;
			E.db.unitframe.units.target.health.attachTextTo = "Health";
			E.db.unitframe.units.target.name.position = "CENTER";
			E.db.unitframe.units.target.name.xOffset = 0;
			E.db.unitframe.units.target.name.yOffset = -1;
			E.db.unitframe.units.target.name.attachTextTo = "Health";
			E.db.unitframe.units.target.buffs.enable = true;
			E.db.unitframe.units.target.buffs.attachTo = "FRAME";
			E.db.unitframe.units.target.buffs.anchorPoint = "BOTTOMRIGHT";
			E.db.unitframe.units.target.buffs.sortDirection = "ASCENDING";
			E.db.unitframe.units.target.buffs.sizeOverride = 30;
			E.db.unitframe.units.target.buffs.perrow = 8;
			E.db.unitframe.units.target.buffs.yOffset = 0;
			E.db.unitframe.units.target.debuffs.yOffset = 0;
			E.db.unitframe.units.target.debuffs.enable = true;
			E.db.unitframe.units.target.debuffs.attachTo = "BUFFS";
			E.db.unitframe.units.target.debuffs.anchorPoint = "BOTTOMRIGHT";
			E.db.unitframe.units.target.debuffs.sortDirection = "DESCENDING";
			E.db.unitframe.units.target.debuffs.sizeOverride = 30;
			E.db.unitframe.units.target.debuffs.perrow = 7;
			E.db.unitframe.units.target.height = 48;
			E.db.unitframe.units.target.width = 300;
			E.db.unitframe.units.target.aurabar.enable = true;
			E.db.unitframe.units.target.aurabar.attachTo = "FRAME";
			E.db.unitframe.units.target.smartAuraDisplay = "DISABLED";
			E.db.unitframe.units.target.infoPanel.enable = true;
			E.db.unitframe.units.target.infoPanel.height = 7;
			E.db.unitframe.units.target.castbar.insideInfoPanel = false;
			E.db.unitframe.units.focus.height = 48;
			E.db.unitframe.units.focus.width = 220;
			E.db.unitframe.units.focus.debuffs.anchorPoint = "TOPRIGHT";
			E.db.unitframe.units.focus.buffs.anchorPoint = "TOPLEFT";
			E.db.unitframe.units.focus.infoPanel.enable = true;
			E.db.unitframe.units.focus.infoPanel.height = 7;
			E.db.unitframe.units.focus.castbar.insideInfoPanel = false;
			E.db.unitframe.units.focus.power.position = "RIGHT";
			E.db.unitframe.units.focus.power.xOffset = 1;
			E.db.unitframe.units.focus.power.yOffset = -1;
			E.db.unitframe.units.focus.power.attachTextTo = "Health";
			E.db.unitframe.units.focus.health.position = "LEFT";
			E.db.unitframe.units.focus.health.xOffset = 5;
			E.db.unitframe.units.focus.health.yOffset = -1;
			E.db.unitframe.units.focus.health.attachTextTo = "Health";
			E.db.unitframe.units.focus.name.position = "CENTER";
			E.db.unitframe.units.focus.name.xOffset = 0;
			E.db.unitframe.units.focus.name.yOffset = -1;
			E.db.unitframe.units.focus.name.attachTextTo = "Health";
			E.db.unitframe.units.focustarget.height = 48;
			E.db.unitframe.units.focustarget.width = 95;
			E.db.unitframe.units.focustarget.infoPanel.enable = true;
			E.db.unitframe.units.focustarget.infoPanel.height = 7;
			E.db.unitframe.units.focustarget.name.position = "CENTER";
			E.db.unitframe.units.focustarget.name.xOffset = 0;
			E.db.unitframe.units.focustarget.name.yOffset = -1;
			E.db.unitframe.units.focustarget.name.attachTextTo = "Health";
			E.db.unitframe.units.party.height = 40;
			E.db.unitframe.units.party.petsGroup.height = 40;
			E.db.unitframe.units.party.targetsGroup.height = 40;
			E.db.unitframe.units.party.infoPanel.enable = true;
			E.db.unitframe.units.party.infoPanel.height = 7;
			E.db.unitframe.units.party.rdebuffs.fontSize = 12;
			E.db.unitframe.units.party.rdebuffs.size = 18;
			E.db.unitframe.units.party.roleIcon.yOffset = 3;
			E.db.unitframe.units.raid.infoPanel.enable = true;
			E.db.unitframe.units.raid.infoPanel.height = 7;
			E.db.unitframe.units.raid.rdebuffs.fontSize = 12;
			E.db.unitframe.units.raid.rdebuffs.size = 18;
			E.db.unitframe.units.raid.roleIcon.yOffset = 3;
			E.db.unitframe.units.raid.name.position = "CENTER";
			E.db.unitframe.units.raid.name.xOffset = 0;
			E.db.unitframe.units.raid.name.yOffset = 5;
			E.db.unitframe.units.raid.name.attachTextTo = "Health";
			E.db.unitframe.units.raid40.infoPanel.enable = true;
			E.db.unitframe.units.raid40.infoPanel.height = 7;
			E.db.unitframe.units.raid40.rdebuffs.fontSize = 12;
			E.db.unitframe.units.raid40.rdebuffs.size = 18;
			E.db.unitframe.units.raid40.roleIcon.yOffset = 3;
			E.db.unitframe.units.raid40.name.position = "CENTER";
			E.db.unitframe.units.raid40.name.xOffset = 0;
			E.db.unitframe.units.raid40.name.yOffset = 5;
			E.db.unitframe.units.raid40.name.attachTextTo = "Health";
			E.db.unitframe.units.raidpet.rdebuffs.fontSize = 12;
			E.db.unitframe.units.raidpet.rdebuffs.size = 18;
			E.db.unitframe.units.raidpet.numGroups = 3;
			E.db.unitframe.units.raidpet.name.position = "CENTER";
			E.db.unitframe.units.raidpet.name.xOffset = 0;
			E.db.unitframe.units.raidpet.name.yOffset = 4;
			E.db.unitframe.units.raidpet.name.attachTextTo = "Health";
			E.db.auras.buffs.growthDirection = "RIGHT_DOWN";
			E.db.auras.buffs.wrapAfter = 12;
			E.db.auras.debuffs.maxWraps = 1;
			E.db.auras.debuffs.growthDirection = "RIGHT_DOWN";
			E.db.auras.debuffs.wrapAfter = 12;
			E.db.datatexts.ActionBarPanels.ActionBarPanelTwo.Enabled = false;
			E.db.datatexts.ActionBarPanels.ActionBarPanelThree.Enabled = false;
			E.db.datatexts.ActionBarPanels.TopPanel.Enabled = false;
			E.db.datatexts.ActionBarPanels.BottomPanel.Enabled = false;
			E.db.datatexts.ActionBarPanels.TopPanel.Height = 14;
			E.db.datatexts.ActionBarPanels.BottomPanel.Height = 14;
			E.db.datatexts.Backgrounds.LeftBG.Enabled = true;
			E.db.datatexts.Backgrounds.LeftBG.XOff = -161;
			E.db.datatexts.Backgrounds.LeftBG.Height = 82;
			E.db.datatexts.Backgrounds.LeftBG.PetHide = true;
			E.db.datatexts.Backgrounds.LeftBG.YOff = 11;
			E.db.datatexts.Backgrounds.LeftBG.Width = 535;
			E.db.datatexts.Backgrounds.RightBG.Enabled = true;
			E.db.datatexts.Backgrounds.RightBG.XOff = 161;
			E.db.datatexts.Backgrounds.RightBG.Height = 82;
			E.db.datatexts.Backgrounds.RightBG.PetHide = true;
			E.db.datatexts.Backgrounds.RightBG.YOff = 11;
			E.db.datatexts.Backgrounds.RightBG.Width = 535;
			E.db.datatexts.Backgrounds.BottomBG.PetHide = true;
			E.db.datatexts.Backgrounds.BottomBG.Height = 100;
			E.db.datatexts.Backgrounds.BottomBG.YOff = 3;
			E.db.datatexts.Backgrounds.BottomBG.Enabled = true;
			E.db.datatexts.Backgrounds.BottomBG.Width = 440;
			E.db.bags.alignToChat = false;
			E.db.bags.xOffsetBank = 984;
			E.db.bags.yOffsetBank = -31;
			E.db.bags.xOffset = 5;
			E.db.bags.yOffset = 112;
			E.db.bags.bagWidth = 424;
			E.db.bags.bankWidth = 500;
			E.db.chat.panelWidth = 407;
			E.db.chat.panelHeight = 142;
			E.db.chat.panelHeightRight = 142;
		end
		if not E.db.movers then E.db.movers = {}; end
	end

	if E.db.lowresolutionset and not noDataReset then
		E.db.unitframe.units.player.width = 240;
		E.db.unitframe.units.player.castbar.width = 240;
		E.db.unitframe.units.target.width = 240;
		E.db.unitframe.units.target.castbar.width = 240;
		-- E.db.unitframe.units.target.combobar.detachFromFrame = false;
		E.db.unitframe.units.boss.width = 200;
		E.db.unitframe.units.boss.castbar.width = 200;
		E.db.unitframe.units.arena.width = 200;
		E.db.unitframe.units.arena.castbar.width = 200;
	end

	if not E.db.lowresolutionset and (layout == 'dpsCaster' or (layout == 'dpsMelee' and E.myclass == 'HUNTER')) then
		if not E.db.movers then E.db.movers = {}; end
		E.db.movers.ElvAB_1 = "BOTTOMElvUIParentBOTTOM058"
		E.db.movers.ElvAB_2 = "BOTTOMElvUIParentBOTTOM022"
		E.db.movers.ElvAB_3 = "LEFTElvUI_Bar2RIGHT30"
		E.db.movers.ElvAB_5 = "RIGHTElvUI_Bar2LEFT-30"
		E.db.movers.PetAB = "BOTTOMElvUIParentBOTTOM0121"
		E.db.movers.ShiftAB = "BOTTOMElvUIParentBOTTOM0163"
		E.db.movers.BossButton = "BOTTOMLEFTElvUIParentBOTTOMLEFT59919"
		E.db.movers.TotemBarMover = "BOTTOMElvUIParentBOTTOM0204"
		E.db.movers.ClassBarMover = "TOPElvUF_PlayerTOP02"
		-- E.db.movers.ComboBarMover = "TOPElvUF_PlayerTOP02"
		E.db.movers.ElvUF_PlayerMover = "BOTTOMElvUIParentBOTTOM-291159"
		E.db.movers.ElvUF_PetMover = "BOTTOMLEFTElvUF_PlayerBOTTOMLEFT0-41"
		E.db.movers.ElvUF_PetTargetMover = "LEFTElvUF_PetRIGHT440"
		E.db.movers.ElvUF_TargetMover = "BOTTOMElvUIParentBOTTOM291159"
		E.db.movers.ElvUF_TargetTargetMover = "BOTTOMRIGHTElvUF_TargetBOTTOMRIGHT0-41"
		E.db.movers.ElvUF_TargetTargetTargetMover = "RIGHTElvUF_TargetTargetLEFT-440"
		E.db.movers.ElvUF_FocusMover = "BOTTOMLEFTElvUF_PlayerTOPLEFT-200448"
		E.db.movers.ElvUF_FocusTargetMover = "RIGHTElvUF_FocusRIGHT1020"
		E.db.movers.ElvUF_PlayerCastbarMover = "BOTTOMElvUIParentBOTTOM0297"
		E.db.movers.ElvUF_PetCastbarMover = "BOTTOMElvUIParentBOTTOM0245"
		E.db.movers.ElvUF_TargetCastbarMover = "BOTTOMElvUIParentBOTTOM0271"
		E.db.movers.ElvUF_PartyMover = "BOTTOMLEFTElvUIParentBOTTOMLEFT2198"
		E.db.movers.ElvUF_RaidMover = "BOTTOMLEFTElvUIParentBOTTOMLEFT2198"
		E.db.movers.ElvUF_Raid40Mover = "BOTTOMLEFTElvUIParentBOTTOMLEFT2198"
		E.db.movers.ElvUF_RaidpetMover = "LEFTElvUIParentLEFT236"
		-- E.db.movers.ElvUF_BodyGuardMover = "RIGHTElvUF_PlayerLEFT-60"
		E.db.movers.ElvUF_AssistMover = "LEFTElvUIParentLEFT2100"
		E.db.movers.ElvUF_TankMover = "LEFTElvUIParentLEFT2180"
		E.db.movers.ArenaHeaderMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-215270"
		E.db.movers.BossHeaderMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-215270"
		E.db.movers.BagsMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-4232"
		E.db.movers.TooltipMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-1168"
		E.db.movers.MinimapMover = "TOPRIGHTElvUIParentTOPRIGHT-4-1"
		E.db.movers.ReputationBarMover = "TOPMMHolderBOTTOM21"
		E.db.movers.ExperienceBarMover = "TOPMMHolderBOTTOM2-12"
		E.db.movers.VehicleSeatMover = "TOPLEFTElvUIParentTOPLEFT2-198"
		E.db.movers.MirrorTimer1Mover = "TOPElvUIParentTOP0-137"
		E.db.movers.MirrorTimer2Mover = "TOPElvUIParentTOP0-162"
		E.db.movers.MirrorTimer3Mover = "TOPElvUIParentTOP0-187"
		E.db.actionbar.bar3.buttonsPerRow = 6;
		E.db.actionbar.bar5.buttonsPerRow = 6;
		E.db.actionbar.fontSize = 12;
		E.db.actionbar.font = "AgencyFB Bold";
		E.db.bags.xOffset = 0;
		E.db.bags.xOffsetBank = 0;
		E.db.bags.yOffset = 110;
		E.db.bags.yOffsetBank = 110;
		E.db.bags.alignToChat = true;
		E.db.chat.font = "AgencyFB Bold";
		E.db.chat.tabFontSize = 12;
		E.db.chat.panelWidth = 407;
		E.db.chat.panelHeight = 94;
		E.db.chat.tabFont = "AgencyFB Bold";
		E.db.datatexts.fontSize = 12;
		E.db.datatexts.font = "AgencyFB Bold";
		E.db.general.fontSize = 12;
		E.db.general.font = "AgencyFB Bold";
		E.db.tooltip.healthBar.height = 13;
		E.db.tooltip.healthBar.font = "AgencyFB Bold";
		E.db.unitframe.units.player.classbar.height = 9;
		-- E.db.unitframe.units.target.combobar.height = 9;
		E.db.unitframe.fontSize = 12;
		E.db.unitframe.font = "AgencyFB Bold";
		E.db.unitframe.units.player.debuffs.yOffset = 5;
		E.db.unitframe.units.targettargettarget.buffs.enable = false;
		E.db.unitframe.units.targettargettarget.debuffs.enable = false;
	elseif not E.db.lowresolutionset and layout == 'healer' then
		if not E.db.movers then E.db.movers = {}; end
		E.db.movers.ElvUF_PartyMover = "BOTTOMElvUIParentBOTTOM0310"
		E.db.movers.ElvAB_1 = "BOTTOMElvUIParentBOTTOM057"
		E.db.movers.ElvAB_2 = "BOTTOMElvUIParentBOTTOM022"
		E.db.movers.ElvAB_3 = "LEFTElvUI_Bar2RIGHT317"
		E.db.movers.ElvAB_5 = "RIGHTElvUI_Bar2LEFT-317"
		E.db.movers.PetAB = "BOTTOMElvUI_Bar1BOTTOM059"
		E.db.movers.ShiftAB = "LEFTElvUIParentLEFT200-380"
		E.db.movers.BossButton = "RIGHTElvUF_PlayerLEFT-275"
		E.db.movers.TotemBarMover = "LEFTElvUIParentLEFT200-340"
		E.db.movers.ClassBarMover = "TOPElvUF_PlayerTOP02"
		-- E.db.movers.ComboBarMover = "TOPElvUF_PlayerTOP02"
		E.db.movers.ElvUF_PlayerMover = "BOTTOMElvUIParentBOTTOM-356310"
		E.db.movers.ElvUF_PetMover = "BOTTOMElvUF_PlayerBOTTOM0-97"
		E.db.movers.ElvUF_PetTargetMover = "BOTTOMLEFTElvUF_PetBOTTOMLEFT0-43"
		E.db.movers.ElvUF_TargetMover = "BOTTOMElvUIParentBOTTOM356310"
		E.db.movers.ElvUF_TargetTargetMover = "BOTTOMElvUF_TargetBOTTOM0-83"
		E.db.movers.ElvUF_TargetTargetTargetMover = "BOTTOMRIGHTElvUF_TargetTargetBOTTOMRIGHT0-43"
		E.db.movers.ElvUF_FocusMover = "BOTTOMLEFTElvUF_PlayerTOPLEFT-200248"
		E.db.movers.ElvUF_FocusTargetMover = "RIGHTElvUF_FocusRIGHT1020"
		E.db.movers.ElvUF_PlayerCastbarMover = "BOTTOMElvUF_PlayerBOTTOM0-26"
		E.db.movers.ElvUF_PetCastbarMover = "BOTTOMElvUF_PlayerBOTTOM0-52"
		E.db.movers.ElvUF_TargetCastbarMover = "BOTTOMElvUF_TargetBOTTOM0-26"
		E.db.movers.ElvUF_PartyMover = "BOTTOMElvUIParentBOTTOM0310"
		E.db.movers.ElvUF_RaidMover = "BOTTOMElvUIParentBOTTOM0160"
		E.db.movers.ElvUF_Raid40Mover = "BOTTOMElvUIParentBOTTOM0160"
		E.db.movers.ElvUF_RaidpetMover = "LEFTElvUIParentLEFT2-280"
		-- E.db.movers.ElvUF_BodyGuardMover = "BOTTOMLEFTElvUF_PetTargetBOTTOMLEFT0-43"
		E.db.movers.ElvUF_AssistMover = "LEFTElvUIParentLEFT2-100"
		E.db.movers.ElvUF_TankMover = "LEFTElvUIParentLEFT2-180"
		E.db.movers.ArenaHeaderMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-190470"
		E.db.movers.BossHeaderMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-190470"
		E.db.movers.BagsMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-4232"
		E.db.movers.TooltipMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-1168"
		E.db.movers.MinimapMover = "TOPRIGHTElvUIParentTOPRIGHT-4-1"
		E.db.movers.ReputationBarMover = "TOPMMHolderBOTTOM21"
		E.db.movers.ExperienceBarMover = "TOPMMHolderBOTTOM2-12"
		E.db.movers.VehicleSeatMover = "TOPLEFTElvUIParentTOPLEFT2-198"
		E.db.movers.MirrorTimer1Mover = "TOPElvUIParentTOP0-137"
		E.db.movers.MirrorTimer2Mover = "TOPElvUIParentTOP0-162"
		E.db.movers.MirrorTimer3Mover = "TOPElvUIParentTOP0-187"
		E.db.actionbar.bar3.buttonsPerRow = 6;
		E.db.actionbar.bar5.buttonsPerRow = 6;
		E.db.actionbar.fontSize = 12;
		E.db.actionbar.font = "AgencyFB Bold";
		E.db.bags.yOffset = 110;
		E.db.bags.yOffsetBank = 110;
		E.db.bags.bagBar.sortDirection = "ASCENDING";
		E.db.bags.bagBar.growthDirection = "HORIZONTAL";
		E.db.bags.bagBar.mouseover = true;
		E.db.chat.font = "AgencyFB Bold";
		E.db.chat.tabFontSize = 12;
		E.db.chat.panelWidth = 407;
		E.db.chat.panelHeight = 94;
		E.db.chat.tabFont = "AgencyFB Bold";
		E.db.datatexts.fontSize = 12;
		E.db.datatexts.font = "AgencyFB Bold";
		E.db.general.fontSize = 12;
		E.db.general.font = "AgencyFB Bold";
		E.db.tooltip.healthBar.height = 13;
		E.db.tooltip.healthBar.font = "AgencyFB Bold";
		E.db.unitframe.fontSize = 12;
		E.db.unitframe.font = "AgencyFB Bold";
		E.db.unitframe.units.party.health.frequentUpdates = true;
		E.db.unitframe.units.party.health.text = true;
		E.db.unitframe.units.party.name.position = 'TOP';
		E.db.unitframe.units.party.roleIcon.enable = true;
		E.db.unitframe.units.party.healPrediction = true;
		E.db.unitframe.units.party.petsGroup.enable = true;
		E.db.unitframe.units.party.growthDirection = 'RIGHT_DOWN';
		E.db.unitframe.units.party.health.orientation = 'VERTICAL';
		E.db.unitframe.units.party.xOffset = 3;
		E.db.unitframe.units.party.health.text_format = "[healthcolor][health:deficit]"
		E.db.unitframe.units.party.health.position = 'BOTTOM';
		E.db.unitframe.units.party.name.position = 'TOP';
		E.db.unitframe.units.party.name.text_format = "[namecolor][name:medium]";
		E.db.unitframe.units.party.buffs.anchorPoint = 'TOPLEFT';
		E.db.unitframe.units.party.buffs.perrow = 3;
		E.db.unitframe.units.party.buffs.sizeOverride = 0;
		E.db.unitframe.units.party.debuffs.anchorPoint = 'BOTTOMRIGHT';
		E.db.unitframe.units.party.debuffs.perrow = 3;
		E.db.unitframe.units.party.debuffs.sizeOverride = 0;
		E.db.unitframe.units.party.debuffs.useFilter = 'Blacklist';
		E.db.unitframe.units.party.petsGroup.enable = true;
		E.db.unitframe.units.party.petsGroup.initialAnchor = 'BOTTOM';
		E.db.unitframe.units.party.petsGroup.anchorPoint = 'BOTTOM';
		E.db.unitframe.units.party.petsGroup.xOffset = 0;
		E.db.unitframe.units.party.petsGroup.yOffset = -26;
		E.db.unitframe.units.party.targetsGroup.enable = true;
		E.db.unitframe.units.party.targetsGroup.initialAnchor = 'TOP';
		E.db.unitframe.units.party.targetsGroup.anchorPoint = 'TOP';
		E.db.unitframe.units.party.targetsGroup.xOffset = 0;
		E.db.unitframe.units.party.targetsGroup.yOffset = 26;
		E.db.unitframe.units.party.petsGroup.width = 69;
		E.db.unitframe.units.party.targetsGroup.width = 69;
		E.db.unitframe.units.party.height = 46;
		E.db.unitframe.units.party.width = 69;
		E.db.unitframe.units.party.xOffset = 3;
		E.db.unitframe.units.party.horizontalSpacing = 3;
		E.db.unitframe.units.party.petsGroup.height = 30;
		E.db.unitframe.units.party.targetsGroup.height = 30;
		E.db.unitframe.units.player.debuffs.yOffset = 5;
		E.db.unitframe.units.player.pvp.position = "TOPRIGHT";
		E.db.unitframe.units.player.classbar.height = 9;
		E.db.unitframe.units.player.portrait.camDistanceScale = 3;
		E.db.unitframe.units.player.power.position = "RIGHT";
		E.db.unitframe.units.player.power.xOffset = 0;
		E.db.unitframe.units.player.power.yOffset = 0;
		E.db.unitframe.units.player.health.position = "LEFT";
		E.db.unitframe.units.player.health.xOffset = 0;
		E.db.unitframe.units.player.health.yOffset = 0;
		E.db.unitframe.units.player.name.position = "CENTER";
		E.db.unitframe.units.player.name.xOffset = 0;
		E.db.unitframe.units.player.name.yOffset = 0;
		E.db.unitframe.units.player.buffs.yOffset = 0;
		E.db.unitframe.units.player.height = 41;
		E.db.unitframe.units.player.width = 270;
		E.db.unitframe.units.player.aurabar.enable = true;
		E.db.unitframe.units.player.aurabar.attachTo = "FRAME"
		E.db.unitframe.units.player.stagger.enable = true;
		E.db.unitframe.units.pet.height = 38;
		E.db.unitframe.units.pet.width = 135;
		E.db.unitframe.units.pet.debuffs.attachTo = "FRAME";
		E.db.unitframe.units.pet.debuffs.anchorPoint = "LEFT";
		E.db.unitframe.units.pettarget.height = 38;
		E.db.unitframe.units.pettarget.width = 135;
		E.db.unitframe.units.pettarget.debuffs.attachTo = "FRAME";
		E.db.unitframe.units.pettarget.debuffs.anchorPoint = "LEFT";
		-- E.db.unitframe.units.bodyguard.height = 38;
		-- E.db.unitframe.units.bodyguard.width = 135;
		E.db.unitframe.units.targettarget.height = 38;
		E.db.unitframe.units.targettarget.width = 135;
		E.db.unitframe.units.targettarget.debuffs.attachTo = "FRAME";
		E.db.unitframe.units.targettarget.debuffs.anchorPoint = "RIGHT";
		E.db.unitframe.units.targettargettarget.height = 38;
		E.db.unitframe.units.targettargettarget.width = 135;
		E.db.unitframe.units.targettargettarget.buffs.enable = true;
		E.db.unitframe.units.targettargettarget.debuffs.enable = true;
		E.db.unitframe.units.targettargettarget.debuffs.attachTo = "FRAME";
		E.db.unitframe.units.targettargettarget.debuffs.anchorPoint = "RIGHT";
		E.db.unitframe.units.target.portrait.camDistanceScale = 3;
		-- E.db.unitframe.units.target.combobar.height = 9;
		E.db.unitframe.units.target.power.position = "LEFT";
		E.db.unitframe.units.target.power.xOffset = 0;
		E.db.unitframe.units.target.power.yOffset = 0;
		E.db.unitframe.units.target.health.position = "RIGHT";
		E.db.unitframe.units.target.health.xOffset = 0;
		E.db.unitframe.units.target.health.yOffset = 0;
		E.db.unitframe.units.target.name.position = "CENTER";
		E.db.unitframe.units.target.name.xOffset = 0;
		E.db.unitframe.units.target.name.yOffset = 0;
		E.db.unitframe.units.target.buffs.yOffset = 0;
		E.db.unitframe.units.target.debuffs.yOffset = 0;
		E.db.unitframe.units.target.height = 41;
		E.db.unitframe.units.target.width = 270;
		E.db.unitframe.units.target.aurabar.enable = true;
		E.db.unitframe.units.target.buffs.anchorPoint = "TOPRIGHT";
		E.db.unitframe.units.target.debuffs.anchorPoint = "TOPLEFT";
		E.db.unitframe.units.target.smartAuraDisplay = "DISABLED";
		E.db.unitframe.units.focus.width = 220;
		E.db.unitframe.units.focus.debuffs.anchorPoint = "TOPRIGHT";
		E.db.unitframe.units.focus.buffs.anchorPoint = "TOPLEFT";
		E.db.unitframe.units.focustarget.width = 95;
		E.db.unitframe.units.boss.portrait.camDistanceScale = 3;
		E.db.auras.buffs.growthDirection = "RIGHT_DOWN";
		E.db.auras.buffs.wrapAfter = 12;
		E.db.auras.debuffs.maxWraps = 1;
		E.db.auras.debuffs.growthDirection = "RIGHT_DOWN";
		E.db.auras.debuffs.wrapAfter = 12;
		E.db.movers.ElvUF_PartyMover = "BOTTOMElvUIParentBOTTOM0310"
	elseif not E.db.lowresolutionset and (layout == 'blizzard') then
		if not E.db.movers then E.db.movers = {}; end
		E.db.movers.ElvUF_PlayerMover = "TOPLEFTElvUIParentTOPLEFT10-28"
		E.db.movers.ElvUF_TargetMover = "BOTTOMLEFTElvUF_PlayerBOTTOMRIGHT620"
		E.db.movers.ElvUF_TargetTargetMover = "BOTTOMRIGHTElvUF_TargetBOTTOMRIGHT0-101"
		E.db.movers.ElvUF_PetMover = "BOTTOMLEFTElvUF_PlayerBOTTOMLEFT0-54"
		E.db.movers.ElvUF_FocusMover = "BOTTOMElvUF_TargetBOTTOM0-143"
		E.db.movers.ElvUF_PartyMover = "BOTTOMLEFTElvUIParentBOTTOMLEFT2240"
		E.db.movers.ElvUF_RaidMover = "BOTTOMLEFTElvUIParentBOTTOMLEFT2240"
		E.db.movers.ElvUF_Raid40Mover = "BOTTOMLEFTElvUIParentBOTTOMLEFT2240"
		E.db.movers.ElvUF_RaidpetMover = "BOTTOMLEFTElvUIParentBOTTOMLEFT2560"
		E.db.movers.ElvUF_AssistMover = "TOPLEFTElvUIParentTOPLEFT2-361"
		E.db.movers.ElvUF_TankMover = "TOPLEFTElvUIParentTOPLEFT2-291"
		E.db.movers.ArenaHeaderMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-120208"
		E.db.movers.BossHeaderMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-120208"
		E.db.movers.TooltipMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-1190"
		E.db.movers.LootFrameMover = "TOPLEFTElvUIParentTOPLEFT368-284"
		E.db.movers.BuffsMover = "TOPRIGHTElvUIParentTOPRIGHT-247-2"
		E.db.movers.DebuffsMover = "BOTTOMRIGHTBuffsMoverBOTTOMRIGHT0-100"
		E.db.movers.TempEnchantMover = "TOPRIGHTBuffsMoverBOTTOMRIGHT0-4"
		E.db.movers.VehicleSeatMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-40350"
		E.db.movers.MicrobarMover = "BOTTOMRIGHTRightChatToggleButtonTOPRIGHT0153"
		E.db.movers.BNETMover = "BOTTOMLEFTLeftChatToggleButtonTOPLEFT0153"
		E.db.movers.WatchFrameMover = "TOPRIGHTElvUIParentTOPRIGHT-116-306"
		E.db.movers.GMMover = "TOPRIGHTMMHolderBOTTOMRIGHT0-30"
		E.db.movers.ElvUF_PlayerCastbarMover = "BOTTOMElvUIParentBOTTOM0267"
		E.db.movers.ElvUF_TargetCastbarMover = "BOTTOMElvUIParentBOTTOM0239"
		E.db.movers.BagsMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-4032"
		E.db.movers.BossButton = "BOTTOMElvUIParentBOTTOM0300"
		E.db.actionbar.bar3.buttonsPerRow = 6;
		E.db.actionbar.bar5.buttonsPerRow = 6;
		E.db.unitframe.fontSize = 12;
		E.db.unitframe.font = "AgencyFB Bold";
		E.db.chat.font = "AgencyFB Bold";
		E.db.chat.tabFontSize = 12;
		E.db.chat.tabFont = "AgencyFB Bold";
		E.db.tooltip.healthBar.height = 13;
		E.db.tooltip.healthBar.font = "AgencyFB Bold";
		E.db.datatexts.fontSize = 12;
		E.db.datatexts.font = "AgencyFB Bold";
		E.db.general.fontSize = 12;
		E.db.general.font = "AgencyFB Bold";
		E.db.actionbar.fontSize = 12;
		E.db.actionbar.font = "AgencyFB Bold";
		E.db.chat.panelWidth = 407;
		E.db.chat.panelHeight = 94;
		E.db.unitframe.units.player.pvp.position = "TOPRIGHT";
	elseif E.db.lowresolutionset and (layout == 'blizzard') then
		if not E.db.movers then E.db.movers = {}; end
		E.db.movers.ElvUF_PlayerMover = "TOPLEFTElvUIParentTOPLEFT10-52"
		E.db.movers.ElvUF_TargetMover = "BOTTOMLEFTElvUF_PlayerBOTTOMRIGHT620"
		E.db.movers.ElvUF_TargetTargetMover = "BOTTOMLEFTElvUF_PlayerBOTTOMRIGHT60"
		E.db.movers.ElvUF_PetMover = "BOTTOMLEFTElvUF_PlayerBOTTOMLEFT0-64"
		E.db.movers.ElvUF_FocusMover = "BOTTOMElvUF_TargetBOTTOM0-100"
		E.db.movers.ArenaHeaderMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-128190"
		E.db.movers.BossHeaderMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-128190"
		E.db.movers.LootFrameMover = "TOPLEFTElvUIParentTOPLEFT368-240"
		E.db.movers.BuffsMover = "TOPRIGHTElvUIParentTOPRIGHT-247-2"
		E.db.movers.TempEnchantMover = "TOPRIGHTBuffsMoverBOTTOMRIGHT0-4"
		E.db.movers.VehicleSeatMover = "TOPRIGHTBuffsMoverBOTTOMRIGHT0-41"
		E.db.movers.MicrobarMover = "BOTTOMRIGHTRightChatToggleButtonTOPRIGHT0130"
		E.db.movers.BNETMover = "TOPRIGHTMMHolderBOTTOMRIGHT0-27"
		E.db.movers.WatchFrameMover = "TOPRIGHTElvUIParentTOPRIGHT-116-322"
		E.db.movers.GMMover = "TOPRIGHTMMHolderBOTTOMRIGHT0-50"
		E.db.movers.ElvUF_PlayerCastbarMover = "BOTTOMElvUIParentBOTTOM0267"
		E.db.movers.ElvUF_TargetCastbarMover = "BOTTOMElvUIParentBOTTOM0239"
		E.db.movers.TotemBarMover = "BOTTOMElvUI_Bar1BOTTOM0138"
		E.db.movers.PetAB = "BOTTOMElvUI_Bar1BOTTOM057"
		E.db.movers.ShiftAB = "BOTTOMElvUI_Bar1BOTTOM097"
	elseif not E.db.lowresolutionset and layout == 'nouveauheal' then
		if not E.db.movers then E.db.movers = {}; end
		E.db.movers.ElvAB_1 = "BOTTOMElvUIParentBOTTOM060"
		E.db.movers.ElvAB_2 = "BOTTOMElvUIParentBOTTOM022"
		E.db.movers.ElvAB_3 = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-2139"
		E.db.movers.ElvAB_5 = "BOTTOMLEFTElvUIParentBOTTOMLEFT2139"
		E.db.movers.PetAB = "BOTTOMElvUI_Bar1BOTTOM059"
		E.db.movers.ShiftAB = "BOTTOMElvUF_PlayerBOTTOM0-226"
		E.db.movers.BossButton = "RIGHTElvUF_PlayerLEFT-275"
		E.db.movers.TotemBarMover = "BOTTOMElvUF_PlayerBOTTOM0-270"
		E.db.movers.ClassBarMover = "TOPLEFTElvUF_PlayerTOPLEFT8-7"
		-- E.db.movers.ComboBarMover = "TOPLEFTElvUF_PlayerTOPLEFT8-7"
		E.db.movers.ElvUF_PlayerMover = "BOTTOMElvUIParentBOTTOM-356310"
		E.db.movers.ElvUF_PetMover = "BOTTOMElvUF_PlayerBOTTOM0-97"
		E.db.movers.ElvUF_PetTargetMover = "BOTTOMLEFTElvUF_PetBOTTOMLEFT0-43"
		E.db.movers.ElvUF_TargetMover = "BOTTOMElvUIParentBOTTOM356310"
		E.db.movers.ElvUF_TargetTargetMover = "BOTTOMElvUF_TargetBOTTOM0-83"
		E.db.movers.ElvUF_TargetTargetTargetMover = "BOTTOMRIGHTElvUF_TargetTargetBOTTOMRIGHT0-43"
		E.db.movers.ElvUF_FocusMover = "BOTTOMLEFTElvUF_PlayerTOPLEFT-200248"
		E.db.movers.ElvUF_FocusTargetMover = "RIGHTElvUF_FocusRIGHT1020"
		E.db.movers.ElvUF_PlayerCastbarMover = "BOTTOMElvUF_PlayerBOTTOM0-26"
		E.db.movers.ElvUF_PetCastbarMover = "BOTTOMElvUF_PlayerBOTTOM0-52"
		E.db.movers.ElvUF_TargetCastbarMover = "BOTTOMElvUF_TargetBOTTOM0-26"
		E.db.movers.ElvUF_PartyMover = "BOTTOMElvUIParentBOTTOM0310"
		E.db.movers.ElvUF_RaidMover = "BOTTOMElvUIParentBOTTOM0160"
		E.db.movers.ElvUF_Raid40Mover = "BOTTOMElvUIParentBOTTOM0160"
		E.db.movers.ElvUF_RaidpetMover = "LEFTElvUIParentLEFT2-280"
		-- E.db.movers.ElvUF_BodyGuardMover = "BOTTOMLEFTElvUF_PetTargetBOTTOMLEFT0-43"
		E.db.movers.ElvUF_AssistMover = "LEFTElvUIParentLEFT2-100"
		E.db.movers.ElvUF_TankMover = "LEFTElvUIParentLEFT2-180"
		E.db.movers.ArenaHeaderMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-190470"
		E.db.movers.BossHeaderMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-190470"
		E.db.movers.BagsMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-4232"
		E.db.movers.TooltipMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-1168"
		E.db.movers.MinimapMover = "TOPRIGHTElvUIParentTOPRIGHT-4-1"
		E.db.movers.ReputationBarMover = "TOPMMHolderBOTTOM21"
		E.db.movers.ExperienceBarMover = "TOPMMHolderBOTTOM2-12"
		E.db.movers.VehicleSeatMover = "TOPLEFTElvUIParentTOPLEFT2-198"
		E.db.movers.MirrorTimer1Mover = "TOPElvUIParentTOP0-137"
		E.db.movers.MirrorTimer2Mover = "TOPElvUIParentTOP0-162"
		E.db.movers.MirrorTimer3Mover = "TOPElvUIParentTOP0-187"
	elseif not E.db.lowresolutionset and (layout == 'nouveauminimal') then
		-- if not E.db.movers then E.db.movers = {}; end
		-- E.db.movers.ElvAB_1 = "BOTTOMElvUIParentBOTTOM058"
		-- E.db.movers.ElvAB_2 = "BOTTOMElvUIParentBOTTOM022"
		-- E.db.movers.ElvAB_3 = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-1139"
		-- E.db.movers.ElvAB_4 = "RIGHTElvUIParentRIGHT-10"
		-- E.db.movers.ElvAB_5 = "BOTTOMLEFTElvUIParentBOTTOMLEFT1139"
		-- E.db.movers.PetAB = "BOTTOMElvUIParentBOTTOM0121"
		-- E.db.movers.ShiftAB = "BOTTOMElvUIParentBOTTOM0163"
		-- E.db.movers.BossButton = "BOTTOMLEFTElvUIParentBOTTOMLEFT59919"
		-- E.db.movers.TotemBarMover = "BOTTOMElvUIParentBOTTOM0204"
		-- E.db.movers.ClassBarMover = "TOPLEFTElvUF_PlayerTOPLEFT6-6"
		-- E.db.movers.ComboBarMover = "TOPLEFTElvUF_PlayerTOPLEFT6-6"
		-- E.db.movers.MicrobarMover = "TOPRIGHTElvUIParentTOPRIGHT-250-1"
		-- E.db.movers.ElvUF_PlayerMover = "BOTTOMElvUIParentBOTTOM-294161"
		-- E.db.movers.ElvUF_PetMover = "BOTTOMLEFTElvUIParentBOTTOMLEFT433161"
		-- E.db.movers.ElvUF_PetTargetMover = "BOTTOMLEFTElvUIParentBOTTOMLEFT433117"
		-- E.db.movers.ElvUF_TargetMover = "BOTTOMElvUIParentBOTTOM294161"
		-- E.db.movers.ElvUF_TargetTargetMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-433161"
		-- E.db.movers.ElvUF_TargetTargetTargetMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-433117"
		-- E.db.movers.ElvUF_FocusMover = "TOPLEFTElvUIParentTOPLEFT316-360"
		-- E.db.movers.ElvUF_FocusTargetMover = "RIGHTElvUF_FocusRIGHT1020"
		-- E.db.movers.ElvUF_PlayerCastbarMover = "BOTTOMElvUIParentBOTTOM0297"
		-- E.db.movers.ElvUF_PetCastbarMover = "BOTTOMElvUIParentBOTTOM0245"
		-- E.db.movers.ElvUF_TargetCastbarMover = "BOTTOMElvUIParentBOTTOM0271"
		-- E.db.movers.ElvUF_PartyMover = "BOTTOMLEFTElvUIParentBOTTOMLEFT1235"
		-- E.db.movers.ElvUF_RaidMover = "TOPLEFTElvUIParentBOTTOMLEFT1543"
		-- E.db.movers.ElvUF_Raid40Mover = "TOPLEFTElvUIParentBOTTOMLEFT1543"
		-- E.db.movers.ElvUF_RaidpetMover = "TOPLEFTElvUIParentBOTTOMLEFT1608"
		-- E.db.movers.ElvUF_BodyGuardMover = "BOTTOMLEFTElvUIParentBOTTOMLEFT43373"
		-- E.db.movers.ElvUF_AssistMover = "LEFTElvUIParentLEFT1100"
		-- E.db.movers.ElvUF_TankMover = "LEFTElvUIParentLEFT1180"
		-- E.db.movers.ArenaHeaderMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-184214"
		-- E.db.movers.BossHeaderMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-184214"
		-- E.db.movers.BagsMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-4232"
		-- E.db.movers.TooltipMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-1181"
		-- E.db.movers.BuffsMover = "TOPLEFTElvUIParentTOPLEFT2-2"
		-- E.db.movers.DebuffsMover = "TOPLEFTElvUIParentTOPLEFT2-147"
		-- E.db.movers.VehicleSeatMover = "TOPLEFTElvUIParentTOPLEFT2-196"
		-- E.db.movers.MirrorTimer1Mover = "TOPElvUIParentTOP0-137"
		-- E.db.movers.MirrorTimer2Mover = "TOPElvUIParentTOP0-162"
		-- E.db.movers.MirrorTimer3Mover = "TOPElvUIParentTOP0-187"
		-- E.db.movers.LeftChatMover = "BOTTOMLEFTElvUIParentBOTTOMLEFT22"
		-- E.db.movers.RightChatMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-22"
		-- E.db.movers.LootFrameMover = "TOPRIGHTElvUIParentTOPRIGHT-466-300"
		-- E.db.movers.GMMover = "TOPRIGHTElvUIParentTOPRIGHT-250-34"
		-- E.db.movers.BNETMover = "TOPRIGHTElvUIParentTOPRIGHT-250-111"
		-- E.db.movers.AlertFrameMover = "TOPElvUIParentTOP0-72"
		-- E.db.movers.MinimapMover = "TOPRIGHTElvUIParentTOPRIGHT-2-2"
		-- E.db.movers.ReputationBarMover = "TOPRIGHTElvUIParentTOPRIGHT-2-230"
		-- E.db.movers.ExperienceBarMover = "TOPRIGHTElvUIParentTOPRIGHT-2-243"
		if not E.db.movers then E.db.movers = {}; end
		E.db.movers.ElvAB_1 = "BOTTOMElvUIParentBOTTOM072"
		E.db.movers.ElvAB_2 = "BOTTOMElvUIParentBOTTOM036"
		E.db.movers.ElvAB_3 = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-42835"
		E.db.movers.ElvAB_4 = "RIGHTElvUIParentRIGHT-10"
		E.db.movers.ElvAB_5 = "BOTTOMLEFTElvUIParentBOTTOMLEFT42835"
		E.db.movers.PetAB = "BOTTOMElvUIParentBOTTOM0135"
		E.db.movers.ShiftAB = "BOTTOMElvUIParentBOTTOM0163"
		E.db.movers.BossButton = "BOTTOMElvUIParentBOTTOM-26442"
		E.db.movers.TotemBarMover = "BOTTOMElvUIParentBOTTOM0184"
		E.db.movers.ClassBarMover = "TOPLEFTElvUF_PlayerTOPLEFT6-6"
		-- E.db.movers.ComboBarMover = "TOPLEFTElvUF_PlayerTOPLEFT6-6"
		E.db.movers.MicrobarMover = "TOPRIGHTElvUIParentTOPRIGHT-250-1"
		E.db.movers.ElvUF_PlayerMover = "BOTTOMElvUIParentBOTTOM-297179"
		E.db.movers.ElvUF_PetMover = "BOTTOMLEFTElvUIParentBOTTOMLEFT432179"
		E.db.movers.ElvUF_PetTargetMover = "BOTTOMLEFTElvUIParentBOTTOMLEFT432130"
		E.db.movers.ElvUF_TargetMover = "BOTTOMElvUIParentBOTTOM297179"
		E.db.movers.ElvUF_TargetTargetMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-432179"
		E.db.movers.ElvUF_TargetTargetTargetMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-432130"
		E.db.movers.ElvUF_FocusMover = "TOPLEFTElvUIParentTOPLEFT316-360"
		E.db.movers.ElvUF_FocusTargetMover = "RIGHTElvUF_FocusRIGHT1020"
		E.db.movers.ElvUF_PlayerCastbarMover = "BOTTOMElvUIParentBOTTOM0285"
		E.db.movers.ElvUF_PetCastbarMover = "BOTTOMElvUIParentBOTTOM0233"
		E.db.movers.ElvUF_TargetCastbarMover = "BOTTOMElvUIParentBOTTOM0259"
		E.db.movers.ElvUF_PartyMover = "TOPLEFTElvUIParentBOTTOMLEFT1580"
		E.db.movers.ElvUF_RaidMover = "TOPLEFTElvUIParentBOTTOMLEFT1600"
		E.db.movers.ElvUF_Raid40Mover = "TOPLEFTElvUIParentBOTTOMLEFT1600"
		E.db.movers.ElvUF_RaidpetMover = "TOPLEFTElvUIParentBOTTOMLEFT1248"
		-- E.db.movers.ElvUF_BodyGuardMover = "BOTTOMLEFTElvUIParentBOTTOMLEFT43373"
		E.db.movers.ElvUF_AssistMover = "LEFTElvUIParentLEFT1100"
		E.db.movers.ElvUF_TankMover = "LEFTElvUIParentLEFT1180"
		E.db.movers.ArenaHeaderMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-187233"
		E.db.movers.BossHeaderMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-187233"
		E.db.movers.BagsMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-4232"
		E.db.movers.TooltipMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-1181"
		E.db.movers.BuffsMover = "TOPLEFTElvUIParentTOPLEFT2-2"
		E.db.movers.DebuffsMover = "TOPLEFTElvUIParentTOPLEFT2-147"
		E.db.movers.VehicleSeatMover = "TOPLEFTElvUIParentTOPLEFT2-196"
		E.db.movers.MirrorTimer1Mover = "TOPElvUIParentTOP0-137"
		E.db.movers.MirrorTimer2Mover = "TOPElvUIParentTOP0-162"
		E.db.movers.MirrorTimer3Mover = "TOPElvUIParentTOP0-187"
		E.db.movers.LeftChatMover = "BOTTOMLEFTElvUIParentBOTTOMLEFT22"
		E.db.movers.RightChatMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-22"
		E.db.movers.LootFrameMover = "TOPRIGHTElvUIParentTOPRIGHT-466-300"
		E.db.movers.GMMover = "TOPRIGHTElvUIParentTOPRIGHT-250-86"
		E.db.movers.BNETMover = "TOPRIGHTElvUIParentTOPRIGHT-250-34"
		E.db.movers.AltPowerBarMover = "TOPElvUIParentTOP0-26"
		E.db.movers.AlertFrameMover = "TOPElvUIParentTOP0-81"
		E.db.movers.MinimapMover = "TOPRIGHTElvUIParentTOPRIGHT-2-2"
		E.db.movers.ReputationBarMover = "TOPRIGHTElvUIParentTOPRIGHT-2-230"
		E.db.movers.ExperienceBarMover = "TOPRIGHTElvUIParentTOPRIGHT-2-243"
		E.db.movers.ArtifactBarMover = "TOPRIGHTElvUIParentTOPRIGHT-2-256"
		E.db.movers.HonorBarMover = "TOPRIGHTElvUIParentTOPRIGHT-2-269"
	elseif E.db.lowresolutionset and (layout == 'nouveauminimal') then
		if not E.db.movers then E.db.movers = {}; end
		E.db.movers.ElvUF_PlayerMover = "TOPElvUIParentTOP-700-25"
		E.db.movers.ElvUF_TargetMover = "BOTTOMLEFTElvUF_PlayerBOTTOMRIGHT620"
		E.db.movers.ElvUF_TargetTargetMover = "TOPElvUIParentTOP-309-130"
		E.db.movers.ElvUF_TargetTargetTargetMover = "TOPElvUIParentTOP-457-130"
		E.db.movers.ElvUF_PetMover = "TOPElvUIParentTOP-769-67"
		E.db.movers.ElvUF_FocusMover = "TOPElvUIParentTOP-378-250"
		E.db.movers.ArenaHeaderMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-128190"
		E.db.movers.BossHeaderMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-128190"
		E.db.movers.LootFrameMover = "TOPLEFTElvUIParentTOPLEFT368-240"
		E.db.movers.BuffsMover = "TOPRIGHTElvUIParentTOPRIGHT-241-25"
		E.db.movers.TempEnchantMover = "TOPRIGHTBuffsMoverBOTTOMRIGHT0-4"
		E.db.movers.VehicleSeatMover = "TOPRIGHTBuffsMoverBOTTOMRIGHT0-41"
		E.db.movers.MicrobarMover = "BOTTOMRIGHTRightChatToggleButtonTOPRIGHT0130"
		E.db.movers.BNETMover = "TOPRIGHTMMHolderBOTTOMRIGHT0-27"
		E.db.movers.WatchFrameMover = "TOPRIGHTElvUIParentTOPRIGHT-116-322"
		E.db.movers.GMMover = "TOPRIGHTMMHolderBOTTOMRIGHT0-50"
		E.db.movers.ElvUF_PlayerCastbarMover = "BOTTOMElvUIParentBOTTOM0267"
		E.db.movers.ElvUF_TargetCastbarMover = "BOTTOMElvUIParentBOTTOM0239"
		E.db.movers.TotemBarMover = "BOTTOMElvUI_Bar1BOTTOM0138"
		E.db.movers.PetAB = "BOTTOMElvUI_Bar1BOTTOM057"
		E.db.movers.ShiftAB = "BOTTOMElvUI_Bar1BOTTOM097"
	elseif not E.db.lowresolutionset and (layout == 'nouveaufull') then
		if not E.db.movers then E.db.movers = {}; end
		E.db.movers.ElvAB_1 = "BOTTOMElvUIParentBOTTOM072"
		E.db.movers.ElvAB_2 = "BOTTOMElvUIParentBOTTOM036"
		E.db.movers.ElvAB_3 = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-42835"
		E.db.movers.ElvAB_4 = "RIGHTElvUIParentRIGHT-10"
		E.db.movers.ElvAB_5 = "BOTTOMLEFTElvUIParentBOTTOMLEFT42835"
		E.db.movers.PetAB = "BOTTOMElvUIParentBOTTOM0135"
		E.db.movers.ShiftAB = "BOTTOMElvUIParentBOTTOM0163"
		E.db.movers.BossButton = "BOTTOMElvUIParentBOTTOM-26442"
		E.db.movers.TotemBarMover = "BOTTOMElvUIParentBOTTOM0184"
		E.db.movers.ClassBarMover = "TOPLEFTElvUF_PlayerTOPLEFT6-6"
		-- E.db.movers.ComboBarMover = "TOPLEFTElvUF_PlayerTOPLEFT6-6"
		E.db.movers.MicrobarMover = "TOPRIGHTElvUIParentTOPRIGHT-250-1"
		E.db.movers.ElvUF_PlayerMover = "BOTTOMElvUIParentBOTTOM-297179"
		E.db.movers.ElvUF_PetMover = "BOTTOMLEFTElvUIParentBOTTOMLEFT432179"
		E.db.movers.ElvUF_PetTargetMover = "BOTTOMLEFTElvUIParentBOTTOMLEFT432130"
		E.db.movers.ElvUF_TargetMover = "BOTTOMElvUIParentBOTTOM297179"
		E.db.movers.ElvUF_TargetTargetMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-432179"
		E.db.movers.ElvUF_TargetTargetTargetMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-432130"
		E.db.movers.ElvUF_FocusMover = "TOPLEFTElvUIParentTOPLEFT316-360"
		E.db.movers.ElvUF_FocusTargetMover = "RIGHTElvUF_FocusRIGHT1020"
		E.db.movers.ElvUF_PlayerCastbarMover = "BOTTOMElvUIParentBOTTOM0285"
		E.db.movers.ElvUF_PetCastbarMover = "BOTTOMElvUIParentBOTTOM0233"
		E.db.movers.ElvUF_TargetCastbarMover = "BOTTOMElvUIParentBOTTOM0259"
		E.db.movers.ElvUF_PartyMover = "TOPLEFTElvUIParentBOTTOMLEFT1580"
		E.db.movers.ElvUF_RaidMover = "TOPLEFTElvUIParentBOTTOMLEFT1600"
		E.db.movers.ElvUF_Raid40Mover = "TOPLEFTElvUIParentBOTTOMLEFT1600"
		E.db.movers.ElvUF_RaidpetMover = "TOPLEFTElvUIParentBOTTOMLEFT1248"
		-- E.db.movers.ElvUF_BodyGuardMover = "BOTTOMLEFTElvUIParentBOTTOMLEFT43373"
		E.db.movers.ElvUF_AssistMover = "LEFTElvUIParentLEFT1100"
		E.db.movers.ElvUF_TankMover = "LEFTElvUIParentLEFT1180"
		E.db.movers.ArenaHeaderMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-187233"
		E.db.movers.BossHeaderMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-187233"
		E.db.movers.BagsMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-4232"
		E.db.movers.TooltipMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-1181"
		E.db.movers.BuffsMover = "TOPLEFTElvUIParentTOPLEFT2-2"
		E.db.movers.DebuffsMover = "TOPLEFTElvUIParentTOPLEFT2-147"
		E.db.movers.VehicleSeatMover = "TOPLEFTElvUIParentTOPLEFT2-196"
		E.db.movers.MirrorTimer1Mover = "TOPElvUIParentTOP0-137"
		E.db.movers.MirrorTimer2Mover = "TOPElvUIParentTOP0-162"
		E.db.movers.MirrorTimer3Mover = "TOPElvUIParentTOP0-187"
		E.db.movers.LeftChatMover = "BOTTOMLEFTElvUIParentBOTTOMLEFT22"
		E.db.movers.RightChatMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-22"
		E.db.movers.LootFrameMover = "TOPRIGHTElvUIParentTOPRIGHT-466-300"
		E.db.movers.GMMover = "TOPRIGHTElvUIParentTOPRIGHT-250-86"
		E.db.movers.BNETMover = "TOPRIGHTElvUIParentTOPRIGHT-250-34"
		E.db.movers.AltPowerBarMover = "TOPElvUIParentTOP0-26"
		E.db.movers.AlertFrameMover = "TOPElvUIParentTOP0-81"
		E.db.movers.MinimapMover = "TOPRIGHTElvUIParentTOPRIGHT-2-2"
		E.db.movers.ReputationBarMover = "TOPRIGHTElvUIParentTOPRIGHT-2-230"
		E.db.movers.ExperienceBarMover = "TOPRIGHTElvUIParentTOPRIGHT-2-243"
		E.db.movers.ArtifactBarMover = "TOPRIGHTElvUIParentTOPRIGHT-2-256"
		E.db.movers.HonorBarMover = "TOPRIGHTElvUIParentTOPRIGHT-2-269"
	elseif E.db.lowresolutionset and (layout == 'nouveaufull') then
		if not E.db.movers then E.db.movers = {}; end
		E.db.movers.ElvAB_3 = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-2135"
		E.db.movers.ElvAB_5 = "BOTTOMLEFTElvUIParentBOTTOMLEFT2135"
		E.db.movers.ElvUF_PlayerMover = "BOTTOMElvUIParentBOTTOM-272180"
		E.db.movers.ElvUF_TargetMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-438180"
		E.db.movers.ElvUF_PetTargetMover = "BOTTOMLEFTElvUIParentBOTTOMLEFT438103"
		E.db.movers.ElvUF_TargetTargetTargetMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-438103"
		E.db.movers.ElvUF_FocusMover = "TOPLEFTElvUIParentTOPLEFT250-427"
		E.db.movers.ClassBarMover = "BOTTOMLEFTElvUIParentBOTTOMLEFT453216"
		E.db.movers.BagsMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-4032"
		E.db.movers.ElvUF_PlayerCastbarMover = "BOTTOMElvUIParentBOTTOM0267"
		E.db.movers.ElvUF_TargetCastbarMover = "BOTTOMElvUIParentBOTTOM0239"
		E.db.movers.BossButton = "BOTTOMLEFTElvUIParentBOTTOMLEFT43823"
		E.db.movers.VehicleSeatMover = "TOPLEFTElvUIParentTOPLEFT2-214"
		E.db.movers.ElvUF_PartyMover = "BOTTOMLEFTElvUIParentBOTTOMLEFT2178"
		E.db.movers.ElvUF_RaidMover = "BOTTOMLEFTElvUIParentBOTTOMLEFT2178"
		E.db.movers.ElvUF_Raid40Mover = "BOTTOMLEFTElvUIParentBOTTOMLEFT2178"
		E.db.movers.ElvUF_RaidpetMover = "BOTTOMLEFTElvUIParentBOTTOMLEFT2490"
		E.db.movers.ElvUF_AssistMover = "TOPLEFTElvUIParentTOPLEFT2-431"
		E.db.movers.ElvUF_TankMover = "TOPLEFTElvUIParentTOPLEFT2-361"
		E.db.movers.ArenaHeaderMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-120178"
		E.db.movers.BossHeaderMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-120178"
		E.db.movers.TooltipMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-1153"
		E.db.movers.LootFrameMover = "TOPLEFTElvUIParentTOPLEFT368-240"
		E.db.movers.BuffsMover = "TOPRIGHTElvUIParentTOPRIGHT-247-2"
		E.db.movers.TempEnchantMover = "TOPRIGHTBuffsMoverBOTTOMRIGHT0-4"
		E.db.movers.MicrobarMover = "BOTTOMRIGHTRightChatToggleButtonTOPRIGHT0130"
		E.db.movers.BNETMover = "TOPRIGHTMMHolderBOTTOMRIGHT0-27"
		E.db.movers.WatchFrameMover = "TOPRIGHTElvUIParentTOPRIGHT-116-322"
		E.db.movers.GMMover = "TOPRIGHTMMHolderBOTTOMRIGHT0-50"
		E.db.movers.TotemBarMover = "BOTTOMElvUI_Bar1BOTTOM0138"
		E.db.movers.PetAB = "BOTTOMElvUI_Bar1BOTTOM057"
		E.db.movers.ShiftAB = "BOTTOMElvUI_Bar1BOTTOM097"
	elseif not E.db.lowresolutionset and (layout == 'nouveauphys') then
		if not E.db.movers then E.db.movers = {}; end
		E.db.movers.ElvAB_1 = "BOTTOMElvUIParentBOTTOM054"
		E.db.movers.ElvAB_2 = "BOTTOMElvUIParentBOTTOM020"
		E.db.movers.ElvAB_3 = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT0137"
		E.db.movers.ElvAB_4 = "RIGHTElvUIParentRIGHT-10"
		E.db.movers.ElvAB_5 = "BOTTOMLEFTElvUIParentBOTTOMLEFT0137"
		E.db.movers.PetAB = "BOTTOMElvUIParentBOTTOM0110"
		E.db.movers.ShiftAB = "BOTTOMElvUIParentBOTTOM0150"
		E.db.movers.BossButton = "BOTTOMElvUIParentBOTTOM0271"
		E.db.movers.TotemBarMover = "BOTTOMElvUIParentBOTTOM0150"
		E.db.movers.ClassBarMover = "TOPLEFTElvUF_PlayerTOPLEFT6-6"
		-- E.db.movers.ComboBarMover = "TOPLEFTElvUF_PlayerTOPLEFT6-6"
		E.db.movers.MicrobarMover = "TOPRIGHTElvUIParentTOPRIGHT-248-2"
		E.db.movers.ElvUF_PlayerMover = "BOTTOMElvUIParentBOTTOM-297148"
		E.db.movers.ElvUF_PetMover = "BOTTOMLEFTElvUIParentBOTTOMLEFT432148"
		E.db.movers.ElvUF_PetTargetMover = "BOTTOMLEFTElvUIParentBOTTOMLEFT432107"
		E.db.movers.ElvUF_TargetMover = "BOTTOMElvUIParentBOTTOM297148"
		E.db.movers.ElvUF_TargetTargetMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-432148"
		E.db.movers.ElvUF_TargetTargetTargetMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-432107"
		E.db.movers.ElvUF_FocusMover = "TOPLEFTElvUIParentTOPLEFT250-290"
		-- E.db.movers.ElvUF_FocusMover = "LEFTElvUIParentLEFT500-50"
		E.db.movers.ElvUF_FocusTargetMover = "LEFTElvUF_FocusRIGHT10"
		E.db.movers.ElvUF_PlayerCastbarMover = "BOTTOMElvUIParentBOTTOM0244"
		E.db.movers.ElvUF_PetCastbarMover = "BOTTOMElvUIParentBOTTOM0190"
		E.db.movers.ElvUF_TargetCastbarMover = "BOTTOMElvUIParentBOTTOM0217"
		E.db.movers.ElvUF_PartyMover = "BOTTOMLEFTElvUIParentBOTTOMLEFT1179"
		E.db.movers.ElvUF_RaidMover = "TOPLEFTElvUIParentBOTTOMLEFT1450"
		E.db.movers.ElvUF_Raid40Mover = "TOPLEFTElvUIParentBOTTOMLEFT1516"
		E.db.movers.ElvUF_RaidpetMover = "TOPLEFTElvUIParentBOTTOMLEFT1240"
		-- E.db.movers.ElvUF_BodyGuardMover = "BOTTOMLEFTElvUIParentBOTTOMLEFT43373"
		E.db.movers.ElvUF_AssistMover = "LEFTElvUIParentLEFT1107"
		E.db.movers.ElvUF_TankMover = "LEFTElvUIParentLEFT1171"
		E.db.movers.ArenaHeaderMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-219200"
		E.db.movers.BossHeaderMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-219200"
		E.db.movers.BagsMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-4232"
		E.db.movers.TooltipMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-1181"
		E.db.movers.BuffsMover = "TOPLEFTElvUIParentTOPLEFT2-2"
		E.db.movers.DebuffsMover = "TOPLEFTElvUIParentTOPLEFT2-147"
		E.db.movers.VehicleSeatMover = "TOPLEFTElvUIParentTOPLEFT2-196"
		E.db.movers.MirrorTimer1Mover = "TOPElvUIParentTOP0-137"
		E.db.movers.MirrorTimer2Mover = "TOPElvUIParentTOP0-157"
		E.db.movers.MirrorTimer3Mover = "TOPElvUIParentTOP0-177"
		E.db.movers.LeftChatMover = "BOTTOMLEFTElvUIParentBOTTOMLEFT223"
		E.db.movers.RightChatMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-223"
		E.db.movers.LootFrameMover = "TOPRIGHTElvUIParentTOPRIGHT-466-290"
		E.db.movers.ObjectiveFrameMover = "TOPRIGHTElvUIParentTOPRIGHT-135-290"
		E.db.movers.GMMover = "TOPRIGHTElvUIParentTOPRIGHT-248-87"
		E.db.movers.BNETMover = "TOPRIGHTElvUIParentTOPRIGHT-248-35"
		E.db.movers.AltPowerBarMover = "TOPElvUIParentTOP0-26"
		E.db.movers.AlertFrameMover = "TOPElvUIParentTOP0-81"
		E.db.movers.MinimapMover = "TOPRIGHTElvUIParentTOPRIGHT-2-2"
		E.db.movers.ReputationBarMover = "TOPRIGHTElvUIParentTOPRIGHT-2-227"
		E.db.movers.ExperienceBarMover = "TOPRIGHTElvUIParentTOPRIGHT-2-240"
		E.db.movers.ArtifactBarMover = "TOPRIGHTElvUIParentTOPRIGHT-2-253"
		E.db.movers.HonorBarMover = "TOPRIGHTElvUIParentTOPRIGHT-2-266"
		E.db.movers.TalkingHeadFrameMover = "TOPElvUIParentTOP0-290"
		E.db.movers.BottomBarMover = "BOTTOMElvUIParentBOTTOM02"

	elseif E.db.lowresolutionset and (layout == 'nouveauphys') then
		if not E.db.movers then E.db.movers = {}; end
		E.db.movers.ElvAB_3 = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-2135"
		E.db.movers.ElvAB_5 = "BOTTOMLEFTElvUIParentBOTTOMLEFT2135"
		E.db.movers.ElvUF_PlayerMover = "BOTTOMElvUIParentBOTTOM-272180"
		E.db.movers.ElvUF_TargetMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-438180"
		E.db.movers.ElvUF_PetTargetMover = "BOTTOMLEFTElvUIParentBOTTOMLEFT438103"
		E.db.movers.ElvUF_TargetTargetTargetMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-438103"
		E.db.movers.ElvUF_FocusMover = "TOPLEFTElvUIParentTOPLEFT250-427"
		E.db.movers.ClassBarMover = "BOTTOMLEFTElvUIParentBOTTOMLEFT453216"
		E.db.movers.BagsMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-4032"
		E.db.movers.ElvUF_PlayerCastbarMover = "BOTTOMElvUIParentBOTTOM0267"
		E.db.movers.ElvUF_TargetCastbarMover = "BOTTOMElvUIParentBOTTOM0239"
		E.db.movers.BossButton = "BOTTOMLEFTElvUIParentBOTTOMLEFT43823"
		E.db.movers.VehicleSeatMover = "TOPLEFTElvUIParentTOPLEFT2-214"
		E.db.movers.ElvUF_PartyMover = "BOTTOMLEFTElvUIParentBOTTOMLEFT2178"
		E.db.movers.ElvUF_RaidMover = "BOTTOMLEFTElvUIParentBOTTOMLEFT2178"
		E.db.movers.ElvUF_Raid40Mover = "BOTTOMLEFTElvUIParentBOTTOMLEFT2178"
		E.db.movers.ElvUF_RaidpetMover = "BOTTOMLEFTElvUIParentBOTTOMLEFT2490"
		E.db.movers.ElvUF_AssistMover = "TOPLEFTElvUIParentTOPLEFT2-431"
		E.db.movers.ElvUF_TankMover = "TOPLEFTElvUIParentTOPLEFT2-361"
		E.db.movers.ArenaHeaderMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-120178"
		E.db.movers.BossHeaderMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-120178"
		E.db.movers.TooltipMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-1153"
		E.db.movers.LootFrameMover = "TOPLEFTElvUIParentTOPLEFT368-240"
		E.db.movers.BuffsMover = "TOPRIGHTElvUIParentTOPRIGHT-247-2"
		E.db.movers.TempEnchantMover = "TOPRIGHTBuffsMoverBOTTOMRIGHT0-4"
		E.db.movers.MicrobarMover = "BOTTOMRIGHTRightChatToggleButtonTOPRIGHT0130"
		E.db.movers.BNETMover = "TOPRIGHTMMHolderBOTTOMRIGHT0-27"
		E.db.movers.WatchFrameMover = "TOPRIGHTElvUIParentTOPRIGHT-116-322"
		E.db.movers.GMMover = "TOPRIGHTMMHolderBOTTOMRIGHT0-50"
		E.db.movers.TotemBarMover = "BOTTOMElvUI_Bar1BOTTOM0138"
		E.db.movers.PetAB = "BOTTOMElvUI_Bar1BOTTOM057"
		E.db.movers.ShiftAB = "BOTTOMElvUI_Bar1BOTTOM097"
	elseif not E.db.lowresolutionset and (layout == 'nouveaucast') then
		if not E.db.movers then E.db.movers = {}; end
		E.db.movers.ElvAB_1 = "BOTTOMElvUIParentBOTTOM058"
		E.db.movers.ElvAB_2 = "BOTTOMElvUIParentBOTTOM022"
		E.db.movers.ElvAB_3 = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-1139"
		E.db.movers.ElvAB_4 = "RIGHTElvUIParentRIGHT-10"
		E.db.movers.ElvAB_5 = "BOTTOMLEFTElvUIParentBOTTOMLEFT1139"
		E.db.movers.PetAB = "BOTTOMElvUIParentBOTTOM0121"
		E.db.movers.ShiftAB = "BOTTOMElvUIParentBOTTOM0163"
		E.db.movers.BossButton = "BOTTOMLEFTElvUIParentBOTTOMLEFT59919"
		E.db.movers.TotemBarMover = "BOTTOMElvUIParentBOTTOM0204"
		E.db.movers.ClassBarMover = "TOPLEFTElvUF_PlayerTOPLEFT6-6"
		-- E.db.movers.ComboBarMover = "TOPLEFTElvUF_PlayerTOPLEFT6-6"
		E.db.movers.MicrobarMover = "TOPRIGHTElvUIParentTOPRIGHT-250-1"
		E.db.movers.ElvUF_PlayerMover = "BOTTOMElvUIParentBOTTOM-294161"
		E.db.movers.ElvUF_PetMover = "BOTTOMLEFTElvUIParentBOTTOMLEFT433161"
		E.db.movers.ElvUF_PetTargetMover = "BOTTOMLEFTElvUIParentBOTTOMLEFT433117"
		E.db.movers.ElvUF_TargetMover = "BOTTOMElvUIParentBOTTOM294161"
		E.db.movers.ElvUF_TargetTargetMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-433161"
		E.db.movers.ElvUF_TargetTargetTargetMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-433117"
		E.db.movers.ElvUF_FocusMover = "TOPLEFTElvUIParentTOPLEFT316-360"
		E.db.movers.ElvUF_FocusTargetMover = "RIGHTElvUF_FocusRIGHT1020"
		E.db.movers.ElvUF_PlayerCastbarMover = "BOTTOMElvUIParentBOTTOM0297"
		E.db.movers.ElvUF_PetCastbarMover = "BOTTOMElvUIParentBOTTOM0245"
		E.db.movers.ElvUF_TargetCastbarMover = "BOTTOMElvUIParentBOTTOM0271"
		E.db.movers.ElvUF_PartyMover = "BOTTOMLEFTElvUIParentBOTTOMLEFT1235"
		E.db.movers.ElvUF_RaidMover = "TOPLEFTElvUIParentBOTTOMLEFT1543"
		E.db.movers.ElvUF_Raid40Mover = "TOPLEFTElvUIParentBOTTOMLEFT1543"
		E.db.movers.ElvUF_RaidpetMover = "TOPLEFTElvUIParentBOTTOMLEFT1608"
		-- E.db.movers.ElvUF_BodyGuardMover = "BOTTOMLEFTElvUIParentBOTTOMLEFT43373"
		E.db.movers.ElvUF_AssistMover = "LEFTElvUIParentLEFT1100"
		E.db.movers.ElvUF_TankMover = "LEFTElvUIParentLEFT1180"
		E.db.movers.ArenaHeaderMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-184214"
		E.db.movers.BossHeaderMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-184214"
		E.db.movers.BagsMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-4232"
		E.db.movers.TooltipMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-1168"
		E.db.movers.BuffsMover = "TOPLEFTElvUIParentTOPLEFT2-2"
		E.db.movers.DebuffsMover = "TOPLEFTElvUIParentTOPLEFT2-147"
		E.db.movers.VehicleSeatMover = "TOPLEFTElvUIParentTOPLEFT2-196"
		E.db.movers.MirrorTimer1Mover = "TOPElvUIParentTOP0-137"
		E.db.movers.MirrorTimer2Mover = "TOPElvUIParentTOP0-162"
		E.db.movers.MirrorTimer3Mover = "TOPElvUIParentTOP0-187"
		E.db.movers.LeftChatMover = "BOTTOMLEFTElvUIParentBOTTOMLEFT22"
		E.db.movers.RightChatMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-22"
		E.db.movers.LootFrameMover = "TOPRIGHTElvUIParentTOPRIGHT-466-300"
		E.db.movers.GMMover = "TOPRIGHTElvUIParentTOPRIGHT-250-86"
		E.db.movers.BNETMover = "TOPRIGHTElvUIParentTOPRIGHT-250-34"
		E.db.movers.AltPowerBarMover = "TOPElvUIParentTOP0-26"
		E.db.movers.AlertFrameMover = "TOPElvUIParentTOP0-81"
		E.db.movers.MinimapMover = "TOPRIGHTElvUIParentTOPRIGHT-2-2"
		E.db.movers.ReputationBarMover = "TOPRIGHTElvUIParentTOPRIGHT-2-230"
		E.db.movers.ExperienceBarMover = "TOPRIGHTElvUIParentTOPRIGHT-2-243"
		E.db.movers.ArtifactBarMover = "TOPRIGHTElvUIParentTOPRIGHT-2-256"
		E.db.movers.HonorBarMover = "TOPRIGHTElvUIParentTOPRIGHT-2-269"
	elseif E.db.lowresolutionset and (layout == 'nouveaucast') then
		if not E.db.movers then E.db.movers = {}; end
		E.db.movers.ElvAB_3 = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-2135"
		E.db.movers.ElvAB_5 = "BOTTOMLEFTElvUIParentBOTTOMLEFT2135"
		E.db.movers.ElvUF_PlayerMover = "BOTTOMElvUIParentBOTTOM-272180"
		E.db.movers.ElvUF_TargetMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-438180"
		E.db.movers.ElvUF_PetTargetMover = "BOTTOMLEFTElvUIParentBOTTOMLEFT438103"
		E.db.movers.ElvUF_TargetTargetTargetMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-438103"
		E.db.movers.ElvUF_FocusMover = "TOPLEFTElvUIParentTOPLEFT250-427"
		E.db.movers.ClassBarMover = "BOTTOMLEFTElvUIParentBOTTOMLEFT453216"
		E.db.movers.BagsMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-4032"
		E.db.movers.ElvUF_PlayerCastbarMover = "BOTTOMElvUIParentBOTTOM0267"
		E.db.movers.ElvUF_TargetCastbarMover = "BOTTOMElvUIParentBOTTOM0239"
		E.db.movers.BossButton = "BOTTOMLEFTElvUIParentBOTTOMLEFT43823"
		E.db.movers.VehicleSeatMover = "TOPLEFTElvUIParentTOPLEFT2-214"
		E.db.movers.ElvUF_PartyMover = "BOTTOMLEFTElvUIParentBOTTOMLEFT2178"
		E.db.movers.ElvUF_RaidMover = "BOTTOMLEFTElvUIParentBOTTOMLEFT2178"
		E.db.movers.ElvUF_Raid40Mover = "BOTTOMLEFTElvUIParentBOTTOMLEFT2178"
		E.db.movers.ElvUF_RaidpetMover = "BOTTOMLEFTElvUIParentBOTTOMLEFT2490"
		E.db.movers.ElvUF_AssistMover = "TOPLEFTElvUIParentTOPLEFT2-431"
		E.db.movers.ElvUF_TankMover = "TOPLEFTElvUIParentTOPLEFT2-361"
		E.db.movers.ArenaHeaderMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-120178"
		E.db.movers.BossHeaderMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-120178"
		E.db.movers.TooltipMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-1153"
		E.db.movers.LootFrameMover = "TOPLEFTElvUIParentTOPLEFT368-240"
		E.db.movers.BuffsMover = "TOPRIGHTElvUIParentTOPRIGHT-247-2"
		E.db.movers.TempEnchantMover = "TOPRIGHTBuffsMoverBOTTOMRIGHT0-4"
		E.db.movers.MicrobarMover = "BOTTOMRIGHTRightChatToggleButtonTOPRIGHT0130"
		E.db.movers.BNETMover = "TOPRIGHTMMHolderBOTTOMRIGHT0-27"
		E.db.movers.WatchFrameMover = "TOPRIGHTElvUIParentTOPRIGHT-116-322"
		E.db.movers.GMMover = "TOPRIGHTMMHolderBOTTOMRIGHT0-50"
		E.db.movers.TotemBarMover = "BOTTOMElvUI_Bar1BOTTOM0138"
		E.db.movers.PetAB = "BOTTOMElvUI_Bar1BOTTOM057"
		E.db.movers.ShiftAB = "BOTTOMElvUI_Bar1BOTTOM097"
	-- Classic Tank, DPS theme
	elseif not E.db.lowresolutionset then
		if not E.db.movers then E.db.movers = {}; end
		E.db.movers.ElvAB_1 = "BOTTOMElvUIParentBOTTOM058"
		E.db.movers.ElvAB_2 = "BOTTOMElvUIParentBOTTOM022"
		E.db.movers.ElvAB_3 = "LEFTElvUI_Bar2RIGHT30"
		E.db.movers.ElvAB_5 = "RIGHTElvUI_Bar2LEFT-30"
		E.db.movers.PetAB = "BOTTOMElvUIParentBOTTOM0121"
		E.db.movers.ShiftAB = "BOTTOMElvUIParentBOTTOM0163"
		E.db.movers.BossButton = "BOTTOMLEFTElvUIParentBOTTOMLEFT59919"
		E.db.movers.TotemBarMover = "BOTTOMElvUIParentBOTTOM0204"
		E.db.movers.ClassBarMover = "TOPLEFTElvUF_PlayerTOPLEFT8-7"
		-- E.db.movers.ComboBarMover = "TOPLEFTElvUF_PlayerTOPLEFT8-7"
		E.db.movers.ElvUF_PlayerMover = "BOTTOMElvUIParentBOTTOM-297162"
		E.db.movers.ElvUF_PetMover = "BOTTOMLEFTElvUF_PlayerBOTTOMLEFT0-41"
		E.db.movers.ElvUF_PetTargetMover = "LEFTElvUF_PetRIGHT440"
		E.db.movers.ElvUF_TargetMover = "BOTTOMElvUIParentBOTTOM297162"
		E.db.movers.ElvUF_TargetTargetMover = "BOTTOMRIGHTElvUF_TargetBOTTOMRIGHT0-41"
		E.db.movers.ElvUF_TargetTargetTargetMover = "RIGHTElvUF_TargetTargetLEFT-440"
		E.db.movers.ElvUF_FocusMover = "BOTTOMLEFTElvUF_PlayerTOPLEFT-200448"
		E.db.movers.ElvUF_FocusTargetMover = "RIGHTElvUF_FocusRIGHT1020"
		E.db.movers.ElvUF_PlayerCastbarMover = "BOTTOMElvUIParentBOTTOM0297"
		E.db.movers.ElvUF_PetCastbarMover = "BOTTOMElvUIParentBOTTOM0245"
		E.db.movers.ElvUF_TargetCastbarMover = "BOTTOMElvUIParentBOTTOM0271"
		E.db.movers.ElvUF_PartyMover = "BOTTOMLEFTElvUIParentBOTTOMLEFT2198"
		E.db.movers.ElvUF_RaidMover = "BOTTOMLEFTElvUIParentBOTTOMLEFT2198"
		E.db.movers.ElvUF_Raid40Mover = "BOTTOMLEFTElvUIParentBOTTOMLEFT2198"
		E.db.movers.ElvUF_RaidpetMover = "LEFTElvUIParentLEFT236"
		-- E.db.movers.ElvUF_BodyGuardMover = "RIGHTElvUF_PlayerLEFT-60"
		E.db.movers.ElvUF_AssistMover = "LEFTElvUIParentLEFT2100"
		E.db.movers.ElvUF_TankMover = "LEFTElvUIParentLEFT2180"
		E.db.movers.ArenaHeaderMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-215270"
		E.db.movers.BossHeaderMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-215270"
		E.db.movers.BagsMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-4232"
		E.db.movers.TooltipMover = "BOTTOMRIGHTElvUIParentBOTTOMRIGHT-1168"
		E.db.movers.MinimapMover = "TOPRIGHTElvUIParentTOPRIGHT-4-1"
		E.db.movers.ReputationBarMover = "TOPMMHolderBOTTOM21"
		E.db.movers.ExperienceBarMover = "TOPMMHolderBOTTOM2-12"
		E.db.movers.VehicleSeatMover = "TOPLEFTElvUIParentTOPLEFT2-198"
		E.db.movers.MirrorTimer1Mover = "TOPElvUIParentTOP0-137"
		E.db.movers.MirrorTimer2Mover = "TOPElvUIParentTOP0-162"
		E.db.movers.MirrorTimer3Mover = "TOPElvUIParentTOP0-187"
		E.db.movers.ClassBarMover = "TOPElvUF_PlayerTOP02"
		-- E.db.movers.ComboBarMover = "TOPElvUF_PlayerTOP02"
		E.db.actionbar.bar3.buttonsPerRow = 6;
		E.db.actionbar.bar5.buttonsPerRow = 6;
		E.db.actionbar.fontSize = 12;
		E.db.actionbar.font = "AgencyFB Bold";
		E.db.bags.xOffset = 0;
		E.db.bags.xOffsetBank = 0;
		E.db.bags.yOffset = 110;
		E.db.bags.yOffsetBank = 110;
		E.db.bags.alignToChat = true;
		E.db.chat.font = "AgencyFB Bold";
		E.db.chat.tabFontSize = 12;
		E.db.chat.panelWidth = 407;
		E.db.chat.panelHeight = 137;
		E.db.chat.tabFont = "AgencyFB Bold";
		E.db.datatexts.fontSize = 12;
		E.db.datatexts.font = "AgencyFB Bold";
		E.db.general.fontSize = 12;
		E.db.general.font = "AgencyFB Bold";
		E.db.tooltip.healthBar.height = 13;
		E.db.tooltip.healthBar.font = "AgencyFB Bold";
		E.db.unitframe.fontSize = 12;
		E.db.unitframe.font = "AgencyFB Bold";
		E.db.unitframe.units.player.classbar.height = 9;
		E.db.unitframe.units.player.debuffs.yOffset = 5;
		E.db.unitframe.units.player.pvp.position = "TOPRIGHT";
		-- E.db.unitframe.units.target.combobar.height = 9;
		E.db.unitframe.units.targettargettarget.buffs.enable = false;
		E.db.unitframe.units.targettargettarget.debuffs.enable = false;
		-- E.db.unitframe.units.bodyguard.width = 100;
	end

	--Datatexts
	if not noDataReset then
		E:CopyTable(E.db.datatexts.panels, P.datatexts.panels)
		if layout == 'tank' then
			E.db.datatexts.panels.ActionBarPanelTwo.middle = 'Attack Power';
			E.db.datatexts.panels.ActionBarPanelThree.middle = 'Haste';
			E.db.datatexts.panels.LeftChatDataPanel.middle = 'Improved System';
			E.db.datatexts.panels.ActionBarPanelOne.left = 'Mastery';
			E.db.datatexts.panels.ActionBarPanelOne.right = 'Avoidance';
			E.db.datatexts.panels.ActionBarPanelOne.middle = 'Talent/Loot Specialization';
			E.db.datatexts.panels.LeftMiniPanel = 'DPS';
			E.db.datatexts.panels.RightMiniPanel = 'HPS';
		elseif layout == 'healer' then
			E.db.datatexts.panels.ActionBarPanelTwo.middle = 'Spell/Heal Power';
			E.db.datatexts.panels.ActionBarPanelThree.middle = 'Mana Regen';
			E.db.datatexts.panels.LeftChatDataPanel.middle = 'Improved System';
			E.db.datatexts.panels.ActionBarPanelOne.left = 'Raid-Damage Taken';
			E.db.datatexts.panels.ActionBarPanelOne.right = 'Raid-HPS';
			E.db.datatexts.panels.ActionBarPanelOne.middle = 'Talent/Loot Specialization';
			E.db.datatexts.panels.LeftMiniPanel = 'HPS';
			E.db.datatexts.panels.RightMiniPanel = 'DPS';
		elseif layout == 'dpsCaster' then
			E.db.datatexts.panels.ActionBarPanelTwo.middle = 'Spell/Heal Power';
			E.db.datatexts.panels.ActionBarPanelThree.middle = 'Haste';
			E.db.datatexts.panels.LeftChatDataPanel.middle = 'Improved System';
			E.db.datatexts.panels.ActionBarPanelOne.left = 'NONE';
			E.db.datatexts.panels.ActionBarPanelOne.right = 'NONE';
			E.db.datatexts.panels.ActionBarPanelOne.middle = 'Talent/Loot Specialization';
			E.db.datatexts.panels.LeftMiniPanel = 'DPS';
			E.db.datatexts.panels.RightMiniPanel = 'HPS';
		elseif layout == 'blizzard' then
			E.db.datatexts.panels.ActionBarPanelTwo.middle = 'Mastery';
			E.db.datatexts.panels.ActionBarPanelThree.middle = 'Haste';
			E.db.datatexts.panels.LeftChatDataPanel.middle = 'Improved System';
			E.db.datatexts.panels.ActionBarPanelOne.left = 'NONE';
			E.db.datatexts.panels.ActionBarPanelOne.right = 'NONE';
			E.db.datatexts.panels.ActionBarPanelOne.middle = 'Talent/Loot Specialization';
			E.db.datatexts.panels.LeftMiniPanel = 'DPS';
			E.db.datatexts.panels.RightMiniPanel = 'HPS';
		elseif layout == 'nouveaufull' then
			E.db.datatexts.panels.ActionBarPanelTwo.middle = 'NONE';
			E.db.datatexts.panels.ActionBarPanelThree.middle = 'NONE';
			E.db.datatexts.panels.LeftChatDataPanel.middle = 'Improved System';
			E.db.datatexts.panels.ActionBarPanelOne.left = 'Mastery';
			E.db.datatexts.panels.ActionBarPanelOne.right = 'Haste';
			E.db.datatexts.panels.ActionBarPanelOne.middle = 'Talent/Loot Specialization';
			E.db.datatexts.panels.LeftMiniPanel = 'DPS';
			E.db.datatexts.panels.RightMiniPanel = 'HPS';
		elseif layout == 'nouveauheal' then
			E.db.datatexts.panels.ActionBarPanelTwo.middle = 'NONE';
			E.db.datatexts.panels.ActionBarPanelThree.middle = 'NONE';
			E.db.datatexts.panels.LeftChatDataPanel.middle = 'Improved System';
			E.db.datatexts.panels.ActionBarPanelOne.left = 'Raid-Damage Taken';
			E.db.datatexts.panels.ActionBarPanelOne.right = 'Raid-HPS';
			E.db.datatexts.panels.ActionBarPanelOne.middle = 'Talent/Loot Specialization';
			E.db.datatexts.panels.LeftMiniPanel = 'HPS';
			E.db.datatexts.panels.RightMiniPanel = 'DPS';
		elseif layout == 'nouveauphys' then
			E.db.datatexts.panels.ActionBarPanelTwo.middle = 'NONE';
			E.db.datatexts.panels.ActionBarPanelThree.middle = 'NONE';
			E.db.datatexts.panels.LeftChatDataPanel.middle = 'Improved System';
			E.db.datatexts.panels.ActionBarPanelOne.left = 'Attack Power';
			E.db.datatexts.panels.ActionBarPanelOne.right = 'Haste';
			E.db.datatexts.panels.ActionBarPanelOne.middle = 'Talent/Loot Specialization';
			E.db.datatexts.panels.LeftMiniPanel = 'DPS';
			E.db.datatexts.panels.RightMiniPanel = 'HPS';
		elseif layout == 'nouveaucast' then
			E.db.datatexts.panels.ActionBarPanelTwo.middle = 'NONE';
			E.db.datatexts.panels.ActionBarPanelThree.middle = 'NONE';
			E.db.datatexts.panels.LeftChatDataPanel.middle = 'Improved System';
			E.db.datatexts.panels.ActionBarPanelOne.left = 'Spell/Heal Power';
			E.db.datatexts.panels.ActionBarPanelOne.right = 'Haste';
			E.db.datatexts.panels.ActionBarPanelOne.middle = 'Talent/Loot Specialization';
			E.db.datatexts.panels.LeftMiniPanel = 'DPS';
			E.db.datatexts.panels.RightMiniPanel = 'HPS';
		elseif layout == 'nouveauminimal' then
			E.db.datatexts.panels.ActionBarPanelTwo.middle = 'NONE';
			E.db.datatexts.panels.ActionBarPanelThree.middle = 'NONE';
			E.db.datatexts.panels.LeftChatDataPanel.middle = 'Improved System';
			E.db.datatexts.panels.ActionBarPanelOne.left = 'Mastery';
			E.db.datatexts.panels.ActionBarPanelOne.right = 'Haste';
			E.db.datatexts.panels.ActionBarPanelOne.middle = 'Talent/Loot Specialization';
			E.db.datatexts.panels.LeftMiniPanel = 'DPS';
			E.db.datatexts.panels.RightMiniPanel = 'HPS';
		else
			E.db.datatexts.panels.ActionBarPanelTwo.middle = 'Attack Power';
			E.db.datatexts.panels.ActionBarPanelThree.middle = 'Haste';
			E.db.datatexts.panels.LeftChatDataPanel.middle = 'Improved System';
			E.db.datatexts.panels.ActionBarPanelOne.left = 'NONE';
			E.db.datatexts.panels.ActionBarPanelOne.right = 'NONE';
			E.db.datatexts.panels.ActionBarPanelOne.middle = 'Talent/Loot Specialization';
			E.db.datatexts.panels.LeftMiniPanel = 'DPS';
			E.db.datatexts.panels.RightMiniPanel = 'HPS';
		end
		if InstallStepComplete then
			InstallStepComplete.message = L["Layout Set"]
			InstallStepComplete:Show()
		end
	end

	--Datatexts
	if not noDataReset and InstallStepComplete then
		InstallStepComplete.message = L["Layout Set"]
		InstallStepComplete:Show()
	end

	E.db.layoutSet = layout

	if not noDataReset and E.private.theme then
		E:SetupTheme(E.private.theme, true)
	end

	E:UpdateAll(true)
end

local function SetupAuras(style)
	-- E:CopyTable(E.db.unitframe.units.player.buffs, P.unitframe.units.player.buffs)
	-- E:CopyTable(E.db.unitframe.units.player.debuffs, P.unitframe.units.player.debuffs)
	-- E:CopyTable(E.db.unitframe.units.player.aurabar, P.unitframe.units.player.aurabar)
	-- E:CopyTable(E.db.unitframe.units.target.buffs, P.unitframe.units.target.buffs)
	-- E:CopyTable(E.db.unitframe.units.target.debuffs, P.unitframe.units.target.debuffs)
	-- E:CopyTable(E.db.unitframe.units.target.aurabar, P.unitframe.units.target.aurabar)
	-- E.db.unitframe.units.target.smartAuraDisplay = P.unitframe.units.target.smartAuraDisplay
	-- E:CopyTable(E.db.unitframe.units.focus.buffs, P.unitframe.units.focus.buffs)
	-- E:CopyTable(E.db.unitframe.units.focus.debuffs, P.unitframe.units.focus.debuffs)
	-- E:CopyTable(E.db.unitframe.units.focus.aurabar, P.unitframe.units.focus.aurabar)
	-- E.db.unitframe.units.focus.smartAuraDisplay = P.unitframe.units.focus.smartAuraDisplay
	if not style then
		--PLAYER
		E.db.unitframe.units.player.buffs.enable = true;
		-- E.db.unitframe.units.player.buffs.attachTo = 'FRAME';
		E.db.unitframe.units.player.buffs.noDuration = false;
		-- E.db.unitframe.units.player.debuffs.attachTo = 'BUFFS';
		E.db.unitframe.units.player.aurabar.enable = false;
		E:GetModule('UnitFrames'):CreateAndUpdateUF("player")
		--TARGET
		-- E.db.unitframe.units.target.smartAuraDisplay = 'DISABLED';
		-- E.db.unitframe.units.target.debuffs.enable = true;
		-- E.db.unitframe.units.target.aurabar.enable = false;
	elseif style == 'standard' then
		E.db.unitframe.units.target.smartAuraDisplay = 'DISABLED';
		E.db.unitframe.units.target.buffs.playerOnly = {friendly = false, enemy = false};
		E.db.unitframe.units.target.debuffs.enable = true;
		-- E.db.unitframe.units.target.aurabar.attachTo = 'DEBUFFS';
	elseif style == 'aurabarsonly' then
		E.db.unitframe.units.player.aurabar.enable = true;
		E.db.unitframe.units.player.buffs.enable = false;
		E.db.unitframe.units.player.debuffs.enable = false;
		E.db.unitframe.units.player.smartAuraDisplay = 'DISABLED';
		-- E.db.unitframe.units.player.aurabar.attachTo = 'FRAME';
		E.db.unitframe.units.player.aurabar.noConsolidated = false;
		E.db.unitframe.units.player.aurabar.useWhitelist = false;
		E.db.unitframe.units.player.aurabar.playerOnly = false;
		E.db.unitframe.units.player.aurabar.useBlacklist = false;
		E.db.unitframe.units.player.aurabar.noDuration = false;
		E.db.unitframe.units.target.aurabar.enable = true;
		E.db.unitframe.units.target.buffs.enable = false;
		E.db.unitframe.units.target.debuffs.enable = false;
		E.db.unitframe.units.target.smartAuraDisplay = 'DISABLED';
		-- E.db.unitframe.units.target.aurabar.attachTo = 'FRAME';
		E.db.unitframe.units.target.aurabar.noConsolidated = {friendly = false, enemy = false};
		E.db.unitframe.units.target.aurabar.playerOnly = {friendly = false, enemy = false};
		E.db.unitframe.units.target.aurabar.useBlacklist = {friendly = false, enemy = false};
		E.db.unitframe.units.target.aurabar.noDuration = {friendly = false, enemy = false};
	elseif style == 'all' then
		E.db.unitframe.units.player.buffs.enable = true;
		-- E.db.unitframe.units.player.buffs.attachTo = 'FRAME';
		E.db.unitframe.units.player.debuffs.enable = true;
		-- E.db.unitframe.units.player.debuffs.attachTo = 'BUFFS';
		E.db.unitframe.units.player.aurabar.enable = true;
		E.db.unitframe.units.player.smartAuraDisplay = 'DISABLED';
		-- E.db.unitframe.units.player.aurabar.attachTo = 'DEBUFFS';
		E.db.unitframe.units.player.aurabar.noConsolidated = true;
		E.db.unitframe.units.player.aurabar.useWhitelist = true;
		E.db.unitframe.units.player.aurabar.playerOnly = true;
		E.db.unitframe.units.player.aurabar.useBlacklist = true;
		E.db.unitframe.units.player.aurabar.noDuration = true;
		E.db.unitframe.units.target.buffs.enable = true;
		-- E.db.unitframe.units.target.buffs.attachTo = 'FRAME';
		E.db.unitframe.units.target.debuffs.enable = true;
		-- E.db.unitframe.units.target.debuffs.attachTo = 'BUFFS';
		E.db.unitframe.units.target.aurabar.enable = true;
		E.db.unitframe.units.target.smartAuraDisplay = 'DISABLED';
		-- E.db.unitframe.units.target.aurabar.attachTo = 'DEBUFFS';
		E.db.unitframe.units.target.aurabar.noConsolidated = {friendly = false, enemy = false};
		E.db.unitframe.units.target.aurabar.playerOnly = {friendly = false, enemy = false};
		E.db.unitframe.units.target.aurabar.useBlacklist = {friendly = false, enemy = false};
		E.db.unitframe.units.target.aurabar.noDuration = {friendly = false, enemy = false};
		E:GetModule('UnitFrames'):CreateAndUpdateUF("target")
	end

	if InstallStepComplete then
		InstallStepComplete.message = L["Auras Set"]
		InstallStepComplete:Show()
	end
end

local function InstallComplete()
	E.private.install_complete = E.version

	if GetCVarBool("Sound_EnableMusic") then
		StopMusic()
	end

	ReloadUI()
end

local function ResetAll()
	InstallNextButton:Disable()
	InstallPrevButton:Disable()
	InstallOption1Button:Hide()
	InstallOption1Button:SetScript("OnClick", nil)
	InstallOption1Button:SetText("")
	InstallOption2Button:Hide()
	InstallOption2Button:SetScript('OnClick', nil)
	InstallOption2Button:SetText('')
	InstallOption3Button:Hide()
	InstallOption3Button:SetScript('OnClick', nil)
	InstallOption3Button:SetText('')
	InstallOption4Button:Hide()
	InstallOption4Button:SetScript('OnClick', nil)
	InstallOption4Button:SetText('')
	InstallOption5Button:Hide()
	InstallOption5Button:SetScript('OnClick', nil)
	InstallOption5Button:SetText('')
	InstallOption6Button:Hide()
	InstallOption6Button:SetScript('OnClick', nil)
	InstallOption6Button:SetText('')
	InstallOption7Button:Hide()
	InstallOption7Button:SetScript('OnClick', nil)
	InstallOption7Button:SetText('')
	InstallOption8Button:Hide()
	InstallOption8Button:SetScript('OnClick', nil)
	InstallOption8Button:SetText('')
	InstallOption9Button:Hide()
	InstallOption9Button:SetScript('OnClick', nil)
	InstallOption9Button:SetText('')
	InstallOption10Button:Hide()
	InstallOption10Button:SetScript('OnClick', nil)
	InstallOption10Button:SetText('')
	InstallOption11Button:Hide()
	InstallOption11Button:SetScript('OnClick', nil)
	InstallOption11Button:SetText('')
	InstallOption12Button:Hide()
	InstallOption12Button:SetScript('OnClick', nil)
	InstallOption12Button:SetText('')
	InstallOption13Button:Hide()
	InstallOption13Button:SetScript('OnClick', nil)
	InstallOption13Button:SetText('')
	InstallOption14Button:Hide()
	InstallOption14Button:SetScript('OnClick', nil)
	InstallOption14Button:SetText('')
	InstallOption15Button:Hide()
	InstallOption15Button:SetScript('OnClick', nil)
	InstallOption15Button:SetText('')
	ElvUIInstallFrame.SubTitle:SetText("")
	ElvUIInstallFrame.Desc1:SetText("")
	ElvUIInstallFrame.Desc2:SetText("")
	ElvUIInstallFrame.Desc3:SetText("")
	ElvUIInstallFrame:Size(550, 400)
end

local function SetPage(PageNum)
	CURRENT_PAGE = PageNum
	ResetAll()
	InstallStatus.anim.progress:SetChange(PageNum)
	InstallStatus.anim.progress:Play()
	InstallStatus.text:SetText(CURRENT_PAGE.." / "..MAX_PAGE)

	local r, g, b = E:ColorGradient(CURRENT_PAGE / MAX_PAGE, 1, 0, 0, 1, 1, 0, 0, 1, 0)
	ElvUIInstallFrame.Status:SetStatusBarColor(r, g, b)
	local f = ElvUIInstallFrame

	if PageNum == MAX_PAGE then
		InstallNextButton:Disable()
	else
		InstallNextButton:Enable()
	end

	if PageNum == 1 then
		InstallPrevButton:Disable()
	else
		InstallPrevButton:Enable()
	end

	if PageNum == 1 then
		f.SubTitle:SetFormattedText(L["Welcome to |cffBD0101DecUI|r!"], E.version)
		f.Desc1:SetText(L["This install process will inform you about some of the features DecUI has to offer, and also prepare your user interface for usage."])
		f.Desc2:SetText(L["The in-game configuration menu can be accessed by clicking the 'C' button on the bottom-left of the right chat panel. You can also use |cffBD0101/dec|r or /ec. Press the button below if you wish to skip the installation process, AT THE RISK OF UI ISSUES."])
		f.Desc3:SetText(L["Please press the continue button to go to the next step."])
		InstallOption1Button:Show()
		InstallOption1Button:SetScript("OnClick", InstallComplete)
		InstallOption1Button:SetText(L["Skip Process"])
	elseif PageNum == 2 then
		f.SubTitle:SetText(L["CVars"])
		f.Desc1:SetText(L["This part of the process sets up your World of Warcraft default options. It's |cff07D400HIGHLY|r recommended you do this step for everything to behave properly."])
		f.Desc2:SetText(L["Please click the button below to setup your CVars."])
		f.Desc3:SetText(L["Importance: |cff07D400High|r"])
		InstallOption1Button:Show()
		InstallOption1Button:SetScript("OnClick", SetupCVars)
		InstallOption1Button:SetText(L["Setup CVars"])
	elseif PageNum == 3 then
		f.SubTitle:SetText(L["Chat"])
		f.Desc1:SetText(L["This part of the installation process sets up your chat window names, positions and chat channel text colors."])
		f.Desc2:SetText(L["The chat windows function the same as Blizzard standard chat windows, you can right click the tabs and drag them around, rename, etc. Please click the button below to setup your chat windows. You need to finish the install for chat windows to correct themselves."])
		f.Desc3:SetText(L["Importance: |cffD3CF00Medium|r"])
		InstallOption1Button:Show()
		InstallOption1Button:SetScript("OnClick", SetupChat)
		InstallOption1Button:SetText(L["Setup Chat"])
	elseif PageNum == 4 then
		f.SubTitle:SetText(L["Pixel Perfect"])
		f.Desc1:SetText(L['The Pixel Perfect option will change the overall apperance of your UI. Using Pixel Perfect is a slight performance increase over the traditional layout.'])
		f.Desc2:SetText(L['Using this option will cause your borders around frames to be 1 pixel wide instead of 3 pixel. You may have to finish the installation to notice a differance. By default this is enabled.'])
		f.Desc3:SetText(L["Importance: |cffFF0000Low|r"])
		InstallOption1Button:Show()
		InstallOption1Button:SetScript('OnClick', function() E:SetupPixelPerfect(true) end)
		InstallOption1Button:SetText(L["Enable"])
		InstallOption2Button:Show()
		InstallOption2Button:SetScript('OnClick', function() E:SetupPixelPerfect(false) end)
		InstallOption2Button:SetText(L['Disable'])
	elseif PageNum == 5 then
		f.SubTitle:SetText(L['Theme Setup'])
		f.Desc1:SetText(L['Choose the theme you wish to use for your initial setup.'])
		f.Desc2:SetText(L['You can always change fonts and colors of any element of DecUI from the in-game configuration.'])
		f.Desc3:SetText(L["Importance: |cffD3CF00Medium|r"])
		InstallOption1Button:Show()
		InstallOption1Button:SetScript('OnClick', function() E:SetupTheme('classic') end)
		InstallOption1Button:SetText(L["Classic"])
		InstallOption2Button:Show()
		InstallOption2Button:SetScript('OnClick', function() E:SetupTheme('class') end)
		InstallOption2Button:SetText(CLASS)
		InstallOption3Button:Show()
		InstallOption3Button:SetScript('OnClick', function() E:SetupTheme('Default') end)
		InstallOption3Button:SetText(L['Default'])
		InstallOption4Button:Show()
		InstallOption4Button:SetScript('OnClick', function() E:SetupTheme('darker') end)
		InstallOption4Button:SetText(L['Darker'])
		InstallOption5Button:Show()
		InstallOption5Button:SetScript('OnClick', function() E:SetupTheme('transparent') end)
		InstallOption5Button:SetText(L['Transparent'])
		InstallOption6Button:Show()
		InstallOption6Button:SetScript('OnClick', function() E:SetupTheme('transparentonebarcoolline') end)
		InstallOption6Button:SetText(L['The Above Themes'])
		InstallOption7Button:Show()
		InstallOption7Button:SetScript('OnClick', function() E:SetupTheme('darkeronebarcoolline') end)
		InstallOption7Button:SetText(L['CoolLine Option For'])
		InstallOption8Button:Show()
		InstallOption8Button:SetScript('OnClick', function() E:SetupTheme('defaultonebarcoolline') end)
		InstallOption8Button:SetText(L['The 1-Bar Width'])
		InstallOption9Button:Show()
		InstallOption9Button:SetScript('OnClick', function() E:SetupTheme('classonebarcoolline') end)
		InstallOption9Button:SetText(L['These Buttons Sets'])
		InstallOption10Button:Show()
		InstallOption10Button:SetScript('OnClick', function() E:SetupTheme('classiconebarcoolline') end)
		InstallOption10Button:SetText(L['Clicking One of'])
	elseif PageNum == 6 then
		f.SubTitle:SetText(L["Resolution"])
		f.Desc1:SetFormattedText(L["Your current resolution is %s, this is considered a %s resolution."], E.resolution, E.lowversion == true and L["low"] or L["high"])
		if E.lowversion then
			f.Desc2:SetText(L["This resolution requires that you change some settings to get everything to fit on your screen."].." "..L["Click the button below to resize your chat frames, unitframes, and reposition your actionbars."].." "..L["You may need to further alter these settings depending how low you resolution is."])
			f.Desc3:SetText(L["Importance: |cff07D400High|r"])
		else
			f.Desc2:SetText(L["This resolution doesn't require that you change settings for the UI to fit on your screen."].." "..L["Click the button below to resize your chat frames, unitframes, and reposition your actionbars."].." "..L["This is completely optional."])
			f.Desc3:SetText(L["Importance: |cffFF0000Low|r"])
		end

		InstallOption1Button:Show()
		InstallOption1Button:SetScript('OnClick', function() E.SetupResolution('high') end)
		InstallOption1Button:SetText(L["High Resolution"])
		InstallOption2Button:Show()
		InstallOption2Button:SetScript('OnClick', function() E.SetupResolution('low') end)
		InstallOption2Button:SetText(L['Low Resolution'])
	elseif PageNum == 7 then
		f.SubTitle:SetText(L["Layout"])
		f.Desc1:SetText(L["Choose a layout you wish to use based on your combat role, or style preference. Choosing either of the Blizzard themes gives you a layout similar to the standard UI placement."])
		f.Desc2:SetText(L["This will change the layout of your unitframes, raidframes (for healer role), and datatexts."])
		f.Desc3:SetText(L["Importance: |cffD3CF00Medium|r"])
		InstallOption1Button:Show()
		InstallOption1Button:SetScript('OnClick', function() E.db.layoutSet = nil; E:SetupLayout('tank') end)
		InstallOption1Button:SetText(L['Tank'])
		InstallOption2Button:Show()
		InstallOption2Button:SetScript('OnClick', function() E.db.layoutSet = nil; E:SetupLayout('healer') end)
		InstallOption2Button:SetText(L['Healer'])
		InstallOption3Button:Show()
		InstallOption3Button:SetScript('OnClick', function() E.db.layoutSet = nil; E:SetupLayout('dpsMelee') end)
		InstallOption3Button:SetText(L['Physical DPS'])
		InstallOption4Button:Show()
		InstallOption4Button:SetScript('OnClick', function() E.db.layoutSet = nil; E:SetupLayout('dpsCaster') end)
		InstallOption4Button:SetText(L['Caster DPS'])
		InstallOption5Button:Show()
		InstallOption5Button:SetScript('OnClick', function() E.db.layoutSet = nil; E:SetupLayout('blizzard') end)
		InstallOption5Button:SetText(L['Blizzard'])
		InstallOption11Button:Show()
		InstallOption11Button:SetScript('OnClick', function() E.db.layoutSet = nil; E:SetupLayout('nouveaufull') end)
		InstallOption11Button:SetText(L['Nouveau Full'])
		InstallOption12Button:Show()
		InstallOption12Button:SetScript('OnClick', function() E.db.layoutSet = nil; E:SetupLayout('nouveauminimal') end)
		InstallOption12Button:SetText(L['Nouveau Minimal'])
		InstallOption13Button:Show()
		InstallOption13Button:SetScript('OnClick', function() E.db.layoutSet = nil; E:SetupLayout('nouveauphys') end)
		InstallOption13Button:SetText(L['Nouveau Phys'])
		InstallOption14Button:Show()
		InstallOption14Button:SetScript('OnClick', function() E.db.layoutSet = nil; E:SetupLayout('nouveauheal') end)
		InstallOption14Button:SetText(L['Nouveau Heal'])
		InstallOption15Button:Show()
		InstallOption15Button:SetScript('OnClick', function() E.db.layoutSet = nil; E:SetupLayout('nouveaucast') end)
		InstallOption15Button:SetText(L['Nouveau Cast'])
	elseif PageNum == 8 then
		f.SubTitle:SetText(L["Auras System"])
		f.Desc1:SetText(L["Set the type of aura/buff display you want. The Integrated option utilizes both aura-bars and aura-icons with filters. The Icons Only option will display only icons and aurabars won't be used. The Standard option will configure icons and aurabars to display debuffs on player and target, buffs on target."])
		f.Desc2:SetText(L["If you have an icon or aurabar that you don't want to display, simply hold down shift and right click the icon for it to disapear. |cffFF0000NOTE: Skip this section if you've chosen either Blizzard layout!|r"])
		f.Desc3:SetText(L["Importance: |cffD3CF00Medium|r"])
		InstallOption11Button:Show()
		InstallOption11Button:SetScript('OnClick', function() SetupAuras('integrated') end)
		InstallOption11Button:SetText(L['Integrated'])
		InstallOption12Button:Show()
		InstallOption12Button:SetScript('OnClick', function() SetupAuras() end)
		InstallOption12Button:SetText(L['Icons Only'])
		InstallOption13Button:Show()
		InstallOption13Button:SetScript('OnClick', function() SetupAuras('standard') end)
		InstallOption13Button:SetText(L['Standard'])
		InstallOption14Button:Show()
		InstallOption14Button:SetScript('OnClick', function() SetupAuras('aurabarsonly') end)
		InstallOption14Button:SetText(L['Aura Bars Only'])
		InstallOption15Button:Show()
		InstallOption15Button:SetScript('OnClick', function() SetupAuras('all') end)
		InstallOption15Button:SetText(L['All'])
	elseif PageNum == 9 then
		f.SubTitle:SetText(L["Installation Complete"])
		f.Desc1:SetText(L["Finished with the installation! Tip: Access the Blizzard micromenu via middle-click on the minimap, or mouseover just outside the top-left of the minimap. If you don't have a middle-click button, then hold down Shift and right-click the minimap. For more information, technical support and updates,"])
		f.Desc2:SetText(L["visit |cff07D400http://www.wowinterface.com/downloads/info17206-DecUI.html|r"])
		f.Desc3:SetText(L["Click the Finished button below to finalize installation and reload DecUI."])
		InstallOption1Button:Show()
		InstallOption1Button:SetScript("OnClick", InstallComplete)
		InstallOption1Button:SetText(L["Finished"])
		InstallTutorialImage:Show()
		InstallTutorialImage:SetTexture([[Interface\AddOns\ElvUI\media\textures\micromenu_tutorial.tga]])
		ElvUIInstallFrame:Size(550, 500)
		InstallTutorialImage:Size(230)
		InstallTutorialImage:Point('BOTTOM', 0, 80)
	end
end

local function NextPage()
	if CURRENT_PAGE ~= MAX_PAGE then
		CURRENT_PAGE = CURRENT_PAGE + 1
		SetPage(CURRENT_PAGE)
	end
end

local function PreviousPage()
	if CURRENT_PAGE ~= 1 then
		CURRENT_PAGE = CURRENT_PAGE - 1
		SetPage(CURRENT_PAGE)
	end
end

--Install UI
function E:Install()
	if not InstallStepComplete then
		local imsg = CreateFrame("Frame", "InstallStepComplete", E.UIParent)
		imsg:Size(418, 72)
		imsg:Point("TOP", 0, -190)
		imsg:Hide()
		imsg:SetScript('OnShow', function(self)
			if self.message then 
				PlaySoundFile([[Sound\Interface\LevelUp.ogg]])
				self.text:SetText(self.message)
				UIFrameFadeOut(self, 3.5, 1, 0)
				E:Delay(4, function() self:Hide() end)
				self.message = nil
				if imsg.firstShow == false then
					if GetCVarBool("Sound_EnableMusic") then
						PlayMusic([[Sound\Music\GlueScreenMusic\BC_main_theme.mp3]])
					end
					imsg.firstShow = true
				end
			else
				self:Hide()
			end
		end)

		imsg.firstShow = false

		imsg.bg = imsg:CreateTexture(nil, 'BACKGROUND')
		imsg.bg:SetTexture([[Interface\LevelUp\LevelUpTex]])
		imsg.bg:Point('BOTTOM')
		imsg.bg:Size(326, 103)
		imsg.bg:SetTexCoord(0.00195313, 0.63867188, 0.03710938, 0.23828125)
		imsg.bg:SetVertexColor(1, 1, 1, 0.6)

		imsg.lineTop = imsg:CreateTexture(nil, 'BACKGROUND')
		imsg.lineTop:SetDrawLayer('BACKGROUND', 2)
		imsg.lineTop:SetTexture([[Interface\LevelUp\LevelUpTex]])
		imsg.lineTop:Point("TOP")
		imsg.lineTop:Size(418, 7)
		imsg.lineTop:SetTexCoord(0.00195313, 0.81835938, 0.01953125, 0.03320313)

		imsg.lineBottom = imsg:CreateTexture(nil, 'BACKGROUND')
		imsg.lineBottom:SetDrawLayer('BACKGROUND', 2)
		imsg.lineBottom:SetTexture([[Interface\LevelUp\LevelUpTex]])
		imsg.lineBottom:Point("BOTTOM")
		imsg.lineBottom:Size(418, 7)
		imsg.lineBottom:SetTexCoord(0.00195313, 0.81835938, 0.01953125, 0.03320313)

		imsg.text = imsg:CreateFontString(nil, 'ARTWORK', 'GameFont_Gigantic')
		imsg.text:Point("BOTTOM", 0, 12)
		imsg.text:SetTextColor(1, 0.82, 0)
		imsg.text:SetJustifyH("CENTER")
	end

	--Create Frame
	if not ElvUIInstallFrame then
		local f = CreateFrame("Button", "ElvUIInstallFrame", E.UIParent)
		f.SetPage = SetPage
		f:Size(550, 400)
		f:SetTemplate("Transparent")
		f:Point("CENTER")
		f:SetFrameStrata('TOOLTIP')

		f.Title = f:CreateFontString(nil, 'OVERLAY')
		f.Title:FontTemplate(nil, 17, nil)
		f.Title:Point("TOP", 0, -5)
		f.Title:SetText(L["ElvUI Installation"]:gsub("ElvUI", E.UIName))

		f.Next = CreateFrame("Button", "InstallNextButton", f, "UIPanelButtonTemplate")
		f.Next:StripTextures()
		f.Next:SetTemplate("Default", true)
		f.Next:Size(110, 25)
		f.Next:Point("BOTTOMRIGHT", -5, 5)
		f.Next:SetText(CONTINUE)
		f.Next:Disable()
		f.Next:SetScript("OnClick", NextPage)
		E.Skins:HandleButton(f.Next, true)

		f.Prev = CreateFrame("Button", "InstallPrevButton", f, "UIPanelButtonTemplate")
		f.Prev:StripTextures()
		f.Prev:SetTemplate("Default", true)
		f.Prev:Size(110, 25)
		f.Prev:Point("BOTTOMLEFT", 5, 5)
		f.Prev:SetText(PREVIOUS)
		f.Prev:Disable()
		f.Prev:SetScript("OnClick", PreviousPage)
		E.Skins:HandleButton(f.Prev, true)

		f.Status = CreateFrame("StatusBar", "InstallStatus", f)
		f.Status:SetFrameLevel(f.Status:GetFrameLevel() + 2)
		f.Status:CreateBackdrop("Default")
		f.Status:SetStatusBarTexture(E["media"].normTex)

		E:RegisterStatusBar(f.Status)
		f.Status:SetStatusBarColor(1, 0, 0)
		f.Status:SetMinMaxValues(0, MAX_PAGE)
		f.Status:Point("TOPLEFT", f.Prev, "TOPRIGHT", 6, -2)
		f.Status:Point("BOTTOMRIGHT", f.Next, "BOTTOMLEFT", -6, 2)
		-- Setup StatusBar Animation
		f.Status.anim = CreateAnimationGroup(f.Status)
		f.Status.anim.progress = f.Status.anim:CreateAnimation("Progress")
		f.Status.anim.progress:SetSmoothing("Out")
		f.Status.anim.progress:SetDuration(.3)

		f.Status.text = f.Status:CreateFontString(nil, 'OVERLAY')
		f.Status.text:FontTemplate()
		f.Status.text:Point("CENTER")
		f.Status.text:SetText(CURRENT_PAGE.." / "..MAX_PAGE)
		-- f.Status:SetScript("OnValueChanged", function(self)
			-- self.text:SetText(self:GetValue().." / "..MAX_PAGE)
		-- end)

		f.Option1 = CreateFrame("Button", "InstallOption1Button", f, "UIPanelButtonTemplate")
		f.Option1:StripTextures()
		f.Option1:Size(160, 30)
		f.Option1:Point("BOTTOM", 0, 45)
		f.Option1:SetText("")
		f.Option1:Hide()
		E.Skins:HandleButton(f.Option1, true)
		f.Option2 = CreateFrame("Button", "InstallOption2Button", f, "UIPanelButtonTemplate")
		f.Option2:StripTextures()
		f.Option2:Size(110, 30)
		f.Option2:Point('BOTTOMLEFT', f, 'BOTTOM', 4, 45)
		f.Option2:SetText("")
		f.Option2:Hide()
		f.Option2:SetScript('OnShow', function() f.Option1:SetWidth(110); f.Option1:ClearAllPoints(); f.Option1:Point('BOTTOMRIGHT', f, 'BOTTOM', -4, 45) end)
		f.Option2:SetScript('OnHide', function() f.Option1:SetWidth(160); f.Option1:ClearAllPoints(); f.Option1:Point("BOTTOM", 0, 45) end)
		E.Skins:HandleButton(f.Option2, true)
		f.Option3 = CreateFrame("Button", "InstallOption3Button", f, "UIPanelButtonTemplate")
		f.Option3:StripTextures()
		f.Option3:Size(100, 30)
		f.Option3:Point('LEFT', f.Option2, 'RIGHT', 4, 0)
		f.Option3:SetText("")
		f.Option3:Hide()
		f.Option3:SetScript('OnShow', function() f.Option1:SetWidth(100); f.Option1:ClearAllPoints(); f.Option1:Point('RIGHT', f.Option2, 'LEFT', -4, 0); f.Option2:SetWidth(100); f.Option2:ClearAllPoints(); f.Option2:Point('BOTTOM', f, 'BOTTOM', 0, 45)  end)
		f.Option3:SetScript('OnHide', function() f.Option1:SetWidth(160); f.Option1:ClearAllPoints(); f.Option1:Point("BOTTOM", 0, 45); f.Option2:SetWidth(110); f.Option2:ClearAllPoints(); f.Option2:Point('BOTTOMLEFT', f, 'BOTTOM', 4, 45) end)
		E.Skins:HandleButton(f.Option3, true)
		f.Option4 = CreateFrame("Button", "InstallOption4Button", f, "UIPanelButtonTemplate")
		f.Option4:StripTextures()
		f.Option4:Size(100, 30)
		f.Option4:Point('LEFT', f.Option3, 'RIGHT', 4, 0)
		f.Option4:SetText("")
		f.Option4:Hide()
		f.Option4:SetScript('OnShow', function() 
			f.Option1:Width(100)
			f.Option2:Width(100)
			f.Option1:ClearAllPoints(); 
			f.Option1:Point('RIGHT', f.Option2, 'LEFT', -4, 0); 
			f.Option2:ClearAllPoints(); 
			f.Option2:Point('BOTTOMRIGHT', f, 'BOTTOM', -54, 68)  
		end)

		f.Option4:SetScript('OnHide', function() f.Option1:SetWidth(160); f.Option1:ClearAllPoints(); f.Option1:Point("BOTTOM", 0, 45); f.Option2:SetWidth(110); f.Option2:ClearAllPoints(); f.Option2:Point('BOTTOMLEFT', f, 'BOTTOM', 4, 45) end)
		E.Skins:HandleButton(f.Option4, true)
		f.Option5 = CreateFrame("Button", "InstallOption5Button", f, "UIPanelButtonTemplate")
		f.Option5:StripTextures()
		f.Option5:Size(100, 30)
		f.Option5:Point('LEFT', f.Option4, 'RIGHT', 4, 0)
		f.Option5:SetText("")
		f.Option5:Hide()
		f.SubTitle = f:CreateFontString(nil, 'OVERLAY')
		f.SubTitle:FontTemplate(nil, 15, nil)
		f.SubTitle:Point("TOP", 0, -40)
		f.Desc1 = f:CreateFontString(nil, 'OVERLAY')
		f.Desc1:FontTemplate()
		f.Desc1:Point("TOPLEFT", 20, -75)
		f.Desc1:Width(f:GetWidth() - 40)
		f.Desc2 = f:CreateFontString(nil, 'OVERLAY')
		f.Desc2:FontTemplate()
		f.Desc2:Point("TOPLEFT", 20, -125)
		f.Desc2:Width(f:GetWidth() - 40)
		f.Desc3 = f:CreateFontString(nil, 'OVERLAY')
		f.Desc3:FontTemplate()
		f.Desc3:Point("TOPLEFT", 20, -175)
		f.Desc3:Width(f:GetWidth() - 40)
		f.Option5:SetScript('OnHide', function() f.Option1:SetWidth(160); f.Option1:ClearAllPoints(); f.Option1:Point("BOTTOM", 0, 45); f.Option2:SetWidth(110); f.Option2:ClearAllPoints(); f.Option2:Point('BOTTOMLEFT', f, 'BOTTOM', 4, 45) end)
		E.Skins:HandleButton(f.Option5, true)
		f.Option6 = CreateFrame("Button", "InstallOption6Button", f, "UIPanelButtonTemplate")
		f.Option6:StripTextures()
		f.Option6:Size(100, 30)
		f.Option6:Point('TOP', f.Option5, 'BOTTOM', 0, -4)
		f.Option6:SetText("")
		f.Option6:Hide()
		E.Skins:HandleButton(f.Option6, true)
		f.SubTitle = f:CreateFontString(nil, 'OVERLAY')
		f.SubTitle:FontTemplate(nil, 15, nil)
		f.SubTitle:Point("TOP", 0, -40)
		f.Desc1 = f:CreateFontString(nil, 'OVERLAY')
		f.Desc1:FontTemplate()
		f.Desc1:Point("TOPLEFT", 20, -75)
		f.Desc1:Width(f:GetWidth() - 40)
		f.Desc2 = f:CreateFontString(nil, 'OVERLAY')
		f.Desc2:FontTemplate()
		f.Desc2:Point("TOPLEFT", 20, -125)
		f.Desc2:Width(f:GetWidth() - 40)
		f.Desc3 = f:CreateFontString(nil, 'OVERLAY')
		f.Desc3:FontTemplate()
		f.Desc3:Point("TOPLEFT", 20, -175)
		f.Desc3:Width(f:GetWidth() - 40)
		f.Option6:SetScript('OnHide', function() f.Option1:SetWidth(160); f.Option1:ClearAllPoints(); f.Option1:Point("BOTTOM", 0, 45); f.Option2:SetWidth(110); f.Option2:ClearAllPoints(); f.Option2:Point('BOTTOMLEFT', f, 'BOTTOM', 4, 45) end)
		f.Option7 = CreateFrame("Button", "InstallOption7Button", f, "UIPanelButtonTemplate")
		f.Option7:StripTextures()
		f.Option7:Size(100, 30)
		f.Option7:Point('TOP', f.Option4, 'BOTTOM', 0, -4)
		f.Option7:SetText("")
		f.Option7:Hide()
		E.Skins:HandleButton(f.Option7, true)
		f.SubTitle = f:CreateFontString(nil, 'OVERLAY')
		f.SubTitle:FontTemplate(nil, 15, nil)
		f.SubTitle:Point("TOP", 0, -40)
		f.Desc1 = f:CreateFontString(nil, 'OVERLAY')
		f.Desc1:FontTemplate()
		f.Desc1:Point("TOPLEFT", 20, -75)
		f.Desc1:Width(f:GetWidth() - 40)
		f.Desc2 = f:CreateFontString(nil, 'OVERLAY')
		f.Desc2:FontTemplate()
		f.Desc2:Point("TOPLEFT", 20, -125)
		f.Desc2:Width(f:GetWidth() - 40)
		f.Desc3 = f:CreateFontString(nil, 'OVERLAY')
		f.Desc3:FontTemplate()
		f.Desc3:Point("TOPLEFT", 20, -175)
		f.Desc3:Width(f:GetWidth() - 40)
		f.Option7:SetScript('OnHide', function() f.Option1:SetWidth(160); f.Option1:ClearAllPoints(); f.Option1:Point("BOTTOM", 0, 45); f.Option2:SetWidth(110); f.Option2:ClearAllPoints(); f.Option2:Point('BOTTOMLEFT', f, 'BOTTOM', 4, 45) end)
		f.Option8 = CreateFrame("Button", "InstallOption8Button", f, "UIPanelButtonTemplate")
		f.Option8:StripTextures()
		f.Option8:Size(100, 30)
		f.Option8:Point('TOP', f.Option3, 'BOTTOM', 0, -4)
		f.Option8:SetText("")
		f.Option8:Hide()
		E.Skins:HandleButton(f.Option8, true)
		f.SubTitle = f:CreateFontString(nil, 'OVERLAY')
		f.SubTitle:FontTemplate(nil, 15, nil)
		f.SubTitle:Point("TOP", 0, -40)
		f.Desc1 = f:CreateFontString(nil, 'OVERLAY')
		f.Desc1:FontTemplate()
		f.Desc1:Point("TOPLEFT", 20, -75)
		f.Desc1:Width(f:GetWidth() - 40)
		f.Desc2 = f:CreateFontString(nil, 'OVERLAY')
		f.Desc2:FontTemplate()	
		f.Desc2:Point("TOPLEFT", 20, -125)
		f.Desc2:Width(f:GetWidth() - 40)
		f.Desc3 = f:CreateFontString(nil, 'OVERLAY')
		f.Desc3:FontTemplate()
		f.Desc3:Point("TOPLEFT", 20, -175)
		f.Desc3:Width(f:GetWidth() - 40)
		f.Option8:SetScript('OnHide', function() f.Option1:SetWidth(160); f.Option1:ClearAllPoints(); f.Option1:Point("BOTTOM", 0, 45); f.Option2:SetWidth(110); f.Option2:ClearAllPoints(); f.Option2:Point('BOTTOMLEFT', f, 'BOTTOM', 4, 45) end)
		E.Skins:HandleButton(f.Option7, true)
		f.Option9 = CreateFrame("Button", "InstallOption9Button", f, "UIPanelButtonTemplate")
		f.Option9:StripTextures()
		f.Option9:Size(100, 30)
		f.Option9:Point('TOP', f.Option2, 'BOTTOM', 0, -4)
		f.Option9:SetText("")
		f.Option9:Hide()
		E.Skins:HandleButton(f.Option9, true)
		f.SubTitle = f:CreateFontString(nil, 'OVERLAY')
		f.SubTitle:FontTemplate(nil, 15, nil)
		f.SubTitle:Point("TOP", 0, -40)
		f.Desc1 = f:CreateFontString(nil, 'OVERLAY')
		f.Desc1:FontTemplate()
		f.Desc1:Point("TOPLEFT", 20, -75)
		f.Desc1:Width(f:GetWidth() - 40)
		f.Desc2 = f:CreateFontString(nil, 'OVERLAY')
		f.Desc2:FontTemplate()
		f.Desc2:Point("TOPLEFT", 20, -125)
		f.Desc2:Width(f:GetWidth() - 40)
		f.Desc3 = f:CreateFontString(nil, 'OVERLAY')
		f.Desc3:FontTemplate()
		f.Desc3:Point("TOPLEFT", 20, -175)
		f.Desc3:Width(f:GetWidth() - 40)
		f.Option9:SetScript('OnHide', function() f.Option1:SetWidth(160); f.Option1:ClearAllPoints(); f.Option1:Point("BOTTOM", 0, 45); f.Option2:SetWidth(110); f.Option2:ClearAllPoints(); f.Option2:Point('BOTTOMLEFT', f, 'BOTTOM', 4, 45) end)
		E.Skins:HandleButton(f.Option8, true)
		f.Option10 = CreateFrame("Button", "InstallOption10Button", f, "UIPanelButtonTemplate")
		f.Option10:StripTextures()
		f.Option10:Size(100, 30)
		f.Option10:Point('TOP', f.Option1, 'BOTTOM', 0, -4)
		f.Option10:SetText("")
		f.Option10:Hide()
		E.Skins:HandleButton(f.Option10, true)
		f.SubTitle = f:CreateFontString(nil, 'OVERLAY')
		f.SubTitle:FontTemplate(nil, 15, nil)
		f.SubTitle:Point("TOP", 0, -40)
		f.Desc1 = f:CreateFontString(nil, 'OVERLAY')
		f.Desc1:FontTemplate()
		f.Desc1:Point("TOPLEFT", 20, -75)
		f.Desc1:Width(f:GetWidth() - 40)
		f.Desc2 = f:CreateFontString(nil, 'OVERLAY')
		f.Desc2:FontTemplate()
		f.Desc2:Point("TOPLEFT", 20, -125)
		f.Desc2:Width(f:GetWidth() - 40)
		f.Desc3 = f:CreateFontString(nil, 'OVERLAY')
		f.Desc3:FontTemplate()
		f.Desc3:Point("TOPLEFT", 20, -175)
		f.Desc3:Width(f:GetWidth() - 40)
		f.Option10:SetScript('OnHide', function() f.Option1:SetWidth(160); f.Option1:ClearAllPoints(); f.Option1:Point("BOTTOM", 0, 45); f.Option2:SetWidth(110); f.Option2:ClearAllPoints(); f.Option2:Point('BOTTOMLEFT', f, 'BOTTOM', 4, 45) end)
		f.Option11 = CreateFrame("Button", "InstallOption11Button", f, "UIPanelButtonTemplate")
		f.Option11:StripTextures()
		f.Option11:Size(100, 30)
		f.Option11:Point('BOTTOMLEFT', f, 'BOTTOMLEFT', 17, 34)
		f.Option11:SetText("")
		f.Option11:Hide()
		E.Skins:HandleButton(f.Option11, true)
		f.SubTitle = f:CreateFontString(nil, 'OVERLAY')
		f.SubTitle:FontTemplate(nil, 15, nil)
		f.SubTitle:Point("TOP", 0, -40)
		f.Desc1 = f:CreateFontString(nil, 'OVERLAY')
		f.Desc1:FontTemplate()
		f.Desc1:Point("TOPLEFT", 20, -75)
		f.Desc1:Width(f:GetWidth() - 40)
		f.Desc2 = f:CreateFontString(nil, 'OVERLAY')
		f.Desc2:FontTemplate()
		f.Desc2:Point("TOPLEFT", 20, -125)
		f.Desc2:Width(f:GetWidth() - 40)
		f.Desc3 = f:CreateFontString(nil, 'OVERLAY')
		f.Desc3:FontTemplate()
		f.Desc3:Point("TOPLEFT", 20, -175)
		f.Desc3:Width(f:GetWidth() - 40)
		f.Option11:SetScript('OnHide', function() f.Option1:SetWidth(160); f.Option1:ClearAllPoints(); f.Option1:Point("BOTTOM", 0, 45); f.Option2:SetWidth(110); f.Option2:ClearAllPoints(); f.Option2:Point('BOTTOMLEFT', f, 'BOTTOM', 4, 45) end)
		f.Option12 = CreateFrame("Button", "InstallOption12Button", f, "UIPanelButtonTemplate")
		f.Option12:StripTextures()
		f.Option12:Size(100, 30)
		f.Option12:Point('LEFT', f.Option11, 'RIGHT', 4, 0)
		f.Option12:SetText("")
		f.Option12:Hide()
		E.Skins:HandleButton(f.Option12, true)
		f.SubTitle = f:CreateFontString(nil, 'OVERLAY')
		f.SubTitle:FontTemplate(nil, 15, nil)
		f.SubTitle:Point("TOP", 0, -40)
		f.Desc1 = f:CreateFontString(nil, 'OVERLAY')
		f.Desc1:FontTemplate()
		f.Desc1:Point("TOPLEFT", 20, -75)
		f.Desc1:Width(f:GetWidth() - 40)
		f.Desc2 = f:CreateFontString(nil, 'OVERLAY')
		f.Desc2:FontTemplate()
		f.Desc2:Point("TOPLEFT", 20, -125)
		f.Desc2:Width(f:GetWidth() - 40)
		f.Desc3 = f:CreateFontString(nil, 'OVERLAY')
		f.Desc3:FontTemplate()
		f.Desc3:Point("TOPLEFT", 20, -175)
		f.Desc3:Width(f:GetWidth() - 40)
		f.Option12:SetScript('OnHide', function() f.Option1:SetWidth(160); f.Option1:ClearAllPoints(); f.Option1:Point("BOTTOM", 0, 45); f.Option2:SetWidth(110); f.Option2:ClearAllPoints(); f.Option2:Point('BOTTOMLEFT', f, 'BOTTOM', 4, 45) end)
		f.Option13 = CreateFrame("Button", "InstallOption13Button", f, "UIPanelButtonTemplate")
		f.Option13:StripTextures()
		f.Option13:Size(100, 30)
		f.Option13:Point('LEFT', f.Option12, 'RIGHT', 4, 0)
		f.Option13:SetText("")
		f.Option13:Hide()
		E.Skins:HandleButton(f.Option13, true)
		f.SubTitle = f:CreateFontString(nil, 'OVERLAY')
		f.SubTitle:FontTemplate(nil, 15, nil)
		f.SubTitle:Point("TOP", 0, -40)
		f.Desc1 = f:CreateFontString(nil, 'OVERLAY')
		f.Desc1:FontTemplate()
		f.Desc1:Point("TOPLEFT", 20, -75)
		f.Desc1:Width(f:GetWidth() - 40)
		f.Desc2 = f:CreateFontString(nil, 'OVERLAY')
		f.Desc2:FontTemplate()
		f.Desc2:Point("TOPLEFT", 20, -125)
		f.Desc2:Width(f:GetWidth() - 40)
		f.Desc3 = f:CreateFontString(nil, 'OVERLAY')
		f.Desc3:FontTemplate()
		f.Desc3:Point("TOPLEFT", 20, -175)
		f.Desc3:Width(f:GetWidth() - 40)
		f.Option13:SetScript('OnHide', function() f.Option1:SetWidth(160); f.Option1:ClearAllPoints(); f.Option1:Point("BOTTOM", 0, 45); f.Option2:SetWidth(110); f.Option2:ClearAllPoints(); f.Option2:Point('BOTTOMLEFT', f, 'BOTTOM', 4, 45) end)
		f.Option14 = CreateFrame("Button", "InstallOption14Button", f, "UIPanelButtonTemplate")
		f.Option14:StripTextures()
		f.Option14:Size(100, 30)
		f.Option14:Point('LEFT', f.Option13, 'RIGHT', 4, 0)
		f.Option14:SetText("")
		f.Option14:Hide()
		E.Skins:HandleButton(f.Option14, true)
		f.SubTitle = f:CreateFontString(nil, 'OVERLAY')
		f.SubTitle:FontTemplate(nil, 15, nil)
		f.SubTitle:Point("TOP", 0, -40)
		f.Desc1 = f:CreateFontString(nil, 'OVERLAY')
		f.Desc1:FontTemplate()
		f.Desc1:Point("TOPLEFT", 20, -75)
		f.Desc1:Width(f:GetWidth() - 40)
		f.Desc2 = f:CreateFontString(nil, 'OVERLAY')
		f.Desc2:FontTemplate()	
		f.Desc2:Point("TOPLEFT", 20, -125)
		f.Desc2:Width(f:GetWidth() - 40)
		f.Desc3 = f:CreateFontString(nil, 'OVERLAY')
		f.Desc3:FontTemplate()
		f.Desc3:Point("TOPLEFT", 20, -175)
		f.Desc3:Width(f:GetWidth() - 40)
		f.Option14:SetScript('OnHide', function() f.Option1:SetWidth(160); f.Option1:ClearAllPoints(); f.Option1:Point("BOTTOM", 0, 45); f.Option2:SetWidth(110); f.Option2:ClearAllPoints(); f.Option2:Point('BOTTOMLEFT', f, 'BOTTOM', 4, 45) end)
		f.Option15 = CreateFrame("Button", "InstallOption15Button", f, "UIPanelButtonTemplate")
		f.Option15:StripTextures()
		f.Option15:Size(100, 30)
		f.Option15:Point('LEFT', f.Option14, 'RIGHT', 4, 0)
		f.Option15:SetText("")
		f.Option15:Hide()
		E.Skins:HandleButton(f.Option15, true)
		f.SubTitle = f:CreateFontString(nil, 'OVERLAY')
		f.SubTitle:FontTemplate(nil, 15, nil)
		f.SubTitle:Point("TOP", 0, -40)
		f.Desc1 = f:CreateFontString(nil, 'OVERLAY')
		f.Desc1:FontTemplate()	
		f.Desc1:Point("TOPLEFT", 20, -75)
		f.Desc1:Width(f:GetWidth() - 40)
		f.Desc2 = f:CreateFontString(nil, 'OVERLAY')
		f.Desc2:FontTemplate()	
		f.Desc2:Point("TOPLEFT", 20, -125)
		f.Desc2:Width(f:GetWidth() - 40)
		f.Desc3 = f:CreateFontString(nil, 'OVERLAY')
		f.Desc3:FontTemplate()
		f.Desc3:Point("TOPLEFT", 20, -175)
		f.Desc3:Width(f:GetWidth() - 40)

		local close = CreateFrame("Button", "InstallCloseButton", f, "UIPanelCloseButton")
		close:Point("TOPRIGHT", f, "TOPRIGHT")
		close:SetScript("OnClick", function()
			f:Hide()
		end)
		E.Skins:HandleCloseButton(close)

		f.tutorialImage = f:CreateTexture('InstallTutorialImage', 'OVERLAY')
		f.tutorialImage:Size(256, 128)
		

		f.tutorialImage:SetTexture('Interface\\AddOns\\ElvUI\\media\\textures\\DecUILogo.tga')
		f.tutorialImage:Point('BOTTOM', 0, 80)
	end

	ElvUIInstallFrame:Show()
	NextPage()
end