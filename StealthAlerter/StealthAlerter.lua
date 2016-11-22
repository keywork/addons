local StealthAlerterMyEnemiesTable = nil;
local StealthAlerterAllianceTable = {"Draenei", "Dwarf", "Human", "Gnome", "NightElf", "Worgen"};
local StealthAlerterHordeTable = {"BloodElf", "Orc", "Troll", "Tauren", "Undead", "Goblin"};

--
-- Search a table.
--
local function SearchTable(race, table)

   ---
   --- Error trap for bad things that may happen (thanks Maroot).
   ---
   if ((not table) or (type(table) ~= "table")) then 
      return false; 
   end

   for _, v in pairs(table) do
      if (v == race) then 
         return true;
      end
   end

   return false;
end -- local function SearchTable()

--
-- Faction tooltip stuff.  Thanks to Achievement Sounds AddOn by Billtopia.
--
local StealthAlerterHostileGUIDCache = {};
local StealthAlerterTooltip = CreateFrame("GameTooltip", "StealthAlerterTooltip", UIParent, "GameTooltipTemplate");
StealthAlerterTooltip:SetOwner(WorldFrame, "ANCHOR_NONE");

--
-- Check faction by GUID, and set to true if hostile, false if friendly.
--
local function CheckFactionByGUID(GUID, Name, Race)

   --
   -- Check for nil.  Somehow it happens, IDK. why.
   --
   if GUID == nil or Name == nil or Race == nil then
      if StealthAlerterDebug then
         DEFAULT_CHAT_FRAME:AddMessage("Stealth Alerter GUID, Name or Race is nil "..GUID.." "..Name..".", 0.0, 0.85, 0.0);
      end
      return nil;
   end

   --
   -- Check cache.
   --
   if StealthAlerterHostileGUIDCache[GUID] ~= nil then
      if StealthAlerterDebug then
         DEFAULT_CHAT_FRAME:AddMessage("Stealth Alerter cache hit "..GUID.." "..Name..".", 0.0, 0.85, 0.0);
      end
      return StealthAlerterHostileGUIDCache[GUID];
   end

   if StealthAlerterDebug then
      DEFAULT_CHAT_FRAME:AddMessage("Stealth Alerter cache miss, doing a faction lookup "..GUID.." "..Name..".", 0.0, 0.85, 0.0);
   end
  
   if Race ~= nil and Race ~= "Pandaren" and SearchTable(Race, StealthAlerterMyEnemiesTable) then
      StealthAlerterHostileGUIDCache[GUID] = true;
      return StealthAlerterHostileGUIDCache[GUID];
   else
      StealthAlerterHostileGUIDCache[GUID] = false;
      return StealthAlerterHostileGUIDCache[GUID];
   end
 
   --
   -- Try to get info from tool tip for Pandaren.
   --
   StealthAlerterTooltip:ClearLines();
   StealthAlerterTooltip:SetHyperlink('unit:'..GUID);
   local tipName, numLines = "StealthAlerterTooltipTextLeft", _G["StealthAlerterTooltip"]:NumLines();

   if numLines == 0 then
      if StealthAlerterDebug then
         DEFAULT_CHAT_FRAME:AddMessage("Stealth Alerter tool tip NumLines() returned 0 "..GUID.." "..Name..".", 0.0, 0.85, 0.0);
      end
      return nil;
   end

   local faction = _G[tipName..tostring(numLines)]:GetText();

   --
   -- Figure out faction.
   --
   if (faction ~= "Alliance") and (faction ~= "Horde") then
      if StealthAlerterDebug then
         DEFAULT_CHAT_FRAME:AddMessage("Stealth Alerter couldn't determine Pandaren faction from GUID "..GUID.." "..Name..".", 0.0, 0.85, 0.0);
      end
      return nil;
   elseif faction == StealthAlerterMyFactionGroup then
      StealthAlerterHostileGUIDCache[GUID] = false;
      return StealthAlerterHostileGUIDCache[GUID];
   else
      StealthAlerterHostileGUIDCache[GUID] = true;
      return StealthAlerterHostileGUIDCache[GUID];
   end

