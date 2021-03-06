-- ------------------------------------------------------------------------------------- --
-- 					TradeSkillMaster_Crafting - AddOn by Sapu94							 	  	  --
--   http://wow.curse.com/downloads/wow-addons/details/tradeskillmaster_crafting.aspx    --
--																													  --
--		This addon is licensed under the CC BY-NC-ND 3.0 license as described at the		  --
--				following url: http://creativecommons.org/licenses/by-nc-nd/3.0/			 	  --
-- 	Please contact the author via email at sapu94@gmail.com with any questions or		  --
--		concerns regarding this license.																	  --
-- ------------------------------------------------------------------------------------- --

-- TradeSkillMaster_Crafting Locale - zhTW
-- Please use the localization app on CurseForge to update this
-- http://wow.curseforge.com/addons/TradeSkillMaster_Crafting/localization/

local L = LibStub("AceLocale-3.0"):NewLocale("TradeSkillMaster_Crafting", "zhTW")
if not L then return end

-- L["AH"] = ""
L["All"] = "全部"
-- L["A loop was detected in the mat cost of %s. Please correct this in your settings. This is typically caused by having 'crafting' in the custom price of two mats which can be crafted into each other."] = ""
-- L["Always Buy from AH"] = ""
-- L["A minimum profit of 0g is not allowed."] = ""
L["Are you sure you want to reset all material prices to the default value?"] = "你確定要重置所有材料價格為默認價值嗎?"
-- L["Are you sure you want to reset the 'Default Craft Value Method' back to the default value?"] = ""
-- L["Are you sure you want to reset the 'Default Material Cost Method' back to the default value?"] = ""
L["Ask Later"] = "以后詢問"
L["Auction House"] = "拍賣行"
L["Bags"] = "背包"
--[==[ L[ [=[Below is a list of crafts that have been smartly added. You can configure what crafts are listed here in the "Cooldowns" tab of the "Crafting" page within the main TSM window. Quest items can be removed through the TSM crafting options.

Simply click on the row in the table below to craft it.]=] ] = "" ]==]
-- L["Buy From AH"] = ""
L["Buy From Vendor"] = "從商人處購買"
-- L["Buy Items"] = ""
L["Buy Vendor Items"] = "購買商人物品"
-- L["Can Craft At Least One, Profit, Craftable Quantity"] = ""
-- L[" (CD)"] = ""
-- L["|cffff0000[Filtered]|r "] = ""
-- L["Changes the scale of the profession frame."] = ""
--[==[ L[ [=[Changes the scale of the profession frame. 

Open the profession window to enable.]=] ] = "" ]==]
-- L["Characters"] = ""
L["Characters (Bags/Bank/AH/Mail) to Ignore:"] = "角色（背包/銀行/拍賣行/郵件）忽略："
L["Clear Filters"] = "清除過濾條件"
L["Clear Queue"] = "清除序列"
-- L["Click here to restock the selected groups based on their Crafting operations."] = ""
-- L["Clicking this button will gather the required materials when you are at a valid source, the text of the button will change according to source."] = ""
-- L["Click this button to stop gathering and close the window."] = ""
-- L["Conversions"] = ""
-- L["Convert"] = ""
-- L["Cooldowns"] = ""
L["Cost"] = "成本"
L["Could not get link for profession."] = "無法獲取專業技能鏈接。"
-- L["Craftable"] = ""
-- L["Craftable Quantity, Profit"] = ""
-- L["Crafter"] = ""
-- L["Crafting can automatically prompt you to craft your cooldowns when you open the profession with the necessary materials on-hand or automatically add them to your queue if you don't have the necessary materials on-hand. Click on rows below to toggle this smart behavior on/off for your cooldowns."] = ""
-- L["Crafting can automatically prompt you to craft your quest required items when you open the profession with the necessary materials on-hand or automatically add them to your queue if you don't have the necessary materials on-hand."] = ""
L["Crafting Cost"] = "製作成本"
-- L["Crafting failed to scan your profession. Please close and re-open it to to allow Crafting to scan and provide pricing info for this profession."] = ""
L["Crafting Material Cost"] = "製造材料成本"
L["Crafting operations contain settings for restocking the items in a group. Type the name of the new operation into the box below and hit 'enter' to create a new Crafting operation."] = "製造操作包含為一個群組中的物品補貨的相關設定。在下面的輸入框中為新操作輸入一個名字并點擊“回車”來創建一個新的製造操作。"
-- L["Crafting will not queue any items affected by this operation with a profit below this value. As an example, a min profit of 'max(10g, 10% crafting)' would ensure a profit of at least 10g or 10% of the craft cost, whichever is highest."] = ""
-- L["Craft Name"] = ""
L["Craft Next"] = "製造下一個"
L["Craft Queue"] = "製造序列"
L["Crafts"] = "製造"
-- L["Craft Value Method"] = ""
-- L["Created profession group for %s."] = ""
L["Create Profession Groups"] = "創建專業技能群組"
-- L["Current Source"] = ""
L["Custom Price"] = "自定義價格"
L["Custom Price for this item."] = "為該物品自定義價格"
L["Custom Price per Item"] = "每物品的自定義價格"
-- L["Default Craft Value Method"] = ""
L["Default Material Cost Method"] = "默認材料成本設定"
L["Default Price"] = "默認價格"
L["Default Price Settings"] = "默認價格設定"
-- L["Disable Crafting AH Search"] = ""
-- L["Disable DE Search"] = ""
-- L["Enable Smart Crafting for Quests"] = ""
L["Enchant Vellum"] = "附魔皮紙"
L[ [=[Estimated Cost: %s
Estimated Profit: %s]=] ] = [=[預估成本：%s
預估利潤：%s]=]
-- L["Even Stacks Only"] = ""
L["Exclude Crafts with a Cooldown from Craft Cost"] = "從製作成本中排除有冷卻時間的製作物品。"
L["Filters >>"] = "過濾條件>>"
-- L["Finished Gathering"] = ""
L["First select a crafter"] = "首先選擇一個製造者"
-- L["From "] = ""
L["Gather"] = "收集"
L["Gathering"] = "收集"
L["Gathering Crafting Mats"] = "收集製造材料"
L["Gather Items"] = "收集物品"
L["General"] = "常規"
L["General Settings"] = "常規設定"
L["Guilds (Guild Banks) to Ignore:"] = "忽略公會（公會銀行）："
-- L["Have Mats"] = ""
-- L["Here, you can select which of your TSM groups you would like to restock based on their Crafting operations."] = ""
L["Here you can view and adjust how Crafting is calculating the price for this material."] = "這裡可以查看和調整如何計算出製作材料的價格。"
-- L["Hide Queue"] = ""
-- L["Hold the left mouse button down and drag this handle to resize the window."] = ""
L["If checked, if there is more than one way to craft the item then the craft cost will exclude any craft with a daily cooldown when calculating the lowest craft cost."] = "若勾選，如果物品不止一種方法可製作，在計算最低成本時將排除掉任何有一天冷卻時間的材料物品。"
-- L["If checked, only crafts which you can craft with items in your bags (ignoring vendor items) will be shown below."] = ""
L["If checked, the crafting cost of items will be shown in the tooltip for the item."] = "若勾選，製作成本將會顯示在物品的滑鼠提示中。"
L["If checked, the material cost of items will be shown in the tooltip for the item."] = "若勾選，物品的製作材料成本將顯示在物品的滑鼠提示中。"
-- L["If checked, the mats needed to craft an item and their prices will be shown in item tooltips."] = ""
-- L["If enabled, buying from AH will always be suggested even if you have enough via other sources. If disabled only short items will be searched for at the AH"] = ""
-- L["If enabled the crafting search at the Auction House will ignore Disenchantable Items."] = ""
-- L["If enabled the crafting search will only search for multiples of 5."] = ""
-- L["Ignore Alts"] = ""
-- L["Ignore Intermediate Crafting"] = ""
-- L["Ink Trader"] = ""
-- L["Intermediate Craft"] = ""
-- L["Intermediate Crafting"] = ""
L["Inventory Settings"] = "庫存設定"
L["Item Name"] = "物品名稱"
L["Items will only be added to the queue if the number being added is greater than this number. This is useful if you don't want to bother with crafting singles for example."] = "如果被添加的數字比該值大，則物品只會添加到序列。舉例來說，如果你不想煩惱于製作單個物品，這是非常有用的設置。" -- Needs review
L["Item Value"] = "物品價值"
L["Left-Click|r to add this craft to the queue."] = "點擊|r 將該項製造添加到序列。"
-- L["Left click will set max quantity as quantity required"] = ""
L["Link"] = "鏈接"
-- L["List Mats in Tooltip"] = ""
-- L["Mail From "] = ""
L["Mailing Craft Mats to %s"] = "郵寄製作材料至%s"
L["Mail Items"] = "郵寄物品"
-- L["Mail To "] = ""
L["Mat Cost"] = "材料成本"
L["Material Cost Options"] = "材料成本選項"
L["Material Name"] = "材料名稱"
L["Materials"] = "材料"
L["Materials:"] = "材料："
L["Mat Price"] = "材料價格"
L["Max Restock Quantity"] = "最大補貨數量"
L["Minimum Profit"] = "最小利潤"
L["Min Restock Quantity"] = "最小補貨數量"
L["Name"] = "名稱"
L["Need"] = "需要"
-- L["No Auctions found for %s"] = ""
-- L["No item specified. Usage: /tsm restock_help [ITEM_LINK]"] = ""
L["<None>"] = "<無>"
-- L["None Found"] = ""
L["No Thanks"] = "否"
-- L["Nothing to Gather"] = ""
L["Nothing To Gather"] = "沒有物品可收集"
L["Nothing to Mail"] = "沒有物品可郵寄"
-- L["Num Owned"] = ""
-- L["Once a crafter and profession(s) are selected, Click this button to start gathering."] = ""
-- L["Once a crafter is selected, you can use this dropdown to select the profession(s) you want to gather for."] = ""
L["Opens the Crafting window to the first profession."] = "打開第一專業的製造窗口" -- Needs review
-- L["Operation"] = ""
-- L["Override Default Craft Value Method"] = ""
-- L["Override global options for the session"] = ""
L["Percent to subtract from buyout when calculating profits (5% will compensate for AH cut)."] = "計算利潤時按百分比從直購價中扣除（設為5%將抵消拍賣行稅金）。"
-- L["Perform a manual AH search for this item"] = ""
-- L["Player"] = ""
-- L["Please switch to the Shopping Tab at the AH to perform the gathering search."] = ""
L["Please switch to the Shopping Tab to perform the gathering search."] = "請切換至購物標籤頁來執行收集搜索。" -- Needs review
L["Price:"] = "價格："
L["Price Settings"] = "價格設定"
L["Price Source Filter"] = "價格來源過濾器" -- Needs review
-- L["Profession"] = ""
L["Profession Filter"] = "專業過濾器" -- Needs review
-- L["Profession Frame Scale"] = ""
L["Professions"] = "專業技能" -- Needs review
L["Professions Used In"] = "涉及專業" -- Needs review
L["Profit"] = "利潤"
-- L["Profit, Craftable Quantity"] = ""
L["Profit Deduction"] = "利潤扣除"
L["Profit (Total Profit):"] = "利潤（總利潤）：" -- Needs review
-- L["Prospect"] = ""
L["Queue"] = "製造序列" -- Needs review
-- L["Queue Increment"] = ""
-- L["Queue Sorting Method"] = ""
-- L["Ready"] = ""
L["Reset All Custom Prices to Default"] = "重設所有自定義價格為默認值" -- Needs review
L["Reset all Custom Prices to Default Price Source."] = "重設所有自定義價格為默認價格來源。" -- Needs review
-- L["Reset Craft Value Method to Default"] = ""
-- L["Reset Material Cost Method to Default"] = ""
L["Resets the material price for this item to the defualt value."] = "將該物品的材料價格重設為默認值。" -- Needs review
-- L["Reset the Craft Value Method to the default TSM value."] = ""
-- L["Reset the Material Cost Method to the default TSM value."] = ""
L["Reset to Default"] = "重設為默認" -- Needs review
-- L["Restock help for %s:"] = ""
L["Restocking to a max of %d (min of %d) with a min profit."] = "以最小利潤補貨至%d的最大值（%d的最小值）。" -- Needs review
L["Restocking to a max of %d (min of %d) with no min profit."] = "以非最小利潤補貨至%d的最大值（%d的最小值）。" -- Needs review
L["Restock Quantity Settings"] = "補貨數量設定" -- Needs review
L["Restock Selected Groups"] = "為選定分組補貨" -- Needs review
L["Restock Settings"] = "補貨設定" -- Needs review
-- L["Retrieve From "] = ""
L["Right-Click|r to subtract this craft from the queue."] = "右鍵|r從製造序列中移除該項製作。" -- Needs review
-- L["Right click will search with no max quantity"] = ""
L["Search"] = "搜索" -- Needs review
-- L["Selection"] = ""
L["Select one of your characters' professions to browse."] = "選擇一項你的角色的專業技能進行瀏覽。" -- Needs review
-- L["Select profession(s) and click start"] = ""
L["Set Minimum Profit"] = "設置最小利潤" -- Needs review
L["Shift-Left-Click|r to queue all you can craft."] = "Shift+點擊|r添加所有你可製造的物品至序列。" -- Needs review
L["Shift-Right-Click|r to remove all from queue."] = "Shift+右鍵|r移除所有序列中的製造項。" -- Needs review
L["Show Crafting Cost in Tooltip"] = "在滑鼠提示中顯示製造成本"
L["Show Material Cost in Tooltip"] = "在滑鼠提示中顯示材料成本" -- Needs review
-- L["Show Queue"] = ""
L["'%s' is an invalid operation! Min restock of %d is higher than max restock of %d."] = "“%s”是一個無效的操作！%d的最小補貨量高于%d的最大補貨量。"
-- L["Skip Smart Crafts and Continue to Profession"] = ""
-- L["Smart"] = ""
-- L["Smart Crafts"] = ""
-- L["Sources"] = ""
L["%s (%s profit)"] = "%s（%s利潤）"
L["Start Gathering"] = "開始收集" -- Needs review
L["Status"] = "狀態"
L["Stop Gathering"] = "停止收集" -- Needs review
-- L["Tells you why a specific item is not being restocked and added to the queue."] = ""
-- L["The 'Craft Value Method' (%s) did not return a value for this item. If it is based on some price database (AuctionDB, TSM_WoWuction, TUJ, etc), then ensure that you have scanned for or downloaded the data as appropriate."] = ""
-- L["The min profit (%s) did not evalulate to a valid value for this item."] = ""
-- L["The number which would be queued (%d) is less than the min restock quantity (%d)."] = ""
-- L["The operation applied to this item is invalid! Min restock of %d is higher than max restock of %d."] = ""
-- L["The profit of this item (%s) is below the min profit (%s)."] = ""
-- L["The queue will be sorted based on this option, from left to right."] = ""
-- L["There is a crafting cost and crafted item value, but TSM_Crafting wasn't able to calculate a profit. This shouldn't happen!"] = ""
-- L["There is no TSM_Crafting operation applied to this item's TSM group (%s)."] = ""
-- L["This area of the profession tab works similarly to the default profession UI, but with some added features. These include the ability to easily add crafts to your queue, listing profit next to crafts, and displaying inventory information."] = ""
-- L["This button will automatically create some simple TSM groups based on the current profession."] = ""
-- L["This button will switch to the default profession UI. You can switch back by clicking a 'TSM' button at the top of the default profession UI."] = ""
-- L["This button will switch to the default profession UI. You can switch back by clicking the 'TSM' button at the top of the default profession UI."] = ""
-- L["This displays the available sources for each item that is required as per your session settings"] = ""
-- L["This displays the tasks that you need to perform to gather the required materials from the selected sources."] = ""
L["This is the default method Crafting will use for determining material cost."] = "這是默認的製造助手用于確定材料價格的方法。" -- Needs review
-- L["This is the default method Crafting will use for determining the value of crafted items."] = ""
-- L["This item does not have a crafting cost. Check that all of its mats have mat prices. If the mat prices are based on some price database (AuctionDB, TSM_WoWuction, TUJ, etc), then ensure that you have scanned for or downloaded the data as appropriate."] = ""
-- L["This item is not in a TSM group."] = ""
-- L["This item will be added to the queue when you restock its group. If this isn't happening, make a post on the TSM forums with a screenshot of the item's tooltip, operation settings, and your general TSM_Crafting options."] = ""
-- L["This slider sets the quantity to add/remove from the queue when left/right clicking on a row below."] = ""
-- L["Toggle to ignore gathering from Alts."] = ""
-- L["Toggle to ignore gathering from Alts and only gather from the crafter."] = ""
-- L["Toggle to ignore intermediate crafting."] = ""
-- L["Toggle to suggest trading inks at the vendor."] = ""
-- L["Toggle to switch between Crafting and Normal searches at the Auction House."] = ""
-- L["Toggle to switch between Crafting and Normal searches at the Auction House. A Crafting search will look for any disenchantable / prospectable / millable / craftable items that will provide the target item wheras a normal search will look just for the target item"] = ""
L["Total"] = "合計"
-- L["Trade Inks at the vendor"] = ""
-- L["Transform"] = ""
-- L["Transform Next"] = ""
L["TSM Groups"] = "TSM群組" -- Needs review
L["Vendor"] = "商人"
L["Vendor Trade"] = "商人交易"
L["Visit Bank"] = "查看銀行" -- Needs review
-- L["Visit Guild Vault"] = ""
-- L["Visit Mailbox"] = ""
L["Warning: The min restock quantity must be lower than the max restock quantity."] = "警告：最小補貨數量必須低於最大補貨數量。"
L["When you click on the \"Restock Queue\" button enough of each craft will be queued so that you have this maximum number on hand. For example, if you have 2 of item X on hand and you set this to 4, 2 more will be added to the craft queue."] = "當你進行補貨操作時，會補貨至使你手上持有該設定的最大值。舉例來說，若此處的設定值為4，你手里只有2個x物品時，進行補貨操作就會添加2個x物品到你的生產序列。"
L["Would you like to automatically create some TradeSkillMaster groups for this profession?"] = "你想為該專業自動創建TSM群組嗎？" -- Needs review
-- L["You already have at least your max restock quantity of this item. You have %d and the max restock quantity is %d"] = ""
-- L["You can change the current tab of the profession frame, start gathering materials for your queue, and show the queue using these buttons."] = ""
L["You can click on one of the rows of the scrolling table below to view or adjust how the price of a material is calculated."] = "你可以點擊下列表格中的一行來查看或調整材料價格的計算方法。"
-- L["You can left/right click on a row to add/remove a craft from the crafting queue."] = ""
-- L["You can set the global default gathering options here, some of these can be overriden per gathering session."] = ""
-- L["You can use this dropdown to switch between crafters."] = ""
-- L["You can use this dropdown to switch between the current character's professions."] = ""
-- L["You don't know how to craft this item."] = ""
-- L["Your craft value method for '%s' was invalid so it has been returned to the default. Details: %s"] = ""
-- L["Your default craft value method was invalid so it has been returned to the default. Details: %s"] = ""
