local ADDON_NAME, NS = ...;

local Handler = {};
NS.EventHandler = Handler;

local tremove
	= tremove;

local r = {};
local frame = CreateFrame('Frame');
local Silenced = {};
Handler.Silenced = Silenced;

function Handler:Register(e,f)
	if not r[e] then
		r[e] = {};
	end
	r[e][#r[e]+1] = f;
	frame:RegisterEvent(e);
end

function Handler:Trigger(e,...)
	if Silenced[e] or not r[e] then return end
	local h = r[e];
	for i = #h,1,-1 do
		if h[i](...) then tremove(h,i) end
	end
	return #h == 0 and frame:UnregisterEvent(e);
end

frame:SetScript('OnEvent',Handler.Trigger)
frame:SetScript('OnUpdate',function(frame,...)
	Handler:Trigger('ON_UPDATE',...);
end)