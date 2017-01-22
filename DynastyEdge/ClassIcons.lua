local ADDON_NAME, EDGE = ...;

local Icons = {}
EDGE.ClassIcons = Icons;

Icons.ROGUE = {
	['Assassination'] = 'Ability_Rogue_Eviscerate',
	['Outlaw'] = 'Ability_BackStab',
	['Subtlety'] = 'Ability_Stealth',
};

Icons.SHAMAN = {
	['Elemental'] = 'Spell_Nature_Lightning',
	['Enhancement'] = 'Spell_Nature_LightningShield',
	['Restoration'] = 'Spell_Nature_MagicImmunity',
};

Icons.MONK = {
	['Brewmaster'] = 'inv_drink_05',
	['Mistweaver'] = 'Ability_Monk_Summonserpentstatue',
	['Windwalker'] = 'pandarenracial_bouncy',
};

Icons.WARRIOR = {
	['Arms'] = 'Ability_Warrior_SavageBlow',
	['Fury'] = 'Ability_Warrior_InnerRage',
	['Protection'] = 'Ability_Warrior_DefensiveStance',
};

Icons.WARLOCK = {
	['Affliction'] = 'Spell_Shadow_DeathCoil',
	['Demonology'] = 'Spell_Shadow_Metamorphosis',
	['Destruction'] = 'Spell_Shadow_RainOfFire',
};

Icons.PALADIN = {
	['Holy'] = 'Spell_Holy_HolyBolt',
	['Protection'] = 'Ability_Paladin_ShieldoftheTemplar',
	['Retribution'] = 'Spell_Holy_AuraOfLight',
};

Icons.HUNTER = {
	['Beast Mastery'] = 'Ability_Druid_FerociousBite',
	['Marksmanship'] = 'Ability_Marksmanship',
	['Survival'] = 'INV_Misc_Net_01',
};

Icons.DRUID = {
	['Balance'] = 'Spell_Nature_StarFall',
	['Restoration'] = 'Spell_Nature_HealingTouch',
	['Feral'] = 'Ability_Druid_CatForm',
	['Guardian'] = 'Ability_Racial_BearForm',
};

Icons.MAGE = {
	['Arcane'] = 'Spell_Holy_MagicalSentry',
	['Fire'] = 'Spell_Fire_FireBolt02',
	['Frost'] = 'Spell_Frost_FrostBolt02',
};

Icons.PRIEST = {
	['Discipline'] = 'Spell_Holy_PowerWordShield',
	['Holy'] = 'Spell_Holy_GuardianSpirit',
	['Shadow'] = 'Spell_Shadow_ShadowWordPain',
};

Icons.DEATHKNIGHT = {
	['Blood'] = 'Spell_Deathknight_BloodPresence',
	['Frost'] = 'Spell_Deathknight_FrostPresence',
	['Unholy'] = 'Spell_Deathknight_UnholyPresence',
};

Icons.DEMONHUNTER = {
	['Havoc'] = 'ability_demonhunter_specdps',
	['Vengeance'] = 'ability_demonhunter_spectank',
};
