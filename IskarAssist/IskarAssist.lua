 
local DF = _G ["DetailsFramework"]
if (not DF) then
	print ("|cFFFFAA00Please restart your client to finish update some AddOns.|r")
	return
end

local UnitExists = UnitExists
local GetPlayerMapPosition = GetPlayerMapPosition
local UnitHealth = UnitHealth
local GetNumGroupMembers = GetNumGroupMembers
local UnitIsConnected = UnitIsConnected
local UnitInRange = UnitInRange
local UnitClass = UnitClass
local GetUnitName = GetUnitName
local GetSpellInfo = GetSpellInfo
local UnitAffectingCombat = UnitAffectingCombat
local InCombatLockdown = InCombatLockdown
local UnitIsDeadOrGhost = UnitIsDeadOrGhost

local abs = abs
local floor = floor
local min = min
local db
local _
local f
local allplayers = {}
local player_index = {}
local unitids = {}
local group_labels = {}
local name_to_block = {}
local unitid_to_block = {}
local anzu_texture
local player_class
local block_backdrop_eye = {bgFile = [[Interface\RaidFrame\Raid-Bar-Hp-Fill]], tile = true, tileSize = 16, insets = {left = 0, right = 0, top = 0, bottom = 0},
edgeFile = "Interface\\AddOns\\IskarAssist\\border_2", edgeSize = 20}
local iskar_version = "v0.23"

local iskar_encounter_id = 1788 --iskar
local iskar_npcid = 90316 --iskar
local hfc_map_id = 1448 --hfc

local archimonde_encounter_id = 1799 --archimonde
local shadowfel_warden_npcid = 91541 --shadowfel warden

local is_kargath_test = false
local isdebug = false

local fel_conduit_save_position = CreateFrame ("frame", "IskarAssistFelConduitPos", UIParent)
fel_conduit_save_position:SetPoint ("center", UIParent, "center", 0, 350)
fel_conduit_save_position:SetMovable (true)
fel_conduit_save_position:SetSize (1, 1)

if (is_kargath_test) then
	iskar_encounter_id =  1721 --kargath (testing) 
	archimonde_encounter_id = 1721
	--iskar_encounter_id =  1706 --butcher (testing)
	--iskar_encounter_id =  1720 --brackenspore (testing)
	iskar_npcid = 78714 --kargath (testing)
	hfc_map_id = 1228 --highmaul (testing)
end

local SharedMedia = LibStub:GetLibrary ("LibSharedMedia-3.0")
SharedMedia:Register ("font", "Accidental Presidency", [[Interface\Addons\IskarAssist\Accidental Presidency.ttf]])
SharedMedia:Register ("statusbar", "Iskar Serenity", [[Interface\AddOns\IskarAssist\bar_serenity]])

--> build the event listener
local frame_event = CreateFrame ("frame", "IskarAssistEvents", UIParent)
frame_event:RegisterEvent ("ADDON_LOADED")
frame_event:SetFrameStrata ("TOOLTIP")


local sort_alphabetical = function (a, b)
	return a < b
end

--> get the localized spellnames
local aura_eyeanzu = GetSpellInfo (179202) --Eye of Anzu

local aura_phantasmal_wounds, rank, phantasmal_wounds_icon = GetSpellInfo (182325) --Phantasmal Wounds
local aura_phantasmal_winds, rank, phantasmal_winds_icon = GetSpellInfo (181957) --Phantasmal Winds
local aura_fel_chakram, rank, fel_chakram_icon = GetSpellInfo (182178) --Fel Chakram
local aura_phantasmal_corruption, rank, phantasmal_corruption_icon = GetSpellInfo (181824) --Phantasmal Corruption
local aura_fel_bomb, rank, fel_bomb_icon = GetSpellInfo (181753) --Fel Bomb
local aura_phantasmal_bomb, rank, phantasmal_bomb_icon = GetSpellInfo (179219) --Phantasmal Fel Bomb
local aura_dark_bindings, rank, dark_bindings_icon = GetSpellInfo (185510) --Dark Bindings
local aura_focused_chaos, rank, aura_focused_chaos_icon = GetSpellInfo (185014) -- focused chaos
local spell_fel_conduit, rank, spell_fel_conduit_icon = GetSpellInfo (181827) --fel conduit
local spell_fel_bomb, rank, spell_fel_bomb_icon = GetSpellInfo (179218) --phantasmal obliteration 

local aura_radiance_of_anzu = GetSpellInfo (185239) --Radiance of Anzu

local track_auras = {
	[aura_phantasmal_wounds] = true,
	[aura_phantasmal_winds] = true,
	[aura_fel_chakram] = true,
	[aura_phantasmal_corruption] = true,
	[aura_fel_bomb] = true,
	[aura_phantasmal_bomb] = true,
	[aura_dark_bindings] = true,
}

local grid_aura_index = {
	[aura_phantasmal_winds] = 1,
	[aura_fel_bomb] = 2,
	[aura_phantasmal_wounds] = 3,
	[aura_phantasmal_corruption] = 4,
}

--Dark Bindings

local dispel_naturescure = GetSpellInfo (88423) --druid
local dispel_purify = GetSpellInfo (527) --priest
local dispel_cleanse = GetSpellInfo (4987) --pally
local dispel_purify_spirit = GetSpellInfo (77130) --shaman
local dispel_detox = GetSpellInfo (115450) --monk
local dispel_sear_magic = GetSpellInfo (89808) --warlock

local no_border = {5/64, 59/64, 5/64, 59/64}

local dispel_spells = {
	[dispel_naturescure] = true,
	[dispel_purify] = true,
	[dispel_cleanse] = true,
	[dispel_purify_spirit] = true,
	[dispel_detox] = true,
	[dispel_sear_magic] = true,
}

--> debug

local config_table = {
	profile = {
		MainPanel = {},
		MainPanel_strata = "DIALOG",
		bartexture = "Iskar Serenity",
		barwidth = 100,
		barheight = 20,
		barwidth_grid = 55,
		barheight_grid = 55,
		textfont = "Accidental Presidency",
		textsize = 14,
		textshadow = true,
		right_side_debuffs = false,
		debuff_phantasmal_wounds = true,
		debuff_phantasmal_winds = true,
		debuff_fel_chakram = false,
		debuff_phantasmal_corruption = true,
		debuff_fel_bomb = true,
		debuff_phantasmal_bomb = false,
		eye_flash_anim = true,
		dispel_ready = false,
		group_sorting = 3,
		cooldown = false,
		show_cooldown_bars = false,
		archimonde_radar = false,
		stack_count_anchor = "top",
	}
}
local IKA = DF:CreateAddOn ("ShadowLordIskarAssist", "IskarAssistDB", config_table)
IKA.MaxGroups = 6

function IKA:ScheduleCreateFrames (show)
	if (UnitAffectingCombat ("player") or InCombatLockdown()) then
		IKA.scheduled_frame_creation = true
	else
		IKA:CreateFrames (show)
	end
end