end -- local function CheckFactionByGUID

--
-- Create a frame for flashing.
--
local f = CreateFrame("Frame", "salFrame", UIParent);
f:SetAllPoints(true);
f:SetAlpha(0);
f:SetToplevel(true);
f:SetFrameStrata("BACKGROUND");
f:EnableMouse(false);
--f:Hide();  -- The examples I found hide the frame, but it doesn't work for me.  Shrug.

--
-- Set frame texture.
--
local t = f:CreateTexture(nil,"BACKGROUND");
t:SetAllPoints(true);
t:SetBlendMode("ADD");
t:SetTexture("Interface\\FullScreenTextures\\LowHealth");  -- A builtin red texture.
--t:SetTexture("Interface\\FullScreenTextures\\OutofControl");  -- A builtin blue texture.
f.texture = t;

--
-- Make it flash.
-- http://forums.wowace.com/showthread.php?t=20397
--
local flasher = f:CreateAnimationGroup();

local fade1 = flasher:CreateAnimation("Alpha");
fade1:SetDuration(0.3);
fade1:SetFromAlpha(1);
fade1:SetOrder(1);

local fade2 = flasher:CreateAnimation("Alpha");
fade2:SetDuration(0.3);
fade2:SetToAlpha(-1);
fade2:SetOrder(2);

-- 
-- Show the help.
--
local function ShowHelp()
   if StealthAlerterEnabled then
      DEFAULT_CHAT_FRAME:AddMessage("Stealth Alerter "..StealthAlerterVersion.." is on, type \"/sal off\" to turn it off.", 0.0, 0.85, 0.0);
      if StealthAlerterShowFriendly == true then
         DEFAULT_CHAT_FRAME:AddMessage("Stealth Alerter will show friendly actions, type \"/sal nofriendly\" to turn them off.", 0.0, 0.85, 0.0);
      else
         DEFAULT_CHAT_FRAME:AddMessage("Stealth Alerter will hide friendly actions, type \"/sal friendly\" to turn them on.", 0.0, 0.85, 0.0);
      end
      if StealthAlerterTerse == true then
         DEFAULT_CHAT_FRAME:AddMessage("Stealth Alerter will print terse messages, type \"/sal noterse\" for more detail.", 0.0, 0.85, 0.0);
      else
         DEFAULT_CHAT_FRAME:AddMessage("Stealth Alerter will print detailed messages, type \"/sal terse\" for less detail.", 0.0, 0.85, 0.0);
      end
      if StealthAlerterFlash == true then
         DEFAULT_CHAT_FRAME:AddMessage("Stealth Alerter will flash the screen for hostile actions, type \"/sal noflash\" to turn it off.", 0.0, 0.85, 0.0);
      else
         DEFAULT_CHAT_FRAME:AddMessage("Stealth Alerter will not flash the screen for hostile actions, type \"/sal flash\" to turn it on.", 0.0, 0.85, 0.0);
      end
   else
      DEFAULT_CHAT_FRAME:AddMessage("Stealth Alerter "..StealthAlerterVersion.." is off, type \"/sal on\" to turn it on.", 0.0, 0.85, 0.0);
   end
end -- local function ShowHelp()

