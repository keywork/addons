local ADDON, data = ...

local checkboxes = {}   -- Will contain {checkbox, variable} pairs. Used in the refresh function.

local Version60100 = (GetBuildInfo ():match ('^6.0') == nil)

-----------------------------------------------------------------

StaticPopupDialogs["BULKORDER_CONFIRMAPPLYTOALL"] = {
    text = "Are you sure you want to apply these settings to all of your characters?",
    button1 = "Yes",
    button2 = "No",
    OnAccept = function ()
        ApplySettingsToAllToons ()
    end,
    timeout = 0,
    hideOnEscape = true,
    preferredIndex = 3,  -- avoid some UI taint, see http://www.wowace.com/announcements/how-to-avoid-some-ui-taint/
}

function ApplySettingsToAllToons ()
    g_BulkOrderGlobal = {}
    for k,v in pairs(g_BulkOrder) do
        g_BulkOrderGlobal[k] = v
    end
    g_BulkOrderGlobal.timestamp = time ()
end
-----------------------------------------------------------------

local function CreateCheckBox (parent, anchorTo, x, y, text)
    local frm = CreateFrame ("CheckButton", '', parent, "InterfaceOptionsCheckButtonTemplate")
    frm:SetPoint ("TOPLEFT", anchorTo, "BOTTOMLEFT", x, y)
    frm.Text:SetText (text)
    
    function frm:SetTooltip (title, text)
        self:SetScript("OnEnter", function(self, motion, ...)
            GameTooltip:SetOwner (self, "ANCHOR_TOPLEFT")
            GameTooltip:AddLine (title, 1, 1, 0)
            GameTooltip:AddLine (text, 1, 1, 1)
            GameTooltip:Show ()
        end)
        self:SetScript("OnLeave", function(self, motion, ...)
            GameTooltip:Hide ()
        end)
        return frm
    end
    
    function frm:Bind (varname)
        self:SetScript ("OnClick", function (self, ...)
            g_BulkOrder[varname] = self:GetChecked ()
            g_BulkOrder.timestamp = time ()
        end)
        table.insert (checkboxes, {frm, varname})
        return frm
    end
    
    return frm
end

-----------------------------------------------------------------

