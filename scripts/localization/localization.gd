extends Node

signal language_changed(language_code: String)

const DEFAULT_LANGUAGE := "uk"
const SUPPORTED_LANGUAGES := ["uk", "en"]
const ENGLISH_DIALOGUES_PATH := "res://translations/dialogue_en.json"

const UI := {
	"main.eyebrow": {"uk": "ВІЗУАЛЬНА НОВЕЛА ПРО ПЕРШИЙ КУРС", "en": "A VISUAL NOVEL ABOUT THE FIRST YEAR"},
	"main.title": {"uk": "Між парами", "en": "Between Classes"},
	"main.subtitle": {"uk": "Нові люди. Нове місто. Твоя історія.", "en": "New people. A new city. Your story."},
	"main.new_game": {"uk": "Нова гра", "en": "New Game"},
	"main.continue": {"uk": "Продовжити", "en": "Continue"},
	"main.load": {"uk": "Завантажити", "en": "Load"},
	"main.choices": {"uk": "Зроблені вибори", "en": "Your Choices"},
	"main.settings": {"uk": "Налаштування", "en": "Settings"},
	"main.exit": {"uk": "Вихід", "en": "Exit"},
	"main.choice_history": {"uk": "Зроблені вибори", "en": "Choices Made"},
	"main.node": {"uk": "Вузол\n%d", "en": "Node\n%d"},
	"main.choice_title": {"uk": "Розділ %d — %s", "en": "Chapter %d — %s"},
	"main.selected": {"uk": "Обрано: %s", "en": "Selected: %s"},
	"main.not_unlocked": {"uk": "Ще не відкрито в поточному проходженні", "en": "Not yet unlocked in this playthrough"},
	"language.uk": {"uk": "Українська", "en": "Ukrainian"},
	"language.en": {"uk": "English", "en": "English"},
	"language.short_uk": {"uk": "УКР", "en": "UA"},
	"language.short_en": {"uk": "ENG", "en": "EN"},
	"common.back": {"uk": "Назад", "en": "Back"},
	"common.save": {"uk": "Зберегти", "en": "Save"},
	"common.saved": {"uk": "Збережено", "en": "Saved"},
	"common.load": {"uk": "Завантажити", "en": "Load"},
	"common.continue": {"uk": "Продовжити", "en": "Continue"},
	"common.main_menu": {"uk": "У головне меню", "en": "Main Menu"},
	"common.empty": {"uk": "Порожній", "en": "Empty"},
	"common.slot": {"uk": "Слот %d", "en": "Slot %d"},
	"common.slot_scene": {"uk": "Слот %d — %s", "en": "Slot %d — %s"},
	"common.chapter": {"uk": "Розділ %d", "en": "Chapter %d"},
	"common.scene": {"uk": "Сцена %d", "en": "Scene %d"},
	"common.slot_meta": {"uk": "Розділ %d   реп. %d   %s", "en": "Chapter %d   rep. %d   %s"},
	"common.choice": {"uk": "Вибір", "en": "Choice"},
	"common.reputation": {"uk": "Репутація", "en": "Reputation"},
	"settings.title": {"uk": "Налаштування", "en": "Settings"},
	"settings.subtitle": {"uk": "Налаштуй читання, звук і вигляд під свій ритм", "en": "Adjust reading, sound, and visuals to your rhythm"},
	"settings.tab_audio": {"uk": "Звук", "en": "Audio"},
	"settings.tab_text": {"uk": "Текст", "en": "Text"},
	"settings.tab_visual": {"uk": "Вигляд", "en": "Visuals"},
	"settings.tab_display": {"uk": "Екран", "en": "Display"},
	"settings.audio_title": {"uk": "Звук", "en": "Audio"},
	"settings.music_volume": {"uk": "Гучність музики", "en": "Music volume"},
	"settings.sfx_volume": {"uk": "Гучність звуків", "en": "Sound volume"},
	"settings.display_title": {"uk": "Екран", "en": "Display"},
	"settings.display_mode": {"uk": "Режим екрана", "en": "Display mode"},
	"settings.resolution": {"uk": "Роздільність", "en": "Resolution"},
	"settings.note_title": {"uk": "✦  Все застосовується одразу", "en": "✦  Changes apply immediately"},
	"settings.note_text": {"uk": "Підбери комфортний темп читання й м’якість діалогового вікна — гра збереже вибір, коли ти повернешся назад.", "en": "Choose a comfortable reading pace and dialogue-box opacity — the game will remember your settings."},
	"settings.text_title": {"uk": "Текст", "en": "Text"},
	"settings.text_speed": {"uk": "Швидкість появи тексту", "en": "Text reveal speed"},
	"settings.auto_delay": {"uk": "Затримка автоматичного тексту", "en": "Auto-advance delay"},
	"settings.font_size": {"uk": "Розмір тексту діалогів", "en": "Dialogue text size"},
	"settings.font_family": {"uk": "Шрифт тексту", "en": "Text font"},
	"settings.visual_title": {"uk": "Вигляд", "en": "Visuals"},
	"settings.textbox_opacity": {"uk": "Прозорість текстового вікна", "en": "Dialogue-box opacity"},
	"settings.ui_scale": {"uk": "Масштаб інтерфейсу", "en": "Interface scale"},
	"settings.inactive_alpha": {"uk": "Яскравість неактивних персонажів", "en": "Inactive character brightness"},
	"settings.language": {"uk": "Мова", "en": "Language"},
	"settings.save_back": {"uk": "Зберегти й назад", "en": "Save and Back"},
	"settings.audio_desc": {"uk": "Збалансуй фонову музику та звуки інтерфейсу.", "en": "Balance background music and interface sounds."},
	"settings.text_desc": {"uk": "Налаштуй темп і читабельність діалогів.", "en": "Adjust dialogue pacing and readability."},
	"settings.visual_desc": {"uk": "Зміни прозорість, масштаб і фокус персонажів.", "en": "Adjust opacity, scale, and character focus."},
	"settings.display_desc": {"uk": "Обери зручний режим вікна та роздільність.", "en": "Choose a convenient window mode and resolution."},
	"settings.mode_windowed": {"uk": "У вікні", "en": "Windowed"},
	"settings.mode_fullscreen": {"uk": "Повний екран", "en": "Fullscreen"},
	"settings.mode_borderless": {"uk": "Без рамки", "en": "Borderless"},
	"settings.hint_windowed": {"uk": "Звичайне вікно Windows. Зручно, якщо треба швидко перемикатись між програмами.", "en": "A regular Windows window. Convenient for switching between apps."},
	"settings.hint_fullscreen": {"uk": "Повноекранний режим. Гра займає весь екран і може перемкнути режим дисплея.", "en": "Exclusive fullscreen. The game fills the screen and may change the display mode."},
	"settings.hint_borderless": {"uk": "Вікно без рамки на весь екран. Виглядає як повноекранний режим, але Alt+Tab зазвичай працює м’якше.", "en": "A borderless full-screen window. It looks fullscreen, but Alt+Tab is usually smoother."},
	"game.pause": {"uk": "Пауза", "en": "Paused"},
	"game.pause_subtitle": {"uk": "Історія зачекає на тебе", "en": "The story will wait for you"},
	"game.resume": {"uk": "Продовжити", "en": "Resume"},
	"game.auto": {"uk": "Авто", "en": "Auto"},
	"game.skip": {"uk": "Пропуск", "en": "Skip"},
	"game.menu": {"uk": "У меню", "en": "Menu"},
	"game.auto_on": {"uk": "Авто: увімкнено", "en": "Auto: on"},
	"game.skip_on": {"uk": "Пропуск: увімкнено", "en": "Skip: on"},
	"game.summary_default": {"uk": "Розділ завершено", "en": "Chapter Complete"},
	"game.relationships": {"uk": "Стосунки", "en": "Relationships"},
	"game.no_changes": {"uk": "Поки без помітних змін.", "en": "No noticeable changes yet."},
	"game.stat_change": {"uk": "Зміна характеристик", "en": "Stat Change"},
}

