local E, L, V, P, G, _ = unpack(ElvUI); --Inport: Engine, Locales, PrivateDB, ProfileDB, GlobalDB, Localize Underscore
local TRAB = E:NewModule('TransparentBackdrops');

function TRAB:TransBack()
	-- Actionbar backdrops
	for i = 1, 10 do
		local transBars = {_G["ElvUI_Bar"..i]}
		for _, frame in pairs(transBars) do
			if frame.backdrop then
				frame.backdrop:SetTemplate('Transparent')
			end
		end	
		
		-- Buttons
		for k = 1, 12 do
			local buttonBars = {_G["ElvUI_Bar"..i.."Button"..k]}
			for _, button in pairs(buttonBars) do
				if button.backdrop then
					button.backdrop:SetTemplate('Transparent')
				end
			end
		end	
	end

	-- Other bar backdrops
	local transOtherBars = {ElvUI_BarPet, ElvUI_StanceBar, ElvUI_TotemBar, ElvUIBags}
	for _, frame in pairs(transOtherBars) do
		if frame.backdrop then
			frame.backdrop:SetTemplate('Transparent')
		end
	end
	
	-- Pet Buttons
	for i = 1, NUM_PET_ACTION_SLOTS do
		local petButtons = {_G["PetActionButton"..i]}
		for _, button in pairs(petButtons) do
			if button.backdrop then
				button.backdrop:SetTemplate('Transparent')
			end
		end
	end
end

function TRAB:Initialize()
	C_Timer.After(0.3, TRAB.TransBack)
end

E:RegisterModule(TRAB:GetName())