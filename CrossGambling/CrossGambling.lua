﻿local AcceptOnes = "false";
local AcceptRolls = "false";
local totalrolls = 0
local tierolls = 0;
local theMax
local lowname = ""
local highname = ""
local low = 0
local high = 0
local tie = 0
local highbreak = 0;
local lowbreak = 0;
local tiehigh = 0;
local tielow = 0;
local chatmethod = "RAID";
local whispermethod = false;
local totalentries = 0;
local highplayername = "";
local lowplayername = "";
local rollCmd = SLASH_RANDOM1:upper();


-- LOAD FUNCTION --
function CrossGambling_OnLoad(self)
	DEFAULT_CHAT_FRAME:AddMessage("|cffffff00<CrossFire Gambling 0.1> loaded /cg to use");

	self:RegisterEvent("CHAT_MSG_RAID");
	self:RegisterEvent("CHAT_MSG_RAID_LEADER");
	self:RegisterEvent("CHAT_MSG_GUILD");
	self:RegisterEvent("CHAT_MSG_GUILD_LEADER");
	self:RegisterEvent("CHAT_MSG_SYSTEM");
	self:RegisterEvent("PLAYER_ENTERING_WORLD");
	self:RegisterForDrag("LeftButton");

	CrossGambling_ROLL_Button:Disable();
	CrossGambling_AcceptOnes_Button:Enable();		
	CrossGambling_LASTCALL_Button:Disable();
	CrossGambling_CHAT_Button:Enable();
end

local EventFrame=CreateFrame("Frame");
EventFrame:RegisterEvent("CHAT_MSG_WHISPER");-- Need to register an event to receive it
EventFrame:SetScript("OnEvent",function(self,event,msg,sender)
    if msg:lower():find("!stats") then--    We're making sure the command is case insensitive by casting it to lowercase before running a pattern check
        SendChatMessage("Work in Progress","WHISPER",nil,sender);
    end
end);

local function Print(pre, red, text)
	if red == "" then red = "/CG" end
	DEFAULT_CHAT_FRAME:AddMessage(pre..GREEN_FONT_COLOR_CODE..red..FONT_COLOR_CODE_CLOSE..": "..text)
end

local function DebugMsg(level, text)
  if debugLevel < level then return end
  Print("","",GRAY_FONT_COLOR_CODE..date("%H:%M:%S")..RED_FONT_COLOR_CODE.." DEBUG: "..FONT_COLOR_CODE_CLOSE..text)
end

function CrossGambling_SlashCmd(msg)
	local msg = msg:lower();
	local msgPrint = 0;
	if (msg == "" or msg == nil) then
	    Print("", "", "~Following commands for CrossGambling~");
		Print("", "", "show - Shows the frame");
		Print("", "", "hide - Hides the frame");
		Print("", "", "reset - Resets the AddOn");
		Print("", "", "resetstats - Resets the stats");
		Print("", "", "joinstats [main] [alt] - Apply [alt]'s win/losses to [main]");
		Print("", "", "unjoinstats [alt] - Unjoin [alt]'s win/losses from whomever it was joined to");
		Print("", "", "ban - Ban's the user from being able to roll");
		Print("", "", "unban - Unban's the user");
		Print("", "", "listban - Shows ban list");
		msgPrint = 1;
	end
	if (msg == "hide") then
		CrossGambling_Frame:Hide();
		CrossGambling["active"] = 0;
		msgPrint = 1;
	end
	if (msg == "show") then
		CrossGambling_Frame:Show();
		CrossGambling["active"] = 1;
		msgPrint = 1;
	end
	if (msg == "reset") then
		Print("", "", "|cffffff00GCG has now been reset");
		CrossGambling_Reset();
		CrossGambling_AcceptOnes_Button:SetText("Open Entry");
		msgPrint = 1;		
	end
	if (msg == "resetstats") then
		Print("", "", "|cffffff00GCG stats have now been reset");
		CrossGambling_ResetStats();
		msgPrint = 1;
	end
	if (string.sub(msg, 1, 9) == "joinstats") then
		CrossGambling_JoinStats(strsub(msg, 11));
		msgPrint = 1;
	end
	if (string.sub(msg, 1, 11) == "unjoinstats") then
		CrossGambling_UnjoinStats(strsub(msg, 13));
		msgPrint = 1;
	end

	if (string.sub(msg, 1, 3) == "ban") then
		CrossGambling_AddBan(strsub(msg, 5));
		msgPrint = 1;
	end

	if (string.sub(msg, 1, 5) == "unban") then
		CrossGambling_RemoveBan(strsub(msg, 7));
		msgPrint = 1;
	end

	if (string.sub(msg, 1, 7) == "listban") then
		CrossGambling_ListBan();
		msgPrint = 1;
	end

	if (msgPrint == 0) then
		Print("", "", "|cffffff00Invalid argument for command /cg");
	end
