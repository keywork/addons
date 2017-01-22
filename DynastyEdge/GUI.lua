local ADDON_NAME, EDGE = ...;

local GUI = {};
EDGE.GUI = GUI;

local LibElci = DynastyCore.LibElci;

local MainWindow = LibElci.Create(UIParent,'Window','DynastyEdge_MainWindow');
MainWindow:SetClampedToScreen(true);
MainWindow:SetPoint('CENTER');

local ArtScale = 1;
MainWindow:SetScale(ArtScale);

local HeaderBar,ContentArea,ContentPane,TitleBar,StatusBar,SideBar,PageTitle,PageScroll;
local ClassButtons = {};
local ActivityButtons = {};
local SpecButtons = {};
local PageButtons = {};

function GUI:Load()
	
	MainWindow:SetSize(494,320);
	MainWindow:SetShown(false);
	MainWindow:Show();
	MainWindow:SetBackdrop(nil);
	
	-- helper function for cutting up texture file.
	local NewTexture = function( p,x,y,w,h )
		local t = p:CreateTexture();
		t:SetTexture('Interface\\AddOns\\'..ADDON_NAME..'\\Textures');
		t:SetTexCoord( x/512, (x+w)/512, y/128, (y+h)/128 );
		t:SetSize(w,h);
		return t;
	end
	
	-- Frame Art
	local HeaderBG = NewTexture(MainWindow,0,0,494,76);
	HeaderBG:SetPoint('TOPLEFT');
	HeaderBG:SetPoint('RIGHT');
	local ContentSpan = NewTexture(MainWindow,0,76,494,1);
	ContentSpan:SetPoint('TOPLEFT',0,-76);
	ContentSpan:SetPoint('BOTTOMRIGHT',0,27);
	local FooterBG = NewTexture(MainWindow,0,77,494,27);
	FooterBG:SetPoint('BOTTOMLEFT');
	FooterBG:SetPoint('RIGHT');
	
	-- Buttons
	local CloseBtn = MainWindow:Create('Button',function()
		MainWindow:Hide();
	end);
	CloseBtn:SetBackdrop({});
	CloseBtn:SetColor(1,0,0);
	CloseBtn:SetPushedColor(1,1,0);
	CloseBtn:SetTexture( NewTexture(CloseBtn,0,104,17,16) );
	CloseBtn:SetSize(17,16);
	CloseBtn:SetPoint('TOPRIGHT',-23,-6);
	
	
	local ClassBtn = MainWindow:Create('Button',function(btn,type)
		EDGE:SetMode('ClassSelect');
		GUI:Update();
	end)
	ClassBtn:RegisterForClicks('AnyUp');
	ClassBtn:SetTexture( NewTexture(ClassBtn,46,104,18,16) );
	ClassBtn.Texture:ClearAllPoints();
	ClassBtn.Texture:SetPoint('CENTER');
	ClassBtn:SetColor(1,1,1);
	ClassBtn:SetPushedColor(1,0.5,0);
	ClassBtn:SetBackdrop({});
	ClassBtn:SetPoint('TOPRIGHT',-27,-36);
	ClassBtn:SetSize(33,28);
	ClassBtn.Step = -0.1
	ClassBtn:Update();
	
	-- Invisible container frame
	ContentArea = MainWindow:Create('Frame');
	ContentArea:SetPoint('TOPLEFT',17,-74);
	ContentArea:SetPoint('BOTTOMRIGHT',-17,18);
	ContentArea:SetBackdrop({});
	
	-- Common
	HeaderBar = ContentArea:Create('Button');
	HeaderBar.Enabled = false;
	HeaderBar:SetColor(0.2,0.1,0.05,0.8);
	HeaderBar:SetPoint('TOPLEFT',4,-4);
	HeaderBar:SetPoint('RIGHT',-4,0);
	HeaderBar:SetHeight(21);
	NewTexture(HeaderBar,17,104,29,16):SetPoint('TOP',HeaderBar,'BOTTOM',0,0);
	HeaderBar.Text:SetFont('Fonts\\FRIZQT__.TTF', 13, '');
	HeaderBar.Text:SetShadowColor(0,0,0,1);
	HeaderBar.Text:SetShadowOffset(1,-1);
	do -- text fade switcher
		local str;
		local delayedUpdate = function()
			HeaderBar.Text:Show();
			HeaderBar.Text:SetText(str);
		end
		function HeaderBar:UpdateText(s)
			HeaderBar.Text:Hide();
			str = s;
			C_Timer.After(0.5,delayedUpdate);
		end
	end
	
	ContentPane = ContentArea:Create('Frame');
	ContentPane:SetPoint('TOPLEFT',4,-28);
	ContentPane:SetPoint('BOTTOMRIGHT',-4,3);
	ContentPane:SetBackdrop({
		bgFile = 'Interface/AddOns/DynastyCore/Media/Noise',
		edgeFile = "Interface/Buttons/WHITE8X8",
		edgeSize = 2,
	});
	ContentPane:SetBackdropColor(0.4,0.2,0.1,1);
	ContentPane:SetBackdropBorderColor(1,0.5,0.25,0.05);
	ContentPane:SetFrameLevel(3)
	
	StatusBar = ContentPane:Create('Frame');
	StatusBar:SetBackdropColor(1,0.5,0.25,0.04);
	StatusBar:SetBackdropBorderColor(0,0,0,0.025);
	StatusBar:SetPoint('TOPLEFT',10,-12);
	StatusBar:SetPoint('RIGHT',-10,0);
	StatusBar:SetHeight(26);
	StatusBar:SetShown(false);
	
	StatusBar.Text = StatusBar:Create('FontString');
	StatusBar.Text:SetFont('Fonts/MORPHEUS.ttf',16);
	StatusBar.Text:SetPoint('TOPLEFT',10,0);
	StatusBar.Text:SetPoint('BOTTOMRIGHT');
	StatusBar.Text:SetShadowColor(0,0,0,1);
	StatusBar.Text:SetShadowOffset(1,-1);
	StatusBar.Text:SetJustifyH('LEFT');
	
	-- Class Buttons
	for i,class in pairs({ -- order of the icon texture file
		'ROGUE',
		'SHAMAN',
		'MONK',
		'WARRIOR',
		'WARLOCK',
		'PALADIN',
		'HUNTER',
		'DRUID',
		'MAGE',
		'PRIEST',
		'DEATHKNIGHT',
		'DEMONHUNTER'
	}) do
		local btn = ContentArea:Create('Button',function()
			EDGE:SelectClass(class);
			GUI:Update();
		end);
		ClassButtons[i] = btn;
		btn.Class = class;
		btn:SetBackdrop({
			bgFile = 'Interface/AddOns/DynastyCore/Media/Noise',
			edgeFile = "Interface/Buttons/WHITE8X8",
			edgeSize = 1,
		});
		btn:SetColor(0.6,0.3,0.15,1);
		btn:SetPushedColor(1,0.6,0.3,1);
		btn:SetBorderColor(0.36,0.18,0.09,0.6);
		btn:SetBorderPushedColor(0.6,0.36,0.18,0.6);
		btn:SetSize(68,76);
		btn:SetFrameLevel(4)
		
		local shadow = btn:CreateTexture();
		shadow:SetTexture(0,0,0,0.8);
		shadow:SetPoint('BOTTOMLEFT',0,-2);
		shadow:SetPoint('RIGHT');
		shadow:SetHeight(2);
		
		local gradient = btn:CreateTexture();
		gradient:SetAllPoints();
		gradient:SetTexture(1,1,1,1);
		gradient:SetGradientAlpha("VERTICAL",0,0,0,0.5,0,0,0,0);
		
		local icon = btn:Create('Texture','Interface/AddOns/'..ADDON_NAME..'/Classes');
		icon:SetSize(54,57.6);
		icon:SetTexCoord( ((i-1)*60)/1024, (i*60)/1024, 0, 1 );
		icon:SetPoint('CENTER',0,-4);
		icon:SetVertexColor(1,1,1,1);
		
		btn.Step = -0.1
		btn.OnUpdate = function(c,v)
			v = c.Enabled and v or 1;
			--icon:SetAlpha(0.5+(0.5*v));
			icon:SetSize(54+(6*v),57.6+(6.4*v));
		end
		
		btn.x = ((i%6)*72)+16;--((i>6) and ((i%6)*72)-18) or ((i*72)-54);
		btn.y = (i>6) and -134 or -48;
		btn:SetPoint('TOPLEFT',btn.x,btn.y);
		
	end
	
	-- Activity Buttons
	local x = 200;
	for act,texture in pairs({
		['PvE'] = 'Interface/ICONS/Achievement_Boss_GeneralDrakkisath',
		['PvP'] = 'Interface/ICONS/Achievement_BG_winWSG',
		['Leveling'] = 'Interface/ICONS/Achievement_Reputation_08',
	}) do
		local btn = ContentArea:Create('Button',function()
			EDGE:SelectActivity(act);
			GUI:Update();
		end);
		ActivityButtons[act] = btn;
		
		btn:SetBackdrop({});
		btn:SetShown(false);
		btn:SetSize(48,48);
		btn:SetPoint('CENTER',ContentArea,'TOPLEFT',x,-108);
		
		local shadow = btn:Create('Texture','Interface/COMMON/icon-shadow');
		shadow:SetPoint('TOPLEFT',-10,10);
		shadow:SetPoint('BOTTOMRIGHT',15,-15);
		shadow:SetDrawLayer('ARTWORK',1);
		
		local icon = btn:Create('Texture',texture);
		icon:SetAllPoints();
		icon:SetTexCoord(0.075,0.925,0.075,0.925);
		icon:SetDrawLayer('ARTWORK',2);
		
		btn:SetText(act);
		btn.Text:SetFont('Fronts/FRIZQT__.ttf',16,'OUTLINE');
		btn.Text:ClearAllPoints();
		btn.Text:SetPoint('TOP',btn,'BOTTOM',0,-5);
		
		btn.Step = -0.1
		btn.OnUpdate = function(c,v)
			icon:SetAlpha(0.4+(0.6*v));
			btn:SetSize(48+(6*v),48+(6*v));
		end
		
		btn:Update();
		
		x = x+90;
	end
	
	-- Spec Buttons
	for i = 1,4 do
		local btn = ContentArea:Create('Button',function(c)
			EDGE:SelectSpec(c.Spec);
			GUI:Update();
		end);
		SpecButtons[i] = btn;
		
		btn:SetBackdrop({});
		btn:SetShown(false);
		btn:SetSize(48,48);
		
		local shadow = btn:Create('Texture','Interface/COMMON/icon-shadow');
		shadow:SetPoint('TOPLEFT',-10,10);
		shadow:SetPoint('BOTTOMRIGHT',15,-15);
		shadow:SetDrawLayer('ARTWORK',1);
		
		local icon = btn:Create('Texture',texture);
		icon:SetAllPoints();
		icon:SetTexCoord(0.075,0.925,0.075,0.925);
		icon:SetDrawLayer('ARTWORK',2);
		btn.Icon = icon;
		
		btn:SetText('fgt');
		btn.Text:SetFont('Fronts/FRIZQT__.ttf',16,'OUTLINE');
		btn.Text:ClearAllPoints();
		btn.Text:SetPoint('TOP',btn,'BOTTOM',0,-5);
		
		btn.Recommended = btn:Create('Texture','Interface/COMMON/FavoritesIcon');
		btn.Recommended:SetPoint('TOPLEFT',-10,10);
		btn.Recommended:SetDrawLayer('OVERLAY');
		btn.Recommended:Hide();
		
		btn.Step = -0.1
		btn.OnUpdate = function(c,v)
			if not c.Enabled then v = 0 end
			icon:SetAlpha(0.4+(0.6*v));
			btn:SetSize(48+(6*v),48+(6*v));
		end
		
		btn:SetScript('OnShow',function(c)
			c.Enabled = EDGE:CanSelectSpec(c.Spec);
			c.Icon:SetDesaturated(not c.Enabled)
		end);
		
		btn:Update();
	end
	
	SideBar = ContentArea:Create('Frame');
	SideBar:SetPoint('TOPLEFT',4,-4);
	SideBar:SetPoint('BOTTOM',0,3);
	SideBar:SetWidth(130);
	SideBar:SetBackdrop({
		bgFile = 'Interface/AddOns/DynastyCore/Media/Noise',
		edgeFile = "Interface/Buttons/WHITE8X8",
		edgeSize = 2,
	});
	SideBar:SetBackdropColor(0.4,0.2,0.1,0.8);
	SideBar:SetBackdropBorderColor(1,0.5,0.25,0.05);
	
	PageTitle = ContentPane:Create('Frame');
	PageTitle:SetPoint('TOPLEFT',4,-32);
	PageTitle:SetPoint('RIGHT',-4,0);
	PageTitle:SetHeight(20);
	PageTitle:SetBackdrop({});
	PageTitle.BG = PageTitle:Create('Texture','Interface/ACHIEVEMENTFRAME/UI-Achievement-Borders');
	PageTitle.BG:SetTexCoord( 0, 1, 212/256, 231/256 );
	PageTitle.BG:SetAllPoints()
	PageTitle.BG:SetGradientAlpha("VERTICAL",1,1,1,0.25,1,1,1,0);
	PageTitle.Text = PageTitle:Create('FontString',14,'',1,0.8,0.4,1,'LEFT');
	PageTitle.Text:SetPoint('TOPLEFT',6,0);
	PageTitle.Text:SetPoint('BOTTOMRIGHT');
	
	PageScroll = ContentPane:Create('ScrollFrame');
	PageScroll:SetPoint('BOTTOMRIGHT',-2,2);
	PageScroll:SetSize(314,185)
	PageScroll:SetBackdrop({});
	PageScroll.ScrollBar.Bar:SetColorTexture(0.2,0.15,0.1,1);
	
