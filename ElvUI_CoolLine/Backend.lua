local name, Backend = ...

ElvUICoolLineConfig = {}

Backend["Defaults"] = {
	["InactiveAlpha"] = 1.0,
	["ActiveAlpha"]   = 1.0,
	["Docking"]       = true,
	["Expand"]        = true,
}
Backend["Config"] = ElvUICoolLineConfig
Backend["CL"]     = CoolLine
Backend["CLDB"]   = CoolLineDB
Backend["Scale"]  = nil
Backend["IfConfig"] = nil
Backend["OnAddOnLoaded"] = nil
Backend["Addon"] = addon

function Backend:GetParent()
    return _G[self.Config.Parent]
end

function Backend:ShowOptions()
    if self.IfConfig() then
        SlashCmdList.COOLLINE()
    end
end

local confmt = {}
confmt.__index = function(tbl, key)
	return Backend.Defaults[key]
end
setmetatable(Backend.Config, confmt)

local addon = CreateFrame("Frame"); -- Need a frame to respond to events
addon:RegisterEvent("PLAYER_LOGIN");
addon:RegisterEvent("PLAYER_LOGOUT");

function addon:OnEvent(event)
	if event == "PLAYER_LOGIN" then
		for k, v in pairs(ElvUICoolLineConfig) do
			Backend.Config[k] = v
		end
		Backend:OnAddOnLoaded()
	elseif event == "PLAYER_LOGOUT" then
		wipe(ElvUICoolLineConfig)
		for k, v in pairs(Backend.Config) do
			if not Backend.Defaults[k] or Backend.Defaults[k] ~= v then
				ElvUICoolLineConfig[k] = v
			end
		end
	end
end
addon:SetScript("OnEvent", addon.OnEvent);

ElvUICoolLine = Backend

local cl = Backend.CL

function Backend:Skin()
	self.CLDB.bgcolor = { r = 0.18, g = 0.18, b = 0.18, a = 1, } --DecUI Change
	self.CLDB.border  = "None"
	local background = CreateFrame("Frame", nil, cl)
	background:SetPoint("TOPLEFT", -self.Scale(2), self.Scale(2))
	background:SetPoint("BOTTOMRIGHT", self.Scale(2), -self.Scale(2))
	background:SetFrameLevel(cl:GetFrameLevel() - 1)
	background:SetTemplate(E.db.datatexts.panelTransparency and 'Transparent' or 'Default', true)
	local parent = self:GetParent()
	if parent.shadow then
		background:CreateShadow("Default")
	end
	-- cl.background = background --DecUI Change
end

function Backend:OnUpdate()
	if self.Config.Docking then
		local parent = self:GetParent()
		self.CLDB.w = parent:GetWidth() - self.Scale(5)
		cl:SetPoint("BOTTOMRIGHT", parent, "TOPRIGHT", self.Scale(-2), self.Scale(4))
	end
end

local function DetectUI()
	if ElvUI then
		return "ElvUI"
	elseif Tukui and GetAddOnInfo("Tukui") == "Tukui" then
		return "Tukui"
	end
end
Backend.UI = DetectUI()

local oldShowSettings = SlashCmdList.COOLLINE
local oldCoolLineMenuInit
local menuButton = {}
Backend["ShowOptions"] = function()
	oldShowSettings()
	if oldCoolLineMenuInit then return end
	oldCoolLineMenuInit = CoolLineDD.initialize
	ToggleDropDownMenu(1, nil, CoolLineDD, "cursor")

	CoolLineDD.initialize = function(self, lvl)
		oldCoolLineMenuInit(self, lvl)
		if lvl ~= 1 then return end

		menuButton.isTitle = true
		menuButton.notCheckable = true
		menuButton.text = ""
		UIDropDownMenu_AddButton(menuButton,1)

		menuButton.text = "|cffC495DDElvUI CoolLine|r"
		UIDropDownMenu_AddButton(menuButton,1)
		wipe(menuButton)

		menuButton.text = "Dock"
		menuButton.keepShownOnClick = true
		menuButton.checked = Backend.Config.Docking
		menuButton.func = function()
			Backend.Config.Docking = not Backend.Config.Docking
			Backend:OnUpdate()
		end
		UIDropDownMenu_AddButton(menuButton,1)

		menuButton.text = "Expand over splitbar"
		menuButton.checked = Backend.Config.Expand
		menuButton.func = function()
			Backend.Config.Expand = not Backend.Config.Expand
			Backend:OnUpdate()
		end
		UIDropDownMenu_AddButton(menuButton,1)
	end
	ToggleDropDownMenu(1, nil, CoolLineDD, "cursor")
end
SlashCmdList.COOLLINE = Backend.ShowOptions
Backend.UnmodifiedShowSettings = oldShowSettings

function Backend:ToggleConfigBG()
	if self.Config.Docking then
		self:CreateOverlay()
		if self:IfConfig() then
			cl.overlayBtn:Show()
		else
			cl.overlayBtn:Hide()
		end
		cl:updatelook()
	end
end

function Backend:CreateOverlay()
	if cl.overlayBtn then return end
	local f = CreateFrame("Button", clButton, UIParent)
	f:SetPoint("TOPLEFT", cl, "TOPLEFT", -self.Scale(2), self.Scale(2))
	f:SetPoint("BOTTOMRIGHT", cl, "BOTTOMRIGHT", self.Scale(2), -self.Scale(2))
	f:SetFrameLevel(cl:GetFrameLevel() + 1)
	f:SetFrameStrata("DIALOG")
	f:SetTemplate(E.db.datatexts.panelTransparency and 'Transparent' or 'Default', true)

	local fs = f:CreateFontString(nil, "OVERLAY")
	fs:SetFont(self.Config.Font, self.Config.FontSize, "THINOUTLINE")
	fs:SetShadowOffset(self.Config.Mult*1.2, -self.Config.Mult*1.2)
	fs:SetJustifyH("CENTER")
	fs:SetPoint("CENTER")
	fs:SetText("CoolLine (click for options)")
	fs:SetTextColor(unpack(self.Config.ConfFColor))
	f:EnableMouse(true)
	f:SetScript("OnMouseUp", self.ShowOptions)
	cl.overlayBtn = f
end

StaticPopupDialogs["ElvUICoolLine_FIRSTRUN"] = {
	text = "First time using ElvUI CoolLine Skin, do you want to configure it?",
	button1 = "Yes",
	button2 = "No",
	OnAccept = Backend.ShowOptions,
	timeout = 0,
	whileDead = 1,
}