end

SLASH_CrossGambling1 = "/CrossGambler";
SLASH_CrossGambling2 = "/cg";
SlashCmdList["CrossGambling"] = CrossGambling_SlashCmd



function CrossGambling_OnEvent(self, event, ...)

	-- LOADS ALL DATA FOR INITIALIZATION OF ADDON --
	arg1,arg2 = ...;
	if (event == "PLAYER_ENTERING_WORLD") then
		CrossGambling_EditBox:SetJustifyH("CENTER");

		if(not CrossGambling) then
			CrossGambling = {
				["active"] = 1, 
				["chat"] = false, 
				["whispers"] = false, 
				["strings"] = { },
				["lowtie"] = { },
				["hightie"] = { },
				["bans"] = { }
			}
		end
		if(not CrossGambling["lastroll"]) then CrossGambling["lastroll"] = 100; end
		if(not CrossGambling["stats"]) then CrossGambling["stats"] = { }; end
		if(not CrossGambling["joinstats"]) then CrossGambling["joinstats"] = { }; end
		if(not CrossGambling["chat"]) then CrossGambling["chat"] = false; end
		if(not CrossGambling["whispers"]) then CrossGambling["whispers"] = false; end
		if(not CrossGambling["bans"]) then CrossGambling["bans"] = { }; end

		CrossGambling_EditBox:SetText(""..CrossGambling["lastroll"]);

		if(CrossGambling["chat"] == false) then
			CrossGambling_CHAT_Button:SetText("(Guild)");
			chatmethod = "GUILD";
		elseif(CrossGambling["chat"] == true) then
			CrossGambling_CHAT_Button:SetText("(Raid)");
			chatmethod = "RAID";
		end
	

		
		
		
		if(CrossGambling["whispers"] == false) then

			whispermethod = false;
		else
			CrossGambling_WHISPER_Button:SetText("(Whispers)");
			whispermethod = true;
		end

		if(CrossGambling["active"] == 0) then
			CrossGambling_Frame:Show();
		else
			CrossGambling_Frame:Hide();
		end
	end

	-- IF IT'S A RAID MESSAGE... --
	if ((event == "CHAT_MSG_RAID_LEADER" or event == "CHAT_MSG_RAID") and AcceptOnes=="true" and CrossGambling["chat"] == true) then
		
		-- ADDS USER TO THE ROLL POOL - CHECK TO MAKE SURE THEY ARE NOT BANNED --
		if (arg1 == "1") then
			if(CrossGambling_ChkBan(tostring(arg2)) == 0) then
				CrossGambling_Add(tostring(arg2));
				if (not CrossGambling_LASTCALL_Button:IsEnabled() and totalrolls == 1) then
					CrossGambling_LASTCALL_Button:Enable();
				end
				if totalrolls == 2 then
					CrossGambling_AcceptOnes_Button:Disable();
					CrossGambling_AcceptOnes_Button:SetText("Open Entry");
				end
			else
				SendChatMessage("Sorry, but you're banned from the game!", chatmethod);
			end

		elseif(arg1 == "-1") then
			CrossGambling_Remove(tostring(arg2));
			if (CrossGambling_LASTCALL_Button:IsEnabled() and totalrolls == 0) then
				CrossGambling_LASTCALL_Button:Disable();
			end
			if totalrolls == 1 then
				CrossGambling_AcceptOnes_Button:Enable();
				CrossGambling_AcceptOnes_Button:SetText("Open Entry");
			end
		end
	end

	if ((event == "CHAT_MSG_GUILD_LEADER" or event == "CHAT_MSG_GUILD")and AcceptOnes=="true" and CrossGambling["chat"] == false) then
		-- ADDS USER TO THE ROLL POOL - CHECK TO MAKE SURE THEY ARE NOT BANNED --
		if (arg1 == "1") then
			if(CrossGambling_ChkBan(tostring(arg2)) == 0) then
				CrossGambling_Add(tostring(arg2));
				if (not CrossGambling_LASTCALL_Button:IsEnabled() and totalrolls == 1) then
					CrossGambling_LASTCALL_Button:Enable();
				end
				if totalrolls == 2 then
					CrossGambling_AcceptOnes_Button:Disable();
					CrossGambling_AcceptOnes_Button:SetText("Open Entry");
				end
			else
				SendChatMessage("Sorry, but you're banned from the game!", chatmethod);
			end

		elseif(arg1 == "-1") then
			CrossGambling_Remove(tostring(arg2));
			if (CrossGambling_LASTCALL_Button:IsEnabled() and totalrolls == 0) then
				CrossGambling_LASTCALL_Button:Disable();
			end
			if totalrolls == 1 then
				CrossGambling_AcceptOnes_Button:Enable();
				CrossGambling_AcceptOnes_Button:SetText("Open Entry");
			end
		end
	end

	if (event == "CHAT_MSG_SYSTEM" and AcceptRolls=="true") then
		local temp1 = tostring(arg1);
		CrossGambling_ParseRoll(temp1);		
	end	
