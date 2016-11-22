local E, L, V, P, G, _ =  unpack(ElvUI);

local DTB = E:GetModule('ActionBarPanels')

local topPanel, bottomPanel

function DTB:createTopPanel()
	topPanel = CreateFrame('Frame', 'topPanel', E.UIParent)
	topPanel:SetPoint("TOPLEFT", E.UIParent, "TOPLEFT", -E.mult, E.mult)
	topPanel:SetPoint("TOPRIGHT", E.UIParent, "TOPRIGHT", E.mult, E.mult)
	topPanel:SetScript('OnShow', Panel_OnShow)
	topPanel:SetFrameStrata('BACKGROUND')
	topPanel:SetFrameLevel(0)
end

function DTB:createBottomPanel()
	bottomPanel = CreateFrame('Frame', 'bottomPanel', E.UIParent)
	bottomPanel:SetFrameStrata('BACKGROUND')
	bottomPanel:SetFrameLevel(0)
	bottomPanel:SetScript('OnShow', Panel_OnShow)
	bottomPanel:SetPoint("BOTTOMLEFT", E.UIParent, "BOTTOMLEFT", -E.mult, -E.mult)
	bottomPanel:SetPoint("BOTTOMRIGHT", E.UIParent, "BOTTOMRIGHT", E.mult, -E.mult)
end

local function Panel_OnShow(self)
	self:SetFrameLevel(0)
	self:SetFrameStrata('BACKGROUND')
end

function DTB:ChangeTemplate()

	if E.db.datatexts.ActionBarPanels.BottomPanel.Template == "DEFAULT" then
		bottomPanel:SetTemplate('Default', true)
	elseif E.db.datatexts.ActionBarPanels.BottomPanel.Template == "TRANSPARENT" then
		bottomPanel:SetTemplate('Transparent', true)
	elseif E.db.datatexts.ActionBarPanels.BottomPanel.Template == "CColor" then
		bottomPanel:SetTemplate('ClassColor', true)
	end

	if E.db.datatexts.ActionBarPanels.TopPanel.Template == "DEFAULT" then
		topPanel:SetTemplate('Default', true)
	elseif E.db.datatexts.ActionBarPanels.TopPanel.Template == "TRANSPARENT" then
		topPanel:SetTemplate('Transparent', true)
	elseif E.db.datatexts.ActionBarPanels.TopPanel.Template == "CColor" then
		topPanel:SetTemplate('ClassColor', true)
	end
end

function DTB:SetSize()
	topPanel:SetSize(E.UIParent:GetWidth() + (E.mult * 2), E.db.datatexts.ActionBarPanels.TopPanel.Height)
	bottomPanel:SetSize(E.UIParent:GetWidth() + (E.mult * 2), E.db.datatexts.ActionBarPanels.BottomPanel.Height)
end

function DTB:ShowPanels()
	if E.db.datatexts.ActionBarPanels.TopPanel.Enabled then
		topPanel:Show()
	else
		topPanel:Hide()
	end

	if E.db.datatexts.ActionBarPanels.BottomPanel.Enabled then
		bottomPanel:Show()
	else
		bottomPanel:Hide()
	end
end