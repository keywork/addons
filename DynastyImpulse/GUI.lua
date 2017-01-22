local ADDON_NAME, Impulse = ...;

local GUI = {};
Impulse.GUI = GUI;

local LibElci = DynastyCore.LibElci;

local MainWindow = LibElci.Create(UIParent,'Window','DynastyImpulse_MainWindow');
MainWindow:SetClampedToScreen(true);
MainWindow:SetPoint('CENTER');

local SelectedSet = null;
local SavePrompt = LibElci.Create(UIParent,'Window','DynastyImpulse_SavePrompt');
local LoadPrompt = LibElci.Create(UIParent,'Window','DynastyImpulse_SavePrompt');
local DelPrompt = LibElci.Create(UIParent,'Window','DynastyImpulse_SavePrompt');
local SetList;
local ArtScale = 1;
MainWindow:SetScale(ArtScale);

function GUI:Load()
	MainWindow:SetSize(400,430);
	MainWindow:SetShown(false);
	MainWindow:Show();
	DynastyCore:StyleMainWindow(MainWindow, {
		IconX = 860,
		IconY = 0
	});
	
	SetList = MainWindow:Create('DataTable');
	SetList:SetPoint('TOPLEFT',24,-76);
	SetList:SetSize(240,212);
	SetList.NoHeader = true;
	SetList.MultiSelect = false;
	SetList.Data = {};
	SetList.RowHeight = 22;
	SetList:AddColumn({
		Render = function(task,data,cell)
			return data.Name;
		end,
		Align = 'LEFT'
	});
	SetList:OnResize();
	SetList:SetStyle('Dynasty');
	
	local InfoFrame = MainWindow:Create('ScrollFrame');
	InfoFrame:SetPoint('TOPLEFT',SetList,'BOTTOMLEFT',0,-4);
	InfoFrame:SetPoint('BOTTOMRIGHT',-24,26);
	InfoFrame:SetSize(240,220);
	InfoFrame:SetStyle('Dynasty');
	InfoFrame.Text = InfoFrame.Content:Create('FontString');
	InfoFrame.Text:SetPoint('TOPLEFT',4,-4);
	InfoFrame.Text:SetWidth(330);
	InfoFrame.Text:SetJustifyH('LEFT');
	
	local LoadBtn = MainWindow:Create('Button', self.ShowLoadPrompt);
	LoadBtn:SetPoint('BOTTOMLEFT',SetList,'BOTTOMRIGHT',4,0);
	LoadBtn:SetPoint('RIGHT',InfoFrame,'RIGHT');
	LoadBtn:SetHeight(22);
	LoadBtn:SetText('Load');
	LoadBtn:SetStyle('Dynasty');
	
	local SaveBtn = MainWindow:Create('Button', self.ShowSavePrompt);
	SaveBtn:SetPoint('BOTTOMLEFT',LoadBtn,'TOPLEFT',0,4);
	SaveBtn:SetPoint('RIGHT',InfoFrame,'RIGHT');
	SaveBtn:SetHeight(22);
	SaveBtn:SetText('Save');
	SaveBtn:SetStyle('Dynasty');
	
	local DeleteBtn = MainWindow:Create('Button',GUI.ShowDeletePrompt);
	DeleteBtn:SetPoint('BOTTOMLEFT',SaveBtn,'TOPLEFT',0,4);
	DeleteBtn:SetPoint('RIGHT',InfoFrame,'RIGHT');
	DeleteBtn:SetHeight(22);
	DeleteBtn:SetText('Delete');
	DeleteBtn:SetStyle('Dynasty');
	
	SetList.OnSelectionChanged = function(c)
		local i = next(SetList.Selected);
		LoadBtn:SetEnabled(not not i);
		local set = SetList.Data[i];
		DeleteBtn:SetEnabled((not not i) and set.CanDelete);
		SelectedSet = set;
		local text = '';
		if set then
			text = '|cFF99CC77Name:|r '..set.Name;
			if set.Creator then text=text..'\n|cFF99CC77Creator:|r '..set.Creator; end
			if set.Created then text=text..'\n|cFF99CC77Date:|r '..set.Created; end
			if set.Description then text=text..'\n\n|cFFBBAACC'..set.Description; end
		end
		InfoFrame.Text:SetText(text);
		InfoFrame.Content:SetHeight(InfoFrame.Text:GetStringHeight()+8);
		InfoFrame:Update();
	end
	
	self.FilterButtons = {};
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
		local btn = MainWindow:Create('Button',function()
			if Impulse.ClassFilter == class then return end
			Impulse.ClassFilter = class;
			wipe(SetList.Selected);
			GUI:Update();
		end);
		self.FilterButtons[i] = btn;
		btn.Class = class;
		btn:SetBackdrop({});
		btn:SetSize(30,32);
		btn:SetPoint('TOPRIGHT', (-32*((i-1)%3))-30, -(80+(floor((i-1)/3)*32)));
		
		local icon = btn:Create('Texture','Interface/AddOns/DynastyCore/Media/Classes');
		icon:SetPoint('CENTER');
		icon:SetSize(30,32);
		icon:SetTexCoord( ((i-1)*60)/1024, (i*60)/1024, 0, 1 );
		icon:SetVertexColor(1,1,1,1);
		icon:SetAlpha(0.25)
		btn.Step = -0.1
		btn.OnUpdate = function(c,v)
			v = c.Enabled and v or 1;
			icon:SetAlpha(0.25+(0.75*v));
			icon:SetSize(30+(6*v),32+(6.4*v));
		end
	end
	
	do -- Save Prompt
		SavePrompt:SetShown(false);
		SavePrompt:SetSize(220,49);
		SavePrompt:SetStyle('Dynasty', true);
		SavePrompt:SetPoint('CENTER',MainWindow,'CENTER');
		SavePrompt:SetFrameLevel(11);
		SavePrompt:SetMovable(false);
		
		local Input = SavePrompt:Create('EditBox');
		Input:SetPoint('BOTTOMLEFT',10,10);
		Input:SetSize(160,20)
		Input:SetStyle('Dynasty');
		SavePrompt.Input = Input;
		
		local Button = SavePrompt:Create('Button',function()
			if Impulse:GenerateSet(Input:GetText()) then
				SavePrompt:Hide();
				GUI:Update();
			else
				print('Set names must be unique per class.');
			end
		end);
		Button:SetPoint('BOTTOMRIGHT',-10,10);
		Button:SetSize(37,20);
		Button:SetText('Save');
		Button:SetStyle('Dynasty');
	end
	
	do -- Load Prompt
		LoadPrompt:SetShown(false);
		LoadPrompt:SetSize(270,110);
		LoadPrompt:SetStyle('Dynasty');
		LoadPrompt:SetPoint('CENTER',MainWindow,'CENTER');
		LoadPrompt:SetFrameLevel(12);
		LoadPrompt:SetMovable(false);
		
		local WarningMsg = LoadPrompt:Create('FontString',nil,nil,0.8,0.8,0.8,1);
		WarningMsg:SetPoint('TOPLEFT',20,-4);
		WarningMsg:SetPoint('BOTTOMRIGHT',-20,40);
		WarningMsg:SetText("Your current |cFFFFFFFFActionBars|r, |cFFFFFFFFMacros|r and |cFFFFFFFFKeyBinds|r will be overwritten. It's recommended you save your current setup before loading a new one.");
		
		local LoadBtn = LoadPrompt:Create('Button',function()
			if SelectedSet then
				Impulse:LoadSet(SelectedSet);
			end
			LoadPrompt:Hide();
		end);
		LoadBtn:SetPoint('BOTTOMLEFT',32,20);
		LoadBtn:SetSize(100,20);
		LoadBtn:SetText('Load');
		LoadBtn:SetStyle('Dynasty');
		
		local CancelBtn = LoadPrompt:Create('Button',LoadPrompt.HideSelf);
		CancelBtn:SetPoint('BOTTOMRIGHT',-32,20);
		CancelBtn:SetSize(100,20);
		CancelBtn:SetText('Cancel');
		CancelBtn:SetStyle('Dynasty');
	end
	
	do -- Delete Prompt
		DelPrompt:SetShown(false);
		DelPrompt:SetSize(270,80);
		DelPrompt:SetStyle('Dynasty');
		DelPrompt:SetPoint('CENTER',MainWindow,'CENTER');
		DelPrompt:SetFrameLevel(12);
		DelPrompt:SetMovable(false);
		
		local WarningMsg = DelPrompt:Create('FontString',nil,nil,0.8,0.8,0.8,1);
		WarningMsg:SetPoint('TOPLEFT',20,-4);
		WarningMsg:SetPoint('BOTTOMRIGHT',-20,40);
		WarningMsg:SetText("Are you sure?");
		
		local LoadBtn = DelPrompt:Create('Button',function()
			if SelectedSet then
				Impulse:DeleteSet(SelectedSet);
				GUI:Update();
			end
			DelPrompt:Hide();
		end);
		LoadBtn:SetPoint('BOTTOMLEFT',32,20);
		LoadBtn:SetSize(100,20);
		LoadBtn:SetText('Yes');
		LoadBtn:SetStyle('Dynasty');
		
		local CancelBtn = DelPrompt:Create('Button',DelPrompt.HideSelf);
		CancelBtn:SetPoint('BOTTOMRIGHT',-32,20);
		CancelBtn:SetSize(100,20);
		CancelBtn:SetText('No');
		CancelBtn:SetStyle('Dynasty');
	end
end

function GUI:Update()
	Impulse.ClassFilter = Impulse.ClassFilter or select(2, UnitClass('Player'));
	for i,btn in pairs(self.FilterButtons) do
		btn.FocusLocked = btn.Class == Impulse.ClassFilter;
		btn:Update();
	end
	wipe(SetList.Data);
	for index,set in pairs(Impulse.Sets) do
		if set.Class == Impulse.ClassFilter then
			tinsert(SetList.Data, set);
		end
	end
	SetList:DataChanged();
	
	if SelectedSet then
		
	end
end

function GUI:Show()
	MainWindow:Show();
end
function GUI:Hide()
end

function GUI.ShowSavePrompt()
	SavePrompt:Show();
	SavePrompt.Input:SetFocus();
	SavePrompt.Input:SetText(Impulse:NextSetName());
end
function GUI.ShowDeletePrompt()
	DelPrompt:Show();
end
function GUI.ShowLoadPrompt()
	-- TODO: Impulse.GSaved.SkipLoadWarning
	LoadPrompt:Show();
end
