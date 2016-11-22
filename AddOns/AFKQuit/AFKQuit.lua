--[[

AFK Quit

This addon will call ForceQuit() right before you are supposed to be 
logged out for beeing Idle. This will return you back to your OS instead 
of going to the character selection screen and then beeing dropped back 
to the login screen.

The idea is to avoid running your graphics card at 100% GPU all night 
when you fall asleep without logging out. It also allows your OS to 
start its screen saver or power down the monitor (and other hardware 
devices)

]]


local afkq = {}


--
--
function afkq.OnEvent(self, event, arg1)
	if ( event == "CHAT_MSG_SYSTEM" ) then
		if ( arg1 and arg1 == IDLE_MESSAGE ) then
			ForceQuit()
		end
	end
end


-- setup
--
afkq.frame = CreateFrame("Frame", "afkQuit", UIParent)
afkq.frame:RegisterEvent("CHAT_MSG_SYSTEM")
afkq.frame:SetScript("OnEvent", afkq.OnEvent)
afkq.frame:Show()
