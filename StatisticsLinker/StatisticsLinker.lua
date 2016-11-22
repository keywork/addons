local function onClick(this)
	if this.isHeader or this.summary then return end
	if ( IsModifiedClick("CHATLINK") and ChatEdit_GetActiveWindow() ) then
		ChatEdit_GetActiveWindow():Insert(this:GetText()..": "..this.value:GetText():gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", ""):gsub("|T.-GoldIcon.-|t", "g"):gsub("|T.-SilverIcon.-|t", "s"):gsub("|T.-CopperIcon.-|t", "c"):gsub("|H.-|h", ""):gsub("|h", ""))
	end
end

hooksecurefunc("AchievementStatButton_OnClick", onClick)