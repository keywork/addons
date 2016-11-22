if IsAddOnLoaded('Tukui') then return end

-- Code taken from ElvUI
-- buy max number value with alt
local savedMerchantItemButton_OnModifiedClick = MerchantItemButton_OnModifiedClick
function MerchantItemButton_OnModifiedClick(self, ...)
	if ( IsAltKeyDown() ) then
		local itemLink = GetMerchantItemLink(self:GetID())
		if not itemLink then return end
		local maxStack = select(8, GetItemInfo(itemLink))
		if ( maxStack and maxStack > 1 ) then
			BuyMerchantItem(self:GetID(), GetMerchantItemMaxStack(self:GetID()))
		end
	end
	savedMerchantItemButton_OnModifiedClick(self, ...)
end