extends Node

const DialogueData = preload("res://scripts/dialogue/dialogue_data.gd")

var current_dialogue_index: int = 0
var current_dialogue_id: String = "ch1_001"
var current_chapter: int = 1
var current_background: String = ""
var visible_characters: Dictionary = {"left": "", "center": "", "right": ""}
var choices_made: Dictionary = {}
var flags: Dictionary = {}
var player_name: String = "Player"

var reputation: int = 0
var relationships: Dictionary = {
	"daria": 0,
	"maria": 0,
	"anna": 0,
	"melania": 0,
	"marta": 0,
	"oksana": 0,
	"lidiya": 0,
	"watchwoman": 0,
	"silhouette_boy": 0,
	"vira": 0,
	"luka": 0,
	"demyan": 0,
	"roksolana": 0,
	"olena_serhiivna": 0,
	"curator": 0,
}

var settings: Dictionary = {
	"music_volume": 0.8,
	"sfx_volume": 0.8,
	"text_speed": 0.025,
	"auto_delay": 1.35,
	"textbox_opacity": 0.84,
	"dialogue_font_size": 30,
	"dialogue_font_family": "Default",
	"ui_scale": 1.0,
	"inactive_character_alpha": 0.82,
	"display_mode": 0,
	"resolution": "1536x1024"
}

const MAX_SLOTS = 5
const SETTINGS_PATH = "user://settings.cfg"
const SAVE_PATH = "user://save_slots.cfg"
const DB_PATH = "user://between_classes.db"

const DISPLAY_MODES = [
	Window.MODE_WINDOWED,
	Window.MODE_EXCLUSIVE_FULLSCREEN,
	Window.MODE_FULLSCREEN,
]

const RELATIONSHIP_NAMES = {
	"daria": "Дарія",
	"maria": "Марія",
	"anna": "Анна",
	"melania": "Меланія",
	"marta": "Марта",
	"oksana": "Оксана",
	"lidiya": "Лідія Іванівна",
	"watchwoman": "Вахтерка",
	"silhouette_boy": "Хлопець",
	"vira": "Віра",
	"luka": "Лука",
	"demyan": "Дем'ян",
	"roksolana": "Роксолана",
	"olena_serhiivna": "Олена Сергіївна",
	"curator": "Кураторка",
}

var RESOLUTIONS: Array[Vector2i] = []
var db = null
var _music_player: AudioStreamPlayer
var _current_music: String = ""


func _ready() -> void:
	_music_player = AudioStreamPlayer.new()
	_music_player.bus = "Master"
	add_child(_music_player)
	_build_resolutions()
	_init_db()
	load_settings()
	call_deferred("apply_settings")


func play_music(path: String) -> void:
	if path == _current_music and _music_player.playing:
		return
	if not ResourceLoader.exists(path):
		push_warning("Music file not found: " + path)
		return
	_current_music = path
	_music_player.stream = load(path)
	_music_player.volume_db = linear_to_db(settings["music_volume"])
	_music_player.play()


func stop_music() -> void:
	_music_player.stop()
	_current_music = ""


func _build_resolutions() -> void:
	var base = [
		Vector2i(1920, 1080),
		Vector2i(1600, 900),
		Vector2i(1536, 1024),
		Vector2i(1366, 768),
		Vector2i(1280, 720),
		Vector2i(1024, 576),
	]
	var native = Vector2i(DisplayServer.screen_get_size())
	RESOLUTIONS.clear()
	if not base.has(native):
		RESOLUTIONS.append(native)
	for r in base:
		RESOLUTIONS.append(r)


func get_scene_name(dialogue_idx: int = current_dialogue_index) -> String:
	if current_chapter == 2:
		return "Розділ 2"
	if current_dialogue_id.begins_with("ch2_"):
		return "Розділ 2"
	if current_dialogue_id.begins_with("ch1_"):
		return "Розділ 1"
	return "Сцена " + str(dialogue_idx + 1)


