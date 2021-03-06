local AceLocale = LibStub:GetLibrary("AceLocale-3.0")
local L = AceLocale:NewLocale("ElvUI", "zhCN")
if not L then return end

L["Add Group"] = "添加光环组" 
L["Attempted to show a reminder icon that does not have any spells. You must add a spell first."] = "尝试显示一个提示但没有任何技能. 你必须先添加一个技能." 
L["Change this if you want the Reminder module to check for weapon enchants, setting this will cause it to ignore any spells listed."] = "改变Buff提示模块来检查武器附魔, 设置这个将导致它忽略所有的技能列表." 
L["Combat"] = "战斗" 
L["Disable Sound"] = "禁用警报音" 
L["Don't play the warning sound."] = "不播放警报提示音." 
L["Group already exists!"] = "组已经存在!" 
L["Remove Group"] = "删除组" 
L["Select Group"] = "选择组" 
L["Role"] = "职责" 
L["Caster"] = "施法者" 
L["Any"] = "任意" 
L["Spell"] = "技能" 
L["Spells"] = "技能" 
L["New ID"] = "新技能ID" 
L["Remove ID"] = "移除技能ID" 
L["Personal Buffs"] = "自身施放的增益" 
L["If any spell found inside this list is found the icon will hide as well"] = "列表中的任何技能图标将会被隐藏" 
L["Inside BG/Arena"] = "战场/竞技场内" 
L["Inside Raid/Party"] = "团队或队伍内" 
L["Instead of hiding the frame when you have the buff, show the frame when you have the buff."] = "当你拥有此增益时显示, 没有时隐藏." 
L["Level Requirement"] = "等级需求" 
L["Level requirement for the icon to be able to display. 0 for disabled."] = "达到此等级才能显示. 设置为 0 禁用此功能." 
L["Negate Spells"] = "如已拥有下列增益则不显示" 
L["New ID (Negate)"] = "新技能ID (已拥有)" 
L["Only run checks during combat."] = "只在战斗中检查." 
L["Only run checks inside BG/Arena instances."] = "只在战场/竞技场中检查." 
L["Only run checks inside raid/party instances."] = "只在队伍/团队中检查." 
L['Only check if the buff is coming from you.'] = "只当增益是是你自身施放时检查." 
L["REMINDER_DESC"] = "缺失增益提醒设置." 
L["Remove ID (Negate)"] = "移除技能ID (已拥有)" 
L["Reverse Check"] = "逆向检查" 
L["Set a talent tree to not follow the reverse check."] = "设置一个不用遵守逆向检查的天赋." 
L["Sound"] = "警报音效" 
L["Sound that will play when you have a warning icon displayed."] = "当警告图标显示时播放声音." 
L["Strict Filter"] = "严格匹配" 
L["Talent Tree"] = "天赋" 
L["This ensures you can only see spells that you actually know. You may want to uncheck this option if you are trying to monitor a spell that is not directly clickable out of your spellbook."] = "这将保证只会显示你已经学会的技能. 如果你想监视一个你不会的技能, 你可以取消这个选项." 
L["Don't play the warning sound."] = "不播放警报提示音." 
L["Tree Exception"] = "天赋例外" 
L["Weapon"] = "武器" 
L["You can't remove a default group from the list, disabling the group."] = "你不能删除过滤器的预设组, 仅能禁用此预设组." 
L["You must be a certain role for the icon to appear."] = "你必需选择一个确定的职责来显示此图标." 
L["You must be using a certain talent tree for the icon to show."] = "你必需选择一个确定的天赋来显示此图标." 
L['CD Fade'] = "冷却过程透明度" 
L["Cooldown"] = "冷却CD" 
L['On Cooldown'] = "冷却CD时" 
L['Reminders'] = "缺失增益提醒" 