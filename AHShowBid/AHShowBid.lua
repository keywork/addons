--------------------------------------------------------------------------------------------------------
--                                        AH_ShowBid variables                                        --
--------------------------------------------------------------------------------------------------------
local L = LibStub("AceLocale-3.0"):GetLocale("AHShowBid")
local addon = CreateFrame('GameTooltip')

--------------------------------------------------------------------------------------------------------
--                                  AH_ShowBid hooked functions                                       --
--------------------------------------------------------------------------------------------------------

-- for LoD addons
if not IsAddOnLoaded('Blizzard_AuctionUI') then
	local function OnEvent(self, event, addonName)
		if ( addonName == 'Blizzard_AuctionUI' ) then
			hooksecurefunc("AuctionFrameBrowse_Update", AuctionFrameBrowse_hook)
			hooksecurefunc("AuctionFrameBid_Update", AuctionFrameBid_hook)
			hooksecurefunc("AuctionFrameAuctions_Update", AuctionFrameAuctions_hook)
			self:SetScript('OnEvent', nil)
			OnEvent = nil
		end
	end

	addon:SetScript('OnEvent', OnEvent)
	addon:RegisterEvent('ADDON_LOADED')
end

-- Hook browse tab
function AuctionFrameBrowse_hook()
	local numBatchAuctions, totalAuctions = GetNumAuctionItems("list")
	local offset = FauxScrollFrame_GetOffset(BrowseScrollFrame)
	local index
	for i=1, NUM_BROWSE_TO_DISPLAY do
		index = offset + i + (NUM_AUCTION_ITEMS_PER_PAGE * AuctionFrameBrowse.page)
		if index > numBatchAuctions + (NUM_AUCTION_ITEMS_PER_PAGE * AuctionFrameBrowse.page) then
			return
		end
		local name, texture, count, quality, canUse, level, levelColHeader, minBid, minIncrement, buyoutPrice, bidAmount, highBidder, bidderFullName, owner, ownerFullName, saleStatus, itemId, hasAllInfo =  GetAuctionItemInfo("list", offset + i)
		if bidAmount > 0 then
			local button = _G["BrowseButton"..i.."Name"]
			button:SetText(name.."|cffffff00".." ("..L["bid"]..")".."|r")
		end
	end
end

-- Hook Bids tab
function AuctionFrameBid_hook()
	local numBatchAuctions, totalAuctions = GetNumAuctionItems("bidder")
	local offset = FauxScrollFrame_GetOffset(BidScrollFrame)
	local index
	for i=1, NUM_BIDS_TO_DISPLAY do
		index = offset + i
		if index > numBatchAuctions then
			return
		end
		local name, texture, count, quality, canUse, level, levelColHeader, minBid, minIncrement, buyoutPrice, bidAmount, highBidder, bidderFullName, owner, ownerFullName, saleStatus, itemId, hasAllInfo =  GetAuctionItemInfo("bidder", index)
		if bidAmount > 0 then
			local button = _G["BidButton"..i.."Name"]
			button:SetText(name.."|cffffff00".." ("..L["bid"]..")".."|r")
		end
	end
end

-- Hook Auctions tab
function AuctionFrameAuctions_hook()
	local numBatchAuctions, totalAuctions = GetNumAuctionItems("owner")
	local offset = FauxScrollFrame_GetOffset(AuctionsScrollFrame)
	local index
	for i=1, NUM_AUCTIONS_TO_DISPLAY do
		index = offset + i + (NUM_AUCTION_ITEMS_PER_PAGE * AuctionFrameAuctions.page)
		if index > numBatchAuctions + (NUM_AUCTION_ITEMS_PER_PAGE * AuctionFrameAuctions.page) then
			return
		end
		local name, texture, count, quality, canUse, level, levelColHeader, minBid, minIncrement, buyoutPrice, bidAmount, highBidder, bidderFullName, owner, ownerFullName, saleStatus, itemId, hasAllInfo =  GetAuctionItemInfo("owner", offset + i)
		if bidAmount > 0 then
			local button = _G["AuctionsButton"..i.."Name"]
			button:SetText(name.."|cffffff00".." ("..L["bid"]..")".."|r")
		end
	end
end
