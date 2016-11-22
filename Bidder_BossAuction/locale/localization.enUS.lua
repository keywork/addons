local L = AceLibrary("AceLocale-2.2"):new("Bidder_BossAuction")

local translations = {
	["You must bid higher than your last bid of %g."] = true,
	["You don't have enough dkp for the minimum bid of %g.  However, you may bid the minimum bid and go negative."] = true,
	['The minimum bid is %g dkp.'] = true,
	["You only have %g dkp."] = true,
	['Note: You are under the high bid of %g'] = true,
	["Multiple winners |cFF%s(Contested)|r"] = true,
	["You have %g %s points"] = true,
	["Bid %g"] = true,
	["High %g"] = true,
	["Min %g"] = true,
	["Winner: |cFF%s%s|r"] = true,
	["No bids."] = true,
	["Boss Auction: Open Bid"] = true,
	["Your bid on item %g was removed by the dkp manager."] = true,
	["You don't have enough dkp for the minimum bid of %g.  However, you may bid the minimum bid and go negative."] = true,
	['The minimum bid is %g dkp.'] = true,
	["You only have %g dkp."] = true,
	["You have %g %s points"] = true,
	["Tied Last %g"] = true,
	["Last %g"] = true,
	["Min %g"] = true,
	["Bid %g"] = true,
	["%d bids, final cost: %g"] = true,
	["Round %d/%d next in "] = true,
	["  (%d bids)"] = true,
	["Boss Auction: Silent Bid"] = true,
	["Your bid on item %g was removed by the dkp manager."] = true,
}
 
L:RegisterTranslations("enUS", function() return translations end)
