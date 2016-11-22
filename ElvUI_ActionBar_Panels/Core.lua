local E, L, V, P, G, _ =  unpack(ElvUI);
local DT = E:GetModule('DataTexts')
local Mm = E:GetModule('Minimap')
local DTB = E:GetModule('ActionBarPanels')
local M = E:GetModule('Misc');

local addon = select(1,...)
local EP = LibStub("LibElvUIPlugin-1.0")

E.Minimap = Mm;

ElvUI_ActionBarPanels = CreateFrame('Frame', "ElvUI_ActionBarPanels", E.UIParent)
ElvUI_ActionBarPanels.version = '2.0'
--------------------------------------------------------
-- System Settable Variables
--------------------------------------------------------
local top_bar, ActionBarPanelOne, rep_bar, lchat_tab
local RightChat_Panel, RightChat_Panel2, ActionBarPanel_Two, ActionBarPanel_Three, ActionBarPanel_Four
--------------------------------------------------------
-- Language Variables
--------------------------------------------------------
L['Top_DataBar'] = 'Top Datatext';
L['ActionBarPanelOne'] = 'ActionBar Panel One';
L['RepDataBar'] = 'Rep Datatext';
L['LeftChatDataBar'] = 'Left Chat Tab';
L['RightChatDatatextPanel'] = 'Right Chat Tab';
L['RightChatDatatextPanel2'] = 'Right Chat Tab 2';
L['ActionBarPanelTwo'] = 'ActionBar Panel Two';
L['ActionBarPanelThree'] = 'ActionBar Panel Three';
L['ActionBarPanelFour'] = 'ActionBar Panel Four';
--------------------------------------------------------
-- Top Bar
--------------------------------------------------------
db = db or {}
top_bar = CreateFrame('Frame', 'Top_DataBar', E.UIParent)
top_bar.db = { key='Top_DataBar', value = true }
DT:RegisterPanel(top_bar, 3, 'ANCHOR_BOTTOM', 0, -4)
function TopBarDP()
	top_bar:Point("TOP", E.UIParent, "TOP", 0, -E.mult)
	top_bar:SetFrameStrata('LOW')
	top_bar:SetScript('OnShow', function(self) 
		E:CreateMover(self, "TopBarMover", "Top Datatext Frame") 
	end)
	top_bar:Hide()
end

--------------------------------------------------------
-- Bottom Bar
--------------------------------------------------------
ActionBarPanelOne = CreateFrame('Frame', 'ActionBarPanelOne', E.UIParent)
ActionBarPanelOne.db = {key ='ActionBarPanelOne', value = true}
DT:RegisterPanel(ActionBarPanelOne, 3, 'ANCHOR_BOTTOM', 0, -4)
function BottomBarDP()
	ActionBarPanelOne:SetFrameStrata('HIGH')
	ActionBarPanelOne:SetFrameLevel(1)
	ActionBarPanelOne:Point("TOP", ElvUI_Bar2, "BOTTOM", 0, -E.mult);
	ActionBarPanelOne:SetScript('OnShow', function(self) 
		E:CreateMover(self, "BottomBarMover", "ActionBar Panel One") 
	end)
	ActionBarPanelOne:Hide()
end
--------------------------------------------------------
-- Rep Bar 
--------------------------------------------------------
local function rep_bar_setup()
	rep_bar:HookScript('OnUpdate', function() 
		local parent_alpha = ElvUI_ReputationBar:GetAlpha()
		if rep_bar:GetAlpha() ~= parent_alpha then rep_bar:SetAlpha( parent_alpha) end
	end )
end

rep_bar = CreateFrame('Frame', 'RepDataBar', E.UIParent)
rep_bar.db = {key='RepDataBar', value = true}
DT:RegisterPanel(rep_bar, 1, 'ANCHOR_BOTTOM', 0, -4)
function RepBarDP()
	rep_bar:Point("TOPLEFT", ElvUI_ReputationBar, "BOTTOMLEFT", 0, -E.mult)
	rep_bar:Point("TOPLEFT", ElvUI_ReputationBar, "BOTTOMLEFT", 0, -E.mult); 
	rep_bar:SetFrameStrata('BACKGROUND')
	rep_bar:Hide()
	rep_bar:SetHeight(22)
	
