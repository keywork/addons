local L = LibStub("AceLocale-3.0"):NewLocale("MythicPlusTimer", "enUS", true)
if L == nil then
    return
end

L["ToggleCommandText"] = "Lock/Unlock timer frame (Frame is only visible during a mythic+ dungeon)"
L["Loot"] = "Loot"
L["NoLoot"] = "No Loot"
L["Chests"] = "Chests"
L["Best"] = "best"
L["ObjectiveTimes"] = "Show Objective Times"
L["ObjectiveTimesDesc"] = "Shows the completion time and your best time per objective."
L["DeleteBestTimes"] = "Delete best times"
L["DeleteBestTimesRecords"] = "Deletes the best times records."
L["DeathCounter"] = "Death Counter (Limitation: Does not count a death if it is too far away)"
L["DeathCounterDesc"] = "Shows a death counter and the time lost caused by player deaths. (5s per death)"
L["Deaths"] = "Deaths"
