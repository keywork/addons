local E, L, V, P, G, _ = unpack(ElvUI); --Import: Engine, Locales, PrivateDB, ProfileDB, GlobalDB, Localize Underscore
local VAT = E:GetModule('VisualAuraTimers')
local A = E:GetModule('Auras');
local EP = LibStub("LibElvUIPlugin-1.0")
local LSM = LibStub("LibSharedMedia-3.0")
local addon, ns = ...

local format, strmatch = string.format, string.match

local inversePoints = {
	TOP = 'BOTTOM',
	BOTTOM = 'TOP',
	LEFT = 'RIGHT',
	RIGHT = 'LEFT',
}

-- Timer format: value, indicator
VAT.TimeFormats = {
	[0] = { '%d', 'd' }, -- days
	[1] = { '%d', 'h' }, -- hours
	[2] = { '%d', 'm' }, -- minutes
	[3] = { '%d', 's' }, -- seconds
	[4] = { '%.1f', 's' },  -- seconds below decimal threshold
	[5] = { '%d', ' %02d', 'h', 'm' }, -- ExactAuras support
}

-- Text color for value text: days, hours, minutes, seconds, seconds below decimal threshold
VAT.TimeColors = {
	[0] = '|cffeeeeee',
	[1] = '|cffeeeeee',
	[2] = '|cffeeeeee',
	[3] = '|cffeeeeee',
	[4] = '|cfffe0000',
	[5] = '|cffeeeeee', --ExactAuras support
}

-- Text color for indicators: d (days), h (hours), m (minutes), s (seconds), s (seconds, below decimal threshold)
VAT.IndicatorColors = {
	[0] = '|cff00b3ff',
	[1] = '|cff00b3ff',
	[2] = '|cff00b3ff',
	[3] = '|cff00b3ff',
	[4] = '|cff00b3ff',
	[5] = '|cff00b3ff', --ExactAuras support
}

function VAT:CreateBar(button)
	if not button.Holder then
		local width = button:GetWidth();
		local height = button:GetHeight();
		local pos = E.db.VAT.position;
		local spacing = E.db.VAT.spacing
		local isOnTop = pos == 'TOP' and true or false;
		local isOnBottom = pos == 'BOTTOM' and true or false;
		local isOnLeft = pos == 'LEFT' and true or false;
		local isOnRight = pos == 'RIGHT' and true or false;
		
		-- Border
		local BarHolder = CreateFrame('Frame', nil, button)
		BarHolder:Width((isOnTop or isOnBottom) and width or (E.db.VAT.barWidth + (E.PixelMode and 0 or 2)))
		BarHolder:Height((isOnLeft or isOnRight) and height or (E.db.VAT.barHeight + (E.PixelMode and 0 or 2)))
		BarHolder:Point(inversePoints[pos], button, pos, (isOnTop or isOnBottom) and 0 or ((isOnLeft and -((E.PixelMode and 1 or 3) + spacing)) or ((E.PixelMode and 1 or 3) + spacing)), (isOnLeft or isOnRight) and 0 or ((isOnTop and ((E.PixelMode and 1 or 3) + spacing) or -((E.PixelMode and 1 or 3) + spacing))))
		BarHolder:SetTemplate('Default', nil, true)
		BarHolder.backdropTexture:SetTexture(E.db.VAT.useBackdropTexture and LSM:Fetch("statusbar", E.db['VAT'].backdropTexture) or E['media'].blankTex)
		button.Holder = BarHolder

		-- Statusbar
		local Bar = CreateFrame('StatusBar', nil, BarHolder)
		Bar:SetInside(BarHolder)
		Bar:SetStatusBarTexture(E.db.VAT.useStatusbarTexture and LSM:Fetch("statusbar", E.db['VAT'].statusbarTexture) or E['media'].blankTex)
		if isOnLeft or isOnRight then
			Bar:SetOrientation('VERTICAL')
		end
		button.Bar = Bar
	end
end

