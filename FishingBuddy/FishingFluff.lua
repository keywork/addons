-- Random fun things to do while fishing
--
-- Turn on the fish finder
-- Change your title to "Salty"
-- Bring out a "fishing buddy"

local FL = LibStub("LibFishing-1.0");
local LibPetJournal = LibStub("LibPetJournal-2.0")

-- 5.0.4 has a problem with a global "_" (see some for loops below)
local _

local PETSETTING = "FishingPetBuddies";

-- Pet menu constants
local PET_NONE = -1;
local PET_FISHING = -2;
local PET_ALL = -3;
local FLUFF_DISPLAYED_PETS = 14;
local FLUFF_LINE_HEIGHT = 16;
local RAFT_RESET_TIME = 60;

-- the creature ids for the fishing pets
local FISHINGPETS = {};
FISHINGPETS[18839] = -1; -- Magical Crawdad
FISHINGPETS[26050] = -1; -- Snarly
FISHINGPETS[26056] = -1; -- Chuck
FISHINGPETS[24388] = -1; -- Toothy
FISHINGPETS[24389] = -1; -- Muckbreath
FISHINGPETS[31575] = -1; -- Giant Sewer Rat
FISHINGPETS[33226] = -1; -- Strand Crawler
FISHINGPETS[55386] = -1; -- Sea Pony
FISHINGPETS[63559] = -1; -- Tiny Goldfish
-- since we can't just do #FISHINGPETS
local NUM_FISHINGPETS = FL:tablecount(FISHINGPETS);

-- Debugging
FishingBuddy.FISHINGPETS = FISHINGPETS;

-- wrap settings
local FBGetSetting = FishingBuddy.GetSetting;
local FBGetSettingBool = FishingBuddy.GetSettingBool;

local function GetSettingBool(setting)
	if (FBGetSettingBool("FishingFluff")) then
		return FBGetSettingBool(setting);
	end
	-- return nil;
end

local function GetSetting(setting)
	if (FBGetSettingBool("FishingFluff")) then
		return FBGetSetting(setting);
	end
	-- return nil;
end

local ourpets = {};
local petmap = {};
local chosenpets = {};
local chosenmap = {};
local chosenlist = {};
local numchosen = 0;

local function AddChosenPet(cid, petid)
	chosenpets[cid] = 1;
	tinsert(chosenlist, petid)
	numchosen = numchosen + 1;
end

local function CheckedOurPets()
	for index=1,#ourpets do
		ourpets[index].checked = (chosenpets[ourpets[index].cID] == 1);
	end
	
	if (FishingPetFrame.petnames) then
		local petnames = FishingPetFrame.petnames;
		for index=4,#petnames do
			petnames[index].checked = (chosenpets[petnames[index].cID] == 1);
		end
	end
end

local function UpdateChosenPets()
	local settingpets = GetSetting(PETSETTING);

	chosenpets = {};
	chosenlist = {};
	numchosen = 0;

	local allpets = false;
	if ( type(settingpets) ~= "table" ) then
		settingpets = tonumber(settingpets);
		if ( settingpets == PET_ALL ) then
			allpets = true;
		end

		for idx=1,#ourpets do
			local cid = ourpets[idx].cID;
			if ( FISHINGPETS[cid] and settingpets == PET_FISHING ) then
				AddChosenPet(cid, petmap[cid]);
			elseif (allpets) then
				AddChosenPet(cid, petmap[cid]);
			end
		end
	elseif ( type(settingpets) == "table" ) then
		for cid,_ in pairs(settingpets) do
			AddChosenPet(cid, petmap[cid]);
		end
	end
	CheckedOurPets();
	FishingPets_UpdateMenu();
end

local function HandlePetsUpdate()
	ourpets = {};
	petmap = {};
    for _,petid in LibPetJournal:IteratePetIDs() do 
        local speciesID, customName, level, xp, maxXp, displayID,
              isFavorite, name, icon, petType, creatureID,
              sourceText, description, isWild, canBattle,
              tradable, unique, obtainable = C_PetJournal.GetPetInfoByPetID(petid)
		local addit = not petmap[creatureID];
		if (customName) then
			name = customName;
			addit = true;
		end
		if (addit) then
			tinsert(ourpets, { cID=creatureID, icon=icon, name=name, petID=petid, checked=false });
			petmap[creatureID] = petid;
		end
    end

	UpdateChosenPets();

	if (FishingBuddy.Debugging) then
		FishingBuddy_Info["ourpets"] = ourpets;
	end
end

local FluffEvents = {};

local unTrack = nil;
local resetPVP = nil;
local resetPet = nil;

