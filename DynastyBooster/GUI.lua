local ADDON_NAME, DGV = ...;

local GUI = {};
DGV.GUI = GUI;

local LibElci = DynastyCore.LibElci;

local MainWindow = LibElci.Create(UIParent,'Window','DGV_MainWindow');
local HeaderFrame = MainWindow:Create('Frame');
local ProgressBar = MainWindow:Create('ProgressBar');
local TaskContainer = MainWindow:Create('Frame');
local GuideTitle, SkipBtn;
local TaskFrames = {};
local TipsWindow = nil;

local ConfigControls = {
	Arrow = {
		ShowArrow = {},
		UseTomTom = {},
	},
};

local ArtScale = 1;

function GUI:Load()
	
	DynastyCore:StyleMainWindow(MainWindow,{})
	MainWindow:SetFrameLevel(1)
	MainWindow:SetSize(400,170);
	MainWindow:SetClampedToScreen(true);
	MainWindow:SetPoint('CENTER');
	
	-- helper function for cutting up texture file.
	local NewTexture = function( p,x,y,w,h )
		local t = p:CreateTexture();
		t:SetTexture('Interface\\AddOns\\'..ADDON_NAME..'\\Textures');
		t:SetTexCoord( x/512, (x+w)/512, y/128, (y+h)/128 );
		t:SetSize(w,h);
		return t;
	end
	
	local BrowserBtn = MainWindow:Create('Button',function()
		self.ConfigMode = false;
		DGV:ShowBrowser()
	end);
	BrowserBtn:SetStyle('Dynasty');
	BrowserBtn:SetColor(0.4,0.3,0.15,1);
	BrowserBtn:SetTexture( NewTexture(BrowserBtn,50,100,33,26) );
	BrowserBtn:SetSize(33,26);
	BrowserBtn:SetPoint('TOPRIGHT',-58,-32);
	
	local ConfigBtn = MainWindow:Create('Button',function()
		self.ConfigMode = not self.ConfigMode;
		self:ShowTips();
		self:Update();
	end);
	ConfigBtn:SetStyle('Dynasty');
	ConfigBtn:SetColor(0.4,0.3,0.15,1);
	ConfigBtn:SetTexture( NewTexture(ConfigBtn,17,100,33,26) );
	ConfigBtn:SetSize(33,26);
	ConfigBtn:SetPoint('TOPRIGHT',-24,-32);
	
	GuideTitle = MainWindow:Create('FontString',14,nil,1,1,1,0.5);
	GuideTitle:SetPoint('TOP',0,-4);
	
	TaskContainer:SetScale(1/ArtScale);
	TaskContainer:SetPoint('TOPLEFT',18*ArtScale,-70.1*ArtScale);
	TaskContainer:SetPoint('BOTTOMRIGHT',-16*ArtScale,26.9*ArtScale);
	TaskContainer:SetBackdropBorderColor(0.2,0.1,0.1);
	
	ProgressBar:SetPoint('BOTTOMLEFT',18,16.9);
	ProgressBar:SetPoint('RIGHT',-18,0);
	ProgressBar:SetHeight(10);
	ProgressBar:SetBackdrop({});
	ProgressBar:SetColor(0.1,0.3,0.6,0.5);
	ProgressBar.SmoothReverse = false;
	
	SkipBtn = MainWindow:Create('Button',function(btn,type)
		if type == 'RightButton' then
			DGV:ClearSkipped();
		else
			DGV:SkipTask();
		end
	end)
	SkipBtn:RegisterForClicks('AnyUp');
	
	SkipBtn:SetStyle('Dynasty');
	SkipBtn:SetColor(0.4,0.3,0.15,1);
	SkipBtn:SetPoint('TOPRIGHT',-102,-44);
	SkipBtn:SetText('>>');
	SkipBtn:SetSize(40,14);
	
	--[[
	-- Popup buttons
	MainWindow.PopupButtons = {};
	local QuickGuideBtn = MainWindow:Create('Button',function()
		print('guide');
	end);
	QuickGuideBtn:SetText('Quick Guide');
	QuickGuideBtn:SetColor(0.15,0.075,0.075,1);
	QuickGuideBtn:SetPushedColor(0.3,0.15,0.15,1);
	QuickGuideBtn:SetPoint('TOP',0,-90);
	QuickGuideBtn:SetSize(180.5,40.5);
	tinsert(MainWindow.PopupButtons, QuickGuideBtn);
	QuickGuideBtn:SetShown(false);
	
	local LevelingTipsBtn = MainWindow:Create('Button',function()
		print('tips');
	end);
	LevelingTipsBtn:SetText('Legion Leveling Tips');
	LevelingTipsBtn:SetColor(0.15,0.075,0.075,1);
	LevelingTipsBtn:SetPushedColor(0.3,0.15,0.15,1);
	LevelingTipsBtn:SetPoint('TOP',0,-145);
	LevelingTipsBtn:SetSize(180.5,40);
	tinsert(MainWindow.PopupButtons, LevelingTipsBtn);
	LevelingTipsBtn:SetShown(false);
	--]]
