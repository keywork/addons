if IsAddOnLoaded('Tukui') then return; end --Tukui already removes texture

--Code Taken from Tukui v16
local RemoveTexture = function(self, texture)
	if texture and (string.sub(texture, 1, 9) == "Interface" or string.sub(texture, 1, 9) == "INTERFACE") then
		self:SetTexture("")
	end
end
hooksecurefunc(DraenorZoneAbilityFrame.SpellButton.Style, 'SetTexture', RemoveTexture)
hooksecurefunc(ExtraActionButton1.style, 'SetTexture', RemoveTexture)