local LastSpecialBait = nil;
local SpecialBait = 
{
	[7] = {
		110274,		-- Jawless Skulker Bait
		110289,		-- Fat Sleeper Bait
		110290,		-- Blind Lake Sturgeon Bait
		110291,		-- Fire Ammonite Bait
		110292,		-- Sea Scorpion Bait
		110293,		-- Abyssal Gulper Eel Bait
		110294,		-- Blackwater Whiptail Bait
	},
	[8] = {
		139175,		-- Arcane lure
	}
};

FluffEvents[FBConstants.FISHING_ENABLED_EVT] = function()
	LastSpecialBait = nil;
	if ( FishingBuddy.GetSettingBool("FishingFluff")) then
		if ( GetSettingBool("FindFish") ) then
			local findid = FL:GetFindFishID();
			if ( findid ) then
				local _, _, active, _ = GetTrackingInfo(findid);
				if (not active) then
					unTrack = true;
					SetTracking(findid, true);
				end
			end
		end
		
		if ( GetSettingBool("TurnOffPVP") ) then
			if (1 == GetPVPDesired() ) then
				resetPVP = true;
				SetPVP(0);
			end
		end
		
		-- only do the fluff stuff if we're actually wearing any fishing gear
		-- we don't do this stuff if we're "no pole equipped" fishing
		if ( FishingBuddy.GetSetting(PETSETTING) ~= PET_NONE and
			 FishingBuddy.ReadyForFishing() and
			 not FishingBuddy.CheckCombat()) then
			if ( not (IsFlying() or IsMounted()) ) then
				local nowpet = C_PetJournal.GetSummonedPetGUID();
				local petid = nowpet;
				if ( numchosen > 0 ) then
					local avail = false;
					for ldx=1,5 do
						if ( not avail ) then
							local idx = random(1, numchosen);
							petid = chosenlist[idx];
							avail = C_PetJournal.PetIsSummonable(petid)
						end
					end
				end
				if ( petid and petid ~= nowpet ) then
					resetPet = nowpet;
					C_PetJournal.SummonPetByGUID(petid);
				end
			end
		end
	end
end

local function Untrack(yes)
	if ( yes ) then
		local findid = FL:GetFindFishID();
		if ( findid ) then
			SetTracking(findid, false);
		end
	end
end

local function DoPetReset(pet)
	if ( pet ) then
		C_PetJournal.SummonPetByGUID(pet);
	elseif (FishingBuddy.GetSetting(PETSETTING) ~= PET_NONE) then
		local nowpet = C_PetJournal.GetSummonedPetGUID();
		if ( nowpet ) then
			C_PetJournal.SummonPetByGUID(nowpet);
		end
	end
end

FluffEvents[FBConstants.FISHING_DISABLED_EVT] = function(started, logout)
	if ( resetPVP ) then
		SetPVP(1);
	end
	if ( logout ) then
		FishingBuddy_Player["Untrack"] = unTrack;
		FishingBuddy_Player["ResetPet"] = resetPet;
	else
		Untrack(unTrack);
		DoPetReset(resetPet);
	end
	unTrack = nil;
	resetPet = nil;
	resetPVP = nil;
	LastSpecialBait = nil;
end

FluffEvents[FBConstants.LOGIN_EVT] = function()
	if ( FishingBuddy_Player ) then
		if ( FishingBuddy_Player["Untrack"] ) then
			FishingBuddy_Player["Untrack"] = nil;
			Untrack(1);
		end
		if ( FishingBuddy_Player["ResetPet"] ) then
			DoPetReset(FishingBuddy_Player["ResetPet"]);
			FishingBuddy_Player["ResetPet"] = nil;
		end		
	end
end

function FishingPetsMenu_Update()
	local buttons = FishingPetsMenu.buttons;
	local petnames = FishingPetFrame.petnames;
	local numButtons = #buttons;
	local scrollOffset = HybridScrollFrame_GetOffset(FishingPetsMenu); 
	local choice;
	for i = 1, numButtons do
		local idx = i + scrollOffset;
		choice = petnames[idx];
		if ( choice ) then
			buttons[i].text:SetText(choice.name);
			buttons[i].meta = choice.meta;
			buttons[i].cID = choice.cID;
			if ( choice.checked ) then
				buttons[i].check:Show();
			else
				buttons[i].check:Hide();
			end
			buttons[i].idx = idx;
		end
	end
end

local function UpdateMenuText(petsetting)
	petsetting = petsetting or FishingBuddy.GetSetting(PETSETTING);
	if ( type(petsetting) ~= "table" ) then
		if ( petsetting == PET_NONE ) then
			FishingPetFrameText:SetText(NONE);
		elseif ( petsetting == PET_ALL ) then
			FishingPetFrameText:SetText(ALL);
		elseif ( petsetting == PET_FISHING ) then
			FishingPetFrameText:SetText(PROFESSIONS_FISHING);
		end
	else
		FishingPetFrameText:SetText(PET_PAPERDOLL);
	end
	
