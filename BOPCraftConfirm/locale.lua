-- my custom locale file - more streamlined than AceLocale and no lib dependency

-- To help with missing translations please go here:
-- http://www.wowace.com/addons/bopcraftconfirm/localization/

local addonName, vars = ...
local Ld, La = {}, {}
local locale = GAME_LOCALE or GetLocale()

vars.L = setmetatable({},{
    __index = function(t, s) return La[s] or Ld[s] or rawget(t,s) or s end
})

Ld["Crafting this item will bind it to you."] = "Crafting this item will bind it to you."


if locale == "frFR" then do end
-- La["Crafting this item will bind it to you."] = ""

elseif locale == "deDE" then do end
-- La["Crafting this item will bind it to you."] = ""

elseif locale == "koKR" then do end
-- La["Crafting this item will bind it to you."] = ""

elseif locale == "esMX" then do end
-- La["Crafting this item will bind it to you."] = ""

elseif locale == "ruRU" then do end
-- La["Crafting this item will bind it to you."] = ""

elseif locale == "zhCN" then do end
-- La["Crafting this item will bind it to you."] = ""

elseif locale == "esES" then do end
-- La["Crafting this item will bind it to you."] = ""

elseif locale == "zhTW" then do end
La["Crafting this item will bind it to you."] = "製作此物品後會綁定在你身上。"

elseif locale == "ptBR" then do end
-- La["Crafting this item will bind it to you."] = ""

elseif locale == "itIT" then do end
-- La["Crafting this item will bind it to you."] = ""

end
