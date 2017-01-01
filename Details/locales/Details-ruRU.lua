local L = LibStub("AceLocale-3.0"):NewLocale("Details", "ruRU") 
if not L then return end 

L["ABILITY_ID"] = "ID способности"
L["STRING_ABSORBED"] = "Поглощено"
L["STRING_ACTORFRAME_NOTHING"] = "упс, нет данных для отчета :("
L["STRING_ACTORFRAME_REPORTAT"] = "на"
L["STRING_ACTORFRAME_REPORTOF"] = "от"
L["STRING_ACTORFRAME_REPORTTARGETS"] = "отчет для целей из"
L["STRING_ACTORFRAME_REPORTTO"] = "отчет для"
L["STRING_ACTORFRAME_SPELLDETAILS"] = "Подробнее о заклинании"
L["STRING_ACTORFRAME_SPELLUSED"] = "Все произнесенные заклинания"
L["STRING_AGAINST"] = "против"
L["STRING_ALIVE"] = "Живой"
L["STRING_ALPHA"] = "Альфа"
L["STRING_ANCHOR_BOTTOM"] = "Снизу"
L["STRING_ANCHOR_BOTTOMLEFT"] = "Снизу Слева"
L["STRING_ANCHOR_BOTTOMRIGHT"] = "Снизу Справа"
L["STRING_ANCHOR_LEFT"] = "Слева"
L["STRING_ANCHOR_RIGHT"] = "Справа"
L["STRING_ANCHOR_TOP"] = "Сверху"
L["STRING_ANCHOR_TOPLEFT"] = "Вверху Слева"
L["STRING_ANCHOR_TOPRIGHT"] = "Вверху Справа"
L["STRING_ASCENDING"] = "Восходящий"
L["STRING_ATACH_DESC"] = "Окно #%d группируется с окном #%d."
L["STRING_ATTRIBUTE_CUSTOM"] = "Вручную"
L["STRING_ATTRIBUTE_DAMAGE"] = "Урон"
L["STRING_ATTRIBUTE_DAMAGE_BYSPELL"] = "Урон, полученный от заклинаний"
L["STRING_ATTRIBUTE_DAMAGE_DEBUFFS"] = "Ауры и войдзоны"
L["STRING_ATTRIBUTE_DAMAGE_DEBUFFS_REPORT"] = "Урон и время действия дебаффов"
L["STRING_ATTRIBUTE_DAMAGE_DONE"] = "Нанесённый урон"
L["STRING_ATTRIBUTE_DAMAGE_DPS"] = "УВС"
L["STRING_ATTRIBUTE_DAMAGE_ENEMIES"] = "Получено урона врагом"
L["STRING_ATTRIBUTE_DAMAGE_ENEMIES_DONE"] = "Нанесено урона врагом"
L["STRING_ATTRIBUTE_DAMAGE_FRAGS"] = "Убийства"
L["STRING_ATTRIBUTE_DAMAGE_FRIENDLYFIRE"] = "Урон по союзникам"
L["STRING_ATTRIBUTE_DAMAGE_TAKEN"] = "Полученный урон"
L["STRING_ATTRIBUTE_ENERGY"] = "Ресурсы"
L["STRING_ATTRIBUTE_ENERGY_ENERGY"] = "Получено: Энергия"
L["STRING_ATTRIBUTE_ENERGY_MANA"] = "Получено: Мана"
L["STRING_ATTRIBUTE_ENERGY_RAGE"] = "Получено: Ярость"
L["STRING_ATTRIBUTE_ENERGY_RESOURCES"] = "Прочие ресурсы"
L["STRING_ATTRIBUTE_ENERGY_RUNEPOWER"] = "Получено: Сила рун"
L["STRING_ATTRIBUTE_HEAL"] = "Исцеление"
L["STRING_ATTRIBUTE_HEAL_DONE"] = "Исцеление"
L["STRING_ATTRIBUTE_HEAL_ENEMY"] = "Произведено исцеления врагом"
L["STRING_ATTRIBUTE_HEAL_HPS"] = "ИВС"
L["STRING_ATTRIBUTE_HEAL_OVERHEAL"] = "Избыточное исцеление"
L["STRING_ATTRIBUTE_HEAL_PREVENT"] = "Предотвращенный Урон"
L["STRING_ATTRIBUTE_HEAL_TAKEN"] = "Исцеления Получено"
L["STRING_ATTRIBUTE_MISC"] = "Разное"
L["STRING_ATTRIBUTE_MISC_BUFF_UPTIME"] = "Время действия баффов"
L["STRING_ATTRIBUTE_MISC_CCBREAK"] = "СС Прерывания"
L["STRING_ATTRIBUTE_MISC_DEAD"] = "Смерти"
L["STRING_ATTRIBUTE_MISC_DEBUFF_UPTIME"] = "Время действия дебаффов"
L["STRING_ATTRIBUTE_MISC_DEFENSIVE_COOLDOWNS"] = "Откаты"
L["STRING_ATTRIBUTE_MISC_DISPELL"] = "Рассеивания"
L["STRING_ATTRIBUTE_MISC_INTERRUPT"] = "Прерывания"
L["STRING_ATTRIBUTE_MISC_RESS"] = "Воскрешения"
L["STRING_AUTO"] = "авто"
L["STRING_AUTOSHOT"] = "Авто-Атака"
L["STRING_AVERAGE"] = "В среднем"
L["STRING_BLOCKED"] = "Заблокированно"
L["STRING_BOTTOM"] = "Снизу"
L["STRING_BOTTOM_TO_TOP"] = "Снизу вверх"
L["STRING_CAST"] = "Произнесено"
L["STRING_CCBROKE"] = "Спадение Контроля"
L["STRING_CENTER"] = "центр"
L["STRING_CENTER_UPPER"] = "Центр"
L["STRING_CHANGED_TO_CURRENT"] = "Сегмент изменен на текущий"
L["STRING_CHANNEL_RAID"] = "Рейд"
L["STRING_CHANNEL_SAY"] = "Сказать"
L["STRING_CHANNEL_WHISPER"] = "Шепнуть"
L["STRING_CHANNEL_YELL"] = "Крикнуть"
L["STRING_CLICK_REPORT_LINE1"] = "|cFFFFCC22Клик|r: |cFFFFEE00отчет|r"
L["STRING_CLICK_REPORT_LINE2"] = "|cFFFFCC22Shift+Клик|r: |cFFFFEE00режим окна|r"
L["STRING_CLOSEALL"] = "Все окна аддона закрыты. Напечатайте '/details new', чтобы снова их открыть."
L["STRING_COLOR"] = "Цвет"
L["STRING_COMMAND_LIST"] = "список команд"
L["STRING_COOLTIP_NOOPTIONS"] = "нет опций"
L["STRING_CRITICAL_HITS"] = "Критические попадания"
L["STRING_CURRENT"] = "Текущий"
L["STRING_CURRENTFIGHT"] = "Текущий сегмент"
L["STRING_CUSTOM_ACTIVITY_ALL"] = "Активный режим"
L["STRING_CUSTOM_ACTIVITY_ALL_DESC"] = "Показывает результаты активности каждого игрока в рейдовой группе"
L["STRING_CUSTOM_ACTIVITY_DPS"] = "Урон (Активный режим)"
L["STRING_CUSTOM_ACTIVITY_DPS_DESC"] = "Сообщает, сколько времени потратил каждый игрок на нанесение урона."
L["STRING_CUSTOM_ACTIVITY_HPS"] = "Исцеление (Активный режим)"
L["STRING_CUSTOM_ACTIVITY_HPS_DESC"] = "Сообщает, сколько времени потратил каждый игрок на исцеление."
L["STRING_CUSTOM_ATTRIBUTE_DAMAGE"] = "Урон"
L["STRING_CUSTOM_ATTRIBUTE_HEAL"] = "Исцеление"
L["STRING_CUSTOM_ATTRIBUTE_SCRIPT"] = "Пользовательский скрипт"
L["STRING_CUSTOM_AUTHOR"] = "Автор:"
L["STRING_CUSTOM_AUTHOR_DESC"] = "Кто создал этот Монитор."
L["STRING_CUSTOM_CANCEL"] = "Отменить"
L["STRING_CUSTOM_CREATE"] = "Создать"
L["STRING_CUSTOM_CREATED"] = "Новый Монитор создан."
L["STRING_CUSTOM_DAMAGEONANYMARKEDTARGET"] = "Урон по другим меткам "
L["STRING_CUSTOM_DAMAGEONANYMARKEDTARGET_DESC"] = "Показать полученный урон по целям с другими метками."
L["STRING_CUSTOM_DAMAGEONSKULL"] = "Урон по \"Черепу\""
L["STRING_CUSTOM_DAMAGEONSKULL_DESC"] = "Показать полученный урон целью с меткой \"Череп\""
L["STRING_CUSTOM_DESCRIPTION"] = "Описание:"
L["STRING_CUSTOM_DESCRIPTION_DESC"] = "Описание того, что делает данный Монитор."
L["STRING_CUSTOM_DONE"] = "Готово"
L["STRING_CUSTOM_DTBS"] = "Урон, полученный от заклинаний"
L["STRING_CUSTOM_DTBS_DESC"] = "Показать урон от вражеских заклинаний, полученный вашей группой "
L["STRING_CUSTOM_EDIT"] = "Редактировать"
L["STRING_CUSTOM_EDIT_SEARCH_CODE"] = "Изменить параметры поиска кода"
L["STRING_CUSTOM_EDIT_TOOLTIP_CODE"] = "Изменить код подсказки"
L["STRING_CUSTOM_EDITCODE_DESC"] = "Это продвинутая функция, где пользователь может создать свой собственный код Монитора."
L["STRING_CUSTOM_EDITTOOLTIP_DESC"] = "Это код подсказки, запускается, когда пользователь держит курсор над полосой. "
L["STRING_CUSTOM_ENEMY_DT"] = "Получено урона"
L["STRING_CUSTOM_EXPORT"] = "Экспортировать"
L["STRING_CUSTOM_HEALTHSTONE_DEFAULT"] = "Исцеляющие зелья и камни"
L["STRING_CUSTOM_HEALTHSTONE_DEFAULT_DESC"] = "Показать, кто в вашей рейдовой группе использовал исцеляющие камни и зелья"
L["STRING_CUSTOM_ICON"] = "Иконка:"
L["STRING_CUSTOM_IMPORT"] = "Импортировать"
L["STRING_CUSTOM_IMPORT_ALERT"] = "Монитор загружен - нажмите 'Импортировать' для подтверждения."
L["STRING_CUSTOM_IMPORT_BUTTON"] = "Импортировать"
L["STRING_CUSTOM_IMPORT_ERROR"] = "Импорт не удался - неверная строка"
L["STRING_CUSTOM_IMPORTED"] = "Этот Монитор успешно импортирован."
L["STRING_CUSTOM_LONGNAME"] = "Слишком длинное название - максимум 32 символа"
L["STRING_CUSTOM_MYSPELLS"] = "Мои заклинания"
L["STRING_CUSTOM_MYSPELLS_DESC"] = "Показывать ваши заклинания в окне."
L["STRING_CUSTOM_NAME"] = "Название:"
L["STRING_CUSTOM_NAME_DESC"] = "Введите название Вашего нового Монитора."
L["STRING_CUSTOM_NEW"] = "Управлять пользовательскими Мониторами"
L["STRING_CUSTOM_PASTE"] = "Вставить здесь:"
L["STRING_CUSTOM_POT_DEFAULT"] = "Использовано зелий"
L["STRING_CUSTOM_POT_DEFAULT_DESC"] = "Показать, кто из рейда использовал зелья во время боя"
L["STRING_CUSTOM_REMOVE"] = "Удалить"
L["STRING_CUSTOM_REPORT"] = "(пользовательский)"
L["STRING_CUSTOM_SAVE"] = "Сохранить изменения"
L["STRING_CUSTOM_SAVED"] = "Монитор сохранен."
L["STRING_CUSTOM_SHORTNAME"] = "Название должно состоять как минимум из 5 символов."
L["STRING_CUSTOM_SKIN_TEXTURE"] = "Файл пользовательского скина"
L["STRING_CUSTOM_SKIN_TEXTURE_DESC"] = [=[Название файла: .tga .

Файл должен быть размещен в папке:

|cFFFFFF00WoW/Interface/|r

|cFFFFFF00Важно:|r прежде, чем создать файл, закройте игровой клиент. После этого пропишите /reload для применения изменений, сохраненные в файле текстуры.]=]
L["STRING_CUSTOM_SOURCE"] = "Источник:"
L["STRING_CUSTOM_SPELLID"] = "ID Заклинания:"
L["STRING_CUSTOM_TARGET"] = "Цель:"
L["STRING_CUSTOM_TEMPORARILY"] = "(|cFFFFC000временно|r)"
L["STRING_DAMAGE"] = "Урон"
L["STRING_DAMAGE_DPS_IN"] = "Урон, полученный от "
L["STRING_DAMAGE_TAKEN_FROM"] = "Урон, полученный от"
L["STRING_DETACH_DESC"] = "Разорвать группирование окон"
L["STRING_DODGE"] = "Уклонение"
L["STRING_DOT"] = "(ДоТ)"
L["STRING_DPS"] = "УВС"
L["STRING_EMPTY_SEGMENT"] = "Пустой сегмент"
L["STRING_ENABLED"] = "Включить"
L["STRING_ENVIRONMENTAL_DROWNING"] = "Мир (утопление)"
L["STRING_ENVIRONMENTAL_FALLING"] = "Мир (падение)"
L["STRING_ENVIRONMENTAL_FATIGUE"] = "Мир (усталость)"
L["STRING_ENVIRONMENTAL_FIRE"] = "Мир (огонь)"
L["STRING_ENVIRONMENTAL_LAVA"] = "Мир (лава)"
L["STRING_ENVIRONMENTAL_SLIME"] = "Мир (слизь)"
L["STRING_ERASE"] = "удалить"
L["STRING_ERASE_DATA"] = "Сбросить все данные"
L["STRING_ERASE_DATA_OVERALL"] = "Сбросить всеобщие данные"
L["STRING_EXAMPLE"] = "Пример"
L["STRING_EXPLOSION"] = "взрыв"
L["STRING_FEEDBACK_SEND_FEEDBACK"] = "Отправить отзыв"
L["STRING_FEEDBACK_WOWI_DESC"] = "Оставить комментарий на странице проекта Details! "
L["STRING_FIGHTNUMBER"] = "Бой #"
L["STRING_FREEZE"] = "Этот сегмент недоступен в данный момент"
L["STRING_HEAL"] = "Исцеление"
L["STRING_HEAL_ABSORBED"] = "Исцеления поглощено"
L["STRING_HEAL_CRIT"] = "Критическое исцеление"
L["STRING_HITS"] = "Попадания "
L["STRING_HPS"] = "ИВС"
L["STRING_IMAGEEDIT_ALPHA"] = "Прозрачность"
L["STRING_IMAGEEDIT_DONE"] = "ГОТОВО"
L["STRING_INFO_TAB_AVOIDANCE"] = "Избегание"
L["STRING_INFO_TAB_COMPARISON"] = "Сравнить"
L["STRING_INFO_TAB_SUMMARY"] = "Суммарно"
L["STRING_INTERFACE_OPENOPTIONS"] = "Открыть панель настроек"
L["STRING_KEYBIND_BOOKMARK"] = "Закладка"
L["STRING_KEYBIND_BOOKMARK_NUMBER"] = "Закладка #%s"
L["STRING_KEYBIND_RESET_SEGMENTS"] = "Сбросить сегменты"
L["STRING_KEYBIND_SEGMENTCONTROL"] = "Сегменты"
L["STRING_LEFT"] = "слева"
L["STRING_LOCK_DESC"] = "Заблок. или разблок. окно"
L["STRING_LOCK_WINDOW"] = "заблок."
L["STRING_MAXIMUM_SHORT"] = "Макс"
L["STRING_MELEE"] = "Атака"
L["STRING_MEMORY_ALERT_BUTTON"] = "Я понял"
L["STRING_MEMORY_ALERT_TEXT1"] = "Details! использует много памяти, |cFFFF8800вопреки распространенному мнению|r, использование памяти аддоном |cFFFF8800не влияет|r на производительность игры или FPS."
L["STRING_MEMORY_ALERT_TEXT2"] = "Если вы видите, что Details! использует очень много памяти, не паникуйте :D - |cFFFF8800все в порядке!|r. Часть этой памяти |cFFFF8800используется в кэше|r, чтобы сделать аддон еще быстрее!"
L["STRING_MEMORY_ALERT_TEXT3"] = "Однако, если вы хотите узнать, |cFFFF8800какой аддон самый 'тяжелый'|r, или какие сильно влияют на ваш FPS, установите аддон:'|cFFFFFF00AddOns Cpu Usage|r'."
L["STRING_MEMORY_ALERT_TITLE"] = "Пожалуйста, прочитайте внимательно!"
L["STRING_MENU_CLOSE_INSTANCE"] = "Закрыть данное окно"
L["STRING_MENU_INSTANCE_CONTROL"] = "Управление Окном"
L["STRING_MINIMAP_TOOLTIP1"] = "|cFFCFCFCFлевый клик|r: открыть панель настроек"
L["STRING_MINIMAP_TOOLTIP11"] = "|cFFCFCFCFлевый клик|r: сбросить все сегменты"
L["STRING_MINIMAP_TOOLTIP12"] = "|cFFCFCFCFлевый клик|r: показать/скрыть окна"
L["STRING_MINIMAP_TOOLTIP2"] = "|cFFCFCFCFправый клик|r: быстрое меню"
L["STRING_MINIMAPMENU_CLOSEALL"] = "Закрыть всё"
L["STRING_MINIMAPMENU_NEWWINDOW"] = "Создать новое окно"
L["STRING_MINIMUM_SHORT"] = "Мин"
L["STRING_MINITUTORIAL_BOOKMARK1"] = "Щелкните правой кнопкой в любом месте в рамках окна, чтобы открыть закладки!"
L["STRING_MINITUTORIAL_BOOKMARK2"] = "Закладки предоставляют быстрый доступ к избранным мониторам."
L["STRING_MINITUTORIAL_BOOKMARK3"] = "Используйте правую клавишу мыши для закрытия панели закладок."
L["STRING_MINITUTORIAL_BOOKMARK4"] = "Не показывать это снова."
L["STRING_MINITUTORIAL_CLOSECTRL1"] = "|cFFFFFF00Ctrl + Правый клик|r закрывает окно!"
L["STRING_MINITUTORIAL_CLOSECTRL2"] = "Если вы захотите снова его открыть, перейдите в Меню -> Управление Окном или в Панель настроек."
L["STRING_MINITUTORIAL_OPTIONS_PANEL1"] = "Окно, которое будет отредактировано."
L["STRING_MINITUTORIAL_OPTIONS_PANEL2"] = "Проверьте, все окна в группе также будут изменены."
L["STRING_MINITUTORIAL_OPTIONS_PANEL3"] = [=[Чтобы создать группу, перетащите окно #2 к окну #1.

Чтобы разорвать группу, кликните по кнопке |cFFFFFF00разгруппировать|r.]=]
L["STRING_MINITUTORIAL_OPTIONS_PANEL4"] = "Проверьте свои настройки создания тестовых полос."
L["STRING_MINITUTORIAL_OPTIONS_PANEL5"] = "Когда Редактирование Группа включена, все окна в группе изменилось."
L["STRING_MINITUTORIAL_OPTIONS_PANEL6"] = "Выберите здесь, какое окно вы хотите изменить внешний вид."
L["STRING_MINITUTORIAL_WINDOWS1"] = [=[Вы только что создали группу окон.

Чтобы разорвать их, кликните под иконке с замочком.]=]
L["STRING_MINITUTORIAL_WINDOWS2"] = [=[Окно заблокировано.

Нажмите на заголовок и растяните его.]=]
L["STRING_MODE_ALL"] = "Всё и вся"
L["STRING_MODE_GROUP"] = "Стандартный"
L["STRING_MODE_PLUGINS"] = "плагины"
L["STRING_MODE_RAID"] = "Плагины: Рейд "
L["STRING_MODE_SELF"] = "Плагины: Одиночная игра"
L["STRING_NEWS_REINSTALL"] = "Обнаружили проблемы после обновления? Попробуйте команду '/details reinstall'."
L["STRING_NEWS_TITLE"] = "Что нового в данной версии"
L["STRING_NORMAL_HITS"] = "Обычные попадания"
L["STRING_NUMERALSYSTEM"] = "Система счисления"
L["STRING_NUMERALSYSTEM_ARABIC_MYRIAD_EASTASIA"] = "используется восточными странами Азии, разделяется на тысячи и мириады"
L["STRING_NUMERALSYSTEM_ARABIC_WESTERN"] = "Западная"
L["STRING_NUMERALSYSTEM_ARABIC_WESTERN_DESC"] = "наиболее распространённая, разделяется на тысячи и миллионы"
L["STRING_NUMERALSYSTEM_DESC"] = "Выберите систему счисления, которую будете использовать "
L["STRING_NUMERALSYSTEM_MYRIAD_EASTASIA"] = "Восточно-Азиатская "
L["STRING_OFFHAND_HITS"] = "Левая рука"
L["STRING_OPTIONS_3D_SELECT"] = "Выберите модель"
L["STRING_OPTIONS_ADVANCED"] = "Дополнительно"
L["STRING_OPTIONS_ALPHAMOD_ANCHOR"] = "Авто-скрытие:"
L["STRING_OPTIONS_ALWAYS_USE"] = "Использовать на всех персонажах"
L["STRING_OPTIONS_ANIMATEBARS"] = "Анимация полос"
L["STRING_OPTIONS_ANIMATEBARS_DESC"] = "Включить анимацию для всех полос."
L["STRING_OPTIONS_APPEARANCE"] = "Внешний вид"
L["STRING_OPTIONS_ATTRIBUTE_TEXT"] = "Настройки текста заголовка "
L["STRING_OPTIONS_ATTRIBUTE_TEXT_DESC"] = "Данные опции управляют текстом заголовка окна "
L["STRING_OPTIONS_AUTO_SWITCH"] = "Все роли |cFFFFAA00(в бою)|r"
L["STRING_OPTIONS_AUTO_SWITCH_COMBAT"] = "|cFFFFAA00(в бою)|r"
L["STRING_OPTIONS_AVATAR"] = "Выберите аватар"
L["STRING_OPTIONS_AVATAR_ANCHOR"] = "Личность:"
L["STRING_OPTIONS_AVATAR_DESC"] = "Аватары также отправляются членам гильдии, показываются в верхней части всплывающий подсказки и в окне 'Details! Игрока'."
L["STRING_OPTIONS_BAR_BCOLOR"] = "Фоновый цвет"
L["STRING_OPTIONS_BAR_COLORBYCLASS"] = "Цвет по классу игрока"
L["STRING_OPTIONS_BAR_COLORBYCLASS_DESC"] = "Если включено, данная текстура всегда использует цвет класса игрока"
L["STRING_OPTIONS_BAR_FOLLOWING"] = "Всегда показывать себя"
L["STRING_OPTIONS_BAR_HEIGHT"] = "Высота"
L["STRING_OPTIONS_BAR_HEIGHT_DESC"] = "Увеличить или уменьшить высоту полос."
L["STRING_OPTIONS_BAR_SPACING"] = "Расстояние"
L["STRING_OPTIONS_BAR_SPACING_DESC"] = "Расстояние между полосами"
L["STRING_OPTIONS_BARLEFTTEXTCUSTOM"] = "Включить пользовательский текст"
L["STRING_OPTIONS_BARORIENTATION"] = "Направление полос"
L["STRING_OPTIONS_BARORIENTATION_DESC"] = "Направление заполнения полос"
L["STRING_OPTIONS_BARRIGHTTEXTCUSTOM"] = "Включить пользовательский текст"
L["STRING_OPTIONS_BARS"] = "Основные настройки полос"
L["STRING_OPTIONS_BARS_CUSTOM_TEXTURE"] = "Файл пользовательской текстуры"
L["STRING_OPTIONS_BARS_CUSTOM_TEXTURE_DESC"] = " |cFFFFFF00Важно|r: изображение должно быть 256x32 пикселей."
L["STRING_OPTIONS_BARS_DESC"] = "Данные опции управляют внешний видом полос"
L["STRING_OPTIONS_BG_ALL_ALLY"] = "Показать всё"
L["STRING_OPTIONS_BG_ANCHOR"] = "Поля боя:"
L["STRING_OPTIONS_CHANGE_CLASSCOLORS"] = "Изменить цвета классов"
L["STRING_OPTIONS_CHANGE_CLASSCOLORS_DESC"] = "Выберите новые цвета классов"
L["STRING_OPTIONS_CHART_ADD"] = "Добавить данные"
L["STRING_OPTIONS_CHART_ADD2"] = "Добавить"
L["STRING_OPTIONS_CHART_ADDAUTHOR"] = "Автор:"
L["STRING_OPTIONS_CHART_ADDCODE"] = "Код:"
L["STRING_OPTIONS_CHART_ADDICON"] = "Иконка:"
L["STRING_OPTIONS_CHART_ADDNAME"] = "Имя:"
L["STRING_OPTIONS_CHART_ADDVERSION"] = "Версия:"
L["STRING_OPTIONS_CHART_AUTHOR"] = "Автор"
L["STRING_OPTIONS_CHART_AUTHORERROR"] = "Имя автора недействительно."
L["STRING_OPTIONS_CHART_CANCEL"] = "Отменить"
L["STRING_OPTIONS_CHART_CLOSE"] = "Закрыть"
L["STRING_OPTIONS_CHART_CODELOADED"] = "Код уже загружен и не может быть показан."
L["STRING_OPTIONS_CHART_EDIT"] = "Редактировать код"
L["STRING_OPTIONS_CHART_EXPORT"] = "Экспорт"
L["STRING_OPTIONS_CHART_FUNCERROR"] = "Функция недействительна."
L["STRING_OPTIONS_CHART_ICON"] = "Иконка"
L["STRING_OPTIONS_CHART_IMPORT"] = "Импорт"
L["STRING_OPTIONS_CHART_IMPORTERROR"] = "Строка импорта недействительна."
L["STRING_OPTIONS_CHART_NAME"] = "Имя"
L["STRING_OPTIONS_CHART_NAMEERROR"] = "Имя недействительно."
L["STRING_OPTIONS_CHART_REMOVE"] = "Удалить"
L["STRING_OPTIONS_CHART_SAVE"] = "Сохранить"
L["STRING_OPTIONS_CHART_VERSION"] = "Версия"
L["STRING_OPTIONS_CHART_VERSIONERROR"] = "Версия недействительна."
L["STRING_OPTIONS_CLASSCOLOR_MODIFY"] = "Изменить цвета классов"
L["STRING_OPTIONS_CLASSCOLOR_RESET"] = "Правый клик для сброса"
L["STRING_OPTIONS_COMBAT_ALPHA"] = "Когда"
L["STRING_OPTIONS_COMBAT_ALPHA_2"] = "В бою"
L["STRING_OPTIONS_COMBATTWEEKS"] = "Твики: Бой"
L["STRING_OPTIONS_COMBATTWEEKS_DESC"] = "Настройки поведения Details! в некоторых аспектах боя. "
L["STRING_OPTIONS_CONFIRM_ERASE"] = "Вы хотите сбросить данные?"
L["STRING_OPTIONS_CUSTOMSPELL_ADD"] = "Добавить заклинание"
L["STRING_OPTIONS_CUSTOMSPELLTITLE"] = "Редактировать настройки заклинания"
L["STRING_OPTIONS_DATABROKER_TEXT"] = "Текст"
L["STRING_OPTIONS_DEATHLIMIT"] = "Счетчик смертей"
L["STRING_OPTIONS_DEATHLIMIT_DESC"] = [=[Установить количество событий, отображаемых в мониторе смертей.

|cFFFFFF00Важно|r: относится только к новым смертям после применения.]=]
L["STRING_OPTIONS_DISABLE_ALLDISPLAYSWINDOW"] = "Отключить меню 'Все Мониторы'"
L["STRING_OPTIONS_DISABLE_GROUPS"] = "Отключить группирование"
L["STRING_OPTIONS_DISABLE_GROUPS_DESC"] = "Окна не будут создавать группы при размещении рядом друг с другом."
L["STRING_OPTIONS_DTAKEN_EVERYTHING"] = "Расширенный полученный урон"
L["STRING_OPTIONS_DTAKEN_EVERYTHING_DESC"] = "Полученный урон отображается в режиме 'Всё и вся'."
L["STRING_OPTIONS_ED"] = "Сброс данных"
L["STRING_OPTIONS_ED_DESC"] = [=[|cFFFFFF00Вручную|r: пользователю необходимо нажать на кнопку сброса.

|cFFFFFF00Уточнять|r: спрашивать о сбросе данных при входе в новое подземелье.

|cFFFFFF00Авто|r: сбрасывать данных после входа в новое подземелье.]=]
L["STRING_OPTIONS_ED1"] = "Вручную"
L["STRING_OPTIONS_ED2"] = "Уточнять"
L["STRING_OPTIONS_ED3"] = "Авто"
L["STRING_OPTIONS_EDITINSTANCE"] = "Редактирование Окна:"
L["STRING_OPTIONS_GENERAL"] = "Общие настройки"
L["STRING_OPTIONS_GENERAL_ANCHOR"] = "Общее:"
L["STRING_OPTIONS_IGNORENICKNAME"] = "Игнорировать никнеймы и аватары"
L["STRING_OPTIONS_IGNORENICKNAME_DESC"] = "Если включено, никнеймы и аватары, установленные другими членами гильдии, игнорируются"
L["STRING_OPTIONS_INSTANCE_ALPHA2"] = "Фоновый цвет"
L["STRING_OPTIONS_INSTANCE_ALPHA2_DESC"] = "Данная опция позволяет менять фоновый цвет окна"
L["STRING_OPTIONS_INSTANCE_BACKDROP"] = "Фоновая текстура"
L["STRING_OPTIONS_INSTANCE_COLOR"] = "Цвет окна"
L["STRING_OPTIONS_INSTANCE_DELETE"] = "Удалить"
L["STRING_OPTIONS_INSTANCE_SKIN"] = "Скин"
L["STRING_OPTIONS_INSTANCE_STATUSBAR_ANCHOR"] = "Строка состояния:"
L["STRING_OPTIONS_INSTANCE_STATUSBARCOLOR"] = "Цвет и прозрачность "
L["STRING_OPTIONS_INSTANCE_STATUSBARCOLOR_DESC"] = [=[Выбрать цвет используемый строкой состояния.

|cFFFFFF00Важно|r: данная опция перезаписывает цвет и прозрачность выбранные ранее для цвета Окна.]=]
L["STRING_OPTIONS_INSTANCES"] = "Окна:"
L["STRING_OPTIONS_LOCKSEGMENTS"] = "Заблокировать сегменты"
L["STRING_OPTIONS_MANAGE_BOOKMARKS"] = "Управление закладками"
L["STRING_OPTIONS_MAXINSTANCES"] = "Количество Окон"
L["STRING_OPTIONS_MAXINSTANCES_DESC"] = [=[Ограничить количество окон, которые можно создать. 

Вы сможете управлять окнами через меню 'Управление Окном'.]=]
L["STRING_OPTIONS_MENU_ATTRIBUTE_ANCHORX"] = "Позиция X"
L["STRING_OPTIONS_MENU_ATTRIBUTE_ANCHORY"] = "Позиция Y"
L["STRING_OPTIONS_MENU_ATTRIBUTE_ENCOUNTERTIMER"] = "Таймер боя"
L["STRING_OPTIONS_MENU_ATTRIBUTE_ENCOUNTERTIMER_DESC"] = "Когда включено, то показывается секундомер с левой стороны текста."
L["STRING_OPTIONS_MENU_ATTRIBUTE_FONT"] = "Шрифт текста"
L["STRING_OPTIONS_MENU_ATTRIBUTE_FONT_DESC"] = "Выберите шрифт текста"
L["STRING_OPTIONS_MENU_ATTRIBUTE_SHADOW_DESC"] = "Включение или выключение теней в тексте."
L["STRING_OPTIONS_MENU_ATTRIBUTE_TEXTCOLOR"] = "Цвет текста"
L["STRING_OPTIONS_MENU_ATTRIBUTE_TEXTSIZE"] = "Размера текста"
L["STRING_OPTIONS_MENU_ATTRIBUTESETTINGS_ANCHOR"] = "Настройки:"
L["STRING_OPTIONS_MENU_AUTOHIDE_LEFT"] = "Авто-скрытие кнопок"
L["STRING_OPTIONS_MENU_X"] = "Позиция X"
L["STRING_OPTIONS_MENU_Y"] = "Позиция Y"
L["STRING_OPTIONS_MINIMAP"] = "Показать значок"
L["STRING_OPTIONS_MINIMAP_ACTION"] = "По Клику"
L["STRING_OPTIONS_MINIMAP_ACTION_DESC"] = "Выберите, что будет происходить, когда значок у миникарты будет нажат левой кнопкой мыши."
L["STRING_OPTIONS_MINIMAP_ACTION1"] = "Открыть Панель настроек"
L["STRING_OPTIONS_MINIMAP_ACTION2"] = "Сбросить сегменты"
L["STRING_OPTIONS_MINIMAP_ACTION3"] = "Показать/скрыть Окна"
L["STRING_OPTIONS_MINIMAP_ANCHOR"] = "Миникарта"
L["STRING_OPTIONS_MINIMAP_DESC"] = "Показать или скрыть значок у миникарты."
L["STRING_OPTIONS_NICKNAME"] = "Никнейм"
L["STRING_OPTIONS_NICKNAME_DESC"] = [=[Настройте никнейм под себя.

Никнеймы отправляются членам гильдии и Details! использует их вместо имени персонажа.]=]
L["STRING_OPTIONS_OVERALL_ALL"] = "Все сегменты"
L["STRING_OPTIONS_OVERALL_ALL_DESC"] = "Все сегменты идут в зачет всеобщих данных"
L["STRING_OPTIONS_OVERALL_ANCHOR"] = "Всеобщие данные:"
L["STRING_OPTIONS_OVERALL_CHALLENGE"] = "Сбрасывать в режиме испытаний (эпох+)"
L["STRING_OPTIONS_OVERALL_CHALLENGE_DESC"] = "Когда включено, всеобщие данные сбрасываются автоматически, когда начинается новый режим испытаний (эпох+)."
L["STRING_OPTIONS_OVERALL_DUNGEONBOSS"] = "Боссы подземелий"
L["STRING_OPTIONS_OVERALL_DUNGEONBOSS_DESC"] = "Сегменты с боссами подземелий идут в зачет всеобщих данных."
L["STRING_OPTIONS_OVERALL_DUNGEONCLEAN"] = "Треш подземелий"
L["STRING_OPTIONS_OVERALL_DUNGEONCLEAN_DESC"] = "Сегменты с трешем подземелий идут в зачет всеобщих данных."
L["STRING_OPTIONS_OVERALL_LOGOFF"] = "Сбрасывать при выходе"
L["STRING_OPTIONS_OVERALL_LOGOFF_DESC"] = "Когда включено, всеобщие данные сбрасываются автоматически, когда вы выходите из игрового мира."
L["STRING_OPTIONS_OVERALL_NEWBOSS"] = "Сбрасывать на новом боссе"
L["STRING_OPTIONS_OVERALL_NEWBOSS_DESC"] = "Когда включено, всеобщие данные сбрасываются автоматически, когда начинается бой с другим рейдовым боссом."
L["STRING_OPTIONS_OVERALL_RAIDBOSS"] = "Рейдовые боссы"
L["STRING_OPTIONS_OVERALL_RAIDBOSS_DESC"] = "Сегменты с рейдовыми боями идут в зачет всеобщих данных."
L["STRING_OPTIONS_OVERALL_RAIDCLEAN"] = "Рейдовый треш"
L["STRING_OPTIONS_OVERALL_RAIDCLEAN_DESC"] = "Сегменты с рейдовым трешем идут в зачет всеобщих данных."
L["STRING_OPTIONS_PLUGINS"] = "Плагины"
L["STRING_OPTIONS_PLUGINS_AUTHOR"] = "Автор"
L["STRING_OPTIONS_PROFILE_COPYOKEY"] = "Профиль успешно скопирован."
L["STRING_OPTIONS_PROFILE_FIELDEMPTY"] = "В поле с названием пусто."
L["STRING_OPTIONS_PROFILE_GLOBAL"] = "Выбрать профиль, который будет использоваться всеми персонажами."
L["STRING_OPTIONS_PROFILE_LOADED"] = "Профиль загружен:"
L["STRING_OPTIONS_PROFILE_NOTCREATED"] = "Профиль не создан."
L["STRING_OPTIONS_PROFILE_POSSIZE"] = "Сохранить размер и положение."
L["STRING_OPTIONS_PROFILE_POSSIZE_DESC"] = "Сохранить положение окна и размеры в рамках профиля. Если выключено, каждый персонаж будет обладать своим показателями."
L["STRING_OPTIONS_PROFILE_REMOVEOKEY"] = "Профиль успешно удален."
L["STRING_OPTIONS_PROFILE_SELECT"] = "выбрать профиль."
L["STRING_OPTIONS_PROFILE_SELECTEXISTING"] = "Выберите существующий профиль или можете продолжить использовать новый профиль на данной персонаже:"
L["STRING_OPTIONS_PROFILE_USENEW"] = "Использовать новый профиль"
L["STRING_OPTIONS_PROFILES_ANCHOR"] = "Настройки:"
L["STRING_OPTIONS_PROFILES_COPY"] = "Скопировать профиль из"
L["STRING_OPTIONS_PROFILES_COPY_DESC"] = "Скопировать все настройки из выбранного профиля в текущий, все значения будут переписаны."
L["STRING_OPTIONS_PROFILES_CREATE"] = "Создать профиль"
L["STRING_OPTIONS_PROFILES_CREATE_DESC"] = "Создать новый профиль."
L["STRING_OPTIONS_PROFILES_CURRENT"] = "Текущий профиль:"
L["STRING_OPTIONS_PROFILES_ERASE"] = "Удалить профиль"
L["STRING_OPTIONS_PROFILES_ERASE_DESC"] = "Удалить выбранный профиль."
L["STRING_OPTIONS_PROFILES_RESET"] = "Сбросить текущий профиль"
L["STRING_OPTIONS_PROFILES_RESET_DESC"] = "Сбросить все настройки текущего профиля к стандартным показателям."
L["STRING_OPTIONS_PROFILES_SELECT"] = "Выбрать профиль"
L["STRING_OPTIONS_PROFILES_TITLE"] = "Профили"
L["STRING_OPTIONS_PROFILES_TITLE_DESC"] = "Данные опции позволяют Вам управлять настройками и расшаривать их между различными персонажами."
L["STRING_OPTIONS_PS_ABBREVIATE"] = "Формат чисел"
L["STRING_OPTIONS_PS_ABBREVIATE_COMMA"] = "Запятая"
L["STRING_OPTIONS_PS_ABBREVIATE_DESC"] = [=[Выберите метод сокращения.

|cFFFFFF00ToK I|r:
520600 = 520.6K
19530000 = 19.53M

|cFFFFFF00ToK II|r:
520600 = 520K
19530000 = 19.53M

|cFFFFFF00ToM I|r:
520600 = 520.6K
19530000 = 19M

|cFFFFFF00Запятая|r:
19530000 = 19,530,000

|cFFFFFF00Нижняя|r и |cFFFFFF00Верхняя|r: определяет, как будут написаны 'K' и 'M' в нижнем или верхнем регистре.]=]
L["STRING_OPTIONS_PS_ABBREVIATE_NONE"] = "Никакой"
L["STRING_OPTIONS_PS_ABBREVIATE_TOK"] = "ToK I Верхняя"
L["STRING_OPTIONS_PS_ABBREVIATE_TOK0"] = "ToM I Верхняя"
L["STRING_OPTIONS_PS_ABBREVIATE_TOK0MIN"] = "ToM I Нижняя"
L["STRING_OPTIONS_PS_ABBREVIATE_TOK2"] = "ToK II Верхняя"
L["STRING_OPTIONS_PS_ABBREVIATE_TOK2MIN"] = "ToK II Нижняя"
L["STRING_OPTIONS_PS_ABBREVIATE_TOKMIN"] = "ToK I Нижняя"
L["STRING_OPTIONS_PVPFRAGS"] = "Только PvP убийства "
L["STRING_OPTIONS_REALMNAME"] = "Убрать название сервера"
L["STRING_OPTIONS_REALMNAME_DESC"] = [=[Когда включено, название сервера игрока не отображается.

|cFFFFFF00Выключено|r: Вася-Гром
|cFFFFFF00Включено|r: Вася]=]
L["STRING_OPTIONS_RT_INTERRUPT"] = "%s прервано!"
L["STRING_OPTIONS_SAVELOAD_REMOVE"] = "Сбросить"
L["STRING_OPTIONS_SAVELOAD_SKINCREATED"] = "Скин создан."
L["STRING_OPTIONS_SENDFEEDBACK"] = "Отзыв"
L["STRING_OPTIONS_SHOW_STATUSBAR"] = "Показать строку состояния"
L["STRING_OPTIONS_SHOW_STATUSBAR_DESC"] = "Показать или скрыть нижнюю строку состояния."
L["STRING_OPTIONS_SHOW_TOTALBAR_INGROUP"] = "Только в Группе"
L["STRING_OPTIONS_SIZE"] = "Размер"
L["STRING_OPTIONS_SKIN_LOADED"] = "скин успешно загружен."
L["STRING_OPTIONS_SKIN_PRESETS_ANCHOR"] = "Сохранить скин:"
L["STRING_OPTIONS_SKIN_REMOVED"] = "скин удален."
L["STRING_OPTIONS_SKIN_RESET_TOOLTIP"] = "Сбросить границу подсказки"
L["STRING_OPTIONS_SKIN_SELECT"] = "выбрать скин"
L["STRING_OPTIONS_SKIN_SELECT_ANCHOR"] = "Выбор скина:"
L["STRING_OPTIONS_TESTBARS"] = "Создать тестовые полосы"
L["STRING_OPTIONS_TEXT"] = "Настройки текста полос"
L["STRING_OPTIONS_TEXT_DESC"] = "Данные опции управляют внешним видом текста полос окна."
L["STRING_OPTIONS_TEXT_FIXEDCOLOR"] = "Цвет текста"
L["STRING_OPTIONS_TEXT_FIXEDCOLOR_DESC"] = [=[Изменить цвет шрифта левого и правого текстов.

Игнорируется, если включен |cFFFFFFFFцвет по классу игрока|r.]=]
L["STRING_OPTIONS_TEXT_FONT"] = "Шрифт текста"
L["STRING_OPTIONS_TEXT_FONT_DESC"] = "Изменить шрифт левого и правого текстов."
L["STRING_OPTIONS_TEXT_LCLASSCOLOR_DESC"] = "Если включено, то для текста всегда используется цвет класса игрока."
L["STRING_OPTIONS_TEXT_LEFT_ANCHOR"] = "Текст слева:"
L["STRING_OPTIONS_TEXT_LOUTILINE"] = "Тень текста"
L["STRING_OPTIONS_TEXT_LOUTILINE_DESC"] = "Включить или выключить тень для левого текста."
L["STRING_OPTIONS_TEXT_LPOSITION"] = "Показывать номер"
L["STRING_OPTIONS_TEXT_LPOSITION_DESC"] = "Показывать номер места игрока с левой стороны."
L["STRING_OPTIONS_TEXT_RIGHT_ANCHOR"] = "Текст справа:"
L["STRING_OPTIONS_TEXT_ROUTILINE_DESC"] = "Включить или выключить тень для правого текста."
L["STRING_OPTIONS_TEXT_ROWICONS_ANCHOR"] = "Иконки:"
L["STRING_OPTIONS_TEXT_SHOW_BRACKET"] = "Скобка"
L["STRING_OPTIONS_TEXT_SHOW_BRACKET_DESC"] = "Выберите символ, используемый для открытия и закрытия блоков: урон в секунду и проценты."
L["STRING_OPTIONS_TEXT_SHOW_PERCENT"] = "Показывать проценты"
L["STRING_OPTIONS_TEXT_SHOW_PERCENT_DESC"] = "Показывать проценты."
L["STRING_OPTIONS_TEXT_SHOW_PS"] = "Показывать урон в секунду"
L["STRING_OPTIONS_TEXT_SHOW_PS_DESC"] = "Показывать 'Урон в Секунду' и 'Исцеление в Секунду'."
L["STRING_OPTIONS_TEXT_SHOW_SEPARATOR"] = "Разделитель"
L["STRING_OPTIONS_TEXT_SHOW_SEPARATOR_DESC"] = "Выберите символ, используемых для разделения показателей урона в секунду от процентов."
L["STRING_OPTIONS_TEXT_SHOW_TOTAL"] = "Показывать итог"
L["STRING_OPTIONS_TEXT_SHOW_TOTAL_DESC"] = [=[Показывать итоговые данные проделанные игроком.

Пример: всего нанесено урона, всего исцеления получено.]=]
L["STRING_OPTIONS_TEXT_SIZE"] = "Размер текста"
L["STRING_OPTIONS_TEXT_SIZE_DESC"] = "Изменить размер левого и правого текстов."
L["STRING_OPTIONS_TEXTEDITOR_COMMA"] = "Запятая"
L["STRING_OPTIONS_TIMEMEASURE"] = "Измерение времени"
L["STRING_OPTIONS_TIMEMEASURE_DESC"] = [=[|cFFFFFF00Активный|r: таймер каждого игрока рейдовой группы будет приостанавливаться при прекращении активности, и снова рассчитываться при ее возобновлении. Распространенный способ измерения УВС и ИВС

|cFFFFFF00Эффективный|r: используется для рейтингов. Данный метод продолжает считывать УВС и ИВС всех членов рейдовой группы, даже тех кто неактивен.]=]
L["STRING_OPTIONS_TOOLS_ANCHOR"] = "Инструменты:"
L["STRING_OPTIONS_TOOLTIP_ANCHOR"] = "Настройки:"
L["STRING_OPTIONS_TOOLTIP_ANCHORTEXTS"] = "Тексты:"
L["STRING_OPTIONS_TOOLTIPS_ABBREVIATION"] = "Тип сокращений"
L["STRING_OPTIONS_TOOLTIPS_ABBREVIATION_DESC"] = "Выберите формат чисел, отображаемый в подсказках."
L["STRING_OPTIONS_TOOLTIPS_ANCHOR_BORDER"] = "Граница:"
L["STRING_OPTIONS_TOOLTIPS_BACKGROUNDCOLOR"] = "Фоновый цвет"
L["STRING_OPTIONS_TOOLTIPS_BACKGROUNDCOLOR_DESC"] = "Выберите фоновый цвет."
L["STRING_OPTIONS_TOOLTIPS_BORDER_COLOR_DESC"] = "Изменить цвет границы."
L["STRING_OPTIONS_TOOLTIPS_BORDER_SIZE_DESC"] = "Изменить размер границы."
L["STRING_OPTIONS_TOOLTIPS_BORDER_TEXTURE_DESC"] = "Изменить файл текстуры границы."
L["STRING_OPTIONS_TOOLTIPS_FONTCOLOR"] = "Цвет текста"
L["STRING_OPTIONS_TOOLTIPS_FONTCOLOR_DESC"] = "Измените цвет текста используемый в подсказках."
L["STRING_OPTIONS_TOOLTIPS_FONTFACE"] = "Шрифт текста"
L["STRING_OPTIONS_TOOLTIPS_FONTFACE_DESC"] = "Выбрать шрифт используемый в текстовых подсказках."
L["STRING_OPTIONS_TOOLTIPS_FONTSIZE"] = "Размер текста"
L["STRING_OPTIONS_TOOLTIPS_MAXIMIZE"] = "Метод расширения"
L["STRING_OPTIONS_TOOLTIPS_MAXIMIZE_DESC"] = [=[Выберите метод расширения информации, отображаемой в подсказке.

|cFFFFFF00 Кнопки управления|r: окно подсказки расширяется, когда кнопки Shift, Ctrl или Alt нажаты.

|cFFFFFF00 Всегда расширено|r: вся информация всегда отображается в окне подсказки без каких-либо ограничений.

|cFFFFFF00 Только блок Shift|r: первый блок подсказки всегда расширен по умолчанию.

|cFFFFFF00 Только блок Ctrl|r: второй блок подсказки всегда расширен по умолчанию.

|cFFFFFF00 Только блок Alt|r: третий блок подсказки всегда расширен по умолчанию.]=]
L["STRING_OPTIONS_TOOLTIPS_MAXIMIZE1"] = "На Shift Ctrl Alt"
L["STRING_OPTIONS_TOOLTIPS_MAXIMIZE2"] = "Всегда расширено"
L["STRING_OPTIONS_TOOLTIPS_MAXIMIZE3"] = "Только блок Shift"
L["STRING_OPTIONS_TOOLTIPS_MAXIMIZE4"] = "Только блок Ctrl"
L["STRING_OPTIONS_TOOLTIPS_MAXIMIZE5"] = "Только блок Alt"
L["STRING_OPTIONS_TOOLTIPS_TITLE"] = "Подсказки"
L["STRING_OPTIONS_TOOLTIPS_TITLE_DESC"] = "Данные опции управляют внешним видом подсказок."
L["STRING_OPTIONS_WC_ANCHOR"] = "Быстрое управление окном (#%s)"
L["STRING_OPTIONS_WC_BOOKMARK"] = "Управление закладками"
L["STRING_OPTIONS_WC_BOOKMARK_DESC"] = "Открыть панель управления закладками."
L["STRING_OPTIONS_WC_CLOSE"] = "Закрыть"
L["STRING_OPTIONS_WC_CLOSE_DESC"] = [=[Закрыть редактируемое в данный момент окно.

В закрытом состояние окно считается неактивным и его можно открыть снова с помощью меню управления окнами.

|cFFFFFF00Важно:|r для окончательного удаление окна, перейдите в раздел "Окно:Общее"]=]
L["STRING_OPTIONS_WC_CREATE"] = "Создать окно"
L["STRING_OPTIONS_WC_CREATE_DESC"] = "Создать новое окно."
L["STRING_OPTIONS_WC_LOCK"] = "Заблокировать"
L["STRING_OPTIONS_WC_LOCK_DESC"] = [=[Заблокировать или разблокировать окно.

Окно нельзя перемещать, если заблокировано.]=]
L["STRING_OPTIONS_WC_UNLOCK"] = "Разблокировать"
L["STRING_OPTIONS_WC_UNSNAP"] = "Разгруппировать"
L["STRING_OPTIONS_WC_UNSNAP_DESC"] = "Убрать данное окно из группы окон."
L["STRING_OPTIONS_WHEEL_SPEED"] = "Скорость прокрутки"
L["STRING_OPTIONS_WHEEL_SPEED_DESC"] = "Изменение того, как быстро будут прокручиваться полосы колесиком мыши в окне"
L["STRING_OPTIONS_WINDOW"] = "Панель настроек"
L["STRING_OPTIONS_WINDOW_SCALE"] = "Масштаб"
L["STRING_OPTIONS_WINDOW_SCALE_DESC"] = [=[Отрегулируйте масштаб окна.

|cFFFFFF00Совет|r: правый клик - ввести значения самому.

|cFFFFFF00Текущий|r: %s]=]
L["STRING_OPTIONS_WINDOW_TITLE"] = "Общие настройки окна"
L["STRING_OPTIONS_WINDOW_TITLE_DESC"] = "Данные опции позволяют управлять внешним видом выбранного окна."
L["STRING_OPTIONS_WINDOWSPEED"] = "Интервал обновления"
L["STRING_OPTIONS_WINDOWSPEED_DESC"] = [=[Интервал времени между обновлениями.

|cFFFFFF000.05|r: обновление в режиме реального времени.

|cFFFFFF000.3|r: обновление 3 раза за секунду.

|cFFFFFF003.0|r: обновление каждые 3 секунды.]=]
L["STRING_OPTIONS_WP"] = "Настройки: Обои"
L["STRING_OPTIONS_WP_ALIGN"] = "Выравнять "
L["STRING_OPTIONS_WP_DESC"] = "Данные опции управляют обоями окна."
L["STRING_OPTIONS_WP_EDIT"] = "Редактировать изображение "
L["STRING_OPTIONS_WP_GROUP"] = "Категория"
L["STRING_OPTIONS_WP_GROUP2"] = "Обои"
L["STRING_OPTIONSMENU_AUTOMATIC"] = "Окно: Автоматизация"
L["STRING_OPTIONSMENU_AUTOMATIC_TITLE"] = "Настройки автоматизации Окна"
L["STRING_OPTIONSMENU_AUTOMATIC_TITLE_DESC"] = "Данные опции управляют автоматическим поведением окна, такими как авто-скрытие и авто-переключение."
L["STRING_OPTIONSMENU_COMBAT"] = "PvE | PvP"
L["STRING_OPTIONSMENU_DISPLAY"] = "Отображение "
L["STRING_OPTIONSMENU_DISPLAY_DESC"] = "Основные базовые настройки и быстрое управление окном."
L["STRING_OPTIONSMENU_LEFTMENU"] = "Заголовок: Общее"
L["STRING_OPTIONSMENU_PROFILES"] = "Профили"
L["STRING_OPTIONSMENU_RIGHTMENU"] = "-- x -- x --"
L["STRING_OPTIONSMENU_ROWMODELS"] = "Полосы: Дополнительно"
L["STRING_OPTIONSMENU_ROWSETTINGS"] = "Полосы: Общее"
L["STRING_OPTIONSMENU_ROWTEXTS"] = "Полосы: Тексты"
L["STRING_OPTIONSMENU_SKIN"] = "Выбрать скин"
L["STRING_OPTIONSMENU_TITLETEXT"] = "Заголовок: Текст"
L["STRING_OPTIONSMENU_TOOLTIP"] = "Подсказки"
L["STRING_OPTIONSMENU_WALLPAPER"] = "Окно: Обои"
L["STRING_OPTIONSMENU_WINDOW"] = "Окно: Общее"
L["STRING_OVERALL"] = "Всеобщие"
L["STRING_OVERHEAL"] = "Избыточное лечение"
L["STRING_OVERHEALED"] = "Избыточно исцелено"
L["STRING_PARRY"] = "Парирование"
L["STRING_PET"] = "Питомец"
L["STRING_PETS"] = "Питомцы"
L["STRING_PLAYER_DETAILS"] = "Details! Игрока"
L["STRING_PLAYERS"] = "Игроки"
L["STRING_PLUGIN_CLOCKNAME"] = "Таймер боя"
L["STRING_PLUGIN_DURABILITY"] = "Прочность "
L["STRING_PLUGIN_FPS"] = "Частота кадров"
L["STRING_PLUGIN_LATENCY"] = "Задержка "
L["STRING_PLUGIN_PSEGMENTNAME"] = "Сегмент"
L["STRING_PLUGIN_SEGMENTTYPE_1"] = "Бой #X"
L["STRING_REPORT_TOOLTIP"] = "Отчет"
L["STRING_REPORTFRAME_COPY"] = "Копировать и Вставить"
L["STRING_REPORTFRAME_GUILD"] = "Гильдия"
L["STRING_REPORTFRAME_INSERTNAME"] = "имя игрока"
L["STRING_REPORTFRAME_LINES"] = "Строк"
L["STRING_REPORTFRAME_OFFICERS"] = "Канал офицеров"
L["STRING_REPORTFRAME_PARTY"] = "Группа"
L["STRING_REPORTFRAME_RAID"] = "Рейд"
L["STRING_REPORTFRAME_REVERT"] = "в обратном"
L["STRING_REPORTFRAME_REVERTED"] = "обратный"
L["STRING_REPORTFRAME_REVERTINFO"] = "отправить в порядке возрастания"
L["STRING_REPORTFRAME_SAY"] = "Сказать"
L["STRING_REPORTFRAME_SEND"] = "Отправить"
L["STRING_REPORTFRAME_WHISPER"] = "Шепот"
L["STRING_REPORTFRAME_WHISPERTARGET"] = "Шепнуть цели"
L["STRING_REPORTFRAME_WINDOW_TITLE"] = "Линкануть Details!"
L["STRING_REPORTHISTORY"] = "Последние отчеты"
L["STRING_RIGHT"] = "справа"
L["STRING_SEGMENT"] = "Сегмент"
L["STRING_SEGMENT_EMPTY"] = "в данном сегменте ничего нет"
L["STRING_SEGMENT_END"] = "Конец"
L["STRING_SEGMENT_ENEMY"] = "Враг"
L["STRING_SEGMENT_LOWER"] = "сегмент"
L["STRING_SEGMENT_OVERALL"] = "Всеобщие данные"
L["STRING_SEGMENT_START"] = "Начало"
L["STRING_SEGMENT_TIME"] = "Время"
L["STRING_SEGMENT_TRASH"] = "Зачистка треша"
L["STRING_SEGMENTS"] = "Сегменты"
L["STRING_SLASH_WIPE"] = "вайп"
L["STRING_SLASH_WORLDBOSS"] = "мировые боссы"
L["STRING_SLASH_WORLDBOSS_DESC"] = "запускает макрос, показывающий каких вы убили на этой неделе "
L["STRING_SPELL_INTERRUPTED"] = "Заклинания прерваны"
L["STRING_SPELLS"] = "Заклинания"
L["STRING_TARGET"] = "Цель"
L["STRING_TARGETS"] = "Цели"
L["STRING_TARGETS_OTHER1"] = "Питомцы и другие цели"
L["STRING_TEXTURE"] = "Текстура"
L["STRING_TIME_OF_DEATH"] = "Смерть"
L["STRING_TUTORIAL_FULLY_DELETE_WINDOW"] = [=[Вы закрыли окно и сможете в любой момент его снова открыть.
Чтобы удалить окно полностью, перейдите в Настройки -> Окно: Общее -> Удалить.]=]
L["STRING_UNKNOWSPELL"] = "Неизвестное заклинание"
L["STRING_UNLOCK_WINDOW"] = "разблок."
L["STRING_VERSION_UPDATE"] = "новая версия: что изменилось? кликните тут"
L["STRING_WELCOME_1"] = [=[|cFFFFFFFFДобро пожаловать в Details! С Вами - Мастер быстрой настройки 

|rДанный гайд поможет Вам в настройке некоторых важных элементов.
Заходите пропустить? Просто кликните в любой момент по кнопке "Пропустить".]=]
L["STRING_WELCOME_11"] = "передумали? всегда сможете всё изменить в панели настроек"
L["STRING_WELCOME_12"] = "Выберите как быстро будет обновляться окно, Вы также можете включить анимации и обновление ИВС и УВС в реальном времени"
L["STRING_WELCOME_14"] = "Скорость обновления"
L["STRING_WELCOME_15"] = [=[Интервал в секундах между обновлениями в окне.

|cffffff00Важно|r: Ютуберам и Стримерам может потребоваться |cFFFF55000.05|r для развлечения зрителей.]=]
L["STRING_WELCOME_16"] = "Включить анимации"
L["STRING_WELCOME_17"] = [=[Если включено, все полосы плавно движутся влево и вправо.

|cffffff00Важно|r: Ютуберам и Стримерам может потребоваться для развлечения зрителей.]=]
L["STRING_WELCOME_2"] = "если Вы передумаете, то всегда сможете это изменить в панели настроек"
L["STRING_WELCOME_26"] = "Фишки интерфейса: Растягиватель"
L["STRING_WELCOME_27"] = [=[Подсвеченная кнопка это Растягиватель. |cFFFFFF00Кликните|r и |cFFFFFF00потяните вверх!|r 

Если окно заблокировано, то вся строка заголовка превращается в Растягиватель.]=]
L["STRING_WELCOME_28"] = "Фишки интерфейса: Управление Окном"
L["STRING_WELCOME_29"] = [=[Управление Окном в основном делает две вещи:

- открывает |cFFFFFF00новое окно|r. 
- показывает меню с |cFFFFFF00закрытыми окнами|r, которые можно открыть снова в любой момент.]=]
L["STRING_WELCOME_3"] = "Выберите предпочитаемый метод УВС и ИВС:"
L["STRING_WELCOME_30"] = "Фишки интерфейса: Закладки"
L["STRING_WELCOME_31"] = [=[|cFFFFFF00Правый клик|r где угодно, в рамках окна, показывает панель с |cFFFFAA00Закладками|r.

|cFFFFFF00Правый клик снова|r закрыть или выбрать другой монитор, кликнув на иконку.

|cFFFFFF00Правый клик|r по панели с заголовком открывает панель "Все мониторы".

|TInterface\AddOns\Details\images\key_ctrl:14:30:0:0:64:64:0:64:0:40|t + Правый клик закрывает окно.]=]
L["STRING_WELCOME_32"] = "Фишка интерфейса: Сгруппировать окна"
L["STRING_WELCOME_34"] = "Фишка интерфейса: Всплывающие подсказки "
L["STRING_WELCOME_36"] = "Фишки интерфейса: Плагины"
L["STRING_WELCOME_38"] = "К рейду готов!"
L["STRING_WELCOME_39"] = [=[Спасибо за выбор Details!

Не стесняйтесь отправлять отзывы и сообщения об ошибках нам. (только на английском)


|cFFFFAA00/details feedback|r]=]
L["STRING_WELCOME_4"] = "Активный режим:"
L["STRING_WELCOME_41"] = "Развлекательные фишки интерфейса:"
L["STRING_WELCOME_42"] = "Быстрые настройки внешнего вида"
L["STRING_WELCOME_43"] = "Выберите предпочитаемый скин:"
L["STRING_WELCOME_44"] = "Обои"
L["STRING_WELCOME_46"] = "Импорт настроек"
L["STRING_WELCOME_5"] = "Эффектив.режим:"
L["STRING_WELCOME_59"] = "Включить фоновые обои."
L["STRING_WELCOME_6"] = "таймер каждого игрока рейдовой группы будет приостанавливаться при прекращении активности, и снова рассчитываться при ее возобновлении."
L["STRING_WELCOME_60"] = "Никнейм и аватар"
L["STRING_WELCOME_63"] = "Обновление DPS/HPS в режиме реального времени"
L["STRING_WELCOME_65"] = "Нажмите ПКМ"
L["STRING_WELCOME_66"] = [=[Перетащите окно к другому для создания группы.

Группированные окна растягиваются и изменяются в размере вместе.

Они также живут счастливо, как пара.]=]
L["STRING_WELCOME_67"] = [=[Нажмите Shift, для отображения всплывающей подсказки о всех используемых заклинаниях.

Ctrl для всех целей and Alt для всех питомцев.]=]
L["STRING_WELCOME_68"] = [=[Details! имеет фишку
под названием 'Плагины'

Они везде помогут Вам
в различных задачах.

К примеру: просмотр аггро, анализ УВС, информация о бое, создание графиков и т.д.]=]
L["STRING_WELCOME_69"] = "Пропустить"
L["STRING_WELCOME_7"] = "используется для рейтингов. Данный метод продолжает считывать УВС и ИВС всех членов рейдовой группы, даже тех кто неактивен."
L["STRING_WELCOME_72"] = "Настройки окна"
L["STRING_WINDOW_NOTFOUND"] = "Окно не найдено."
L["STRING_WINDOW1ATACH_DESC"] = "Чтобы создать группу окон, перетащите окно #2 к окну #1 "
L["STRING_YES"] = "Да"