function IKA:CreateFrames (show_after_cretion)
	
	if (f and f.FramesCreated) then
		return
	end
	
	--> create the main frame
	f = DF:Create1PxPanel (_, 100, 20, "Iskar Assist", "IskarAssist", IKA.db.profile.MainPanel, "top", true)
	f.FramesCreated = true
	
	f:SetFrameStrata ("DIALOG")
	f.version = iskar_version
	f.Title:ClearAllPoints()
	f.Title:SetPoint ("bottomleft", f, "topleft", 0, 1)
	
	f.dead_cache = {}
	f.player_blocks = {}
	f.track_player_health = {}

	f:SetSize (104, 100)
	f:SetBackdrop ({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 16, insets = {left = -1, right = -1, top = -1, bottom = -1}})

	--> checking first, in case of outdate framework
	if (f.HasPosition and not f:HasPosition()) then
		f:SetPoint ("center", UIParent, "center", 300, 200)
	end
	
	f:SetBackdropColor (0, 0, 0, 0.2)
	f:SetBackdropBorderColor (0, 0, 0, 1)
	f:SetMovable (true)
	f:EnableMouse (true)
	f:Hide()
	
	f.DontRightClickClose = true
	IKA.scheduled_frame_creation = nil
	
	for i = 1, 6 do
		local label = f:CreateFontString (nil, "overlay", "GameFontNormal")
		label:SetText ("Group " .. i)
		tinsert (group_labels, label)
	end
	
	function f:ClearGroupLabels()
		for i = 1, 6 do
			local label = group_labels [i]
			label:ClearAllPoints()
			label:Hide()
		end
	end
	
	function f:HideMe()
		if (UnitAffectingCombat ("player") or InCombatLockdown()) then
			f.schedule_hide = true
			IKA:Msg ("Iskar Assist will hide after you leave the combat.")
		else
			f:Hide()
		end
	end
	function f:ShowMe()
		if (UnitAffectingCombat ("player") or InCombatLockdown()) then
			f.schedule_show = true
		else
			f:Show()
		end
	end
	
	f.Close:SetScript ("OnClick", function (self)
		f:HideMe()
	end)

	local anchor_frame = CreateFrame ("frame", "IskarAssisTopAnchor", f)
	anchor_frame:SetPoint ("bottomleft", f, "topleft")
	anchor_frame:SetPoint ("bottomright", f, "topright")
	anchor_frame:SetHeight (16)
	anchor_frame:SetBackdrop ({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 16, insets = {left = -1, right = -1, top = -1, bottom = -1}})
	anchor_frame:SetBackdropColor (0, 0, 0, 0.4)
	anchor_frame:SetBackdropBorderColor (0, 0, 0, 1)
	anchor_frame:SetMovable (true)
	anchor_frame:EnableMouse (true)
	anchor_frame:SetFrameStrata ("HIGH")

	anchor_frame:SetScript ("OnMouseDown", function (self)
		if (not f.IsLocked) then
			f:GetScript("OnMouseDown")(f)
		end
	end)
	anchor_frame:SetScript ("OnMouseUp", function (self)
		if (not f.IsLocked) then
			f:GetScript("OnMouseUp")(f)
		end
	end)

	f.OnLock = function (self)
		anchor_frame:Hide()
	end
	f.OnUnlock = function (self)
		anchor_frame:Show()
	end
	
	if (f.IsLocked) then
		anchor_frame:Hide()
	end
	
	anzu_texture = frame_event:CreateTexture (nil, "overlay")
	anzu_texture:SetTexture ("Interface\\ICONS\\ability_felarakkoa_eyeofterrok")
	anzu_texture:SetSize (18, 18)
	anzu_texture:SetTexCoord (4/64, 60/64, 4/64, 60/64)
	frame_event:Show()
	anzu_texture:Hide()
	
	function f:debug (msg, msg2)
		if (isdebug) then
			print ("-", msg, msg2 or "")
		end
	end
	
	--> which debuffs to track
	function f:SetEnabledDebuffs (debuff_phantasmal_wounds, debuff_phantasmal_winds, debuff_fel_chakram, debuff_phantasmal_corruption, debuff_fel_bomb, debuff_phantasmal_bomb)
		local profile = IKA.db.profile
		
		debuff_phantasmal_wounds = debuff_phantasmal_wounds or profile.debuff_phantasmal_wounds
		profile.debuff_phantasmal_wounds = debuff_phantasmal_wounds
		debuff_phantasmal_winds = debuff_phantasmal_winds or profile.debuff_phantasmal_winds
		profile.debuff_phantasmal_winds = debuff_phantasmal_winds
		debuff_fel_chakram = debuff_fel_chakram or profile.debuff_fel_chakram
		profile.debuff_fel_chakram = debuff_fel_chakram
		debuff_phantasmal_corruption = debuff_phantasmal_corruption or profile.debuff_phantasmal_corruption
		profile.debuff_phantasmal_corruption = debuff_phantasmal_corruption
		debuff_fel_bomb = debuff_fel_bomb or profile.debuff_fel_bomb
		profile.debuff_fel_bomb = debuff_fel_bomb
		debuff_phantasmal_bomb = debuff_phantasmal_bomb or profile.debuff_phantasmal_bomb
		profile.debuff_phantasmal_bomb = debuff_phantasmal_bomb
		
		track_auras [aura_phantasmal_wounds] = debuff_phantasmal_wounds
		track_auras [aura_phantasmal_winds] = debuff_phantasmal_winds 
		track_auras [aura_fel_chakram] = debuff_fel_chakram
		track_auras [aura_phantasmal_corruption] = debuff_phantasmal_corruption
		track_auras [aura_fel_bomb] = debuff_fel_bomb
		track_auras [aura_phantasmal_bomb] = debuff_phantasmal_bomb
	end
	
	--> unit frame stuff
	local do_block_changes = function (block, bartexture, barwidth, barheight, textfont, textsize, textshadow, right_side_debuffs, dispel_ready, barwidth_grid, barheight_grid, stack_anchor)
		--bar texture
		local texture_file = SharedMedia:Fetch ("statusbar", bartexture)
		block.block_texture:SetTexture (texture_file)
		
		--bar width / height and iconsize
		if (IKA.db.profile.group_sorting < 3) then
			block:SetSize (barwidth, barheight)
			for _, debuff in ipairs (block.debuffs) do
				debuff:SetSize (barheight, barheight)
			end
			
			
			
		elseif (IKA.db.profile.group_sorting == 3) then
			block:SetSize (barwidth_grid, barheight_grid)
			for _, debuff in ipairs (block.inside_debuffs) do
				debuff:SetSize (barwidth_grid/2, barheight_grid/2)
			end
			
			
			
		end
		
		--text font
		local fontfile = SharedMedia:Fetch ("font", textfont)
		IKA:SetFontFace (block.playername, fontfile)
		--text size
		IKA:SetFontSize (block.playername, textsize)
		--text shadow
		IKA:SetFontOutline (block.playername, textshadow)

		block.stack_count:ClearAllPoints()
		
		if (stack_anchor == "top") then
			block.stack_count:SetPoint ("center", block.playername, "center")
			block.stack_count:SetPoint ("bottom", block.playername, "top", 0, 1)
		elseif (stack_anchor == "bottom") then
			block.stack_count:SetPoint ("center", block.playername, "center")
			block.stack_count:SetPoint ("top", block.playername, "bottom", 0, -1)
		elseif (stack_anchor == "left") then
			block.stack_count:SetPoint ("right", block.playername, "left", -2, 0)
		elseif (stack_anchor == "right") then
			block.stack_count:SetPoint ("left", block.playername, "right", 2, 0)
		end
		
		--cooldown side
		local debuffs_blocks = block.debuffs
		if (right_side_debuffs) then
			for i = 1, 4 do
				local cooldown_support = debuffs_blocks [i]
				cooldown_support:ClearAllPoints()
				if (i == 1) then
					cooldown_support:SetPoint ("left", block, "right", 3, 0)
				else
					cooldown_support:SetPoint ("left", debuffs_blocks [i-1], "right", 3, 0)
				end
			end
		else
			for i = 1, 4 do
				local cooldown_support = debuffs_blocks [i]
				cooldown_support:ClearAllPoints()
				if (i == 1) then
					cooldown_support:SetPoint ("right", block, "left", -3, 0)
				else
					cooldown_support:SetPoint ("right", debuffs_blocks [i-1], "left", -3, 0)
				end
			end
		end
	end
	
	function f:SetPlayerBlockConfig (block, bartexture, barwidth, barheight, textfont, textsize, textshadow, right_side_debuffs, dispel_ready, barwidth_grid, barheight_grid, stack_anchor)
		local profile = IKA.db.profile
		
		--get and set values
		bartexture = bartexture or profile.bartexture
		profile.bartexture = bartexture
		
		barwidth = barwidth or profile.barwidth
		profile.barwidth = barwidth
		barheight = barheight or profile.barheight
		profile.barheight = barheight
		
		barwidth_grid = barwidth_grid or profile.barwidth_grid
		profile.barwidth_grid = barwidth_grid
		barheight_grid = barheight_grid or profile.barheight_grid
		profile.barheight_grid = barheight_grid
		
		textfont = textfont or profile.textfont
		profile.textfont = textfont
		textsize = textsize or profile.textsize
		profile.textsize = textsize
		textshadow = textshadow or profile.textshadow
		profile.textshadow = textshadow		
		right_side_debuffs = right_side_debuffs or profile.right_side_debuffs
		profile.right_side_debuffs = right_side_debuffs
		dispel_ready = dispel_ready or profile.dispel_ready
		profile.dispel_ready = dispel_ready
		
		stack_anchor = stack_anchor or profile.stack_count_anchor
		profile.stack_count_anchor = stack_anchor
		
		--change the blocks
		if (block) then
			do_block_changes (block, bartexture, barwidth, barheight, textfont, textsize, textshadow, right_side_debuffs, dispel_ready, barwidth_grid, barheight_grid, stack_anchor)
		else
			for i = 1, #f.player_blocks do
				do_block_changes (f.player_blocks [i], bartexture, barwidth, barheight, textfont, textsize, textshadow, right_side_debuffs, dispel_ready, barwidth_grid, barheight_grid, stack_anchor)
			end
		end
		
		--update the frame background
		f:UpdateFrameBackground()
	end
	
	function f:UpdateFrameBackground (amt_blocks_shown, groups_amt, max_players)
		amt_blocks_shown = amt_blocks_shown or allplayers.n or 0
		groups_amt = groups_amt or allplayers.g_amt or 0
		max_players = max_players or allplayers.g_line_amt or 0
		
		if (not amt_blocks_shown) then
			return
		end
		
		--> set the size for simple alphabetical order
		if (IKA.db.profile.group_sorting == 1) then
			local height = IKA.db.profile.barheight+1
			f:SetWidth (IKA.db.profile.barwidth + 4)
			f:SetHeight (height * amt_blocks_shown)
		
		elseif (IKA.db.profile.group_sorting == 2) then
			local height = IKA.db.profile.barheight+1
			f:SetWidth (IKA.db.profile.barwidth + 4)
			f:SetHeight ((height * amt_blocks_shown) + (groups_amt*10) + 8)
			
		elseif (IKA.db.profile.group_sorting == 3) then
			local height = IKA.db.profile.barheight_grid+1
			f:SetWidth (math.max ((IKA.db.profile.barwidth_grid * groups_amt) + 4 + groups_amt, 100))
			f:SetHeight (math.max ((height * max_players) + 2, 20))
		end
	end
	
	local on_enter_player_block = function (self)
		self.myblock.mouse_texture:Show()
	end
	local on_leave_player_block = function (self)
		self.myblock.mouse_texture:Hide()
	end
	
	function f:CreatePlayerBlock()
	
		local b = CreateFrame ("frame", "IskarAssistBlockSupport" .. #f.player_blocks+1, f)
		tinsert (f.player_blocks, b)

		-- protected button (secure)
			local button = CreateFrame ("button", "IskarAssistActionButtonForBlock" .. #f.player_blocks, f, "SecureActionButtonTemplate")
			button:SetPoint ("topleft", b, "topleft")
			button:SetPoint ("bottomright", b, "bottomright")
			button:SetFrameLevel (b:GetFrameLevel() + 4)
			
			button:SetAttribute ("type1", "macro")
			button:SetAttribute ("type2", "spell")
			button:SetAttribute ("type3", "macro")
			button:RegisterForClicks ("AnyUp")
			
			b.button = button
			button.myblock = b
			
			button:SetScript ("OnEnter", on_enter_player_block)
			button:SetScript ("OnLeave", on_leave_player_block)
		--
		
		--lower frame
		local background_frame = CreateFrame ("statusbar", "IskarAssistBlockBackground" .. #f.player_blocks, b)
		background_frame:SetFrameLevel (b:GetFrameLevel()-1)
		background_frame:SetAllPoints()
		background_frame:SetMinMaxValues (0, 100)
		b.statusbar = background_frame
		--overlay frame
		local overlay_frame = CreateFrame ("frame", "IskarAssistBlockOverlay" .. #f.player_blocks, b)
		overlay_frame:SetFrameLevel (b:GetFrameLevel()+2)
		overlay_frame:SetAllPoints()
		
		--> player class texture
		local texture = background_frame:CreateTexture (nil, "background")
		texture:SetAllPoints()
		texture:SetDrawLayer ("background", 1)
		background_frame:SetStatusBarTexture (texture)
		b.block_texture = texture
		local texture2 = background_frame:CreateTexture (nil, "background")
		texture2:SetAllPoints()
		texture2:SetDrawLayer ("background", 2)
		texture2:Hide()
		texture2:SetTexture (1, 1, 1, 0.1)
		b.mouse_texture = texture2
		
		local name = overlay_frame:CreateFontString (nil, "overlay", "GameFontHighlight")
		name:SetPoint ("center", b, "center")
		b.playername = name
		
		local dc = overlay_frame:CreateTexture (nil, "artwork")
		dc:SetPoint ("right", b, "right", 3, 0)
		dc:SetSize (35, 35)
		dc:SetTexture ([[Interface\CHARACTERFRAME\Disconnect-Icon]])
		dc:SetDrawLayer ("artwork", 3)
		dc:Hide()
		b.offline_icon = dc
		
		local dead = overlay_frame:CreateTexture (nil, "artwork")
		dead:SetPoint ("right", b, "right", 0, 0)
		dead:SetSize (20, 20)
		dead:SetTexture ([[Interface\WorldStateFrame\SkullBones]])
		dead:SetTexCoord (0, 32/64, 0, 33/64)
		dead:Hide()
		dead:SetDrawLayer ("artwork", 4)
		b.dead_icon = dead
		
		local dead_overlay = b:CreateTexture (nil, "artwork")
		dead_overlay:SetAllPoints()
		dead_overlay:SetTexture (0, 0, 0, 0.85)
		dead_overlay:Hide()
		b.dead_overlay = dead_overlay
		dead_overlay:SetDrawLayer ("artwork", 5)
		
		local stack_count = overlay_frame:CreateFontString (nil, "overlay", "GameFontNormal")
		stack_count:SetPoint ("center", name, "center")
		stack_count:SetPoint ("bottom", name, "top", 0, 1)
		IKA:SetFontSize (stack_count, 14)
		b.stack_count = stack_count
		
		--> outside debuffs
		b.debuffs = {}
		for i = 1, 4 do
			local cooldown_support = CreateFrame ("frame", nil, b)
			tinsert (b.debuffs, cooldown_support)

			local texture = cooldown_support:CreateTexture (nil, "border")
			texture:SetPoint ("topleft", cooldown_support, "topleft")
			texture:SetPoint ("bottomright", cooldown_support, "bottomright")
			cooldown_support.texture = texture
		
			local cooldown = CreateFrame ("cooldown", "IskarAssistCD" .. #f.player_blocks .. "_" .. i, cooldown_support, "CooldownFrameTemplate")
			cooldown:SetAllPoints()
			cooldown_support.cooldown = cooldown
			
			cooldown_support:Hide()
		end
		
		--> internal debuffs
		b.inside_debuffs = {}

		for i = 1, 4 do
			local cooldown_support = CreateFrame ("frame", nil, b)
			tinsert (b.inside_debuffs, cooldown_support)
			cooldown_support:SetFrameLevel (b:GetFrameLevel()+1)
			
			local texture = cooldown_support:CreateTexture (nil, "border")
			texture:SetPoint ("topleft", cooldown_support, "topleft")
			texture:SetPoint ("bottomright", cooldown_support, "bottomright")
			cooldown_support.texture = texture
			
			cooldown_support:SetSize (20, 20)
		
			local cooldown = CreateFrame ("cooldown", "IskarAssistCDInside" .. #f.player_blocks .. "_" .. i, cooldown_support, "CooldownFrameTemplate")
			cooldown:SetAllPoints()
			cooldown_support.cooldown = cooldown
			
			if (i == 1) then
				cooldown_support:SetPoint ("topleft", b, "topleft")
				local _, _, tex = GetSpellInfo (181957) --Phantasmal Winds
				texture:SetTexture (tex)
				texture:SetTexCoord (unpack (no_border))
				
			elseif (i == 2) then
				cooldown_support:SetPoint ("topright", b, "topright")
				local _, _, tex = GetSpellInfo (181753) --Fel Bomb
				texture:SetTexture (tex)
				texture:SetTexCoord (unpack (no_border))
				
			elseif (i == 3) then
				cooldown_support:SetPoint ("bottomleft", b, "bottomleft")
				local _, _, tex = GetSpellInfo (182325) --Phantasmal Wounds
				texture:SetTexture (tex)
				texture:SetTexCoord (unpack (no_border))
				
			elseif (i == 4) then
				cooldown_support:SetPoint ("bottomright", b, "bottomright")
				local _, _, tex = GetSpellInfo (181824) --Phantasmal Corruption
				texture:SetTexture (tex)
				texture:SetTexCoord (unpack (no_border))
				
			end
			
			cooldown_support:Hide()
		end

		f:SetPlayerBlockConfig (b)
		
		return b
	end

	function f:ClearFrames()
		for _, block in ipairs (f.player_blocks) do
			for _, debuff in ipairs (block.debuffs) do
				debuff.cooldown:SetCooldown (0, 0, 0, 0)
				debuff:Hide()
			end

			for _, debuff in ipairs (block.inside_debuffs) do
				debuff.cooldown:SetCooldown (0, 0, 0, 0)
				debuff:Hide()
			end
			
			block.dead_icon:Hide()
			block.dead_overlay:Hide()
			block.stack_count:Hide()
			
			if (block.unitid) then
				f.dead_cache [block.unitid] = nil
			end
			
			block.statusbar:SetValue (100)
		end
		
		wipe (f.track_player_health)
		
		anzu_texture:Hide()
	end

	function IKA:DispelCooldown (who_name)
		if (f.dispell_ready) then
			f.dispell_ready [who_name] = f.dispell_ready [who_name] + 1
			f:UpdateDispelsAndInterruptsIcons()
		end
	end

	function IKA:UpdateDispelsAndInterruptsIcons()
		return f:UpdateDispelsAndInterruptsIcons()
	end
	
	function f:UpdateDispelsAndInterruptsIcons()
		if (f.dispell_ready and IKA.db.profile.dispel_ready) then
			for playername, amount in pairs (f.dispell_ready) do
				if (not UnitIsDeadOrGhost (playername)) then
					if (amount < 1) then
						--> doesn't have
						local block = f.player_blocks [player_index [playername]]
						if (block) then
							block.dead_icon:Hide()
						end
					else
						--> have dispel
						local block = f.player_blocks [player_index [playername]]
						if (block) then
							block.dead_icon:SetTexture ([[Interface\ICONS\SPELL_HOLY_DISPELMAGIC]])
							block.dead_icon:SetTexCoord (5/64, 59/64, 5/64, 59/64)
							block.dead_icon:SetAlpha (0.7)
							block.dead_icon:SetBlendMode ("ADD")
							block.dead_icon:Show()
							
							if (IKA.db.profile.group_sorting < 3) then
								block.dead_icon:SetSize (20, 20)
							elseif (IKA.db.profile.group_sorting == 3) then
								block.dead_icon:SetSize (12, 12)
							end
						end
					end
				end
			end
		end
	end
	
	function f:SetClassColor (block, unitid, dc_icon_only, dead_icon_only)

		--UnitIsDeadOrGhost
		if (not dead_icon_only) then
			if (UnitIsConnected (unitid)) then
				if (not dc_icon_only) then
					local _, class = UnitClass (unitid)
					if (class) then
						local color = RAID_CLASS_COLORS [class]
						block.block_texture:SetVertexColor (color.r, color.g, color.b)
					else
						block.block_texture:SetVertexColor (.8, .8, .8)
					end
				end
				block.offline_icon:Hide()
			else
				if (not dc_icon_only) then
					block.block_texture:SetVertexColor (.2, .2, .2)
				end
				block.offline_icon:Show()
			end
		end
		
		if (not dc_icon_only) then
			if (not UnitIsDeadOrGhost (unitid)) then
				block.dead_icon:Hide()
				block.dead_overlay:Hide()
				f.dead_cache [unitid] = nil
			else
				block.dead_icon:Show()
				block.dead_icon:SetTexture ([[Interface\WorldStateFrame\SkullBones]])
				block.dead_icon:SetTexCoord (0, 32/64, 0, 33/64)
				block.dead_icon:SetAlpha (1)
				block.dead_icon:SetBlendMode ("BLEND")
				if (IKA.db.profile.group_sorting < 3) then
					block.dead_icon:SetSize (20, 20)
				elseif (IKA.db.profile.group_sorting == 3) then
					block.dead_icon:SetSize (12, 12)
				end
				block.dead_overlay:Show()
				f.dead_cache [unitid] = true
			end
		end
	end

	function f:UpdatePlayerBlock (block, playername, unitid, block_index)
		--> set the player index within our frame
		player_index [playername] = block_index
		
		--> set the name without the realm name
		local max_size
		if (IKA.db.profile.group_sorting < 3) then
			max_size = IKA.db.profile.barwidth - 4
		elseif (IKA.db.profile.group_sorting == 3) then
			max_size = IKA.db.profile.barwidth_grid - 4
		end
		
		max_size = max (max_size, 25)
		
		local name = playername --> make a copy of the variable
		name = name:gsub (("%-.*"), "")
		block.playername:SetText (name)
		
		for i = 1, 12 do
			if (block.playername:GetStringWidth() > max_size) then
				name = strsub (name, 1, #name-1)
				block.playername:SetText (name)
			else
				break
			end
		end
		
		--> set the color of the block
		f:SetClassColor (block, unitid)
		
		--> set the action for clicks
		if (not playername or playername == "") then
			print ("|cFFFFAA00Iskar Assist|r:", "Warning: player name is invalid:", playername, unitid, block_index, GetUnitName (unitid or "", true))
		end
		
		block.button:SetFrameLevel (block:GetFrameLevel() + 4)
		
		block.button:SetAttribute ("macrotext1", "/targetexact " .. (playername or "") .. "\n/click ExtraActionButton1\n/targetlasttarget") -- /say %t\n
		--block.button:SetAttribute ("macrotext1", "/targetexact Ditador") -- /say %t\n
		--block.button:SetAttribute ("macrotext1", "/targetexact " .. (playername or "") .. "\n/click ExtraActionButton1") -- /say %t\n -- (tests)
		block.button:SetAttribute ("macrotext3", "/targetexact " .. (playername or ""))
		
		block.button:SetAttribute ("unit", unitid or "")

		if (player_class == "PRIEST") then
			block.button:SetAttribute ("spell2", dispel_purify)
		elseif (player_class == "PALADIN") then
			block.button:SetAttribute ("spell2", dispel_cleanse)
		elseif (player_class == "SHAMAN") then
			block.button:SetAttribute ("spell2", dispel_purify_spirit)
		elseif (player_class == "DRUID") then
			block.button:SetAttribute ("spell2", dispel_naturescure)
		elseif (player_class == "MONK") then
			block.button:SetAttribute ("spell2", dispel_detox)
		elseif (player_class == "WARLOCK") then
			--check if the player has grimory of sacrifice
			local ativo = GetActiveSpecGroup()
			local talentID, name, texture, selected, available = GetTalentInfo (5, 3, ativo)
			if (selected) then
				--grimory of sacrifice
				local command_demon = GetSpellInfo (119898)
				block.button:SetAttribute ("spell2", command_demon)
			else
				--use the pet dispell
				block.button:SetAttribute ("spell2", dispel_sear_magic)
			end
		end

		block.name = playername
		block.unitid = unitid
		block:Show()
	end
	
	function f:BuildInGroupOrder (groups)
		for g = 1, IKA.MaxGroups do
			local a = 0
			for i = 1, GetNumGroupMembers() do
				local _, _, subgroup = GetRaidRosterInfo (i)
				if (subgroup == g) then
					local unitid = "raid" .. i
					local fullname = GetUnitName (unitid, true)
					unitids [fullname] = unitid
					tinsert (allplayers, fullname)
					tinsert (groups [subgroup], fullname)
					a = a + 1
					if (a == 5) then
						break
					end
				end
			end
		end
	end
	
	function f:SortGroups (event)
		
		if (UnitAffectingCombat ("player") or InCombatLockdown()) then
			if (event == "UNIT_CONNECTION") then
				f:RefreshPlayerIconConnection()
			end
			f:debug ("in Combat, can't update unit frame, scheduling up...")
			f.schedule_sort = true
			return
		end
		
		if (not IsInRaid()) then
			f:debug ("Isn't in a raid group.")
			return
		end

		f:debug ("Building the unit frame...")
		
		f.schedule_sort = false
		f:SetFrameStrata (IKA.db.profile.MainPanel_strata)
		
		f:ClearFrames()
		wipe (allplayers)
		wipe (unitid_to_block)
		wipe (name_to_block)
		
		for i = 1, #f.player_blocks do
			f.player_blocks[i]:Hide()
		end
		
		--> alphabetical
		if (IKA.db.profile.group_sorting == 1) then
		
			for _, label in ipairs (group_labels) do
				label:SetAlpha (0)
			end

			for i = 1, GetNumGroupMembers() do
				local name, rank, subgroup, level, class, fileName, zone, online, isDead, role, isML, assignedRole = GetRaidRosterInfo (i)
				if (subgroup < (IKA.MaxGroups+1)) then
					local unitid = "raid" .. i
					local fullname = GetUnitName (unitid, true)
					tinsert (allplayers, fullname)
					unitids [fullname] = unitid
				end
			end
			table.sort (allplayers, sort_alphabetical)
			
			allplayers.n = #allplayers
			f:UpdateFrameBackground (allplayers.n)
			
			local height = IKA.db.profile.barheight+1
			
			for i = 1, allplayers.n do
				--> get the player name and its unitid in the raid frame
				local playername = allplayers [i]
				local unitid = unitids [playername]
			
				--> get a block for this player
				local block = f.player_blocks [i]
				if (not block) then
					block = f:CreatePlayerBlock()
				end
				
				--> update it
				f:UpdatePlayerBlock (block, playername, unitid, i)
				name_to_block [playername] = block
				unitid_to_block [unitid] = block
				
				block:Show()
				block:ClearAllPoints()
				block:SetPoint ("topleft", f, "topleft", 2, (i * height * -1) + height)
			end
			
		--> order by groups	
		elseif (IKA.db.profile.group_sorting == 2) then
			local groups = { {}, {}, {}, {}, {}, {} }
			
			-- does some way some how the rosterinfo pass the information not in correct order? well let's just avoid this possibility.
			f:BuildInGroupOrder (groups)
			
			allplayers.n = #allplayers
			
			local group_amt = 0
			local block_index = 1
			local height = IKA.db.profile.barheight+1
			local last_block
			
			f:ClearGroupLabels()
			
			for i = 1, #groups do
				local this_group = groups [i] -- group 1
				local amt_players = #this_group -- 5
				
				if (amt_players > 0) then
					group_amt = group_amt + 1 -- now has 1 group
					
					--set the label for the group
					local label = group_labels [i]
					label:Show()
					
					if (not last_block) then
						label:SetPoint ("topright", f, "topright", 0, -5)
					else
						label:SetPoint ("topright", last_block, "bottomright", 0, -5)
					end

					label:SetAlpha (1)
				end
				
				for index, playername in pairs (this_group) do
					--> get the player name and its unitid in the raid frame
					local unitid = unitids [playername]
				
					--> get a block for this player
					local block = f.player_blocks [block_index]
					if (not block) then
						block = f:CreatePlayerBlock()
					end
					
					--> set its point
					block:ClearAllPoints()
					if (not last_block) then
						block:SetPoint ("topright", f, "topright", -2, -17)
					elseif (index == 1) then
						--leave some space for the group label title
						block:SetPoint ("topleft", last_block, "bottomleft", 0, -17)
					else
						block:SetPoint ("topleft", last_block, "bottomleft", 0, -1)
					end
					
					--> update it
					f:UpdatePlayerBlock (block, playername, unitid, block_index)
					name_to_block [playername] = block
					unitid_to_block [unitid] = block
					
					block_index = block_index + 1 --get block 2
					last_block = block --the last block is this
				end
			end
			
			allplayers.g_amt = group_amt
			
			f:UpdateFrameBackground (allplayers.n, group_amt)

		--> grid style
		elseif (IKA.db.profile.group_sorting == 3) then
		
			for _, label in ipairs (group_labels) do
				label:SetAlpha (0)
			end
		
			local groups = { {}, {}, {}, {}, {}, {} }
			
			-- does some way some how the rosterinfo pass the information not in correct order? well let's just avoid this possibility.
			f:BuildInGroupOrder (groups)
			
			allplayers.n = #allplayers
			
			local group_amt = 0
			local max_players = 0
			local block_index = 1
			local height = IKA.db.profile.barheight_grid+1
			local last_block
			local last_top_block
			
			f:ClearGroupLabels()
			
			for i = 1, #groups do
				local this_group = groups [i]
				local amt_players = #this_group
				
				if (amt_players > 0) then
					group_amt = group_amt + 1
				end
				
				for index, playername in pairs (this_group) do
					--> get the player name and its unitid in the raid frame
					local unitid = unitids [playername]
				
					--> get a block for this player
					local block = f.player_blocks [block_index]
					if (not block) then
						block = f:CreatePlayerBlock()
					end
					
					--> set its point
					block:ClearAllPoints()
					if (not last_block) then
						block:SetPoint ("topleft", f, "topleft", 2, -2)
						last_top_block = block
					elseif (index == 1) then
						block:SetPoint ("topleft", last_top_block, "topright", 1, 0)
						last_top_block = block
					else
						block:SetPoint ("topleft", last_block, "bottomleft", 0, -1)
					end
					
					--> update it
					f:UpdatePlayerBlock (block, playername, unitid, block_index)
					name_to_block [playername] = block
					unitid_to_block [unitid] = block
					
					block_index = block_index + 1
					last_block = block
					
					if (index > max_players) then
						max_players = index
					end
				end
			end
			
			allplayers.g_amt = group_amt
			allplayers.g_line_amt = max_players
			
			f:UpdateFrameBackground (allplayers.n, group_amt, max_players)
		end
		
		f:UpdateDispelsAndInterruptsIcons()
		
	end

	function f:StartTrackDistance()
		if (IKA.tracking_distance_pid) then
			IKA:CancelTimer (IKA.tracking_distance_pid)
			IKA.tracking_distance_pid = nil
		end
		IKA.tracking_distance_pid = IKA:ScheduleRepeatingTimer ("DistanceTracker", 0.2)
	end

	function f:StopTrackDistance()
		if (IKA.tracking_distance_pid) then
			IKA:CancelTimer (IKA.tracking_distance_pid)
			IKA.tracking_distance_pid = nil
		end
	end

	f:SetScript ("OnShow", function (self)
		f.enabled = true
		frame_event:RegisterEvent ("UNIT_CONNECTION")
		frame_event:RegisterEvent ("UNIT_HEALTH")
		frame_event:RegisterEvent ("UNIT_HEALTH_FREQUENT")
		frame_event:RegisterEvent ("PARTY_MEMBERS_CHANGED")
		frame_event:RegisterEvent ("GROUP_ROSTER_UPDATE")
		frame_event:RegisterEvent ("PLAYER_ENTERING_WORLD")
		frame_event:RegisterEvent ("UNIT_NAME_UPDATE")
		
		f:RegisterEvent ("COMBAT_LOG_EVENT_UNFILTERED")
		
		f:SortGroups()
		f:StartTrackDistance()
	end)
	f:SetScript ("OnHide", function (self)
		f.enabled = false
		frame_event:UnregisterEvent ("UNIT_CONNECTION")
		frame_event:UnregisterEvent ("UNIT_HEALTH")
		frame_event:UnregisterEvent ("UNIT_HEALTH_FREQUENT")
		frame_event:UnregisterEvent ("PARTY_MEMBERS_CHANGED")
		frame_event:UnregisterEvent ("GROUP_ROSTER_UPDATE")
		frame_event:UnregisterEvent ("PLAYER_ENTERING_WORLD")
		frame_event:UnregisterEvent ("UNIT_NAME_UPDATE")
		
		f:UnregisterEvent ("COMBAT_LOG_EVENT_UNFILTERED")
		
		f:StopTrackDistance()
	end)

	--> in case a player falls off during the combat, it doesn't refresh everything only the icon
	function f:RefreshPlayerIconConnection()
		if (allplayers.n) then
			for i = 1, allplayers.n do
				local playername = allplayers [i]
				local unitid = unitids [playername]
				local block = name_to_block [playername]
				if (block) then
					f:SetClassColor (block, unitid, true)
				end
			end
		end
	end

	function f:UnitDiedOrRessed (playername, died)
		local index = player_index [playername]
		if (index) then
			local block = name_to_block [playername]
			if (block) then
				local unitid = unitids [playername]
				f:SetClassColor (block, unitid, _, true)
				if (died) then
					f.dead_cache [unitid] = true
				else
					f.dead_cache [unitid] = false
				end
				
				f:UpdateDispelsAndInterruptsIcons()
			end
		end
	end
	
	local f_anim = CreateFrame ("frame", nil, f)
	local t = f_anim:CreateTexture (nil, "overlay")
	t:SetTexCoord (0, 0.78125, 0, 0.66796875)
	t:SetTexture ([[Interface\AchievementFrame\UI-Achievement-Alert-Glow]])
	t:SetAllPoints()
	t:SetBlendMode ("ADD")
	local animation = t:CreateAnimationGroup()
	local anim1 = animation:CreateAnimation ("Alpha")
	local anim2 = animation:CreateAnimation ("Alpha")
	anim1:SetOrder (1)
	anim1:SetFromAlpha (0)
	anim1:SetToAlpha (1)
	anim1:SetDuration (0.1)
	anim2:SetOrder (2)
	anim2:SetFromAlpha (1)
	anim2:SetToAlpha (0)
	anim2:SetDuration (0.2)
	
	animation:SetScript ("OnFinished", function (self)
		f_anim:Hide()
	end)

	local do_flash_anim = function (block)
		f_anim:Show()
		f_anim:SetParent (block)
		f_anim:SetPoint ("topleft", block, "topleft", -20, 20)
		f_anim:SetPoint ("bottomright", block, "bottomright", 20, -20)
		animation:Play()
	end
	
	function f:SetStackCount (target_name, stack_amt)
		local block = name_to_block [target_name]
		if (block and type (stack_amt) == "number") then
			if (stack_amt > 0) then
				block.stack_count:SetText (stack_amt)
				block.stack_count:Show()
			else
				block.stack_count:Hide()
			end
		end
	end
	
	--> combatlog stuff
	function f:SetAnzu (target_name)
		local block = name_to_block [target_name]
		if (block) then
			block.block_texture:SetVertexColor (1, 1, 0)
			anzu_texture:ClearAllPoints()
			
			if (IKA.db.profile.group_sorting < 3) then
				anzu_texture:SetPoint ("left", block, "left", 2, 0)
			elseif (IKA.db.profile.group_sorting == 3) then
				anzu_texture:SetPoint ("center", block, "center", 0, 6)
			end
			
			anzu_texture:SetParent (block)
			anzu_texture:Show()
			if (IKA.db.profile.eye_flash_anim) then
				do_flash_anim (block)
			end
		end
		f:debug ("Anzu on", target_name)
	end

	function f:RemoveAnzu (target_name)
		local block = name_to_block [target_name]
		if (block) then
			anzu_texture:Hide()
			local unitid = unitids [target_name]
			if (unitid) then
				f:SetClassColor (block, unitid)
			end
		end
		f:debug ("Anzu leaves", target_name)
	end
	
	function f:SetGridAura (block, target_name, spellname, spellid)
		local debuff_block = grid_aura_index [spellname]
		debuff_block = block.inside_debuffs [debuff_block]
		
		if (not debuff_block) then
			return 
			--print ("|cFFFFAA00Iskar Assist|r:", "debuff not found", spellname, spellid)
			--"debuff not found Phantasmal Fel Bomb 179219"
		end
		
		debuff_block:Show() --stan bug
		
		if (IKA.db.profile.cooldown) then
			local _, _, icon, count, _, duration, expirationTime = UnitDebuff (target_name, spellname)
			if (expirationTime) then
				debuff_block.cooldown:SetCooldown (GetTime(), expirationTime-GetTime(), 0, 0)
			end
		end
	end

	function f:RemoveGridAura (block, target_name, spellname, spellid)
		local debuff_block = grid_aura_index [spellname]
		debuff_block = block.inside_debuffs [debuff_block]
		
		if (not debuff_block) then
			return 
			--print ("|cFFFFAA00Iskar Assist|r:", "debuff not found", spellname, spellid)
		end
		
		debuff_block.cooldown:SetCooldown (0, 0, 0, 0)
		debuff_block:Hide()
	end
	
	function f:SetAuraDarkBindings (target_name, applied)
		if (applied) then
			local block = name_to_block [target_name]
			if (block) then
				block:SetBackdrop ({edgeFile = [[Interface\Buttons\WHITE8X8]], edgeSize = 3})
				block:SetBackdropBorderColor (146/255, 114/255, 183/255)
			end
		else
			local block = name_to_block [target_name]
			if (block) then
				block:SetBackdrop (nil)
			end
		end
	end
	
	function f:SetAura (target_name, spellname, spellid)
		local block = name_to_block [target_name]
		
		if (block) then
		
			if (spellname == aura_dark_bindings) then
				return f:SetAuraDarkBindings (target_name, true)
			end
			
			if (spellname == aura_phantasmal_wounds) then
				if (block.unitid) then
					f.track_player_health [block.unitid] = true
					block.statusbar:SetValue (UnitHealth (block.unitid)/UnitHealthMax (block.unitid)*100)
				end
			end
		
			if (IKA.db.profile.group_sorting == 3) then
				return f:SetGridAura (block, target_name, spellname, spellid)
			end
		
			local isDose = false
			for i = 1, 4 do
				local d = block.debuffs [i]
				if (d:IsShown() and d.spell == spellname) then
					local _, _, icon, count, _, duration, expirationTime = UnitDebuff (target_name, spellname)
					if (expirationTime) then
						if (IKA.db.profile.cooldown) then
							d.cooldown:SetCooldown (GetTime(), expirationTime-GetTime(), 0, 0)
						end
					end
					isDose = true
					break
				end
			end
			
			if (not isDose) then
				for i = 1, 4 do
					local d = block.debuffs [i]
					if (not d:IsShown()) then
						d:Show()
						
						local _, _, icon, count, _, duration, expirationTime = UnitDebuff (target_name, spellname)
						if (expirationTime) then
							if (IKA.db.profile.cooldown) then
								d.cooldown:SetCooldown (GetTime(), expirationTime-GetTime(), 0, 0)
							end
						end
						
						local _, _, icon = GetSpellInfo (spellid)
						d.texture:SetTexture (icon)
						d.texture:SetTexCoord (4/64, 60/64, 4/64, 60/64)
						
						d.spell = spellname
						
						break
					end
				end
			end
		end
	end

	function f:RemoveAura (target_name, spellname, spellid)
	
		local block = name_to_block [target_name]
		if (block) then

			if (spellname == aura_dark_bindings) then
				return f:SetAuraDarkBindings (target_name, false)
			end
			
			if (spellname == aura_phantasmal_wounds) then
				if (block.unitid) then
					f.track_player_health [block.unitid] = nil
					block.statusbar:SetValue (100)
				end
			end
		
			if (IKA.db.profile.group_sorting == 3) then
				return f:RemoveGridAura (block, target_name, spellname, spellid)
			end
		
			for i = 1, 4 do
				local d = block.debuffs [i]
				if (d:IsShown() and d.spell == spellname) then
					d.cooldown:SetCooldown (0, 0, 0, 0)
					d:Hide()
					d.spell = nil
					break
				end
			end
		end
	end
	
	function IKA:DistanceTracker()
		if (allplayers.n) then
			for i = 1, allplayers.n do
				local playername = allplayers [i]
				local block = name_to_block [playername]
				if (block) then
					local r, g, b, a = block.block_texture:GetVertexColor()
					local tr, tg, tb, ta = block.playername:GetTextColor()
					if (UnitInRange (unitids [playername])) then
						block.block_texture:SetVertexColor (r, g, b, 1)
						block.playername:SetTextColor (tr, tg, tb, 1)
					else
						block.block_texture:SetVertexColor (r, g, b, 0.2)
						block.playername:SetTextColor (tr, tg, tb, 0.2)
					end
				end
			end
		end
	end

	--on update func
	local fel_cooldown_on_update = function (self, elapsed)
		local now = GetTime()
		if (now > self.end_time) then
			self:SetScript ("OnUpdate", nil)
			self:Hide()
			return
		end
		
		self:SetValue (now)
		self.time_left:SetText (format ("%.1f", self.end_time - now))
	end
	
	--on move func
	local fel_cooldown_mouse_down = function (self, button)
		if (self.isMoving) then
			return
		end
		fel_conduit_save_position:StartMoving() 
		self.isMoving = true
	end
	local fel_cooldown_mouse_up = function (self, button) 
		if (self.isMoving) then
			fel_conduit_save_position:StopMovingOrSizing()
			fel_conduit_save_position:SetUserPlaced (true)
			self.isMoving = nil
		end
	end
	
	--set cooldown func
	local fel_set_cooldown = function (self, heroic, normal, cancel)
		if (cancel) then
			self:SetScript ("OnUpdate", nil)
			self:Hide()
			return
		end
	
		local name, type, difficulty, difficultyName, maxPlayers, playerDifficulty, isDynamicInstance, mapID, instanceGroupSize = GetInstanceInfo()

		--heroic and mythic has 18s cooldown.
		-- normal has 23s cooldown.
		local cooldowntimer = normal --normal raid finder
		if (difficulty == 15 or difficulty == 16) then --heroic mythic
			cooldowntimer = heroic
		end
		
		--print ("difficulty:",  difficulty, "cd timer:", cooldowntimer)
		
		local now = GetTime()
		local min_value, max_value = now, now + cooldowntimer
		self.end_time = max_value
		self:SetMinMaxValues (min_value, max_value)
		self:SetScript ("OnUpdate", fel_cooldown_on_update)
		self:Show()
	end	
	
	-- fel conduit
	local fel_conduit_cooldown = CreateFrame ("StatusBar", "IskarAssistFelConduitCastBar", UIParent)
	fel_conduit_cooldown:SetPoint ("center", fel_conduit_save_position, "center")
	fel_conduit_cooldown:SetSize (300, 30)
	fel_conduit_cooldown:SetMovable (true)
	fel_conduit_cooldown:EnableMouse (true)
	fel_conduit_cooldown:SetUserPlaced (true)
	fel_conduit_cooldown:Hide()
	fel_conduit_cooldown.SetBarCooldown = fel_set_cooldown
	f.fel_conduit_cooldown = fel_conduit_cooldown
	
	fel_conduit_cooldown:SetScript ("OnMouseDown", fel_cooldown_mouse_down)
	fel_conduit_cooldown:SetScript ("OnMouseUp", fel_cooldown_mouse_up)
	fel_conduit_cooldown:SetBackdrop ({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 16})
	fel_conduit_cooldown:SetBackdropColor (0, 0, 0, 0.5)
	
	fel_conduit_cooldown.texture = fel_conduit_cooldown:CreateTexture (nil, "artwork")
	fel_conduit_cooldown.texture:SetTexture ([[Interface\AddOns\IskarAssist\bar_serenity]])
	fel_conduit_cooldown.texture:SetVertexColor (.5, 1, .5)
	fel_conduit_cooldown:SetStatusBarTexture (fel_conduit_cooldown.texture)
	
	fel_conduit_cooldown.icon = fel_conduit_cooldown:CreateTexture (nil, "overlay")
	fel_conduit_cooldown.icon:SetTexture (spell_fel_conduit_icon)
	fel_conduit_cooldown.icon:SetPoint ("topright", fel_conduit_cooldown, "topleft")
	fel_conduit_cooldown.icon:SetSize (30, 30)
	fel_conduit_cooldown.text = fel_conduit_cooldown:CreateFontString (nil, "overlay", "GameFontNormal")
	fel_conduit_cooldown.text:SetText (spell_fel_conduit .. " cooldown")
	fel_conduit_cooldown.text:SetPoint ("left", fel_conduit_cooldown, "left", 2, 0)
	fel_conduit_cooldown.time_left = fel_conduit_cooldown:CreateFontString (nil, "overlay", "GameFontNormal")
	fel_conduit_cooldown.time_left:SetText ("0s")
	fel_conduit_cooldown.time_left:SetPoint ("right", fel_conduit_cooldown, "right", -2, 0)
	fel_conduit_cooldown.time_left:SetJustifyH ("right")
	
	--fel bomb
	local fel_bomb_cooldown = CreateFrame ("StatusBar", "IskarAssistFelBombCastBar", UIParent)
	fel_bomb_cooldown:SetPoint ("topleft", fel_conduit_cooldown, "bottomleft", 0, -1)
	fel_bomb_cooldown:SetSize (300, 30)
	fel_bomb_cooldown:SetMovable (true)
	fel_bomb_cooldown:EnableMouse (true)
	fel_bomb_cooldown:SetUserPlaced (true)
	fel_bomb_cooldown:Hide()
	fel_bomb_cooldown.SetBarCooldown = fel_set_cooldown
	f.fel_bomb_cooldown = fel_bomb_cooldown

	fel_bomb_cooldown:SetScript ("OnMouseDown", fel_cooldown_mouse_down)
	fel_bomb_cooldown:SetScript ("OnMouseUp", fel_cooldown_mouse_up)
	fel_bomb_cooldown:SetBackdrop ({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 16})
	fel_bomb_cooldown:SetBackdropColor (0, 0, 0, 0.5)

	fel_bomb_cooldown.texture = fel_bomb_cooldown:CreateTexture (nil, "artwork")
	fel_bomb_cooldown.texture:SetTexture ([[Interface\AddOns\IskarAssist\bar_serenity]])
	fel_bomb_cooldown.texture:SetVertexColor (1, .5, .5)
	fel_bomb_cooldown:SetStatusBarTexture (fel_bomb_cooldown.texture)
	
	fel_bomb_cooldown.icon = fel_bomb_cooldown:CreateTexture (nil, "overlay")
	fel_bomb_cooldown.icon:SetTexture (spell_fel_bomb_icon)
	fel_bomb_cooldown.icon:SetPoint ("topright", fel_bomb_cooldown, "topleft")
	fel_bomb_cooldown.icon:SetSize (30, 30)
	fel_bomb_cooldown.text = fel_bomb_cooldown:CreateFontString (nil, "overlay", "GameFontNormal")
	fel_bomb_cooldown.text:SetText (spell_fel_bomb .. " cooldown")
	fel_bomb_cooldown.text:SetPoint ("left", fel_bomb_cooldown, "left", 2, 0)
	fel_bomb_cooldown.time_left = fel_bomb_cooldown:CreateFontString (nil, "overlay", "GameFontNormal")
	fel_bomb_cooldown.time_left:SetText ("0s")
	fel_bomb_cooldown.time_left:SetPoint ("right", fel_bomb_cooldown, "right", -2, 0)
	fel_bomb_cooldown.time_left:SetJustifyH ("right")
	
	--f:RegisterEvent ("COMBAT_LOG_EVENT_UNFILTERED")

	f:SetScript ("OnEvent", function (self, event, time, token, _, who_serial, who_name, who_flags, _, target_serial, target_name, target_flags, _, spellid, spellname, spellschool, buff_type, dose_stack_count)
		if (token == "SPELL_AURA_APPLIED" or token == "SPELL_AURA_REFRESH" or token == "SPELL_AURA_APPLIED_DOSE" or token == "SPELL_AURA_REMOVED_DOSE") then
			
			if (spellname == aura_radiance_of_anzu) then
				f:SetStackCount (target_name, dose_stack_count or 1)
			elseif (spellname == aura_eyeanzu) then
				f:SetAnzu (target_name)
			elseif (track_auras [spellname]) then
				f:SetAura (target_name, spellname, spellid)
			end
			
		elseif (token == "SPELL_AURA_REMOVED") then
			if (spellname == aura_radiance_of_anzu) then
				f:SetStackCount (target_name, 0)
			elseif (spellname == aura_eyeanzu) then
				f:RemoveAnzu (target_name)
			elseif (track_auras [spellname]) then
				f:RemoveAura (target_name, spellname, spellid)
			end
			
		elseif (token == "SPELL_RESURRECT") then
			if (bit.band (who_flags, 0x00000007) ~= 0) then
				local unitid = unitids [target_name]
				if (unitid) then
					if (not UnitIsDeadOrGhost (unitid)) then
						f:UnitDiedOrRessed (target_name)
					end
				end
			end
		
		elseif (token == "SPELL_CAST_SUCCESS") then
			if (dispel_spells [spellname] and f.dispell_ready) then
				if (f.dispell_ready [who_name]) then
					f.dispell_ready [who_name] = f.dispell_ready [who_name] - 1
					IKA:ScheduleTimer ("DispelCooldown", 8, who_name)
					f:UpdateDispelsAndInterruptsIcons()
				end
			end
			
		elseif (token == "UNIT_DIED") then
		
			if (target_serial) then
				local npcid = select (6, strsplit ("-", target_serial))
				if (npcid) then
					if (tonumber (npcid) == shadowfel_warden_npcid) then
						if (f) then
							fel_conduit_cooldown:SetBarCooldown (nil, nil, true)
							fel_bomb_cooldown:SetBarCooldown (nil, nil, true)						
						end
					end
				end
			end
			
			if (not UnitIsFeignDeath (target_name)) then
				if (bit.band (target_flags, 0x00000007) ~= 0 and bit.band (target_flags, 0x00000400) ~= 0) then
					f:UnitDiedOrRessed (target_name, true)
				end
			end
		end
	end)
	
	function f:GetReadyDispelsAndInterrupts()

		f.dispell_ready = f.dispell_ready or {}
		f.interrupt_ready = f.interrupt_ready or {}
		wipe (f.dispell_ready)
		wipe (f.interrupt_ready)
		
		if (type (unitids) == "table") then
			for playername, unitid in pairs (unitids) do
				local role = UnitGroupRolesAssigned (unitid)
				if (role == "DAMAGER") then
					local c = select (3, UnitClass (unitid))
					if (c == 1 or c == 2 or c == 4 or c == 6) then
						
					end
				elseif (role == "HEALER") then
					f.dispell_ready [playername] = 1
				end
			end
		end
		
		IKA:ScheduleTimer ("UpdateDispelsAndInterruptsIcons", 2)
		
	end

	function f:Msg (msg)
		print ("|cFFFFAA00Iskar Assist|r:", msg)
	end

	--> refresh the capturing debuffs
	f:SetEnabledDebuffs()

	---
	
	local build_options_panel = function()
		local options_frame = DF:CreateOptionsFrame ("IskarAssistOptionsPanel", "Iskar Assist", 1)
		options_frame:SetHeight (300)
		options_frame:SetWidth (520)
		
		--> options table
		local set_bar_texture = function (_, _, value) 
			IKA.db.profile.bartexture = value
			f:SetPlayerBlockConfig()
		end
		
		local texture_icon = [[Interface\TARGETINGFRAME\UI-PhasingIcon]]
		local texture_icon_size = {14, 14}
		local texture_texcoord = {0, 1, 0, 1}
		
		local textures = SharedMedia:HashTable ("statusbar")
		local texTable = {}
		for name, texturePath in pairs (textures) do 
			texTable[#texTable+1] = {value = name, label = name, iconsize = texture_icon_size, statusbar = texturePath, onclick = set_bar_texture, icon = texture_icon, texcoord = texture_texcoord}
		end
		table.sort (texTable, function (t1, t2) return t1.label < t2.label end)
		---
		local set_font_face= function (_, _, value)
			IKA.db.profile.textfont = value
			f:SetPlayerBlockConfig()
		end
		local fontObjects = SharedMedia:HashTable ("font")
		local fontTable = {}
		for name, fontPath in pairs (fontObjects) do 
			fontTable[#fontTable+1] = {value = name, label = name, icon = texture_icon, iconsize = texture_icon_size, texcoord = texture_texcoord, onclick = set_font_face, font = fontPath, descfont = name}
		end
		table.sort (fontTable, function (t1, t2) return t1.label < t2.label end)
		---
		local set_group_sort= function (_, _, value)
			IKA.db.profile.group_sorting = value
			if (value == 1 or value == 2) then
				--alphabetical and groups
				IskarAssistOptionsPanelWidget1.MyObject:SetValue (IKA.db.profile.barwidth)
				IskarAssistOptionsPanelWidget2.MyObject:SetValue (IKA.db.profile.barheight)
			elseif (value == 3) then
				--grid
				IskarAssistOptionsPanelWidget1.MyObject:SetValue (IKA.db.profile.barwidth_grid)
				IskarAssistOptionsPanelWidget2.MyObject:SetValue (IKA.db.profile.barheight_grid)
			end
			f:SortGroups()
		end
		local groupTable = {}
		groupTable [1] = {value = 1, label = "Vertical (alphabetical)", iconsize = texture_icon_size, statusbar = texturePath, onclick = set_group_sort, icon = texture_icon, texcoord = texture_texcoord}
		groupTable [2] = {value = 2, label = "Vertical (by groups)", iconsize = texture_icon_size, statusbar = texturePath, onclick = set_group_sort, icon = texture_icon, texcoord = texture_texcoord}
		groupTable [3] = {value = 3, label = "Grid (by groups)", iconsize = texture_icon_size, statusbar = texturePath, onclick = set_group_sort, icon = texture_icon, texcoord = texture_texcoord}
		---
		local set_frame_strata = function (_, _, strata)
			IKA.db.profile.MainPanel_strata = strata
			f:SortGroups()
		end
		local strataTable = {}
		strataTable [1] = {value = "BACKGROUND", label = "BACKGROUND", iconsize = texture_icon_size, statusbar = texturePath, onclick = set_frame_strata, icon = texture_icon, texcoord = texture_texcoord}
		strataTable [2] = {value = "LOW", label = "LOW", iconsize = texture_icon_size, statusbar = texturePath, onclick = set_frame_strata, icon = texture_icon, texcoord = texture_texcoord}
		strataTable [3] = {value = "MEDIUM", label = "MEDIUM", iconsize = texture_icon_size, statusbar = texturePath, onclick = set_frame_strata, icon = texture_icon, texcoord = texture_texcoord}
		strataTable [4] = {value = "HIGH", label = "HIGH", iconsize = texture_icon_size, statusbar = texturePath, onclick = set_frame_strata, icon = texture_icon, texcoord = texture_texcoord}
		strataTable [5] = {value = "DIALOG", label = "DIALOG", iconsize = texture_icon_size, statusbar = texturePath, onclick = set_frame_strata, icon = texture_icon, texcoord = texture_texcoord}
		-- endd
		
		local set_stack_anchor = function (_, _, value)
			IKA.db.profile.stack_count_anchor = value
			f:SetPlayerBlockConfig()
		end
		local stackTable = {}
		stackTable [1] = {value = "top", label = "TOP", iconsize = texture_icon_size, statusbar = texturePath, onclick = set_stack_anchor, icon = texture_icon, texcoord = texture_texcoord}
		stackTable [2] = {value = "bottom", label = "BOTTOM", iconsize = texture_icon_size, statusbar = texturePath, onclick = set_stack_anchor, icon = texture_icon, texcoord = texture_texcoord}
		stackTable [3] = {value = "left", label = "LEFT", iconsize = texture_icon_size, statusbar = texturePath, onclick = set_stack_anchor, icon = texture_icon, texcoord = texture_texcoord}
		stackTable [4] = {value = "right", label = "RIGHT", iconsize = texture_icon_size, statusbar = texturePath, onclick = set_stack_anchor, icon = texture_icon, texcoord = texture_texcoord}
		--
		--> options panel
		local options_panel = {
			{
				type = "select",
				get = function() return IKA.db.profile.group_sorting end,
				values = function() return groupTable end,
				desc = "The way the player are sorted.",
				name = "|cFFFF9900Frame Type|r"
			},
			{
				type = "select",
				get = function() return IKA.db.profile.MainPanel_strata end,
				values = function() return strataTable end,
				desc = "How high the frame is placed on your screen.\n\nLowering make the frame be behind backpack, talent frame, etc.",
				name = "Frame Strata"
			},
			{
				type = "select",
				get = function() return IKA.db.profile.stack_count_anchor end,
				values = function() return stackTable end,
				desc = "Where the stack of ".. aura_radiance_of_anzu .. " is attached relative to player's name.",
				name = "Stack Anchor"
			},
			{
				type = "range",
				get = function() 
					if (IKA.db.profile.group_sorting < 3) then
						return IKA.db.profile.barwidth 
					elseif (IKA.db.profile.group_sorting == 3) then	
						return IKA.db.profile.barwidth_grid
					end
				end,
				set = function (self, fixedparam, value) 
					if (IKA.db.profile.group_sorting < 3) then
						IKA.db.profile.barwidth = value
					elseif (IKA.db.profile.group_sorting == 3) then
						IKA.db.profile.barwidth_grid = value
					end
					f:SetPlayerBlockConfig()
					f:SortGroups()
				end,
				min = 20,
				max = 200,
				step = 1,
				desc = "The width of each player frame.",
				name = "Width",
			},
			{
				type = "range",
				get = function() 
					if (IKA.db.profile.group_sorting < 3) then
						return IKA.db.profile.barheight
					elseif (IKA.db.profile.group_sorting == 3) then
						return IKA.db.profile.barheight_grid
					end
				end,
				set = function (self, fixedparam, value) 
					if (IKA.db.profile.group_sorting < 3) then
						IKA.db.profile.barheight = value
					elseif (IKA.db.profile.group_sorting == 3) then
						IKA.db.profile.barheight_grid = value
					end
					f:SetPlayerBlockConfig()
					f:SortGroups()
				end,
				
				min = 8,
				max = 60,
				step = 1,
				desc = "The height of each player frame.",
				name = "Height",
			},
			{
				type = "select",
				get = function() return IKA.db.profile.bartexture end,
				values = function() return texTable end,
				desc = "Choose the texture used on tank blocks.",
				name = "Texture"
			},
			{
				type = "range",
				get = function() return IKA.db.profile.textsize end,
				set = function (self, fixedparam, value) IKA.db.profile.textsize = value; f:SetPlayerBlockConfig(); end,
				min = 8,
				max = 24,
				step = 1,
				desc = "Size of the player name.",
				name = "Text Size",
			},
			{
				type = "select",
				get = function() return IKA.db.profile.textfont end,
				values = function() return fontTable end,
				desc = "Font used on player name.",
				name = "Text Font"
			},
			{
				type = "toggle",
				get = function() return IKA.db.profile.textshadow end,
				set = function (self, fixedparam, value) 
					IKA.db.profile.textshadow = not IKA.db.profile.textshadow
					f:SetPlayerBlockConfig()
				end,
				desc = "Draw shadow on player name.",
				name = "Text Shadow"		
			},
			
	----------------------------------------
			{
				type = "toggle",
				get = function() return IKA.db.profile.eye_flash_anim end,
				set = function (self, fixedparam, value) 
					IKA.db.profile.eye_flash_anim = not IKA.db.profile.eye_flash_anim
				end,
				desc = "Play a flash animation on the player that just received the Eye of Anzu.",
				name = "Flash Enabled"
			},
			{
				type = "toggle",
				get = function() return IKA.db.profile.right_side_debuffs end,
				set = function (self, fixedparam, value) 
					IKA.db.profile.right_side_debuffs = not IKA.db.profile.right_side_debuffs
				end,
				desc = "When enabled and |cFFFFFF00not showing as Grid|r, debuffs are placed on the right side of player blocks.",
				name = "Debuffs on Right"
			},
			{
				type = "toggle",
				get = function() return IKA.db.profile.dispel_ready end,
				set = function (self, fixedparam, value) 
					IKA.db.profile.dispel_ready = not IKA.db.profile.dispel_ready
				end,
				desc = "Shows an icon on the right side of a healer bar telling if has a dispel ready to use.",
				name = "Dispel Ready"
			},
			{
				type = "toggle",
				get = function() return IKA.db.profile.cooldown end,
				set = function (self, fixedparam, value) 
					IKA.db.profile.cooldown = not IKA.db.profile.cooldown
				end,
				desc = "Shows the cooldown animation on debuffs.\n\nNot recommended, become hard to see which debuff are.",
				name = "Debuff Duration"
			},

			--debuffs
			{
				type = "toggle",
				get = function() return IKA.db.profile.debuff_phantasmal_wounds end,
				set = function (self, fixedparam, value) 
					IKA.db.profile.debuff_phantasmal_wounds = not IKA.db.profile.debuff_phantasmal_wounds
					f:SetEnabledDebuffs()
				end,
				desc = "Show " .. aura_phantasmal_wounds .. " aura.",
				name = "|T" .. phantasmal_wounds_icon .. ":14:14:0:0:64:64:5:59:5:59|t" .. " " .. aura_phantasmal_wounds
			},
			{
				type = "toggle",
				get = function() return IKA.db.profile.debuff_phantasmal_winds end,
				set = function (self, fixedparam, value) 
					IKA.db.profile.debuff_phantasmal_winds = not IKA.db.profile.debuff_phantasmal_winds
					f:SetEnabledDebuffs()
				end,
				desc = "Show " .. aura_phantasmal_winds .. " aura.",
				name = "|T" .. phantasmal_winds_icon .. ":14:14:0:0:64:64:5:59:5:59|t" .. " " .. aura_phantasmal_winds
			},
			{
				type = "toggle",
				get = function() return IKA.db.profile.debuff_fel_chakram end,
				set = function (self, fixedparam, value) 
					IKA.db.profile.debuff_fel_chakram = not IKA.db.profile.debuff_fel_chakram
					f:SetEnabledDebuffs()
				end,
				desc = "Show " .. aura_fel_chakram .. " aura.\n\n|cFFFFFF00Important|r: only works on vertical alignment.",
				name = "|T" .. fel_chakram_icon .. ":14:14:0:0:64:64:5:59:5:59|t" .. " " .. aura_fel_chakram
			},
			{
				type = "toggle",
				get = function() return IKA.db.profile.debuff_phantasmal_corruption end,
				set = function (self, fixedparam, value) 
					IKA.db.profile.debuff_phantasmal_corruption = not IKA.db.profile.debuff_phantasmal_corruption
					f:SetEnabledDebuffs()
				end,
				desc = "Show " .. aura_phantasmal_corruption .. " aura.",
				name = "|T" .. phantasmal_corruption_icon .. ":14:14:0:0:64:64:5:59:5:59|t" .. " " .. aura_phantasmal_corruption
			},
			{
				type = "toggle",
				get = function() return IKA.db.profile.debuff_fel_bomb end,
				set = function (self, fixedparam, value) 
					IKA.db.profile.debuff_fel_bomb = not IKA.db.profile.debuff_fel_bomb
					f:SetEnabledDebuffs()
				end,
				desc = "Show " .. aura_fel_bomb .. " aura.",
				name = "|T" .. fel_bomb_icon .. ":14:14:0:0:64:64:5:59:5:59|t" .. " " .. aura_fel_bomb
			},
			{
				type = "toggle",
				get = function() return IKA.db.profile.debuff_phantasmal_bomb end,
				set = function (self, fixedparam, value) 
					IKA.db.profile.debuff_phantasmal_bomb = not IKA.db.profile.debuff_phantasmal_bomb
					f:SetEnabledDebuffs()
				end,
				desc = "Show " .. aura_phantasmal_bomb .. " aura.\n\n|cFFFFFF00Important|r: only works on vertical alignment.",
				name = "|T" .. phantasmal_bomb_icon .. ":14:14:0:0:64:64:5:59:5:59|t" .. " " .. aura_phantasmal_bomb
			},
			--feedback
			{
				type = "execute",
				func = function() 
					IKA.OpenReportWindow()
				end,
				desc = "Get the link for our MMO-Champion forum thread, post bugs or feature suggestions.",
				name = "Report Bug",
			},
			
			--archimonde radar
			{
				type = "toggle",
				get = function() return IKA.db.profile.archimonde_radar end,
				set = function (self, fixedparam, value) 
					IKA.db.profile.archimonde_radar = not IKA.db.profile.archimonde_radar
				end,
				desc = "Show " .. aura_focused_chaos .. " radar for archimonde encounter.",
				name = "|T" .. aura_focused_chaos_icon .. ":14:14:0:0:64:64:5:59:5:59|t" .. " " .. aura_focused_chaos .. " (Archimonde)"
			},

		}
		--> end options table
		
		DF:BuildMenu (options_frame, options_panel, 15, -60, 300)
		options_frame:SetBackdropColor (0, 0, 0, .9)
	end

	f.OpenOptionsPanel = function()
		
		local RA = RaidAssist
		if (RA) then
			RA.OpenMainOptions (IKA)
			return
		end
	
		if (UnitAffectingCombat ("player") or InCombatLockdown()) then
			IKA:Msg ("options will be opened after the combat.")
			IKA.schedule_open_options = true
			return
		end
	
		if (not IskarAssistOptionsPanel) then
			build_options_panel()
		end
		IskarAssistOptionsPanel:Show()
	end
	
	local options_button = DF:CreateOptionsButton (f, f.OpenOptionsPanel, "IskarAssistOptionsButton")
	options_button:SetPoint ("right", f.Lock, "left", 1, 0)
	options_button:SetFrameLevel (f:GetFrameLevel()+5)
	f.OptionsButton = options_button	
	
	if (show_after_cretion) then
		f:ShowMe()
	end
	
	if (IskarAssistDB and IskarAssistDB.GotLegionHeadsUp) then
		return
	end
	
	f.OpenOptionsPanel()

	do
		local arrowFrame = CreateFrame ("frame", "IskarAssistNewArrow2", RaidAssistOptionsPanel, "GlowBoxTemplate")
		arrowFrame:SetSize (220, 100)
		arrowFrame:SetFrameStrata ("TOOLTIP")
		f.arrowFrame = arrowFrame
		
		arrowFrame.Text = arrowFrame:CreateFontString (nil, "overlay", "GameFontHighlightLeft")
		arrowFrame.Text:SetWidth (200)
		arrowFrame.Text:SetPoint ("TOPLEFT", 15, -15)
		arrowFrame.Text:SetSpacing (4)
		
		arrowFrame.ArrowRIGHT = arrowFrame:CreateTexture (nil, "artwork", "HelpPlateArrowDOWN")
		arrowFrame.ArrowRIGHT:Hide()
		arrowFrame.ArrowRIGHT:SetSize (53, 21)
		arrowFrame.ArrowRIGHT:SetPoint ("RIGHT", arrowFrame, "LEFT", 3, 0)
		SetClampedTextureRotation (arrowFrame.ArrowRIGHT, 90)
		
		arrowFrame.ArrowGlowRIGHT = arrowFrame:CreateTexture (nil, "border", "HelpPlateArrow-GlowDOWN")
		arrowFrame.ArrowGlowRIGHT:Hide()
		arrowFrame.ArrowGlowRIGHT:SetSize (53, 21)
		arrowFrame.ArrowGlowRIGHT:SetPoint ("RIGHT", arrowFrame, "LEFT", 3, 0)
		SetClampedTextureRotation (arrowFrame.ArrowGlowRIGHT, 90)

		arrowFrame.CloseButton = CreateFrame ("button", "IskarAssistNewArrow2CloseButton", arrowFrame, "UIPanelCloseButton")
		arrowFrame.CloseButton:SetSize (20, 20)
		arrowFrame.CloseButton:SetPoint ("TOPRIGHT", arrowFrame, "TOPRIGHT", 3, 3)
		
		arrowFrame:SetScript ("OnShow", function()
			arrowFrame:SetHeight (arrowFrame.Text:GetHeight()+30)
		end)
		
		arrowFrame.Text:SetText ("Raid Leader, you may want to see the Aura Check & Share plugin.")
		arrowFrame:SetPoint ("right", RaidAssistOptionsPanel, "left", -20, 175)
	end
	do
		local arrowFrame = CreateFrame ("frame", "IskarAssistNewArrow1", RaidAssistOptionsPanel, "GlowBoxTemplate")
		arrowFrame:SetSize (220, 100)
		arrowFrame:SetFrameStrata ("TOOLTIP")
		f.arrowFrame = arrowFrame
		
		arrowFrame.Text = arrowFrame:CreateFontString (nil, "overlay", "GameFontHighlightLeft")
		arrowFrame.Text:SetWidth (200)
		arrowFrame.Text:SetPoint ("TOPLEFT", 15, -15)
		arrowFrame.Text:SetSpacing (4)
		
		arrowFrame.ArrowRIGHT = arrowFrame:CreateTexture (nil, "artwork", "HelpPlateArrowDOWN")
		arrowFrame.ArrowRIGHT:Hide()
		arrowFrame.ArrowRIGHT:SetSize (53, 21)
		arrowFrame.ArrowRIGHT:SetPoint ("RIGHT", arrowFrame, "LEFT", 3, 0)
		SetClampedTextureRotation (arrowFrame.ArrowRIGHT, 90)
		
		arrowFrame.ArrowGlowRIGHT = arrowFrame:CreateTexture (nil, "border", "HelpPlateArrow-GlowDOWN")
		arrowFrame.ArrowGlowRIGHT:Hide()
		arrowFrame.ArrowGlowRIGHT:SetSize (53, 21)
		arrowFrame.ArrowGlowRIGHT:SetPoint ("RIGHT", arrowFrame, "LEFT", 3, 0)
		SetClampedTextureRotation (arrowFrame.ArrowGlowRIGHT, 90)
		
		arrowFrame.CloseButton = CreateFrame ("button", "IskarAssistNewArrow1CloseButton", arrowFrame, "UIPanelCloseButton")
		arrowFrame.CloseButton:SetSize (20, 20)
		arrowFrame.CloseButton:SetPoint ("TOPRIGHT", arrowFrame, "TOPRIGHT", 3, 3)
		
		arrowFrame:SetScript ("OnShow", function()
			arrowFrame:SetHeight (arrowFrame.Text:GetHeight()+30)
		end)
		
		arrowFrame.Text:SetText ("On Legion, Iskar plugins are being hosted by 'Raid Assist' addon. You can get it on curse client.")
		arrowFrame:SetPoint ("right", RaidAssistOptionsPanel, "left", -20, 0)
	end
	
	if (IskarAssistDB) then
		IskarAssistDB.GotLegionHeadsUp = true
	end
	
	--RaidAssist.OpenMainOptionsForPlugin (_G ["RaidAssistAuraCheck"])
	
-- end of frame creation
end

function IKA.OpenReportWindow()
	if (not IKA.report_window) then
		local w = CreateFrame ("frame", "IskarAssistBugReportWindow", UIParent)
		w:SetFrameStrata ("TOOLTIP")
		if (f) then
			w:SetFrameLevel (f:GetFrameLevel()+6)
		end
		w:SetSize (300, 50)
		w:SetPoint ("center", UIParent, "center")
		tinsert (UISpecialFrames, "IskarAssistBugReportWindow")
		IKA.report_window = w
		
		local editbox = DF:CreateTextEntry (w, function()end, 280, 20)
		w.editbox = editbox
		editbox:SetPoint ("center", w, "center")
		editbox:SetAutoFocus (false)
		
		editbox:SetHook ("OnEditFocusGained", function() 
			editbox.text = "http://www.mmo-champion.com/threads/1798990-AddOn-Shadow-Lord-Iskar-Assist" 
			editbox:HighlightText()
		end)
		editbox:SetHook ("OnEditFocusLost", function() 
			w:Hide()
		end)
		editbox:SetHook ("OnChar", function() 
			editbox.text = "http://www.mmo-champion.com/threads/1798990-AddOn-Shadow-Lord-Iskar-Assist"
			editbox:HighlightText()
		end)
		editbox.text = "http://www.mmo-champion.com/threads/1798990-AddOn-Shadow-Lord-Iskar-Assist"
		
		function IKA:ReportWindowSetFocus()
			if (IskarAssistBugReportWindow:IsShown()) then
				IskarAssistBugReportWindow:Show()
				IskarAssistBugReportWindow.editbox:SetFocus()
				IskarAssistBugReportWindow.editbox:HighlightText()
			end
		end
	end
	
	IskarAssistBugReportWindow:Show()
	IKA:ScheduleTimer ("ReportWindowSetFocus", 1)
end

function IKA:ReloadAuraNames()

	aura_eyeanzu = GetSpellInfo (179202) --Eye of Anzu (checked on live)
	
	aura_phantasmal_wounds = GetSpellInfo (182325) --Phantasmal Wounds (checked on live)
	aura_phantasmal_winds = GetSpellInfo (181957) --Phantasmal Winds (checked on live)
	aura_fel_chakram = GetSpellInfo (182178) --Fel Chakram (checked on live)
	aura_phantasmal_corruption = GetSpellInfo (181824) --Phantasmal Corruption (checked on live)
	aura_fel_bomb = GetSpellInfo (181753) --Fel Bomb (checked on live)
	aura_phantasmal_bomb = GetSpellInfo (179219) --Phantasmal Fel Bomb (checked on live)
	aura_dark_bindings = GetSpellInfo (185510) --Dark Bindings

	aura_radiance_of_anzu = GetSpellInfo (185239) --Radiance of Anzu
	
	dispel_naturescure = GetSpellInfo (88423) --druid
	dispel_purify = GetSpellInfo (527) --priest
	dispel_cleanse = GetSpellInfo (4987) --pally
	dispel_purify_spirit = GetSpellInfo (77130) --shaman
	dispel_detox = GetSpellInfo (115450) --monk
	dispel_sear_magic = GetSpellInfo (89808) --warlock
	
	track_auras [aura_phantasmal_wounds] = true
	track_auras [aura_phantasmal_winds] = true
	track_auras [aura_fel_chakram] = true
	track_auras [aura_phantasmal_corruption] = true
	track_auras [aura_fel_bomb] = true
	track_auras [aura_phantasmal_bomb] = true
	track_auras [aura_dark_bindings] = true
	
	dispel_spells [dispel_naturescure] = true
	dispel_spells [dispel_purify] = true
	dispel_spells [dispel_cleanse] = true
	dispel_spells [dispel_purify_spirit] = true
	dispel_spells [dispel_detox] = true
	dispel_spells [dispel_sear_magic] = true
	
	if (f) then
		f:SetEnabledDebuffs()
	end
	
	if (is_kargath_test) then
		aura_dark_bindings = "Weakened Soul"
		--aura_phantasmal_winds = "Weakened Soul"
		aura_phantasmal_wounds = "Flame Jet"
		aura_phantasmal_corruption = "Chain Hurl"
		aura_fel_bomb = "Impale"
		
		spell_fel_conduit = "Flash Heal"
		spell_fel_bomb = "Cascade"
		
		track_auras ["Weakened Soul"] = true
		track_auras ["Flame Jet"] = true
		track_auras ["Chain Hurl"] = true
		track_auras ["Impale"] = true
		
		grid_aura_index ["Impale"] = 1
		grid_aura_index ["Flame Jet"] = 2
		grid_aura_index ["Chain Hurl"] = 3
		grid_aura_index ["Impale"] = 4
		grid_aura_index ["Weakened Soul"] = 5
	end
	
end

frame_event:SetScript ("OnEvent", function (self, event, ...)

	if (event == "UNIT_HEALTH" or event == "UNIT_HEALTH_FREQUENT") then
		if (f.dead_cache [...]) then
			local health = UnitHealth (...)
			if (health > 0) then
				--is alive
				f:UnitDiedOrRessed (GetUnitName (..., true))
			else
				--is death
				f:UnitDiedOrRessed (GetUnitName (..., true), true)
			end
			
		elseif (f.track_player_health [...]) then
			local block = unitid_to_block [...]
			if (block) then
				block.statusbar:SetValue (UnitHealth (...) / UnitHealthMax (...) * 100)
			end
		end

	elseif (event == "PARTY_MEMBERS_CHANGED" or event == "GROUP_ROSTER_UPDATE" or event == "UNIT_NAME_UPDATE" or event == "PLAYER_ENTERING_WORLD" or event == "UNIT_CONNECTION") then

		if (f:IsShown()) then
			f:debug ("Party Members Update")
			f:SortGroups (event)
		end

	elseif (event == "PLAYER_TARGET_CHANGED") then
		local GUID = UnitGUID ("target")
		if (GUID) then
			local npcid = select (6, strsplit ("-", GUID))
			if (npcid) then
				if (tonumber (npcid) == iskar_npcid) then
					if (not f) then
						IKA:ScheduleCreateFrames (true)
					else
						if (not f:IsShown()) then
							f:ShowMe()
						end
					end
				end
			end
		end
		
	elseif (event == "PLAYER_REGEN_DISABLED") then
		if (IskarAssistOptionsPanel and IskarAssistOptionsPanel:IsShown()) then
			IskarAssistOptionsPanel:Hide()
			IKA.schedule_open_options = true
			IKA:Msg ("can't change options while in combat.")
		end
		
	elseif (event == "INSTANCE_ENCOUNTER_ENGAGE_UNIT") then
		if (f and f:IsShown() and not UnitAffectingCombat ("player") and not InCombatLockdown()) then
			f:SortGroups (event)
		end
	
	elseif (event == "PLAYER_REGEN_ENABLED") then
		if (IKA.scheduled_frame_creation) then
			IKA.scheduled_frame_creation = nil
			IKA:CreateFrames()
			f:ShowMe()
			if (IKA.scheduled_check_users) then
				IKA.scheduled_check_users = nil
				IKA:GetUserList()
			end
		end
		
		if (f) then
			if (f.schedule_sort) then
				f.schedule_sort = nil
				f:SortGroups()
				f:debug ("Regen Enabled with a schedule sort.")
			end
			if (f.schedule_hide) then
				f.schedule_hide = nil
				f:Hide()
			end
			if (f.schedule_show) then
				f.schedule_show = nil
				f:Show()
			end
			if (IKA.schedule_open_options) then
				IKA.schedule_open_options = nil
				f.OpenOptionsPanel()
			end
		end
		
	elseif (event == "ADDON_LOADED" and select (1, ...) == "IskarAssist") then

		local _, class = UnitClass ("player")
		player_class = class
		
		if (isdebug) then
			IKA:CreateFrames()
			f:HideMe()
		end
		
		frame_event:RegisterEvent ("ENCOUNTER_START")
		frame_event:RegisterEvent ("ENCOUNTER_END")
		frame_event:RegisterEvent ("PLAYER_REGEN_ENABLED")
		frame_event:RegisterEvent ("PLAYER_REGEN_DISABLED")
		frame_event:RegisterEvent ("PLAYER_TARGET_CHANGED")
		frame_event:RegisterEvent ("INSTANCE_ENCOUNTER_ENGAGE_UNIT")
		
		if (player_class == "WARLOCK") then
			frame_event:RegisterEvent ("ACTIVE_TALENT_GROUP_CHANGED")
			frame_event:RegisterEvent ("PLAYER_TALENT_UPDATE")
		end

		--> reload auras once again after the addon loaded
		IKA:ScheduleTimer ("ReloadAuraNames", 5)

	elseif (event == "ENCOUNTER_START" or event == "ENCOUNTER_END") then
	
		local encounterID, encounterName, difficultyID, raidSize, eendStatus = select (1, ...)
		
		if (encounterID == iskar_encounter_id) then
			if (event == "ENCOUNTER_START") then
				if (f) then
					f.on_encounter = true
					f:RegisterEvent ("COMBAT_LOG_EVENT_UNFILTERED")
					f:GetReadyDispelsAndInterrupts()
					
					if (f:IsShown() and not UnitAffectingCombat ("player") and not InCombatLockdown()) then
						f:SortGroups (event)
					end
					
					f:debug ("Encounter Started!")
				end
				
			elseif (event == "ENCOUNTER_END") then
				if (f) then
					f.on_encounter = false
					--f:UnregisterEvent ("COMBAT_LOG_EVENT_UNFILTERED")
					f:debug ("Encounter End")
					
					f:ClearFrames()
					
					if (eendStatus == 1) then
						--f:HideMe()
					end
					
					f.fel_conduit_cooldown:SetBarCooldown (nil, nil, true)
					f.fel_bomb_cooldown:SetBarCooldown (nil, nil, true)	
				end
			end
		end
		
	elseif (event == "ACTIVE_TALENT_GROUP_CHANGED" or event == "PLAYER_TALENT_UPDATE") then
		if (f) then
			if (f:IsShown()) then
				f:SortGroups (event)
			end
		end
	end
end)

--local AceTimer = LibStub:GetLibrary ("AceTimer-3.0")
--AceTimer:Embed (f)
--local AceComm = LibStub:GetLibrary ("AceComm-3.0")
--AceComm:Embed (f)
function IKA:ShowUsers()
	local users_frame = IskarAssistUsersPanel
	if (not users_frame) then
	
		users_frame = CreateFrame ("frame", "IskarAssistUsersPanel", UIParent)
		users_frame:SetBackdrop ({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 16, insets = {left = -1, right = -1, top = -1, bottom = -1},
		edgeFile = "Interface\\AddOns\\IskarAssist\\border_2", edgeSize = 8})
		users_frame:SetBackdropColor (0, 0, 0, 1)
		tinsert (UISpecialFrames, "IskarAssistUsersPanel")
		users_frame:SetSize (200, 500)
		users_frame:SetPoint ("center", UIParent, "center", 0, 0)
		users_frame.text = users_frame:CreateFontString (nil, "overlay", "GameFontHighlight")
		users_frame.text:SetPoint ("topleft", users_frame, "topleft", 10, -10)
		users_frame.text:SetJustifyH ("left")
		
		users_frame.title = users_frame:CreateFontString (nil, "overlay", "GameFontNormal")
		users_frame.title:SetText ("Iskar Assist: Users (press escape to close)")
		users_frame.title:SetPoint ("center", users_frame, "center")
		users_frame.title:SetPoint ("bottom", users_frame, "top", 0, 2)
		
		local close = CreateFrame ("button", "IskarAssistUsersPanelCloseButton", users_frame, "UIPanelCloseButton")
		close:SetPoint ("topright", users_frame, "topright")
		users_frame.close_button = close
	end
	
	local s = ""
	
	for key, value in pairs (f.users) do
		s = s .. "|cFF33FF33" .. key .. "\n"
	end
	
	s = s .. "|r\n\n\n|cFFFFFFFFOut of Date or Not installed:|r\n\n"
	
	for i = 1, GetNumGroupMembers() do
		local name = UnitName ("raid" .. i)
		if (not s:find (name)) then
			s = s .. "|cFFFF3333" .. name .. "|r\n"
		end
	end
	
	users_frame.text:SetText (s)
	
	users_frame:Show()

	f.users = nil
	f.users_schedule = nil
end

function IKA:GetUserList()

	IKA:ScheduleCreateFrames()

	if (f) then
		if (f.users_schedule) then
			f:Msg ("please wait 5 seconds...")
		elseif (IsInRaid()) then
			f.users = {}
			IKA:SendCommMessage ("IAFR", "US", "RAID")
			--print (">", "IAFR", "US", "RAID")
			f.users_schedule = IKA:ScheduleTimer ("ShowUsers", 5)
			f:Msg ("please wait 5 seconds...")
		else
			f:Msg ("you aren't in a raid group.")
		end
	else
		print ("|cFFFFAA00Iskar Assist|r:", "main window isn't loaded yet, it'll be when the combat is gone.")
		IKA.scheduled_check_users = true
	end
end

function IKA:CommReceived (_, data, _, source)
	--print ("< 1", data, source)
	if (data == "US") then
		IKA:SendCommMessage ("IAFR", UnitName ("player") .. " " .. iskar_version, "RAID")
	elseif (f and f.users) then
		--print ("< 2", data, source)
		f.users [data] = true
	end
end
IKA:RegisterComm ("IAFR", "CommReceived")

SLASH_IskarAssist1 = "/iskar"
function SlashCmdList.IskarAssist (msg, editbox)

	local command, rest = msg:match ("^(%S*)%s*(.-)$")
	print ("|cFFFFAA00Iskar Assist|r:", "|cFF00FF00" .. iskar_version .. "|r")
	
	if (UnitAffectingCombat ("player") or InCombatLockdown()) then
		if (not f) then
			print ("|cFFFFAA00Iskar Assist|r:", "|cFFFF0000You are in combat, we can't create the main window now.")
		end
	end
	
	if (command == "users") then
		IKA:GetUserList()
	
	elseif (command == "maxgroups") then
		IKA.MaxGroups = tonumber (rest) or 6
		if (IKA.MaxGroups < 2) then
			IKA.MaxGroups = 2
		elseif (IKA.MaxGroups > 8) then
			IKA.MaxGroups = 8
		end
		print ("|cFFFFAA00Iskar Assist|r:", "max groups set to: ", IKA.MaxGroups)
		print ("|cFFFFAA00Iskar Assist|r:", "max groups isn't saving at the moment, re-run this command again after a /reload.")
		print ("|cFFFFAA00Iskar Assist|r:", "we are working to make it a fixed option, thank you!")
		f:SortGroups()
	
	elseif (command == "options") then
		if (f) then
			f.OpenOptionsPanel()
		else
			print ("|cFFFFAA00Iskar Assist|r:", "failed, main window isn't loaded yet.")
		end
		
	elseif (command == "resetpos") then
		if (f) then
			f:ClearAllPoints()
			f:SetPoint ("center", UIParent, "center")
			f.IsMoving = true
			f:GetScript ("OnMouseUp")(f)
		else
			print ("|cFFFFAA00Iskar Assist|r:", "failed, main window isn't loaded yet.")
		end
	else
	
		print ("|cFFFFAA00Iskar Assist|r:", "/iskar |cFFFFFF00users|r: show who in the raid group is using this addon.")
		print ("|cFFFFAA00Iskar Assist|r:", "/iskar |cFFFFFF00resetpos|r: reset the frame position.")
		print ("|cFFFFAA00Iskar Assist|r:", "/iskar |cFFFFFF00options|r: open options panel.")
		print ("|cFFFFAA00Iskar Assist|r:", "/iskar |cFFFFFF00maxgroups <amount>|r: set the max groups shown.")

		if (not f) then
			IKA:ScheduleCreateFrames (true)
		else
			f:ShowMe()
		end
	end
end

------------------------------------------------------------------------

function IKA.BuildOptions (frame)
	
	if (not frame.FirstRun) then
		frame.FirstRun = true
	
		local set_bar_texture = function (_, _, value) 
			IKA.db.profile.bartexture = value
			f:SetPlayerBlockConfig()
		end
		
		local texture_icon = [[Interface\TARGETINGFRAME\UI-PhasingIcon]]
		local texture_icon_size = {14, 14}
		local texture_texcoord = {0, 1, 0, 1}
		
		local textures = SharedMedia:HashTable ("statusbar")
		local texTable = {}
		for name, texturePath in pairs (textures) do 
			texTable[#texTable+1] = {value = name, label = name, iconsize = texture_icon_size, statusbar = texturePath, onclick = set_bar_texture, icon = texture_icon, texcoord = texture_texcoord}
		end
		table.sort (texTable, function (t1, t2) return t1.label < t2.label end)
		---
		local set_font_face= function (_, _, value)
			IKA.db.profile.textfont = value
			f:SetPlayerBlockConfig()
		end
		local fontObjects = SharedMedia:HashTable ("font")
		local fontTable = {}
		for name, fontPath in pairs (fontObjects) do 
			fontTable[#fontTable+1] = {value = name, label = name, icon = texture_icon, iconsize = texture_icon_size, texcoord = texture_texcoord, onclick = set_font_face, font = fontPath, descfont = name}
		end
		table.sort (fontTable, function (t1, t2) return t1.label < t2.label end)
		---
		local set_group_sort= function (_, _, value)
			IKA.db.profile.group_sorting = value
			if (value == 1 or value == 2) then
				--alphabetical and groups
				if (IskarAssistOptionsPanelWidget1) then
					IskarAssistOptionsPanelWidget1.MyObject:SetValue (IKA.db.profile.barwidth)
					IskarAssistOptionsPanelWidget2.MyObject:SetValue (IKA.db.profile.barheight)
				end
			elseif (value == 3) then
				--grid
				if (IskarAssistOptionsPanelWidget1) then
					IskarAssistOptionsPanelWidget1.MyObject:SetValue (IKA.db.profile.barwidth_grid)
					IskarAssistOptionsPanelWidget2.MyObject:SetValue (IKA.db.profile.barheight_grid)
				end
			end
			f:SortGroups()
		end
		local groupTable = {}
		groupTable [1] = {value = 1, label = "Vertical (alphabetical)", iconsize = texture_icon_size, statusbar = texturePath, onclick = set_group_sort, icon = texture_icon, texcoord = texture_texcoord}
		groupTable [2] = {value = 2, label = "Vertical (by groups)", iconsize = texture_icon_size, statusbar = texturePath, onclick = set_group_sort, icon = texture_icon, texcoord = texture_texcoord}
		groupTable [3] = {value = 3, label = "Grid (by groups)", iconsize = texture_icon_size, statusbar = texturePath, onclick = set_group_sort, icon = texture_icon, texcoord = texture_texcoord}
		---
		local set_frame_strata = function (_, _, strata)
			IKA.db.profile.MainPanel_strata = strata
			f:SortGroups()
		end
		local strataTable = {}
		strataTable [1] = {value = "BACKGROUND", label = "BACKGROUND", iconsize = texture_icon_size, statusbar = texturePath, onclick = set_frame_strata, icon = texture_icon, texcoord = texture_texcoord}
		strataTable [2] = {value = "LOW", label = "LOW", iconsize = texture_icon_size, statusbar = texturePath, onclick = set_frame_strata, icon = texture_icon, texcoord = texture_texcoord}
		strataTable [3] = {value = "MEDIUM", label = "MEDIUM", iconsize = texture_icon_size, statusbar = texturePath, onclick = set_frame_strata, icon = texture_icon, texcoord = texture_texcoord}
		strataTable [4] = {value = "HIGH", label = "HIGH", iconsize = texture_icon_size, statusbar = texturePath, onclick = set_frame_strata, icon = texture_icon, texcoord = texture_texcoord}
		strataTable [5] = {value = "DIALOG", label = "DIALOG", iconsize = texture_icon_size, statusbar = texturePath, onclick = set_frame_strata, icon = texture_icon, texcoord = texture_texcoord}
		-- endd
		
		local set_stack_anchor = function (_, _, value)
			IKA.db.profile.stack_count_anchor = value
			f:SetPlayerBlockConfig()
		end
		local stackTable = {}
		stackTable [1] = {value = "top", label = "TOP", iconsize = texture_icon_size, statusbar = texturePath, onclick = set_stack_anchor, icon = texture_icon, texcoord = texture_texcoord}
		stackTable [2] = {value = "bottom", label = "BOTTOM", iconsize = texture_icon_size, statusbar = texturePath, onclick = set_stack_anchor, icon = texture_icon, texcoord = texture_texcoord}
		stackTable [3] = {value = "left", label = "LEFT", iconsize = texture_icon_size, statusbar = texturePath, onclick = set_stack_anchor, icon = texture_icon, texcoord = texture_texcoord}
		stackTable [4] = {value = "right", label = "RIGHT", iconsize = texture_icon_size, statusbar = texturePath, onclick = set_stack_anchor, icon = texture_icon, texcoord = texture_texcoord}
		--
	
		local options_list = {
		
			{type = "label", get = function() return "Frame:" end, text_template = DF:GetTemplate ("font", "ORANGE_FONT_TEMPLATE")},
		
			{
				type = "select",
				get = function() return IKA.db.profile.group_sorting end,
				values = function() return groupTable end,
				desc = "The way the player are sorted.",
				name = "|cFFFF9900Frame Type|r"
			},
			{
				type = "select",
				get = function() return IKA.db.profile.MainPanel_strata end,
				values = function() return strataTable end,
				desc = "How high the frame is placed on your screen.\n\nLowering make the frame be behind backpack, talent frame, etc.",
				name = "Frame Strata"
			},
			{
				type = "select",
				get = function() return IKA.db.profile.stack_count_anchor end,
				values = function() return stackTable end,
				desc = "Where the stack of ".. aura_radiance_of_anzu .. " is attached relative to player's name.",
				name = "Stack Anchor"
			},
			{
				type = "range",
				get = function() 
					if (IKA.db.profile.group_sorting < 3) then
						return IKA.db.profile.barwidth 
					elseif (IKA.db.profile.group_sorting == 3) then	
						return IKA.db.profile.barwidth_grid
					end
				end,
				set = function (self, fixedparam, value) 
					if (IKA.db.profile.group_sorting < 3) then
						IKA.db.profile.barwidth = value
					elseif (IKA.db.profile.group_sorting == 3) then
						IKA.db.profile.barwidth_grid = value
					end
					f:SetPlayerBlockConfig()
					f:SortGroups()
				end,
				min = 20,
				max = 200,
				step = 1,
				desc = "The width of each player frame.",
				name = "Width",
			},
			{
				type = "range",
				get = function() 
					if (IKA.db.profile.group_sorting < 3) then
						return IKA.db.profile.barheight
					elseif (IKA.db.profile.group_sorting == 3) then
						return IKA.db.profile.barheight_grid
					end
				end,
				set = function (self, fixedparam, value) 
					if (IKA.db.profile.group_sorting < 3) then
						IKA.db.profile.barheight = value
					elseif (IKA.db.profile.group_sorting == 3) then
						IKA.db.profile.barheight_grid = value
					end
					f:SetPlayerBlockConfig()
					f:SortGroups()
				end,
				
				min = 8,
				max = 60,
				step = 1,
				desc = "The height of each player frame.",
				name = "Height",
			},
			{
				type = "select",
				get = function() return IKA.db.profile.bartexture end,
				values = function() return texTable end,
				desc = "Choose the texture used on tank blocks.",
				name = "Texture"
			},
			
			{type = "blank"},
			{type = "label", get = function() return "Text:" end, text_template = DF:GetTemplate ("font", "ORANGE_FONT_TEMPLATE")},
			
			{
				type = "range",
				get = function() return IKA.db.profile.textsize end,
				set = function (self, fixedparam, value) IKA.db.profile.textsize = value; f:SetPlayerBlockConfig(); end,
				min = 8,
				max = 24,
				step = 1,
				desc = "Size of the player name.",
				name = "Text Size",
			},
			{
				type = "select",
				get = function() return IKA.db.profile.textfont end,
				values = function() return fontTable end,
				desc = "Font used on player name.",
				name = "Text Font"
			},
			{
				type = "toggle",
				get = function() return IKA.db.profile.textshadow end,
				set = function (self, fixedparam, value) 
					IKA.db.profile.textshadow = not IKA.db.profile.textshadow
					f:SetPlayerBlockConfig()
				end,
				desc = "Draw shadow on player name.",
				name = "Text Shadow"		
			},
			
	----------------------------------------
	
			{type = "blank"},
			{type = "label", get = function() return "Debuff:" end, text_template = DF:GetTemplate ("font", "ORANGE_FONT_TEMPLATE")},
	
			{
				type = "toggle",
				get = function() return IKA.db.profile.eye_flash_anim end,
				set = function (self, fixedparam, value) 
					IKA.db.profile.eye_flash_anim = not IKA.db.profile.eye_flash_anim
				end,
				desc = "Play a flash animation on the player that just received the Eye of Anzu.",
				name = "Flash Enabled"
			},
			{
				type = "toggle",
				get = function() return IKA.db.profile.right_side_debuffs end,
				set = function (self, fixedparam, value) 
					IKA.db.profile.right_side_debuffs = not IKA.db.profile.right_side_debuffs
				end,
				desc = "When enabled and |cFFFFFF00not showing as Grid|r, debuffs are placed on the right side of player blocks.",
				name = "Debuffs on Right"
			},
			{
				type = "toggle",
				get = function() return IKA.db.profile.dispel_ready end,
				set = function (self, fixedparam, value) 
					IKA.db.profile.dispel_ready = not IKA.db.profile.dispel_ready
				end,
				desc = "Shows an icon on the right side of a healer bar telling if has a dispel ready to use.",
				name = "Dispel Ready"
			},
			{
				type = "toggle",
				get = function() return IKA.db.profile.cooldown end,
				set = function (self, fixedparam, value) 
					IKA.db.profile.cooldown = not IKA.db.profile.cooldown
				end,
				desc = "Shows the cooldown animation on debuffs.\n\nNot recommended, become hard to see which debuff are.",
				name = "Debuff Duration"
			},

			--debuffs
			{
				type = "toggle",
				get = function() return IKA.db.profile.debuff_phantasmal_wounds end,
				set = function (self, fixedparam, value) 
					IKA.db.profile.debuff_phantasmal_wounds = not IKA.db.profile.debuff_phantasmal_wounds
					f:SetEnabledDebuffs()
				end,
				desc = "Show " .. aura_phantasmal_wounds .. " aura.",
				name = "|T" .. phantasmal_wounds_icon .. ":14:14:0:0:64:64:5:59:5:59|t" .. " " .. aura_phantasmal_wounds
			},
			{
				type = "toggle",
				get = function() return IKA.db.profile.debuff_phantasmal_winds end,
				set = function (self, fixedparam, value) 
					IKA.db.profile.debuff_phantasmal_winds = not IKA.db.profile.debuff_phantasmal_winds
					f:SetEnabledDebuffs()
				end,
				desc = "Show " .. aura_phantasmal_winds .. " aura.",
				name = "|T" .. phantasmal_winds_icon .. ":14:14:0:0:64:64:5:59:5:59|t" .. " " .. aura_phantasmal_winds
			},
			{
				type = "toggle",
				get = function() return IKA.db.profile.debuff_fel_chakram end,
				set = function (self, fixedparam, value) 
					IKA.db.profile.debuff_fel_chakram = not IKA.db.profile.debuff_fel_chakram
					f:SetEnabledDebuffs()
				end,
				desc = "Show " .. aura_fel_chakram .. " aura.\n\n|cFFFFFF00Important|r: only works on vertical alignment.",
				name = "|T" .. fel_chakram_icon .. ":14:14:0:0:64:64:5:59:5:59|t" .. " " .. aura_fel_chakram
			},
			{
				type = "toggle",
				get = function() return IKA.db.profile.debuff_phantasmal_corruption end,
				set = function (self, fixedparam, value) 
					IKA.db.profile.debuff_phantasmal_corruption = not IKA.db.profile.debuff_phantasmal_corruption
					f:SetEnabledDebuffs()
				end,
				desc = "Show " .. aura_phantasmal_corruption .. " aura.",
				name = "|T" .. phantasmal_corruption_icon .. ":14:14:0:0:64:64:5:59:5:59|t" .. " " .. aura_phantasmal_corruption
			},
			{
				type = "toggle",
				get = function() return IKA.db.profile.debuff_fel_bomb end,
				set = function (self, fixedparam, value) 
					IKA.db.profile.debuff_fel_bomb = not IKA.db.profile.debuff_fel_bomb
					f:SetEnabledDebuffs()
				end,
				desc = "Show " .. aura_fel_bomb .. " aura.",
				name = "|T" .. fel_bomb_icon .. ":14:14:0:0:64:64:5:59:5:59|t" .. " " .. aura_fel_bomb
			},
			{
				type = "toggle",
				get = function() return IKA.db.profile.debuff_phantasmal_bomb end,
				set = function (self, fixedparam, value) 
					IKA.db.profile.debuff_phantasmal_bomb = not IKA.db.profile.debuff_phantasmal_bomb
					f:SetEnabledDebuffs()
				end,
				desc = "Show " .. aura_phantasmal_bomb .. " aura.\n\n|cFFFFFF00Important|r: only works on vertical alignment.",
				name = "|T" .. phantasmal_bomb_icon .. ":14:14:0:0:64:64:5:59:5:59|t" .. " " .. aura_phantasmal_bomb
			},
			
			{type = "blank"},
			{type = "blank"},
			{type = "label", get = function() return "Miscellaneous:" end, text_template = DF:GetTemplate ("font", "ORANGE_FONT_TEMPLATE")},			
			
			--feedback
			{
				type = "execute",
				func = function() 
					IKA.OpenReportWindow()
				end,
				desc = "Get the link for our MMO-Champion forum thread, post bugs or feature suggestions.",
				name = "Report Bug",
			},
			
			--archimonde radar
			{
				type = "toggle",
				get = function() return IKA.db.profile.archimonde_radar end,
				set = function (self, fixedparam, value) 
					IKA.db.profile.archimonde_radar = not IKA.db.profile.archimonde_radar
				end,
				desc = "Show " .. aura_focused_chaos .. " radar for archimonde encounter.",
				name = "|T" .. aura_focused_chaos_icon .. ":14:14:0:0:64:64:5:59:5:59|t" .. " " .. aura_focused_chaos .. " (Archimonde)"
			},

		}
	
		local options_text_template = DF:GetTemplate ("font", "OPTIONS_FONT_TEMPLATE")
		local options_dropdown_template = DF:GetTemplate ("dropdown", "OPTIONS_DROPDOWN_TEMPLATE")
		local options_switch_template = DF:GetTemplate ("switch", "OPTIONS_CHECKBOX_TEMPLATE")
		local options_slider_template = DF:GetTemplate ("slider", "OPTIONS_SLIDER_TEMPLATE")
		local options_button_template = DF:GetTemplate ("button", "OPTIONS_BUTTON_TEMPLATE")
		
		DF:BuildMenu (frame, options_list, 0, 0, 235, true, options_text_template, options_dropdown_template, options_switch_template, true, options_slider_template, options_button_template)
	
	end

end

C_Timer.After (2, function()
	local RA = RaidAssist
	if (RA) then
	
		IKA.menu_text = function (plugin)
			local _, _, icon = GetSpellInfo (179202) --Eye of Anzu
		
			if (IKA.db.enabled) then
				return icon, icon_texcoord, "Iskar Assist", text_color_enabled
			else
				return icon, icon_texcoord, "Iskar Assist", text_color_disabled
			end
		end
	
		IKA.pluginname = "Iskar Assist"
	
		IKA.IsBossMod = true
		IKA.IsBossMod_MapId = 1448
		IKA.IsBossMod_EncounterId = 1788
		IKA.IsBossMod_EjId = 669
		IKA.IsBossMod_EjEncounterIndex = 7
		
		function IKA.OnShowOnOptionsPanel()
			local OptionsPanel = IKA.OptionsPanel
			IKA.BuildOptions (OptionsPanel)
		end
		
		local current_config_table
		if (DF and IskarAssistDB and not IskarAssistDB.ExportedConfig) then
			local profile = IskarAssistDB.profiles and IskarAssistDB.profiles.Default
			if (profile) then
				current_config_table = DF.table.copy ({}, profile)
			end
		end
		
		local install_status = RA:InstallPlugin ("Iskar Assist", "RAIskarAssistFrame", IKA, config_table)
		
		if (current_config_table) then
			IskarAssistDB.ExportedConfig = true
			
			local RAIskar = RADataBase and RADataBase.profiles and RADataBase.profiles.Default and RADataBase.profiles.Default.plugins and RADataBase.profiles.Default.plugins ["Iskar Assist"] and RADataBase.profiles.Default.plugins ["Iskar Assist"].profile
			if (RAIskar) then
				DF.table.copy (RAIskar, current_config_table)
				
				local RAInvite = RADataBase and RADataBase.profiles and RADataBase.profiles.Default and RADataBase.profiles.Default.plugins and RADataBase.profiles.Default.plugins ["Invites"]
				if (RAInvite) then
					RAInvite ["auto_accept_invites"] = false
					RAInvite ["auto_invite"] = false
					
					--print ("Settings auto invite OFF.")
				end
			end
		end
		
	end
end)


------------------------------------------------------------------------
-- /run ShadowLordIskarAssist:DumpAuras()
function IKA:DumpAuras()
	for name, value in pairs (track_auras) do
		print (name, value)
	end
end

-- /run ShadowLordIskarAssist:DumpMembers()
function IKA:DumpMembers()
	for i = 1, GetNumGroupMembers() do
		local name, rank, subgroup, level, class, fileName, zone, online, isDead, role, isML, assignedRole = GetRaidRosterInfo (i)
		local unitid = "raid" .. i
		local fullname = GetUnitName (unitid, true)
		print (unitid, i, subgroup, fullname)
	end
end

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- archimonde focused chaos radar
local radar = CreateFrame ("frame", "IskarAssistArchimondeRadar", UIParent)
radar:SetSize (140, 140)
radar:SetPoint ("center", UIParent, "center", -200, 0)

local g = LibStub:GetLibrary ("LibGraph-2.0")
if (not g) then
	radar:Hide()
	print ("|cFFFFAA00Please restart your client to finish update some AddOns.|r")
	return
end

local load_mod = CreateFrame ("frame", nil, UIParent)
load_mod:RegisterEvent ("ENCOUNTER_START")
load_mod:RegisterEvent ("ENCOUNTER_END")
load_mod:SetScript ("OnEvent", function (self, event, ...)
	if (event == "ENCOUNTER_START") then
		if (IKA.db.profile.archimonde_radar) then
			local encounterID, encounterName, difficultyID, raidSize = select (1, ...)
			if (encounterID == archimonde_encounter_id) then
				radar:RegisterEvent ("UNIT_AURA")
			end
		end
	else
		radar:UnregisterEvent ("UNIT_AURA")
	end
end)

if (is_kargath_test) then
	radar:RegisterEvent ("UNIT_AURA")
end

radar:SetMovable (true)
radar:SetScript ("OnMouseDown", function (self, button)
	if (self.isMoving) then
		return
	end
	self:StartMoving() 
	self.isMoving = true
end)
radar:SetScript ("OnMouseUp", function (self, button) 
	if (self.isMoving) then
		self:StopMovingOrSizing()
		self.isMoving = nil
	end
end)
--radar:SetBackdrop ({bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", tile = true, tileSize = 16})
--radar:SetBackdropColor (0, 0, 0, 0.5)
radar:Hide()

local background_image = radar:CreateTexture (nil, "background")
background_image:SetTexture ([[Interface\CHARACTERFRAME\TempPortraitAlphaMask]])
background_image:SetPoint ("center", radar, "center")
background_image:SetAlpha (0.3)
background_image:SetVertexColor (0, 0, 0)
background_image:SetSize (160, 160)

local center_point = radar:CreateTexture (nil, "overlay")
center_point:SetPoint ("center", radar, "center", 0, 0)
center_point:SetTexture (1, 1, 1, 0.5)
center_point:SetSize (3, 3)

local p1 = radar:CreateTexture (nil, "overlay")
p1:SetTexture (1, 0, 0)
p1:SetSize (6, 6)
local p2 = radar:CreateTexture (nil, "overlay")
p2:SetTexture (1, 0, 0)
p2:SetSize (6, 6)
local p3 = radar:CreateTexture (nil, "overlay")
p3:SetTexture (1, 0, 0)
p3:SetSize (6, 6)
local pname1 = radar:CreateFontString (nil, "overlay", "GameFontNormal")
pname1:SetPoint ("bottom", p1, "top", 0, 1)
local pname2 = radar:CreateFontString (nil, "overlay", "GameFontNormal")
pname2:SetPoint ("bottom", p2, "top", 0, 1)

local spellname1, spellname2 = select (1, GetSpellInfo (185014)), select (1, GetSpellInfo (186123)) --focused-chaos, wrought-chaos
if (is_kargath_test) then
	spellname1, spellname2 = "Weakened Soul", "Weakened Soul"
end
local player1, player2
local pi = math.pi
local pi_doubled = pi*2
local sin = math.sin
local cos = math.cos

local white = {1, 1, 1, 1}

local on_update_radar = function (self)
	if (UnitExists (player1) and UnitExists (player2)) then
		local self_x, self_y = UnitPosition ("player")
		local player1_x, player1_y = UnitPosition (player1)
		local player2_x, player2_y = UnitPosition (player2)
		
		local pivot = pi_doubled - GetPlayerFacing()
		local sine, cosine = -sin (pivot), -cos (pivot)
		local player1_dx = player1_x - self_x
		local player1_dy = player1_y - self_y
		local player2_dx = player2_x - self_x
		local player2_dy = player2_y - self_y
		local player_1_pin_pointX = ((player1_dy*cosine) - (-player1_dx*sine)) * 2.8
		local player_1_pin_pointY = ((player1_dy*sine) + (-player1_dx*cosine)) * 2.8
		local player_2_pin_pointX = ((player2_dy*cosine) - (-player2_dx*sine)) * 2.8
		local player_2_pin_pointY = ((player2_dy*sine) + (-player2_dx*cosine)) * 2.8
		local line_dx = player_2_pin_pointX - player_1_pin_pointX
		local line_dy = player_2_pin_pointY - player_1_pin_pointY
		local vsize = ((line_dy^2) + (line_dx^2)) ^ 0.5
		local vx = (line_dx/vsize) * (abs (vsize-150))
		local vy = (line_dy/vsize) * (abs (vsize-150))
		
		p1:SetPoint ("center", radar, "center", player_1_pin_pointX, player_1_pin_pointY)
		p2:SetPoint ("center", radar, "center", player_2_pin_pointX, player_2_pin_pointY)
		p3:SetPoint ("center", radar, "center", player_2_pin_pointX+vx, player_2_pin_pointY+vy)
		
		if (radar.GraphLib_Lines_Used) then
			for i = #radar.GraphLib_Lines_Used, 1, -1 do
				local line = tremove (radar.GraphLib_Lines_Used)
				tinsert (radar.GraphLib_Lines, line)
				line:Hide()
			end
		end
		
		local x, y = radar:GetCenter()
		local half = radar:GetWidth()/2
		local x1, y1 = p1:GetCenter()
		local x2, y2 = p2:GetCenter()
		local x3, y3 = p3:GetCenter()
		x1, y1, x2, y2, x3, y3 = x1-x, y1-y, x2-x, y2-y, x3-x, y3-y
		g:DrawLine (radar, x1+half, y1+half, x2+half, y2+half, 80, white, "artwork")
		g:DrawLine (radar, x2+half, y2+half, x3+half, y3+half, 80, white, "artwork")

		radar:Show()
	else
		radar:SetScript ("OnUpdate", nil)
		radar:Hide()
	end
end

radar:SetScript ("OnEvent", function (self, event, unitid)

	if (not UnitDebuff ("player", spellname1) and not UnitDebuff ("player", spellname2)) then

		player1, player2 = nil, nil

		for i = 1, GetNumGroupMembers() do
			if (UnitDebuff ("raid" .. i, spellname1) or UnitDebuff ("raid" .. i, spellname2)) then
				if (not player1) then
					player1 = "raid" .. i
				elseif (not player2) then
					player2 = "raid" .. i
					break
				end
			end
		end
		
		if (player1 and player2) then
			pname1:SetText (UnitName (player1))
			pname2:SetText (UnitName (player2))
			radar:Show()
			radar:SetScript ("OnUpdate", on_update_radar)
		else
			radar:SetScript ("OnUpdate", nil)
			radar:Hide()
		end
	else
		radar:SetScript ("OnUpdate", nil)
		radar:Hide()
	end
	
end)


--> GridLayoutHeader1UnitButton1
--> Grid2LayoutHeader1UnitButton1
--> CompactRaidGroup1Member1
--> HealBot_Action_HealUnit15Bar
--> Vd1H23BgBarIcBar