end
--------------------------------------------------------
-- Left Chat Tab
--------------------------------------------------------
local function lchat_tab_setup()
	do
		lchat_tab:Size(LeftChatTab:GetWidth() / 3, 22)
		lchat_tab:Point("TOPRIGHT", LeftChatTab, "TOPRIGHT", 0, -E.mult)
		lchat_tab:SetFrameStrata('LOW')
		LeftChatTab:HookScript("OnHide", function() lchat_tab:Hide() end)
		LeftChatTab:HookScript("OnShow", function() lchat_tab:Show() end)
	end
end

do
	lchat_tab = CreateFrame('Frame', 'LeftChatDataBar', E.UIParent)
	lchat_tab.db = {key='LeftChatDataBar', value = true}
	DT:RegisterPanel(lchat_tab, 1, 'ANCHOR_BOTTOM', 0, -4)
	lchat_tab:Hide()
end
--------------------------------------------------------
-- Right Chat Tab 1
--------------------------------------------------------
local function RightChat_Panel_setup()
	do
		RightChat_Panel:Size(RightChatPanel:GetWidth() /3, 19)
		RightChat_Panel:Point("RIGHT", RightChatDatatextPanel2, "LEFT")
		RightChat_Panel:SetFrameStrata('LOW')

		RightChat_Panel2:Size((RightChatPanel:GetWidth() / 3), 19)
		RightChat_Panel2:Point("TOPRIGHT", RightChatTab, "TOPRIGHT", 0, -1) --DecUI Legion change
		RightChat_Panel2:SetFrameStrata('LOW')
		RightChatTab:HookScript("OnHide", function() 
			RightChat_Panel:Hide() 
			RightChat_Panel2:Hide() 
		end)
		RightChatTab:HookScript("OnShow", function() 
			RightChat_Panel:Show() 
			RightChat_Panel:SetAlpha(RightChatTab:GetAlpha()) 
			RightChat_Panel2:Show() 
			RightChat_Panel2:SetAlpha(RightChatTab:GetAlpha()) 
		end)
	end
end

do
	RightChat_Panel = CreateFrame('Frame', 'RightChatDatatextPanel', E.UIParent)
	RightChat_Panel.db ={key='RightChatDatatextPanel', value = true}
	DT:RegisterPanel(RightChat_Panel, 1, 'ANCHOR_BOTTOM', 0, -4)
	RightChat_Panel:Hide()
end
--------------------------------------------------------
-- Right Chat Tab 2
--------------------------------------------------------
do
	RightChat_Panel2 = CreateFrame('Frame', 'RightChatDatatextPanel2', E.UIParent)
	RightChat_Panel2.db = {key='RightChatDatatextPanel2', value = true}
	DT:RegisterPanel(RightChat_Panel2, 1, 'ANCHOR_BOTTOM', 0, -4)
	RightChat_Panel2:Hide()
end
--------------------------------------------------------
--ExtraOne
--------------------------------------------------------
	ActionBarPanel_Two = CreateFrame('Frame', 'ActionBarPanelTwo', E.UIParent)
	ActionBarPanel_Two.db = { key='ActionBarPanelTwo', value = true }
	function ActionBarPanelTwoDP()
		ActionBarPanel_Two:SetFrameStrata('HIGH')
		ActionBarPanel_Two:SetFrameLevel(1)
		ActionBarPanel_Two:Point("TOPLEFT", ElvUI_Bar5, "BOTTOMLEFT", 1, -E.mult);
		ActionBarPanel_Two:SetScript('OnShow', function(self)
			E:CreateMover(ActionBarPanel_Two, "ExtraOneMover", "ActionBar Panel Two")
		end)
		ActionBarPanel_Two:Hide()
	end
--------------------------------------------------------
--ExtraTwo
--------------------------------------------------------
	ActionBarPanel_Three = CreateFrame('Frame', 'ActionBarPanelThree', E.UIParent)
	ActionBarPanel_Three.db = { key='ActionBarPanelThree', value = true }
	function ActionBarPanelThreeDP()
		ActionBarPanel_Three:SetFrameStrata('HIGH')
		ActionBarPanel_Three:SetFrameLevel(1)
		ActionBarPanel_Three:Point("TOPLEFT", ElvUI_Bar3, "BOTTOMLEFT", 1, -E.mult);
		ActionBarPanel_Three:SetScript('OnShow', function(self)
			E:CreateMover(ActionBarPanel_Three, "ExtraTwoMover", "ActionBar Panel Three")
		end)
		ActionBarPanel_Three:Hide()
	end
