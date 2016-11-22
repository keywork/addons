ZoneFadeInDuration = 0.5;
ZoneHoldDuration = 1.0;
ZoneFadeOutDuration = 2.0;

function LeavingZoneText_OnLoad(self)

	-- Other OnLoad Code:
	FadingFrame_OnLoad(self);
	FadingFrame_SetFadeInTime(self, ZoneFadeInDuration);
	FadingFrame_SetHoldTime(self, ZoneHoldDuration);
	FadingFrame_SetFadeOutTime(self, ZoneFadeOutDuration);
	self:RegisterEvent("ZONE_CHANGED");
	self:RegisterEvent("ZONE_CHANGED_INDOORS");
	self:RegisterEvent("ZONE_CHANGED_NEW_AREA");
	LeavingZoneTextString:SetText( "" );
	previousZone = "";

end

function LeavingZoneText_OnEvent(self, event, ...)
	--message("." .. GetRealZoneText() .. ". ." .. GetSubZoneText() .. ".");
	--/script message(GetRealZoneText() .. " - " .. GetSubZoneText())

	-- Set Zone Strings Positions
	ZoneTextString:SetJustifyH("LEFT");
	ZoneTextHeight = (GetScreenHeight() / 2) - 200;
	ZoneTextFrame:SetPoint("TOP", 0, -ZoneTextHeight);

	-- Set PVP Info String Positions
	PVPInfoTextString:SetJustifyH("LEFT");
	PVPArenaTextString:SetJustifyH("LEFT");

	-- Set Sub Zone Text
	SubZoneTextString:SetJustifyH("RIGHT");
	SubZoneTextString:SetPoint("BOTTOMLEFT", ZoneTextFrame, "BOTTOM", -180, -55);

	-- Set Leaving Zone Text Position
	LeavingZoneTextString:SetJustifyH("RIGHT");
	LeavingZoneTextString:SetPoint("BOTTOMLEFT", ZoneTextFrame, "BOTTOM", -180, -70);

	local pvpType, isSubZonePvP, factionName = GetZonePVPInfo();
	if ( pvpType == "sanctuary" ) then
		LeavingZoneTextString:SetTextColor(0.41, 0.8, 0.94);
	elseif ( pvpType == "arena" ) then
		LeavingZoneTextString:SetTextColor(1.0, 0.1, 0.1);
	elseif ( pvpType == "friendly" ) then
		LeavingZoneTextString:SetTextColor(0.1, 1.0, 0.1);
	elseif ( pvpType == "hostile" ) then
		LeavingZoneTextString:SetTextColor(1.0, 0.1, 0.1);
	elseif ( pvpType == "contested" ) then
		LeavingZoneTextString:SetTextColor(1.0, 0.7, 0);
	elseif ( pvpType == "combat" ) then
		LeavingZoneTextString:SetTextColor(1.0, 0.1, 0.1);
	else
		LeavingZoneTextString:SetTextColor(1.0, 0.9294, 0.7607);
	end
	if ( (zoneText ~= self.zoneText) or (event == "ZONE_CHANGED_NEW_AREA") ) then
		if ( previousZone ~= "" ) then
			if ( previousZone ~= GetRealZoneText() and previousZone ~= GetSubZoneText() ) then
				LeavingZoneTextString:SetText( "Leaving: " .. previousZone);
				FadingFrame_Show( self );
			elseif ( previousZone == GetRealZoneText() ) then
				LeavingZoneTextString:SetText( "" );
				FadingFrame_Show( self );
			elseif ( previousZone == GetSubZoneText() ) then
				LeavingZoneTextString:SetText( "" );
				FadingFrame_Show( self );
			end
		end
		previousZone = GetRealZoneText();
	elseif ( (zoneText ~= self.zoneText) or (event == "ZONE_CHANGED") ) then
		if ( previousZone ~= "" ) then
			if ( previousZone ~= GetRealZoneText() and previousZone ~= GetSubZoneText() ) then
				LeavingZoneTextString:SetText( "Leaving: " .. previousZone);
				FadingFrame_Show( self );
			elseif ( previousZone == GetRealZoneText() ) then
				LeavingZoneTextString:SetText( "" );
				FadingFrame_Show( self );
			elseif ( previousZone == GetSubZoneText() ) then
				LeavingZoneTextString:SetText( "" );
				FadingFrame_Show( self );
			end
		end
		previousZone = GetSubZoneText();
		if ( (previousZone == "") or (previousZone == nil) ) then
			previousZone = GetRealZoneText();
		end
	end	
end