--
-- Handle slash commands.
--
function StealthAlerterCommand(command)
   local argc, argv = 0, {};
   gsub(command, "[^%s]+", function (word) argc=argc+1; argv[argc]=word; end);

   if (argc == 1) and (argv[1] == "help") then
      ShowHelp();
   elseif (argc == 1) and (argv[1] == "off") then
      DEFAULT_CHAT_FRAME:AddMessage("Stealth Alerter "..StealthAlerterVersion.." is off, type \"/sal on\" to turn it on.", 0.0, 0.85, 0.0);
      StealthAlerterEnabled = false;
      StealthAlerterFrame:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
   elseif (argc == 1) and (argv[1] == "on") then
      DEFAULT_CHAT_FRAME:AddMessage("Stealth Alerter "..StealthAlerterVersion.." is on, type \"/sal off\" to turn it off.", 0.0, 0.85, 0.0);
      StealthAlerterEnabled = true;
      StealthAlerterFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
   elseif (argc == 1) and (argv[1] == "debug") then
      DEFAULT_CHAT_FRAME:AddMessage("Stealth Alerter "..StealthAlerterVersion.." debug is on, type \"/sal undebug\" to turn debugging off.", 0.0, 0.85, 0.0);
      StealthAlerterDebug = true;
   elseif (argc == 1) and (argv[1] == "undebug") then
      DEFAULT_CHAT_FRAME:AddMessage("Stealth Alerter "..StealthAlerterVersion.." debug is off, type \"/sal debug\" to turn debugging on.", 0.0, 0.85, 0.0);
      StealthAlerterDebug = false;
   elseif (argc == 1) and (argv[1] == "friendly") then
      DEFAULT_CHAT_FRAME:AddMessage("Stealth Alerter will show friendly actions, type \"/sal nofriendly\" to turn them off.", 0.0, 0.85, 0.0);
      StealthAlerterShowFriendly = true;
   elseif (argc == 1) and (argv[1] == "nofriendly") then
      DEFAULT_CHAT_FRAME:AddMessage("Stealth Alerter will hide friendly actions, type \"/sal friendly\" to turn them on.", 0.0, 0.85, 0.0);
      StealthAlerterShowFriendly = false;
   elseif (argc == 1) and (argv[1] == "terse") then
      DEFAULT_CHAT_FRAME:AddMessage("Stealth Alerter will print terse messages, type \"/sal noterse\" for more detail.", 0.0, 0.85, 0.0);
      StealthAlerterTerse = true;
   elseif (argc == 1) and (argv[1] == "noterse") then
      DEFAULT_CHAT_FRAME:AddMessage("Stealth Alerter will print detailed messages, type \"/sal terse\" for less detail.", 0.0, 0.85, 0.0);
      StealthAlerterTerse = false;
   elseif (argc == 1) and (argv[1] == "flash") then
      DEFAULT_CHAT_FRAME:AddMessage("Stealth Alerter will flash the screen for hostile actions, type \"/sal noflash\" to turn it off.", 0.0, 0.85, 0.0);
      StealthAlerterFlash = true;
      flasher:Play(); 
   elseif (argc == 1) and (argv[1] == "noflash") then
      DEFAULT_CHAT_FRAME:AddMessage("Stealth Alerter will not flash the screen for hostile actions, type \"/sal flash\" to turn it on.", 0.0, 0.85, 0.0);
      StealthAlerterFlash = false;
   else
      ShowHelp();
   end
end -- function StealthAlerterCommand()

-- 
-- Do stuff when the Addon is loaded.
--
function StealthAlerterOnLoad()
   StealthAlerterVersion = "0.99.25 (July 31, 2016)";   -- Version number.

   --
   -- Register a command handler.
   -- 
   SlashCmdList["STEALTHALERTERCMD"] = StealthAlerterCommand;
   SLASH_STEALTHALERTERCMD1 = "/sal";
   SLASH_STEALTHALERTERCMD2 = "/stealthalerter";
   
   if StealthAlerterEnabled == nil then
      StealthAlerterEnabled = true;
   end

   if StealthAlerterDebug == nil then
      StealthAlerterDebug = false;
   end

   if StealthAlerterShowFriendly == nil then
      StealthAlerterShowFriendly = true;
   end

   if StealthAlerterTerse == nil then
      StealthAlerterTerse = false;
   end

   if StealthAlerterFlash == nil then
      StealthAlerterFlash = true;
   end

   --
   -- Get our faction.
   --
   -- factionGroup is the non-localized (English) faction name of the faction ('Horde', 'Alliance', or 'Neutral').
   -- factionName is the localized name of the faction - not used.
   --
   StealthAlerterMyFactionGroup, StealthAlerterMyFactionName = UnitFactionGroup("player");

   -- 
   -- Set our enemies.
   --
   if StealthAlerterMyFactionGroup == "Horde" then
      StealthAlerterMyEnemiesTable = StealthAlerterAllianceTable;
   else
      StealthAlerterMyEnemiesTable = StealthAlerterHordeTable;
   end

   StealthAlerterFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");

   return;