const RELATIONSHIP_NAMES := {
	"daria": {"uk": "Дарія", "en": "Daria"},
	"maria": {"uk": "Марія", "en": "Maria"},
	"anna": {"uk": "Анна", "en": "Anna"},
	"melania": {"uk": "Меланія", "en": "Melania"},
	"marta": {"uk": "Марта", "en": "Marta"},
	"oksana": {"uk": "Оксана", "en": "Oksana"},
	"lidiya": {"uk": "Лідія Іванівна", "en": "Lidiia Ivanivna"},
	"watchwoman": {"uk": "Вахтерка", "en": "Dorm Supervisor"},
	"silhouette_boy": {"uk": "Хлопець", "en": "Boy"},
	"vira": {"uk": "Віра", "en": "Vira"},
	"luka": {"uk": "Лука", "en": "Luka"},
	"demyan": {"uk": "Дем'ян", "en": "Demian"},
	"roksolana": {"uk": "Роксолана", "en": "Roksolana"},
	"olena_serhiivna": {"uk": "Олена Сергіївна", "en": "Olena Serhiivna"},
	"curator": {"uk": "Кураторка", "en": "Curator"},
}

const UNKNOWN_RELATIONSHIP_NAMES := {
	"maria": {"uk": "Незнайомка", "en": "Stranger"},
	"melania": {"uk": "Незнайомка", "en": "Stranger"},
	"marta": {"uk": "Незнайомка", "en": "Stranger"},
	"oksana": {"uk": "Незнайомка", "en": "Stranger"},
	"silhouette_boy": {"uk": "Незнайомець", "en": "Stranger"},
	"vira": {"uk": "Незнайомка", "en": "Stranger"},
	"luka": {"uk": "Незнайомець", "en": "Stranger"},
	"demyan": {"uk": "Незнайомець", "en": "Stranger"},
	"roksolana": {"uk": "Незнайомка", "en": "Stranger"},
}

