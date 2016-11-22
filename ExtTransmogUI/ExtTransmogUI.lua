local HOOKS = {};

function ExtTransmog_OnLoad(self)

    --HOOKS["Model_Reset"] = Model_Reset;
    --Model_Reset = ExtTransmog_Model_Reset;
    
    ExtTransmog_RebuildFrame();

end

function ExtTransmog_RebuildFrame()

    --TransmogrifyFrame:SetWidth(500);
    --TransmogrifyModelFrame:SetWidth(482);
    --ExtTransmog_ResetPosition(TransmogrifyModelFrame);
    WardrobeFrame:SetWidth(1200);
    WardrobeFrame:SetScale(0.82);
    WardrobeTransmogFrame:SetWidth(535);
    WardrobeTransmogFrame.Model:ClearAllPoints();
    WardrobeTransmogFrame.Model:SetPoint("TOP", WardrobeTransmogFrame, "TOP", 0, -4);
    WardrobeTransmogFrame.Model:SetWidth(420);
    WardrobeTransmogFrame.Model:SetHeight(420);
    WardrobeTransmogFrame.Inset.BG:SetWidth(529);

    WardrobeTransmogFrame.Model.HeadButton:ClearAllPoints();
    WardrobeTransmogFrame.Model.HeadButton:SetPoint("TOP", WardrobeTransmogFrame.Model, "TOP", -238, -41);
    WardrobeTransmogFrame.Model.HandsButton:ClearAllPoints();
    WardrobeTransmogFrame.Model.HandsButton:SetPoint("TOP", WardrobeTransmogFrame.Model, "TOP", 235, -118);

    WardrobeTransmogFrame.Model.MainHandButton:ClearAllPoints();
    WardrobeTransmogFrame.Model.MainHandButton:SetPoint("TOP", WardrobeTransmogFrame.Model, "BOTTOM", -26, -5);
    WardrobeTransmogFrame.Model.SecondaryHandButton:ClearAllPoints();
    WardrobeTransmogFrame.Model.SecondaryHandButton:SetPoint("TOP", WardrobeTransmogFrame.Model, "BOTTOM", 27, -5);
    WardrobeTransmogFrame.Model.MainHandEnchantButton:ClearAllPoints();
    WardrobeTransmogFrame.Model.MainHandEnchantButton:SetPoint("BOTTOM", WardrobeTransmogFrame.Model.MainHandButton, "BOTTOM", 0, -20);
    WardrobeTransmogFrame.Model.SecondaryHandEnchantButton:ClearAllPoints();
    WardrobeTransmogFrame.Model.SecondaryHandEnchantButton:SetPoint("BOTTOM", WardrobeTransmogFrame.Model.SecondaryHandButton, "BOTTOM", 0, -20);
    
end

function ExtTransmog_Model_Reset(self)

    --HOOKS["Model_Reset"](self);

    --if (self:GetName() == "TransmogrifyModelFrame") then
    --    ExtTransmog_ResetPosition(self);
    --end

end

function ExtTransmog_ResetPosition(model)

    --model:SetPosition(-0.5, 0, -0.25);

end
