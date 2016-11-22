
local f = CreateFrame("frame","xanReplaceEnchant",UIParent)
f:SetScript("OnEvent", function(self, event, ...) if self[event] then return self[event](self, event, ...) end end)

----------------------
--      Enable      --
----------------------

function f:PLAYER_LOGIN()

	if not XanRE_DB then XanRE_DB = {} end
	if XanRE_DB.enable == nil then XanRE_DB.enable = 1 end

	self:RegisterEvent("REPLACE_ENCHANT")

	SLASH_XANREPLACEENCHANT1 = "/xanre";
	SlashCmdList["XANREPLACEENCHANT"] = xanRE_SlashCommand;
	
	local ver = GetAddOnMetadata("xanReplaceEnchant","Version") or '1.0'
	DEFAULT_CHAT_FRAME:AddMessage(string.format("|cFF99CC33%s|r [v|cFFDF2B2B%s|r] loaded:   /xanre", "xanReplaceEnchant", ver or "1.0"))
	
	self:UnregisterEvent("PLAYER_LOGIN")
	self.PLAYER_LOGIN = nil
end

function xanRE_SlashCommand(cmd)
	if XanRE_DB.enable == 1 then
		XanRE_DB.enable = 0
		DEFAULT_CHAT_FRAME:AddMessage("xanReplaceEnchant: Auto replace is OFF");
	else
		XanRE_DB.enable = 1
		DEFAULT_CHAT_FRAME:AddMessage("xanReplaceEnchant: Auto replace is ON");
	end
end

------------------------------
--      Event Handlers      --
------------------------------

function f:REPLACE_ENCHANT(self, oldE, newE)
	if XanRE_DB.enable == 0 then return end
	
	ReplaceEnchant()
	StaticPopup1Button1:Click()
end

if IsLoggedIn() then f:PLAYER_LOGIN() else f:RegisterEvent("PLAYER_LOGIN") end
