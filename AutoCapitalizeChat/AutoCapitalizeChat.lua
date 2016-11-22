local current, msg, words, find = _, _, AutoCap_Words, string.find
local capnextletter = 1
local autoCapChatOn = 1
local frame = CreateFrame("FRAME"); -- Need a frame to respond to events
frame:RegisterEvent("ADDON_LOADED"); -- Fired when saved variables are loaded
frame:RegisterEvent("PLAYER_LOGOUT"); -- Fired when about to log out

SLASH_AUTOCAP1 = "/acc"
SLASH_AUTOCAP2 = "/autocapitalizechat"
SLASH_AUTOCAP3 = "/autocapchat"

local function handler(msg)
	if msg == "on" then
		setCapChatOn()
	elseif msg == "off" then
		setCapChatOff()
	else
		ChatFrame1:AddMessage("AutoCapitalizeChat commands:")
		ChatFrame1:AddMessage("/acc, /autocapchat, /autocapitalizechat - Show this message.")
		if autoCapChatOn == 1 then
			ChatFrame1:AddMessage("/acc [ON/off] - Toggle AutoCapitalizeChat on/off.")
		else
			ChatFrame1:AddMessage("/acc [on/OFF] - Toggle AutoCapitalizeChat on/off.")
		end
	end
end

SlashCmdList["AUTOCAP"] = handler

function setCapChatOn()
	autoCapChatOn = 1
	ChatFrame1:AddMessage("AutoCapitalizeChat is now on")
end

function setCapChatOff()
	autoCapChatOn = 0
	ChatFrame1:AddMessage("AutoCapitalizeChat is now off")
end

ChatFrame1EditBox:SetScript("OnTextChanged", function()
	current = ChatFrame1EditBox:GetText()
	if (autoCapChatOn == 1 and current:sub(1,1) ~= "/") then
		if (current:len() == 1 or lastCharIsEnd()) then
			capnextletter = 1
		else
			capnextletter = 0
		end
		if (current:sub(-1,-1):find("%l") and capnextletter == 1) then
			msg = current:sub(1, -2)..current:sub(-1,-1):upper()
			ChatFrame1EditBox:SetText(msg)
			capnextletter = 0
		end
		current = ChatFrame1EditBox:GetText()
		for k,v in pairs(words) do
			if current:find(" "..k, 1, true) then
				msg = current:gsub(literalize(" "..k), " "..v)
				ChatFrame1EditBox:SetText(msg)
			elseif (not current:find(" .") and current:sub(1,1):find("I") and current:find(k, 1, true)) then
				msg = current:gsub(literalize(k), v)
				ChatFrame1EditBox:SetText(msg)
			end
		end
	end
end)

function literalize(str)
    return str:gsub("[%(%)%.%%%+%-%*%?%[%]%^%$]", function(c) return "%" .. c end)
end


function lastCharIsEnd()
	local str = current
	str = str:gsub(" ", ""):sub(1,-2)
	if (str:sub(-1,-1) == "." or str:sub(-1,-1) == "!" or str:sub(-1,-1) == "?") then
		return true
	else
		return false
	end
end

function frame:OnEvent(event, arg1)
	if event == "ADDON_LOADED" and arg1 == "AutoCapitalizeChat" then
	-- Our saved variables are ready at this point. If there are none, both variables will set to nil.
		if AutoCapChatOn == nil then
			autoCapChatOn = 1
		else
			autoCapChatOn = AutoCapChatOn
		end
	elseif event == "PLAYER_LOGOUT" then
		AutoCapChatOn = autoCapChatOn
	end
end

frame:SetScript("OnEvent", frame.OnEvent);