end


function CrossGambling_ResetStats()
	CrossGambling["stats"] = { };
end


function CrossGambling_OnClickCHAT()
	if(CrossGambling["chat"] == nil) then CrossGambling["chat"] = false; end

	CrossGambling["chat"] = not CrossGambling["chat"];
	
	if(CrossGambling["chat"] == false) then
		CrossGambling_CHAT_Button:SetText("(Guild)");
		chatmethod = "GUILD";
	else
		CrossGambling_CHAT_Button:SetText("(Raid)");
		chatmethod = "RAID";
	end
end

function CrossGambling_OnClickWHISPERS()
	if(CrossGambling["whispers"] == nil) then CrossGambling["whispers"] = false; end

	CrossGambling["whispers"] = not CrossGambling["whispers"];
	
	if(CrossGambling["whispers"] == false) then
		CrossGambling_WHISPER_Button:SetText("(No Whispers)");
		whispermethod = false;
	else
		CrossGambling_WHISPER_Button:SetText("(Whispers)");
		whispermethod = true;
	end
end

function CrossGambling_JoinStats(msg)
	local i = string.find(msg, " ");
	if((not i) or i == -1 or string.find(msg, "[", 1, true) or string.find(msg, "]", 1, true)) then
		ChatFrame1:AddMessage("");
		return;
	end
	local mainname = string.sub(msg, 1, i-1);
	local altname = string.sub(msg, i+1);
	ChatFrame1:AddMessage(string.format("Joined alt '%s' -> main '%s'", altname, mainname));
	CrossGambling["joinstats"][altname] = mainname;
end

function CrossGambling_UnjoinStats(altname)
	if(altname ~= nil and altname ~= "") then
		ChatFrame1:AddMessage(string.format("Unjoined alt '%s' from any other characters", altname));
		CrossGambling["joinstats"][altname] = nil;
	else
		local i, e;
		for i, e in pairs(CrossGambling["joinstats"]) do
			ChatFrame1:AddMessage(string.format("currently joined: alt '%s' -> main '%s'", i, e));
		end
	end
end

