local ADDON_NAME, Impulse = ...;

Impulse:AddSet({
	Class = "DEATHKNIGHT",
	Name = "Frost (PvE)",
	Creator = "Dynasty Addons",
	Description = "",
	Binds = {
		["SHIFT-5"] = "MULTIACTIONBAR1BUTTON5",
		["SHIFT-C"] = "ITEMCOMPARISONCYCLING",
		["NUMPAD3"] = "VEHICLENEXTSEAT",
		["SHIFT-P"] = "TOGGLECOLLECTIONS",
		["SHIFT-Z"] = "ACTIONBUTTON7",
		["CTRL-0"] = "BONUSACTIONBUTTON10",
		["SHIFT-F3"] = "TARGETPARTYPET2",
		["SHIFT-MOUSEWHEELUP"] = "PREVIOUSACTIONPAGE",
		["F2"] = "TARGETPARTYMEMBER1",
		["SHIFT-X"] = "ACTIONBUTTON6",
		["SHIFT-TAB"] = "TARGETPREVIOUSENEMY",
		["NUMPAD5"] = "VEHICLEEXIT",
		["CTRL-2"] = "BONUSACTIONBUTTON2",
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
		["-"] = "ACTIONBUTTON11",
		["/"] = "OPENCHATSLASH",
		["NUMPADDIVIDE"] = "TOGGLERUN",
		["1"] = "ACTIONBUTTON1",
		["0"] = "ACTIONBUTTON10",
		["3"] = "ACTIONBUTTON3",
		["2"] = "ACTIONBUTTON2",
		["RIGHT"] = "TURNRIGHT",
		["4"] = "ACTIONBUTTON4",
		["7"] = "ACTIONBUTTON7",
		["6"] = "ACTIONBUTTON6",
		["9"] = "ACTIONBUTTON9",
		["SHIFT-V"] = "ACTIONBUTTON8",
		["="] = "ACTIONBUTTON12",
		["A"] = "TURNLEFT",
		["SHIFT-PAGEDOWN"] = "CHATBOTTOM",
		["C"] = "TOGGLECHARACTER0",
		["B"] = "OPENALLBAGS",
		["E"] = "STRAFERIGHT",
		["D"] = "TURNRIGHT",
		["G"] = "TARGETLASTHOSTILE",
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
		["5"] = "ACTIONBUTTON5",
		["CTRL-MOUSEWHEELDOWN"] = "VEHICLEAIMDECREMENT",
		["TAB"] = "TARGETNEARESTENEMY",
		["ALT-Z"] = "TOGGLEUI",
		["CTRL-F5"] = "SHAPESHIFTBUTTON5",
		["SHIFT-F5"] = "TARGETPARTYPET4",
		["CTRL-F1"] = "SHAPESHIFTBUTTON1",
		["F4"] = "TARGETPARTYMEMBER3",
		["CTRL-5"] = "BONUSACTIONBUTTON5",
		["I"] = "TOGGLEGROUPFINDER",
		["SHIFT-O"] = "TOGGLECHANNELPULLOUT",
		["CTRL-6"] = "BONUSACTIONBUTTON6",
		["CTRL-F4"] = "SHAPESHIFTBUTTON4",
		["DOWN"] = "MOVEBACKWARD",
		["UP"] = "MOVEFORWARD",
		["SHIFT-B"] = "TOGGLEBACKPACK",
		["CTRL-V"] = "ALLNAMEPLATES",
		["BUTTON4"] = "TOGGLEAUTORUN",
		["ENTER"] = "OPENCHAT",
		["CTRL-SHIFT-PAGEDOWN"] = "COMBATLOGBOTTOM",
		["SHIFT-F1"] = "TARGETPET",
		["SHIFT-UP"] = "PREVIOUSACTIONPAGE",
		["F8"] = "TOGGLEBAG1",
		["CTRL-3"] = "BONUSACTIONBUTTON3",
		["SHIFT-R"] = "REPLY2",
		["SHIFT-SPACE"] = "TOGGLEWORLDSTATESCORES",
		["CTRL-8"] = "BONUSACTIONBUTTON8",
		["CTRL-F7"] = "SHAPESHIFTBUTTON7",
		["SHIFT-A"] = "MULTIACTIONBAR2BUTTON1",
		["CTRL-1"] = "BONUSACTIONBUTTON1",
		["PAGEDOWN"] = "CHATPAGEDOWN",
		["SHIFT-F4"] = "TARGETPARTYPET3",
		["CTRL-7"] = "BONUSACTIONBUTTON7",
		["SHIFT-I"] = "TOGGLEPETBOOK",
		["NUMPADMINUS"] = "MINIMAPZOOMOUT",
		["CTRL-PAGEDOWN"] = "COMBATLOGPAGEDOWN",
		["Y"] = "TOGGLEACHIEVEMENT",
		["CTRL-SHIFT-TAB"] = "TARGETPREVIOUSFRIEND",
		["SHIFT-2"] = "MULTIACTIONBAR1BUTTON2",
		["F9"] = "TOGGLEBAG2",
		["BUTTON3"] = "MOVEANDSTEER",
		["SHIFT-Y"] = "TOGGLESTATISTICS",
		["CTRL-="] = "MASTERVOLUMEUP",
		["F3"] = "TARGETPARTYMEMBER2",
		["CTRL-4"] = "BONUSACTIONBUTTON4",
		["J"] = "TOGGLEGUILDTAB",
		["SHIFT-DOWN"] = "NEXTACTIONPAGE",
		["CTRL-M"] = "TOGGLEMUSIC",
		["MOUSEWHEELUP"] = "CAMERAZOOMIN",
		["CTRL-I"] = "TOGGLEDUNGEONSANDRAIDS",
		["SHIFT-M"] = "TOGGLEBATTLEFIELDMINIMAP",
		["NUMPADPLUS"] = "MINIMAPZOOMIN",
		["CTRL-S"] = "TOGGLESOUND",
		["PAGEUP"] = "CHATPAGEUP",
		["SHIFT-H"] = "MULTIACTIONBAR3BUTTON1",
	},
	Macros = {
		[1] = {"GraspMO",nil,"#showtooltip Gorefiend's Grasp\n/cast [target=focus] Gorefiend's Grasp"},
		[2] = {"GripMO",nil,"#showtooltip Death Grip\n/cast [@mouseover,harm][@target]Death Grip"},
		[3] = {"MindFreezeMO",nil,"#showtooltip Mind Freeze\n/cast [@mouseover,harm][@target]Mind Freeze"},
		[4] = {"RaiseMO",nil,"#showtooltip Raise Ally\n/cast [@mouseover,help][@target]Raise Ally"},
		[5] = {"Trinket",nil,"#showtooltip\n/use 13"},
	},
	Bars = {
		[1] = {"spell",49998},
		[2] = {"spell",49020},
		[3] = {"spell",207230},
		[4] = {"spell",49184},
		[6] = {"spell",196770},
		[7] = {"spell",45524},
		[8] = {"macro",124},
		[9] = {"macro",0},
		[25] = {"summonmount",268435455},
		[26] = {"spell",111673},
		[27] = {"spell",56222},
		[28] = {"spell",50977},
		[29] = {"spell",3714},
		[30] = {"spell",53428},
		[49] = {"spell",47568},
		[50] = {"macro",125},
		[51] = {"spell",51271},
		[53] = {"spell",48707},
		[54] = {"spell",212552},
		[55] = {"spell",48792},
		[58] = {"macro",123},
		[61] = {"macro",122},
		[62] = {"spell",49143},
		[63] = {"spell",207256},
		[64] = {"spell",57330},
	},
});
Impulse:AddSet({
	Class = "DEATHKNIGHT",
	Name = "Blood (PvE)",
	Creator = "Dynasty Addons",
	Description = "",
	Binds = {
		["SHIFT-5"] = "MULTIACTIONBAR1BUTTON5",
		["SHIFT-C"] = "ITEMCOMPARISONCYCLING",
		["NUMPAD3"] = "VEHICLENEXTSEAT",
		["SHIFT-P"] = "TOGGLECOLLECTIONS",
		["SHIFT-Z"] = "ACTIONBUTTON7",
		["CTRL-0"] = "BONUSACTIONBUTTON10",
		["SHIFT-F3"] = "TARGETPARTYPET2",
		["SHIFT-MOUSEWHEELUP"] = "PREVIOUSACTIONPAGE",
		["F2"] = "TARGETPARTYMEMBER1",
		["SHIFT-X"] = "ACTIONBUTTON6",
		["SHIFT-TAB"] = "TARGETPREVIOUSENEMY",
		["NUMPAD5"] = "VEHICLEEXIT",
		["CTRL-2"] = "BONUSACTIONBUTTON2",
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
		["-"] = "ACTIONBUTTON11",
		["/"] = "OPENCHATSLASH",
		["NUMPADDIVIDE"] = "TOGGLERUN",
		["1"] = "ACTIONBUTTON1",
		["0"] = "ACTIONBUTTON10",
		["3"] = "ACTIONBUTTON3",
		["2"] = "ACTIONBUTTON2",
		["RIGHT"] = "TURNRIGHT",
		["4"] = "ACTIONBUTTON4",
		["7"] = "ACTIONBUTTON7",
		["6"] = "ACTIONBUTTON6",
		["9"] = "ACTIONBUTTON9",
		["8"] = "ACTIONBUTTON8",
		["="] = "ACTIONBUTTON12",
		["A"] = "TURNLEFT",
		["SHIFT-PAGEDOWN"] = "CHATBOTTOM",
		["C"] = "TOGGLECHARACTER0",
		["B"] = "OPENALLBAGS",
		["E"] = "STRAFERIGHT",
		["D"] = "TURNRIGHT",
		["G"] = "TARGETLASTHOSTILE",
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
		["5"] = "ACTIONBUTTON5",
		["CTRL-MOUSEWHEELDOWN"] = "VEHICLEAIMDECREMENT",
		["TAB"] = "TARGETNEARESTENEMY",
		["ALT-Z"] = "TOGGLEUI",
		["CTRL-F5"] = "SHAPESHIFTBUTTON5",
		["SHIFT-F5"] = "TARGETPARTYPET4",
		["CTRL-F1"] = "SHAPESHIFTBUTTON1",
		["F4"] = "TARGETPARTYMEMBER3",
		["CTRL-5"] = "BONUSACTIONBUTTON5",
		["I"] = "TOGGLEGROUPFINDER",
		["SHIFT-O"] = "TOGGLECHANNELPULLOUT",
		["CTRL-6"] = "BONUSACTIONBUTTON6",
		["CTRL-F4"] = "SHAPESHIFTBUTTON4",
		["DOWN"] = "MOVEBACKWARD",
		["UP"] = "MOVEFORWARD",
		["SHIFT-B"] = "TOGGLEBACKPACK",
		["CTRL-V"] = "ALLNAMEPLATES",
		["BUTTON4"] = "TOGGLEAUTORUN",
		["ENTER"] = "OPENCHAT",
		["CTRL-SHIFT-PAGEDOWN"] = "COMBATLOGBOTTOM",
		["SHIFT-F1"] = "TARGETPET",
		["SHIFT-UP"] = "PREVIOUSACTIONPAGE",
		["F8"] = "TOGGLEBAG1",
		["CTRL-3"] = "BONUSACTIONBUTTON3",
		["SHIFT-R"] = "REPLY2",
		["SHIFT-SPACE"] = "TOGGLEWORLDSTATESCORES",
		["CTRL-8"] = "BONUSACTIONBUTTON8",
		["CTRL-F7"] = "SHAPESHIFTBUTTON7",
		["SHIFT-A"] = "MULTIACTIONBAR2BUTTON1",
		["CTRL-1"] = "BONUSACTIONBUTTON1",
		["PAGEDOWN"] = "CHATPAGEDOWN",
		["SHIFT-F4"] = "TARGETPARTYPET3",
		["CTRL-7"] = "BONUSACTIONBUTTON7",
		["SHIFT-I"] = "TOGGLEPETBOOK",
		["NUMPADMINUS"] = "MINIMAPZOOMOUT",
		["CTRL-PAGEDOWN"] = "COMBATLOGPAGEDOWN",
		["Y"] = "TOGGLEACHIEVEMENT",
		["CTRL-SHIFT-TAB"] = "TARGETPREVIOUSFRIEND",
		["SHIFT-2"] = "MULTIACTIONBAR1BUTTON2",
		["F9"] = "TOGGLEBAG2",
		["BUTTON3"] = "MOVEANDSTEER",
		["SHIFT-Y"] = "TOGGLESTATISTICS",
		["CTRL-="] = "MASTERVOLUMEUP",
		["F3"] = "TARGETPARTYMEMBER2",
		["CTRL-4"] = "BONUSACTIONBUTTON4",
		["J"] = "TOGGLEGUILDTAB",
		["SHIFT-DOWN"] = "NEXTACTIONPAGE",
		["CTRL-M"] = "TOGGLEMUSIC",
		["MOUSEWHEELUP"] = "CAMERAZOOMIN",
		["CTRL-I"] = "TOGGLEDUNGEONSANDRAIDS",
		["SHIFT-M"] = "TOGGLEBATTLEFIELDMINIMAP",
		["NUMPADPLUS"] = "MINIMAPZOOMIN",
		["CTRL-S"] = "TOGGLESOUND",
		["PAGEUP"] = "CHATPAGEUP",
		["SHIFT-V"] = "ACTIONBUTTON9",
		["SHIFT-H"] = "MULTIACTIONBAR3BUTTON1",
	},
	Macros = {
		[1] = {"AsphyxMO",nil,"#showtooltip Asphyxiate\n/cast [@mouseover,harm][@target]Asphyxiate"},
		[2] = {"FreezeMO",nil,"#showtooltip Mind Freeze\n/cast [@mouseover,harm][@target]Mind Freeze"},
		[3] = {"GraspMO",nil,"#showtooltip Gorefiend's Grasp\n/cast [target=focus] Gorefiend's Grasp"},
		[4] = {"RaiseMO",nil,"#showtooltip Raise Ally\n/cast [@mouseover,help][@target]Raise Ally"},
		[5] = {"Trinket",nil,"#showtooltip\n/use 13"},
	},
	Bars = {
		[1] = {"spell",49998},
		[2] = {"spell",206930},
		[3] = {"spell",195182},
		[4] = {"spell",49028},
		[6] = {"spell",56222},
		[7] = {"spell",108199},
		[9] = {"macro",124},
		[25] = {"summonmount",268435455},
		[26] = {"spell",53428},
		[27] = {"spell",3714},
		[28] = {"spell",50977},
		[29] = {"spell",111673},
		[49] = {"spell",55233},
		[50] = {"macro",125},
		[53] = {"spell",48707},
		[54] = {"spell",212552},
		[57] = {"macro",121},
		[58] = {"macro",122},
		[61] = {"spell",50842},
		[62] = {"spell",43265},
		[63] = {"spell",195292},
		[64] = {"spell",49576},
	},
});
Impulse:AddSet({
	Class = "DEATHKNIGHT",
	Name = "Unholy (PvE)",
	Creator = "Dynasty Addons",
	Description = "",
	Binds = {
		["SHIFT-5"] = "MULTIACTIONBAR1BUTTON5",
		["SHIFT-C"] = "ACTIONBUTTON8",
		["NUMPAD3"] = "VEHICLENEXTSEAT",
		["SHIFT-P"] = "TOGGLECOLLECTIONS",
		["SHIFT-Z"] = "MULTIACTIONBAR2BUTTON12",
		["CTRL-0"] = "BONUSACTIONBUTTON10",
		["SHIFT-F3"] = "TARGETPARTYPET2",
		["SHIFT-MOUSEWHEELUP"] = "PREVIOUSACTIONPAGE",
		["F2"] = "TARGETPARTYMEMBER1",
		["SHIFT-X"] = "ACTIONBUTTON6",
		["SHIFT-TAB"] = "TARGETPREVIOUSENEMY",
		["NUMPAD5"] = "VEHICLEEXIT",
		["CTRL-2"] = "MULTIACTIONBAR4BUTTON2",
		["LEFT"] = "TURNLEFT",
		["CTRL-MOUSEWHEELUP"] = "VEHICLEAIMINCREMENT",
		["SHIFT-S"] = "MULTIACTIONBAR2BUTTON2",
		["NUMPAD0"] = "JUMP",
		["SHIFT-6"] = "ACTIONPAGE6",
		["UP"] = "MOVEFORWARD",
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
		["4"] = "ACTIONBUTTON4",
		["CTRL-F5"] = "SHAPESHIFTBUTTON5",
		["A"] = "TURNLEFT",
		["SHIFT-PAGEDOWN"] = "CHATBOTTOM",
		["C"] = "TOGGLECHARACTER0",
		["B"] = "OPENALLBAGS",
		["E"] = "STRAFERIGHT",
		["D"] = "TURNRIGHT",
		["G"] = "TARGETLASTHOSTILE",
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
		["CTRL-4"] = "MULTIACTIONBAR4BUTTON4",
		["SHIFT-D"] = "MULTIACTIONBAR2BUTTON3",
		["SHIFT-W"] = "MULTIACTIONBAR2BUTTON6",
		["CTRL-6"] = "BONUSACTIONBUTTON6",
		["CTRL-PAGEUP"] = "COMBATLOGPAGEUP",
		["F12"] = "TOGGLEBACKPACK",
		["F11"] = "TOGGLEBAG4",
		["NUMLOCK"] = "TOGGLEAUTORUN",
		["CTRL-9"] = "BONUSACTIONBUTTON9",
		["F10"] = "TOGGLEBAG3",
		["ENTER"] = "OPENCHAT",
		["F1"] = "TARGETSELF",
		["SHIFT-Q"] = "MULTIACTIONBAR2BUTTON5",
		["SPACE"] = "JUMP",
		["CTRL-F8"] = "SHAPESHIFTBUTTON8",
		["HOME"] = "PREVVIEW",
		["DELETE"] = "PITCHDOWN",
		["CTRL--"] = "MASTERVOLUMEDOWN",
		["CTRL-S"] = "TOGGLESOUND",
		["CTRL-MOUSEWHEELDOWN"] = "VEHICLEAIMDECREMENT",
		["ALT-Z"] = "TOGGLEUI",
		["5"] = "ACTIONBUTTON5",
		["SHIFT-F5"] = "TARGETPARTYPET4",
		["CTRL-F1"] = "SHAPESHIFTBUTTON1",
		["F4"] = "TARGETPARTYMEMBER3",
		["CTRL-5"] = "BONUSACTIONBUTTON5",
		["SHIFT-F2"] = "TARGETPARTYPET1",
		["SHIFT-3"] = "MULTIACTIONBAR1BUTTON3",
		["CTRL-I"] = "TOGGLEDUNGEONSANDRAIDS",
		["CTRL-F4"] = "SHAPESHIFTBUTTON4",
		["SHIFT-A"] = "MULTIACTIONBAR2BUTTON1",
		["CTRL-7"] = "BONUSACTIONBUTTON7",
		["SHIFT-O"] = "TOGGLECHANNELPULLOUT",
		["CTRL-V"] = "ALLNAMEPLATES",
		["F9"] = "TOGGLEBAG2",
		["SHIFT-B"] = "TOGGLEBACKPACK",
		["CTRL-SHIFT-PAGEDOWN"] = "COMBATLOGBOTTOM",
		["INSERT"] = "PITCHUP",
		["J"] = "TOGGLEGUILDTAB",
		["F8"] = "TOGGLEBAG1",
		["CTRL-3"] = "MULTIACTIONBAR4BUTTON3",
		["SHIFT-R"] = "REPLY2",
		["SHIFT-F1"] = "TARGETPET",
		["CTRL-8"] = "BONUSACTIONBUTTON8",
		["CTRL-F7"] = "SHAPESHIFTBUTTON7",
		["SHIFT-SPACE"] = "TOGGLEWORLDSTATESCORES",
		["CTRL-1"] = "MULTIACTIONBAR4BUTTON1",
		["SHIFT-I"] = "TOGGLEPETBOOK",
		["SHIFT-F4"] = "TARGETPARTYPET3",
		["CTRL-F2"] = "SHAPESHIFTBUTTON2",
		["Y"] = "TOGGLEACHIEVEMENT",
		["SHIFT-Y"] = "TOGGLESTATISTICS",
		["SHIFT-UP"] = "PREVIOUSACTIONPAGE",
		["NUMPADMINUS"] = "MINIMAPZOOMOUT",
		["CTRL-SHIFT-TAB"] = "TARGETPREVIOUSFRIEND",
		["SHIFT-2"] = "MULTIACTIONBAR1BUTTON2",
		["CTRL-PAGEDOWN"] = "COMBATLOGPAGEDOWN",
		["BUTTON3"] = "MOVEANDSTEER",
		["BUTTON4"] = "TOGGLEAUTORUN",
		["CTRL-="] = "MASTERVOLUMEUP",
		["F3"] = "TARGETPARTYMEMBER2",
		["DOWN"] = "MOVEBACKWARD",
		["I"] = "TOGGLEGROUPFINDER",
		["SHIFT-DOWN"] = "NEXTACTIONPAGE",
		["CTRL-M"] = "TOGGLEMUSIC",
		["SHIFT-1"] = "MULTIACTIONBAR1BUTTON1",
		["SHIFT-M"] = "TOGGLEBATTLEFIELDMINIMAP",
		["MOUSEWHEELUP"] = "CAMERAZOOMIN",
		["NUMPADPLUS"] = "MINIMAPZOOMIN",
		["TAB"] = "TARGETNEARESTENEMY",
		["PAGEUP"] = "CHATPAGEUP",
		["SHIFT-V"] = "MULTIACTIONBAR4BUTTON5",
		["SHIFT-H"] = "MULTIACTIONBAR3BUTTON1",
	},
	Macros = {
		[1] = {"GraspMO",nil,"#showtooltip Gorefiend's Grasp\n/cast [target=focus] Gorefiend's Grasp"},
		[2] = {"GripMO",nil,"#showtooltip Death Grip\n/cast [@mouseover,harm][@target]Death Grip"},
		[3] = {"MindFreezeMO",nil,"#showtooltip Mind Freeze\n/cast [@mouseover,harm][@target]Mind Freeze"},
		[4] = {"PetAtk",nil,"/petattack"},
		[5] = {"PetFollow",nil,"/petfollow"},
		[6] = {"PetMoveTo",nil,"/petmoveto"},
		[7] = {"RaiseMO",nil,"#showtooltip Raise Ally\n/cast [@mouseover,help][@target]Raise Ally"},
		[8] = {"Trinket",nil,"#showtooltip\n/use 13"},
	},
	Bars = {
		[1] = {"spell",85948},
		[2] = {"spell",55090},
		[3] = {"spell",49998},
		[4] = {"spell",43265},
		[6] = {"spell",207349},
		[25] = {"summonmount",268435455},
		[26] = {"spell",111673},
		[27] = {"spell",50977},
		[28] = {"spell",53428},
		[29] = {"spell",3714},
		[30] = {"spell",56222},
		[37] = {"macro",124},
		[38] = {"macro",125},
		[39] = {"macro",126},
		[40] = {"spell",46584},
		[41] = {"macro",127},
		[49] = {"spell",63560},
		[50] = {"macro",128},
		[51] = {"spell",42650},
		[53] = {"spell",48707},
		[54] = {"spell",212552},
		[55] = {"spell",48792},
		[58] = {"macro",123},
		[60] = {"spell",45524},
		[61] = {"spell",77575},
		[62] = {"spell",47541},
		[63] = {"spell",207317},
		[64] = {"macro",122},
	},
});