local AddOnName, Engine = ...
local AddOn = {}

Engine[1] = AddOn

AddOn.Title = GetAddOnMetadata(AddOnName, "Title")
AddOn.Version = GetAddOnMetadata(AddOnName, "Version")
AddOn.MyRealm = GetRealmName()

AddOn.GameIcons = {
	Default = {
		Alliance = BNet_GetClientTexture('WoW'),
		Horde = BNet_GetClientTexture('WoW'),
		Neutral = BNet_GetClientTexture('WoW'),
		D3 = BNet_GetClientTexture('D3'),
		WTCG = BNet_GetClientTexture('WTCG'),
		S2 = BNet_GetClientTexture('S2'),
		App = BNet_GetClientTexture('App'),
		Hero = BNet_GetClientTexture('Hero'),
	},
	BlizzardChat = {
		Alliance = "Interface\\ChatFrame\\UI-ChatIcon-WoW",
		Horde = "Interface\\ChatFrame\\UI-ChatIcon-WoW",
		Neutral = "Interface\\ChatFrame\\UI-ChatIcon-WoW",
		D3 = "Interface\\ChatFrame\\UI-ChatIcon-D3",
		WTCG = "Interface\\ChatFrame\\UI-ChatIcon-WTCG",
		S2 = "Interface\\ChatFrame\\UI-ChatIcon-SC2",
		App = "Interface\\ChatFrame\\UI-ChatIcon-Battlenet",
		Hero = "Interface\\ChatFrame\\UI-ChatIcon-Hero",
	},
	Flat = {
		Alliance = "Interface\\AddOns\\"..AddOnName.."\\Textures\\GameIcons\\Flat\\Alliance",
		Horde = "Interface\\AddOns\\"..AddOnName.."\\Textures\\GameIcons\\Flat\\Horde",
		Neutral = "Interface\\AddOns\\"..AddOnName.."\\Textures\\GameIcons\\Flat\\Neutral",
		D3 = "Interface\\AddOns\\"..AddOnName.."\\Textures\\GameIcons\\Flat\\D3",
		WTCG = "Interface\\AddOns\\"..AddOnName.."\\Textures\\GameIcons\\Flat\\Hearthstone",
		S2 = "Interface\\AddOns\\"..AddOnName.."\\Textures\\GameIcons\\Flat\\SC2",
		App = "Interface\\AddOns\\"..AddOnName.."\\Textures\\GameIcons\\Flat\\BattleNet",
		Hero = "Interface\\AddOns\\"..AddOnName.."\\Textures\\GameIcons\\Flat\\Heroes",
	},
	Gloss = {
		Alliance = "Interface\\AddOns\\"..AddOnName.."\\Textures\\GameIcons\\Gloss\\Alliance",
		Horde = "Interface\\AddOns\\"..AddOnName.."\\Textures\\GameIcons\\Gloss\\Horde",
		Neutral = "Interface\\AddOns\\"..AddOnName.."\\Textures\\GameIcons\\Gloss\\Neutral",
		D3 = "Interface\\AddOns\\"..AddOnName.."\\Textures\\GameIcons\\Gloss\\D3",
		WTCG = "Interface\\AddOns\\"..AddOnName.."\\Textures\\GameIcons\\Gloss\\Hearthstone",
		S2 = "Interface\\AddOns\\"..AddOnName.."\\Textures\\GameIcons\\Gloss\\SC2",
		App = "Interface\\AddOns\\"..AddOnName.."\\Textures\\GameIcons\\Gloss\\BattleNet",
		Hero = "Interface\\AddOns\\"..AddOnName.."\\Textures\\GameIcons\\Gloss\\Heroes",
	},
}

AddOn.StatusIcons = {
	Default = {
		Online = FRIENDS_TEXTURE_ONLINE,
		Offline = FRIENDS_TEXTURE_OFFLINE,
		DND = FRIENDS_TEXTURE_DND,
		AFK = FRIENDS_TEXTURE_AFK,
	},
	Square = {
		Online = "Interface\\AddOns\\"..AddOnName.."\\Textures\\StatusIcons\\Square\\Online",
		Offline = "Interface\\AddOns\\"..AddOnName.."\\Textures\\StatusIcons\\Square\\Offline",
		DND = "Interface\\AddOns\\"..AddOnName.."\\Textures\\StatusIcons\\Square\\DND",
		AFK = "Interface\\AddOns\\"..AddOnName.."\\Textures\\StatusIcons\\Square\\AFK",
	},
	D3 = {
		Online = "Interface\\AddOns\\"..AddOnName.."\\Textures\\StatusIcons\\D3\\Online",
		Offline = "Interface\\AddOns\\"..AddOnName.."\\Textures\\StatusIcons\\D3\\Offline",
		DND = "Interface\\AddOns\\"..AddOnName.."\\Textures\\StatusIcons\\D3\\DND",
		AFK = "Interface\\AddOns\\"..AddOnName.."\\Textures\\StatusIcons\\D3\\AFK",
	},
}