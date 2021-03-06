local ADDON_NAME, Impulse = ...;

Impulse:AddSet({
	Class = "MONK",
	Name = "Windwalker (PvE)",
	Creator = "Dynasty Addons",
	Description = "",
	Binds = {
		["SHIFT-5"] = "MULTIACTIONBAR1BUTTON5",
		["SHIFT-C"] = "ACTIONBUTTON12",
		["NUMPAD3"] = "VEHICLENEXTSEAT",
		["SHIFT-P"] = "TOGGLECOLLECTIONS",
		["SHIFT-Z"] = "ACTIONBUTTON10",
		["CTRL-0"] = "BONUSACTIONBUTTON10",
		["SHIFT-F3"] = "TARGETPARTYPET2",
		["SHIFT-MOUSEWHEELUP"] = "PREVIOUSACTIONPAGE",
		["F2"] = "TARGETPARTYMEMBER1",
		["SHIFT-X"] = "ACTIONBUTTON11",
		["SHIFT-TAB"] = "TARGETPREVIOUSENEMY",
		["NUMPAD5"] = "VEHICLEEXIT",
		["BUTTON4"] = "TOGGLEAUTORUN",
		["LEFT"] = "TURNLEFT",
		["CTRL-MOUSEWHEELUP"] = "VEHICLEAIMINCREMENT",
		["SHIFT-S"] = "MULTIACTIONBAR2BUTTON2",
		["NUMPAD0"] = "JUMP",
		["SHIFT-6"] = "ACTIONPAGE6",
		["SHIFT-3"] = "MULTIACTIONBAR1BUTTON3",
		["END"] = "NEXTVIEW",
		["F5"] = "TARGETPARTYMEMBER4",
		["CTRL-F9"] = "SHAPESHIFTBUTTON9",
		["SHIFT-T"] = "PETATTACK",
		["MOUSEWHEELDOWN"] = "CAMERAZOOMOUT",
		["PRINTSCREEN"] = "SCREENSHOT",
		["SHIFT-J"] = "TOGGLEENCOUNTERJOURNAL",
		["CTRL-R"] = "TOGGLEFPS",
		["CTRL-F10"] = "SHAPESHIFTBUTTON10",
		["SHIFT-4"] = "MULTIACTIONBAR1BUTTON4",
		["PAGEDOWN"] = "CHATPAGEDOWN",
		["/"] = "OPENCHATSLASH",
		["NUMPADDIVIDE"] = "TOGGLERUN",
		["1"] = "ACTIONBUTTON1",
		["3"] = "ACTIONBUTTON3",
		["2"] = "ACTIONBUTTON2",
		["RIGHT"] = "TURNRIGHT",
		["SHIFT-A"] = "MULTIACTIONBAR2BUTTON1",
		["9"] = "ACTIONBUTTON9",
		["CTRL-F5"] = "SHAPESHIFTBUTTON5",
		["A"] = "TURNLEFT",
		["SHIFT-PAGEDOWN"] = "CHATBOTTOM",
		["C"] = "TOGGLECHARACTER0",
		["B"] = "OPENALLBAGS",
		["E"] = "STRAFERIGHT",
		["D"] = "TURNRIGHT",
		["G"] = "MULTIACTIONBAR2BUTTON11",
		["F"] = "MULTIACTIONBAR2BUTTON9",
		["CTRL-F6"] = "SHAPESHIFTBUTTON6",
		["H"] = "TOGGLECHARACTER4",
		["K"] = "TOGGLEPROFESSIONBOOK",
		["SHIFT-MOUSEWHEELDOWN"] = "NEXTACTIONPAGE",
		["M"] = "TOGGLEWORLDMAP",
		["L"] = "TOGGLEQUESTLOG",
		["O"] = "TOGGLESOCIAL",
		["N"] = "TOGGLETALENTS",
		["Q"] = "STRAFELEFT",
		["P"] = "TOGGLESPELLBOOK",
		["S"] = "MOVEBACKWARD",
		["R"] = "MULTIACTIONBAR2BUTTON10",
		["U"] = "TOGGLECHARACTER2",
		["T"] = "MULTIACTIONBAR1BUTTON6",
		["W"] = "MOVEFORWARD",
		["V"] = "NAMEPLATES",
		["ESCAPE"] = "TOGGLEGAMEMENU",
		["X"] = "SITORSTAND",
		["Z"] = "TOGGLESHEATH",
		["SHIFT-E"] = "MULTIACTIONBAR2BUTTON7",
		["NUMPAD1"] = "VEHICLEPREVSEAT",
		["CTRL-F3"] = "SHAPESHIFTBUTTON3",
		["SHIFT-1"] = "MULTIACTIONBAR1BUTTON1",
		["SHIFT-D"] = "MULTIACTIONBAR2BUTTON3",
		["SHIFT-W"] = "MULTIACTIONBAR2BUTTON6",
		["CTRL-6"] = "BONUSACTIONBUTTON6",
		["CTRL-PAGEUP"] = "COMBATLOGPAGEUP",
		["F12"] = "TOGGLEBACKPACK",
		["F11"] = "TOGGLEBAG4",
		["NUMLOCK"] = "TOGGLEAUTORUN",
		["CTRL-9"] = "BONUSACTIONBUTTON9",
		["F10"] = "TOGGLEBAG3",
		["CTRL-F2"] = "SHAPESHIFTBUTTON2",
		["F1"] = "TARGETSELF",
		["SHIFT-Q"] = "MULTIACTIONBAR2BUTTON5",
		["SPACE"] = "JUMP",
		["CTRL-F8"] = "SHAPESHIFTBUTTON8",
		["HOME"] = "PREVVIEW",
		["DELETE"] = "PITCHDOWN",
		["CTRL-S"] = "TOGGLESOUND",
		["CTRL--"] = "MASTERVOLUMEDOWN",
		["4"] = "ACTIONBUTTON4",
		["5"] = "ACTIONBUTTON5",
		["ALT-Z"] = "TOGGLEUI",
		["CTRL-MOUSEWHEELDOWN"] = "VEHICLEAIMDECREMENT",
		["SHIFT-F5"] = "TARGETPARTYPET4",
		["CTRL-F1"] = "SHAPESHIFTBUTTON1",
		["TAB"] = "TARGETNEARESTENEMY",
		["MOUSEWHEELUP"] = "CAMERAZOOMIN",
		["CTRL-TAB"] = "TARGETNEARESTFRIEND",
		["CTRL-4"] = "BONUSACTIONBUTTON4",
		["CTRL-I"] = "TOGGLEDUNGEONSANDRAIDS",
		["CTRL-F4"] = "SHAPESHIFTBUTTON4",
		["SHIFT-F2"] = "TARGETPARTYPET1",
		["F9"] = "TOGGLEBAG2",
		["J"] = "TOGGLEGUILDTAB",
		["CTRL-V"] = "ALLNAMEPLATES",
		["SHIFT-B"] = "TOGGLEBACKPACK",
		["INSERT"] = "PITCHUP",
		["CTRL-SHIFT-PAGEDOWN"] = "COMBATLOGBOTTOM",
		["UP"] = "MOVEFORWARD",
		["SHIFT-SPACE"] = "TOGGLEWORLDSTATESCORES",
		["F8"] = "TOGGLEBAG1",
		["CTRL-3"] = "ACTIONBUTTON8",
		["SHIFT-R"] = "REPLY2",
		["SHIFT-F1"] = "TARGETPET",
		["CTRL-PAGEDOWN"] = "COMBATLOGPAGEDOWN",
		["CTRL-F7"] = "SHAPESHIFTBUTTON7",
		["ENTER"] = "OPENCHAT",
		["CTRL-1"] = "ACTIONBUTTON6",
		["SHIFT-I"] = "TOGGLEPETBOOK",
		["NUMPADMINUS"] = "MINIMAPZOOMOUT",
		["Y"] = "TOGGLEACHIEVEMENT",
		["SHIFT-Y"] = "TOGGLESTATISTICS",
		["CTRL-8"] = "BONUSACTIONBUTTON8",
		["SHIFT-F4"] = "TARGETPARTYPET3",
		["SHIFT-M"] = "TOGGLEBATTLEFIELDMINIMAP",
		["CTRL-SHIFT-TAB"] = "TARGETPREVIOUSFRIEND",
		["SHIFT-2"] = "MULTIACTIONBAR1BUTTON2",
		["SHIFT-UP"] = "PREVIOUSACTIONPAGE",
		["BUTTON3"] = "MOVEANDSTEER",
		["CTRL-2"] = "ACTIONBUTTON7",
		["CTRL-="] = "MASTERVOLUMEUP",
		["F3"] = "TARGETPARTYMEMBER2",
		["DOWN"] = "MOVEBACKWARD",
		["SHIFT-O"] = "TOGGLECHANNELPULLOUT",
		["SHIFT-DOWN"] = "NEXTACTIONPAGE",
		["CTRL-M"] = "TOGGLEMUSIC",
		["CTRL-7"] = "BONUSACTIONBUTTON7",
		["CTRL-5"] = "BONUSACTIONBUTTON5",
		["I"] = "TOGGLEGROUPFINDER",
		["NUMPADPLUS"] = "MINIMAPZOOMIN",
		["F4"] = "TARGETPARTYMEMBER3",
		["PAGEUP"] = "CHATPAGEUP",
		["SHIFT-V"] = "ACTIONBUTTON9",
		["SHIFT-H"] = "MULTIACTIONBAR3BUTTON1",
	},
	Macros = {
		[1] = {"DetoxMouseover",nil,"#showtooltip Detox\n/cast [@mouseover,help,nodead] Detox;Detox\n"},
		[2] = {"RingofPeaceMO",nil,"#showtooltip Ring of Peace\n/cast [@mouseover,help,nodead] Ring of Peace;Ring of Peace"},
		[3] = {"TigerLustMO",nil,"#showtooltip Tiger's Lust\n/cast [@mouseover,help,nodead] Tiger's Lust;Tiger's Lust"},
		[4] = {"Trinket",nil,"#showtooltip\n/use 13"},
	},
	Bars = {
		[1] = {"spell",100780},
		[2] = {"spell",113656},
		[3] = {"spell",107428},
		[4] = {"spell",152175},
		[6] = {"spell",101546},
		[7] = {"spell",116847},
		[8] = {"spell",117952},
		[10] = {"spell",109132},
		[11] = {"spell",101545},
		[12] = {"macro",123},
		[25] = {"summonmount",268435455},
		[26] = {"spell",115178},
		[27] = {"spell",115546},
		[28] = {"spell",119996},
		[29] = {"spell",101643},
		[30] = {"spell",126892},
		[49] = {"spell",115288},
		[50] = {"macro",124},
		[51] = {"spell",137639},
		[53] = {"spell",116694},
		[54] = {"spell",122470},
		[55] = {"spell",122278},
		[57] = {"spell",116705},
		[58] = {"spell",115078},
		[59] = {"spell",119381},
		[61] = {"spell",115098},
		[62] = {"spell",100784},
		[63] = {"spell",115080},
		[64] = {"spell",116095},
		[66] = {"macro",121},
		[73] = {"spell",115288},
	},
});
Impulse:AddSet({
	Class = "MONK",
	Name = "Mistweaver (PvE)",
	Creator = "Dynasty Addons",
	Description = "",
	Binds = {
		["SHIFT-5"] = "MULTIACTIONBAR1BUTTON5",
		["SHIFT-C"] = "ITEMCOMPARISONCYCLING",
		["NUMPAD3"] = "VEHICLENEXTSEAT",
		["SHIFT-P"] = "TOGGLECOLLECTIONS",
		["SHIFT-Z"] = "MULTIACTIONBAR1BUTTON6",
		["CTRL-0"] = "BONUSACTIONBUTTON10",
		["SHIFT-F3"] = "TARGETPARTYPET2",
		["SHIFT-MOUSEWHEELUP"] = "PREVIOUSACTIONPAGE",
		["F2"] = "TARGETPARTYMEMBER1",
		["SHIFT-X"] = "ACTIONBUTTON6",
		["SHIFT-TAB"] = "TARGETPREVIOUSENEMY",
		["NUMPAD5"] = "VEHICLEEXIT",
		["BUTTON4"] = "TOGGLEAUTORUN",
		["LEFT"] = "TURNLEFT",
		["CTRL-MOUSEWHEELUP"] = "VEHICLEAIMINCREMENT",
		["SHIFT-S"] = "MULTIACTIONBAR2BUTTON2",
		["NUMPAD0"] = "JUMP",
		["SHIFT-6"] = "ACTIONPAGE6",
		["SHIFT-3"] = "MULTIACTIONBAR1BUTTON3",
		["END"] = "NEXTVIEW",
		["F5"] = "TARGETPARTYMEMBER4",
		["CTRL-F9"] = "SHAPESHIFTBUTTON9",
		["SHIFT-T"] = "PETATTACK",
		["MOUSEWHEELDOWN"] = "CAMERAZOOMOUT",
		["PRINTSCREEN"] = "SCREENSHOT",
		["SHIFT-J"] = "TOGGLEENCOUNTERJOURNAL",
		["CTRL-R"] = "TOGGLEFPS",
		["CTRL-F10"] = "SHAPESHIFTBUTTON10",
		["SHIFT-4"] = "MULTIACTIONBAR1BUTTON4",
		["PAGEDOWN"] = "CHATPAGEDOWN",
		["/"] = "OPENCHATSLASH",
		["NUMPADDIVIDE"] = "TOGGLERUN",
		["1"] = "ACTIONBUTTON1",
		["3"] = "ACTIONBUTTON3",
		["2"] = "ACTIONBUTTON2",
		["RIGHT"] = "TURNRIGHT",
		["SHIFT-A"] = "MULTIACTIONBAR2BUTTON1",
		["7"] = "ACTIONBUTTON7",
		["8"] = "ACTIONBUTTON8",
		["A"] = "TURNLEFT",
		["SHIFT-PAGEDOWN"] = "CHATBOTTOM",
		["C"] = "TOGGLECHARACTER0",
		["B"] = "OPENALLBAGS",
		["E"] = "STRAFERIGHT",
		["D"] = "TURNRIGHT",
		["G"] = "MULTIACTIONBAR2BUTTON11",
		["F"] = "MULTIACTIONBAR2BUTTON9",
		["CTRL-F6"] = "SHAPESHIFTBUTTON6",
		["H"] = "TOGGLECHARACTER4",
		["K"] = "TOGGLEPROFESSIONBOOK",
		["SHIFT-MOUSEWHEELDOWN"] = "NEXTACTIONPAGE",
		["M"] = "TOGGLEWORLDMAP",
		["L"] = "TOGGLEQUESTLOG",
		["O"] = "TOGGLESOCIAL",
		["N"] = "TOGGLETALENTS",
		["Q"] = "STRAFELEFT",
		["P"] = "TOGGLESPELLBOOK",
		["S"] = "MOVEBACKWARD",
		["R"] = "MULTIACTIONBAR2BUTTON10",
		["U"] = "TOGGLECHARACTER2",
		["CTRL-TAB"] = "TARGETNEARESTFRIEND",
		["W"] = "MOVEFORWARD",
		["V"] = "NAMEPLATES",
		["ESCAPE"] = "TOGGLEGAMEMENU",
		["X"] = "SITORSTAND",
		["Z"] = "TOGGLESHEATH",
		["SHIFT-E"] = "MULTIACTIONBAR2BUTTON7",
		["NUMPAD1"] = "VEHICLEPREVSEAT",
		["CTRL-F3"] = "SHAPESHIFTBUTTON3",
		["SHIFT-1"] = "MULTIACTIONBAR1BUTTON1",
		["SHIFT-D"] = "MULTIACTIONBAR2BUTTON3",
		["SHIFT-W"] = "MULTIACTIONBAR2BUTTON6",
		["CTRL-6"] = "BONUSACTIONBUTTON6",
		["CTRL-PAGEUP"] = "COMBATLOGPAGEUP",
		["F12"] = "TOGGLEBACKPACK",
		["F11"] = "TOGGLEBAG4",
		["NUMLOCK"] = "TOGGLEAUTORUN",
		["CTRL-9"] = "BONUSACTIONBUTTON9",
		["F10"] = "TOGGLEBAG3",
		["CTRL-F2"] = "SHAPESHIFTBUTTON2",
		["F1"] = "TARGETSELF",
		["SHIFT-Q"] = "MULTIACTIONBAR2BUTTON5",
		["SPACE"] = "JUMP",
		["CTRL-F8"] = "SHAPESHIFTBUTTON8",
		["HOME"] = "PREVVIEW",
		["DELETE"] = "PITCHDOWN",
		["CTRL-S"] = "TOGGLESOUND",
		["CTRL--"] = "MASTERVOLUMEDOWN",
		["4"] = "ACTIONBUTTON4",
		["CTRL-MOUSEWHEELDOWN"] = "VEHICLEAIMDECREMENT",
		["ALT-Z"] = "TOGGLEUI",
		["TAB"] = "TARGETNEARESTENEMY",
		["SHIFT-F5"] = "TARGETPARTYPET4",
		["CTRL-F1"] = "SHAPESHIFTBUTTON1",
		["F4"] = "TARGETPARTYMEMBER3",
		["CTRL-5"] = "BONUSACTIONBUTTON5",
		["CTRL-7"] = "BONUSACTIONBUTTON7",
		["CTRL-4"] = "ACTIONBUTTON12",
		["F9"] = "TOGGLEBAG2",
		["CTRL-F4"] = "SHAPESHIFTBUTTON4",
		["INSERT"] = "PITCHUP",
		["DOWN"] = "MOVEBACKWARD",
		["UP"] = "MOVEFORWARD",
		["CTRL-V"] = "ALLNAMEPLATES",
		["SHIFT-B"] = "TOGGLEBACKPACK",
		["CTRL-2"] = "ACTIONBUTTON10",
		["ENTER"] = "OPENCHAT",
		["SHIFT-F1"] = "TARGETPET",
		["CTRL-PAGEDOWN"] = "COMBATLOGPAGEDOWN",
		["F8"] = "TOGGLEBAG1",
		["CTRL-3"] = "ACTIONBUTTON11",
		["SHIFT-R"] = "REPLY2",
		["SHIFT-SPACE"] = "TOGGLEWORLDSTATESCORES",
		["CTRL-8"] = "BONUSACTIONBUTTON8",
		["CTRL-F7"] = "SHAPESHIFTBUTTON7",
		["SHIFT-UP"] = "PREVIOUSACTIONPAGE",
		["CTRL-1"] = "ACTIONBUTTON9",
		["SHIFT-I"] = "TOGGLEPETBOOK",
		["SHIFT-F4"] = "TARGETPARTYPET3",
		["Y"] = "TOGGLEACHIEVEMENT",
		["SHIFT-Y"] = "TOGGLESTATISTICS",
		["CTRL-F5"] = "SHAPESHIFTBUTTON5",
		["NUMPADMINUS"] = "MINIMAPZOOMOUT",
		["SHIFT-M"] = "TOGGLEBATTLEFIELDMINIMAP",
		["CTRL-SHIFT-TAB"] = "TARGETPREVIOUSFRIEND",
		["SHIFT-2"] = "MULTIACTIONBAR1BUTTON2",
		["CTRL-SHIFT-PAGEDOWN"] = "COMBATLOGBOTTOM",
		["BUTTON3"] = "MOVEANDSTEER",
		["J"] = "TOGGLEGUILDTAB",
		["CTRL-="] = "MASTERVOLUMEUP",
		["F3"] = "TARGETPARTYMEMBER2",
		["SHIFT-O"] = "TOGGLECHANNELPULLOUT",
		["CTRL-I"] = "TOGGLEDUNGEONSANDRAIDS",
		["SHIFT-DOWN"] = "NEXTACTIONPAGE",
		["CTRL-M"] = "TOGGLEMUSIC",
		["I"] = "TOGGLEGROUPFINDER",
		["MOUSEWHEELUP"] = "CAMERAZOOMIN",
		["SHIFT-F2"] = "TARGETPARTYPET1",
		["NUMPADPLUS"] = "MINIMAPZOOMIN",
		["5"] = "ACTIONBUTTON5",
		["PAGEUP"] = "CHATPAGEUP",
		["SHIFT-V"] = "FRIENDNAMEPLATES",
		["SHIFT-H"] = "MULTIACTIONBAR3BUTTON1",
	},
	Macros = {
		[1] = {"DetoxMouseover",nil,"#showtooltip Detox\n/cast [@mouseover,help,nodead] Detox;Detox\n"},
		[2] = {"RingofPeaceMO",nil,"#showtooltip Ring of Peace\n/cast [@mouseover,help,nodead] Ring of Peace;Ring of Peace\n"},
		[3] = {"TigerLustMO",nil,"#showtooltip Tiger's Lust\n/cast [@mouseover,help,nodead] Tiger's Lust;Tiger's Lust\n"},
		[4] = {"Trinket",nil,"#showtooltip\n/use 13\n"},
	},
	Bars = {
		[1] = {"spell",115151},
		[2] = {"spell",124682},
		[3] = {"spell",116694},
		[4] = {"spell",116670},
		[6] = {"macro",121},
		[9] = {"spell",100780},
		[10] = {"spell",100784},
		[11] = {"spell",107428},
		[12] = {"spell",101546},
		[25] = {"summonmount",268435455},
		[26] = {"spell",212051},
		[27] = {"spell",115178},
		[29] = {"spell",119996},
		[30] = {"spell",101643},
		[35] = {"spell",115546},
		[36] = {"spell",126892},
		[49] = {"spell",116680},
		[50] = {"macro",124},
		[51] = {"spell",198664},
		[53] = {"spell",116849},
		[54] = {"spell",122278},
		[55] = {"spell",197908},
		[57] = {"spell",115078},
		[58] = {"spell",119381},
		[59] = {"spell",117952},
		[61] = {"spell",191837},
		[62] = {"spell",123986},
		[63] = {"spell",115310},
		[64] = {"spell",115008},
	},
});
Impulse:AddSet({
	Class = "MONK",
	Name = "Brewmaster (PvE)",
	Creator = "Dynasty Addons",
	Description = "",
	Binds = {
		["SHIFT-5"] = "MULTIACTIONBAR1BUTTON5",
		["SHIFT-C"] = "ITEMCOMPARISONCYCLING",
		["NUMPAD3"] = "VEHICLENEXTSEAT",
		["SHIFT-P"] = "TOGGLECOLLECTIONS",
		["CTRL-0"] = "BONUSACTIONBUTTON10",
		["SHIFT-F3"] = "TARGETPARTYPET2",
		["SHIFT-MOUSEWHEELUP"] = "PREVIOUSACTIONPAGE",
		["F2"] = "TARGETPARTYMEMBER1",
		["SHIFT-X"] = "ACTIONBUTTON6",
		["SHIFT-TAB"] = "TARGETPREVIOUSENEMY",
		["NUMPAD5"] = "VEHICLEEXIT",
		["BUTTON4"] = "TOGGLEAUTORUN",
		["LEFT"] = "TURNLEFT",
		["CTRL-MOUSEWHEELUP"] = "VEHICLEAIMINCREMENT",
		["SHIFT-S"] = "MULTIACTIONBAR2BUTTON2",
		["NUMPAD0"] = "JUMP",
		["SHIFT-6"] = "ACTIONPAGE6",
		["SHIFT-3"] = "MULTIACTIONBAR1BUTTON3",
		["END"] = "NEXTVIEW",
		["F5"] = "TARGETPARTYMEMBER4",
		["CTRL-F9"] = "SHAPESHIFTBUTTON9",
		["SHIFT-T"] = "PETATTACK",
		["MOUSEWHEELDOWN"] = "CAMERAZOOMOUT",
		["PRINTSCREEN"] = "SCREENSHOT",
		["SHIFT-J"] = "TOGGLEENCOUNTERJOURNAL",
		["CTRL-R"] = "TOGGLEFPS",
		["CTRL-F10"] = "SHAPESHIFTBUTTON10",
		["SHIFT-4"] = "MULTIACTIONBAR1BUTTON4",
		["PAGEDOWN"] = "CHATPAGEDOWN",
		["/"] = "OPENCHATSLASH",
		["NUMPADDIVIDE"] = "TOGGLERUN",
		["1"] = "ACTIONBUTTON1",
		["3"] = "ACTIONBUTTON3",
		["2"] = "ACTIONBUTTON2",
		["RIGHT"] = "TURNRIGHT",
		["SHIFT-A"] = "MULTIACTIONBAR2BUTTON1",
		["7"] = "ACTIONBUTTON7",
		["9"] = "ACTIONBUTTON9",
		["8"] = "ACTIONBUTTON8",
		["A"] = "TURNLEFT",
		["SHIFT-PAGEDOWN"] = "CHATBOTTOM",
		["C"] = "TOGGLECHARACTER0",
		["B"] = "OPENALLBAGS",
		["E"] = "STRAFERIGHT",
		["D"] = "TURNRIGHT",
		["G"] = "MULTIACTIONBAR2BUTTON11",
		["F"] = "MULTIACTIONBAR2BUTTON9",
		["CTRL-F6"] = "SHAPESHIFTBUTTON6",
		["H"] = "TOGGLECHARACTER4",
		["K"] = "TOGGLEPROFESSIONBOOK",
		["SHIFT-MOUSEWHEELDOWN"] = "NEXTACTIONPAGE",
		["M"] = "TOGGLEWORLDMAP",
		["L"] = "TOGGLEQUESTLOG",
		["O"] = "TOGGLESOCIAL",
		["N"] = "TOGGLETALENTS",
		["Q"] = "STRAFELEFT",
		["P"] = "TOGGLESPELLBOOK",
		["S"] = "MOVEBACKWARD",
		["R"] = "MULTIACTIONBAR2BUTTON10",
		["U"] = "TOGGLECHARACTER2",
		["T"] = "MULTIACTIONBAR1BUTTON6",
		["W"] = "MOVEFORWARD",
		["V"] = "NAMEPLATES",
		["ESCAPE"] = "TOGGLEGAMEMENU",
		["X"] = "SITORSTAND",
		["Z"] = "TOGGLESHEATH",
		["SHIFT-E"] = "MULTIACTIONBAR2BUTTON7",
		["NUMPAD1"] = "VEHICLEPREVSEAT",
		["CTRL-F3"] = "SHAPESHIFTBUTTON3",
		["SHIFT-1"] = "MULTIACTIONBAR1BUTTON1",
		["SHIFT-D"] = "MULTIACTIONBAR2BUTTON3",
		["SHIFT-W"] = "MULTIACTIONBAR2BUTTON6",
		["INSERT"] = "PITCHUP",
		["CTRL-PAGEUP"] = "COMBATLOGPAGEUP",
		["F12"] = "TOGGLEBACKPACK",
		["F11"] = "TOGGLEBAG4",
		["NUMLOCK"] = "TOGGLEAUTORUN",
		["CTRL-9"] = "BONUSACTIONBUTTON9",
		["F10"] = "TOGGLEBAG3",
		["CTRL-F2"] = "SHAPESHIFTBUTTON2",
		["F1"] = "TARGETSELF",
		["SHIFT-Q"] = "MULTIACTIONBAR2BUTTON5",
		["SPACE"] = "JUMP",
		["CTRL-F8"] = "SHAPESHIFTBUTTON8",
		["DELETE"] = "PITCHDOWN",
		["HOME"] = "PREVVIEW",
		["SHIFT-F2"] = "TARGETPARTYPET1",
		["CTRL--"] = "MASTERVOLUMEDOWN",
		["4"] = "ACTIONBUTTON4",
		["CTRL-MOUSEWHEELDOWN"] = "VEHICLEAIMDECREMENT",
		["TAB"] = "TARGETNEARESTENEMY",
		["ALT-Z"] = "TOGGLEUI",
		["CTRL-TAB"] = "TARGETNEARESTFRIEND",
		["SHIFT-F5"] = "TARGETPARTYPET4",
		["CTRL-F1"] = "SHAPESHIFTBUTTON1",
		["CTRL-8"] = "BONUSACTIONBUTTON8",
		["MOUSEWHEELUP"] = "CAMERAZOOMIN",
		["CTRL-6"] = "BONUSACTIONBUTTON6",
		["CTRL-I"] = "TOGGLEDUNGEONSANDRAIDS",
		["CTRL-F5"] = "SHAPESHIFTBUTTON5",
		["CTRL-F4"] = "SHAPESHIFTBUTTON4",
		["5"] = "ACTIONBUTTON5",
		["J"] = "TOGGLEGUILDTAB",
		["SHIFT-B"] = "TOGGLEBACKPACK",
		["CTRL-V"] = "ALLNAMEPLATES",
		["CTRL-7"] = "BONUSACTIONBUTTON7",
		["SHIFT-M"] = "TOGGLEBATTLEFIELDMINIMAP",
		["F9"] = "TOGGLEBAG2",
		["SHIFT-F1"] = "TARGETPET",
		["CTRL-SHIFT-PAGEDOWN"] = "COMBATLOGBOTTOM",
		["F8"] = "TOGGLEBAG1",
		["CTRL-3"] = "ACTIONBUTTON12",
		["SHIFT-R"] = "REPLY2",
		["SHIFT-SPACE"] = "TOGGLEWORLDSTATESCORES",
		["UP"] = "MOVEFORWARD",
		["CTRL-F7"] = "SHAPESHIFTBUTTON7",
		["ENTER"] = "OPENCHAT",
		["CTRL-1"] = "ACTIONBUTTON10",
		["SHIFT-UP"] = "PREVIOUSACTIONPAGE",
		["NUMPADMINUS"] = "MINIMAPZOOMOUT",
		["SHIFT-I"] = "TOGGLEPETBOOK",
		["Y"] = "TOGGLEACHIEVEMENT",
		["SHIFT-F4"] = "TARGETPARTYPET3",
		["SHIFT-Y"] = "TOGGLESTATISTICS",
		["CTRL-PAGEDOWN"] = "COMBATLOGPAGEDOWN",
		["CTRL-SHIFT-TAB"] = "TARGETPREVIOUSFRIEND",
		["SHIFT-2"] = "MULTIACTIONBAR1BUTTON2",
		["CTRL-2"] = "ACTIONBUTTON11",
		["BUTTON3"] = "MOVEANDSTEER",
		["DOWN"] = "MOVEBACKWARD",
		["CTRL-="] = "MASTERVOLUMEUP",
		["F3"] = "TARGETPARTYMEMBER2",
		["I"] = "TOGGLEGROUPFINDER",
		["CTRL-4"] = "BONUSACTIONBUTTON4",
		["SHIFT-DOWN"] = "NEXTACTIONPAGE",
		["CTRL-M"] = "TOGGLEMUSIC",
		["SHIFT-O"] = "TOGGLECHANNELPULLOUT",
		["F4"] = "TARGETPARTYMEMBER3",
		["CTRL-5"] = "BONUSACTIONBUTTON5",
		["NUMPADPLUS"] = "MINIMAPZOOMIN",
		["CTRL-S"] = "TOGGLESOUND",
		["PAGEUP"] = "CHATPAGEUP",
		["SHIFT-V"] = "FRIENDNAMEPLATES",
		["SHIFT-H"] = "MULTIACTIONBAR3BUTTON1",
	},
	Macros = {
		[1] = {"DetoxMouseover",nil,"#showtooltip Detox\n/cast [@mouseover,help,nodead] Detox;Detox\n"},
		[2] = {"RingofPeaceMO",nil,"#showtooltip Ring of Peace\n/cast [@mouseover,help,nodead] Ring of Peace;Ring of Peace\n"},
		[3] = {"TigerLustMO",nil,"#showtooltip Tiger's Lust\n/cast [@mouseover,help,nodead] Tiger's Lust;Tiger's Lust\n"},
		[4] = {"Trinket",nil,"#showtooltip\n/use 13\n"},
	},
	Bars = {
		[1] = {"spell",121253},
		[2] = {"spell",100780},
		[3] = {"spell",100784},
		[4] = {"spell",119582},
		[6] = {"spell",123986},
		[10] = {"spell",116694},
		[25] = {"summonmount",268435455},
		[26] = {"spell",115178},
		[27] = {"spell",115546},
		[33] = {"spell",101643},
		[34] = {"spell",119996},
		[36] = {"spell",126892},
		[49] = {"spell",115399},
		[50] = {"macro",124},
		[53] = {"spell",115203},
		[54] = {"spell",115176},
		[55] = {"spell",115308},
		[57] = {"spell",116705},
		[58] = {"spell",115078},
		[59] = {"spell",119381},
		[61] = {"spell",122281},
		[62] = {"spell",115072},
		[63] = {"spell",115008},
		[64] = {"spell",115181},
		[66] = {"spell",218164},
	},
});