--------------------------------------------------------
--ExtraThree
--------------------------------------------------------
	ActionBarPanel_Four = CreateFrame('Frame', 'ActionBarPanelFour', E.UIParent)
	ActionBarPanel_Four.db = { key='ActionBarPanelFour', value = true }
	function ActionBarPanelFourDP()
		ActionBarPanel_Four:SetFrameStrata('HIGH')
		ActionBarPanel_Four:SetFrameLevel(1)
		ActionBarPanel_Four:Point("TOPLEFT", MMHolder, "BOTTOMLEFT", 0, -24);
		ActionBarPanel_Four:SetScript('OnShow', function(self)
			E:CreateMover(ActionBarPanel_Four, "ExtraThreeMover", "ActionBar Panel Four")
		end)
		ActionBarPanel_Four:Hide()
	end
--------------------------------------------------------
--Updating Frames
--------------------------------------------------------
function DT:UpdateFrames()
	DT:FramesVisibility()
	DT:FramesSize()
	DT:PetBattleHide()
	DT:SnapMiniMap()
	DT:MouseOver()
	DTB:ChangeTemplate()
end

function DT:MouseOver()

	if E.db.datatexts.ActionBarPanels.Top_DataBar.MouseOver then
		top_bar:SetScript("OnUpdate", function (self,event,...)
			if MouseIsOver(Top_DataBar) then
				top_bar:SetAlpha(1)
			else
				top_bar:SetAlpha(0)
			end
		end)
	end

	if not E.db.datatexts.ActionBarPanels.Top_DataBar.MouseOver then
		top_bar:SetScript("OnUpdate", nil)
		top_bar:SetAlpha(1)	
	end

	if E.db.datatexts.ActionBarPanels.ActionBarPanelOne.MouseOver then
		ActionBarPanelOne:SetScript("OnUpdate", function (self,event,...)
			if MouseIsOver(ActionBarPanelOne) then
				ActionBarPanelOne:SetAlpha(1)
			else
				ActionBarPanelOne:SetAlpha(0)
			end
		end)
	end

	if not E.db.datatexts.ActionBarPanels.ActionBarPanelOne.MouseOver then
		ActionBarPanelOne:SetScript("OnUpdate", nil)
		ActionBarPanelOne:SetAlpha(1)
	end

	if E.db.datatexts.ActionBarPanels.RepDataBar.MouseOver then
		rep_bar:SetScript("OnUpdate", function (self,event,...)
			if MouseIsOver(RepDataBar) then
				rep_bar:SetAlpha(1)
			else
				rep_bar:SetAlpha(0)
			end
		end)
	end

	if not E.db.datatexts.ActionBarPanels.RepDataBar.MouseOver then
		rep_bar:SetScript("OnUpdate", nil)
		rep_bar:SetAlpha(1)
	end

	if E.db.datatexts.ActionBarPanels.ActionBarPanelTwo.MouseOver then
		ActionBarPanel_Two:SetScript("OnUpdate", function (self,event,...)
			if MouseIsOver(ActionBarPanelTwo) then
				ActionBarPanel_Two:SetAlpha(1)
			else
				ActionBarPanel_Two:SetAlpha(0)
			end
		end)
	end

	if not E.db.datatexts.ActionBarPanels.ActionBarPanelTwo.MouseOver then
		ActionBarPanel_Two:SetScript("OnUpdate", nil)
		ActionBarPanel_Two:SetAlpha(1)
	end

	if E.db.datatexts.ActionBarPanels.ActionBarPanelThree.MouseOver then
		ActionBarPanel_Three:SetScript("OnUpdate", function (self,event,...)
			if MouseIsOver(ActionBarPanelThree) then
				ActionBarPanel_Three:SetAlpha(1)
			else
				ActionBarPanel_Three:SetAlpha(0)
			end
		end)
	end

	if not E.db.datatexts.ActionBarPanels.ActionBarPanelThree.MouseOver then
		ActionBarPanel_Three:SetScript("OnUpdate", nil)
		ActionBarPanel_Three:SetAlpha(1)
	end

	if E.db.datatexts.ActionBarPanels.ActionBarPanelFour.MouseOver then
		ActionBarPanel_Four:SetScript("OnUpdate", function (self,event,...)
			if MouseIsOver(ActionBarPanelFour) then
				ActionBarPanel_Four:SetAlpha(1)
			else
				ActionBarPanel_Four:SetAlpha(0)
			end
		end)
	end

	if not E.db.datatexts.ActionBarPanels.ActionBarPanelFour.MouseOver then
		ActionBarPanel_Four:SetScript("OnUpdate", nil)
		ActionBarPanel_Four:SetAlpha(1)
	end
