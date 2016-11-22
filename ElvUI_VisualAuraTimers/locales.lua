-- English localization file for enUS and enGB.
local L = LibStub("AceLocale-3.0"):NewLocale("ElvUI", "enUS", true);

if not L then return end
L['Above Icons'] = true;
L['Additional spacing between icon and statusbar. If a negative value is chosen then the statusbar is shown inside the icon. Changing this requires you to reload UI.'] = true;
L['Allows you to choose which texture to use for statusbar backdrops. If disabled, no texture will be used.'] = true;
L['Allows you to choose which texture to use for statusbars. If disabled, no texture will be used.'] = true;
L["Always Show Text"] = true;
L['Below Icons'] = true;
L["Buffs Threshold"] = true;
L["Buffs"] = true;
L['Changes the statusbar to use a static color instead of going from green to red the lower duration it has.'] = true;
L['Choose where you want the statusbar to be positioned. If you position it on the left or right side of the icon I advice you to increase Horizontal Spacing for Buffs and Debuffs. Changing this requires you to reload UI.'] = true;
L['Choose which color you want the statusbar backdrops to use. Tip: use light colors for dark statusbar colors and vice versa.'] = true;
L['Choose which color you want your statusbars to use.'] = true;
L['Color when the text is in the HH:MM format (provided by the ExactAuras addon).'] = true;
L["Debuffs Threshold"] = true;
L["Debuffs"] = true;
L["Decimal Threshold"] = true;
L['Enable Static Color'] = true;
L['General Options'] = true;
L["Height of the statusbar frame (default: 5). Changing this requires you to reload UI."] = true;
L['Hour/Minutes'] = true;
L["If enabled, the timers on your buffs will switch to text when duration goes below set threshold."] = true;
L["If enabled, the timers on your debuffs will switch to text when duration goes below set threshold."] = true;
L["If enabled, the timers on your temporary enchant(s) will switch to text when duration goes below set threshold."] = true;
L['Indicator (s, m, h, d)'] = true;
L['Left Side of Icons'] = true;
L["No Duration"] = true;
L['Numbers'] = true;
L['Position and Size'] = true;
L['Right Side of Icons'] = true;
L["Show bars for auras without a duration."] = true;
L['Show text in addition to statusbars. (You might need to move the text by changing the offset in the Buffs and Debuffs section)'] = true;
L["Show timers as bars instead of text."] = true;
L['Static Statusbar Color'] = true;
L['Statusbar Backdrop Color'] = true;
L['Statusbar Backdrop Texture'] = true;
L["Statusbar Height"] = true;
L['Statusbar Options'] = true;
L['Statusbar Position'] = true;
L['Statusbar Spacing'] = true;
L['Statusbar Texture'] = true;
L['Statusbar Width'] = true;
L["Switch to text based timers when duration goes below threshold"] = true;
L["Temp. Threshold"] = true;
L["Temporary Enchants"] = true;
L['Text Options'] = true;
L["Text Threshold"] = true;
L['Threshold before the timer changes color and goes into decimal form. Set to -1 to disable.'] = true;
L["Threshold in seconds before status bar based timers turn to text."] = true;
L['Use Backdrop Texture'] = true;
L['Use Statusbar Texture'] = true;
L['Width of the statusbar frame (default: 6). Changing this requires you to reload UI.'] = true;

--We don't need the rest if we're on enUS or enGB locale, so stop here.
if GetLocale() == "enUS" then return end

--German Localizations
local L = LibStub("AceLocale-3.0"):NewLocale("ElvUI", "deDE")
if L then
	--Add translations here, eg.
	-- L[' Alert'] = ' Alert',
end

--Spanish (Spain) Localizations
local L = LibStub("AceLocale-3.0"):NewLocale("ElvUI", "esES")
if L then
	--Add translations here, eg.
	-- L[' Alert'] = ' Alert',
end

--Spanish (Mexico) Localizations
local L = LibStub("AceLocale-3.0"):NewLocale("ElvUI", "esMX")
if L then
	--Add translations here, eg.
	-- L[' Alert'] = ' Alert',
end

--French Localizations
local L = LibStub("AceLocale-3.0"):NewLocale("ElvUI", "frFR")
if L then
	--Add translations here, eg.
	-- L[' Alert'] = ' Alert',
end

--Italian Localizations
local L = LibStub("AceLocale-3.0"):NewLocale("ElvUI", "itIT")
if L then
	--Add translations here, eg.
	-- L[' Alert'] = ' Alert',
end

--Korean Localizations
local L = LibStub("AceLocale-3.0"):NewLocale("ElvUI", "koKR")
if L then
	--Add translations here, eg.
	-- L[' Alert'] = ' Alert',
end

--Portuguese Localizations
local L = LibStub("AceLocale-3.0"):NewLocale("ElvUI", "ptBR")
if L then
	--Add translations here, eg.
	-- L[' Alert'] = ' Alert',
end

--Russian Localizations
local L = LibStub("AceLocale-3.0"):NewLocale("ElvUI", "ruRU")
if L then
	--Add translations here, eg.
	-- L[' Alert'] = ' Alert',
end

--Chinese (China, simplified) Localizations
local L = LibStub("AceLocale-3.0"):NewLocale("ElvUI", "zhCN")
if L then
	--Add translations here, eg.
	-- L[' Alert'] = ' Alert',
end

--Chinese (Taiwan, traditional) Localizations
local L = LibStub("AceLocale-3.0"):NewLocale("ElvUI", "zhTW")
if L then
	--Add translations here, eg.
	-- L[' Alert'] = ' Alert',
end