func update_current_entry(entry: Dictionary, index: int) -> void:
	current_dialogue_index = index
	current_dialogue_id = str(entry.get("id", current_dialogue_id))
	current_chapter = int(entry.get("chapter", current_chapter))
	current_background = str(entry.get("bg", current_background))
	visible_characters = {
		"left": str(entry.get("left", "")),
		"center": str(entry.get("center", "")),
		"right": str(entry.get("right", "")),
	}


func apply_effects(effects: Dictionary) -> Array[Dictionary]:
	var notifications: Array[Dictionary] = []
	for key in effects:
		var value = int(effects[key])
		if value == 0:
			continue
		if key == "reputation":
			reputation += value
			notifications.append({"text": "Репутація", "value": value})
		elif relationships.has(key):
			relationships[key] += value
			var display_name = RELATIONSHIP_NAMES.get(key, key)
			notifications.append({"text": display_name, "value": value})
	return notifications


func reset_progress() -> void:
	current_dialogue_index = 0
	current_dialogue_id = DialogueData.get_start_id(1)
	current_chapter = 1
	current_background = ""
	visible_characters = {"left": "", "center": "", "right": ""}
	choices_made = {}
	flags = {}
	reputation = 0
	for key in relationships:
		relationships[key] = 0


func start_chapter_1() -> void:
	reset_progress()


func start_chapter_2() -> void:
	current_dialogue_id = DialogueData.get_start_id(2)
	current_dialogue_index = _find_dialogue_index(current_dialogue_id)
	current_chapter = 2
	current_background = ""
	visible_characters = {"left": "", "center": "", "right": ""}


func jump_to_scene(scene_id: String) -> void:
	var idx = _find_dialogue_index(scene_id)
	if idx >= 0:
		current_dialogue_index = idx
		current_dialogue_id = scene_id
		var entry = DialogueData.DIALOGUES[idx]
		current_chapter = int(entry.get("chapter", current_chapter))
		current_background = str(entry.get("bg", current_background))


func replay_from_choice(choice_id: String) -> bool:
	var target_index = _find_dialogue_index(choice_id)
	if target_index < 0:
		return false
	var previous_choices = _get_choice_map_from_progress()
	reset_progress()
	var kept_choices: Dictionary = {}
	for entry in DialogueData.DIALOGUES:
		var entry_id = str(entry.get("id", ""))
		var entry_index = _find_dialogue_index(entry_id)
		if entry_index >= target_index:
			break
		if entry.has("choices") and previous_choices.has(entry_id):
			var selected_target = str(previous_choices[entry_id])
			for choice in entry["choices"]:
				if str(choice.get("target", "")) == selected_target:
					if choice.has("effects"):
						apply_effects(choice["effects"])
					kept_choices[entry_id] = selected_target
					break
	choices_made = kept_choices
	jump_to_scene(choice_id)
	return true


func get_choice_flow() -> Array[Dictionary]:
	var made_choices = _get_choice_map_from_progress()
	var flow: Array[Dictionary] = []
	for entry in DialogueData.DIALOGUES:
		if not entry.has("choices"):
			continue
		var entry_id = str(entry.get("id", ""))
		var selected_target = str(made_choices.get(entry_id, ""))
		var selected_text = ""
		for choice in entry["choices"]:
			if str(choice.get("target", "")) == selected_target:
				selected_text = str(choice.get("text", ""))
				break
		flow.append({
			"id": entry_id,
			"chapter": int(entry.get("chapter", 1)),
			"question": str(entry.get("text", "Вибір")),
			"background": str(entry.get("bg", "")),
			"choices": entry.get("choices", []),
			"selected_target": selected_target,
			"selected_text": selected_text,
			"unlocked": selected_target != "",
		})
	return flow


func _get_choice_map_from_progress() -> Dictionary:
	if not choices_made.is_empty():
		return choices_made.duplicate()
	var latest = _get_latest_slot_with_choices()
	if not latest.is_empty():
		return latest
	return {}