end

function GUI:Show()
	MainWindow:Show();
end
function GUI:Hide()
	MainWindow:Hide();
end

function GUI:IsShown()
	return MainWindow:IsShown()
end

function GUI:ShowConfig()
	--[[
	local y = 100;
	for i = 1, #TaskFrames do
		TaskFrames[i]:SetShown(false)
	end
	
	SkipBtn:SetShown(false)
	MainWindow:Resize( nil, (y/ArtScale)+98, 0.2 );
	GuideTitle:SetText('Config');
	
	for k,b in pairs(MainWindow.PopupButtons) do
		b:Show();
	end
	--]]
end


function GUI:QueuedUpdate()
	GUI.Animating = nil;
	GUI:Update();
end
function GUI.Update()
	--[[
	if GUI.ConfigMode then
		GUI:ShowConfig();
		return;
	end
	
	for k,b in pairs(MainWindow.PopupButtons) do -- hide config
		b:Hide();
	end
	--]]
	if GUI.Animating then
		return; -- let animations finish, and update will be called when they are finished.
	end
	
	local content = DGV:GetContent();
	local animating = false;
	local y = 2;
	
	
	for i = 1, #content do
		local f = TaskFrames[i];
		if not f then
			TaskFrames[i] = TaskContainer:Create('Button');
			f = TaskFrames[i];
			f.Bar = f:Create('ProgressBar');
			f.Bar:SetBackdrop(nil);
			--f.Bar:SetColor(0.3,0.25,0);
			--f.Bar:SetJustifyV('Left','TOP');
			--f.Bar:SetJustifyV('Right','TOP');
			f.Bar:SetPoint('TOPLEFT');
			f.Bar:SetPoint('BOTTOMRIGHT',f,'TOPRIGHT',0,-20);
			f.Bar.SmoothReverse = false;
			
			f.SubText = f:Create('FontString',12,nil,1,1,1,0.5,'LEFT','TOP');
			f.SubText:SetPoint('TOPLEFT',4,-20);
			f.SubText:SetPoint('RIGHT',-4,0);
			
			f:SetPoint('RIGHT',-2,0);
		end
		
		f:Show()
		f:SetPoint('TOPLEFT',2,-y);
		
		f.Bar:SetText( 'Left', content[i].LeftText );
		f.Bar:SetText( 'Right', content[i].RightText );
		
		local progress = content[i].Progress or 0;
		f.Bar:SetValue( progress );
		animating = animating or f.Bar:IsAnimating();
		
		f:SetColor(0.175,0.1,0.08);
		f:SetPushedColor(0.35,0.2,0.16);
		--f:SetBorderColor(0.26,0.13,0.13);
		if content[i].Skipped then -- Skipped task
			f.Bar:SetColor(0.3,0.3,0.6,1);
			f.Color[3] = 0.2;
			f.PushedColor[3] = 0.4;
		elseif progress >= 1 then -- Completed task
			f.Bar:SetColor(0.3,0.6,0.1,1);
			f.Color[2] = 0.2;
			f.PushedColor[2] = 0.4;
		else
			f.Bar:SetColor(0.3,0.6,0.1,0.6);
		end
		
		
		local h = 20;
		local subtext = content[i].SubText;
		if f.Bar.Text['Left']:GetStringWidth() > 300 then -- move content into subtext if it's too long.
			f.Bar:SetText( 'Left', '>>');
			subtext = content[i].LeftText..(subtext and ("\n"..subtext) or '');
		end
		if subtext and subtext:len()>1 then
			f.SubText:SetText(subtext);
			local lines = ceil(f.SubText:GetStringWidth(subtext) / f.SubText:GetWidth());
			h = h+(12*lines)+4;
			f.SubText:SetHeight(h);
		else
			f.SubText:SetText('');
		end
		f:SetHeight(h);
		
		f:Update();
		f.OnClick = content[i].Action;
		
		y = y + h + 1;
	end
	
	for i = #content+1, #TaskFrames do
		TaskFrames[i]:SetShown(false)
	end
	
	SkipBtn:SetShown( DGV:CanSkipTask() )
	GuideTitle:SetText( DGV:GetGuideTitle() );
	MainWindow:Resize( nil, y+98, 0.2 );
	ProgressBar:SetValue( DGV:GetGuideProgress() );
	
	if animating then
		GUI.Animating = true;
		C_Timer.After(1.5, GUI.QueuedUpdate);
	end
	
