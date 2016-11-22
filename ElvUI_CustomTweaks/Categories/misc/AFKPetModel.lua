local E, L, V, P, G = unpack(ElvUI)
local AFK = E:GetModule('AFK')
local CT = E:GetModule("CustomTweaks")
local isEnabled = E.private["CustomTweaks"] and E.private["CustomTweaks"]["AFKPetModel"] and true or false

--Cache global variables
local select = select
local pi = math.pi
local CreateFrame = CreateFrame
local InCombatLockdown = InCombatLockdown
local C_PetJournalFindPetIDByName = C_PetJournal.FindPetIDByName
local C_PetJournalGetPetInfoByIndex = C_PetJournal.GetPetInfoByIndex
local C_PetJournalGetPetInfoBySpeciesID = C_PetJournal.GetPetInfoBySpeciesID

---
-- GLOBALS: UIParent, GetScreenWidth, GetScreenHeight
---

P["CustomTweaks"]["AFKPetModel"] = {
	["pet"] = "",
	["animation"] = 0,
	["modelScale"] = 1,
	["facing"] = 15,
}

local function ConfigTable()
	E.Options.args.CustomTweaks.args.Misc.args.options.args.AFKPetModel = {
		type = "group",
		name = "AFKPetModel",
		get = function(info) return E.db.CustomTweaks.AFKPetModel[info[#info]] end,
		set = function(info, value) E.db.CustomTweaks.AFKPetModel[info[#info]] = value end,
		args = {
			pet = {
				order = 1,
				type = "input",
				name = L["Companion Pet Name"],
				width = "full",
				disabled = function() return not isEnabled end,
				set = function(info, value)
					local speciesID = C_PetJournalFindPetIDByName(value)
					if speciesID then
						E.db.CustomTweaks.AFKPetModel[info[#info]] = value
					else
						E.db.CustomTweaks.AFKPetModel[info[#info]] = select(8, C_PetJournalGetPetInfoByIndex(1))
					end
					E.db.CustomTweaks.AFKPetModel.modelScale = 1 --Reset scale when new pet is set
				end,
			},
			modelScale = {
				order = 2,
				type = "range",
				name = L["Model Scale"],
				desc = L["Some pets will appear huge. Lower the scale when that happens."],
				min = 0.05, max = 2, step = 0.05,
				disabled = function() return not isEnabled end,
			},
			facing = {
				order = 3,
				type = "range",
				name = L["Model Facing Direction"],
				desc = L["Less than 0 faces the model to the left, more than 0 faces the model to the right"],
				min = -180, max = 180, step = 5,
				disabled = function() return not isEnabled end,
			},
			animation = {
				order = 4,
				type = "range",
				name = L["Animation"],
				desc = L["NPC animations are not documented anywhere, and as such you will just have to try out various settings until you find the animation you want. Default animation is 0 (idle)"],
				min = 0, max = 822, step = 1,
				disabled = function() return not isEnabled end,
				set = function(info, value)
					if value > 822 then value = 822 elseif value < 0 then value = 0 end
					E.db.CustomTweaks.AFKPetModel[info[#info]] = value
				end,
			},
		},
	}
end
CT.Configs["AFKPetModel"] = ConfigTable
if not isEnabled then return; end

--Add new config mode category
table.insert(E.ConfigModeLayouts, "AFK")
E.ConfigModeLocalizedStrings["AFK"] = "AFK"

local function SetAFK(self, status)
	if(InCombatLockdown()) then return end
	
	if(status) then
		local petName = E.db.CustomTweaks.AFKPetModel.pet
		if petName == "" then return end
		local scale = E.db.CustomTweaks.AFKPetModel.modelScale
		local facingRad = E.db.CustomTweaks.AFKPetModel.facing * (pi/180)
		local animation = E.db.CustomTweaks.AFKPetModel.animation
		local speciesID	= C_PetJournalFindPetIDByName(petName)
		local displayID = select(12, C_PetJournalGetPetInfoBySpeciesID(speciesID));
		self.AFKMode.pet.model:SetModelScale(scale)
		self.AFKMode.pet.model:SetFacing(facingRad)
		self.AFKMode.pet.model:ClearModel()
		self.AFKMode.pet.model:SetDisplayInfo(displayID)
		--Animation types are undocumented. Some are listed here: http://us.battle.net/wow/en/forum/topic/8569600188
		self.AFKMode.pet.model:SetAnimation(animation)
		self.AFKMode.pet.model:SetCustomCamera(1)
		self.AFKMode.pet.model:SetCameraDistance(20) --Zoom out, otherwise we get a huge model
	end
end
hooksecurefunc(AFK, "SetAFK", SetAFK)

local function createPetModel(self)
	self.AFKMode.pet = CreateFrame("Frame", nil, self.AFKMode)
	self.AFKMode.pet:SetSize(150, 150)
	self.AFKMode.pet:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 400, 60)
	E:CreateMover(self.AFKMode.pet, "AFKPetModelMover", "AFK Pet Model", nil, nil, nil, "AFK")
	
	self.AFKMode.pet.model = CreateFrame("PlayerModel", "ElvUIAFKPetModel", self.AFKMode.pet)
	self.AFKMode.pet.model:SetPoint("CENTER", self.AFKMode.pet, "CENTER")
	--Use a large frame so borders don't become visible when pets do one of their special animations
	self.AFKMode.pet.model:SetSize(GetScreenWidth()*2, GetScreenHeight()*2)
end
hooksecurefunc(AFK, "Initialize", createPetModel)