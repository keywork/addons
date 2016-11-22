local mod	= DBM:NewMod("Bookshelf", "DBM-Bookshelf")

mod:RemoveOption("HealthFrame")
mod:AddBoolOption("PlaySound", true)

mod:RegisterEvents(
	"CHAT_MSG_MONSTER_SAY"
)

function mod:CHAT_MSG_MONSTER_SAY(msg)
	if msg == "This will only take a moment." and self.Options.PlaySound then
		PlaySoundFile("Interface\\AddOns\\DBM-Bookshelf\\sounds\\TP_Secret.ogg")
	end
end