﻿local ADDON_NAME, Impulse = ...;
Impulse:AddSet({
	Class = "MAGE",
	Name = "Fire (PvE)",
	Creator = "Dynasty Addons",
	Description = "",
	Binds = {
		["SHIFT-5"] = "ACTIONPAGE5",
		["SHIFT-C"] = "ITEMCOMPARISONCYCLING",
		["NUMPAD3"] = "VEHICLENEXTSEAT",
		["SHIFT-P"] = "TOGGLECOLLECTIONS",
		["SHIFT-Z"] = "ACTIONBUTTON7",
		["CTRL-0"] = "BONUSACTIONBUTTON10",
		["SHIFT-I"] = "TOGGLEPETBOOK",
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
		["9"] = "ACTIONBUTTON9",
		["8"] = "ACTIONBUTTON8",
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
		["HOME"] = "PREVVIEW",
		["DELETE"] = "PITCHDOWN",
		["CTRL-S"] = "TOGGLESOUND",
		["CTRL--"] = "MASTERVOLUMEDOWN",
		["4"] = "ACTIONBUTTON4",
		["TAB"] = "TARGETNEARESTENEMY",
		["ALT-Z"] = "TOGGLEUI",
		["F4"] = "TARGETPARTYMEMBER3",
		["SHIFT-F5"] = "TARGETPARTYPET4",
		["CTRL-F1"] = "SHAPESHIFTBUTTON1",
		["SHIFT-F2"] = "TARGETPARTYPET1",
		["MOUSEWHEELUP"] = "CAMERAZOOMIN",
		["CTRL-7"] = "BONUSACTIONBUTTON7",
		["CTRL-4"] = "BONUSACTIONBUTTON4",
		["5"] = "ACTIONBUTTON5",
		["CTRL-F4"] = "SHAPESHIFTBUTTON4",
		["F9"] = "TOGGLEBAG2",
		["DOWN"] = "MOVEBACKWARD",
		["CTRL-6"] = "BONUSACTIONBUTTON6",
		["CTRL-V"] = "ALLNAMEPLATES",
		["SHIFT-B"] = "TOGGLEBACKPACK",
		["CTRL-2"] = "ACTIONBUTTON11",
		["UP"] = "MOVEFORWARD",
		["CTRL-PAGEDOWN"] = "COMBATLOGPAGEDOWN",
		["SHIFT-F1"] = "TARGETPET",
		["F8"] = "TOGGLEBAG1",
		["CTRL-3"] = "ACTIONBUTTON12",
		["SHIFT-R"] = "REPLY2",
		["SHIFT-SPACE"] = "TOGGLEWORLDSTATESCORES",
		["CTRL-8"] = "BONUSACTIONBUTTON8",
		["CTRL-F7"] = "SHAPESHIFTBUTTON7",
		["ENTER"] = "OPENCHAT",
		["CTRL-1"] = "ACTIONBUTTON10",
		["SHIFT-UP"] = "PREVIOUSACTIONPAGE",
		["NUMPADMINUS"] = "MINIMAPZOOMOUT",
		["Y"] = "TOGGLEACHIEVEMENT",
		["SHIFT-Y"] = "TOGGLESTATISTICS",
		["CTRL-F5"] = "SHAPESHIFTBUTTON5",
		["SHIFT-F4"] = "TARGETPARTYPET3",
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
		["CTRL-5"] = "BONUSACTIONBUTTON5",
		["SHIFT-F3"] = "TARGETPARTYPET2",
		["NUMPADPLUS"] = "MINIMAPZOOMIN",
		["CTRL-MOUSEWHEELDOWN"] = "VEHICLEAIMDECREMENT",
		["PAGEUP"] = "CHATPAGEUP",
		["SHIFT-V"] = "FRIENDNAMEPLATES",
		["SHIFT-H"] = "MULTIACTIONBAR3BUTTON1",
	},
	Macros = {
		[1] = {"CounterspellMO",nil,"#showtooltip Counterspell\n/cast [@mouseover,harm][@target]Counterspell\n"},
		[2] = {"IceBlock",nil,"#showtooltip\n/stopcasting\n/cancelaura Ice Block\n/cast Ice Block\n"},
		[3] = {"PolyMO",nil,"#showtooltip Polymorph\n/cast [@mouseover,harm][@target]Polymorph\n"},
		[4] = {"Trinket",nil,"#showtooltip\n/use 13\n"},
	},
	Bars = {
		[1] = {"spell",108853},
		[2] = {"spell",194466},
		[3] = {"spell",31661},
		[4] = {"spell",205029},
		[6] = {"spell",190319},
		[7] = {"spell",108839},
		[10] = {"spell",212653},
		[11] = {"spell",122},
		[12] = {"spell",66},
		[25] = {"summonmount",268435455},
		[26] = {"spell",190336},
		[27] = {"spell",193759},
		[37] = {"spell",130},
		[38] = {"spell",30449},
		[49] = {"spell",116011},
		[50] = {"macro",124},
		[51] = {"spell",80353},
		[53] = {"macro",122},
		[54] = {"spell",11426},
		[57] = {"macro",121},
		[58] = {"macro",123},
		[61] = {"spell",133},
		[62] = {"spell",11366},
		[63] = {"spell",2948},
		[64] = {"spell",2120},
	},
});
Impulse:AddSet({
	Class = "MAGE",
	Name = "Arcane (PvE)",
	Creator = "Dynasty Addons",
	Description = "",
	Binds = {
		["SHIFT-5"] = "MULTIACTIONBAR1BUTTON5",
		["SHIFT-C"] = "ACTIONBUTTON8",
		["NUMPAD3"] = "VEHICLENEXTSEAT",
		["SHIFT-P"] = "TOGGLECOLLECTIONS",
		["SHIFT-Z"] = "ACTIONBUTTON7",
		["CTRL-0"] = "BONUSACTIONBUTTON10",
		["SHIFT-I"] = "TOGGLEPETBOOK",
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
		["ALT-Z"] = "TOGGLEUI",
		["4"] = "ACTIONBUTTON4",
		["SHIFT-F5"] = "TARGETPARTYPET4",
		["CTRL-F1"] = "SHAPESHIFTBUTTON1",
		["5"] = "ACTIONBUTTON5",
		["CTRL-5"] = "BONUSACTIONBUTTON5",
		["TAB"] = "TARGETNEARESTENEMY",
		["F4"] = "TARGETPARTYMEMBER3",
		["CTRL-MOUSEWHEELDOWN"] = "VEHICLEAIMDECREMENT",
		["CTRL-F4"] = "SHAPESHIFTBUTTON4",
		["I"] = "TOGGLEGROUPFINDER",
		["F9"] = "TOGGLEBAG2",
		["CTRL-7"] = "BONUSACTIONBUTTON7",
		["CTRL-V"] = "ALLNAMEPLATES",
		["CTRL-2"] = "ACTIONBUTTON11",
		["J"] = "TOGGLEGUILDTAB",
		["SHIFT-B"] = "TOGGLEBACKPACK",
		["UP"] = "MOVEFORWARD",
		["SHIFT-UP"] = "PREVIOUSACTIONPAGE",
		["F8"] = "TOGGLEBAG1",
		["CTRL-3"] = "ACTIONBUTTON12",
		["SHIFT-R"] = "REPLY2",
		["SHIFT-F1"] = "TARGETPET",
		["CTRL-F7"] = "SHAPESHIFTBUTTON7",
		["CTRL-8"] = "BONUSACTIONBUTTON8",
		["SHIFT-SPACE"] = "TOGGLEWORLDSTATESCORES",
		["CTRL-1"] = "ACTIONBUTTON10",
		["SHIFT-F4"] = "TARGETPARTYPET3",
		["NUMPADMINUS"] = "MINIMAPZOOMOUT",
		["CTRL-F2"] = "SHAPESHIFTBUTTON2",
		["INSERT"] = "PITCHUP",
		["Y"] = "TOGGLEACHIEVEMENT",
		["SHIFT-Y"] = "TOGGLESTATISTICS",
		["SHIFT-M"] = "TOGGLEBATTLEFIELDMINIMAP",
		["CTRL-SHIFT-TAB"] = "TARGETPREVIOUSFRIEND",
		["SHIFT-2"] = "MULTIACTIONBAR1BUTTON2",
		["CTRL-PAGEDOWN"] = "COMBATLOGPAGEDOWN",
		["BUTTON3"] = "MOVEANDSTEER",
		["CTRL-SHIFT-PAGEDOWN"] = "COMBATLOGBOTTOM",
		["CTRL-="] = "MASTERVOLUMEUP",
		["F3"] = "TARGETPARTYMEMBER2",
		["DOWN"] = "MOVEBACKWARD",
		["SHIFT-O"] = "TOGGLECHANNELPULLOUT",
		["SHIFT-DOWN"] = "NEXTACTIONPAGE",
		["CTRL-M"] = "TOGGLEMUSIC",
		["CTRL-4"] = "BONUSACTIONBUTTON4",
		["CTRL-I"] = "TOGGLEDUNGEONSANDRAIDS",
		["SHIFT-F3"] = "TARGETPARTYPET2",
		["NUMPADPLUS"] = "MINIMAPZOOMIN",
		["SHIFT-F2"] = "TARGETPARTYPET1",
		["PAGEUP"] = "CHATPAGEUP",
		["SHIFT-V"] = "MULTIACTIONBAR2BUTTON12",
		["SHIFT-H"] = "MULTIACTIONBAR3BUTTON1",
	},
	Macros = {
		[1] = {"CounterspellMO",nil,"#showtooltip Counterspell\n/cast [@mouseover,harm][@target]Counterspell\n"},
		[2] = {"IceBlock",nil,"#showtooltip\n/stopcasting\n/cancelaura Ice Block\n/cast Ice Block\n"},
		[3] = {"PolyMO",nil,"#showtooltip Polymorph\n/cast [@mouseover,harm][@target]Polymorph\n"},
		[4] = {"Trinket",nil,"#showtooltip\n/use 13\n"},
	},
	Bars = {
		[1] = {"spell",30451},
		[2] = {"spell",44425},
		[3] = {"spell",5143},
		[4] = {"spell",116011},
		[6] = {"spell",108839},
		[7] = {"spell",157980},
		[8] = {"spell",31589},
		[10] = {"spell",130},
		[11] = {"spell",30449},
		[12] = {"spell",110959},
		[25] = {"summonmount",268435455},
		[26] = {"spell",190336},
		[49] = {"spell",12042},
		[50] = {"macro",124},
		[51] = {"spell",80353},
		[53] = {"macro",122},
		[54] = {"spell",11426},
		[57] = {"macro",121},
		[58] = {"macro",123},
		[60] = {"spell",12051},
		[61] = {"spell",212653},
		[62] = {"spell",195676},
		[63] = {"spell",122},
		[64] = {"spell",1449},
	},
});
Impulse:AddSet({
	Class = "MAGE",
	Name = "Frost (PvE)",
	Creator = "Dynasty Addons",
	Description = "",
	Binds = {
		["SHIFT-5"] = "MULTIACTIONBAR1BUTTON5",
		["SHIFT-C"] = "MULTIACTIONBAR1BUTTON6",
		["NUMPAD3"] = "VEHICLENEXTSEAT",
		["SHIFT-P"] = "TOGGLECOLLECTIONS",
		["SHIFT-Z"] = "ACTIONBUTTON7",
		["CTRL-0"] = "BONUSACTIONBUTTON10",
		["SHIFT-F3"] = "TARGETPARTYPET2",
		["SHIFT-MOUSEWHEELUP"] = "PREVIOUSACTIONPAGE",
		["F2"] = "TARGETPARTYMEMBER1",
		["ALT-3"] = "MULTIACTIONBAR4BUTTON3",
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
		["5"] = "ACTIONBUTTON5",
		["SHIFT-A"] = "MULTIACTIONBAR2BUTTON1",
		["9"] = "ACTIONBUTTON9",
		["8"] = "ACTIONBUTTON8",
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
		["ALT-2"] = "MULTIACTIONBAR4BUTTON2",
		["CTRL-F3"] = "SHAPESHIFTBUTTON3",
		["SHIFT-1"] = "MULTIACTIONBAR1BUTTON1",
		["SHIFT-D"] = "MULTIACTIONBAR2BUTTON3",
		["ALT-4"] = "MULTIACTIONBAR4BUTTON4",
		["INSERT"] = "PITCHUP",
		["CTRL-PAGEUP"] = "COMBATLOGPAGEUP",
		["F12"] = "TOGGLEBACKPACK",
		["F11"] = "TOGGLEBAG4",
		["NUMLOCK"] = "TOGGLEAUTORUN",
		["CTRL-9"] = "BONUSACTIONBUTTON9",
		["F10"] = "TOGGLEBAG3",
		["CTRL-F2"] = "SHAPESHIFTBUTTON2",
		["F1"] = "TARGETSELF",
		["ALT-1"] = "MULTIACTIONBAR4BUTTON1",
		["SHIFT-Q"] = "MULTIACTIONBAR2BUTTON5",
		["SPACE"] = "JUMP",
		["CTRL-F8"] = "SHAPESHIFTBUTTON8",
		["DELETE"] = "PITCHDOWN",
		["NUMPAD1"] = "VEHICLEPREVSEAT",
		["HOME"] = "PREVVIEW",
		["CTRL--"] = "MASTERVOLUMEDOWN",
		["4"] = "ACTIONBUTTON4",
		["RIGHT"] = "TURNRIGHT",
		["CTRL-MOUSEWHEELDOWN"] = "VEHICLEAIMDECREMENT",
		["TAB"] = "TARGETNEARESTENEMY",
		["ALT-Z"] = "TOGGLEUI",
		["CTRL-8"] = "BONUSACTIONBUTTON8",
		["SHIFT-F5"] = "TARGETPARTYPET4",
		["CTRL-F1"] = "SHAPESHIFTBUTTON1",
		["I"] = "TOGGLEGROUPFINDER",
		["CTRL-5"] = "BONUSACTIONBUTTON5",
		["SHIFT-O"] = "TOGGLECHANNELPULLOUT",
		["SHIFT-F2"] = "TARGETPARTYPET1",
		["F9"] = "TOGGLEBAG2",
		["CTRL-F4"] = "SHAPESHIFTBUTTON4",
		["SHIFT-M"] = "TOGGLEBATTLEFIELDMINIMAP",
		["SHIFT-B"] = "TOGGLEBACKPACK",
		["UP"] = "MOVEFORWARD",
		["CTRL-V"] = "ALLNAMEPLATES",
		["SHIFT-X"] = "ACTIONBUTTON6",
		["ENTER"] = "OPENCHAT",
		["CTRL-F5"] = "SHAPESHIFTBUTTON5",
		["SHIFT-F1"] = "TARGETPET",
		["CTRL-6"] = "BONUSACTIONBUTTON6",
		["F8"] = "TOGGLEBAG1",
		["CTRL-3"] = "ACTIONBUTTON12",
		["SHIFT-R"] = "REPLY2",
		["SHIFT-UP"] = "PREVIOUSACTIONPAGE",
		["CTRL-7"] = "BONUSACTIONBUTTON7",
		["CTRL-F7"] = "SHAPESHIFTBUTTON7",
		["SHIFT-I"] = "TOGGLEPETBOOK",
		["CTRL-1"] = "ACTIONBUTTON10",
		["Y"] = "TOGGLEACHIEVEMENT",
		["NUMPADMINUS"] = "MINIMAPZOOMOUT",
		["SHIFT-Y"] = "TOGGLESTATISTICS",
		["SHIFT-F4"] = "TARGETPARTYPET3",
		["CTRL-PAGEDOWN"] = "COMBATLOGPAGEDOWN",
		["CTRL-SHIFT-PAGEDOWN"] = "COMBATLOGBOTTOM",
		["CTRL-2"] = "ACTIONBUTTON11",
		["CTRL-SHIFT-TAB"] = "TARGETPREVIOUSFRIEND",
		["SHIFT-2"] = "MULTIACTIONBAR1BUTTON2",
		["DOWN"] = "MOVEBACKWARD",
		["BUTTON3"] = "MOVEANDSTEER",
		["SHIFT-W"] = "MULTIACTIONBAR2BUTTON6",
		["CTRL-="] = "MASTERVOLUMEUP",
		["F3"] = "TARGETPARTYMEMBER2",
		["SHIFT-SPACE"] = "TOGGLEWORLDSTATESCORES",
		["CTRL-4"] = "BONUSACTIONBUTTON4",
		["SHIFT-DOWN"] = "NEXTACTIONPAGE",
		["CTRL-M"] = "TOGGLEMUSIC",
		["CTRL-I"] = "TOGGLEDUNGEONSANDRAIDS",
		["J"] = "TOGGLEGUILDTAB",
		["NUMPADPLUS"] = "MINIMAPZOOMIN",
		["F4"] = "TARGETPARTYMEMBER3",
		["CTRL-S"] = "TOGGLESOUND",
		["PAGEUP"] = "CHATPAGEUP",
		["SHIFT-V"] = "MULTIACTIONBAR1BUTTON7",
		["SHIFT-H"] = "MULTIACTIONBAR3BUTTON1",
	},
	Macros = {
		[1] = {"CounterspellMO",nil,"#showtooltip Counterspell\n/cast [@mouseover,harm][@target]Counterspell\n"},
		[2] = {"FrostJet",nil,"#showtooltip Frostbolt\n/cast Water Jet\n/cast Frostbolt"},
		[3] = {"IceBlock",nil,"#showtooltip\n/stopcasting\n/cancelaura Ice Block\n/cast Ice Block\n"},
		[4] = {"PetAtk",nil,"/petattack"},
		[5] = {"PetFollow",nil,"/petfollow"},
		[6] = {"PetFreeze",nil,"#showtooltip\n/cast Freeze"},
		[7] = {"PetJet",nil,"#showtooltip\n/cast Water Jet"},
		[8] = {"PetMoveTo",nil,"/petmoveto"},
		[9] = {"PolyMO",nil,"#showtooltip Polymorph\n/cast [@mouseover,harm][@target]Polymorph\n"},
		[10] = {"Trinket",nil,"#showtooltip\n/use 13\n"},
	},
	Bars = {
		[1] = {"macro",122},
		[2] = {"spell",205021},
		[3] = {"spell",30455},
		[4] = {"spell",44614},
		[6] = {"spell",84714},
		[10] = {"spell",212653},
		[11] = {"spell",120},
		[12] = {"spell",190356},
		[25] = {"summonmount",268435455},
		[26] = {"spell",190336},
		[27] = {"spell",3567},
		[28] = {"spell",130},
		[29] = {"spell",30449},
		[37] = {"macro",124},
		[38] = {"macro",125},
		[39] = {"macro",128},
		[40] = {"spell",31687},
		[49] = {"spell",12472},
		[50] = {"macro",130},
		[51] = {"spell",80353},
		[53] = {"macro",123},
		[54] = {"spell",11426},
		[55] = {"macro",126},
		[57] = {"macro",121},
		[58] = {"macro",129},
		[61] = {"spell",116011},
		[62] = {"spell",199786},
		[63] = {"spell",205030},
		[64] = {"spell",122},
		[66] = {"spell",108839},
	},
});