end

function FishingPets_UpdateMenu()
	local buttons = FishingPetsMenu.buttons;
	local fontstringText = buttons[1].text;
	local fontstringWidth;			
	local maxWidth = 0;
	
	local petsetting = GetSetting(PETSETTING);
	if ( not petsetting or type(petsetting) ~= "table" ) then
		petsetting = tonumber(petsetting) or PET_FISHING;
	end
	local petnames = {};
	petnames[1] = { };
	-- Let's make "none" an easy choice
	petnames[1].name = NONE;
	petnames[1].cID = PET_NONE;
	petnames[1].checked = (petsetting == PET_NONE);
	petnames[1].meta = true;
	petnames[2] = { };
	petnames[2].name = PROFESSIONS_FISHING;
	petnames[2].cID = PET_FISHING;
	petnames[2].checked = (petsetting == PET_FISHING);
	petnames[2].meta = true;
	petnames[3] = { };
	petnames[3].name = ALL;
	petnames[3].cID = PET_ALL;
	petnames[3].checked = (petsetting == PET_ALL);
	petnames[3].meta = true;

	local menuidx = 4;
	for _,info in pairs(ourpets) do
		petnames[menuidx] = petnames[menuidx] or { };
		petnames[menuidx].name = info.name;
		petnames[menuidx].cID = info.cID;
		petnames[menuidx].checked = info.checked;
		fontstringText:SetText(info.name);
		fontstringWidth = fontstringText:GetWidth();
		if ( fontstringWidth > maxWidth ) then
			maxWidth = fontstringWidth;
		end
		menuidx = menuidx + 1;
	end
	FishingPetFrame.petnames = petnames; 
	UpdateMenuText(petsetting);
	maxWidth = maxWidth + 10;				
	for i = 1, #buttons do
		buttons[i]:SetWidth(maxWidth);
	end
	FishingPetsMenu:SetWidth(maxWidth);
	FishingPetsMenuScrollChild:SetWidth(maxWidth);
	HybridScrollFrame_Update(FishingPetsMenu, menuidx * FLUFF_LINE_HEIGHT, FishingPetsMenu:GetHeight());		
	FishingPetsMenu_Update();
	FishingPetsMenuHolder:SetSize(FishingPetsMenu:GetWidth() + 38, FishingPetsMenu:GetHeight() + 24);
end