func _get_latest_slot_with_choices() -> Dictionary:
	if db:
		db.query("SELECT choices_made FROM save_slots ORDER BY saved_at DESC LIMIT 1;")
		if db.query_result.size() > 0:
			var parsed = _parse_json_dict(db.query_result[0].get("choices_made", "{}"))
			if not parsed.is_empty():
				return parsed

	var config = ConfigFile.new()
	if config.load(SAVE_PATH) != OK:
		return {}
	var best_time = ""
	var best_choices: Dictionary = {}
	for i in range(MAX_SLOTS):
		var section = "slot_" + str(i)
		if not config.has_section(section):
			continue
		var slot_choices = config.get_value(section, "choices_made", {})
		if slot_choices.is_empty():
			continue
		var saved_at = str(config.get_value(section, "saved_at", ""))
		if saved_at >= best_time:
			best_time = saved_at
			best_choices = slot_choices
	return best_choices


func _find_dialogue_index(scene_id: String) -> int:
	for i in range(DialogueData.DIALOGUES.size()):
		if str(DialogueData.DIALOGUES[i].get("id", "")) == scene_id:
			return i
	return -1


func _fallback_background(dialogue_id: String, dialogue_index: int) -> String:
	var idx = _find_dialogue_index(dialogue_id)
	if idx < 0:
		idx = dialogue_index
	if idx >= 0 and idx < DialogueData.DIALOGUES.size():
		return str(DialogueData.DIALOGUES[idx].get("bg", ""))
	return ""


func _init_db() -> void:
	if not ClassDB.class_exists("SQLite"):
		push_warning("godot-sqlite addon not found. Using ConfigFile only.")
		return

	db = ClassDB.instantiate("SQLite")
	db.path = DB_PATH
	if not db.open_db():
		push_warning("Failed to open SQLite database.")
		db = null
		return

	db.query("""
		CREATE TABLE IF NOT EXISTS save_slots (
			slot_id INTEGER PRIMARY KEY,
			dialogue_index INTEGER DEFAULT 0,
			dialogue_id TEXT DEFAULT 'ch1_001',
			chapter INTEGER DEFAULT 1,
			scene_name TEXT DEFAULT '',
			background TEXT DEFAULT '',
			visible_characters TEXT DEFAULT '{}',
			choices_made TEXT DEFAULT '{}',
			flags TEXT DEFAULT '{}',
			reputation INTEGER DEFAULT 0,
			relationships TEXT DEFAULT '{}',
			saved_at TEXT DEFAULT (datetime('now'))
		);
	""")
	_ensure_save_column("dialogue_id", "TEXT DEFAULT 'ch1_001'")
	_ensure_save_column("background", "TEXT DEFAULT ''")
	_ensure_save_column("visible_characters", "TEXT DEFAULT '{}'")
	_ensure_save_column("flags", "TEXT DEFAULT '{}'")

	db.query("""
		CREATE TABLE IF NOT EXISTS game_settings (
			player_name TEXT PRIMARY KEY DEFAULT 'Player',
			music_volume REAL DEFAULT 0.8,
			sfx_volume REAL DEFAULT 0.8,
			text_speed REAL DEFAULT 0.025,
			display_mode INTEGER DEFAULT 0,
			resolution TEXT DEFAULT '1536x1024',
			updated_at TEXT DEFAULT (datetime('now'))
		);
	""")


func _ensure_save_column(column_name: String, column_sql: String) -> void:
	if not db:
		return
	db.query("PRAGMA table_info(save_slots);")
	for row in db.query_result:
		if str(row.get("name", "")) == column_name:
			return
	db.query("ALTER TABLE save_slots ADD COLUMN " + column_name + " " + column_sql + ";")


