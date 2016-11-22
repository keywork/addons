-- English localization file forenGB.
local AceLocale = LibStub:GetLibrary("AceLocale-3.0");
local L = AceLocale:NewLocale("ElvUI", "enUS", true);
if not L then return; end

L['Combat State Options'] = true
L["OOC_DESC"] = [[This options allow you to set different visibility and mouseover setting when entering or leaving combat.
Please note: if you enable state change for a bar here the presented options will disapper from the regular options for the said bar.]]
L["In Combat"] = true
L["Conditions below will take effet when entering combat."] = true
L["Out of Combat"] = true
L["Conditions below will take effet when leaving combat."] = true