end

function GUI:Show()
	MainWindow:Show();
end

-- switches between the main content layouts
function GUI:Refactor(prev,mode)
	
	-- Hide everything
	HeaderBar:Hide();
	StatusBar:Hide();
	SideBar:Hide();
	PageTitle:Hide();
	PageScroll:Hide();
	for i,btn in pairs(ClassButtons) do
		btn:Hide();
		--btn.Enabled = false;
		--btn:Update();
	end
	for act,btn in pairs(ActivityButtons) do
		btn:Hide();
	end
	for i,btn in pairs(SpecButtons) do
		btn:Hide();
	end
	
	
	if mode ~= 'ClassSelect' then
		-- show back button
		StatusBar:Show();
	else
		if prev == 'Info' then -- Info -> ClassSelect
			-- quickly reposition the class buttons so they don't transition from modified state.
			for i,btn in pairs(ClassButtons) do 
				btn:SetPoint('TOPLEFT',btn.x,btn.y);
				btn:SetSize(68,76);
			end
		end
	end
	
	-- state info
	local selectedClass,selectedAct,selectedSpec = EDGE:GetSelection();
	local className = 'Unknown'
	local classColor = RAID_CLASS_COLORS.PRIEST;
	if selectedClass then
		classColor = RAID_CLASS_COLORS[selectedClass];
		className = (selectedClass == 'DEATHKNIGHT' and 'Death Knight') or selectedClass:lower():gsub("^%l", string.upper);
	end
	
	-- Show new stuff
	if mode == 'Info' and selectedClass and selectedAct and selectedSpec then
		MainWindow:Resize(nil,340,0.3);
		StatusBar.Text:SetText(format('|c%s%s|r  -  %s  -  %s',classColor.colorStr,className,selectedAct,selectedSpec));
		ContentPane:Move('TOPLEFT',136,-4,0.3);
		StatusBar:Move('TOPLEFT',6,-6);
		StatusBar:Move('RIGHT',-6,0);
		StatusBar:SetScale(0.8);
		SideBar:Show();
		PageTitle:Show();
		PageScroll:Show();
		
	else
		HeaderBar:Show();
		ContentPane:Move('TOPLEFT',4,-28,0.3);
		StatusBar:Move('TOPLEFT',10,-12);
		StatusBar:Move('RIGHT',-10,0);
		StatusBar:SetScale(1);
		
		if selectedClass and mode == 'ActivitySelect' then
			MainWindow:Resize(nil,256,0.3);
			HeaderBar:UpdateText('Select An Activity')
			StatusBar.Text:SetText(format('|c%s%s|r',classColor.colorStr,className));
			for i,btn in pairs(ClassButtons) do
				if btn.Class == selectedClass then
					btn:Show();
					btn:Move('TOPLEFT',14,-72,0.3);
					btn:Resize(120,76,0.3);
					--btn.Enabled = false;
					--btn:Update();
				end
			end
			for act,btn in pairs(ActivityButtons) do
				btn:Show();
			end
			
		elseif selectedClass and selectedAct and mode == 'SpecSelect' then
			MainWindow:Resize(nil,256,0.3);
			HeaderBar:UpdateText('Choose A Specialization');
			StatusBar.Text:SetText(format('|c%s%s|r  -  %s',classColor.colorStr,className,selectedAct));
			local n = 0;
			for spec,icon in pairs(EDGE.ClassIcons[selectedClass]) do
				n = n + 1;
				local btn = SpecButtons[n];
				btn.Icon:SetTexture('Interface/ICONS/'..(icon or 'INV_Misc_QuestionMark'));
				btn.Recommended:SetShown( EDGE:IsRecommended(spec) );
				btn:SetText(spec);
				btn.Spec = spec;
			end
			for i,btn in pairs(SpecButtons) do
				if i > n then
					btn:Hide();
				else
					local s = (300/n);
					btn:SetPoint('CENTER',ContentArea,'TOPLEFT',(144+s*i)-(s/2),-108);
					btn:Show();
				end
			end
			for i,btn in pairs(ClassButtons) do
				if btn.Class == selectedClass then
					btn:Show(); -- only need to show it, already setup by ActivitySelect
				end
			end
			
		else -- 'ClassSelect' / Default
			MainWindow:Resize(nil,320,0.3);
			HeaderBar:UpdateText('Choose Your Class');
			
			-- set title bar text
			for i,btn in pairs(ClassButtons) do
				btn:Show();
				btn:Resize(68,76,0.3);
				btn:Move('TOPLEFT',btn.x,btn.y,0.3);
				btn.Enabled = true;
				btn:Update();
			end
		end
	end