end

function DT:YPoints()
	local location = E:GetScreenQuadrant(ElvUI_ReputationBar)
	if location == "TOP" then
	print("Top Screen")
		rep_bar:Point("TOPLEFT", ElvUI_ReputationBar, "BOTTOMLEFT", 0, -E.mult)
	elseif location == "BOTTOM" then
	print("Bottom Screen")
		rep_bar:Point("BOTTOMLEFT", ElvUI_ReputationBar, "TOPLEFT", 0, -E.mult)
	end
end

function DT:SetTemplate()
	if E.db.datatexts.ActionBarPanels.Top_DataBar.Template == "DEFAULT" then
		Top_DataBar:SetTemplate('Default', true)
	elseif E.db.datatexts.ActionBarPanels.Top_DataBar.Template == "TRANSPARENT" then
		Top_DataBar:SetTemplate('Transparent', true)
	elseif E.db.datatexts.ActionBarPanels.Top_DataBar.Template == "CColor" then
		Top_DataBar:SetTemplate('ClassColor', true)
	end

	if E.db.datatexts.ActionBarPanels.ActionBarPanelOne.Template == "DEFAULT" then
		ActionBarPanelOne:SetTemplate('Default', true)
	elseif E.db.datatexts.ActionBarPanels.ActionBarPanelOne.Template == "TRANSPARENT" then
		ActionBarPanelOne:SetTemplate('Transparent', true)
	elseif E.db.datatexts.ActionBarPanels.ActionBarPanelOne.Template == "CColor" then
		ActionBarPanelOne:SetTemplate('ClassColor', true)
	end

	if E.db.datatexts.ActionBarPanels.RepDataBar.Template == "DEFAULT" then
		RepDataBar:SetTemplate('Default', true)
	elseif E.db.datatexts.ActionBarPanels.RepDataBar.Template == "TRANSPARENT" then
		RepDataBar:SetTemplate('Transparent', true)
	elseif E.db.datatexts.ActionBarPanels.RepDataBar.Template == "CColor" then
		RepDataBar:SetTemplate('ClassColor', true)
	end

	if E.db.datatexts.ActionBarPanels.ActionBarPanelTwo.Template == "DEFAULT" then
		ActionBarPanelTwo:SetTemplate('Default', true)
	elseif E.db.datatexts.ActionBarPanels.ActionBarPanelTwo.Template == "TRANSPARENT" then
		ActionBarPanelTwo:SetTemplate('Transparent', true)
	elseif E.db.datatexts.ActionBarPanels.ActionBarPanelTwo.Template == "CColor" then
		ActionBarPanelTwo:SetTemplate('ClassColor', true)
	end

	if E.db.datatexts.ActionBarPanels.ActionBarPanelThree.Template == "DEFAULT" then
		ActionBarPanelThree:SetTemplate('Default', true)
	elseif E.db.datatexts.ActionBarPanels.ActionBarPanelThree.Template == "TRANSPARENT" then
		ActionBarPanelThree:SetTemplate('Transparent', true)
	elseif E.db.datatexts.ActionBarPanels.ActionBarPanelThree.Template == "CColor" then
		ActionBarPanelThree:SetTemplate('ClassColor', true)
	end

	if E.db.datatexts.ActionBarPanels.ActionBarPanelFour.Template == "DEFAULT" then
		ActionBarPanelFour:SetTemplate('Default', true)
	elseif E.db.datatexts.ActionBarPanels.ActionBarPanelFour.Template == "TRANSPARENT" then
		ActionBarPanelFour:SetTemplate('Transparent', true)
	elseif E.db.datatexts.ActionBarPanels.ActionBarPanelFour.Template == "CColor" then
		ActionBarPanelFour:SetTemplate('ClassColor', true)
	end
