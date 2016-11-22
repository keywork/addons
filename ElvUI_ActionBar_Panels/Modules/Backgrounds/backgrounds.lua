---Credits to DarthPredator for letting me use his code.

local E, L, V, P, G, _ =  unpack(ElvUI);
local BG = E:NewModule('BackGrounds', 'AceHook-3.0', 'AceEvent-3.0');

local BGb = CreateFrame('Frame', "BottomBG", E.UIParent);
local BGl = CreateFrame('Frame', "LeftBG", E.UIParent);
local BGr = CreateFrame('Frame', "RightBG", E.UIParent);

local Tn = {
	BottomBG = {BGb,"BottomBG"},
	LeftBG = {BGl,"LeftBG"},
	RightBG = {BGr,"RightBG"},
}


function BG:SetTemplate()
	local db = E.db.datatexts.Backgrounds
	for _,v in pairs(Tn) do
		v[1]:SetFrameLevel(1)
		v[1]:SetTemplate('Default', true)
		v[1]:SetScript("OnShow", function() v[1]:SetFrameStrata('BACKGROUND') end)
		v[1]:Hide()
	end
	if E.db.datatexts.Backgrounds.LeftBG.Template == "DEFAULT" then
		BGl:SetTemplate('Default', true)
	elseif E.db.datatexts.Backgrounds.LeftBG.Template == "TRANSPARENT" then
		BGl:SetTemplate('Transparent', true)
	elseif E.db.datatexts.Backgrounds.LeftBG.Template == "CColor" then
		BGl:SetTemplate('ClassColor', true)
	end
	
	if E.db.datatexts.Backgrounds.RightBG.Template == "DEFAULT" then
		BGr:SetTemplate('Default', true)
	elseif E.db.datatexts.Backgrounds.RightBG.Template == "TRANSPARENT" then
		BGr:SetTemplate('Transparent', true)
	elseif E.db.datatexts.Backgrounds.RightBG.Template == "CColor" then
		BGr:SetTemplate('ClassColor', true)
	end
	
	if E.db.datatexts.Backgrounds.BottomBG.Template == "DEFAULT" then
		BGb:SetTemplate('Default', true)
	elseif E.db.datatexts.Backgrounds.BottomBG.Template == "TRANSPARENT" then
		BGb:SetTemplate('Transparent', true)
	elseif E.db.datatexts.Backgrounds.BottomBG.Template == "CColor" then
		BGb:SetTemplate('ClassColor', true)
	end
end

function BG:FramesSize()
	local db = E.db.datatexts.Backgrounds
	for _,v in pairs(Tn) do
		v[1]:SetSize(db[v[2]].Width, db[v[2]].Height)
	end
end

function BG:FramesPositions()
	BGb:Point("BOTTOM", E.UIParent, "BOTTOM", 0 + E.db.datatexts.Backgrounds.BottomBG.XOff, 21 + E.db.datatexts.Backgrounds.BottomBG.YOff); 
	BGl:Point("BOTTOMRIGHT", E.UIParent, "BOTTOM", -(E.screenwidth/4 + 32)/2 - 1 + E.db.datatexts.Backgrounds.LeftBG.XOff, 21 + E.db.datatexts.Backgrounds.LeftBG.YOff); 
	BGr:Point("BOTTOMLEFT", E.UIParent, "BOTTOM", (E.screenwidth/4 + 32)/2 + 1 + E.db.datatexts.Backgrounds.RightBG.XOff, 21 + E.db.datatexts.Backgrounds.RightBG.YOff); 
end


function BG:FramesVisibility()
	local db = E.db.datatexts.Backgrounds
	for _,v in pairs(Tn) do
		if db[v[2]].Enabled then
			v[1]:Show()
		else
			v[1]:Hide()
		end
	end
end

function BG:UpdateFrames()
	BG:FramesSize()
	BG:FramesPositions()
	BG:FramesVisibility()
end

function BG:RegisterHide()
	local db = E.db.datatexts.Backgrounds
	for k,v in pairs(Tn) do
		if db[v[2]].PetHide then
			E.FrameLocks[k] = true
		else
			E.FrameLocks[k] = nil
		end
	end
end

function BG:Initialize()
	BG:SetTemplate()
	BG:UpdateFrames()
	BG:RegisterHide()
end

E:RegisterModule(BG:GetName())