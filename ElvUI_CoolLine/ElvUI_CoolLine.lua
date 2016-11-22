local name, Backend = ...

function Backend:Install()
	StaticPopup_Show("ELVUICOOLLINE_FIRSTRUN")
	Backend.CLDB.font = self["Defaults"]["Font"]
end

Backend.OnAddOnLoaded = function(self)
	self:Skin()
	if not self.Config.Installed then
		self:Install()
		self.Config.Installed = true
	end
end