end

function DT:FramesVisibility()
	if E.db.datatexts.ActionBarPanels.Top_DataBar.Enabled then
		top_bar:Show()
	else
		top_bar:Hide()
	end

	if E.db.datatexts.ActionBarPanels.ActionBarPanelOne.Enabled then
		ActionBarPanelOne:Show()
	else
		ActionBarPanelOne:Hide()
	end

	if E.db.datatexts.ActionBarPanels.LeftChatDataBar.Enabled then
		lchat_tab:Show()
	else
		lchat_tab:Hide()
	end

	if E.db.datatexts.ActionBarPanels.RightChatDatatextPanel.Enabled then
		RightChat_Panel:Show()
		RightChat_Panel2:Show()
	else
		RightChat_Panel:Hide()
		RightChat_Panel2:Hide()
	end

	if E.db.datatexts.ActionBarPanels.RepDataBar.Enabled then
		if E.db.datatexts.ActionBarPanels.RepDataBar.MiniMapSnap or ElvUI_ReputationBar:IsShown() and not E.db.datatexts.ActionBarPanels.RepDataBar.MiniMapSnap then
			rep_bar:Show()
		elseif not ElvUI_ReputationBar:IsShown() then
			rep_bar:Hide()
		end
	else
		rep_bar:Hide()
end

	if E.db.datatexts.ActionBarPanels.ActionBarPanelTwo.Enabled then
		ActionBarPanel_Two:Show()
	else
		ActionBarPanel_Two:Hide()
	end

	if E.db.datatexts.ActionBarPanels.ActionBarPanelThree.Enabled then
		ActionBarPanel_Three:Show()
	else
		ActionBarPanel_Three:Hide()
	end

	if E.db.datatexts.ActionBarPanels.ActionBarPanelFour.Enabled then
		ActionBarPanel_Four:Show()
	else
		ActionBarPanel_Four:Hide()
	end
end

function DT:Watched()
	local name = GetWatchedFactionInfo()
	if not name and ElvUI_ReputationBar:IsShown() and E.db.datatexts.ActionBarPanels.RepDataBar.Enabled then
		rep_bar:Hide()
	else
		rep_bar:Show()
	end
end

function DT:FramesSize()
	top_bar:SetSize(E.db.datatexts.ActionBarPanels.Top_DataBar.Width, 19)
	ActionBarPanelOne:SetSize(E.db.datatexts.ActionBarPanels.ActionBarPanelOne.Width - 1, 19)
	ActionBarPanel_Two:SetSize(E.db.datatexts.ActionBarPanels.ActionBarPanelTwo.Width - 1, 19)
	ActionBarPanel_Three:SetSize(E.db.datatexts.ActionBarPanels.ActionBarPanelThree.Width - 1, 19)
	ActionBarPanel_Four:SetSize(E.db.datatexts.ActionBarPanels.ActionBarPanelFour.Width - 1, 19)
	DT:UpdateAllDimensions()
end

function DT:PetBattleHide()
	if E.db.datatexts.ActionBarPanels.Top_DataBar.PetBattleHide then
		E.FrameLocks["Top_DataBar"] = true
	else
		E.FrameLocks["Top_DataBar"] = nil
	end

	if E.db.datatexts.ActionBarPanels.ActionBarPanelOne.PetBattleHide then
		E.FrameLocks["ActionBarPanelOne"] = true
	else
		E.FrameLocks["ActionBarPanelOne"] = nil
	end

	if E.db.datatexts.ActionBarPanels.ActionBarPanelTwo.PetBattleHide then
		E.FrameLocks["ActionBarPanelTwo"] = true
	else
		E.FrameLocks["ActionBarPanelTwo"] = nil
	end

	if E.db.datatexts.ActionBarPanels.ActionBarPanelThree.PetBattleHide then
		E.FrameLocks["ActionBarPanelThree"] = true
	else
		E.FrameLocks["ActionBarPanelThree"] = nil
	end

	if E.db.datatexts.ActionBarPanels.ActionBarPanelFour.PetBattleHide then
		E.FrameLocks["ActionBarPanelFour"] = true
	else
		E.FrameLocks["ActionBarPanelFour"] = nil
	end

	if E.db.datatexts.ActionBarPanels.TopPanel.PetHide then
		E.FrameLocks["topPanel"] = true
		topPanel:SetFrameLevel(0)
		topPanel:SetFrameStrata('BACKGROUND')
	else
		E.FrameLocks["topPanel"] = nil
		topPanel:SetFrameLevel(0)
		topPanel:SetFrameStrata('BACKGROUND')
	end

	if E.db.datatexts.ActionBarPanels.BottomPanel.PetHide then
		E.FrameLocks["bottomPanel"] = true
		bottomPanel:SetFrameStrata('BACKGROUND')
		bottomPanel:SetFrameLevel(0)
	else
		E.FrameLocks["bottomPanel"] = true
		bottomPanel:SetFrameStrata('BACKGROUND')
		bottomPanel:SetFrameLevel(0)
	end