function VAT:UpdateAura(button, index)
	-- Auras are updated too early at login, before statusbars have been created.
	if not button.Holder then
		VAT:CreateBar(button)
	end

	local enable = E.db.VAT.enable
	local enableThreshold = E.db.VAT.tenable
	local noduration = E.db.VAT.noduration
	local buffs = E.db.VAT.threshold.buffs
	local debuffs = E.db.VAT.threshold.debuffs
	local buffsvalue = E.db.VAT.threshold.buffsvalue
	local debuffsvalue = E.db.VAT.threshold.debuffsvalue
	local showText = E.db.VAT.showText
	local isDebuff
	local filter = button:GetParent():GetAttribute('filter')
	local unit = button:GetParent():GetAttribute("unit")
	local name, _, _, _, dtype, duration, expiration = UnitAura(unit, index, filter)

	if(name) then
		if(duration > 0 and expiration) then
			local timeLeft = expiration - GetTime()
			if(not button.timeLeft_) then
				button.timeLeft_ = timeLeft
				-- I need to overwrite the existing script, otherwise color flickering will occur
				button:SetScript("OnUpdate", VAT.UpdateTime)
			else
				button.timeLeft_ = timeLeft
			end

			button.nextUpdate = -1
			VAT.UpdateTime(button, 0)
		else
			button.timeLeft_ = nil
			button.time:SetText("")
			button:SetScript("OnUpdate", nil)			
		end
		
		if UnitBuff('player',name) then
			isDebuff = false
		elseif UnitDebuff('player',name) then
			isDebuff = true
		end
	
		if filter == 'HARMFUL' then
			local color = DebuffTypeColor[dtype or ""]
			-- Match color of statusbar border to color of the border of the debuff aura
			button.Holder:SetBackdropBorderColor(color.r, color.g, color.b)
		else
			button.Holder:SetBackdropBorderColor(unpack(E.media.bordercolor))
		end

		-- Set min / max values
		if (button.Bar and duration > 0 and expiration) then
			button.Bar:SetMinMaxValues(0, duration)
		else
			-- Make sure a full statusbar is shown if aura has no duration
			local min, max  = button.Bar:GetMinMaxValues()
			button.Bar:SetValue(max)
			if E.db.VAT.enableStaticColor then
				local color = E.db.VAT.staticColor
				button.Bar:SetStatusBarColor(color.r, color.g, color.b)
			else
				button.Bar:SetStatusBarColor(0, 0.8, 0)
			end
		end
		local color = E.db.VAT.backdropColor
		button.Holder.backdropTexture:SetVertexColor(color.r, color.g, color.b)
	end

	-- Toggle Visual Timer and Text Timer
	-- For auras with no duration
	local timeLeft = button.timeLeft_
	if not timeLeft then
		if enable then -- Toggle visual timer
			-- If 'No Duration' is disabled then hide statusbar on auras with no duration
			if not noduration then
				button.Holder:Hide()
			else
				button.Holder:Show()
			end
		else -- Disable visual timer
			button.Holder:Hide()
		end
	else -- For auras with a duration
		if enable then -- Toggle visual timer
			button.Holder:Show()
			if showText then
				button.time:Show()
			else
				button.time:Hide()
				-- If aura duration goes below threshold then toggle to text
				if enableThreshold then
					-- Buffs
					if buffs and timeLeft <= buffsvalue and duration > 0 and isDebuff == false then
						button.Holder:Hide()
						button.time:Show()
					-- Debuffs
					elseif debuffs and timeLeft <= debuffsvalue and duration > 0 and isDebuff == true then
						button.Holder:Hide()
						button.time:Show()
					else
						button.Holder:Show()
						button.time:Hide()
					end
				end
			end
		else -- Toggle to text only
			button.Holder:Hide()
			button.time:Show()
		end

		-- Set color and value of statusbar
		local r, g, b
		button.Bar:SetValue(timeLeft)
		if E.db.VAT.enableStaticColor then
			local color = E.db.VAT.staticColor
			r, g, b = color.r, color.g, color.b
		else
			r, g, b = ElvUF.ColorGradient(timeLeft, duration or 0, 0.8,0,0,0.8,0.8,0,0,0.8,0)
		end
		button.Bar:SetStatusBarColor(r, g, b)
	end
end

