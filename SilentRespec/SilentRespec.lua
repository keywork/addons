function SilentRespecOptionsFrame_OnLoad(panel)
	panel.name = "SilentRespec v" .. GetAddOnMetadata("SilentRespec", "Version");
	panel.okay =  function (self) SilentRespecOptionsFrame_Okay(); end;
	panel.cancel = function (self) SilentRespecOptionsFrame_Cancel(); end;
	InterfaceOptions_AddCategory(panel);
end

function SilentRespecOptionsFrame_Okay(panel)
	hidelearndual = SilentRespecOptionsFrame_CheckboxLearnDual:GetChecked();
	hideunlearndual = SilentRespecOptionsFrame_CheckboxUnlearnDual:GetChecked();
	hidelearnrespec = SilentRespecOptionsFrame_CheckboxLearnRespec:GetChecked();
	hideunlearnrespec = SilentRespecOptionsFrame_CheckboxUnlearnRespec:GetChecked();
	hidepetlearn = SilentRespecOptionsFrame_CheckboxPetLearn:GetChecked();
	hidepetunlearn = SilentRespecOptionsFrame_CheckboxPetUnlearn:GetChecked();
	hidetitles = SilentRespecOptionsFrame_CheckboxHideTitles:GetChecked();
end

function SilentRespecOptionsFrame_Cancel(panel)
	SilentRespecOptionsFrame_CheckboxLearnDual:SetChecked(hidelearndual);
	SilentRespecOptionsFrame_CheckboxUnlearnDual:SetChecked(hideunlearndual);
	SilentRespecOptionsFrame_CheckboxLearnRespec:SetChecked(hidelearnrespec);
	SilentRespecOptionsFrame_CheckboxUnlearnRespec:SetChecked(hideunlearnrespec);
	SilentRespecOptionsFrame_CheckboxPetLearn:SetChecked(hidepetlearn);
	SilentRespecOptionsFrame_CheckboxPetUnlearn:SetChecked(hidepetunlearn);
	SilentRespecOptionsFrame_CheckboxHideTitles:SetChecked(hidetitles);
end

function SilentRespecOptions_SlashCmdHandler(command)
	InterfaceOptionsFrame_OpenToCategory(SilentRespecOptionsFrame);
end

function SilentRespec_OnLoad()
	SlashCmdList["SILENTRESPEC_OPTIONS"] = SilentRespecOptions_SlashCmdHandler;
    SLASH_SILENTRESPEC_OPTIONS1 = "/silentrespec";
	SLASH_SILENTRESPEC_OPTIONS2 = "/sr";
end

local changingspec = false;
local learnspellmsg = "^" .. string.gsub(ERR_LEARN_SPELL_S, "%%s", ".*") .. "$"
local learnabilitymsg = "^" .. string.gsub(ERR_LEARN_ABILITY_S, "%%s", ".*") .. "$"
local learnpassivemsg= "^" .. string.gsub(ERR_LEARN_PASSIVE_S, "%%s", ".*") .. "$"
local unlearnspellmsg = "^" .. string.gsub(ERR_SPELL_UNLEARNED_S, "%%s", ".*") .. "$"
local petlearnspellmsg = "^" .. string.gsub(ERR_PET_LEARN_SPELL_S, "%%s", ".*") .. "$"
local petlearnabilitymsg = "^" .. string.gsub(ERR_PET_LEARN_ABILITY_S, "%%s", ".*") .. "$"
local petunlearnspellmsg = "^" .. string.gsub(ERR_PET_SPELL_UNLEARNED_S, "%%s", ".*") .. "$"
local gaintitlemsg = "^" .. string.gsub(NEW_TITLE_EARNED, "%%s", ".*") .. "$"
local losetitlemsg = "^" .. string.gsub(OLD_TITLE_LOST, "%%s", ".*") .. "$"
function TalentSpam(self, event, ...)
	local msg = ...;
	-- If System Chat Message is "You have Learned..."
	if strfind(msg, learnspellmsg) or strfind(msg, learnabilitymsg) or strfind(msg, learnpassivemsg)  then
		-- If option for hiding "Learned" messages is set for dual or respec and if for dual spec player is changing between dual specs.
		if (hidelearndual and changingspec) or (hidelearnrespec and not changingspec) then
			return true
		end
	-- If System Chat Message is "You have unlearned..."
	elseif strfind(msg, unlearnspellmsg) then
		-- If option for hiding "Unlearned" messages is set for dual or respec and if for dual spec player is changing between dual specs.
		if (hideunlearndual and changingspec) or (hideunlearnrespec and not changingspec) then
			return true
		end
	-- If System Chat Message is "Your pet has learned..."
	elseif strfind(msg, petlearnspellmsg) or strfind(msg, petlearnabilitymsg) then
		-- If option for hiding pet "Learned" messages is set.
		if (hidepetlearn) then
			return true
		end
	-- If System Chat Message is "Your pet has unlearned..."
	elseif strfind(msg, petunlearnspellmsg) then
		-- If option for hiding pet "Unlearned" messages is set.
		if (hidepetunlearn) then
			return true
		end
	-- If System Chat Message is "You have lost the title..." or "You have earned the title..."
	elseif strfind(msg, gaintitlemsg) or strfind(msg, losetitlemsg) then
		-- If option for hiding "Titles" messages is set.
		if (hidetitles) then
			return true
		end
	end
