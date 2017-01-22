local ADDON_NAME, EDGE = ...;

local LibElci = DynastyCore.LibElci;

local Templates = {};
Templates.TalentsAndGlyphs = function( frame, MajorGlyphs, MinorGlyphs, Talents, TalentTips, GlyphTips )
	local h = 6;
	for tier, spellId in pairs(Talents) do
		local name,_,icon = GetSpellInfo(spellId);
		local texture = frame:CreateTexture();
		texture:SetTexture(icon);
		texture:SetPoint('TOPLEFT',6,-h);
		texture:SetSize(28,28);
		
		local text = frame:CreateFontString();
		text:SetFont('Fonts/ARIALN.TTF',12);
		text:SetText(name);
		text:SetPoint('LEFT',texture,'RIGHT',5,0);
		
		h = h + 34;
	end
	
	if MajorGlyphs then
		local Hr = frame:CreateTexture();
		Hr:SetColorTexture(0.6,0.3,0.15,0.1);
		Hr:SetPoint('TOP',0,-h);
		Hr:SetSize(230,2);
		h = h+4;
		
		for i, spellId in pairs(MajorGlyphs) do
			local name,_,icon = GetSpellInfo(spellId);
			local texture = frame:CreateTexture();
			texture:SetTexture(icon);
			texture:SetPoint('TOPLEFT',6,-h);
			texture:SetSize(26,26);
			
			local text = frame:CreateFontString();
			text:SetFont('Fonts/ARIALN.TTF',10);
			text:SetText((name or 'Unknown'):gsub('^Glyph of ',''));
			text:SetPoint('LEFT',texture,'RIGHT',5,0);
			
			h = h + 30;
		end
		h = h+4;
	end
	
	if MinorGlyphs then
		local Hr = frame:CreateTexture();
		Hr:SetColorTexture(0.6,0.3,0.15,0.1);
		Hr:SetPoint('TOP',0,-h);
		Hr:SetSize(230,2);
		h = h+4;
		
		for i, spellId in pairs(MinorGlyphs) do
			local name,_,icon = GetSpellInfo(spellId);
			local texture = frame:CreateTexture();
			texture:SetTexture(icon);
			texture:SetPoint('TOPLEFT',6,-h);
			texture:SetSize(24,24);
			
			local text = frame:CreateFontString();
			text:SetFont('Fonts/ARIALN.TTF',10);
			text:SetText((name or 'Unknown'):gsub('^Glyph of ',''));
			text:SetPoint('LEFT',texture,'RIGHT',5,0);
			
			h = h + 28;
		end
		h = h+4;
	end
	
	frame:SetHeight(h);
end
Templates.PlayStyles = function( frame, SingleTargetRotation, MultiTargetRotation, EffectiveCooldowns )
	local anchor;
	local h = 0;
	if SingleTargetRotation and SingleTargetRotation ~= '' then
		local title = frame:CreateFontString();
		title:SetFont('Fonts/ARIALN.TTF',14);
		title:SetText('Single-Target');
		title:SetPoint('TOPLEFT',5,-5);
		title:SetTextColor(0.6,0.8,0.5,1);
		local fs = frame:CreateFontString();
		fs:SetFont('Fonts/ARIALN.TTF',10);
		fs:SetText(SingleTargetRotation);
		fs:SetPoint('TOPLEFT',title,'BOTTOMLEFT',0,0);
		fs:SetPoint('RIGHT',-10,0);
		fs:SetJustifyH('LEFT');
		anchor = fs;
		h = h + 20+fs:GetStringHeight();
	end
	if MultiTargetRotation and MultiTargetRotation ~= '' then
		local title = frame:CreateFontString();
		title:SetFont('Fonts/ARIALN.TTF',14);
		title:SetText('Multi-Target');
		if anchor then
			title:SetPoint('TOPLEFT',anchor,'BOTTOMLEFT',0,-5);
		else
			title:SetPoint('TOPLEFT',5,-5);
		end
		title:SetTextColor(0.6,0.8,0.5,1);
		local fs = frame:CreateFontString();
		fs:SetFont('Fonts/ARIALN.TTF',10);
		fs:SetText(MultiTargetRotation);
		fs:SetPoint('TOPLEFT',title,'BOTTOMLEFT',0,0);
		fs:SetPoint('RIGHT',-10,0);
		fs:SetJustifyH('LEFT');
		anchor = fs;
		h = h + 20+fs:GetStringHeight();
	end
	if EffectiveCooldowns and EffectiveCooldowns ~= '' then
		local title = frame:CreateFontString();
		title:SetFont('Fonts/ARIALN.TTF',14);
		title:SetText('Effective Cooldowns');
		if anchor then
			title:SetPoint('TOPLEFT',anchor,'BOTTOMLEFT',0,-5);
		else
			title:SetPoint('TOPLEFT',5,-5);
		end
		title:SetTextColor(0.6,0.8,0.5,1);
		local fs = frame:CreateFontString();
		fs:SetFont('Fonts/ARIALN.TTF',10);
		fs:SetText(EffectiveCooldowns);
		fs:SetPoint('TOPLEFT',title,'BOTTOMLEFT',0,0);
		fs:SetPoint('RIGHT',-10,0);
		fs:SetJustifyH('LEFT');
		h = h + 20+fs:GetStringHeight();
	end
	frame:SetHeight(h+20);
	return true;
end
Templates.Tips = function( frame, tips, tricks )
	local anchor;
	local h = 0;
	if tips and tips ~= '' then
		local title = frame:CreateFontString();
		title:SetFont('Fonts/ARIALN.TTF', 14);
		title:SetText('Buffs');
		if anchor then
			title:SetPoint('TOPLEFT', anchor, 'BOTTOMLEFT', 0, -5);
		else
			title:SetPoint('TOPLEFT', 5, -5);
		end
		title:SetTextColor(0.6, 0.8, 0.5, 1);
		local fs = frame:CreateFontString();
		fs:SetFont('Fonts/ARIALN.TTF', 10);
		fs:SetText(tips);
		fs:SetPoint('TOPLEFT', title, 'BOTTOMLEFT', 0, 0);
		fs:SetPoint('RIGHT', -10, 0);
		fs:SetJustifyH('LEFT');
		h = h + 20+fs:GetStringHeight();
	end
	frame:SetHeight(h+20);
	return true;
end



function EDGE:FillTemplate( frame, key, ... )
	if not Templates[key] then
		return EDGE.Debug and error('No template found: '..tostring(key));
	end
	Templates[key](frame,...);
	return true;
end