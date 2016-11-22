MythicPlusTimer = LibStub("AceAddon-3.0"):NewAddon("MythicPlusTimer", "AceConsole-3.0", "AceEvent-3.0", "AceTimer-3.0");

-- ---------------------------------------------------------------------------------------------------------------------
function MythicPlusTimer:OnInitialize()
    if MythicPlusTimerDB == nil then
        MythicPlusTimerDB = {}
    end
    
    if not MythicPlusTimerDB.config then
        MythicPlusTimerDB.config = {
            objectiveTime = true,
            deathCounter = false,
        } 
    end
    
    if not MythicPlusTimerDB.currentRun then
        MythicPlusTimerDB.currentRun = {} 
    end

    MythicPlusTimer.L = LibStub("AceLocale-3.0"):GetLocale("MythicPlusTimer")

    local options = {
        name = "MythicPlusTimer",
        handler = MythicPlusTimerDB,
        type = "group",
        args = {
            objectivetimes = {
                type = "toggle",
                name = MythicPlusTimer.L["ObjectiveTimes"],
                desc = MythicPlusTimer.L["ObjectiveTimesDesc"],
                get = function(info,val) return MythicPlusTimerDB.config.objectiveTime  end,
                set = function(info,val)  MythicPlusTimerDB.config.objectiveTime = val end,
                width = "full"
            },
            deathcounter = {
                type = "toggle",
                name = MythicPlusTimer.L["DeathCounter"],
                desc = MythicPlusTimer.L["DeathCounterDesc"],
                get = function(info,val) return MythicPlusTimerDB.config.deathCounter  end,
                set = function(info,val)  MythicPlusTimerDB.config.deathCounter = val end,
                width = "full"
            },
            resetbesttimes = {
                type = "execute",
                name = MythicPlusTimer.L["DeleteBestTimes"],
                desc = MythicPlusTimer.L["DeleteBestTimesRecords"],
                func = function(info) MythicPlusTimerDB.bestTimes = {} end,
                width = "full"
            },
        },
    }

    LibStub("AceConfig-3.0"):RegisterOptionsTable("MythicPlusTimer", options)
    LibStub("AceConfigDialog-3.0"):AddToBlizOptions("MythicPlusTimer", "MythicPlusTimer")
    
    
    MythicPlusTimerCMTimer:Init();
end

-- ---------------------------------------------------------------------------------------------------------------------
function MythicPlusTimer:OnEnable()
    self:RegisterEvent("CHALLENGE_MODE_START");
    self:RegisterEvent("CHALLENGE_MODE_COMPLETED");
    self:RegisterEvent("CHALLENGE_MODE_RESET");
    self:RegisterEvent("PLAYER_ENTERING_WORLD");
    
    self:RegisterChatCommand("mpt", "CMTimerChatCommand");
end

-- ---------------------------------------------------------------------------------------------------------------------
function MythicPlusTimer:CHALLENGE_MODE_START()
    MythicPlusTimerCMTimer:OnStart();
end

-- ---------------------------------------------------------------------------------------------------------------------
function MythicPlusTimer:StartCMTimer()
    MythicPlusTimer:CancelCMTimer()
    MythicPlusTimer.cmTimer = self:ScheduleRepeatingTimer("OnCMTimerTick", 1)
end

-- ---------------------------------------------------------------------------------------------------------------------
function MythicPlusTimer:CHALLENGE_MODE_COMPLETED()
    MythicPlusTimerCMTimer:OnComplete();
end

-- ---------------------------------------------------------------------------------------------------------------------
function MythicPlusTimer:CHALLENGE_MODE_RESET()
    MythicPlusTimerCMTimer:OnReset();
end

-- ---------------------------------------------------------------------------------------------------------------------
function MythicPlusTimer:OnCMTimerTick()
    MythicPlusTimerCMTimer:Draw();
end

-- ---------------------------------------------------------------------------------------------------------------------
function MythicPlusTimer:PLAYER_ENTERING_WORLD()
    MythicPlusTimerCMTimer:ReStart();
end

-- ---------------------------------------------------------------------------------------------------------------------
function MythicPlusTimer:CancelCMTimer()
    if MythicPlusTimer.cmTimer then
        self:CancelTimer(MythicPlusTimer.cmTimer)
        MythicPlusTimer.cmTimer = nil
    end
end

-- ---------------------------------------------------------------------------------------------------------------------
function MythicPlusTimer:CMTimerChatCommand(input)
    if input == "toggle" then
        MythicPlusTimerCMTimer:ToggleFrame()
    else
        self:Print("/mpt toggle: " .. MythicPlusTimer.L["ToggleCommandText"])
    end
end