function CrossGambling_OnClickSTATS()
	local sortlistname = {};
	local sortlistamount = {};
	local n = 0;
	local i, j, k;

	for i, j in pairs(CrossGambling["stats"]) do
		local name = i;
		if(CrossGambling["joinstats"][strlower(i)] ~= nil) then
			name = CrossGambling["joinstats"][strlower(i)]:gsub("^%l", string.upper);
		end
		for k=0,n do
			if(k == n) then
				sortlistname[n] = name;
				sortlistamount[n] = j;
				n = n + 1;
				break;
			elseif(strlower(name) == strlower(sortlistname[k])) then
				sortlistamount[k] = (sortlistamount[k] or 0) + j;
				break;
			end
		end
	end

	if(n == 0) then
		DEFAULT_CHAT_FRAME:AddMessage("No stats yet!");
		return;
	end

	for i = 0, n-1 do
		for j = i+1, n-1 do
			if(sortlistamount[j] > sortlistamount[i]) then
				sortlistamount[i], sortlistamount[j] = sortlistamount[j], sortlistamount[i];
				sortlistname[i], sortlistname[j] = sortlistname[j], sortlistname[i];
			end
		end
	end

	DEFAULT_CHAT_FRAME:AddMessage("--- CrossGambling Stats ---", chatmethod);

	local x1 = 3-1;
	local x2 = n-3;
	if(x1 >= n) then x1 = n-1; end
	if(x2 <= x1) then x2 = x1+1; end

	for i = 0, x1 do
		sortsign = "won";
		if(sortlistamount[i] < 0) then sortsign = "lost"; end
		SendChatMessage(string.format("%d.  %s %s %d total", i+1, sortlistname[i], sortsign, math.abs(sortlistamount[i])), chatmethod);
	end

	if(x1+1 < x2) then
		SendChatMessage("...", chatmethod);
	end

	for i = x2, n-1 do
		sortsign = "won";
		if(sortlistamount[i] < 0) then sortsign = "lost"; end
		SendChatMessage(string.format("%d.  %s %s %d total", i+1, sortlistname[i], sortsign, math.abs(sortlistamount[i])), chatmethod);
	end
end


function CrossGambling_OnClickROLL()
	if (totalrolls > 0 and AcceptRolls == "true") then
		if table.getn(CrossGambling.strings) ~= 0 then
			CrossGambling_List();
		end	
		return;
	end
	if (totalrolls >1) then
		AcceptOnes = "false";
		AcceptRolls = "true";
		if (tie == 0) then
			SendChatMessage("Roll now!",chatmethod,GetDefaultLanguage("player"));
		end

		if (lowbreak == 1) then
			SendChatMessage(format("%s%d%s", "Low end tiebreaker! Roll 1-", theMax, " now!"),chatmethod,GetDefaultLanguage("player"));
			CrossGambling_List();
		end

		if (highbreak == 1) then
			SendChatMessage(format("%s%d%s", "High end tiebreaker! Roll 1-", theMax, " now!"),chatmethod,GetDefaultLanguage("player"));
			CrossGambling_List();
		end

		CrossGambling_EditBox:ClearFocus();

	end

	if (AcceptOnes == "true" and totalrolls <2) then
		SendChatMessage("Not enough Players!",chatmethod,GetDefaultLanguage("player"));
	end
end

function CrossGambling_OnClickLASTCALL()
	SendChatMessage("Last Call to join!",chatmethod,GetDefaultLanguage("player"));
	CrossGambling_EditBox:ClearFocus();
	CrossGambling_LASTCALL_Button:Disable();
	CrossGambling_ROLL_Button:Enable();
end

function CrossGambling_OnClickACCEPTONES() 
	if CrossGambling_EditBox:GetText() ~= "" and CrossGambling_EditBox:GetText() ~= "1" then
		CrossGambling_Reset();
		CrossGambling_ROLL_Button:Disable();
		CrossGambling_LASTCALL_Button:Disable();
		AcceptOnes = "true";
		local fakeroll = "";
		SendChatMessage(format("%s%s%s%s", ".:Welcome to CrossGambling:. User's Roll - (", CrossGambling_EditBox:GetText(), ") - Type 1 to Join  (-1 to withdraw)", fakeroll),chatmethod,GetDefaultLanguage("player"));
        CrossGambling["lastroll"] = CrossGambling_EditBox:GetText();
		theMax = tonumber(CrossGambling_EditBox:GetText()); 
		low = theMax+1;
		tielow = theMax+1;
		CrossGambling_EditBox:ClearFocus();
		CrossGambling_AcceptOnes_Button:SetText("New Game");
		CrossGambling_LASTCALL_Button:Disable();
		CrossGambling_EditBox:ClearFocus();
	else
		message("Please enter a number to roll from.", chatmethod);
	end
end

function CrossGambling_OnClickRoll() 
hash_SlashCmdList[rollCmd](CrossGambling_EditBox:GetText())
end

