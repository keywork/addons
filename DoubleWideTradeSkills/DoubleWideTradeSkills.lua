function TradeSkillFrame_MakeDouble() 
  TradeSkillFrame:SetAttribute("UIPanelLayout-width", 695) --orig 384
  
  TradeSkillFrame:SetWidth(695)
  
  --widen the skill level statusbar
  TradeSkillRankFrame:ClearAllPoints()
  TradeSkillRankFrame:SetPoint("TOPLEFT", 75, -38)
  TradeSkillRankFrame:SetWidth(575)
  
  --Widen the skill rank border
  TradeSkillRankFrameBorder:SetTexture([[Interface\AddOns\DoubleWideTradeSkills\images\BarBorder]])
  TradeSkillRankFrameBorder:ClearAllPoints()
  TradeSkillRankFrameBorder:SetPoint("LEFT", -4, 0)
  TradeSkillRankFrameBorder:SetWidth(584); TradeSkillRankFrameBorder:SetHeight(17)
  
  --Move the skill rank string
  TradeSkillRankFrameSkillRank:ClearAllPoints()
  TradeSkillRankFrameSkillRank:SetPoint("CENTER", TradeSkillRankFrame, 0, 1)
  
  TRADE_SKILLS_DISPLAYED = 19
  
  CreateFrame("Button", "TradeSkillSkill9", TradeSkillFrame, "TradeSkillSkillButtonTemplate"):SetPoint("TOPLEFT", TradeSkillSkill8, "BOTTOMLEFT")
  CreateFrame("Button", "TradeSkillSkill10", TradeSkillFrame, "TradeSkillSkillButtonTemplate"):SetPoint("TOPLEFT", TradeSkillSkill9, "BOTTOMLEFT")
  CreateFrame("Button", "TradeSkillSkill11", TradeSkillFrame, "TradeSkillSkillButtonTemplate"):SetPoint("TOPLEFT", TradeSkillSkill10, "BOTTOMLEFT")
  CreateFrame("Button", "TradeSkillSkill12", TradeSkillFrame, "TradeSkillSkillButtonTemplate"):SetPoint("TOPLEFT", TradeSkillSkill11, "BOTTOMLEFT")
  CreateFrame("Button", "TradeSkillSkill13", TradeSkillFrame, "TradeSkillSkillButtonTemplate"):SetPoint("TOPLEFT", TradeSkillSkill12, "BOTTOMLEFT")
  CreateFrame("Button", "TradeSkillSkill14", TradeSkillFrame, "TradeSkillSkillButtonTemplate"):SetPoint("TOPLEFT", TradeSkillSkill13, "BOTTOMLEFT")
  CreateFrame("Button", "TradeSkillSkill15", TradeSkillFrame, "TradeSkillSkillButtonTemplate"):SetPoint("TOPLEFT", TradeSkillSkill14, "BOTTOMLEFT")
  CreateFrame("Button", "TradeSkillSkill16", TradeSkillFrame, "TradeSkillSkillButtonTemplate"):SetPoint("TOPLEFT", TradeSkillSkill15, "BOTTOMLEFT")
  CreateFrame("Button", "TradeSkillSkill17", TradeSkillFrame, "TradeSkillSkillButtonTemplate"):SetPoint("TOPLEFT", TradeSkillSkill16, "BOTTOMLEFT")
  CreateFrame("Button", "TradeSkillSkill18", TradeSkillFrame, "TradeSkillSkillButtonTemplate"):SetPoint("TOPLEFT", TradeSkillSkill17, "BOTTOMLEFT")
  CreateFrame("Button", "TradeSkillSkill19", TradeSkillFrame, "TradeSkillSkillButtonTemplate"):SetPoint("TOPLEFT", TradeSkillSkill18, "BOTTOMLEFT")
  
  --Tradeskill skills list
  TradeSkillListScrollFrame:ClearAllPoints()
  TradeSkillListScrollFrame:SetPoint("TOPLEFT", 22, -86); 
  TradeSkillListScrollFrame:SetHeight(310)
  
  --The stuff which shows reagents and what produced
  TradeSkillDetailScrollFrame:ClearAllPoints();
  TradeSkillDetailScrollFrame:SetPoint("TOPLEFT", TradeSkillListScrollFrame, "TOPRIGHT", 35, -2) -- -2
  TradeSkillDetailScrollFrame:SetWidth(298)
  TradeSkillDetailScrollFrame:SetHeight(310)
  
  --Remove Horizontal Bar
  local DWTSHorizontalBar = false
  for i, region in ipairs({TradeSkillFrame:GetRegions()}) do
  	if DWTSHorizontalBar or region:GetName() == "TradeSkillHorizontalBarLeft" then
  		region:Hide()
      DWTSHorizontalBar = true
  	end
  end
  
  --Add the mid section by messing with glue and newspaper clippings
  local function CreateTex(parent, tex, layer, width, height, ...)
  	local texf = parent:CreateTexture(nil, layer)
  	texf:SetPoint(...)
  	texf:SetTexture(tex)
  	texf:SetWidth(width); texf:SetHeight(height)
  	return texf
  end
  
  --Scrollbar fix
  CreateTex(TradeSkillListScrollFrame, [[Interface\ClassTrainerFrame\UI-ClassTrainer-ScrollBar]], "BACKGROUND", 30, 97.4, 
            "LEFT", TradeSkillListScrollFrame, "RIGHT", -3, 0):SetTexCoord(0, 0.46875, 0.2, 0.9609375);
            
  --Move buttons alight them to the left bottom.
  TradeSkillIncrementButton:ClearAllPoints()
  TradeSkillIncrementButton:SetPoint("TOPLEFT", TradeSkillInputBox, "TOPRIGHT", 0, 1)
    
  TradeSkillCreateButton:ClearAllPoints();
  TradeSkillCreateButton:SetPoint("TOPLEFT", TradeSkillIncrementButton, "TOPRIGHT")
  TradeSkillCancelButton:ClearAllPoints();
  TradeSkillCancelButton:SetPoint("TOPLEFT", TradeSkillCreateButton, "TOPRIGHT")
end

TradeSkillFrame_MakeDouble() 