func save_to_slot(slot_id: int) -> void:
	var scene = get_scene_name(current_dialogue_index)
	var config = ConfigFile.new()
	var section = "slot_" + str(slot_id)
	config.load(SAVE_PATH)
	config.set_value(section, "dialogue_index", current_dialogue_index)
	config.set_value(section, "dialogue_id", current_dialogue_id)
	config.set_value(section, "chapter", current_chapter)
	config.set_value(section, "background", current_background)
	config.set_value(section, "visible_characters", visible_characters)
	config.set_value(section, "choices_made", choices_made)
	config.set_value(section, "flags", flags)
	config.set_value(section, "reputation", reputation)
	config.set_value(section, "relationships", relationships)
	config.set_value(section, "scene_name", scene)
	config.set_value(section, "saved_at", Time.get_datetime_string_from_system(false, true))
	config.save(SAVE_PATH)

	if db:
		db.query_with_bindings("""
			INSERT OR REPLACE INTO save_slots
				(slot_id, dialogue_index, dialogue_id, chapter, scene_name, background,
				 visible_characters, choices_made, flags, reputation, relationships, saved_at)
			VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, datetime('now'));
		""", [
			slot_id, current_dialogue_index, current_dialogue_id, current_chapter, scene,
			current_background, JSON.stringify(visible_characters), JSON.stringify(choices_made),
			JSON.stringify(flags), reputation, JSON.stringify(relationships)
		])


func load_from_slot(slot_id: int) -> bool:
	if _load_slot_from_db(slot_id):
		return true
	return _load_slot_local(slot_id)


func _load_slot_local(slot_id: int) -> bool:
	var config = ConfigFile.new()
	if config.load(SAVE_PATH) != OK:
		return false
	var section = "slot_" + str(slot_id)
	if not config.has_section(section):
		return false
	current_dialogue_id = str(config.get_value(section, "dialogue_id", ""))
	current_dialogue_index = int(config.get_value(section, "dialogue_index", 0))
	if current_dialogue_id != "":
		current_dialogue_index = _find_dialogue_index(current_dialogue_id)
	current_chapter = int(config.get_value(section, "chapter", 1))
	current_background = str(config.get_value(section, "background", ""))
	visible_characters = config.get_value(section, "visible_characters", {"left": "", "center": "", "right": ""})
	choices_made = config.get_value(section, "choices_made", {})
	flags = config.get_value(section, "flags", {})
	reputation = int(config.get_value(section, "reputation", 0))
	var loaded_rels = config.get_value(section, "relationships", {})
	_merge_relationships(loaded_rels)
	return true


func _load_slot_from_db(slot_id: int) -> bool:
	if not db:
		return false
	db.query_with_bindings("SELECT * FROM save_slots WHERE slot_id = ?;", [slot_id])
	if db.query_result.size() == 0:
		return false
	var row = db.query_result[0]
	current_dialogue_id = str(row.get("dialogue_id", ""))
	current_dialogue_index = int(row.get("dialogue_index", 0))
	if current_dialogue_id != "":
		current_dialogue_index = _find_dialogue_index(current_dialogue_id)
	current_chapter = int(row.get("chapter", 1))
	current_background = str(row.get("background", ""))
	reputation = int(row.get("reputation", 0))
	choices_made = _parse_json_dict(row.get("choices_made", "{}"))
	flags = _parse_json_dict(row.get("flags", "{}"))
	visible_characters = _parse_json_dict(row.get("visible_characters", "{}"))
	_merge_relationships(_parse_json_dict(row.get("relationships", "{}")))
	return true


func _parse_json_dict(value) -> Dictionary:
	var json = JSON.new()
	if json.parse(str(value)) == OK and json.data is Dictionary:
		return json.data
	return {}


func _merge_relationships(loaded_rels: Dictionary) -> void:
	if loaded_rels.has("lydia") and not loaded_rels.has("lidiya"):
		relationships["lidiya"] = int(loaded_rels["lydia"])
	for key in relationships:
		if loaded_rels.has(key):
			relationships[key] = int(loaded_rels[key])


func get_all_slots() -> Array[Dictionary]:
	var slots: Array[Dictionary] = []
	for i in range(MAX_SLOTS):
		slots.append(get_slot_info(i))
	return slots


