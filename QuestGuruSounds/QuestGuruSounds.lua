--QuestGuruSounds

--local addonName,addonTable = ...
--local DA = _G[addonName]

-- Sound set definitions
local soundSets = {
-- Plays sounds on quest completeion and objective completion.
--[[
  mix = {
	questComplete = "Sound/Creature/Peon/PeonBuildingComplete1.ogg",
	objectiveComplete = "Sound/Creature/Peasant/PeasantReady1.ogg",
	objectiveProgress = "",
  },
-- Plays sounds on quest completeion only.
  peasantquestonly = {
	questComplete = "Sound/Creature/Peasant/PeasantReady1.ogg",
	objectiveComplete = "",
	objectiveProgress = "",
  },
]]		
	classic = {  --
		questComplete = "Sound/INTERFACE/iQuestComplete.ogg",
		objectiveComplete = "Sound/INTERFACE/AuctionWindowClose.ogg",
		objectiveProgress = "Sound/INTERFACE/AuctionWindowOpen.ogg",
  },	
	alarms = {
		questComplete = "Sound/Interface/AlarmClockWarning1.wav",
		objectiveComplete = "Sound/Interface/AlarmClockWarning2.wav",
		objectiveProgress = "Sound/Interface/AlarmClockWarning3.wav",
  }, 
	
	bells = {
		questComplete = "Sound/Doodad/KharazahnBellToll.wav",
		objectiveComplete = "Sound/Doodad/BellTollHorde.wav",
		objectiveProgress = "Sound/Spells/ShaysBell.wav",
  },

	peasant = {
		questComplete = "Sound/Creature/Peasant/PeasantReady1.ogg",
		objectiveComplete = "Sound/Creature/Peasant/PeasantYes4.ogg",
		objectiveProgress = "Sound/Creature/Peasant/PeasantYes1.ogg",
  },  
	peon = {  -- default set
		questComplete = "Sound/Creature/Peon/PeonBuildingComplete1.ogg",
		objectiveComplete = "Sound/Creature/Peon/PeonReady1.ogg",
		objectiveProgress = "Sound/Creature/Peon/PeonYes3.ogg",
  },
    quiet = {  --
		questComplete = "",
		objectiveComplete = "",
		objectiveProgress = "",
  },
}

-- The saved variables
QGSVars = {} 

-- The sounds to play
local sounds = nil 


local messageLevels = {
  -- increment in multiples of 10 so we can add levels later without breaking stuff
  none = 0,
  completion = 10,
  objectives = 20,
  all = 30
}

local qgs = CreateFrame("Frame")
local events = {}

qgs.questIndex = 0
qgs.questId = 0
qgs.completeCount = 0
qgs.msgLvl = messageLevels.all

local function countCompleteObjectives(index)
  local n = 0
  for i = 1, GetNumQuestLeaderBoards(index) do
    local _, _, finished = GetQuestLogLeaderBoard(i, index)
    if finished then
      n = n + 1
    end
  end
  return n
end

function qgs:setQuest(index)
  self.questIndex = index
  if index>0 then
    local _, _, _, _, _, _, _, id = GetQuestLogTitle(index)
    self.questId = id
    if id and id>0 then
      self.completeCount = countCompleteObjectives(index)
    end
  end
end

function qgs:checkQuest()
  if self.questIndex>0 then
    local index = self.questIndex
    self.questIndex = 0
    -- Beware! One of the output arguments was removed in WoD
    local title, level, _, _, _, complete, daily, id = GetQuestLogTitle(index)
    local link = GetQuestLink(id) -- Change in 7.1 fron index to id
    if id==self.questId then
      if id and id>0 then
      	if link == nil then
          link = title
        end
        local objectivesComplete = countCompleteObjectives(index)
        if complete then
          if qgs.msgLvl >= messageLevels.completion then
            print("["..level.."] '"..link.."': complete");
          end
          self:Play(sounds and sounds.questComplete)
        elseif objectivesComplete>self.completeCount then
          if qgs.msgLvl >= messageLevels.objectives then
            print("["..level.."] '"..link.."': objective complete ("..objectivesComplete.."/"..GetNumQuestLeaderBoards(index)..")");
          end
          self:Play(sounds and sounds.objectiveComplete)
        else
          if qgs.msgLvl >= messageLevels.all then
--             print("["..level.."] '"..link.."': updated");
          end
          self:Play(sounds and sounds.objectiveProgress)
        end
      end
    end
  end
end

function qgs:init()
  self:SetScript("OnEvent", function(frame, event, ...)
    local handler = events[event]
    if handler then
      -- dispatch events that were auto-registered by naming convention
      handler(frame, ...)
    end
  end)
  for k,v in pairs(events) do
    self:RegisterEvent(k)
  end
end

function qgs:Play(sound)
  if sound and sound~="" then
    --print("PeonQuestComplete debug message: Playing:", sound)
    PlaySoundFile(sound);
  end
end

