---------------------------------------------------------------------------------------------------------------
--[[	Gup_MountData				 																		]]--
----------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------
--[[
	The Mounts are split in speeds/type by there spellid for less cpu power then extract it out of the tooltip.
	
	--GROUND--		--FLY--		--AQUATIC--		--SPECIAL--
	1 				10 			20 				30 
		
	21 = SeaLegs
	2  = Aq40
	
]]			
			 
--if Gup_MountDataVersion == nil or tonumber(Gup_MountDataVersion) < 1.13  then
			 
Gup_MountDataVersion = "7.1.0" ;
Gup_MountData = {

-- GROUND MOUNTS ----------------------------------------------------------
[48778]={[1]=true},--Acherus Deathcharger
[127180]={[1]=true},--Albino Riding Crane
[98204]={[1]=true},--Amani Battle Bear
[43688]={[1]=true},--Amani War Bear
[138424]={[1]=true},--Amber Primordial Direhorn
[123886]={[1]=true},--Amber Scorpion
[16056]={[1]=true},--Ancient Frostsaber
[171618]={[1]=true},--Ancient Leatherhide
[16081]={[1]=true},--Arctic Wolf
[66906]={[1]=true},--Argent Charger
[67466]={[1]=true},--Argent Warhorse
[66907]={[1]=true},--Argent Warhorse
[60116]={[1]=true},--Armored Brown Bear
[60114]={[1]=true},--Armored Brown Bear
[171629]={[1]=true},--Armored Frostboar
[171838]={[1]=true},--Armored Frostwolf
[171626]={[1]=true},--Armored Irontusk
[171630]={[1]=true},--Armored Razorback
[96491]={[1]=true},--Armored Razzashi Raptor
[148428]={[1]=true},--Ashhide Mushan Beast
[127174]={[1]=true},--Azure Riding Crane
[118089]={[1]=true},--Azure Water Strider
[51412]={[1]=true},--Big Battle Bear
[58983]={[1]=true},--Big Blizzard Bear
[22719]={[1]=true},--Black Battlestrider
[127286]={[1]=true},--Black Dragon Turtle
[35022]={[1]=true},--Black Hawkstrider
[16055]={[1]=true},--Black Nightsaber
[26656]={[1]=true},--Black Qiraji Battle Tank
[138642]={[1]=true},--Black Primal Raptor
[130138]={[1]=true},--Black Riding Goat
[127209]={[1]=true},--Black Riding Yak
[17461]={[1]=true},--Black Ram
[64977]={[1]=true},--Black Skeletal Horse
[470]={[1]=true},--Black Stallion
[60118]={[1]=true},--Black War Bear
[60119]={[1]=true},--Black War Bear
[48027]={[1]=true},--Black War Elekk
[22718]={[1]=true},--Black War Kodo
[59785]={[1]=true},--Black War Mammoth
[59788]={[1]=true},--Black War Mammoth
[22720]={[1]=true},--Black War Ram
[22721]={[1]=true},--Black War Raptor
[22717]={[1]=true},--Black War Steed
[22723]={[1]=true},--Black War Tiger
[22724]={[1]=true},--Black War Wolf
[64658]={[1]=true},--Black Wolf
[171627]={[1]=true},--Blacksteel Battleboar
[127220]={[1]=true},--Blonde Riding Yak
[171620]={[1]=true},--Bloodhoof Bull
[127287]={[1]=true},--Blue Dragon Turtle
[35020]={[1]=true},--Blue Hawkstrider
[10969]={[1]=true},--Blue Mechanostrider
[25953]={[1]=true,[2]=true},--Blue Qiraji Battle Tank
[129934]={[1]=true},--Blue Shado-Pan Riding Tiger
[17463]={[1]=true},--Blue Skeletal Horse
[64656]={[1]=true},--Blue Skeletal Warhorse
[138640]={[1]=true},--Bone-White Primal Raptor
[142641]={[1]=true},--Brawler's Burly Mushan Beast
[171832]={[1]=true},--Breezestrider Stallion
[50869]={[1]=true},--Brewfest Kodo
[43899]={[1]=true},--Brewfest Ram
[190690]={[1]=true},--Bristling Hellboar
[127288]={[1]=true},--Brown Dragon Turtle
[34406]={[1]=true},--Brown Elekk	
[458]={[1]=true},--Brown Horse
[18990]={[1]=true},--Brown Kodo
[6899]={[1]=true},--Brown Ram
[88748]={[1]=true},--Brown Riding Camel
[130086]={[1]=true},--Brown Riding Goat
[17464]={[1]=true},--Brown Skeletal Horse
[6654]={[1]=true},--Brown Wolf
[171848]={[1]=true},--Challenger's War Yeti
[171846]={[1]=true},--Champion's Treadblade
[6648]={[1]=true},--Chestnut Mare
[189364]={[1]=true},--Coalfist Gronnling
[138423]={[1]=true},--Cobalt Primordial Direhorn
[39315]={[1]=true},--Cobalt Riding Talbuk
[34896]={[1]=true},--Cobalt War Talbuk
[170347]={[1]=true},--Core Hound
[169952]={[1]=true},--Creeping Carpet
[73313]={[1]=true},--Crimson Deathcharger
[140250]={[1]=true},--Crimson Primal Direhorn
[123160]={[1]=true},--Crimson Riding Crane
[127271]={[1]=true},--Crimson Water Strider
[68188]={[1]=true},--Crusader's Black Warhorse
[68187]={[1]=true},--Crusader's White Warhorse
[39316]={[1]=true},--Dark Riding Talbuk
[34790]={[1]=true},--Dark War Talbuk
[103081]={[1]=true},--Darkmoon Dancing Bear
[63635]={[1]=true},--Darkspear Raptor
[63637]={[1]=true},--Darnassian Nightsaber
[190977]={[1]=true},--Deathtusk Felboar
[6653]={[1]=true},--Dire Wolf
[171634]={[1]=true},--Domesticated Razorback
[23161]={[1]=true},--Dreadsteed
[171844]={[1]=true},--Dustmane Direwolf
[171625]={[1]=true},--Dusty Rockhide
[8395]={[1]=true},--Emerald Raptor
[63639]={[1]=true},--Exodar Elekk
[5784]={[1]=true},--Felsteed
[36702]={[1]=true},--Fiery Warhorse
[101542]={[1]=true},--Flametalon of Alysrazor
[63643]={[1]=true},--Forsaken Warhorse
[84751]={[1]=true},--Fossilized Raptor
[17460]={[1]=true},--Frost Ram
[171632]={[1]=true},--Frostplains Battleboar
[23509]={[1]=true},--Frostwolf Howler
[171851]={[1]=true},--Garn Nighthowl
[171836]={[1]=true},--Garn Steelmaw
[171635]={[1]=true},--Giant Coldsnout
[63638]={[1]=true},--Gnomeregan Mechanostrider
[89520]={[1]=true},--Goblin Mini Hotrod
[87090]={[1]=true},--Goblin Trike 
[87091]={[1]=true},--Goblin Turbo-Trike 
[90621]={[1]=true},--Golden King
[140249]={[1]=true},--Golden Primal Direhorn
[127176]={[1]=true},--Golden Riding Crane
[127278]={[1]=true},--Golden Water Strider
[171436]={[1]=true},--Gorestrider Gronnling
[61465]={[1]=true,[30]=true},--Grand Black War Mammoth
[61467]={[1]=true,[30]=true},--Grand Black War Mammoth
[122708]={[1]=true,[30]=true},--Grand Expedition Yak
[61469]={[1]=true,[30]=true},--Grand Ice Mammoth
[61470]={[1]=true,[30]=true},--Grand Ice Mammoth
[35710]={[1]=true},--Gray Elekk
[18989]={[1]=true},--Gray Kodo
[6777]={[1]=true},--Gray Ram
[127295]={[1]=true},--Great Black Dragon Turtle
[127302]={[1]=true},--Great Blue Dragon Turtle
[35713]={[1]=true},--Great Blue Elekk
[49379]={[1]=true},--Great Brewfest Kodo
[127308]={[1]=true},--Great Brown Dragon Turtle
[23249]={[1]=true},--Great Brown Kodo
[65641]={[1]=true},--Great Golden Kodo
[23248]={[1]=true},--Great Gray Kodo
[127293]={[1]=true},--Great Green Dragon Turtle
[35712]={[1]=true},--Great Green Elekk
[171636]={[1]=true},--Great Greytusk
[127310]={[1]=true},--Great Purple Dragon Turtle
[35714]={[1]=true},--Great Purple Elekk
[120822]={[1]=true},--Great Red Dragon Turtle
[65637]={[1]=true},--Great Red Elekk
[23247]={[1]=true},--Great White Kodo
[120395]={[1]=true},--Green Dragon Turtle
[18991]={[1]=true},--Green Kodo
[17453]={[1]=true},--Green Mechanostrider
[138643]={[1]=true},--Green Primal Raptor
[26056]={[1]=true,[2]=true},--Green Qiraji Battle Tank
[129932]={[1]=true},--Green Shado-Pan Riding Tiger
[17465]={[1]=true},--Green Skeletal Warhorse
[88750]={[1]=true},--Grey Riding Camel
[127216]={[1]=true},--Grey Riding Yak
[59797]={[1]=true},--Ice Mammoth
[59799]={[1]=true},--Ice Mammoth
[17459]={[1]=true},--Icy Blue Mechanostrider Mod A
[189998]={[1]=true},--Illidari Felstalker
[186305]={[1]=true},--Infernal Direwolf
[63636]={[1]=true},--Ironforge Ram
[171621]={[1]=true},--Ironhoof Destroyer
[171839]={[1]=true},--Ironside Warwolf
[17450]={[1]=true},--Ivory Raptor
[138426]={[1]=true},--Jade Primordial Direhorn
[127274]={[1]=true},--Jade Water Strider
[127178]={[1]=true},--Jungle Riding Crane
[93644]={[1]=true},--Kor'kron Annihilator
[148417]={[1]=true},--Kor'kron Juggernaut
[148396]={[1]=true},--Kor'kron War Wolf
[65917]={[1]=true},--Magic Rooster 
[55531]={[1]=true,[30]=true},--Mechano-hog
[60424]={[1]=true,[30]=true},--Mekgineer's Chopper
[191314]={[1]=true},--Minion of Grumpus
[171825]={[1]=true},--Mosshide Riverwallow
[171622]={[1]=true},--Mottled Meadowstomper
[16084]={[1]=true},--Mottled Red Raptor
[103195]={[1]=true},--Mountain Horse
[171826]={[1]=true},--Mudback Riverbeast
[66846]={[1]=true},--Ochre Skeletal Warhorse
[127272]={[1]=true},--Orange Water Strider
[63640]={[1]=true},--Orgrimmar Wolf
[171833]={[1]=true},--Pale Thorngrazer
[16082]={[1]=true},--Palomino
[472]={[1]=true},--Pinto
[186828]={[1]=true},--Primal Gladiator's Felblood Gronnling
[127289]={[1]=true},--Purple Dragon Turtle
[35711]={[1]=true},--Purple Elekk
[35018]={[1]=true},--Purple Hawkstrider
[23246]={[1]=true},--Purple Skeletal Warhorse
[66090]={[1]=true},--Quel'dorei Steed
[41252]={[1]=true},--Raven Lord
[127290]={[1]=true},--Red Dragon Turtle
[34795]={[1]=true},--Red Hawkstrider
[10873]={[1]=true},--Red Mechanostrider
[138641]={[1]=true},--Red Primal Raptor
[26054]={[1]=true,[2]=true},--Red Qiraji Battle Tank
[129935]={[1]=true},--Red Shado-Pan Riding Tiger
[17462]={[1]=true},--Red Skeletal Horse
[22722]={[1]=true},--Red Skeletal Warhorse
[16080]={[1]=true},--Red Wolf
[127177]={[1]=true},--Regal Riding Crane
[17481]={[1]=true},--Rivendare's Deathcharger
[171628]={[1]=true},--Rocktusk Battleboar
[171824]={[1]=true},--Sapphire Riverbeast
[97581]={[1]=true},--Savage Raptor
[39317]={[1]=true},--Silver Riding Talbuk
[34898]={[1]=true},--Silver War Talbuk
[63642]={[1]=true},--Silvermoon Hawkstrider
[171624]={[1]=true},--Shadowhide Pearltusk
[171829]={[1]=true},--Shadowmane Charger
[138425]={[1]=true},--Slate Primordial Direhorn
[171843]={[1]=true},--Smoky Direwolf
[171828]={[1]=true},--Solar Spirehawk
[130965]={[1]=true},--Son of Galleon
[136471]={[1]=true},--Spawn of Horridon
[92231]={[1]=true},--Spectral Steed
[42776]={[1]=true},--Spectral Tiger
[92232]={[1]=true},--Spectral Wolf
[10789]={[1]=true},--Spotted Frostsaber
[23510]={[1]=true},--Stormpike Battle Charger
[63232]={[1]=true},--Stormwind Steed
[66847]={[1]=true},--Striped Dawnsaber
[8394]={[1]=true},--Striped Frostsaber
[10793]={[1]=true},--Striped Nightsaber
[171849]={[1]=true},--Sunhide Gronnling
[23214]={[1]=true},--Summon Charger
[179244]={[1]=true},--Summon Chauffeur
[179245]={[1]=true},--Summon Chauffeur
[34767]={[1]=true},--Summon Thalassian Charger
[73629]={[1]=true},--Summon Exarch's Elekk
[73630]={[1]=true},--Summon Great Exarch's Elekk
[69826]={[1]=true},--Summon Great Sunwalker Kodo
[69820]={[1]=true},--Summon Sunwalker Kodo
[34769]={[1]=true},--Summon Thalassian Warhorse
[13819]={[1]=true},--Summon Warhorse
[66091]={[1]=true},--Sunreaver Hawkstrider
[68057]={[1]=true},--Swift Alliance Steed
[23241]={[1]=true},--Swift Blue Raptor
[43900]={[1]=true},--Swift Brewfest Ram	
[171830]={[1]=true},--Swift Breezestrider
[23238]={[1]=true},--Swift Brown Ram
[23229]={[1]=true},--Swift Brown Steed
[23250]={[1]=true},--Swift Brown Wolf
[65646]={[1]=true},--Swift Burgundy Wolf
[102346]={[1]=true},--Swift Forest Strider
[23221]={[1]=true},--Swift Frostsaber
[171842]={[1]=true},--Swift Frostwolf
[23239]={[1]=true},--Swift Gray Ram
[65640]={[1]=true},--Swift Gray Steed
[23252]={[1]=true},--Swift Gray Wolf	
[35025]={[1]=true},--Swift Green Hawkstrider
[23225]={[1]=true},--Swift Green Mechanostrider
[68056]={[1]=true},--Swift Horde Wolf
[102350]={[1]=true},--Swift Lovebird
[23219]={[1]=true},--Swift Mistsaber
[65638]={[1]=true},--Swift Moonsaber
[103196]={[1]=true},--Swift Mountain Horse
[23242]={[1]=true},--Swift Olive Raptor
[23243]={[1]=true},--Swift Orange Raptor
[23227]={[1]=true},--Swift Palomino
[33660]={[1]=true},--Swift Pink Hawkstrider
[35027]={[1]=true},--Swift Purple Hawkstrider
[65644]={[1]=true},--Swift Purple Raptor
[24242]={[1]=true},--Swift Razzashi Raptor	
[65639]={[1]=true},--Swift Red Hawkstrider
[101573]={[1]=true},--Swift Shorestrider
[42777]={[1]=true},--Swift Spectral Tiger
[102349]={[1]=true},--Swift Springstrider
[23338]={[1]=true},--Swift Stormsaber
[23251]={[1]=true},--Swift Timber Wolf
[65643]={[1]=true},--Swift Violet Ram
[35028]={[1]=true},--Swift Warstrider
[46628]={[1]=true},--Swift White Hawkstrider
[23223]={[1]=true},--Swift White Mechanostrider
[23240]={[1]=true},--Swift White Ram
[23228]={[1]=true},--Swift White Steed
[23222]={[1]=true},--Swift Yellow Mechanostrider
[49322]={[1]=true},--Swift Zhevra
[96499]={[1]=true},--Swift Zulian Panther
[24252]={[1]=true},--Swift Zulian Tiger
[88749]={[1]=true},--Tan Riding Camel
[39318]={[1]=true},--Tan Riding Talbuk
[34899]={[1]=true},--Tan War Talbuk
[18992]={[1]=true},--Teal Kodo
[63641]={[1]=true},--Thunder Bluff Kodo
[580]={[1]=true},--Timber Wolf
[171617]={[1]=true},--Trained Icehoof
[171623]={[1]=true},--Trained Meadowstomper
[171638]={[1]=true},--Trained Riverwallow
[171637]={[1]=true},--Trained Rocktusk
[171831]={[1]=true},--Trained Silverpelt
[171841]={[1]=true},--Trained Snarler
[61425]={[1]=true,[30]=true},--Traveler's Tundra Mammoth
[61447]={[1]=true,[30]=true},--Traveler's Tundra Mammoth
[171619]={[1]=true},--Tundra Icehoof
[65642]={[1]=true},--Turbostrider
[10796]={[1]=true},--Turquoise Raptor
[92155]={[1]=true},--Ultramarine Qiraji Battle Tank
[17454]={[1]=true},--Unpainted Mechanostrider
[64659]={[1]=true},--Venomhide Ravasaur
[146622]={[1]=true},--Vicious Skeletal Warhorse
[185052]={[1]=true},--Vicious War Kodo
[183889]={[1]=true},--Vicious War Mechanostrider
[171834]={[1]=true},--Vicious War Ram
[171835]={[1]=true},--Vicious War Raptor
[100332]={[1]=true},--Vicious War Steed
[100333]={[1]=true},--Vicious War Wolf
[146615]={[1]=true},--Vicious Warsaber
[10799]={[1]=true},--Violet Raptor
[179478]={[1]=true},--Voidtalon of the Dark Star
[171845]={[1]=true},--Warlord's Deathwheel
[189044]={[1]=true},--Warmongering Gladiator's Felblood Gronnling
[171837]={[1]=true},--Warsong Direfang
[64657]={[1]=true},--White Kodo 
[15779]={[1]=true},--White Mechanostrider Mod B
[54753]={[1]=true},--White Polar Bear
[6898]={[1]=true},--White Ram
[102488]={[1]=true},--White Riding Camel
[130137]={[1]=true},--White Riding Goat
[123182]={[1]=true},--White Riding Yak
[39319]={[1]=true},--White Riding Talbuk
[65645]={[1]=true},--White Skeletal Warhorse
[16083]={[1]=true},--White Stallion
[34897]={[1]=true},--White War Talbuk
[189043]={[1]=true},--Wild Gladiator's Felblood Gronnling
[171633]={[1]=true},--Wild Goretusk
[171616]={[1]=true},--Witherhide Cliffstomper
[17229]={[1]=true},--Winterspring Frostsaber
[59791]={[1]=true},--Wooly Mammoth
[59793]={[1]=true},--Wooly Mammoth
[74918]={[1]=true},--Wooly White Rhino
[26055]={[1]=true,[2]=true},--Yellow Qiraji Battle Tank
-- Not listed in Wowhead under mounts --
[15781]={[1]=true},--Steel Mechanostrider
[17455]={[1]=true},--Purple Mechanostrider
[17456]={[1]=true},--Red and Blue Mechanostrider
[17458]={[1]=true},--Fluorescent Green Mechanostrider
[16058]={[1]=true},--Primal Leopard
[16059]={[1]=true},--Tawny Sabercat
[16060]={[1]=true},--Golden Sabercat
[18363]={[1]=true},--Riding Kodo
[49378]={[1]=true},--Brewfest Riding Kodo
[23220]={[1]=true},--Swift Dawnsaber
[34407]={[1]=true},--Great Elite Elekk
[47037]={[1]=true},--Swift War Elekk
[59572]={[1]=true},--Black Polar Bear
[59573]={[1]=true},--Brown Polar Bear
[63234]={[1]=true},--Trusty Stormwind Charger
[60136]={[1]=true,[30]=true},--Grand Caravan Mammoth
[60140]={[1]=true,[30]=true},--Grand Caravan Mammoth
[61466]={[1]=true,[30]=true},--Grand Black War Mammoth
-- FLYING MOUNTS ----------------------------------------------------------
[60025]={[10]=true},--Albino Drake
[96503]={[10]=true},--Amani Dragonhawk
[63844]={[10]=true},--Argent Hippogryph
[139595]={[10]=true},--Armored Bloodwing
[142478]={[10]=true},--Armored Blue Dragonhawk
[61230]={[10]=true},--Armored Blue Wind Rider
[142266]={[10]=true},--Armored Red Dragonhawk
[136400]={[10]=true},--Armored Skyscreamer
[61229]={[10]=true},--Armored Snowy Gryphon
[132117]={[10]=true},--Ashen Pandaren Phoenix
[40192]={[10]=true},--Ashes of Al'ar
[127170]={[10]=true},--Astral Cloud Serpent
[123992]={[10]=true},--Azure Cloud Serpent
[59567]={[10]=true},--Azure Drake
[41514]={[10]=true},--Azure Netherwing Drake
[71342]={[1]=true,[10]=true},--Big Love Rocket
[59650]={[10]=true},--Black Drake
[59976]={[10]=true},--Black Proto-Drake
[107842]={[10]=true},--Blazing Drake
[74856]={[10]=true},--Blazing Hippogryph
[72808]={[10]=true},--Bloodbathed Frostbrood Vanquisher
[61996]={[10]=true},--Blue Dragonhawk
[59568]={[10]=true},--Blue Drake
[59996]={[10]=true},--Blue Proto-Drake
[39803]={[10]=true},--Blue Riding Nether Ray
[32244]={[10]=true},--Blue Wind Rider
[59569]={[10]=true},--Bronze Drake
[58615]={[10]=true},--Brutal Nether Drake
[124550]={[10]=true},--Cataclysmic Gladiator's Twilight Drake
[75614]={[1]=true,[10]=true},--Celestial Steed
[43927]={[10]=true},--Cenarion War Hippogryph
[171847]={[1]=true,[10]=true},--Cindermane Charger
[139448]={[10]=true},--Clutch of Ji-Kun
[41515]={[10]=true},--Cobalt Netherwing Drake
[183117]={[1]=true,[10]=true},--Corrupted Dreadwing
[97560]={[10]=true},--Corrupted Fire Hawk
[102514]={[10]=true},--Corrupted Hippogryph
[127156]={[10]=true},--Crimson Cloud Serpent
[129552]={[10]=true},--Crimson Pandaren Phoenix
[88990]={[10]=true},--Dark Phoenix <-- Flying Guild Mount
[64927]={[1]=true,[10]=true},--Deadly Gladiator's Frost Wyrm
[126507]={[10]=true},--Depleted-Kyparium Rocket
[88335]={[10]=true},--Drake of the East Wind
[88742]={[10]=true},--Drake of the North Wind
[88744]={[10]=true},--Drake of the South Wind
[88741]={[10]=true},--Drake of the West Wind
[155741]={[1]=true,[10]=true},--Dread Raven
[32239]={[10]=true},--Ebon Gryphon
[194464]={[10]=true},--Eclipse Dragonhawk
[175700]={[10]=true},--Emerald Drake
[149801]={[10]=true},--Emerald Hippogryph
[132118]={[10]=true},--Emerald Pandaren Phoenix
[142878]={[10]=true},--Enchanted Fey Dragon
[110039]={[10]=true},--Experiment 12-B
[113120]={[10]=true},--Feldrake
[97501]={[10]=true},--Felfire Hawk
[182912]={[1]=true,[10]=true},--Felsteel Annihilator
[97359]={[1]=true,[10]=true},--Flameward Hippogryph
[61451]={[10]=true},--Flying Carpet
[44153]={[1]=true,[10]=true},--Flying Machine
[75596]={[1]=true,[10]=true},--Frosty Flying Carpet
[65439]={[10]=true},--Furious Gladiator's Frost Wyrm
[126508]={[10]=true},--Geosynchronous World Spinner
[136505]={[1]=true,[10]=true},--Ghastly Charger
[123993]={[10]=true},--Golden Cloud Serpent
[32235]={[10]=true},--Golden Gryphon
[135416]={[10]=true},--Grand Armored Gryphon
[135418]={[10]=true},--Grand Armored Wyvern
[136163]={[10]=true},--Grand Gryphon
[136164]={[10]=true},--Grand Wyvern
[61294]={[10]=true},--Green Proto-Drake
[39798]={[10]=true},--Green Riding Nether Ray
[32245]={[10]=true},--Green Wind Rider
[148619]={[10]=true},--Grievous Gladiator's Cloud Serpent
[163025]={[1]=true,[10]=true},--Grinning Reaver
[189999]={[1]=true,[10]=true},--Grove Warden
[48025]={[1]=true,[10]=true},--Headless Horseman's Mount	
[110051]={[10]=true},--Heart of the Aspects
[142073]={[1]=true,[10]=true},--Hearthsteed
[127169]={[10]=true},--Heavenly Azure Cloud Serpent
[127161]={[10]=true},--Heavenly Crimson Cloud Serpent
[127164]={[10]=true},--Heavenly Golden Cloud Serpent
[127165]={[10]=true},--Heavenly Jade Cloud Serpent
[127158]={[10]=true},--Heavenly Onyx Cloud Serpent
[72807]={[10]=true},--Icebound Frostbrood Vanquisher
[124659]={[10]=true},--Imperial Quilen
[201098]={[10]=true},--Infinite Timereaver
[72286]={[1]=true,[10]=true},--Invincible
[153489]={[10]=true},--Iron Skyreaver
[63956]={[10]=true},--Ironbound Proto-Drake
[142910]={[1]=true,[10]=true},--Ironbound Wraithcharger
[113199]={[10]=true},--Jade Cloud Serpent
[133023]={[10]=true},--Jade Pandaren Kite
[121837]={[1]=true,[10]=true},--Jade Panther
[120043]={[1]=true,[10]=true},--Jeweled Onyx Panther
[107845]={[10]=true},--Life-Binder's Handmaiden
[61309]={[1]=true,[10]=true},--Magnificent Flying Carpet
[139407]={[10]=true},--Malevolent Gladiator's Cloud Serpent
[44744]={[10]=true},--Merciless Nether Drake
[63796]={[10]=true},--Mimiron's Head
[93623]={[10]=true},--Mottled Drake
[180545]={[1]=true,[10]=true},--Mystic Runesaber
[121820]={[1]=true,[10]=true,[30]=true},--Obsidian Nightwing
[127154]={[10]=true},--Onyx Cloud Serpent
[41513]={[10]=true},--Onyx Netherwing Drake
[69395]={[10]=true},--Onyxian Drake
[118737]={[10]=true},--Pandaren Kite
[130985]={[10]=true},--Pandaren Kite
[32345]={[10]=true},--Peep the Phoenix Mount
[88718]={[10]=true},--Phosphorescent Stone Drake
[60021]={[10]=true},--Plagued Proto-Drake
[148620]={[10]=true},--Prideful Gladiator's Cloud Serpent
[97493]={[10]=true},--Pureblood Fire Hawk
[41516]={[10]=true},--Purple Netherwing Drake
[39801]={[10]=true},--Purple Riding Nether Ray
[61997]={[10]=true},--Red Dragonhawk
[59570]={[10]=true},--Red Drake
[130092]={[1]=true,[10]=true},--Red Flying Cloud
[59961]={[10]=true},--Red Proto-Drake
[39800]={[10]=true},--Red Riding Nether Ray
[67336]={[10]=true},--Relentless Gladiator's Frost Wyrm
[121838]={[1]=true,[10]=true},--Ruby Panther
[63963]={[10]=true},--Rusted Proto-Drake
[101821]={[10]=true},--Ruthless Gladiator's Twilight Drake
[93326]={[10]=true,[30]= true},--Sandstone Drake
[121836]={[1]=true,[10]=true},--Sapphire Panther
[66087]={[10]=true},--Silver Covenant Hippogryph
[39802]={[10]=true},--Silver Riding Nether Ray
[134359]={[1]=true,[10]=true},--Sky Golem
[191633]={[1]=true,[10]=true},--Soaring Skyterror
[148392]={[10]=true},--Spawn of Galakras
[107516]={[10]=true},--Spectral Gryphon
[107517]={[10]=true},--Spectral Wind Rider
[32240]={[10]=true},--Snowy Gryphon
[147595]={[10]=true},--Stormcrow
[66088]={[10]=true},--Sunreaver Dragonhawk
[121839]={[1]=true,[10]=true},--Sunstone Panther
[32242]={[10]=true},--Swift Blue Gryphon
[32290]={[10]=true},--Swift Green Gryphon
[32295]={[10]=true},--Swift Green Wind Rider
[37015]={[10]=true},--Swift Nether Drake
[32292]={[10]=true},--Swift Purple Gryphon
[32297]={[10]=true},--Swift Purple Wind Rider
[32289]={[10]=true},--Swift Red Gryphon
[32246]={[10]=true},--Swift Red Wind Rider
[134573]={[1]=true,[10]=true},--Swift Windsteed
[32296]={[10]=true},--Swift Yellow Wind Rider
[32243]={[10]=true},--Tawny Wind Rider
[60002]={[10]=true},--Time-Lost Proto-Drake
[129918]={[10]=true},--Thundering August Cloud Serpent
[139442]={[10]=true},--Thundering Cobalt Cloud Serpent
[124408]={[10]=true},--Thundering Jade Cloud Serpent
[148476]={[10]=true},--Thundering Onyx Cloud Serpent
[132036]={[10]=true},--Thundering Ruby Cloud Serpent
[44151]={[1]=true,[10]=true},--Turbo-Charged Flying Machine
[59571]={[10]=true},--Twilight Drake
[107844]={[10]=true},--Twilight Harbinger
[107203]={[1]=true,[10]=true},--Tyrael's Charger
[148618]={[10]=true},--Tyrannical Gladiator's Cloud Serpent
[49193]={[10]=true},--Vengeful Nether Drake
[41517]={[10]=true},--Veridian Netherwing Drake
[101282]={[10]=true},--Vicious Gladiator's Twilight Drake
[41518]={[10]=true},--Violet Netherwing Drake
[132119]={[10]=true},--Violet Pandaren Phoenix
[60024]={[10]=true},--Violet Proto-Drake
[88746]={[10]=true},--Vitreous Stone Drake
[88331]={[10]=true},--Volcanic Stone Drake
[163024]={[1]=true,[10]=true},--Warforged Nightmare
[98727]={[1]=true,[10]=true},--Winged Guardian
[54729]={[10]=true},--Winged Steed of the Ebon Blade
[71810]={[10]=true},--Wrathful Gladiator's Frost Wyrm
[46197]={[1]=true,[10]=true},--X-51 Nether-Rocket
[46199]={[1]=true,[10]=true},--X-51 Nether-Rocket X-TREME
[75973]={[1]=true,[10]=true,[30]= true},--X-53 Touring Rocket
-- Not listed in Wowhead under mounts --
[62048]={[10]=true},--Black Dragonhawk Mount
[43810]={[10]=true},--Frost Wyrm
[51960]={[10]=true},--Frostwyrm Mount
[44221]={[10]=true},--Loaned Gryphon Reins
[44229]={[10]=true},--Loaned Wind Rider Reins
[44317]={[10]=true},--Merciless Nether Drake
[3363]={[10]=true}, --Nether Drake
[28828]={[10]=true},--Nether Drake
[61442]={[10]=true},--Swift Mooncloth Carpet
[61444]={[10]=true},--Swift Shadoweave Carpet
[55164]={[10]=true},--Swift Spectral Gryphon
[61446]={[10]=true},--Swift Spellfire Carpet
-- AQUATIC MOUNTS ---------------------------------------------------------
[75207]={[20]=true,[21]=true},--Abyssal Seahorse
[30174]={[20]=true},--Riding Turtle
[64731]={[20]=true},--Sea Turtle
[98718]={[20]=true},--Subdued Seahorse
---------------------------------------------------------------------------	
[148970]={[1]=true},--Felsteed
[148972]={[1]=true},--Dreadsteed

-- Legion 7.0.3 -----------------------------------------------------------
[227956]={[1]=true},--Arcadian War Turtle
[213115]={[1]=true},--Bloodfang Widow
[213164]={[1]=true},--Brilliant Direbeak
[214791]={[20]=true},--Brinedeep Bottom-Feeder
[171840]={[1]=true},--Coldflame Infernal
[227989]={[1]=true,[10]=true},--Cruel  Gladiator's Storm Dragon
[227995]={[1]=true,[10]=true},--Demonic Gladiator's Storm Dragon
[223018]={[20]=true},--Fathom Dweller
[227988]={[1]=true},--Fearless Gladiator's Storm Dragon
[215545]={[1]=true},--Fel Bat (Test) -- exist???
[213134]={[1]=true},--Felblaze Infernal
[200175]={[1]=true},--Felsaber
[227991]={[1]=true,[10]=true},--Ferocious Gladiator's Storm Dragon
[227994]={[1]=true,[10]=true},--Fierce Gladiator's Storm Dragon
[213349]={[1]=true},--Flarecore Infernal
[213350]={[1]=true},--Frostshard Infernal
[213339]={[1]=true,[10]=true},--Great Northern Elderhorn -- fly?
[193007]={[1]=true,[10]=true},--Grove Defiler -- fly?
[171827]={[1]=true},--Hellfire Infernal
[225765]={[1]=true,[10]=true},--Leyfeather Hippogryph
[171850]={[1]=true},--Llothien Prowler
[215159]={[1]=true,[10]=true},--Long-Forgotten Hippogryph
[223814]={[1]=true,[10]=true},--Mechanized Lumber Extractor
[213158]={[1]=true},--Predatory Bloodgazer
[222240]={[1]=true},--Prestigious Azure Courser
[222202]={[1]=true},--Prestigious Bronze Courser
[222237]={[1]=true},--Prestigious Forest Courser
[222238]={[1]=true},--Prestigious Ivory Courser
[222241]={[1]=true},--Prestigious Midnight Courser
[222236]={[1]=true},--Prestigious Royal Courser
[193695]={[1]=true},--Prestigious War Steed
[215558]={[1]=true},--Ratstallion
[213163]={[1]=true},--Snowfeather Hunter
[196681]={[1]=true},--Spirit of Eche'ro
[213209]={[1]=true},--Steelbound Devourer
[223341]={[1]=true},--Vicious Gilnean Warhorse
[223578]={[1]=true},--Vicious War Elekk
[223354]={[1]=true},--Vicious War Trike7
[223363]={[1]=true},--Vicious Warstrider
[227986]={[1]=true,[10]=true},--Vindictive Gladiator's Storm Dragon
[213165]={[1]=true},--Viridian Sharptalon
---------------------------------------------------------------------------
-- 7.1.0
[230987]={[1]=true,[10]=true},--Arcanist's Manasaber
[228919]={[20]=true},--Darkwater Skate
[229499]={[1]=true},--Midnight
[230844]={[1]=true},--Rockspine Basilisk
[231428]={[10]=true},--Smoldering Ember Wyrm
[230401]={[1]=true},--White Hawkstrider
}	;

--end



