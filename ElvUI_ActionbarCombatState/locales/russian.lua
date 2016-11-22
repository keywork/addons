--Файл локализации для ruRU
local AceLocale = LibStub:GetLibrary("AceLocale-3.0");
local L = AceLocale:NewLocale("ElvUI", "ruRU")
if not L then return; end

L['Combat State Options'] = "Опции состояния боя"
L["OOC_DESC"] = [[Эти опции позволят вам утановить разные условия отображения и показа при наведении при вступлении или выходе из боя.
Замечание: если вы активируете автоматическую смену для какой-либо панели, то указанные опции пропадут из обычных настроек для данной панели.]]
L["In Combat"] = "В бою"
L["Conditions below will take effet when entering combat."] = "Эти условия будут применяться при вступлении в бой."
L["Out of Combat"] = "Вне боя"
L["Conditions below will take effet when leaving combat."] = "Эти условия будут применяться при выходе из боя."