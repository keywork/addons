local ldb = LibStub:GetLibrary("LibDataBroker-1.1")
local dataobj = ldb:NewDataObject("DarkmoonProfessional", {
	type = "launcher",
	icon = "Interface\\Icons\\INV_MISC_TOKEN_DARKMOON_01",
})

-- Faire Profession Quest Info
local questInfo = {
	[182] = {["questId"] = 29514}, -- Herbalism
	[186] = {["questId"] = 29518}, -- Mining
	[393] = {["questId"] = 29519}, -- Skinning
	[171] = {["questId"] = 29506}, -- Alchemy
	[164] = {["questId"] = 29508}, -- Blacksmithing
	[333] = {["questId"] = 29510}, -- Enchanting
	[202] = {["questId"] = 29511}, -- Engineering
	[773] = {["questId"] = 29515}, -- Inscription
	[755] = {["questId"] = 29516}, -- Jewelcrafting
	[165] = {["questId"] = 29517}, -- Leatherworking
	[197] = {["questId"] = 29520}, -- Tailoring
	[794] = {["questId"] = 29507}, -- Archaeology
	[185] = {["questId"] = 29509}, -- Cooking
	[129] = {["questId"] = 29512}, -- First Aid
	[356] = {["questId"] = 29513}, -- Fishing
	["Trophies"] = {["questId"] = 29433}, -- Kerri's Grisly Trophies
	["Moonfang"] = {["questId"] = 33354}, -- Den Mother's Demise
	["JFeasel"] = {["questId"] = 32175}, -- Jeremy Feasel's Battle Pet Daily
	["CFeasel"] = {["questId"] = 36471} -- Cristoph VonFeasel's Battle Pet Daily
}

-- string colors
local RED   = "|cffFF0000"
local GREEN = "|cff00FF00"
local YELGREEN  = "|cff7FFF00"
local YELLOW  = "|cffFFFF00"

-- Basic function to add colour to a string
local function AddColor(str,color)
	return color..str.."|r"
end

-- check to see if the Faire is active
local function CheckDarkmoonOpen()
	local i
	local _,_,today = CalendarGetDate()
	for i = 1,CalendarGetNumDayEvents(0,today) do
		local title = CalendarGetDayEvent(0, today, i)
		if title == CALENDAR_FILTER_DARKMOON then
			return true
		end
	end
	return false
end

local function GetItemName(itemId)
	local itemName = nil

	itemName, _, _, _, _, _, _, _ = GetItemInfo(itemId)

	if itemName == nil then
		return "Retreiving Item Name..."
	else
		return itemName
	end
end

local function GetQuestMatsText(skillId)
	local returnText
	local itemName
	local itemCount
	local itemMax
	
	if skillId == 171 then -- Alchemy
		itemName = GetItemName(1645)
		itemCount = GetItemCount(1645)
		itemMax = 5
		returnText = itemName.." ("
		if itemCount < itemMax then
			returnText = returnText..AddColor(itemCount.."/"..itemMax, RED )
		else
			returnText = returnText..AddColor(itemCount.."/"..itemMax, GREEN )
		end
		returnText = returnText..")"
		itemCount = GetItemCount(19299)
		itemMax = 5
		itemName = GetItemName(19299)
		returnText = returnText..", "..itemName.." ("
		if itemCount < itemMax then
			returnText = returnText..AddColor(itemCount.."/"..itemMax, RED )
		else
			returnText = returnText..AddColor(itemCount.."/"..itemMax, GREEN )
		end
		returnText = returnText..")"
	elseif skillId == 773 then -- Inscription
		itemName = GetItemName(39354)
		itemCount = GetItemCount(39354)
		itemMax = 5
		returnText = itemName.." ("
		if itemCount < itemMax then
			returnText = returnText..AddColor(itemCount.."/"..itemMax, RED )
		else
			returnText = returnText..AddColor(itemCount.."/"..itemMax, GREEN )
		end
		returnText = returnText..")"
	elseif skillId == 165 then -- Leatherworking
		itemName = GetItemName(2320)
		itemCount = GetItemCount(2320)
		itemMax = 5
		returnText = itemName.." ("
		if itemCount < itemMax then
			returnText = returnText..AddColor(itemCount.."/"..itemMax, RED )
		else
			returnText = returnText..AddColor(itemCount.."/"..itemMax, GREEN )
		end
		returnText = returnText..")"
		itemName = GetItemName(6260)
		itemCount = GetItemCount(6260)
		itemMax = 5
		returnText = returnText..", "..itemName.." ("
		if itemCount < itemMax then
			returnText = returnText..AddColor(itemCount.."/"..itemMax, RED )
		else
			returnText = returnText..AddColor(itemCount.."/"..itemMax, GREEN )
		end
		returnText = returnText..")"
		itemName = GetItemName(6529)
		itemCount = GetItemCount(6529)
		itemMax = 10
		returnText = returnText..", "..itemName.." ("
		if itemCount < itemMax then
			returnText = returnText..AddColor(itemCount.."/"..itemMax, RED )
		else
			returnText = returnText..AddColor(itemCount.."/"..itemMax, GREEN )
		end
		returnText = returnText..")"
	elseif skillId == 197 then -- Tailoring
		itemName = GetItemName(2320)
		itemCount = GetItemCount(2320)
		itemMax = 1
		returnText = itemName.." ("
		if itemCount < itemMax then
			returnText = returnText..AddColor(itemCount.."/"..itemMax, RED )
		else
			returnText = returnText..AddColor(itemCount.."/"..itemMax, GREEN )
		end
		returnText = returnText..")"
		itemName = GetItemName(6260)
		itemCount = GetItemCount(6260)
		itemMax = 1
		returnText = returnText..", "..itemName.." ("
		if itemCount < itemMax then
			returnText = returnText..AddColor(itemCount.."/"..itemMax, RED )
		else
			returnText = returnText..AddColor(itemCount.."/"..itemMax, GREEN )
		end
		returnText = returnText..")"
		itemName = GetItemName(2604)
		itemCount = GetItemCount(2604)
		itemMax = 1
		returnText = returnText..", "..itemName.." ("
		if itemCount < itemMax then
			returnText = returnText..AddColor(itemCount.."/"..itemMax, RED )
		else
			returnText = returnText..AddColor(itemCount.."/"..itemMax, GREEN )
		end
		returnText = returnText..")"
	elseif skillId == 794 then -- Archaeology
        itemName, itemCount, _, _, _, _, _, _ = GetCurrencyInfo(393)
		--itemName = itemName.." Fragment"
		itemMax = 15
		returnText = itemName.." ("
		if itemCount < itemMax then
			returnText = returnText..AddColor(itemCount.."/"..itemMax, RED )
		else
			returnText = returnText..AddColor(itemCount.."/"..itemMax, GREEN )
		end
		returnText = returnText..")"
	elseif skillId == 185 then -- Cooking
		itemName = GetItemName(30817)
		itemCount = GetItemCount(30817)
		itemMax = 5
		returnText = itemName.." ("
		if itemCount < itemMax then
			returnText = returnText..AddColor(itemCount.."/"..itemMax, RED )
		else
			returnText = returnText..AddColor(itemCount.."/"..itemMax, GREEN )
		end
		returnText = returnText..")"
	elseif skillId == "Trophies" then -- Grisly Trophies
		local _, _, _, itemCount, itemMax = GetQuestObjectiveInfo(29433, 1, false);

		itemName = GetItemName(71096)
		returnText = itemName.." ("
		if itemCount < itemMax then
			returnText = returnText..AddColor(itemCount.."/"..itemMax, RED )
		else
			returnText = returnText..AddColor(itemCount.."/"..itemMax, GREEN )
		end
		returnText = returnText..")"
	else
		return ""
	end
	return ": "..returnText