var current_language := DEFAULT_LANGUAGE
var _english_dialogues: Dictionary = {}


func _ready() -> void:
	_load_english_dialogues()


func set_language(language_code: String) -> void:
	var normalized := language_code if SUPPORTED_LANGUAGES.has(language_code) else DEFAULT_LANGUAGE
	if normalized == current_language:
		return
	current_language = normalized
	TranslationServer.set_locale(normalized)
	language_changed.emit(normalized)


func t(key: String, fallback: String = "") -> String:
	var translations: Dictionary = UI.get(key, {})
	return str(translations.get(current_language, fallback if fallback != "" else key))


func relationship_name(key: String, is_known: bool = true) -> String:
	var source := RELATIONSHIP_NAMES if is_known else UNKNOWN_RELATIONSHIP_NAMES
	var translations: Dictionary = source.get(key, RELATIONSHIP_NAMES.get(key, {}))
	return str(translations.get(current_language, key))


func localize_dialogues(source_dialogues: Array) -> Array:
	var localized: Array = []
	localized.resize(source_dialogues.size())
	for i in range(source_dialogues.size()):
		localized[i] = localize_entry(source_dialogues[i])
	return localized


func localize_entry(source_entry: Dictionary) -> Dictionary:
	var localized: Dictionary = source_entry.duplicate(true)
	localized["_source_speaker"] = str(source_entry.get("speaker", ""))
	if current_language != "en":
		return localized
	var entry_id := str(source_entry.get("id", ""))
	var translation: Dictionary = _english_dialogues.get(entry_id, {})
	for field in ["speaker", "text", "summary_title", "continue_label", "save_label"]:
		if translation.has(field):
			localized[field] = translation[field]
	if translation.has("summary_lines"):
		localized["summary_lines"] = translation["summary_lines"].duplicate(true)
	if translation.has("choices") and localized.has("choices"):
		var translated_choices: Dictionary = {}
		for translated_choice in translation["choices"]:
			translated_choices[str(translated_choice.get("target", ""))] = str(translated_choice.get("text", ""))
		for choice in localized["choices"]:
			var target := str(choice.get("target", ""))
			if translated_choices.has(target):
				choice["text"] = translated_choices[target]
	return localized


func english_translation_count() -> int:
	return _english_dialogues.size()


func has_english_translation(entry_id: String) -> bool:
	return _english_dialogues.has(entry_id)


func _load_english_dialogues() -> void:
	_english_dialogues.clear()
	if not FileAccess.file_exists(ENGLISH_DIALOGUES_PATH):
		push_warning("English dialogue translation is missing: " + ENGLISH_DIALOGUES_PATH)
		return
	var file := FileAccess.open(ENGLISH_DIALOGUES_PATH, FileAccess.READ)
	var parsed = JSON.parse_string(file.get_as_text())
	if parsed is Dictionary:
		_english_dialogues = parsed
	else:
		push_error("English dialogue translation has invalid JSON")