end


local prev = nil;
function GUI:Update()
	local mode = EDGE:GetMode();
	if mode ~= prev then
		GUI:Refactor(prev,mode);
		prev = mode;
	end
	
	if mode == 'Info' then
		local selectedPage = EDGE:GetSelectedPage();
		PageTitle.Text:SetText(selectedPage.Title);
		PageScroll.Content:Hide()
		if selectedPage.Frame then
			PageScroll:SetContent(selectedPage.Frame)
			selectedPage.Frame:Show();
		end
		
		local pages = EDGE:GetPageList()
		for i,btn in pairs(PageButtons) do
			btn:SetShown(false);
		end
		for i,page in pairs(pages or {}) do
			local btn = PageButtons[i];
			if not btn then
				btn = SideBar:Create('Button',function()
					EDGE:SelectPage(i)
					GUI:Update();
				end);
				btn.Step = -0.1;
				btn:SetPoint('TOPLEFT',4,20-(i*24));
				btn:SetPoint('RIGHT',-4,0);
				btn:SetHeight(22);
				btn:SetColor(0.2,0.1,0.05,0.8);
				btn:SetPushedColor(0.5,0.3,0.15,0.8);
				btn.Text:SetShadowColor(0,0,0,1);
				btn.Text:SetShadowOffset(1,-1);
				btn.Text:SetJustifyH('LEFT');
				PageButtons[i] = btn;
			end
			btn:SetShown(true);
			btn:SetText(page.Title);
			btn.FocusLocked = page == selectedPage;
			btn:Update();
		end
	end
	
end