end

local function Panel_OnShow(self)
	self:SetFrameLevel(0)
	self:SetFrameStrata('BACKGROUND')
end

function DT:SnapMiniMap()
	if E.db.datatexts.ActionBarPanels.RepDataBar.MiniMapSnap then
		rep_bar:SetWidth(MMHolder:GetWidth())
		rep_bar:SetPoint("TOPLEFT", MMHolder, "BOTTOMLEFT", 0, -E.mult)
	else
		rep_bar:SetWidth(ElvUI_ReputationBar:GetWidth())
		rep_bar:Point("TOPLEFT", ElvUI_ReputationBar, "BOTTOMLEFT", 0, -E.mult)
	end
end
--------------------------------------------------------
--Initialize
--------------------------------------------------------
--DT.InitializeBar = DT.Initialize
function DTB:Initialize()
	TopBarDP()
	BottomBarDP()
	RepBarDP()
	ActionBarPanelTwoDP()
	ActionBarPanelThreeDP()
	ActionBarPanelFourDP()
	DT:FramesSize()
	DT:SetTemplate()
	DTB:createBottomPanel()
	DTB:createTopPanel()
	DTB:SetSize()
	DTB:ChangeTemplate()
	DTB:ShowPanels()
	rep_bar_setup()
	RightChat_Panel_setup()
	lchat_tab_setup()

	if E.db.datatexts.ActionBarPanels.ActionBarPanelOne.DataPlacements == 1 then
		DT:RegisterPanel(ActionBarPanel_One, 1, 'ANCHOR_BOTTOM', 0, -4)
	elseif E.db.datatexts.ActionBarPanels.ActionBarPanelOne.DataPlacements == 3 then
		DT:RegisterPanel(ActionBarPanel_One, 3, 'ANCHOR_BOTTOM', 0, -4)
	end

	if E.db.datatexts.ActionBarPanels.ActionBarPanelTwo.DataPlacements == 1 then
		DT:RegisterPanel(ActionBarPanel_Two, 1, 'ANCHOR_BOTTOM', 0, -4)
	elseif E.db.datatexts.ActionBarPanels.ActionBarPanelTwo.DataPlacements == 3 then
		DT:RegisterPanel(ActionBarPanel_Two, 3, 'ANCHOR_BOTTOM', 0, -4)
	end

	if E.db.datatexts.ActionBarPanels.ActionBarPanelThree.DataPlacements == 1 then
		DT:RegisterPanel(ActionBarPanel_Three, 1, 'ANCHOR_BOTTOM', 0, -4)
	elseif E.db.datatexts.ActionBarPanels.ActionBarPanelThree.DataPlacements == 3 then
		DT:RegisterPanel(ActionBarPanel_Three, 3, 'ANCHOR_BOTTOM', 0, -4)
	end

	if E.db.datatexts.ActionBarPanels.ActionBarPanelFour.DataPlacements == 1 then
		DT:RegisterPanel(ActionBarPanel_Four, 1, 'ANCHOR_BOTTOM', 0, -4)
	elseif E.db.datatexts.ActionBarPanels.ActionBarPanelFour.DataPlacements == 3 then
		DT:RegisterPanel(ActionBarPanel_Four, 3, 'ANCHOR_BOTTOM', 0, -4)
	end

	DT:UpdateFrames()
	DT:RegisterEvent("UPDATE_FACTION" , "FramesVisibility")
	EP:RegisterPlugin(addon, DTB.addOptions)
	-- hooksecurefunc(M, "EnableDisable_ReputationBar", DT.FramesVisibility)
end