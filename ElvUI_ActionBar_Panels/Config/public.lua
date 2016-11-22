local E, L, V, P, G, _ =  unpack(ElvUI);
local DTB = E:NewModule('ActionBarPanels')

-- Defaults -- 
P['datatexts']['ActionBarPanels'] = {
		['Top_DataBar'] = {
			['Enabled'] = false,
			['Width'] = 350,
			['PetBattleHide'] = false,
			['Template'] = "TRANSPARENT",
			['MouseOver'] = false;
		},
		['ActionBarPanelOne'] = {
			['Enabled'] = true,
			['Width'] = 408,
			['PetBattleHide'] = true,
			['Template'] = "DEFAULT",
			['MouseOver'] = false;
		},
		['LeftChatDataBar'] = {
			['Enabled'] = false,
		},
		['RightChatDatatextPanel'] = {
			['Enabled'] = true,
		},
		['RepDataBar'] = {
			['Enabled'] = false,
			['MouseOver'] = false,
			['MiniMapSnap'] = false,
			['Template'] = "TRANSPARENT";
		},
		['ActionBarPanelTwo'] = {
			['Enabled'] = true,
			['MouseOver'] = false,
			['Width'] = 215,
			['DataPlacements'] = 1,
			['PetBattleHide'] = true,
			['Template'] = "DEFAULT";
		},
		['ActionBarPanelThree'] = {
			['Enabled'] = true,
			['MouseOver'] = false,
			['Width'] = 215,
			['DataPlacements'] = 1,
			['PetBattleHide'] = true,
			['Template'] = "DEFAULT";
		},
		['ActionBarPanelFour'] = {
			['Enabled'] = false,
			['MouseOver'] = false,
			['Width'] = 202,
			['DataPlacements'] = 1,
			['PetBattleHide'] = true,
			['Template'] = "DEFAULT";
		},
		['TopPanel'] = {
			['Enabled'] = true,
			['Height'] = 1,
			['PetBattleHide'] = false,
			['Template'] = "TRANSPARENT";
		},
		['BottomPanel'] = {
			['Enabled'] = true,
			['Height'] = 12,
			['PetBattleHide'] = false,
			['Template'] = "TRANSPARENT";
		},
	}

------Background Defaults------	
P['datatexts']['Backgrounds'] = {
	['LeftBG'] = {
		['Enabled'] = false,
		['Height'] = 50,
		['Width'] = 50,
		['XOff'] = 0,
		['YOff'] = 0,
		['PetHide'] = false,
		['Template'] = "DEFAULT",
	},
	['RightBG'] = {
		['Enabled'] = false,
		['Height'] = 50,
		['Width'] = 50,
		['XOff'] = 0,
		['YOff'] = 0,
		['PetHide'] = false,
		['Template'] = "DEFAULT",
	},
	['BottomBG'] = {
		['Enabled'] = false,
		['Height'] = 50,
		['Width'] = 50,
		['XOff'] = 0,
		['YOff'] = 0,
		['PetHide'] = false,
		['Template'] = "DEFAULT",
	}
}	
	
-----Default Values for Datatexts------
-- P['datatexts']['panels']['Top_DataBar'] = {
		-- ['left'] = '',
		-- ['middle'] = '',
		-- ['right'] = '',
-- }
P['datatexts']['panels']['ActionBarPanelOne'] = {
		['left'] = '',
		['middle'] = 'Spec Switch',
		['right'] = '',
}
-- P['datatexts']['panels']['RepDataBar'] = ''

-- P['datatexts']['panels']['LeftChatDataBar'] = ''

P['datatexts']['panels']['RightChatDatatextPanel'] = 'BagSyncLDB'

-- P['datatexts']['panels']['RightChatDatatextPanel2'] = 'Garrison'
P['datatexts']['panels']['RightChatDatatextPanel2'] = 'Call to Arms'

P['datatexts']['panels']['ActionBarPanelTwo'] = {
		['left'] = '',
		['middle'] = '',
		['right'] = '',
}
P['datatexts']['panels']['ActionBarPanelThree'] = {
		['left'] = '',
		['middle'] = '',
		['right'] = '',
}
P['datatexts']['panels']['ActionBarPanelFour'] = {
		['left'] = '',
		['middle'] = '',
		['right'] = '',
} 

E:RegisterModule(DTB:GetName())