end

local spellcastprimaryspec = GetSpellInfo(63645);
local spellcastsecondaryspec = GetSpellInfo(63644);
function SilentRespec_OnEvent(event, ...)
	local arg1, arg2 = ...;
	if event == "ADDON_LOADED" and arg1 == "SilentRespec" then
		if (not alreadybeenrun) and (hidelearndual or hideunlearndual or hidelearnrespec or hideunlearnrespec or hidepetlearn or hidepetunlearn or hidetitles) then
			alreadybeenrun = true;
		end
		if (alreadybeenrun) then
			SilentRespecOptionsFrame_CheckboxLearnDual:SetChecked(hidelearndual);
			SilentRespecOptionsFrame_CheckboxUnlearnDual:SetChecked(hideunlearndual);
			SilentRespecOptionsFrame_CheckboxLearnRespec:SetChecked(hidelearnrespec);
			SilentRespecOptionsFrame_CheckboxUnlearnRespec:SetChecked(hideunlearnrespec);
			SilentRespecOptionsFrame_CheckboxPetLearn:SetChecked(hidepetlearn);
			SilentRespecOptionsFrame_CheckboxPetUnlearn:SetChecked(hidepetunlearn);
			SilentRespecOptionsFrame_CheckboxHideTitles:SetChecked(hidetitles);
		else
			hidelearndual = SilentRespecOptionsFrame_CheckboxLearnDual:GetChecked();
			hideunlearndual = SilentRespecOptionsFrame_CheckboxUnlearnDual:GetChecked();
			hidelearnrespec = SilentRespecOptionsFrame_CheckboxLearnRespec:GetChecked();
			hideunlearnrespec = SilentRespecOptionsFrame_CheckboxUnlearnRespec:GetChecked();
			hidepetlearn = SilentRespecOptionsFrame_CheckboxPetLearn:GetChecked();
			hidepetunlearn = SilentRespecOptionsFrame_CheckboxPetUnlearn:GetChecked();
			hidetitles = SilentRespecOptionsFrame_CheckboxHideTitles:GetChecked();
			alreadybeenrun = true;
		end
		ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", TalentSpam);
		DEFAULT_CHAT_FRAME:AddMessage("SilentRespec v" .. GetAddOnMetadata("SilentRespec", "Version") .. " loaded. /sr or /silentrespec for Options.");		
	end
	-- If player starts casting spell to change dual spec.
	if event == "UNIT_SPELLCAST_START" and arg1 == "player"
		and	(arg2 == spellcastprimaryspec or arg2 == spellcastsecondaryspec) then
		changingspec = true;
	end
	-- If player has finished or interrupted casting dual spec.
	if (event == "UNIT_SPELLCAST_STOP" or event == "UNIT_SPELLCAST_SUCCEEDED") and arg1 == "player"
		and	(arg2 == spellcastprimaryspec or arg2 == spellcastsecondaryspec) then
		changingspec = false;
	end
end