function CrossGambling_OnClickRoll1()
	if(CrossGambling["chat"] == false) then
		SendChatMessage("1","Guild");
	else
		SendChatMessage("1","Raid");
	end
end

CG_Settings = {
	MinimapPos = 75 
	
}


-- ** do not call from the mod's OnLoad, VARIABLES_LOADED or later is fine. **
function CG_MinimapButton_Reposition()
	CG_MinimapButton:SetPoint("TOPLEFT","Minimap","TOPLEFT",52-(80*cos(CG_Settings.MinimapPos)),(80*sin(CG_Settings.MinimapPos))-52)
end


function CG_MinimapButton_DraggingFrame_OnUpdate()

	local xpos,ypos = GetCursorPosition()
	local xmin,ymin = Minimap:GetLeft(), Minimap:GetBottom()

	xpos = xmin-xpos/UIParent:GetScale()+70 
	ypos = ypos/UIParent:GetScale()-ymin-70

	CG_Settings.MinimapPos = math.deg(math.atan2(ypos,xpos)) 
	CG_MinimapButton_Reposition() 
end


function CG_MinimapButton_OnClick()
	DEFAULT_CHAT_FRAME:AddMessage(tostring(arg1).." was clicked.")
end

function CrossGambling_Report()
	local goldowed = high - low
	if (goldowed ~= 0) then
		lowname = lowname:gsub("^%l", string.upper)
		highname = highname:gsub("^%l", string.upper)
		local string3 = strjoin(" ", "", lowname, "owes", highname, goldowed,"gold.")

		CrossGambling["stats"][highname] = (CrossGambling["stats"][highname] or 0) + goldowed;
		CrossGambling["stats"][lowname] = (CrossGambling["stats"][lowname] or 0) - goldowed;
	
		SendChatMessage(string3,chatmethod,GetDefaultLanguage("player"));
	else
		SendChatMessage("It was a tie! No payouts on this roll!",chatmethod,GetDefaultLanguage("player"));
	end
	CrossGambling_Reset();
	CrossGambling_AcceptOnes_Button:SetText("Open Entry");
	CrossGambling_CHAT_Button:Enable();
end

function CrossGambling_Tiebreaker()
	tierolls = 0;
	totalrolls = 0;
	tie = 1;
	if table.getn(CrossGambling.lowtie) == 1 then
		CrossGambling.lowtie = {};
	end
	if table.getn(CrossGambling.hightie) == 1 then
		CrossGambling.hightie = {};
	end
	totalrolls = table.getn(CrossGambling.lowtie) + table.getn(CrossGambling.hightie);
	tierolls = totalrolls;
	if (table.getn(CrossGambling.hightie) == 0 and table.getn(CrossGambling.lowtie) == 0) then
		CrossGambling_Report();
	else
		AcceptRolls = "false";
		if table.getn(CrossGambling.lowtie) > 0 then
			lowbreak = 1;
			highbreak = 0;
			tielow = theMax+1;
			tiehigh = 0;
			CrossGambling.strings = CrossGambling.lowtie;
			CrossGambling.lowtie = {};
			CrossGambling_OnClickROLL();			
		end
		if table.getn(CrossGambling.hightie) > 0  and table.getn(CrossGambling.strings) == 0 then
			lowbreak = 0;
			highbreak = 1;
			tielow = theMax+1;
			tiehigh = 0;
			CrossGambling.strings = CrossGambling.hightie;
			CrossGambling.hightie = {};
			CrossGambling_OnClickROLL();
		end
	end
end