end

local function GetQuestText(skillId)
	local returnText
	local questData = questInfo[skillId]
	local _, _, questFinished, _, _ = GetQuestObjectiveInfo(questData["questId"], 1, false);

	if IsQuestFlaggedCompleted(questData["questId"]) then -- Returns nil if not complete.
		returnText = AddColor("Completed", GREEN )
	elseif questFinished == true then -- True if the quest is ready to hand in.
		returnText = AddColor("Ready to Hand In", YELGREEN )
	elseif GetQuestLogIndexByID(questData["questId"]) > 0 then -- 0 if not in log, otherwise log index
		returnText = AddColor("In Progress", YELLOW )
	else
		returnText = AddColor("Not Completed", RED )
	end
	
	return returnText
end

local function GetSkillText(key, index)
	local skillInfo = {}
	local returnTextL
	local returnTextR
	local questText
	local questMats = ""
	if index == nil then
		return key, AddColor("Not Learned", RED )
	else
		skillInfo["name"], _, skillInfo["rank"], skillInfo["maxRank"], _, _, skillInfo["skillLine"], _, _, _ = GetProfessionInfo(index)
		if skillInfo["rank"] < 75 then
			returnTextR = AddColor("Skill too Low", RED )
		else
			returnTextR = GetQuestText( skillInfo["skillLine"] )
			questMats = GetQuestMatsText( skillInfo["skillLine"] )
		end
		returnTextL = skillInfo["name"].." ("..skillInfo["rank"].."/"..skillInfo["maxRank"]..")"..questMats

		return returnTextL, returnTextR
	end

end

function dataobj:OnTooltipShow()
	local skills = {}
	local skillorder = {"Profession 1", "Profession 2", "Archaeology", "Fishing", "Cooking", "First Aid"}
	local tmpLeft
	local tmpRight

	skills["Profession 1"], skills["Profession 2"], skills["Archaeology"], skills["Fishing"], skills["Cooking"], skills["First Aid"] = GetProfessions()
	
	if CheckDarkmoonOpen() == true then
		self:AddLine("The Faire is currently "..AddColor("OPEN", GREEN ))
	else
		self:AddLine("The Faire is currently "..AddColor("CLOSED", RED ))
		--return
	end

	self:AddLine(" ") -- Just spacing it out a bit

	for _,value in ipairs(skillorder) do
		self:AddDoubleLine( GetSkillText( value, skills[ value ] ) )
	end

	self:AddLine(" ") -- Just spacing it out a bit

	tmpLeft = "Test Your Strength"..GetQuestMatsText( "Trophies" )
	tmpRight = GetQuestText( "Trophies" )
	self:AddDoubleLine( tmpLeft, tmpRight )

	tmpRight = GetQuestText( "Moonfang" )
	self:AddDoubleLine( "Den Mother's Demise", tmpRight )

	self:AddLine(" ") -- Just spacing it out a bit

	tmpRight = GetQuestText( "JFeasel" )
	self:AddDoubleLine( "Jeremy Feasel Pet Battle", tmpRight )

	tmpRight = GetQuestText( "CFeasel" )
	self:AddDoubleLine( "Cristoph VonFeasel Pet Battle", tmpRight )

end

function dataobj:OnEnter()
	GameTooltip:SetOwner(self, "ANCHOR_NONE")
	GameTooltip:SetPoint("TOPLEFT", self, "BOTTOMLEFT")
	GameTooltip:ClearLines()
	dataobj.OnTooltipShow(GameTooltip)
	GameTooltip:Show()
end

function dataobj:OnLeave()
	GameTooltip:Hide()
end
