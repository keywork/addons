﻿if GetLocale() == "deDE" then



function iclllocaleui()

arallbuttonmaint = "Zonenliste"
arallbuttontak = "Taktiken"
	areachatlist1 = "raid"
	areachatlist2 = "Raid Warnung"
	areachatlist3 = "Offizier"
	areachatlist4 = "Gruppe"
	areachatlist5 = "Gilde"
	areachatlist6 = "Sagen"
	areachatlist7 = "Schreien"
	areachatlist8 = "An sich selbst"
	
	ralldefaulttactic1 = "Es sind ca. 85 Zombies auf der gesamten Strasse zu Beginn. Folgendes ist notwendig:\n1. ersten Boss toeten\n2. den zweiten Boss zur Tuer des Gasthauses ziehen (er laesst sich nicht reinziehen, also nur bis zur Treppe bringen)\n3. es dauert 1-2 Minuten bis die Zombies wieder aufstehen, dann erst den Boss toeten\n4. sprecht Arthas an, saeubert das Gasthaus, toetet den dritten Boss und sprecht wieder mit Arthas um das Buecherregal zu oeffnen\n5. ein bis zwei DDs gehen zurueck zu der Treppe wo ihr den zweiten Boss getoetet habt, der Rest der Gruppe geht weiter\n6. beginnt gleichzeitig die Zombies in beiden Zonen zu toeten bis ihr den Erfolg erhaltet (ggf. vorher die Zombies sammeln)"
	ralldefaulttactic10 = "Der Boss beginnt bei ca. 50% Schlick Gegner zu spawnen und hoert bei 25% wieder damit auf. Wartet bis die kleinen Schlick zu Eisenschlick werden und toetet diese in der benoetigten Anzahl"
	ralldefaulttactic11 = "Permafrost stackt alle 2 bis 3 Sekunden. Wenn Ihr euch hinter den Steinbrocken versteckt wird der Stack entfernt.\nDie zweite Moeglichkeit ist das dispellen oder den Boss schnell mit massiv-DPS zu toeten"
	ralldefaulttactic12 = "Du musst durch den Eistunnel ohne das ein Mitglied eurer Gruppe von den Eisspitzen getroffen wird.\nDie Eisspitzen werden durch blaue Kreise am Boden deutlich gekennzeichnet, ca. 5 Sekunden bevor sie am Boden aufschlagen"
	ralldefaulttactic13 = "Wenn Ihr die letzte Strasse vor Mal'Ganis gesaeubert habt erreicht Ihr ein Gebiet wo die Seuche noch nicht ist. Nun gibt es zwei Wege, entweder Ihr geht direkt zum Boss Mal'Ganis ODER Ihr geht nach links in die Seitenstrasse. Wenn Ihr im Zeitrahmen liegt steht dort der Boss."
	ralldefaulttactic14 = "Beschreibung: Ca. alle 30 Sekunden visiert der Boss einen aus der Gruppe an und kanalisiert einen Zauber der ein Verderbtes Seelenfragment spawnen laesst. Ihr muesst soweit wie moeglich vom Boss weg laufen, weil diese Seelenfragmente laufen zum Boss und wenn sie ihn beruehren, verschwinden sie. Wenn der Boss unter 35% ist, teleportiert er sich in die Mitte vom Raum und bewegt sich nicht mehr.\nTaktik: Zieht Ihn auf die Platform außerhalb des Raumes, so das die 4 Seelen einen langen Weg haben wenn er sich zurueck teleportiert. Dann toetet ihr schnell den Boss. Die Seelenfragmente koennen verlangsamt werden (z.b Eisfalle etc.)"
	ralldefaulttactic15 = "Ihr muesst ein Rotation machen in dem Ihr den 'Phantomschlag' unterbrecht"
	ralldefaulttactic16 = "Boss wird 45 Sekunden nach Kampfbeginn immun, wartet und toetet Ihn ohne die Chaotischen Risse anzugreifen (Achtung mit AoE)"
	ralldefaulttactic17 = "Individueller Erfolg. Eiskaelte stackt auf jedem Spieler alle 2 Sekunden. Bewegung unterbricht diesen Effekt. Wenn Ihr stehen laenger als 5 Sekunden ohne Bewegung stehen bleibt ist der Erfolg fehlgeschlagen. Achtung! - Keristrasza hat eine Faehigkeit die einen Spieler fuer 10 Sekunden einfriert, dieser Zauber kann bzw. muss dispellt werden."
	ralldefaulttactic18 = "Beschreibung: Der zweite Boss wird zufaellig gewaehlt."
	ralldefaulttactic19 = "Beschreibung: 'Hammer der Gerechtigkeit' - Betaeubt einen Gegner und verhindert die Bewegung oder Angriffsmoeglichkeit fuer 6 Sekunden.\n'Hammer der Rechtschaffenheit' - erzeugt einen Hammer der einen Gegner mit 14000 Heiligschaden trifft, wenn das Ziel NICHT vom 'Hammer der Gerechtigkeit' betroffen ist, kann dieser Hammer abgefangen und zurueck zum Caster geschickt werden.\nTaktik: Bringt den Boss auf ca. 25K Lebenspunkte, wartet bis er jemanden stunnt, dispellt den Stun und auf der Spielerleiste erscheint die Faehigkeit 'Hammer zurueck werfen!' - Benutzt diese!"
	ralldefaulttactic2 = "Stellt euch auf die Treppe und fangt alle Gegner die von Oben kommen ab. Wenn das Schild gebrochen ist, kommen keine Gegner mehr von der Treppe und Ihr koennt den Boss toeten."
	ralldefaulttactic20 = "Toetet die Ghule oder kitet den Boss wenn diese anfangen die Explosion zu zaubern."
	ralldefaulttactic21 = "\"Frostgrab\" - umschliesst das Ziel mit einem Block aus Eis. Toetet den Boss ohne Frostgraeber zu zerstoeren. Das Frostgrab wird auf zufaellige Spieler gezaubert."
	ralldefaulttactic22 = "Es befinden sich zwei Huenen der Geissel, einen davon benoetigt ihr. Bei 50% beginnt der Boss das Ritual zu zaubern. Den Huenen auf die Position bringen wo das Schwert von oben herunter kommt und durch die Explosion toeten lassen. Vorher den Huenen bis zu einem gewissen Punkt Lebenspunkte abziehen, so das er durch die Explosion stirbt.\nSonst unmittelbar nach der Explosion erst den Huenen toeten (aktiver Debuff auf dem Huenen)"
	ralldefaulttactic23 = "Um Grauf zu toeten muesst ihr 3 Harpunen moeglichst zeitnah auf ihn abschiessen."
	ralldefaulttactic24 = "Wenn Ihr den Boss nicht schnell genug toetet, zaubert er \"Bann\" auf sich selbst. Einfach den Boss vor dem Zauber toeten."
	ralldefaulttactic25 = "Toetet die Sekretkugeln bevor sie sich mit dem Boss vereinen.\nTip: Die Schalter koennen auch benutzt werden um die Verteidigungsmechanismen zu aktivieren"
	ralldefaulttactic26 = "Verhindert das Gegner das Gefaengnissiegel erreichen ohne die Verteidigungsmechanismen (Schalter) zu benutzen."
	ralldefaulttactic27 = "Jedes Mal wenn Ihr die Instanz betretet, werden lediglich 2 von 6 Bossen zufaellig erscheinen."
	ralldefaulttactic28 = "Beschreibung: Wenn ein Waechter der Ahn'kahar nahe am Boss ist, wird der Boss immun gegen jeglichen Schaden.\nTaktik: Den Waechter oder den Boss kiten, so dass beide nicht in Reichweite zueinander stehen. Dann einfach schnell den Boss toeten."
	ralldefaulttactic29 = "Den Boss toeten waehrend er mit einer elektrischen Ladung versehen ist."
	ralldefaulttactic3 = "Boss schnell toeten."
	ralldefaulttactic30 = "Den Boss toeten bevor 4 Golems erschaffen wurden."
	ralldefaulttactic31 = "In der zweiten Phase (Flugphase) wird Onyxia Tiefer Atem zaubern, bleibt aus dem Radius dieses Zaubers und nehmt keinen Schaden."
	ralldefaulttactic32 = "Bei 65% erreicht Onyxia die zweite Phase, wenn sie abhebt habt ihr 10 Sekunden Zeit in den Seiten die Eier mit den Welpen schluepfen zu lassen."
	ralldefaulttactic33 = "Gormok der Pfaehler schmeisst Schneekobolde auf die Spieler. Toetet %s nicht von ihnen und killt anschliessend den Eisheuler in der letzten Phase."
	ralldefaulttactic34 = "Wenn der Boss 35% erreicht gibt es keine Untertauchphase und keine Schwaerme mehr. Wartet bis Ihr genug Skarabaen zusammen habt und toetet sie gleichzeitig."
	ralldefaulttactic35 = "Individueller Erfolg. Ihr muesst dem AoE Schaden ausweichen, nicht den Flammenwaenden.\nAlternative: Sterbt bevor der AoE Schaden auftritt. Damit bekommt ihr den Erfolg automatisch."
	ralldefaulttactic36 = "In der zweiten Phase (nachdem der Boss 50% erreicht hat) erscheinen einige Gegner auf fliegenden Scheiben. Wenn einer dieser Gegner getoetet wird hinterlaesst er diese Scheibe, aufsteigen und einen anderen Gegner in der Luft toeten."
	ralldefaulttactic37 = "Hier gibt es zwei Moeglichkeiten den Erfolg zu erhalten:\n1. Keine Adds toeten\n2. Adds toeten wenn sie weit genug vom Boss entfernt sind (kiten)"
	ralldefaulttactic38 = "Beschreibung: Thaddius zaubert 'Polaritaetswechsel': Er zaubert eine positive oder negative Ladung auf alle nah stehenden Spieler (Debuff). Spieler mit der identischen Aufladung erhoehen ihren Schaden. Spieler mit verschiedenen Aufladungen verursachen Schaden und lassen den Erfolg fehlschlagen.\nTaktik: Den Raid in zwei Gruppen aufteilen (+ und -), wenn die Polaritaet gewechselt wird muessen die Spieler die Gruppen wechseln/laufen je nachdem welchen Debuff sie erhalten haben"
	ralldefaulttactic39 = "In der ersten Phase muesst ihr die Add von Kel'Thuzad fernhalten und die benoetigte Anzahl toeten."
	ralldefaulttactic4 = "Toetet die benoetigte Anzahl an Raptoren waehrend des Bosskampfes."
	ralldefaulttactic40 = "Waehrend des Bosskampfes werden Knochenstacheln auf die Spieler gezaubert (1 im 10er, 3 im 25er Modus). Diese Stacheln muessen schnell getoetet werden."
	ralldefaulttactic41 = "Der Boss ruft in der ersten Phase verschiedene Typen von Adds und transformiert diese. Seid sicher das Ihr 5 verschiedene Adds am leben lasst bevor ihr in die zweite Phase eintretet.\nHinweis: Machterfuellter Kultist zaehlt nicht!"
	ralldefaulttactic42 = "Betretet das gegnerische Luftschiff nicht mehr als ein mal."
	ralldefaulttactic43 = "Gassporen spawnen drei Mal bevor der AoE vom Boss den Stack resetted. Wenn die Spore explodiert bekommt jeder einen Stack Impfung (25% Schattenwiderstand). Ihr duerft nicht 3 Stacks davon erhalten.\nTaktik: Die ersten beiden Spieler die die Sporen erhalten, sind die einzigen die den Debuff Impfung bekommen. Diese bleiben von den anderen Spielern fern und unterbinden so die Impfung. Bei den zwei weiteren Malen bekommen ALLE Spieler die Impfung AUSSER den beiden die als erstes den Debuff erhalten haben."
	-- ralldefaulttactic43a = "Gas Spores will spawn three times before boss AoE that reset stacks. When the spore explode it gives everyone 1 stack of Inoculated (25% shadow resistance). Just don't get 3 stacks. The best strategy - to have each of the first 3 people who get the spores be the only ones to get the debuff. However, the second time around, you need to have everyone EXCEPT the first 3 get inoculated"
	-- ralldefaulttactic44 = "Boss casts debuff on a random player, it spawns a little ooze when despelled or ends, when two little oozes are close to each other - they will transform in a big ooze. The big will explode and fail achievement if it consumes 5 little oozes. So kill boss quick and don't merge oozes"
	-- ralldefaulttactic45 = "\"Regurgitated Ooze\" - The Regurgitated Ooze has a surprising effect on the target, slowing its movement speed by 50% and dealing 6338 to 6662 damage every 2 sec for 20 sec. Kill adds without using this ability"
	-- ralldefaulttactic46 = "Usual this damage gets the Keleseth`s tank, he should have many \"Dark Nucleus\" on him to avoid big damage"
	ralldefaulttactic47 = "Der Erfolg wird erreicht wenn JEDES entstandene Portal von irgendeinem Spieler benutzt wird. Das Addon prueft den Erfolg NICHT im heroischen Modus!"
	-- ralldefaulttactic48 = "\"Mystic Buffet\" - Buffets all nearby foes with magic every 6 sec., increasing magical damage taken by 10% per application. To reset stacks you have to get LOS from boss using Ice Tombs. It's difficult for tanks, their rotation is quite complicated"
	ralldefaulttactic5 = "Greift den Boss an bevor er hoch kommt und die Tuer versperrt."
	-- ralldefaulttactic50 = "Vile Spirit will join battle on a 3rd phase (<40%), just nuke them quick and kite. They explode when get close to raiders"
	ralldefaulttactic51 = "Dieser Erfolg ist solo machbar. Zieht so viele Stahlgeschmiedeter Verteidiger wie Ihr koennt und toetet diese."
	-- ralldefaulttactic52 = "Individual achievement. Demolisher Passengers can be launched onto the Flame Leviathan, where they can kill Defense Turrets, to get the achievement you have to make a killing blow"
	-- ralldefaulttactic53 = "Players can be launched onto the Flame Leviathan from the Demolisher vehicles to take out its turrets. Taking out all turrets activates Overload Circuit, which stuns the Leviathan, makes him take 50% more damage and clears the entire stack of Gathering Speed. This achievement requires the raid to ignore this mechanic"
	-- ralldefaulttactic55 = "The Iron Constructs adds can gain the buff Heat by standing in the fire left by Ignis' Scorch. Once Heat reaches 10 stacks, the Constructs gain the buff Molten, which lasts for 20 seconds. If within this time frame they are kited to a pool of water they will loose the Molten buff and instead become Brittle for 15 seconds. A single blow dealing 5000 or more damage to a Brittle Construct will shatter it, causing an explosion. Doing this last step to 2 or more Constructs within a 5 second window will grant this achievement"
	-- ralldefaulttactic56 = "Use Single Target DPS (avoid DoT effects) and bring all the Dark Rune Guardians down to less than 15,000 HP. Right before the ground phase ends Razorscale will Flame Breath the area directly in front of him. The counter does not reset at all"
	ralldefaulttactic57 = "50% Bossleben in zweiter Bodenphase."
	ralldefaulttactic58 = "Die Erfolgsbeschreibung ist nicht korrekt, es ist schwierig zu verstehen wann es fehlschlaegt."
	ralldefaulttactic59 = "Die XS-013 Bots duerfen den X-002 nicht erreichen. Diese Bots werden waehrend der ausgeworfenen Herzphase gespawnt (im 25% HP Intervall). Sie ignorieren Aggro und bewegen sich auf den X-002 automatisch zu. Sie koennen verlangsamt oder gewurzelt werden."
	ralldefaulttactic6 = "Die Schlangen duerfen niemand fuer laengere Zeit angreifen. Entweder die Schlangen mit AoE toeten oder den Boss schnell erledigen."
	-- ralldefaulttactic60 = "Every 25% HP interval, X-002 Deconstructors heart becomes exposed and adds are spawned, amongst them some XE-321 Boombots and many XS-013 Scrapbots which will move towards X-002. When XE-321 Boombots are killed they explode dealing damage to everything near them"
	-- ralldefaulttactic61 = "Requires the player to be under the effect of the Iron Boot Flask when the last of the tree Iron Council bosses is killed. The flask can be purchased in Storm Peaks from Olut Alegut (H) or Rork Sharpchin (A)"
	-- ralldefaulttactic62 = "Everyone stand in melee range, except 3 rangers, they will kite Focused Eye Beam"
	ralldefaulttactic63 = "Toetet die Arme und wartet auf den Respawn. Jeglichen Schaden auf den Boss vermeiden!"
	ralldefaulttactic64 = "Bringt den Boss auf %s HP, toetet dann beide Arme gleichzeitig"
	-- ralldefaulttactic65 = "The Feral Defender spawns after 1 minute and begins the fight with 8 stacks of Feral Essence. He can revive himself at the cost of 1 stack, so getting this achievement requires killing the Defender 9 times. Be ready to kill boss after last add's life, enrage will be near"
	-- ralldefaulttactic66 = "Individual achievement. Storm Power buffs a player for 30 seconds regardless of where he stands, but the Toasty Fire and Starlight buffs appear to be limited to a random location, you have to get all that 3 buffs"
	-- ralldefaulttactic67 = "Kill all Flash Freeze that will spawn on NPC"
	-- ralldefaulttactic68 = "All raid members must avoid every Flash Freeze by standing on Snowdrifts. They are spawned after an Icicle fell on the ground"
	-- ralldefaulttactic69 = "Do not allow a single raid member to get more then 2 stacks of Biting Cold while killing Hodir. Biting Cold stack size increase on the entire raid over time and each stack causes damage over time. Both movement and proximity to the Toasty Fires created by the mage adds will lower the amount of stacks. The dispelable close range Freeze and the avoidable Flash Freeze complicate using movement to clear the stack"
	ralldefaulttactic7 = "Unterbrecht die \"Transformation\" Zauber. Die Zauberzeit wird bei abnehmenden Lebenspunkten schneller."
	-- ralldefaulttactic70 = "You have 3 min to kill boss before he shatters his rare cache"
	-- ralldefaulttactic71 = "Once the raid has completed the gauntlet and engaged Thorim, he will cast Lightning Charge every 15 seconds. It appears to be a cone based attack originating at Thorim and aimed at a lightning orb surrounding the arena"
	-- ralldefaulttactic72 = "Both of these adds are encountered by the raid group that goes through the gauntlet. But all raid members will earn this achievement once you kill boss"
	-- ralldefaulttactic73 = "The Dark Rune Warbringer - NPC that is spawned during the first phase, he gives the \"Aura\" of Celerity aura. This NPC will have to be \"Mind controlled\" to buff the party with this aura at the time Thorim is defeated. The aura radius is 40 yards"
	ralldefaulttactic74 = "Es gibt 6 Wellen von Gegnern. Toetet 5 Wellen und dann den Boss waehrend die letzte Welle am Leben bleibt."
	-- ralldefaulttactic75 = "The entire raid must avoid the Proximity Mines from phase 1 and 4, the Rocket Strikes from phases 2 and 4 and the explosions of Bomb Bot adds from phase 3. The achievement can be done in increments, so avoiding all Bomb Bots will complete that condition and allow the raid to focus more on Proximity Mines or Rocket Strikes for the next week"
	-- ralldefaulttactic76 = "One of the Assault Bots from 3 phase must be left alive for phase 4. In Phase 4, Mimiron again casts the lethal Rocket Strike at a location, preceded by a 3 second visible warning. Kite the Assault bot into this small area"
	-- ralldefaulttactic77 = "Hard-mode. Don't kill any Saronite Crystals, wait when they transforms into Saronite Animus, kill him and after that - defeat boss"
	ralldefaulttactic78 = "Benutzt das /kuessen Emote auf Sara in Phase 2 des Yogg-Saron Bosses.\nMacro: /tar Sara\n/kuessen"
	ralldefaulttactic79 = "Waehrend Phase 2 werden Portale neben Yogg geoeffnet. Wenn Du hinein gehst, bist Du in einer von drei Visionen."
	-- ralldefaulttactic8 = "In order to get the Residue debuff, you need to be hit by Eck's frontal cone ability: Eck Spit. After that kill last boss, without dying"
	-- ralldefaulttactic80 = "You start the fight with 100% sanity, which goes down when hit by his abilities. During the fight, Sanity Wells will spawn, which are used to restore some of your sanity over time when you stand near them (only if you ask Freya to help you). When a person reaches 0% sanity, they become mind controlled by Yogg-Saron till either one of them dies"
	-- ralldefaulttactic81 = "Black Holes are formed when Collapsing Stars die. This achievement refer to the closing of Black Holes by kiting the Living Constellations into them simultaneously"
	-- ralldefaulttactic82 = "Each time Lumbering Oaf uses his charge ability on a player, random number of Mine Rats spawn around the lumber pile which the player was smashed into."
	-- ralldefaulttactic83 = "You need to kill the boss on the first try and avoid the reaper to take any damage during trash (maybe BUG) and bossfight to get this achievement (reaper is immune to fire damage - boss adds)"
	-- ralldefaulttactic84 = "Individual achievement. Boss casts fire wall during all second phase"
	-- ralldefaulttactic85 = "After each 'Asphyxiate' boss channels his heal 'Stay of Execution' interrupt it immediately"
	-- ralldefaulttactic86 = "Adds (not boss) cast 'Unholy Empowerment' - interrupt all their casts"
	-- ralldefaulttactic87 = "When adds come - make one of them get into Geyser. No need to kill Boss to get this achievment"
	-- ralldefaulttactic88 = "Don't kill the Unyielding Behemoth until you get Tidal Surge effect on 3rd phase"
	ralldefaulttactic89 = "Lasst einen Zeloten nach dem anderen erscheinen und toetet sie bevor Sie euren Tank toeten. Danach den Boss toeten. Die Zeloten erscheinen wenn ein keiner im Strahl steht (100er Stack bei Spielern).\nZwei Spieler springen bei ca. 80 Stacks aus dem Strahl um das erscheinen des Zeloten zu verhindern. Bei einem Zeloten laesst man den Strahl durchlaufen.\nDas macht man dann mit allen drei nacheinander"
	-- ralldefaulttactic9 = "Actually, the impale spell won't be cast on the highest threat target, so you either need 2 tanks. Kill boss after all party players will get impaled"
	-- ralldefaulttactic90 = "Individual achievement. Jump when boss casts 'Static Cling' - so you don't get rooted by his ability, best way to get this achievement is to jump all the fight"
	-- ralldefaulttactic91 = "To get him affected, you must kill an affected Trogg Dweller near him. Attention: 'Modgud's Malice' - Increases damage done by 100%"
	-- ralldefaulttactic92 = "Achievement will be awarded to all party. There are more then 5 orbs in instance, you have to get only 5 of them. For example, 2 of them are above the platform of the 2nd boss, to get them - you have to use tornado during boss fight"
	-- ralldefaulttactic93 = "When you enter the 'spirit world' at 50%, a Dark Hatchling will spawn. Every few seconds, a soul fragment will spawn that channels a heal on the Dark Hatchling. Move them into the flame patches transforming them into Burning Souls. Kill 3 of then and you will get achieve without killing a boss!"
	ralldefaulttacticmain1 = "Addon wird dich im Chat informieren wann es moeglich ist den Boss zu toeten!"
	ralldefaulttacticmain2 = "Achtung: Begleiter oder Totems koennten den Erfolg fehlschlagen lassen."
	ralldefaulttacticmain3 = "Erfolg Fehlschlag wird zur Instanz ID gespeichert und du kannst es an diesem Tag nicht zurueck setzen"
	rallachievekologarnhp1 = "800K - 1 mio."
	rallachievekologarnhp2 = "3 mio - 4 mio"
	ralltitle2 = "Dieses  Modul informiert Dich ueber Erfolge in |cff00ff00aktueller Zone|r, wenn Du die Instanz betrittst. Es kann Dich auch daran erinnern welcher Boss ein notwendiges Kriterium fuer einen Erfolg ist. P.S. '|cffff0000Nicht verfolgt vom Addon|r' bedeutet das das Addon den aktuellen Erfolg nicht ueberprüfen und Dich nicht informieren kann wenn der Erfolg fehlschlaegt. '|cffff0000Nicht vom Boss|r' - dieses Kriterium ist kein Boss Kill, es muesste ein Objekt oder etwas anderes sein. Im aktuellen Frame siehst Du alle Gruppen-Erfolge die in dieser Zone verfuegbar sind."
	ralltxt1 = "Wenn Du eine Instanz betritts informiert es ueber:"
	ralltxt10 = "nur nicht abgeschlossene Erfolge fuer 'Ruhm des Helden/Schlachtzueglers'"
	ralltxt11 = "nur Erfolge die notwendig sind fuer 'Ruhm des Helden/Schlachtzueglers', inkl. bereits abgeschlossener"
	ralltxt12 = "Komplette Version - ALLE Erfolge die ich benoetige, inkl. Normal/Heroischen Boss Kills etc."
	ralltxt13 = "Komplette Version - ALLE Erfolge in dieser Zone"
	ralltxt2 = "nur nicht abgeschlossene Erfolge"
	ralltxt3 = "alle Erfolge, inkl. der bereits abgeschlossenen"
	ralltxt4 = "nur nicht abgeschlossene Erfolge fuer 'Ruhm des Helden/Schlachtzueglers'"
	ralltxt5 = "nur notwendige Erfolge fuer 'Ruhm des Helden/Schlachtzueglers', inkl. der bereits abgeschlossenen"
	ralltxt6 = "Komplette Version - ALLE Erfolge die ich benoetige, inkl. Normal/Heroischen Boss Kills etc."
	ralltxt7 = "Wenn Du den Boss anvisierst, informiert es:"
	ralltxt8 = "nur nicht abgeschlossene Erfolge"
	ralltxt9 = "alle Erfolge, inkl. der bereits abgeschlossenen"
	ralltxtoff = "(deaktiviert)"
	ralltxton = "(aktiviert)"
	rallzonenotfound = "Aktuelle Zone wurde in der Datenbank nicht gefunden."
	rallachiverepl1 = "Nicht abgeschlossene Erfolge in"
	rallachiverepl10 = "Komplette Liste der benoetigten Erfolge fuer 'Ruhm des Helden/Schlachtzueglers' in"
	rallachiverepl11 = "Benoetigte Erfolge fuer 'Ruhm des Helden/Schlachtzueglers' die NICHT in dieser Zone gefunden wurden."
	rallachiverepl12 = "Komplette Liste fuer nicht abgeschlossene Erfolge in"
	rallachiverepl13 = "Nicht abgeschlossene Erfolge fuer"
	rallachiverepl14 = "Liste aller Erfolge fuer"
	rallachiverepl15 = "Keine Erfolge mit den gesetzten Optionen fuer den aktuellen Boss gefunden."
	rallachiverepl16 = "Nicht abgeschlossene Erfolge fuer 'Ruhm des Helden/Schlachtzueglers'"
	rallachiverepl17 = "Komplette Liste der benoetigten Erfolge fuer 'Ruhm des Helden/Schlachtzueglers'"
	rallachiverepl18 = "Liste aller nicht abgeschlossenen Erfolge fuer"
	rallachiverepl19 = "Komplette Liste ALLER Erfolge in"
	rallachiverepl2 = "Du hast in dieser Zone alle Erfolge abgeschlossen."
	rallachiverepl3 = "Aktuelle Zone ist kein Raid oder heroische Instanz."
	rallachiverepl4 = "Liste aller Erfolge in"
	rallachiverepl5 = "Keinen Gruppen Erfolge für diese Zone in der Datenbank gefunden."
	rallachiverepl6 = "Erfolgueberwachung deaktiviert."
	rallachiverepl7 = "Mehr als 10 Erfolge gefunden (|cff00ff00%s|r). Vollstaendige Liste ist im Optionsfenster verfuegbar (/achr - Liste fuer Zone)"
	rallachiverepl8 = "Nicht abgeschlossene Erfolge fuer 'Ruhm des Helden/Schlachtzueglers' in"
	rallachiverepl9 = "Du hast alle Erfolge fuer 'Ruhm des Helden/Schlachtzueglers' in dieser Zone abgeschlossen."
	rallnoaddontrack = "Keine Addon Verfolgung"
	rallnotfromboss = "nicht vom Boss"
	rallmenutxt1 = "    Liste der verfuegbaren Erfolge in der aktuellen Zone"
	rallmenutxt2 = "    Liste der verfuegbaren Erfolge fuer gewaehlte Zone"
	rallmenutxt3 = "    Taktikten fuer Gruppen Erfolg"
	rallachdonel1 = "abgeschlossen"
	rallachdonel2 = "nicht abgeschlossen"
	rallsend = "Senden"
	rallwhisper = "fluestern:"
	rallbutton2 = "Waehle anderen Ort"
	ralltitle3 = "Dieses Modul zeigt die in dieser Zone verfuegbaren Erfolge. Du kannst diese Informationen in den Chat senden."
	ralltxt13 = "Komplette Version - ALLE Erfolge in dieser Zone"
	rallbutton3 = "<<< Zurueck zu den Einstellungen"
	rallmanualtxt1 = "Erweiterung:"
	rallmanualtxt2 = "Schwierigkeit:"
	rallmanualtxt3 = "Ort:"
	rallachiverepl19 = "Komplette Liste ALLER Erfolge in"
	ralltooltiptxt = "Zeige im Tooltip"
	ralltooltiptxt2 = "RA: %s gefundene Erfolge"
	ralltooltiptxt21 = "RA: Erfolge gefunden"
	ralltooltiptxt3 = "Mehr Infos: /raida"
	rallchatshowboss = "Zeige im Chat"
	ralltitle33 = "'Taktik: /raida' zeigt Taktiken im Chat fuer Erfolge die Schwierigkeiten machen koennten. Hier kannst Du alle Taktiken sehen, sie sind sehr nuetzlich wenn Du die Instanz das erste Mal betrittst. Du kannst den Text editieren und im Chat senden. Alle Aenderungen beziehen sich auf alle Charaktere.\nP.S Sende Deine Kommentare oder Taktiken and mich, so koennen sie im Addon anderen als Hilfe zur Verfuegung gestellt werden!\nP.S.2 Fehler in der deutschen Uebersetzung? Schreibe mich an um sie auf der Curse Projekt Seite korrigieren zu koennen!"
	ralltactictext1 = "Waehle Erfolg:"
	ralltactictext2 = "benoetige Taktik"
	ralltactictext3 = "Taktik: /raida"
	ralluilooktactic1 = "Zeige Taktiken"
	rallnotfoundachiv1 = "nicht abgeschlossene Erfolge wurden nicht gefunden"
	rallnotfoundachiv2 = "keine Erfolge"
	ralltacticbutsave1 = "Aenderungen uebernehmen"
	ralltacticbutsave2 = "Standard Taktiken wieder herstellen"
	ralluilooktactic3 = "|cffff0000Keine Taktik gefunden|r, vielleicht ist der Erfolg so leicht das er in der Beschreibung steht. Wenn Du Taktiken hinzufuegen moechtest |cff00ff00dann fuege hier den Text ein|r"
	ralluilooktactic4 = "Aenderungen wurden erfolgreich gespeichert."
	ralluilooktactic5 = "Taktik"
	ralldifparty = "Gruppe"
	ralldifraid = "Raid"



end


end