Impulse:AddSet({
	Class = "MAGE",
	Name = "Fire (Leveling)",
	Creator = "Dynasty Addons",
	Description = "",
	Binds = {
		["SHIFT-5"] = "ACTIONPAGE5",
		["SHIFT-C"] = "ITEMCOMPARISONCYCLING",
		["NUMPAD3"] = "VEHICLENEXTSEAT",
		["SHIFT-P"] = "TOGGLECOLLECTIONS",
		["SHIFT-Z"] = "ACTIONBUTTON7",
		["CTRL-0"] = "BONUSACTIONBUTTON10",
		["SHIFT-I"] = "TOGGLEPETBOOK",
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
		["9"] = "ACTIONBUTTON9",
		["8"] = "ACTIONBUTTON8",
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
		["HOME"] = "PREVVIEW",
		["DELETE"] = "PITCHDOWN",
		["CTRL-S"] = "TOGGLESOUND",
		["CTRL--"] = "MASTERVOLUMEDOWN",
		["4"] = "ACTIONBUTTON4",
		["TAB"] = "TARGETNEARESTENEMY",
		["ALT-Z"] = "TOGGLEUI",
		["F4"] = "TARGETPARTYMEMBER3",
		["SHIFT-F5"] = "TARGETPARTYPET4",
		["CTRL-F1"] = "SHAPESHIFTBUTTON1",
		["SHIFT-F2"] = "TARGETPARTYPET1",
		["CTRL-5"] = "BONUSACTIONBUTTON5",
		["CTRL-7"] = "BONUSACTIONBUTTON7",
		["CTRL-4"] = "BONUSACTIONBUTTON4",
		["5"] = "ACTIONBUTTON5",
		["CTRL-F4"] = "SHAPESHIFTBUTTON4",
		["F9"] = "TOGGLEBAG2",
		["DOWN"] = "MOVEBACKWARD",
		["CTRL-6"] = "BONUSACTIONBUTTON6",
		["CTRL-V"] = "ALLNAMEPLATES",
		["SHIFT-B"] = "TOGGLEBACKPACK",
		["CTRL-2"] = "ACTIONBUTTON11",
		["UP"] = "MOVEFORWARD",
		["CTRL-PAGEDOWN"] = "COMBATLOGPAGEDOWN",
		["SHIFT-F1"] = "TARGETPET",
		["F8"] = "TOGGLEBAG1",
		["CTRL-3"] = "ACTIONBUTTON12",
		["SHIFT-R"] = "REPLY2",
		["SHIFT-SPACE"] = "TOGGLEWORLDSTATESCORES",
		["CTRL-8"] = "BONUSACTIONBUTTON8",
		["CTRL-F7"] = "SHAPESHIFTBUTTON7",
		["ENTER"] = "OPENCHAT",
		["CTRL-1"] = "ACTIONBUTTON10",
		["SHIFT-UP"] = "PREVIOUSACTIONPAGE",
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
		["SHIFT-F3"] = "TARGETPARTYPET2",
		["NUMPADPLUS"] = "MINIMAPZOOMIN",
		["CTRL-MOUSEWHEELDOWN"] = "VEHICLEAIMDECREMENT",
		["PAGEUP"] = "CHATPAGEUP",
		["SHIFT-V"] = "FRIENDNAMEPLATES",
		["SHIFT-H"] = "MULTIACTIONBAR3BUTTON1",
	},
	Macros = {
		[1] = {"CounterspellMO",nil,"#showtooltip Counterspell\n/cast [@mouseover,harm][@target]Counterspell\n"},
		[2] = {"IceBlock",nil,"#showtooltip\n/stopcasting\n/cancelaura Ice Block\n/cast Ice Block\n"},
		[3] = {"PolyMO",nil,"#showtooltip Polymorph\n/cast [@mouseover,harm][@target]Polymorph\n"},
		[4] = {"Trinket",nil,"#showtooltip\n/use 13\n"},
	},
	Bars = {
		[1] = {"spell",108853},
		[2] = {"spell",44457},
		[3] = {"spell",194466},
		[4] = {"spell",31661},
		[6] = {"spell",108839},
		[7] = {"spell",2948},
		[10] = {"spell",212653},
		[11] = {"spell",122},
		[12] = {"spell",66},
		[25] = {"summonmount",268435455},
		[26] = {"spell",190336},
		[27] = {"spell",193759},
		[37] = {"spell",130},
		[38] = {"spell",30449},
		[49] = {"spell",205029},
		[50] = {"spell",190319},
		[51] = {"spell",80353},
		[53] = {"macro",122},
		[54] = {"spell",11426},
		[57] = {"macro",121},
		[58] = {"macro",123},
		[60] = {"item",80610},
		[61] = {"spell",133},
		[62] = {"spell",11366},
		[63] = {"spell",198929},
		[64] = {"spell",2120},
	},
});