func get_slot_info(slot_id: int) -> Dictionary:
	if db:
		db.query_with_bindings(
			"SELECT slot_id, scene_name, dialogue_index, dialogue_id, chapter, background, reputation, saved_at FROM save_slots WHERE slot_id = ?;",
			[slot_id]
		)
		if db.query_result.size() > 0:
			var row = db.query_result[0]
			return {
				"slot_id": slot_id,
				"empty": false,
				"scene_name": row.get("scene_name", ""),
				"dialogue_index": row.get("dialogue_index", 0),
				"dialogue_id": row.get("dialogue_id", ""),
				"chapter": row.get("chapter", 1),
				"background": str(row.get("background", "")) if str(row.get("background", "")) != "" else _fallback_background(str(row.get("dialogue_id", "")), int(row.get("dialogue_index", 0))),
				"reputation": row.get("reputation", 0),
				"saved_at": row.get("saved_at", ""),
			}

	var config = ConfigFile.new()
	if config.load(SAVE_PATH) == OK:
		var section = "slot_" + str(slot_id)
		if config.has_section(section):
			return {
				"slot_id": slot_id,
				"empty": false,
				"scene_name": config.get_value(section, "scene_name", ""),
				"dialogue_index": config.get_value(section, "dialogue_index", 0),
				"dialogue_id": config.get_value(section, "dialogue_id", ""),
				"chapter": config.get_value(section, "chapter", 1),
				"background": str(config.get_value(section, "background", "")) if str(config.get_value(section, "background", "")) != "" else _fallback_background(str(config.get_value(section, "dialogue_id", "")), int(config.get_value(section, "dialogue_index", 0))),
				"reputation": config.get_value(section, "reputation", 0),
				"saved_at": config.get_value(section, "saved_at", ""),
			}
	return {"slot_id": slot_id, "empty": true}


func has_any_save() -> bool:
	for i in range(MAX_SLOTS):
		var info = get_slot_info(i)
		if not info["empty"]:
			return true
	return false


func save_game() -> void:
	save_to_slot(0)


func load_game() -> bool:
	return load_from_slot(0)


func has_save() -> bool:
	return not get_slot_info(0)["empty"]


func save_settings() -> void:
	var config = ConfigFile.new()
	for key in settings:
		config.set_value("settings", key, settings[key])
	config.save(SETTINGS_PATH)
	if db:
		db.query_with_bindings("""
			INSERT OR REPLACE INTO game_settings
				(player_name, music_volume, sfx_volume, text_speed, display_mode, resolution, updated_at)
			VALUES (?, ?, ?, ?, ?, ?, datetime('now'));
		""", [player_name, settings["music_volume"], settings["sfx_volume"],
			  settings["text_speed"], settings["display_mode"], settings["resolution"]])


func load_settings() -> void:
	var config = ConfigFile.new()
	if config.load(SETTINGS_PATH) == OK:
		for key in settings:
			settings[key] = config.get_value("settings", key, settings[key])
		if config.has_section_key("settings", "fullscreen") and not config.has_section_key("settings", "display_mode"):
			settings["display_mode"] = 1 if config.get_value("settings", "fullscreen", false) else 0
	if db:
		db.query_with_bindings("SELECT * FROM game_settings WHERE player_name = ?;", [player_name])
		if db.query_result.size() > 0:
			var row = db.query_result[0]
			for key in settings:
				if row.has(key):
					settings[key] = row[key]


func apply_settings() -> void:
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("Master"),
		linear_to_db(settings["music_volume"])
	)
	if _music_player:
		_music_player.volume_db = linear_to_db(settings["music_volume"])

	var mode_index = int(settings["display_mode"])
	if mode_index >= 0 and mode_index < DISPLAY_MODES.size():
		var target_mode = DISPLAY_MODES[mode_index]
		if DisplayServer.window_get_mode() != target_mode:
			DisplayServer.window_set_mode(target_mode)
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
		var parts = str(settings["resolution"]).split("x")
		if parts.size() == 2:
			var w = int(parts[0])
			var h = int(parts[1])
			if w > 0 and h > 0:
				DisplayServer.window_set_size(Vector2i(w, h))
				var ss = DisplayServer.screen_get_size()
				DisplayServer.window_set_position(Vector2i((ss.x - w) / 2, (ss.y - h) / 2))
