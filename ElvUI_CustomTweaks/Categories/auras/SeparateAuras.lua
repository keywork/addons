local E, L, V, P, G = unpack(ElvUI)
local A = E:GetModule("Auras")
local LSM = LibStub("LibSharedMedia-3.0")
local CT = E:GetModule("CustomTweaks")
local isEnabled = E.private["CustomTweaks"] and E.private["CustomTweaks"]["SeparateAuras"] and true or false

--Cache global variables
local select = select
local floor = math.floor

---
-- GLOBALS: BuffFrame, TemporaryEnchantFrame, Minimap
-- GLOBALS: InterfaceOptionsFrameCategoriesButton12, LeftMiniPanel
---

V["CustomTweaks"]["SeparateAuras_Options"] = {
	["buffs"] = true,
	["debuffs"] = true,
}

local function ConfigTable()
	E.Options.args.CustomTweaks.args.Auras.args.options.args.SeparateAuras = {
		type = "group",
		name = "SeparateAuras",
		get = function(info) return E.private.CustomTweaks["SeparateAuras_Options"][info[#info]] end,
		set = function(info, value) E.private.CustomTweaks["SeparateAuras_Options"][info[#info]] = value; E:StaticPopup_Show("PRIVATE_RL"); end,
		args = {
			buffs = {
				order = 1,
				type = "toggle",
				name = L["Enable Buffs"],
				disabled = function() return not isEnabled end,
			},
			debuffs = {
				order = 2,
				type = "toggle",
				name = L["Enable Debuffs"],
				disabled = function() return not isEnabled end,
			},
		},
	}
	
	if isEnabled then
		--Substitute with our own options
		E.Options.args.auras.args.enable = nil
		E.Options.args.auras.args.buffs = {
			order = 2,
			type = "toggle",
			name = L["Enable Buffs"],
			get = function(info) return E.private.CustomTweaks["SeparateAuras_Options"].buffs end,
			set = function(info, value) E.private.CustomTweaks["SeparateAuras_Options"].buffs = value; E:StaticPopup_Show("PRIVATE_RL"); end,
		}
		E.Options.args.auras.args.debuffs = {
			order = 2.5,
			type = "toggle",
			name = L["Enable Debuffs"],
			get = function(info) return E.private.CustomTweaks["SeparateAuras_Options"].debuffs end,
			set = function(info, value) E.private.CustomTweaks["SeparateAuras_Options"].debuffs = value; E:StaticPopup_Show("PRIVATE_RL"); end,
		}
	end
end
CT.Configs["SeparateAuras"] = ConfigTable
if not isEnabled then return; end

local DIRECTION_TO_POINT = {
	DOWN_RIGHT = "TOPLEFT",
	DOWN_LEFT = "TOPRIGHT",
	UP_RIGHT = "BOTTOMLEFT",
	UP_LEFT = "BOTTOMRIGHT",
	RIGHT_DOWN = "TOPLEFT",
	RIGHT_UP = "BOTTOMLEFT",
	LEFT_DOWN = "TOPRIGHT",
	LEFT_UP = "BOTTOMRIGHT",
}

local DIRECTION_TO_HORIZONTAL_SPACING_MULTIPLIER = {
	DOWN_RIGHT = 1,
	DOWN_LEFT = -1,
	UP_RIGHT = 1,
	UP_LEFT = -1,
	RIGHT_DOWN = 1,
	RIGHT_UP = 1,
	LEFT_DOWN = -1,
	LEFT_UP = -1,
}

local DIRECTION_TO_VERTICAL_SPACING_MULTIPLIER = {
	DOWN_RIGHT = -1,
	DOWN_LEFT = -1,
	UP_RIGHT = 1,
	UP_LEFT = 1,
	RIGHT_DOWN = -1,
	RIGHT_UP = 1,
	LEFT_DOWN = -1,
	LEFT_UP = 1,
}

local IS_HORIZONTAL_GROWTH = {
	RIGHT_DOWN = true,
	RIGHT_UP = true,
	LEFT_DOWN = true,
	LEFT_UP = true,
}

local Masque = LibStub("Masque", true)
local MasqueGroupBuffs = Masque and Masque:Group("ElvUI", "Buffs")
local MasqueGroupDebuffs = Masque and Masque:Group("ElvUI", "Debuffs")

function A:UpdateHeader(header)
	if (not E.private.CustomTweaks.SeparateAuras_Options.buffs) and (not E.private.CustomTweaks.SeparateAuras_Options.debuffs) then return end
	local db = self.db.debuffs
	if header:GetAttribute('filter') == 'HELPFUL' then
		db = self.db.buffs
		header:SetAttribute("consolidateTo", 0)
		header:SetAttribute('weaponTemplate', ("ElvUIAuraTemplate%d"):format(db.size))
	end

	header:SetAttribute("separateOwn", db.seperateOwn)
	header:SetAttribute("sortMethod", db.sortMethod)
	header:SetAttribute("sortDirection", db.sortDir)
	header:SetAttribute("maxWraps", db.maxWraps)
	header:SetAttribute("wrapAfter", db.wrapAfter)

	header:SetAttribute("point", DIRECTION_TO_POINT[db.growthDirection])

	if(IS_HORIZONTAL_GROWTH[db.growthDirection]) then
		header:SetAttribute("minWidth", ((db.wrapAfter == 1 and 0 or db.horizontalSpacing) + db.size) * db.wrapAfter)
		header:SetAttribute("minHeight", (db.verticalSpacing + db.size) * db.maxWraps)
		header:SetAttribute("xOffset", DIRECTION_TO_HORIZONTAL_SPACING_MULTIPLIER[db.growthDirection] * (db.horizontalSpacing + db.size))
		header:SetAttribute("yOffset", 0)
		header:SetAttribute("wrapXOffset", 0)
		header:SetAttribute("wrapYOffset", DIRECTION_TO_VERTICAL_SPACING_MULTIPLIER[db.growthDirection] * (db.verticalSpacing + db.size))
	else
		header:SetAttribute("minWidth", (db.horizontalSpacing + db.size) * db.maxWraps)
		header:SetAttribute("minHeight", ((db.wrapAfter == 1 and 0 or db.verticalSpacing) + db.size) * db.wrapAfter)
		header:SetAttribute("xOffset", 0)
		header:SetAttribute("yOffset", DIRECTION_TO_VERTICAL_SPACING_MULTIPLIER[db.growthDirection] * (db.verticalSpacing + db.size))
		header:SetAttribute("wrapXOffset", DIRECTION_TO_HORIZONTAL_SPACING_MULTIPLIER[db.growthDirection] * (db.horizontalSpacing + db.size))
		header:SetAttribute("wrapYOffset", 0)
	end

	header:SetAttribute("template", ("ElvUIAuraTemplate%d"):format(db.size))
	local index = 1
	local child = select(index, header:GetChildren())
	while(child) do
		if((floor(child:GetWidth() * 100 + 0.5) / 100) ~= db.size) then
			child:SetSize(db.size, db.size)
		end

		if(child.time) then
			local font = LSM:Fetch("font", self.db.font)
			child.time:ClearAllPoints()
			child.time:SetPoint("TOP", child, 'BOTTOM', 1 + self.db.timeXOffset, 0 + self.db.timeYOffset)
			child.time:FontTemplate(font, self.db.fontSize, self.db.fontOutline)

			child.count:ClearAllPoints()
			child.count:SetPoint("BOTTOMRIGHT", -1 + self.db.countXOffset, 0 + self.db.countYOffset)
			child.count:FontTemplate(font, self.db.fontSize, self.db.fontOutline)
		end

		--Blizzard bug fix, icons arent being hidden when you reduce the amount of maximum buttons
		if(index > (db.maxWraps * db.wrapAfter) and child:IsShown()) then
			child:Hide()
		end

		index = index + 1
		child = select(index, header:GetChildren())
	end
	
	if MasqueGroupBuffs and E.private.auras.masque.buffs then MasqueGroupBuffs:ReSkin() end
	if MasqueGroupDebuffs and E.private.auras.masque.debuffs then MasqueGroupDebuffs:ReSkin() end
end

function A:Initialize()
	if(E.private.auras.disableBlizzard) then
		BuffFrame:Kill()
		TemporaryEnchantFrame:Kill();
	end

	if (not E.private.CustomTweaks.SeparateAuras_Options.buffs) and (not E.private.CustomTweaks.SeparateAuras_Options.debuffs) then return end

	self.db = E.db.auras

	if (E.private.CustomTweaks.SeparateAuras_Options.buffs) then
		self.BuffFrame = self:CreateAuraHeader("HELPFUL")
		self.BuffFrame:SetPoint("TOPRIGHT", Minimap, "TOPLEFT", -8, 0)
		E:CreateMover(self.BuffFrame, "BuffsMover", L["Player Buffs"])
		if Masque then
			if MasqueGroupBuffs then A.BuffsMasqueGroup = MasqueGroupBuffs end
		end
	end

	if (E.private.CustomTweaks.SeparateAuras_Options.debuffs) then
		self.DebuffFrame = self:CreateAuraHeader("HARMFUL")
		self.DebuffFrame:SetPoint("BOTTOMRIGHT", LeftMiniPanel, "BOTTOMLEFT", -(6 + E.Border), 0)
		E:CreateMover(self.DebuffFrame, "DebuffsMover", L["Player Debuffs"])
		if Masque then
			if MasqueGroupDebuffs then A.DebuffsMasqueGroup = MasqueGroupDebuffs end
		end
	end
end