function FishingPetsButton_OnClick(self)
	PlaySound("igMainMenuOptionCheckBoxOff");
	local petnames = FishingPetFrame.petnames;
	if ( self.meta ) then
		FishingBuddy.SetSetting(PETSETTING, self.cID);	
		UpdateChosenPets();
		for idx=1,3 do
			petnames[idx].checked = (petnames[idx].cID == self.cID);
		end
	else
		-- toggle
		if (chosenpets[self.cID] == 1) then
			chosenpets[self.cID] = 0;
			petnames[self.idx].checked = false;
		else
			chosenpets[self.cID] = 1;
			petnames[self.idx].checked = true;
		end
		local newpets = {};
		for cid,val in pairs(chosenpets) do
			if (val and val > 0) then
				newpets[cid] = 1;
			end
		end
		local petsetting;
		local newcount = FL:tablecount(newpets);
		if ( newcount > 0 ) then
			if ( newcount == #ourpets ) then
				petsetting = PET_ALL;
			else
				local count = 0;
				for cid,_ in pairs(FISHINGPETS) do
					if ( chosenpets[cid] and chosenpets[cid] == 1 ) then
						count = count + 1;
					end
				end
				if ( count == newcount and count == NUM_FISHINGPETS ) then
					petsetting = PET_FISHING;
				else
					petsetting = newpets;
				end
			end
		else
			petsetting = PET_NONE;
		end
		for idx=1,3 do
			petnames[idx].checked = (petnames[idx].cID == petsetting);
		end
		FishingBuddy.SetSetting(PETSETTING, petsetting);
		UpdateMenuText(petsetting);
		UpdateChosenPets();
	end
end

function FishingPetsMenu_Toggle()
	if ( FishingPetsMenuHolder:IsShown() ) then
		PlaySound("igMainMenuOptionCheckBoxOff");
		FishingPetsMenuHolder:Hide(); 
	else		
		PlaySound("igMainMenuOptionCheckBoxOn");
		FishingPetsMenuHolder:SetFrameLevel(FishingPetFrame:GetFrameLevel()+3);
		FishingPetsMenuHolder:Show();
		FishingPetsMenu_Update();	
	end
end

function FishingPetsMenu_OnLoad(self)
	HybridScrollFrame_OnLoad(self);
	self.update = FishingPetsMenu_Update;	
	HybridScrollFrame_CreateButtons(self, "FishingPetButtonTemplate");
end

local function FishingPetFrame_OnHide(self)
	if ( FishingPetsMenu:IsShown() ) then
		FishingPetsMenuHolder:Hide(); 
	end
end

-- Don't cast the angler's raft if we're doing Scavenger Hunt or on Inkgill Mere
local GSB = FishingBuddy.GetSettingBool;
local function RaftBergUsable(info)
	return ( GSB(info.setting) and not IsMounted() and 
		not FL:HasBuff(GetSpellInfo(116032)) and
		not FL:HasBuff(GetSpellInfo(119700)));
end

local function RaftBergCheck(info, buff, need, itemid)
	if (GSB(info.option.setting) and need) then
		return false;
	end
	local _, _, _, _, _, _, et, _, _, _, _ = UnitBuff("player", buff);
	et = (et or 0) - GetTime();
	if (need or et <= RAFT_RESET_TIME) then
		if (info.toy) then
			_, itemid = C_ToyBox.GetToyInfo(itemid)
		end
		return true, itemid;
	end
	--return nil;
end

local QuestBaits = {
	{
		item = 114628,		-- Icespine Stinger Bait
		spell = 168448,
	},
	{
		item = 114874,		-- Moonshell Claw Bait
		spell = 168868,
	},
};

local objectiveMapID = { 941, 946, 947, 948, 949, 950 }
local function IsQuestFishing(item)
	-- Check for hookshot
	if (GetItemCount(116755) > 0) then
		-- Better Nat's quest checking by Bodar (Curse)
		local questLogIndex = GetQuestLogIndexByID(36611);
		if (questLogIndex > 0) then
			local currentMapID = GetCurrentMapAreaID();
			local numObjectives = GetNumQuestLeaderBoards(questLogIndex);
			for i = 1, numObjectives do
				local text, objectiveType, finished = GetQuestLogLeaderBoard(i, questLogIndex);
				if (not finished and currentMapID == objectiveMapID[i]) then
					return true;
				end
			end
		end
	end

	-- and intro quest baits
	for _,bait in ipairs(QuestBaits) do
		if (GetItemCount(bait.item) > 0 or FL:HasBuff(GetSpellInfo(bait.spell))) then
			return true;
		end
	end
end

local FishingItems = {};
FishingItems[85973] = {
	["enUS"] = "Ancient Pandaren Fishing Charm",
	["tooltip"] = FBConstants.CONFIG_FISHINGCHARM_INFO,
	spell = 125167,
	setting = "UsePandarenCharm",
	usable = function(item)
			-- only usable in Pandoria
			local C,_,_,_ = FL:GetCurrentPlayerPosition();
			return (C == 6);
		end,
	["default"] = true,
};
FishingItems[88535] = {
	["enUS"] = "Sharpened Tuskarr Spear",
	["tooltip"] = FBConstants.CONFIG_TUSKAARSPEAR_INFO,
	spell = 128357,
	setting = "UseTuskarrSpear",
	check = function(info, buff, need)
			if ( need ) then
				local s,_,_ = GetItemCooldown(88535);
				if ( s == 0 ) then
					local pole = FL:IsFishingPole();
					local main = FL:GetMainHandItem(true);
					if ( pole ) then
						info.pole = main;
						EquipItemByName(88535);
						return true, 88535;
					elseif (main) then
						return (main == 88535), 88535;
					end
				end
			elseif (info.pole) then
				EquipItemByName(info.pole);
				info.pole = nil;
				return true, nil;
			end
					
			-- return false, nil
		end,
	["default"] = false,
};
FishingItems[122742] = {
	["enUS"] = "Bladebone Hook",					-- 1 hour duration
	["spell"] = 182226,
	setting = "UseBladeboneHook",
	visible = function(option)
			return true;
		end,
	usable = function(item)
			-- only usable in Draenor
			local C,_,_,_ = FL:GetCurrentPlayerPosition();
			return (C == 7);
		end,
	["default"] = false,
};
FishingItems[116755] = {
	["enUS"] = "Nat's Hookshot",
	spell = 171740,
	usable = IsQuestFishing,
};
FishingItems[136377] = {
	["enUS"] = "Oversized Bobber",
	setting = "UseOversizedBobber",
	spell = 207700,
	visible = function(option)
			return true;
		end,
	["default"] = true,
};

-- Dalaran coin lures
local CoinLures = {};
local function CanUseCoinLure()
	if (GSB("DalaranLures")) then
		for id,info in pairs(CoinLures) do
			if (FL:HasBuff(GetSpellInfo(info.spell))) then
				return false;
			end
		end
		return true;
	end
	return false;
end

CoinLures[138956] = {
	["enUS"] = "Hypermagnetic Lure",
	setting = "DalaranLures",
	spell = 217835,
	usable = CanUseCoinLure,
	ignore = true,
};
CoinLures[138959] = {
	["enUS"] = "Micro-Vortex Generator",
	setting = "DalaranLures",
	spell = 217838,
	usable = CanUseCoinLure,
	ignore = true,
};
CoinLures[138961] = {
	["enUS"] = "Alchemical Bonding Agent",
	setting = "DalaranLures",
	spell = 217840,
	usable = CanUseCoinLure,
	ignore = true,
};
CoinLures[138962] = {
	["enUS"] = "Starfish on a String",
	setting = "DalaranLures",
	spell = 217842,
	usable = CanUseCoinLure,
	ignore = true,
};
CoinLures[138957] = {
	["enUS"] = "Auriphagic Sardine",
	setting = "DalaranLures",
	spell = 217836,
	usable = CanUseCoinLure,
	ignore = true,
};
CoinLures[138960] = {
	["enUS"] = "Wish Crystal",
	setting = "DalaranLures",
	spell = 217839,
	usable = CanUseCoinLure,
	ignore = true,
};
CoinLures[138963] = {
	["enUS"] = "Tiny Little Grabbing Apparatus",
	setting = "DalaranLures",
	spell = 217844,
	usable = CanUseCoinLure,
	ignore = true,
};
CoinLures[138958] = {
	["enUS"] = "Glob of Really Sticky Glue",
	setting = "DalaranLures",
	spell = 217837,
	usable = CanUseCoinLure,
	ignore = true,
};

local function SetupCoinLures()
	for id,info in pairs(CoinLures) do
		FishingItems[id] = info;
	end
end

local seascorpion = {
	["Shadowmoon Valley (Draenor)"] = {
		["Darktide Strait"] = true,
		["The Evanescent Sea"] = true,
		["Karabor Harbor"] = true,
		["Tanaan Channel"] = true,
	},
	["Gorgrond"] = {
		["Colossal Depths"] = true,
		["Barrier Sea"] = true,
		["Iron Sea"] = true,
		["Orunai Coast"] = true,
	},
	["Talador"] = {
		["Aarko's Estate"] = true,
		["Orunai Delta"] = true,
		["The South Sea"] = true,
		["Sha'tari Anchorage"] = true,
		["Shattrath Port Authority"] = true,
		["Beacon of Sha'tar"] = true,
		["The Sunset Shore"] = true,
		["Orunai Bay"] = true,
		["Orunai Coast"] = true,
	},
	["Frostfire Ridge"] = {
		["Colossal Depths"] = true,
		["Frostboar Point"] = true,
		["Frostbite Deep"] = true,
		["Southwind Inlet"] = true,
		["Ata'gar Promontory"] = true,
		["Tor'goroth's Tooth"] = true,
		["Cold Snap Coast"] = true,
		["Zangar Sea"] = true,
		["Frostangler Bay"] = true,
		["Southwind Cliffs"] = true,
		["The Pale Cove"] = true,
		["Throm'var Landing"] = true,
		["Glacier Bay"] = true,
		["Ozgor's Launch"] = true,
		["Iron Sea"] = true,
	},
	["Nagrand (Draenor)"] = {
		["The Colossal's Fist"] = true,
		["Lernaen Shore"] = true,
		["Zangar Shore"] = true,
		["Cerulean Lagoon"] = true,
		["Ironfist Harbor"] = true,
		["Zangar Sea"] = true,
		["Windroc Bay"] = true,
		["The South Sea"] = true,
		["The Cliffs of Highmaul"] = true,
		["Highmaul Harbor"] = true,
	},
	["Tanaan Jungle"] = {
		["Tanaan Channel"] = true,
		["Barrier Sea"] = true,
	},
	["Spires of Arak"] = {
		["Pinchwhistle Gearworks"] = true,
		["Echidnean Shelf"] = true,
		["The South Sea"] = true,
		["Wreck of the Mother Lode"] = true,
		["The Writhing Mire"] = true,
		["Southport"] = true,
		["Bloodmane Pridelands"] = true,
		["The Evanescent Sea"] = true,
	},
};

local function CurrentSpecialBait()
	local continent = GetCurrentMapContinent();
	local baits = SpecialBait[continent];
	if (baits) then
		for _,id in ipairs(baits) do
			local bait = FishingItems[id];
			if (bait and FL:HasBuff(GetSpellInfo(bait.spell))) then
				return id;
			end
		end
	end
	-- return nil
end

local function CheckSpecialBait(info, buff, need)
	local continent = GetCurrentMapContinent();
	if (SpecialBait[continent]) then
		if ( GSB("DraenorBaitMaintainOnly") and LastSpecialBait ) then
			return true, LastSpecialBait;
		elseif (not FL:HasBuff(GetSpellInfo(info.spell))) then
			return true, info.id;
		end
	end
end

local function VerifySpecialBait(info, checkscorpion)
	if (not IsQuestFishing()) then
		if (GSB("EasyLures") and GSB("DraenorBait")) then
			local continent = GetCurrentMapContinent();
			if ( GSB("DraenorBaitMaintainOnly") ) then
				local baitid = CurrentSpecialBait();
				if ( not baitid and LastSpecialBait ) then
					if (GetItemCount(LastSpecialBait) > 0) then
						return true;
					end
				else
					LastSpecialBait = baitid;
				end
			elseif (continent == 7 ) then
				local zone, subzone = FL:GetBaseZoneInfo();
				if ( checkscorpion ) then
					return (seascorpion[zone] and seascorpion[zone][subzone]);
				elseif ( zone == info.zone) then
					return not seascorpion[zone][subzone];
				end
			end
		end
	end
	-- return nil;
end

local function UseSeaScorpionBait(info)
	return VerifySpecialBait(info, true);
end


local function UsableSpecialBait(info)
	return VerifySpecialBait(info, false);
end

-- Blind Lake Sturgeon, 158035
FishingItems[110290] = {
	["enUS"] = "Blind Lake Sturgeon Bait",
	spell = 158035,
	zone = "Shadowmoon Valley (Draenor)",
	usable = UsableSpecialBait,
	check = CheckSpecialBait,
};
FishingItems[110293] = {
	["enUS"] = "Abyssal Gulper Eel Bait",
	spell = 158038,
	zone = "Spires of Arak",
	usable = UsableSpecialBait,
	check = CheckSpecialBait,
};
FishingItems[110294] = {
	["enUS"] = "Blackwater Whiptail Bait",
	spell = 158039,
	zone = "Talador",
	usable = UsableSpecialBait,
	check = CheckSpecialBait,
};
FishingItems[110289] = {
	["enUS"] = "Fat Sleeper Bait",
	spell = 158034,
	zone = "Nagrand (Draenor)",
	usable = UsableSpecialBait,
	check = CheckSpecialBait,
};
FishingItems[110291] = {
	["enUS"] = "Fire Ammonite Bait",
	spell = 158036,
	zone = "Frostfire Ridge",
	usable = UsableSpecialBait,
	check = CheckSpecialBait,
};
FishingItems[110274] = {
	["enUS"] = "Jawless Skulker Bait",
	spell = 158031,
	zone = "Gorgrond",
	usable = UsableSpecialBait,
	check = CheckSpecialBait,
};
FishingItems[128229] = {
	["enUS"] = "Felmouth Frenzy Bait",
	spell = 188904,
	zone = "Tanaan Jungle",
	usable = UsableSpecialBait,
	check = CheckSpecialBait,
};

FishingItems[110292] = {
	["enUS"] = "Sea Scorpion Bait",
	spell = 158037,
	zone = "Non-inland water",
	usable = UseSeaScorpionBait,
	check = CheckSpecialBait,
};

FishingItems[139175] = {
	["enUS"] = "Arcane Lure",
	spell = 218861,
	usable = UsableSpecialBait,
	check = CheckSpecialBait,
};

FishingBuddy.FishingItems = FishingItems;

local FluffOptions = {
	["FishingFluff"] = {
		["text"] = FBConstants.CONFIG_FISHINGFLUFF_ONOFF,
		["tooltip"] = FBConstants.CONFIG_FISHINGFLUFF_INFO,
		["v"] = 1,
		["m1"] = 1,
		["p"] = 1,
		["default"] = true
	},
	["FindFish"] = {
		["text"] = FBConstants.CONFIG_FINDFISH_ONOFF,
		["tooltip"] = FBConstants.CONFIG_FINDFISH_INFO,
		["v"] = 1,
		["m"] = 1,
		["parents"] = { ["FishingFluff"] = "d" },
		["default"] = true
	},
	[PETSETTING] = {
		["tooltip"] = FBConstants.CONFIG_FISHINGBUDDY_INFO,
		["setup"] =
			function()
				UpdateChosenPets();
			end,
		["visible"] =
			function(option)
				local numPets, numOwned = C_PetJournal.GetNumPets(false);
				if (numOwned > 0) then return 1; end;
			end,
		["button"] = "FishingPetFrame",
		["margin"] = { 4, 4 },
		["parents"] = { ["FishingFluff"] = "h", },
		["default"] = PET_FISHING,
	},
	["DrinkHeavily"] = {
		["text"] = FBConstants.CONFIG_DRINKHEAVILY_ONOFF,
		["tooltip"] = FBConstants.CONFIG_DRINKHEAVILY_INFO,
		["v"] = 1,
		["m"] = 1,
		["parents"] = { ["FishingFluff"] = "d" },
		["default"] = true
	},
};

local RaftOptions = {
	["enUS"] = "Angler's Fishing Raft",
	["tooltip"] = FBConstants.CONFIG_FISHINGRAFT_INFO,
	itemid = 85500;
	spell = 124036,
	toy = 1,
	always = 1, -- this is now a toy!
	setting = "UseAnglersRaft",
	usable = RaftBergUsable,
	check = RaftBergCheck,
	["default"] = true,
	["option"] = {
		["setting"] = "BergMaintainOnly",
		["text"] = FBConstants.CONFIG_MAINTAINRAFTBERG_ONOFF,
		["tooltip"] = FBConstants.CONFIG_MAINTAINRAFT_INFO,
		["default"] = true,
	},
};
local BergOptions = {
	["enUS"] = "Bipsi's Bobbing Berg",
		-- Don't cast the angler's raft if we're doing Scavenger Hunt or on Inkgill Mere
	["tooltip"] = FBConstants.CONFIG_BOBBINGBERG_INFO,
	itemid = 107950;
	spell = 152421,
	setting = "UseBobbingBerg",
	usable = RaftBergUsable,
	check = RaftBergCheck,
	["default"] = true,
	["option"] = {
		["setting"] = "BergMaintainOnly",
		["text"] = FBConstants.CONFIG_MAINTAINRAFTBERG_ONOFF,
		["tooltip"] = FBConstants.CONFIG_MAINTAINBERG_INFO,
		["default"] = true,
	},
};

local function PickRaft(info, buff, need, itemid)
	local bergbuff = GetSpellInfo(BergOptions.spell);
	local raftbuff = GetSpellInfo(RaftOptions.spell);
	local hasberg = FL:HasBuff(bergbuff);
	local hasraft = FL:HasBuff(raftbuff);
	
	need = not (hasberg or hasraft);
	
	-- if we need it, but we're maintaining only, skip it
	if (GSB("BergMaintainOnly") and need) then
		return false;
	end

	local it = nil;
	if (not hasraft and GSB("UseBobbingBerg")) then
		buff = bergbuff;
		itemid = BergOptions.itemid;
	else
		buff = raftbuff;
		_, itemid = C_ToyBox.GetToyInfo(RaftOptions.itemid)
		-- it = "item"
	end

	local _, _, _, _, _, _, et, _, _, _, _ = UnitBuff("player", buff);
	et = (et or 0) - GetTime();
	if (need or et <= RAFT_RESET_TIME) then
		return true, itemid, it;
	end
	--return nil;
end

local function HandleRaftItems()
	local haveRaft = PlayerHasToy(RaftOptions.itemid);
	local haveBerg = GetItemCount(BergOptions.itemid);

	if (haveRaft and haveBerg) then
		-- if we have both, be smarter about rafts
		FluffOptions["UseRaft"] = {
			["text"] = FBConstants.CONFIG_USERAFTS_ONOFF,
			["tooltip"] = FBConstants.CONFIG_USERAFTS_INFO,
			["v"] = 1,
			["default"] = true
		};
		FluffOptions["BergMaintainOnly"] = {
			["text"] = FBConstants.CONFIG_MAINTAINRAFTBERG_ONOFF,
			["tooltip"] = FBConstants.CONFIG_MAINTAINRAFT_INFO,
			["v"] = 1,
			["default"] = true,
			["parents"] = { ["UseRaft"] = "d", },
		};
		FluffOptions["UseBobbingBerg"] = {
			["text"] = FBConstants.CONFIG_BOBBINGBERG_ONOFF,
			["tooltip"] = FBConstants.CONFIG_BOBBINGBERG_INFO,
			["v"] = 1,
			["default"] = true,
			["parents"] = { ["UseRaft"] = "d", },
		};
		
		FishingItems[RaftOptions.itemid] = {
			setting = "UseRaft",
			ignore = 1,
			spell = 124036,
			always = 1,
			usable = RaftBergUsable,
			check = PickRaft,
		};
	elseif (haveRaft) then
		-- if we just have one or the other, then use our regular item option
		FishingItems[RaftOptions.itemid] = RaftOptions;
	else
		FishingItems[BergOptions.itemid] = BergOptions;
	end
end

local function ItemInit(option, button)
	local n, _, _, _, _, _, _, _,_, _ = GetItemInfo(option.id);
	if (n) then
		option.text = n;
	else
		option.text = option.enUS;
	end
end

local function ItemVisible(option)
	return GetItemCount(option.id) > 0;
end

local function UpdateItemOptions()
	for id,info in pairs(FishingItems) do
		info.id = id;
		if (info.setting and not info.ignore) then
			local option = {};

			option.id = id;
			option.enUS = info.enUS;

			if (info.visible) then
				option.visible = info.visible;
			else
				option.visible = ItemCountVisible;
			end
		
			option.init = ItemInit;

			option.tooltip = info.tooltip;
			option.setup = info.setup;
			option.enabled = info.enabled;
			option.default = info.default;

			option.v = 1;
			-- option.deps = { ["FishingFluff"] = "d" };
			FluffOptions[info.setting] = option;

			if (info.option) then
				local sub = {};
				sub.text = info.option.text;
				sub.tooltip = info.option.tooltip;
				sub.default = info.option.default;
				sub.visible = option.visible;
				sub.v = 1;
				sub.parents = {};
				sub.parents[info.setting] = "d";
				FluffOptions[info.option.setting] = sub;
			end
		end
	end
	
	FishingBuddy.FluffOptions = FluffOptions;
end

FluffEvents["VARIABLES_LOADED"] = function(started)
	local pet = FishingBuddy.GetSetting(PETSETTING);

	FishingPetFrame:SetScript("OnHide", FishingPetFrame_OnHide);
	FishingPetFrameButton:SetScript("OnClick", FishingPetsMenu_Toggle);
	
	local menuwidth = 0;
	for _,text in pairs( { NONE, ALL, PET_FISHING, PET_PAPERDOLL } ) do
		FishingPetFrameText:SetText(text);
		if (FishingPetFrameText:GetWidth() > menuwidth) then
			menuwidth = FishingPetFrameText:GetWidth();
		end
	end
	
	FishingPetsMenu:SetWidth(menuwidth + 8);
	FishingPetsMenu:SetHeight(FLUFF_DISPLAYED_PETS * FLUFF_LINE_HEIGHT + 1);
	HybridScrollFrame_CreateButtons(FishingPetsMenu, "FishingPetButtonTemplate");
	
	HandlePetsUpdate();
	LibPetJournal.RegisterCallback(FBConstants.ID, "PetListUpdated", HandlePetsUpdate)

	FishingPetFrameLabel:SetText(PET_TYPE_PET..": ");
	
	UIDropDownMenu_SetWidth(FishingPetFrame, menuwidth + 32);
	FishingPetFrame:SetHeight(32);
	
	FishingPetsMenu:SetWidth(210);
	FishingPetsMenuHolder:ClearAllPoints();
	FishingPetsMenuHolder:SetPoint("TOP", FishingPetFrameButton, "BOTTOM", 0, 8);
	FishingPetsMenuHolder:Hide();

	SetupCoinLures();

	-- we have to wait until the toys are actually available
	local toydelayframe = CreateFrame("Frame");
	toydelayframe:Hide();

	toydelayframe:SetScript("OnUpdate", function(self, ...)
			HandleRaftItems();
			UpdateItemOptions();
			FishingBuddy.OptionsFrame.HandleOptions(FBConstants.CONFIG_FISHINGFLUFF_ONOFF, "Interface\\Icons\\inv_misc_food_164_fish_seadog", FluffOptions);
			-- FishingBuddy.OptionsFrame.HandleOptions(nil, nil, FluffInvisible);
			self:Hide();
		end);
	toydelayframe:Show();
end

FishingBuddy.RegisterHandlers(FluffEvents);

if ( FishingBuddy.Debugging ) then
	local function DumpChosen()
		UpdateChosenPets();
		local Debug = FishingBuddy.Debug;
		local pets = FishingPetFrame.petnames;
		local n = FL:tablecount(chosenpets);
		Debug("chosenpets "..n.." "..#ourpets.." "..#pets);
		for idx=1,#chosenpets do
			Debug("petid "..chosenpets[idx])
		end
	end
	
	FishingBuddy.Commands["pets"] = {};
	FishingBuddy.Commands["pets"].func =
		function(what)
			DumpChosen();
			return true;
		end

	FishingBuddy.SeaScorpion = seascorpion;
	
	FishingBuddy.CurrentSpecialBait = CurrentSpecialBait;
end

function fixthis()
	-- Update the pet settings
	if ( version < 10001 ) then
		local pets = FishingBuddy_Player["FishingPetBuddies"];
		if (pets) then
			local newpets = {};
			local n = GetNumCompanions("CRITTER");
			for id=1,n do
				local cID, cName, cSpellID, icon, here = GetCompanionInfo("CRITTER", id);
				if ( pets[cSpellID] ) then
					newpets[cID] = 1;
				end
			end
			FishingBuddy_Player["FishingPetBuddies"] = newpets;
		end
	end
end