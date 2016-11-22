--[[--------------------------------------------------------------------
	ConfirmLeaveParty
	Asks for confirmation when leaving a group inside an instance.
	Copyright (c) 2010-2014 Phanx <addons@phanx.net>. All rights reserved.
	See the accompanying README and LICENSE files for more information.
	http://www.wowinterface.com/downloads/info16676-ConfirmLeaveParty.html
	http://www.curse.com/addons/wow/confirmleaveparty
----------------------------------------------------------------------]]

local CONFIRM_LEAVE_PARTY = "Do you really want to leave the group?"

if GetLocale() == "deDE" then
	CONFIRM_LEAVE_PARTY = "Willst du wirklich die Gruppe verlassen?" -- by Shantalya @ WoWI
elseif GetLocale() == "esES" or GetLocale() == "esMX" then
	CONFIRM_LEAVE_PARTY = "¿Realmente quieres dejar el grupo?"
elseif GetLocale() == "frFR" then
	CONFIRM_LEAVE_PARTY = "Voulez-vous vraiment quitter le groupe?"
elseif GetLocale() == "itIT" then
	CONFIRM_LEAVE_PARTY = "Vuoi davvero abbandonare il gruppo?"
elseif GetLocale() == "ptBR" then
	CONFIRM_LEAVE_PARTY = "Tem certeza de que deseja sair o grupo?"
elseif GetLocale() == "ruRU" then
	CONFIRM_LEAVE_PARTY = "Вы действительно хотите выйти из группы?"
elseif GetLocale() == "koKR" then
	CONFIRM_LEAVE_PARTY = "정말 이 파티를 떠나시겠습니까?"
elseif GetLocale() == "zhCN" then
	CONFIRM_LEAVE_PARTY = "难道你真的想离开组吗?"
elseif GetLocale() == "zhTW" then
	CONFIRM_LEAVE_PARTY = "難道你真的想離開組嗎?"
end

------------------------------------------------------------------------

local ReallyLeaveParty = LeaveParty

StaticPopupDialogs["CONFIRM_LEAVE_PARTY"] = {
	text = CONFIRM_LEAVE_PARTY,
	button1 = YES,
	button2 = NO,
	enterClicksFirstButton = 1, -- YES on enter
	hideOnEscape = 1, -- NO on escape
	timeout = 0,
	preferredIndex = 3, -- helps prevent taint; see http://forums.wowace.com/showthread.php?t=19960
	OnAccept = ReallyLeaveParty,
}

LeaveParty = function()
	if IsInGroup() or IsInRaid() then
		local _, instanceType = IsInInstance()
		if instanceType == "party" or instanceType == "raid" then
			return StaticPopup_Show("CONFIRM_LEAVE_PARTY")
		end
		ReallyLeaveParty()
	end
end

StaticPopupDialogs.CONFIRM_LEAVE_INSTANCE_PARTY.OnAccept = ReallyLeaveParty
StaticPopupDialogs.CONFIRM_LEAVE_INSTANCE_PARTY.preferredIndex = 3