function VAT:UpdateTempEnchant(button, index)
	-- Auras are updated too early at login, before statusbars have been created.
	if not button.Holder then
		VAT:CreateBar(button)
	end

	local offset = 2
	local weapon = button:GetName():sub(-1)
	if weapon:match("2") then
		offset = 5
	end

	local expirationTime = select(offset, GetWeaponEnchantInfo())
	if(expirationTime) then
		button.offset = offset
		-- I need to overwrite the existing script, otherwise color flickering will occur
		button:SetScript("OnUpdate", VAT.UpdateTime)
		button.nextUpdate = -1
		VAT.UpdateTime(button, 0)
	else
		button.timeLeft = nil
		button.offset = nil
		button:SetScript("OnUpdate", nil)
		button.time:SetText("")
	end

	local timeLeft = button.timeLeft
	if timeLeft then
		local duration
		-- Here we try to figure out the maximum duration of the weapon enchant
		-- If less than 1 hour and higher than 30 minutes set max duration to 1 hour
		if timeLeft <= 3600.5 and timeLeft > 1800.5 then
			duration = 3600
		-- if less than 30 minutes and higher than 10 minutes set max duration to 30 minutes
		elseif timeLeft <= 1800.5 and timeLeft > 600.5 then
			duration = 1800
		--if less than 10 minutes and higher than 0 seconds set max duration to 10 minutes
		elseif timeLeft <= 600.5 and timeLeft > 0 then
			duration = 600
		end
	end

	-- Set min / max values
	if (button.Bar and duration) then
		button.Bar:SetMinMaxValues(0, duration)
	else
		-- Make sure a full statusbar is shown if Temp. Enchant has no duration (none that I know of, but might be in the future)
		local min, max  = button.Bar:GetMinMaxValues()
		button.Bar:SetValue(max)
		if E.db.VAT.enableStaticColor then
			local color = E.db.VAT.staticColor
			button.Bar:SetStatusBarColor(color.r, color.g, color.b)
		else
			button.Bar:SetStatusBarColor(0, 0.8, 0)
		end
	end

	local enable = E.db.VAT.enable
	local enableThreshold = E.db.VAT.tenable
	local tempenchants = E.db.VAT.threshold.tempenchants
	local tempenchantsvalue = E.db.VAT.threshold.tempenchantsvalue
	local noduration = E.db.VAT.noduration
	local showText = E.db.VAT.showText

	-- Apparently 'totems' are calling updates here, prevent errors by checking if holder is created
	if button.Holder then
		-- Toggle Visual Timer and Text Timer
		-- For auras with no duration
		if not timeLeft then
			if enable then -- Toggle visual timer
				-- If 'No Duration' is disabled then hide statusbar on auras with no duration
				if not noduration then
					button.Holder:Hide()
				else
					button.Holder:Show()
				end
			else -- Disable visual timer
				button.Holder:Hide()
			end
		else -- For auras with a duration
			if enable then -- Toggle visual timer
				button.Holder:Show()
				if showText then
					button.time:Show()
				else
					button.time:Hide()
					-- If aura duration goes below threshold then toggle to text
					if enableThreshold and tempenchants and timeLeft <= tempenchantsvalue then
						button.Holder:Hide()
						button.time:Show()
					else
						button.Holder:Show()
						button.time:Hide()
					end
				end
			else --Toggle to text only
				button.Holder:Hide()
				button.time:Show()
			end
			
			-- Set color and value of statusbar and match color of statusbar border to color of the aura border
			local r, g, b
			button.Bar:SetValue(timeLeft)
			if E.db.VAT.enableStaticColor then
				local color = E.db.VAT.staticColor
				r, g, b = color.r, color.g, color.b
			else
				r, g, b = ElvUF.ColorGradient(timeLeft, duration or 0, 0.8,0,0,0.8,0.8,0,0,0.8,0)
			end
			button.Bar:SetStatusBarColor(r, g, b)
			local quality = GetInventoryItemQuality("player", index)
			if (quality) then
				button.Holder:SetBackdropBorderColor(GetItemQualityColor(quality))
			end
		end
	end
end

function VAT:UpdateHeader(header)
	if (not E.private.auras.enable) then return end
	
	local db = A.db.debuffs
	if header:GetAttribute('filter') == 'HELPFUL' then
		db = A.db.buffs
	end
	
	local width = db.size;
	local height = db.size;
	local pos = E.db.VAT.position;
	local spacing = E.db.VAT.spacing
	local isOnTop = pos == 'TOP' and true or false;
	local isOnBottom = pos == 'BOTTOM' and true or false;
	local isOnLeft = pos == 'LEFT' and true or false;
	local isOnRight = pos == 'RIGHT' and true or false;
	
	local index = 1
	local child = select(index, header:GetChildren())
	while (child) do
		if (child.Holder) then
			child.Holder:Width((isOnTop or isOnBottom) and width or (E.db.VAT.barWidth + (E.PixelMode and 0 or 2)))
			child.Holder:Height((isOnLeft or isOnRight) and height or (E.db.VAT.barHeight + (E.PixelMode and 0 or 2)))
			child.Holder:ClearAllPoints()
			child.Holder:Point(inversePoints[pos], child, pos, (isOnTop or isOnBottom) and 0 or ((isOnLeft and -((E.PixelMode and 1 or 3) + spacing)) or ((E.PixelMode and 1 or 3) + spacing)), (isOnLeft or isOnRight) and 0 or ((isOnTop and ((E.PixelMode and 1 or 3) + spacing) or -((E.PixelMode and 1 or 3) + spacing))))
			child.Holder:SetTemplate('Default', nil, true)
			child.Holder.backdropTexture:SetTexture(E.db.VAT.useBackdropTexture and LSM:Fetch("statusbar", E.db['VAT'].backdropTexture) or E['media'].blankTex)
			
			child.Bar:SetStatusBarTexture(E.db.VAT.useStatusbarTexture and LSM:Fetch("statusbar", E.db['VAT'].statusbarTexture) or E['media'].blankTex)
			if isOnLeft or isOnRight then
				child.Bar:SetOrientation('VERTICAL')
			else
				child.Bar:SetOrientation('HORIZONTAL')
			end
		end

		index = index + 1
		child = select(index, header:GetChildren())
	end
