local ADDON_NAME, Impulse = ...;

local EventHandler = DynastyCore.EventHandler;
local GUI = Impulse.GUI;

EventHandler:Register('ADDON_LOADED',function(name)
	if name ~= ADDON_NAME then return end
	
	DynastyImpulse_GSaved = DynastyImpulse_GSaved or {};
	Impulse.GSaved = DynastyImpulse_GSaved;
	
	Impulse.GSaved.Sets = Impulse.GSaved.Sets or {};
	for i,set in pairs(Impulse.GSaved.Sets) do
		set.CanDelete = true;
		Impulse:AddSet(set);
	end
	
	GUI:Load();
	GUI:Update();
	
	return true;
end);

EventHandler:Register('DYNASTY_ADDON_SELECTED',function(addon)
	if addon == ADDON_NAME then
		GUI:Show();
	else
		-- hide self?
	end
end);

Impulse.Sets = {};
Impulse.ClassFilter = nil;
Impulse.Index = {};

function Impulse:AddSet(set)
	local key = set.Class..':'..set.Name;
	if Impulse.Index[key] then
		return print('Failed to load set, duplicate name.');
	end
	tinsert(self.Sets, set);
	Impulse.Index[key] = set;
end

-- Do not call this without ensuring the current set is saved
-- probably worth generating a set for undo.
function Impulse:LoadSet(set)
	for i = 131, 121, -1 do -- clear existing macros
		if GetMacroInfo(i) then
			DeleteMacro(i)
		end
	end
	for i,m in pairs(set.Macros) do
		if i > 18 then break end
		CreateMacro(m[1], "INV_MISC_QUESTIONMARK", m[3], 1);
	end
	for i = 1,120 do
		local a = set.Bars[i];
		PickupAction(i);
		ClearCursor();
		if a then
			if a[1] == 'spell' then
				PickupSpell(a[2]);
				--if select(4,GetCursorInfo()) ~= a[2] then
				--	print('failed.',i,unpack(a));
				--	return;
				--end
			elseif a[1] == 'macro' then
				PickupMacro(a[2]);
			elseif a[1] == 'item' then
				PickupItem(a[2]);
			elseif a[1] == 'summonmount' then
				if a[2] == 0x0FFFFFFF then -- random favorite
					C_MountJournal.Pickup(0);
				else
					for i = 1, C_MountJournal.GetNumDisplayedMounts() do
						if select(12, C_MountJournal.GetDisplayedMountInfo(i)) == a[2] then
							C_MountJournal.Pickup(i);
							break;
						end
					end
				end
			elseif a[1] == 'summonpet' then
				C_PetJournal.PickupPet(a[2]);
			end
			PlaceAction(i);
			ClearCursor();
		end
	end
	
	for i = 1, GetNumBindings() do
		local action,category,key1,key2 = GetBinding(i);
		--if set.CanDelete then -- for user created sets, clear the bindings.
			if key1 then SetBinding(key1) end
			if key2 then SetBinding(key2) end
		--end
	end
	
	for key,action in pairs(set.Binds) do
		SetBinding(key,action);
	end
	SaveBindings(GetCurrentBindingSet());
end

function Impulse:GenerateSet(name)
	local set = {
		Name = name or self:NextSetName(),
		Class = select(2,UnitClass('Player')),
		Created = date(),
		Creator = UnitName('Player')..'-'..GetRealmName(),
		Macros = {}, -- {name, icon, content}
		Bars = {}, -- {slot,value}
		Binds = {}, -- {key,value}
		CanDelete = true,
	};
	local key = set.Class..':'..set.Name;
	if Impulse.Index[key] then
		return false; -- duplicate set name
	end
	
	for i = 121, 120+select(2,GetNumMacros()) do
		tinsert(set.Macros,{GetMacroInfo(i)});
	end
	for i = 1, 120 do
		set.Bars[i] = {GetActionInfo(i)};
		if set.Bars[i][1] == 'spell' then -- make sure the spell isn't transformed.
			PickupAction(i);
			set.Bars[i][2] = select(4,GetCursorInfo()); -- real spell id.
			PlaceAction(i);
		end
	end
	for i = 1, GetNumBindings() do
		local action,category,key1,key2 = GetBinding(i);
		if key1 then set.Binds[key1] = action; end
		if key2 then set.Binds[key2] = action; end
	end
	tinsert(Impulse.GSaved.Sets, set);
	self:AddSet(set);
	return true;
end

function Impulse:DeleteSet(set)
	local key = set.Class..':'..set.Name;
	for i,s in pairs(self.GSaved.Sets) do
		if s == set then
			tremove(self.GSaved.Sets, i);
		end
	end
	for i,s in pairs(self.Sets) do
		if s == set then
			tremove(self.Sets, i);
		end
	end
	self.Index[key] = nil;
end

function Impulse:NextSetName()
	local spec = select(2,GetSpecializationInfo(GetSpecialization()));
	local class = select(2,UnitClass('Player'));
	for i = 1,99 do
		local name = spec..((i>1)and(' ('..i..')')or'');
		if not self.Index[class..':'..name] then
			return name;
		end
	end
	return '';
end