function CrossGambling_ParseRoll(temp2)
	local temp1 = strlower(temp2);

	local player, junk, roll, range = strsplit(" ", temp1);

	if junk == "rolls" and CrossGambling_Check(player)==1 then
		minRoll, maxRoll = strsplit("-",range);
		minRoll = tonumber(strsub(minRoll,2));
		maxRoll = tonumber(strsub(maxRoll,1,-2));
		roll = tonumber(roll);
		if (maxRoll == theMax and minRoll == 1) then
			if (tie == 0) then
				if (roll == high) then
					if table.getn(CrossGambling.hightie) == 0 then
						CrossGambling_AddTie(highname, CrossGambling.hightie);
					end
					CrossGambling_AddTie(player, CrossGambling.hightie);
				end
				if (roll>high) then
					highname = player
					highplayername = player
					if (high == 0) then
						high = roll
						if (whispermethod) then
							SendChatMessage(string.format("You have the HIGHEST roll so far: %s and you might win a max of %sg", roll, (high - 1)),"WHISPER",GetDefaultLanguage("player"),player);
						end
					else
						high = roll
						if (whispermethod) then
							SendChatMessage(string.format("You have the HIGHEST roll so far: %s and you might win %sg from %s", roll, (high - low), lowplayername),"WHISPER",GetDefaultLanguage("player"),player);
							SendChatMessage(string.format("%s now has the HIGHEST roller so far: %s and you might owe him/her %sg", player, roll, (high - low)),"WHISPER",GetDefaultLanguage("player"),lowplayername);
						end
					end
					CrossGambling.hightie = {};
			
				end
				if (roll == low) then
					if table.getn(CrossGambling.lowtie) == 0 then
						CrossGambling_AddTie(lowname, CrossGambling.lowtie);
					end
					CrossGambling_AddTie(player, CrossGambling.lowtie);
				end
				if (roll<low) then 
					lowname = player
					lowplayername = player
					low = roll
					if (high ~= low) then
						if (whispermethod) then
							SendChatMessage(string.format("You have the LOWEST roll so far: %s and you might owe %s %sg ", roll, highplayername, (high - low)),"WHISPER",GetDefaultLanguage("player"),player);
						end
					end
					CrossGambling.lowtie = {};				
			
				end
			else
				if (lowbreak == 1) then
					if (roll == tielow) then
						
						if table.getn(CrossGambling.lowtie) == 0 then
							CrossGambling_AddTie(lowname, CrossGambling.lowtie);
						end
						CrossGambling_AddTie(player, CrossGambling.lowtie);
					end
					if (roll<tielow) then 
						lowname = player
						tielow = roll;
						CrossGambling.lowtie = {};				
		
					end
				end
				if (highbreak == 1) then
					if (roll == tiehigh) then
						if table.getn(CrossGambling.hightie) == 0 then
							CrossGambling_AddTie(highname, CrossGambling.hightie);
						end
						CrossGambling_AddTie(player, CrossGambling.hightie);
					end
					if (roll>tiehigh) then
						highname = player
						tiehigh = roll;
						CrossGambling.hightie = {};
			
					end
				end
			end
			CrossGambling_Remove(tostring(player));
			totalentries = totalentries + 1;

			if table.getn(CrossGambling.strings) == 0 then
				if tierolls == 0 then
					CrossGambling_Report();
				else
					if totalentries == 2 then
						CrossGambling_Report();
					else
						CrossGambling_Tiebreaker();
					end
				end
			end
		end	
	end
end

function CrossGambling_Check(player)
	for i=1, table.getn(CrossGambling.strings) do
		if strlower(CrossGambling.strings[i]) == tostring(player) then
			return 1
		end
	end
	return 0
end

function CrossGambling_List()
	for i=1, table.getn(CrossGambling.strings) do
	  	local string3 = strjoin(" ", "", tostring(CrossGambling.strings[i]):gsub("^%l", string.upper),"still needs to roll.")
		SendChatMessage(string3,chatmethod,GetDefaultLanguage("player"));
	end
end

function CrossGambling_ListBan()
	local bancnt = 0;
	Print("", "", "|cffffff00To ban do /cg ban (Name) or to unban /cg unban (Name) - The Current Bans:");
	for i=1, table.getn(CrossGambling.bans) do
		bancnt = 1;
		DEFAULT_CHAT_FRAME:AddMessage(strjoin("|cffffff00", "...", tostring(CrossGambling.bans[i])));
	end
	if (bancnt == 0) then
		DEFAULT_CHAT_FRAME:AddMessage("|cffffff00To ban do /cg ban (Name) or to unban /cg unban (Name).");
	end
end

function CrossGambling_Add(name)
	local charname, realmname = strsplit("-",name);
	local insname = strlower(charname);
	if (insname ~= nil or insname ~= "") then
		local found = 0;
		for i=1, table.getn(CrossGambling.strings) do
		  	if CrossGambling.strings[i] == insname then
				found = 1;
			end
        	end
		if found == 0 then
		      	table.insert(CrossGambling.strings, insname)
			totalrolls = totalrolls+1
		end
	end