end

function VAT:UpdateTime(elapsed)
	if(self.offset) then
		local expiration = select(self.offset, GetWeaponEnchantInfo())
		if(expiration) then
			self.timeLeft = expiration / 1e3
		else
			self.timeLeft = 0
		end
	else
		self.timeLeft = self.timeLeft - elapsed
	end

	if(self.nextUpdate > 0) then
		self.nextUpdate = self.nextUpdate - elapsed
		return
	end

	local timerValue, formatID
	timerValue, formatID, self.nextUpdate = E:GetTimeInfo(self.timeLeft, E.db.VAT.decimalThreshold)
	if type(timerValue) == 'string' then --ExactAuras support
		self.time:SetFormattedText(VAT:FormatString(timerValue, formatID))
	else
		self.time:SetFormattedText(("%s%s|r%s%s|r"):format(VAT.TimeColors[formatID], VAT.TimeFormats[formatID][1], VAT.IndicatorColors[formatID], VAT.TimeFormats[formatID][2]), timerValue)
	end

	if self.timeLeft > E.db.auras.fadeThreshold then
		E:StopFlash(self)
	else
		E:Flash(self, 1)
	end
end

function VAT:FormatString(str, formatID)
	local a,b,c,d = strmatch(str, "(%d+)(%a)%s(%d+)(%a)") --Credit Cutepally
	if a and b == 'h' and c and d == 'm' then
		local formatString = format("%s%s|r%s%s|r%s%s|r%s%s|r", VAT.TimeColors[formatID], VAT.TimeFormats[formatID][1], VAT.IndicatorColors[formatID], VAT.TimeFormats[formatID][3], VAT.TimeColors[formatID], VAT.TimeFormats[formatID][2], VAT.IndicatorColors[formatID], VAT.TimeFormats[formatID][4])
		return formatString, tonumber(a), tonumber(c)
	end
end

function VAT:UpdateTimerColors()
	local c, c2

	--color for timers shown in the HH:MM format (ExactAuras support)
	c, c2 = E.db.VAT.colors.hourminutes, E.db.VAT.colors.hourminutesIndicator
	VAT.TimeColors[5] = E:RGBToHex(c.r, c.g, c.b)
	VAT.IndicatorColors[5] = E:RGBToHex(c2.r, c2.g, c2.b)
	
	-- colors for timers that are soon to expire
	c, c2 = E.db.VAT.colors.expire, E.db.VAT.colors.expireIndicator
	VAT.TimeColors[4] = E:RGBToHex(c.r, c.g, c.b)
	VAT.IndicatorColors[4] = E:RGBToHex(c2.r, c2.g, c2.b)
	
	-- colors for timers that have seconds remaining
	c, c2 = E.db.VAT.colors.seconds, E.db.VAT.colors.secondsIndicator
	VAT.TimeColors[3] = E:RGBToHex(c.r, c.g, c.b)
	VAT.IndicatorColors[3] = E:RGBToHex(c2.r, c2.g, c2.b)
	
	-- colors for timers that have minutes remaining
	c, c2 = E.db.VAT.colors.minutes, E.db.VAT.colors.minutesIndicator
	VAT.TimeColors[2] = E:RGBToHex(c.r, c.g, c.b)
	VAT.IndicatorColors[2] = E:RGBToHex(c2.r, c2.g, c2.b)
	
	-- color for timers that have hours remaining
	c, c2 = E.db.VAT.colors.hours, E.db.VAT.colors.hoursIndicator
	VAT.TimeColors[1] = E:RGBToHex(c.r, c.g, c.b)
	VAT.IndicatorColors[1] = E:RGBToHex(c2.r, c2.g, c2.b)

	-- color for timers that have days remaining
	c, c2 = E.db.VAT.colors.days, E.db.VAT.colors.daysIndicator
	VAT.TimeColors[0] = E:RGBToHex(c.r, c.g, c.b)
	VAT.IndicatorColors[0] = E:RGBToHex(c2.r, c2.g, c2.b)
end

function VAT:Initialize()
	-- Register callback with LibElvUIPlugin
	EP:RegisterPlugin(addon, VAT.InsertOptions)

	--ElvUI Auras are not enabled, stop right here!
	if E.private.auras.enable ~= true then return; end
	
	self:UpdateTimerColors()

	hooksecurefunc(A, 'UpdateTime', VAT.UpdateTime)
	hooksecurefunc(A, 'CreateIcon', VAT.CreateBar)
	hooksecurefunc(A, 'UpdateAura', VAT.UpdateAura)
	hooksecurefunc(A, 'UpdateTempEnchant', VAT.UpdateTempEnchant)
	hooksecurefunc(A, "UpdateHeader", VAT.UpdateHeader)
end