function BulkOrder_CreateOptions ()
    -- Default values!
    if g_BulkOrderGlobal and g_BulkOrderGlobal.timestamp and (g_BulkOrderGlobal.timestamp > (g_BulkOrder.timestamp or 0)) then
        for k,v in pairs(g_BulkOrderGlobal) do
            g_BulkOrder[k] = v
        end
    else
        g_BulkOrder = g_BulkOrder or {}
        
        for _,v in ipairs({string.split (' ', 'ExcludeTradingPost ExcludeWarMill ExcludeGoblinWorkshop ExcludeBarn ExcludeShipyard RemindProfBuildings RemindWarMill RemindLumberMill RemindTradingPost RemindBarn RemindGoblinWorkshop RemindGladiatorSanctum RemindSpiritLodge RemindMine RemindHerbGarden RemindGathering')}) do
            if g_BulkOrder[v]==nil then 
                g_BulkOrder[v] = true 
            end
        end
    end

    -- GUI stuff!
    local Options = CreateFrame ("Frame", "BulkOrderOptions", UIParent);
    Options.name = "BulkOrder";
    Options:Hide ()
    InterfaceOptions_AddCategory (Options);
    
    Options.refresh = function ()
        for i,v in pairs(checkboxes) do
            v[1]:SetChecked (g_BulkOrder[v[2]])
        end
    end
    
    Options.CreateCheckBox = CreateCheckBox
    
    local txt = {
        '- While this add-on is installed, opening a work orders window will automatically start all available work orders.',
        '- You can avoid the automatic work orders by holding LEFT SHIFT down while opening the work orders window.',
        '- In addition, work orders at the Trading Post or Dwarven Bunker/ War Mill are by default not automatic, which you can change with these options.',
    }
    local sometext = Options:CreateFontString (nil, "ARTWORK", "GameFontHighlight")
    sometext:SetPoint ("TOPLEFT", 16, -40)
    sometext:SetPoint ("TOPRIGHT", -16, -40)
    sometext:SetWordWrap (true)
    sometext:SetText (string.join ('\n', unpack (txt)))
    sometext:SetJustifyH ("LEFT")
    sometext:SetJustifyV ("TOP")
    sometext:SetHeight (80)
    Options.sometext = sometext
    
    -----------------------------------------------------------------
    
    local Title = Options:CreateFontString (nil, "ARTWORK", "GameFontNormalLarge")
    Title:SetPoint ("TOPLEFT", 16, -16)
    Title:SetText (Options.name)
    Options.Title = Title

    
    -- Exclude buildings
    local TitleExclude = Options:CreateFontString (nil, "ARTWORK", "GameFontHighlight")
    TitleExclude:SetPoint ("TOPLEFT", sometext, "BOTTOMLEFT", 0, -15)
    TitleExclude:SetText ('Exclude these buildings:')
    Options.TitleExclude = TitleExclude
    
    local dy = 2

    Options.chkWarMill = Options:CreateCheckBox (TitleExclude, 0, -5, 'Dwarven Bunker/ War Mill')
        :Bind ('ExcludeWarMill', false, true)
        :SetTooltip ('Exclude Dwarven Bunker/ War Mill', 'If this option is checked, BulkOrder will NOT automatically start work orders in the Dwarven Bunker/ War Mill.')
    
    Options.chkTradingPost = Options:CreateCheckBox (Options.chkWarMill, 0, dy, 'Trading Post')
        :Bind ('ExcludeTradingPost', false, true)
        :SetTooltip ('Exclude Trading Post', 'If this option is checked, BulkOrder will NOT automatically start work orders in the Trading Post.')
    
    Options.chkShipyard = Options:CreateCheckBox (Options.chkTradingPost, 0, dy, 'Shipyard')
        :Bind ('ExcludeShipyard', false, true)
        :SetTooltip ('Exclude Shipyard', 'If this option is checked, BulkOrder will NOT automatically start work orders in the Shipyard.')
    
    Options.chkGoblinWorkshop = Options:CreateCheckBox (TitleExclude, 250, -5, 'Gnomish Gearworks/ Goblin Workshop')
        :Bind ('ExcludeGoblinWorkshop', false, true)
        :SetTooltip ('Exclude Gnomish Gearworks/ Goblin Workshop', 'If this option is checked, BulkOrder will NOT automatically start work orders in the Gnomish Gearworks/ Goblin Workshop.')
    
    Options.chkBarn = Options:CreateCheckBox (Options.chkGoblinWorkshop, 0, dy, 'Barn')
        :Bind ('ExcludeBarn', false, true)
        :SetTooltip ('Exclude Barn', 'If this option is checked, BulkOrder will NOT automatically start work orders in the Barn.')
    
    Options.chkEverything = Options:CreateCheckBox (Options.chkBarn, 0, dy, 'EVERYTHING!')
        :Bind ('ExcludeEverything', false, true)
        :SetTooltip ('Exclude Everything!', 'If this option is checked, BulkOrder will NOT automatically start work orders in any buildings, ever.\nYou will have to manually press the Start All Work Orders button like some sort of cave man.')
    
    
    -- Reminder
    local moretext = Options:CreateFontString (nil, "ARTWORK", "GameFontHighlight")
    moretext:SetPoint ("TOPLEFT", Options.chkShipyard, "BOTTOMLEFT", 0, -20)
    moretext:SetText ('The first time you enter your garrison after logging in, BulkOrder will remind you if you have buildings that have no work orders queued.')
    moretext:SetWidth (500)
    moretext:SetJustifyH ("LEFT")
    Options.moretext = moretext

    local TitleReminder = Options:CreateFontString (nil, "ARTWORK", "GameFontHighlight")
    TitleReminder:SetPoint ("TOPLEFT", moretext, "BOTTOMLEFT", 0, -15)
    TitleReminder:SetText ('Remind me about:')
    Options.TitleReminder = TitleReminder
    
    --dy = -3
    
    Options.chkRemindProfBuildings = Options:CreateCheckBox (TitleReminder, 0, dy, 'Profession Buildings')
        :Bind ('RemindProfBuildings', false, true)
        :SetTooltip ('Profession Buildings', 'If this option is checked, BulkOrder will remind you to start work orders in all your profession buildings.')
    
    Options.chkRemindWarMill = Options:CreateCheckBox (Options.chkRemindProfBuildings, 0, dy, 'Dwarven Bunker/ War Mill')
        :Bind ('RemindWarMill', false, true)
        :SetTooltip ('Dwarven Bunker/ War Mill', 'If this option is checked, BulkOrder will remind you to start work orders in your Dwarven Bunker/ War Mill.')
    
    Options.chkRemindLumberMill = Options:CreateCheckBox (Options.chkRemindWarMill, 0, dy, 'Lumber Mill')
        :Bind ('RemindLumberMill', false, true)
        :SetTooltip ('Lumber Mill', 'If this option is checked, BulkOrder will remind you to start work orders in your Lumber Mill.')
    
    Options.chkRemindTradingPost = Options:CreateCheckBox (Options.chkRemindLumberMill, 0, dy, 'Trading Post')
        :Bind ('RemindTradingPost', false, true)
        :SetTooltip ('Trading Post', 'If this option is checked, BulkOrder will remind you to start work orders in your Trading Post.')
    
    Options.chkRemindGladiatorSanctum = Options:CreateCheckBox (Options.chkRemindTradingPost, 0, dy, 'Gladiator\'s Sanctum')
        :Bind ('RemindGladiatorSanctum', false, true)
        :SetTooltip ('Gladiator\'s Sanctum', 'If this option is checked, BulkOrder will remind you to start work orders in your Gladiator\'s Sanctum.')
    
    Options.chkRemindBarn = Options:CreateCheckBox (TitleReminder, 250, dy, 'Barn')
        :Bind ('RemindBarn', false, true)
        :SetTooltip ('Barn', 'If this option is checked, BulkOrder will remind you to start work orders in your Barn.')
    
    Options.chkRemindGoblinWorkshop = Options:CreateCheckBox (Options.chkRemindBarn, 0, dy, 'Gnomish Gearworks/ Goblin Workshop')
        :Bind ('RemindWorkshop', false, true)
        :SetTooltip ('Gnomish Gearworks/ Goblin Workshop', 'If this option is checked, BulkOrder will remind you to start work orders in your Gnomish Gearworks/ Goblin Workshop.')
    
    Options.chkRemindSpiritLodge = Options:CreateCheckBox (Options.chkRemindGoblinWorkshop, 0, dy, 'Mage Tower/ Spirit Lodge')
        :Bind ('RemindSpiritLodge', false, true)
        :SetTooltip ('Mage Tower/ Spirit Lodge', 'If this option is checked, BulkOrder will remind you to start work orders in your Mage Tower/ Spirit Lodge.')
    
    Options.chkRemindMine = Options:CreateCheckBox (Options.chkRemindSpiritLodge, 0, dy, 'Mine')
        :Bind ('RemindMine', false, true)
        :SetTooltip ('Mine', 'If this option is checked, BulkOrder will remind you to start work orders in your mine.')
    
    Options.chkRemindHerbGarden = Options:CreateCheckBox (Options.chkRemindMine, 0, dy, 'Herb Garden')
        :Bind ('RemindHerbGarden', false, true)
        :SetTooltip ('Herb Garden', 'If this option is checked, BulkOrder will remind you to start work orders in your herb garden.')
    
    
    Options.chkRemindGathering = Options:CreateCheckBox (Options.chkRemindGladiatorSanctum, 0, dy, 'Gathering')
        :Bind ('RemindGathering', false, true)
        :SetTooltip ('Gathering', 'If this option is checked, BulkOrder will remind you every day to do your mining/ herbing.')
    

    -- Misc
    if not Version60100 then
        local TitleMisc = Options:CreateFontString (nil, "ARTWORK", "GameFontHighlight")
        TitleMisc:SetPoint ("TOPLEFT", Options.chkRemindHerbGarden, "BOTTOMLEFT", 0, -30)
        TitleMisc:SetText ('Misc.:')
        Options.TitleMisc = TitleMisc
    
        Options.chkHideButton = Options:CreateCheckBox (TitleMisc, 0, -5, 'Hide Button')
            :Bind ('HideButton', false, true)
            :SetTooltip ('Hide Button', 'If this option is checked, the work orders window will not display the additional Start All Work Orders button.')
    end
    
    
    
    
    -- Apply To All
    local btnApplyToAll = CreateFrame ("Button", '', Options, "UIPanelButtonTemplate")
    btnApplyToAll:SetSize (200,25)
    btnApplyToAll:SetPoint ("BOTTOMLEFT", Options, "BOTTOMLEFT", 16, 8)
    btnApplyToAll:SetText ("Apply to ALL characters!")
    btnApplyToAll:SetScript ("OnClick", function ()
        StaticPopup_Show ("BULKORDER_CONFIRMAPPLYTOALL")
    end)
    
end

