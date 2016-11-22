if GetLocale() ~= "esES" and GetLocale() ~= "esMX" then return end
local L

---------------
-- Kurinnaxx --
---------------
L = DBM:GetModLocalization("Kurinnaxx")

L:SetGeneralLocalization{
	name 		= "Kurinnaxx"
}
------------
-- Rajaxx --
------------
L = DBM:GetModLocalization("Rajaxx")

L:SetGeneralLocalization{
	name 		= "General Rajaxx"
}
L:SetWarningLocalization{
	WarnWave	= "Oleada %s"
}
L:SetOptionLocalization{
	WarnWave	= "Mostrar aviso previo para la siguiente oleada"
}
L:SetMiscLocalization{
	Wave12		= "Ahí vienen. Intenta que no te maten,",--Followed by 'chico' or 'chica'
	Wave3		= "¡La hora de las recompensas está próxima! ¡Que la oscuridad gobierne el corazón de nuestros enemigos!",
	Wave4		= "¡No volveremos a esperar detrás de rejas y paredes de piedra! ¡Nunca más podrán negarnos nuestra venganza! ¡Hasta los dragones temblarán frente a nuestra ira!",
	Wave5		= "¡El miedo es para el enemigo! ¡Miedo y muerte!",
	Wave6		= "¡Corzocelada lloriqueará y rogará por su vida, igual que hizo su débil hijo! ¡Hoy acabará un milenio de injusticia!",
	Wave7		= "¡Fandral! ¡Ha llegado tu hora! ¡Ve y escóndete en el Sueño Esmeralda y reza para que nunca te encontremos!",
	Wave8		= "¡Loco imprudente! ¡Acabaré contigo yo mismo!"
}

----------
-- Moam --
----------
L = DBM:GetModLocalization("Moam")

L:SetGeneralLocalization{
	name 		= "Moam"
}

----------
-- Buru --
----------
L = DBM:GetModLocalization("Buru")

L:SetGeneralLocalization{
	name 		= "Buru el Manducador"
}
L:SetWarningLocalization{
	WarnPursue		= "Persiguiendo a >%s<",
	SpecWarnPursue	= "Buru te está persiguiendo",
	WarnDismember	= "%s en >%s< (%s)"
}
L:SetOptionLocalization{
	WarnPursue		= "Anunciar objetivos de la persecución de Buru",
	SpecWarnPursue	= "Mostrar aviso especial cuando te persiga el jefe",
	WarnDismember	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(96)
}
L:SetMiscLocalization{
	PursueEmote 	= "¡%s fija su mirada en %s!"
}

-------------
-- Ayamiss --
-------------
L = DBM:GetModLocalization("Ayamiss")

L:SetGeneralLocalization{
	name 		= "Ayamiss el Cazador"
}

--------------
-- Ossirian --
--------------
L = DBM:GetModLocalization("Ossirian")

L:SetGeneralLocalization{
	name 		= "Osirio el Sinmarcas"
}
L:SetWarningLocalization{
	WarnVulnerable	= "%s"
}
L:SetTimerLocalization{
	TimerVulnerable	= "%s"
}
L:SetOptionLocalization{
	WarnVulnerable	= "Anunciar debilidades",
	TimerVulnerable	= "Mostrar temporizador para la duración de las debilidades"
}