end

local TIP_CONTENT_GUIDE = ([[
* If you begin using the guide in the middle of a quest chain it may take a little time to sync up with the Booster routes. Continue following the guide as best you can and skip steps you can't complete until you are totally in sync.
* Certain steps require you to manually hit the skip button to continue. Skip button (>>)
* The Legion guide does not include Scenarios due to them occurring in phased zones. Booster doesn't like phased zones!
]]):gsub('%*','\n\226\151\143');
local TIP_CONTENT_TIPS = ([[
* Legion uses a new dynamic leveling system. Mobs, quests and their rewards scale to match your level. Only Suramar is for level 110. This means you can complete the zones in any order you wish. Mobs will always match your level.
* Pure solo questing without exp boosts, heirlooms or dungeons won't get you to 110. Most people only reach 108! You will need about 2 levels of exp from other sources.
* You will need to pickup and complete the Dungeon quest towards the end of each zone's storyline to help you get enough exp. Following the guide will lead to picking up these quests. Doing a few dungeons will probably be required too.
]]):gsub('%*','\n\226\151\143');

function GUI:ShowTips()
	
	if not TipsWindow then
		TipsWindow = LibElci.Create(UIParent,'Window','DGV_TipsWindow');
		TipsWindow:SetFrameLevel(5)
		TipsWindow:SetPoint('TOP',0,-80);
		TipsWindow:SetSize(350,400);
		TipsWindow:SetStyle('Dynasty');
		
		TipsWindow.Content = TipsWindow:Create('Frame');
		TipsWindow.Content:SetPoint('TOPLEFT',12,-36);
		TipsWindow.Content:SetPoint('BOTTOMRIGHT',-12,36);
		TipsWindow.Content:SetStyle('Dynasty');
		
		local TipsText = TipsWindow.Content:Create('FontString',12,nil,1,1,1,0.75,'LEFT','TOP');
		TipsText:SetPoint('TOPLEFT',6,0);
		TipsText:SetPoint('BOTTOMRIGHT',-6,0);
		TipsText:SetText(TIP_CONTENT_GUIDE);
		
		local GuideBtn = TipsWindow:Create('Button',function()
			TipsText:SetText(TIP_CONTENT_GUIDE);
		end);
		GuideBtn:SetPoint('TOPLEFT',12,-12);
		GuideBtn:SetSize(162,20);
		GuideBtn:SetText('Quick Guide');
		GuideBtn:SetStyle('Dynasty');
		TipsWindow.GuideBtn = GuideBtn;
		
		local TipsBtn = TipsWindow:Create('Button',function()
			TipsText:SetText(TIP_CONTENT_TIPS);
		end);
		TipsBtn:SetPoint('TOPRIGHT',-12,-12);
		TipsBtn:SetSize(162,20);
		TipsBtn:SetText('Leveling Tips');
		TipsBtn:SetStyle('Dynasty');
		TipsWindow.TipsBtn = TipsBtn;
		
		local OkayBtn = TipsWindow:Create('Button',function()
			TipsWindow:Hide();
			DGV.GSaved.DontShowTips = true;
		end);
		OkayBtn:SetPoint('BOTTOM',0,12);
		OkayBtn:SetSize(326,20);
		OkayBtn:SetText('Okay');
		OkayBtn:SetStyle('Dynasty');
		TipsWindow.OkayBtn = OkayBtn;
		
	end
	
	TipsWindow:Show();
	
end