end -- function StealthAlerterOnLoad()

-- 
-- Handle the events we've registered, print messages and do stuff.
--
function StealthAlerterOnEvent(event, ...)
   local timestamp, type, hideCaster, sourceGUID, sourceName, sourceFlags, mysteryArgument, destGUID, destName, destFlags, anotherMysteryArgument, spellId, spellName = select(1, ...)

   if StealthAlerterEnabled == false then
      return;
   end

   --
   -- Look for interesting SPELL_CAST_SUCCESS events.
   --
   if event == "COMBAT_LOG_EVENT_UNFILTERED" and type == "SPELL_CAST_SUCCESS" then
      --
      -- Enable for verbose logging.  Probably a bad idea.
      --
      -- DEFAULT_CHAT_FRAME:AddMessage(""..spellId.." "..spellName.." "..sourceGUID.." "..sourceName..".", 0.41, 0.8, 0.94);

      --
      -- Detect Rogues casting Vanish.
      --
      if spellId == 1856 then 
         local class, classFilename, race, raceFilename, sex = GetPlayerInfoByGUID(sourceGUID);
         local IsHostile = CheckFactionByGUID(sourceGUID, sourceName, raceFilename);

	 if IsHostile ~= nil and IsHostile then 
            if StealthAlerterTerse then
               DEFAULT_CHAT_FRAME:AddMessage(""..sourceName.." cast Vanish.", 1.0, 0.25, 0.25);
            else
               DEFAULT_CHAT_FRAME:AddMessage(""..sourceName.." ("..race..") cast Vanish (3 seconds).", 1.0, 0.25, 0.25);
	    end
            if StealthAlerterFlash then
               flasher:Play(); 
            end
	 elseif IsHostile ~= nil and StealthAlerterShowFriendly then
            if StealthAlerterTerse then
               DEFAULT_CHAT_FRAME:AddMessage(""..sourceName.." cast Vanish.", 0.41, 0.8, 0.94);
            else
               DEFAULT_CHAT_FRAME:AddMessage(""..sourceName.." ("..race..") cast Vanish (3 seconds).", 0.41, 0.8, 0.94);
	    end
	 end
      --
      -- Detect Rogues casting Stealth.
      --
      elseif spellId == 1784 then 
         local class, classFilename, race, raceFilename, sex = GetPlayerInfoByGUID(sourceGUID);
         local IsHostile = CheckFactionByGUID(sourceGUID, sourceName, raceFilename);

	 if IsHostile ~= nil and IsHostile then 
            if StealthAlerterTerse then
               DEFAULT_CHAT_FRAME:AddMessage(""..sourceName.." cast Stealth.", 1.0, 0.25, 0.25);
	    else
               DEFAULT_CHAT_FRAME:AddMessage(""..sourceName.." ("..race..") cast Stealth.", 1.0, 0.25, 0.25);
            end
            if StealthAlerterFlash then
               flasher:Play(); 
            end
	 elseif IsHostile ~= nil and StealthAlerterShowFriendly then
            if StealthAlerterTerse then
               DEFAULT_CHAT_FRAME:AddMessage(""..sourceName.." cast Stealth.", 0.41, 0.8, 0.94);
	    else
               DEFAULT_CHAT_FRAME:AddMessage(""..sourceName.." ("..race..") cast Stealth.", 0.41, 0.8, 0.94);
	    end
	 end
      --
      -- Detect Rogues casting Shroud of Concealment.
      --
      elseif spellId == 114018 then 
         local class, classFilename, race, raceFilename, sex = GetPlayerInfoByGUID(sourceGUID);
         local IsHostile = CheckFactionByGUID(sourceGUID, sourceName, raceFilename);

	 if IsHostile ~= nil and IsHostile then 
            if StealthAlerterTerse then
               DEFAULT_CHAT_FRAME:AddMessage(""..sourceName.." cast Shroud of Concealment.", 1.0, 0.25, 0.25);
	    else
               DEFAULT_CHAT_FRAME:AddMessage(""..sourceName.." ("..race..") cast Shroud of Concealment (15 seconds).", 1.0, 0.25, 0.25);
            end
            if StealthAlerterFlash then
               flasher:Play(); 
            end
	 elseif IsHostile ~= nil and StealthAlerterShowFriendly then
            if StealthAlerterTerse then
               DEFAULT_CHAT_FRAME:AddMessage(""..sourceName.." cast Shroud of Concealment.", 0.41, 0.8, 0.94);
	    else
               DEFAULT_CHAT_FRAME:AddMessage(""..sourceName.." ("..race..") cast Shroud of Concealment (15 seconds).", 0.41, 0.8, 0.94);
	    end
	 end
      --
      -- Detect Druids casting Prowl.
      --
      elseif spellId == 5215 then
         local class, classFilename, race, raceFilename, sex = GetPlayerInfoByGUID(sourceGUID);
         local IsHostile = CheckFactionByGUID(sourceGUID, sourceName, raceFilename);

	 if IsHostile ~= nil and IsHostile then 
            if StealthAlerterTerse then
               DEFAULT_CHAT_FRAME:AddMessage(""..sourceName.." cast Prowl.", 1.0, 0.25, 0.25);
            else
	       DEFAULT_CHAT_FRAME:AddMessage(""..sourceName.." ("..race..") cast Prowl (speed reduced by 30%).", 1.0, 0.25, 0.25);
	    end
            if StealthAlerterFlash then
               flasher:Play(); 
            end
	 elseif IsHostile ~= nil and StealthAlerterShowFriendly then
            if StealthAlerterTerse then
               DEFAULT_CHAT_FRAME:AddMessage(""..sourceName.." cast Prowl.", 0.41, 0.8, 0.94);
	    else
               DEFAULT_CHAT_FRAME:AddMessage(""..sourceName.." ("..race..") cast Prowl (speed reduced by 30%).", 0.41, 0.8, 0.94);
	    end
	 end
      --
      -- Detect Night Elves casting Shadowmeld.
      --
      elseif spellId == 58984 then
         local class, classFilename, race, raceFilename, sex = GetPlayerInfoByGUID(sourceGUID);
         local IsHostile = CheckFactionByGUID(sourceGUID, sourceName, raceFilename);

	 if IsHostile ~= nil and IsHostile then 
            if StealthAlerterTerse then
               DEFAULT_CHAT_FRAME:AddMessage(""..sourceName.." cast Shadowmeld.", 1.0, 0.25, 0.25);
            else
	       DEFAULT_CHAT_FRAME:AddMessage(""..sourceName.." ("..race..") cast Shadowmeld.", 1.0, 0.25, 0.25);
	    end
            if StealthAlerterFlash then
               flasher:Play(); 
            end
	 elseif IsHostile ~= nil and StealthAlerterShowFriendly then
            if StealthAlerterTerse then
               DEFAULT_CHAT_FRAME:AddMessage(""..sourceName.." cast Shadowmeld.", 0.41, 0.8, 0.94);
            else
	       DEFAULT_CHAT_FRAME:AddMessage(""..sourceName.." ("..race..") cast Shadowmeld.", 0.41, 0.8, 0.94);
	    end
	 end
      --
      -- Detect Hunters casting Camouflage.
      --
      elseif spellId == 51753 then
         local class, classFilename, race, raceFilename, sex = GetPlayerInfoByGUID(sourceGUID);
         local IsHostile = CheckFactionByGUID(sourceGUID, sourceName, raceFilename);

	 if IsHostile ~= nil and IsHostile then 
            if StealthAlerterTerse then
               DEFAULT_CHAT_FRAME:AddMessage(""..sourceName.." cast Camouflage.", 1.0, 0.25, 0.25);
            else
	       DEFAULT_CHAT_FRAME:AddMessage(""..sourceName.." ("..race..") cast Camouflage (60 seconds).", 1.0, 0.25, 0.25);
	    end
            if StealthAlerterFlash then
               flasher:Play(); 
            end
	 elseif IsHostile ~= nil and StealthAlerterShowFriendly then
            if StealthAlerterTerse then
               DEFAULT_CHAT_FRAME:AddMessage(""..sourceName.." cast Camouflage.", 0.41, 0.8, 0.94);
            else
	       DEFAULT_CHAT_FRAME:AddMessage(""..sourceName.." ("..race..") cast Camouflage (60 seconds).", 0.41, 0.8, 0.94);
	    end
	 end
      --
      -- Detect Mages casting Invisibility.
      --
      elseif spellId == 66 then
         local class, classFilename, race, raceFilename, sex = GetPlayerInfoByGUID(sourceGUID);
         local IsHostile = CheckFactionByGUID(sourceGUID, sourceName, raceFilename);

	 if IsHostile ~= nil and IsHostile then 
            if StealthAlerterTerse then
               DEFAULT_CHAT_FRAME:AddMessage(""..sourceName.." cast Invisibility.", 1.0, 0.25, 0.25);
            else
	       DEFAULT_CHAT_FRAME:AddMessage(""..sourceName.." ("..race..") cast Invisibility (20 seconds).", 1.0, 0.25, 0.25);
	    end
            if StealthAlerterFlash then
               flasher:Play(); 
            end
	 elseif IsHostile ~= nil and StealthAlerterShowFriendly then
            if StealthAlerterTerse then
               DEFAULT_CHAT_FRAME:AddMessage(""..sourceName.." cast Invisibility.", 0.41, 0.8, 0.94);
            else
	       DEFAULT_CHAT_FRAME:AddMessage(""..sourceName.." ("..race..") cast Invisibility (20 seconds).", 0.41, 0.8, 0.94);
	    end
	 end
      --
      -- Detect Mages casting Greater Invisibility.
      --
      elseif spellId == 110959 then
         local class, classFilename, race, raceFilename, sex = GetPlayerInfoByGUID(sourceGUID);
         local IsHostile = CheckFactionByGUID(sourceGUID, sourceName, raceFilename);

	 if IsHostile ~= nil and IsHostile then 
            if StealthAlerterTerse then
               DEFAULT_CHAT_FRAME:AddMessage(""..sourceName.." cast Greater Invisibility.", 1.0, 0.25, 0.25);
            else
	       DEFAULT_CHAT_FRAME:AddMessage(""..sourceName.." ("..race..") cast Greater Invisibility (20 seconds).", 1.0, 0.25, 0.25);
	    end
            if StealthAlerterFlash then
               flasher:Play(); 
            end
	 elseif IsHostile ~= nil and StealthAlerterShowFriendly then
            if StealthAlerterTerse then
               DEFAULT_CHAT_FRAME:AddMessage(""..sourceName.." cast Greater Invisibility.", 0.41, 0.8, 0.94);
            else
	       DEFAULT_CHAT_FRAME:AddMessage(""..sourceName.." ("..race..") cast Greater Invisibility (20 seconds).", 0.41, 0.8, 0.94);
	    end
	 end
      --
      -- Detect Stealthman 54 devices.
      --
      elseif spellId == 156136 then
         local class, classFilename, race, raceFilename, sex = GetPlayerInfoByGUID(sourceGUID);
         local IsHostile = CheckFactionByGUID(sourceGUID, sourceName, raceFilename);

	 if IsHostile ~= nil and IsHostile then 
            if StealthAlerterTerse then
               DEFAULT_CHAT_FRAME:AddMessage(""..sourceName.." used a Stealthman 54 device.", 1.0, 0.25, 0.25);
            else
	       DEFAULT_CHAT_FRAME:AddMessage(""..sourceName.." ("..race..") used a Stealthman 54 device.", 1.0, 0.25, 0.25);
	    end
            if StealthAlerterFlash then
               flasher:Play(); 
            end
	 elseif IsHostile ~= nil and StealthAlerterShowFriendly then
            if StealthAlerterTerse then
               DEFAULT_CHAT_FRAME:AddMessage(""..sourceName.." used a Stealthman 54 device.", 0.41, 0.8, 0.94);
            else
	       DEFAULT_CHAT_FRAME:AddMessage(""..sourceName.." ("..race..") used a Stealthman 54 device.", 0.41, 0.8, 0.94);
	    end
	 end
      --
      -- Detect Invisibility potions.
      --
      elseif spellId == 3680 then
         local class, classFilename, race, raceFilename, sex = GetPlayerInfoByGUID(sourceGUID);
         local IsHostile = CheckFactionByGUID(sourceGUID, sourceName, raceFilename);

	 if IsHostile ~= nil and IsHostile then 
            if StealthAlerterTerse then
               DEFAULT_CHAT_FRAME:AddMessage(""..sourceName .. " used a Lesser Invisibility Potion.", 1.0, 0.25, 0.25);
	    else
               DEFAULT_CHAT_FRAME:AddMessage(""..sourceName .. " ("..race..") used a Lesser Invisibility Potion (15 seconds).", 1.0, 0.25, 0.25);
	    end
            if StealthAlerterFlash then
               flasher:Play(); 
            end
	 elseif IsHostile ~= nil and StealthAlerterShowFriendly then
            if StealthAlerterTerse then
               DEFAULT_CHAT_FRAME:AddMessage(""..sourceName .. " used a Lesser Invisibility Potion.", 0.41, 0.8, 0.94);
            else
	       DEFAULT_CHAT_FRAME:AddMessage(""..sourceName .. " ("..race..") used a Lesser Invisibility Potion (15 seconds).", 0.41, 0.8, 0.94);
	    end
	 end
      elseif spellId == 11392 then
         local class, classFilename, race, raceFilename, sex = GetPlayerInfoByGUID(sourceGUID);
         local IsHostile = CheckFactionByGUID(sourceGUID, sourceName, raceFilename);

	 if IsHostile ~= nil and IsHostile then 
            if StealthAlerterTerse then
               DEFAULT_CHAT_FRAME:AddMessage(""..sourceName .. " used an Invisibility Potion.", 1.0, 0.25, 0.25); 
	    else
               DEFAULT_CHAT_FRAME:AddMessage(""..sourceName .. " ("..race..") used an Invisibility Potion (18 seconds).", 1.0, 0.25, 0.25);
	    end
            if StealthAlerterFlash then
               flasher:Play(); 
            end
	 elseif IsHostile ~= nil and StealthAlerterShowFriendly then
            if StealthAlerterTerse then
               DEFAULT_CHAT_FRAME:AddMessage(""..sourceName .. " used an Invisibility Potion.", 0.41, 0.8, 0.94);
	    else
               DEFAULT_CHAT_FRAME:AddMessage(""..sourceName .. " ("..race..") used an Invisibility Potion (18 seconds).", 0.41, 0.8, 0.94);
	    end
	 end
      elseif spellId == 175833 then
         local class, classFilename, race, raceFilename, sex = GetPlayerInfoByGUID(sourceGUID);
         local IsHostile = CheckFactionByGUID(sourceGUID, sourceName, raceFilename);

	 if IsHostile ~= nil and IsHostile then 
            if StealthAlerterTerse then
               DEFAULT_CHAT_FRAME:AddMessage(""..sourceName .. " used a Draenic Invisibility Potion.", 1.0, 0.25, 0.25); 
	    else
               DEFAULT_CHAT_FRAME:AddMessage(""..sourceName .. " ("..race..") used a Draenic Invisibility Potion (18 seconds).", 1.0, 0.25, 0.25);
	    end
            if StealthAlerterFlash then
               flasher:Play(); 
            end
	 elseif IsHostile ~= nil and StealthAlerterShowFriendly then
            if StealthAlerterTerse then
               DEFAULT_CHAT_FRAME:AddMessage(""..sourceName .. " used a Draenic Invisibility Potion.", 0.41, 0.8, 0.94);
	    else
               DEFAULT_CHAT_FRAME:AddMessage(""..sourceName .. " ("..race..") used a Draenic Invisibility Potion (18 seconds).", 0.41, 0.8, 0.94);
	    end
	 end
      end
   end
end -- function StealthAlerterOnEvent()
