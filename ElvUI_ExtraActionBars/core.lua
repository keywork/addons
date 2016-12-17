local E, L, V, P, G, _ = unpack(ElvUI); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB
local EAB = E:GetModule('ExtraActionBars')
local AB = E:GetModule('ActionBars');
local EP = LibStub("LibElvUIPlugin-1.0")
local addon, ns = ...

-- Create incompatibility warning popup
E.PopupDialogs['EAB_Incompatible'] = {
	text = 'ElvUI_OneExtraActionBar has been renamed to ElvUI_ExtraActionBars. You still have the old ElvUI_OneExtraActionBar enabled. Click Accept below to disable ElvUI_OneExtraActionBar',
	button1 = ACCEPT,
	OnAccept = function() DisableAddOn('ElvUI_OneExtraActionBar'); ReloadUI(); end,
	timeout = 0,
	whileDead = 1,
	preferredIndex = 3,
}

-- Function we can call or hook to AB:UpdateButtonSettings() so extra bars gets updated
function EAB:UpdateButtonSettings()
	for i = 7, 10 do
		AB:PositionAndSizeBar('bar'..i)
	end
end

function EAB:CreateBars()
	-- Set defaults.
	AB['barDefaults']['bar7'] = {
		['page'] = 7,
		['bindButtons'] = 'EXTRABAR7BUTTON',
		['conditions'] = '',
		['position'] = 'BOTTOM,ElvUI_Bar1,TOP,0,82',
	}
	AB['barDefaults']['bar8'] = {
		['page'] = 8,
		['bindButtons'] = 'EXTRABAR8BUTTON',
		['conditions'] = '',
		['position'] = 'BOTTOM,ElvUI_Bar1,TOP,0,122',
	}
	AB['barDefaults']['bar9'] = {
		['page'] = 9,
		['bindButtons'] = 'EXTRABAR9BUTTON',
		['conditions'] = '',
		['position'] = 'BOTTOM,ElvUI_Bar1,TOP,0,162',
	}
	AB['barDefaults']['bar10'] = {
		['page'] = 10,
		['bindButtons'] = 'EXTRABAR10BUTTON',
		['conditions'] = '',
		['position'] = 'BOTTOM,ElvUI_Bar1,TOP,0,202',
	}

	-- Create the actionbars.
	for i = 7, 10 do
		AB:CreateBar(i)
	end

	for b, _ in pairs(AB['handledbuttons']) do
		AB:RegisterButton(b, true);
	end

	-- Force updates so ElvUI recognizes the extra bars.
	AB:UpdateButtonSettings()
	E:UpdateCooldownSettings()
	AB:ReassignBindings()

	-- Hook UpdateButtonSettings to also update the extra bars when needed.
	hooksecurefunc(AB, 'UpdateButtonSettings', EAB.UpdateButtonSettings)
end

function EAB:PLAYER_REGEN_ENABLED()
	self:UnregisterEvent('PLAYER_REGEN_ENABLED')
	--Create Bars
	EAB:CreateBars()
end

function EAB:PLAYER_ENTERING_WORLD()
	self:UnregisterEvent('PLAYER_ENTERING_WORLD')

	--Warn about incompatible addon
	if IsAddOnLoaded('ElvUI_OneExtraActionBar') then
		E:StaticPopup_Show('EAB_Incompatible')
	end

	if InCombatLockdown() then self:RegisterEvent('PLAYER_REGEN_ENABLED'); return; end
	--Create Bars
	EAB:CreateBars()
end

function EAB:OnInitialize()
	-- Register callback with LibElvUIPlugin
	EP:RegisterPlugin(addon, EAB.InsertOptions)

	--ElvUI ActionBars are not enabled, stop right here!
	if E.private.actionbar.enable ~= true then return; end

	self:RegisterEvent('PLAYER_ENTERING_WORLD')
end