function qgs:SetSoundSet(setName, silent)
  if setName and soundSets[setName] then
    QGSVars.ActiveSet = setName
    sounds = soundSets[setName]
    if not(silent) then
      print("Switching to sound set |cFF44FF00"..setName.."|r")
      qgs:Play(sounds.questComplete)
    end
  else
    print("Recognized sound set names are:")
    for k,v in pairs(soundSets) do
      if k==QGSVars.ActiveSet then
        print("  "..k.."      (*)")
      else
        print("  "..k)
      end
    end
  end
end

function qgs:SetMessageLevel(messageLevel)
  local levelCode = messageLevels[messageLevel]
  if levelCode==nil then
    -- ignore silently now
  else
    QGSVars.Messages = messageLevel
    qgs.msgLvl = levelCode
  end
end


function qgs:SetMessageLevelCmd(messageLevel)
  if messageLevel==nil or messageLevel=="" then
    print("The current message verbosity level is '"..QGSVars.Messages.."'")
  else
    local levelCode = messageLevels[messageLevel]
    if levelCode==nil then
      print("Unrecognized message verbosity level '"..messageLevel.."'. Expecting one of :")
      for k,v in pairs(messageLevels) do
        print("  "..k);
      end
    else
      qgs:SetMessageLevel(messageLevel)
      print("Setting message verbosity to "..QGSVars.Messages)
    end
  end
end


-- ................................................................
-- event handlers

function events:UNIT_QUEST_LOG_CHANGED(unit)
  if unit=="player" then
    qgs:checkQuest()
  end
end

function events:QUEST_WATCH_UPDATE(index)
  -- This event triggers just *before* the changes are registered
  -- in the quest log, giving a great opportunity to quantify changes
  -- in the subsequent UNIT_QUEST_LOG_CHANGED
  qgs:setQuest(index)
end

function events:PLAYER_LOGIN()
  -- Saved variables are stable now
  if not(QGSVars.ActiveSet) then
    QGSVars.ActiveSet = "peon"
  end
  if not(QGSVars.Messages) then
    QGSVars.Messages = "objectives"
    -- one of "objectives", "completion", "none"
  end
  qgs:SetMessageLevel(QGSVars.Messages)
  qgs:SetSoundSet(QGSVars.ActiveSet, true)
end

-- ................................................................
-- command interface

SLASH_QUESTGURUSOUNDS1 = "/qgs"
SLASH_QUESTGURUSOUNDS2 = "/questgurusounds"

function SlashCmdList.QUESTGURUSOUNDS(msg, editbox)
  local cmd, rest = msg:match("^(%S*)%s*(.-)$")
  qgs:Command(cmd, rest)
end

function qgs:Command(command, arg)
  local handler = self["CMD"..command]
  if handler then
    handler(self, arg)
  else
    if command~="" then
      print("Unknown QuestGuru Sounds command '"..command.."'");
    end
    print("QuestGuru Sounds:")
    print("  /qgs set <soundsetname>")
    print("     Sets the sound set and plays its quest completion sound")
    print("  /qgs set")
    print("     Lists the known sound set names")
    print("  /qgs test <quest|objective|part>")
    print("     Plays the current 'quest', 'objective' or 'part' completion sound")
    print("  /qgs message <objectives|completion|none>")
    print("     Sets verbosity of messages in the chat log to 'objectives', 'completion' or 'none'")
    print("  The current sound set is |cFF44FF00"..QGSVars.ActiveSet.."|r");
    print("  The current message verbosity is |cFF44FF00"..QGSVars.Messages.."|r");
  end
end

function qgs:CMDtest(arg)
  if arg=="1" or arg=="quest" then
    print("Playing |cFFCCCC44quest complete|r sound of sound set |cFF44FF00"..QGSVars.ActiveSet.."|r")
    self:Play(sounds and sounds.questComplete)
  elseif arg=="2" or arg=="objective" then
    print("Playing |cFFCCCC44objective complete|r sound of sound set |cFF44FF00"..QGSVars.ActiveSet.."|r")
    self:Play(sounds and sounds.objectiveComplete)
  elseif arg=="3" or arg=="part" then
    print("Playing |cFFCCCC44objective progress|r sound of sound set |cFF44FF00"..QGSVars.ActiveSet.."|r")
    self:Play(sounds and sounds.objectiveProgress)
  else
    print("  Usage: /qgs test <sound id>")
    print("    Recognized values for <sound id> are:")
    print("      '1' or 'quest' for the quest complete sound")
    print("      '2' or 'objective' for the objective complete sound")
    print("      '3' or 'part' for the objective part update sound")
  end
end

function qgs:CMDset(arg)
  self:SetSoundSet(arg)
end

function qgs:CMDmessage(arg)
  self:SetMessageLevelCmd(arg)
end

function qgs:CMDmsg(arg)
  self:SetMessageLevelCmd(arg)
end

-- ................................................................
-- must be last line:
qgs:init()