end

function CrossGambling_ChkBan(name)
	local charname, realmname = strsplit("-",name);
	local insname = strlower(charname);
	if (insname ~= nil or insname ~= "") then
		for i=1, table.getn(CrossGambling.bans) do
			if strlower(CrossGambling.bans[i]) == strlower(insname) then
				return 1
			end
		end
	end
	return 0
end

function CrossGambling_AddBan(name)
	local charname, realmname = strsplit("-",name);
	local insname = strlower(charname);
	if (insname ~= nil or insname ~= "") then
		local banexist = 0;
		for i=1, table.getn(CrossGambling.bans) do
			if CrossGambling.bans[i] == insname then
				Print("", "", "|cffffff00Unable to add to ban list - user already banned.");
				banexist = 1;
			end
		end
		if (banexist == 0) then
			table.insert(CrossGambling.bans, insname)
			Print("", "", "|cffffff00User is now banned!");
			local string3 = strjoin(" ", "", "User Banned from rolling! -> ",insname, "!")
			DEFAULT_CHAT_FRAME:AddMessage(strjoin("|cffffff00", string3));
		end
	else
		Print("", "", "|cffffff00Error: No name provided.");
	end
end

function CrossGambling_RemoveBan(name)
	local charname, realmname = strsplit("-",name);
	local insname = strlower(charname);
	if (insname ~= nil or insname ~= "") then
		for i=1, table.getn(CrossGambling.bans) do
			if strlower(CrossGambling.bans[i]) == strlower(insname) then
				table.remove(CrossGambling.bans, i)
				Print("", "", "|cffffff00User removed from ban successfully.");
				return;
			end
		end
	else
		Print("", "", "|cffffff00Error: No name provided.");
	end
end
				
function CrossGambling_AddTie(name, tietable)
	local charname, realmname = strsplit("-",name);
	local insname = strlower(charname);
	if (insname ~= nil or insname ~= "") then
		local found = 0;
		for i=1, table.getn(tietable) do
		  	if tietable[i] == insname then
				found = 1;
			end
        	end
		if found == 0 then
		    table.insert(tietable, insname)
			tierolls = tierolls+1	
			totalrolls = totalrolls+1		
		end
	end
end

function CrossGambling_Remove(name)
	local charname, realmname = strsplit("-",name);
	local insname = strlower(charname);
	for i=1, table.getn(CrossGambling.strings) do
		if CrossGambling.strings[i] ~= nil then
		  	if strlower(CrossGambling.strings[i]) == strlower(insname) then
				table.remove(CrossGambling.strings, i)
				totalrolls = totalrolls - 1;
			end
		end
      end
end

function CrossGambling_RemoveTie(name, tietable)
	local charname, realmname = strsplit("-",name);
	local insname = strlower(charname);
	for i=1, table.getn(tietable) do
		if tietable[i] ~= nil then
		  	if strlower(tietable[i]) == insname then
				table.remove(tietable, i)
			end
		end
      end
end

function CrossGambling_Reset()
		CrossGambling["strings"] = { };
		CrossGambling["lowtie"] = { };
		CrossGambling["hightie"] = { };
		AcceptOnes = "false"
		AcceptRolls = "false"
		totalrolls = 0
		theMax = 0
		tierolls = 0;
		lowname = ""
		highname = ""
		low = theMax
		high = 0
		tie = 0
		highbreak = 0;
		lowbreak = 0;
		tiehigh = 0;
		tielow = 0;
		totalentries = 0;
		highplayername = "";
		lowplayername = "";
		CrossGambling_ROLL_Button:Disable();
		CrossGambling_AcceptOnes_Button:Enable();		
		CrossGambling_LASTCALL_Button:Disable();
		CrossGambling_CHAT_Button:Enable();
end

function CrossGambling_ResetCmd()
	SendChatMessage(".:CrossGambling:. Game has been reset", chatmethod)	
end

function CrossGambling_EditBox_OnLoad()
	CrossGambling_EditBox:SetNumeric(true);
	CrossGambling_EditBox:SetAutoFocus(false);
end

