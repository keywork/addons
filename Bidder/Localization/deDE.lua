--[[
    Copyright Daniel D. Neilson, 2006

    This file is part of Bidder.

    Bidder is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    Bidder is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Bidder; if not, write to the Free Software
    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
]]

local L = AceLibrary("AceLocale-2.2"):new("Bidder")

local translations = {
   ["Bidder"] = "Bidder",

   -- Lootframe
   ["Bidding with name: |cff%s%s|r"] = "Biete als: |cff%s%s|r",

   -- Options table: Console commands
   ["query"] = "anfragen",
   ['Query the raid leaders for your current points.'] = 'Fragt den Schlachtzugleiter nach deinen aktuellen Punkten.',
   ["showdkp"] = "DKPzeigen",
   ["Browse your raid's DKP standings."] = "Zeigt die DKP des Raids.",
   ["show"] = "anzeigen",
   ["Show the bidding window."] = "Zeigt das Gebots-Fenster",
   ["togglestandby"] = "bereitschaft",
   ['Toggle whether you are on standby.'] = 'Setzt dich auf Bereitschaft bzw entfernt dich von der Bereitschaft.',
   ['modules'] = 'Module',
   ['List the DKP system modules you have installed.'] = 'Listet die installierten DKP-System Module auf.',
   ['Modules installed:'] = 'Installierte Module:',

   -- Options table: Fubar items
   ['Query points'] = 'Punkte erfragen',
   ['Query the raid leaders for your current points.'] = 'Fragt den Schlachtzugleiter nach deinen aktuellen Punkten.',
   ['Show DKP'] = 'DKP zeigen',
   ["Browse your raid's DKP standings."] = "Zeigt die DKP des Raids.",
   ['Show window'] = 'Gebotsfenster zeigen',
   ['Show the bidding window.'] = "Zeigt das Gebots-Fenster",
   ['Raid standby'] = 'Bereitschaft',
   ['Toggle whether you are on standby.'] = 'Setzt dich auf Bereitschaft bzw entfernt dich von der Bereitschaft.',

   -- Communications
   ["Communications command %s already registered."] = "Kommunikations Befehl %s ist bereits registriert.",
   ["Expected function for dispatchfunc, got %s instead."] = "Erwartete Funktion fÃ¼r dispatchfunc, bekam %s stattdessen.",
   
   -- Main:
   ["/bid"] = "/bid",
   ["/bidder"] = "/bidder",
   ["Database version changed. Migrating to new format."] = "Datenbankversion wurde ge\195\164ndert. Wechsle zum neuen Format.",
   ["Set your bidding name"] = "Name f\195\188rs Bieten:",
   ["Choose the name that you're going to use for bidding."] = "W\195\164hle den Namen unter dem deine Gebote eingehen.",

   -- DKP system registry
   ["Register DKP system -- DKP system with sysID %s does not inherit from the Bidder_DKP_BaseClass object"] = "DKP system registrieren -- DKP system mit sysID %s kann nicht vom Bidder_DKP_BaseClass Objekt erben",
   ["Register DKP system -- second arg must be a string or number"] = "DKP system registrieren -- Zweites Argument muss ein String oder eine Nummer sein",
   ["Register DKP system -- %s already registered."] = "DKP system registrieren -- %s ist bereits registriert.",
   ["DKP System %s not registered."] = "DKP System %s ist nicht registriert.",

   -- Fixed DKP module
   ["DKP Cost = %g"] = "DKP-Kosten = %g",
   ["Your DKP = %g"] = "Deine DKP = %g",
   ["Bid placed"] = "Gebot gesetzt",
   ["Fixed DKP"] = "Feste DKP",

   -- DKP browser
   ["Player"] = "Spieler",
   ["Class"] = "Klasse",
   ["Name"] = "Name",
   ["Primary sort key"] = "1. Sortierungspriorit\195\164t",
   ["Select the primary sorting key"] = "W\195\164hle die 1. Sortierungspriorit\195\164t",
   ['Secondary sort key'] = '2. Sortierungspriorit\195\164t',
   ['Select the secondary sorting key'] = "W\195\164hle die 2. Sortierungspriorit\195\164t",
   ['Teriary sort key'] = '3. Sortierungspriorit\195\164t',
   ['Select the teriary sorting key'] = "W\195\164hle die 3. Sortierungspriorit\195\164t",
   ['Classes to display'] = 'Anzuzeigende Klassen',
   ["Select the classes to display in the DKP standings"] = "W\195\164hle die Klassen deren DKP angezeigt werden sollen",
   ["Druid"] = "Druide", ["Show druids"] = "Zeige Druiden",
   ["Hunter"] = "J\195\164ger", ["Show hunters"] = "Zeige J\195\164ger",
   ["Monk"] = "Monk", ["Show monks"] = "Monks",
   ["Mage"] = "Magier", ["Show mages"] = "Zeige Magier",
   ["Paladin"] = "Paladin", ["Show paladins"] = "Zeige Paladine",
   ["Priest"] = "Priester", ["Show priests"] = "Zeige Priester",
   ["Rogue"] = "Schurke", ["Show rogues"] = "Zeige Schurken",
   ["Shaman"] = "Schamane", ["Show shaman"] = "Zeige Schamanen",
   ["Warlock"] = "Hexenmeister", ["Show warlocks"] = "Zeige Hexenmeister",
   ["Warrior"] = "Krieger",  ["Show warriors"] = "Zeige Krieger",
   ["Bidder: DKP Standings Browser"] = "Bidder: DKP Browser",
   ["right-click for options"] = "rechts-klick für optionen",
   ["Scroll Left"] = "Nach links scrollen", ["Scroll Right"] = "Nach rechts scrollen",
   ["Error -- received message to display DKP browser with wrong checksum (%g)"] = "FEHLER: Bekam die Aufforderung einen DKP Browser mit falscher Check-Summe (%g) zu zeigen",
   
   -- Utils
   ["Name not in database."] = "Name nicht in der Datenbank.",
}

L:RegisterTranslations("deDE",
		       function() return translations end)