extends Node

var current_dialogue_index: int = 0
var choices_made: Dictionary = {}
var player_name: String = "Player"

var reputation: int = 0
var relationships: Dictionary = {
	"maria": 0,
	"anna": 0,
	"melania": 0,
	"marta": 0,
	"oksana": 0,
	"lydia": 0,
}

var settings: Dictionary = {
	"music_volume": 0.8,
	"sfx_volume": 0.8,
	"text_speed": 0.03,
	"display_mode": 0,
	"resolution": "1536x1024"
}

const MAX_SLOTS = 5
const SETTINGS_PATH = "user://settings.cfg"
const DB_PATH = "user://between_classes.db"

const DISPLAY_MODES = [
	Window.MODE_WINDOWED,
	Window.MODE_EXCLUSIVE_FULLSCREEN,
	Window.MODE_FULLSCREEN,
]

var RESOLUTIONS: Array[Vector2i] = []

# Map dialogue index ranges to scene names for save display
const SCENE_NAMES = {
	0: "Потяг",
	6: "Перон",
	13: "Гуртожиток (зовні)",
	28: "Хол гуртожитку",
	37: "Коридор 5-го поверху",
	45: "Кімната 92 (темна)",
	55: "Кімната 92",
	68: "Знайомство з Марією та Анною",
	99: "Вечір у кімнаті",
	120: "Ранок",
	134: "Подвір'я університету",
	151: "Аудиторія",
	177: "Спогад з дитинства",
	180: "Після лекції",
	189: "Ресторан",
	209: "Дорога додому",
}

const RELATIONSHIP_NAMES = {
	"maria": "Марія",
	"anna": "Анна",
	"melania": "Меланія",
	"marta": "Марта",
	"oksana": "Оксана",
	"lydia": "Лідія Іванівна",
}

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
	var has_native = false
	for r in base:
		if r == native:
			has_native = true
			break
	if not has_native:
		RESOLUTIONS.append(native)
	for r in base:
		RESOLUTIONS.append(r)


func get_scene_name(dialogue_idx: int) -> String:
	var result = "Початок"
	for threshold in SCENE_NAMES:
		if dialogue_idx >= threshold:
			result = SCENE_NAMES[threshold]
	return result


# ===========================================
#  EFFECTS
# ===========================================
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
	choices_made = {}
	reputation = 0
	for key in relationships:
		relationships[key] = 0


# ===========================================
#  DATABASE (optional)
# ===========================================
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
			chapter INTEGER DEFAULT 1,
			scene_name TEXT DEFAULT '',
			choices_made TEXT DEFAULT '{}',
			reputation INTEGER DEFAULT 0,
			relationships TEXT DEFAULT '{}',
			saved_at TEXT DEFAULT (datetime('now'))
		);
	""")

	db.query("""
		CREATE TABLE IF NOT EXISTS game_settings (
			player_name TEXT PRIMARY KEY DEFAULT 'Player',
			music_volume REAL DEFAULT 0.8,
			sfx_volume REAL DEFAULT 0.8,
			text_speed REAL DEFAULT 0.03,
			display_mode INTEGER DEFAULT 0,
			resolution TEXT DEFAULT '1536x1024',
			updated_at TEXT DEFAULT (datetime('now'))
		);
	""")


# ===========================================
#  SAVE/LOAD SLOTS
# ===========================================
func save_to_slot(slot_id: int) -> void:
	var scene = get_scene_name(current_dialogue_index)
	# ConfigFile
	var config = ConfigFile.new()
	var section = "slot_" + str(slot_id)
	config.load("user://save_slots.cfg")
	config.set_value(section, "dialogue_index", current_dialogue_index)
	config.set_value(section, "choices_made", choices_made)
	config.set_value(section, "reputation", reputation)
	config.set_value(section, "relationships", relationships)
	config.set_value(section, "scene_name", scene)
	config.set_value(section, "saved_at", Time.get_datetime_string_from_system(false, true))
	config.save("user://save_slots.cfg")
	# SQLite
	if db:
		db.query_with_bindings("""
			INSERT OR REPLACE INTO save_slots
				(slot_id, dialogue_index, chapter, scene_name, choices_made, reputation, relationships, saved_at)
			VALUES (?, ?, 1, ?, ?, ?, ?, datetime('now'));
		""", [slot_id, current_dialogue_index, scene,
			  JSON.stringify(choices_made), reputation, JSON.stringify(relationships)])


func load_from_slot(slot_id: int) -> bool:
	if _load_slot_from_db(slot_id):
		return true
	return _load_slot_local(slot_id)


func _load_slot_local(slot_id: int) -> bool:
	var config = ConfigFile.new()
	if config.load("user://save_slots.cfg") != OK:
		return false
	var section = "slot_" + str(slot_id)
	if not config.has_section(section):
		return false
	current_dialogue_index = config.get_value(section, "dialogue_index", 0)
	choices_made = config.get_value(section, "choices_made", {})
	reputation = config.get_value(section, "reputation", 0)
	var loaded_rels = config.get_value(section, "relationships", {})
	for key in relationships:
		if loaded_rels.has(key):
			relationships[key] = loaded_rels[key]
	return true


func _load_slot_from_db(slot_id: int) -> bool:
	if not db:
		return false
	db.query_with_bindings(
		"SELECT * FROM save_slots WHERE slot_id = ?;",
		[slot_id]
	)
	if db.query_result.size() == 0:
		return false
	var row = db.query_result[0]
	current_dialogue_index = row.get("dialogue_index", 0)
	reputation = row.get("reputation", 0)
	var json = JSON.new()
	if json.parse(row.get("choices_made", "{}")) == OK and json.data is Dictionary:
		choices_made = json.data
	var json2 = JSON.new()
	if json2.parse(row.get("relationships", "{}")) == OK and json2.data is Dictionary:
		for key in relationships:
			if json2.data.has(key):
				relationships[key] = json2.data[key]
	return true


func get_all_slots() -> Array[Dictionary]:
	var slots: Array[Dictionary] = []
	for i in range(MAX_SLOTS):
		slots.append(get_slot_info(i))
	return slots


func get_slot_info(slot_id: int) -> Dictionary:
	# Try DB first
	if db:
		db.query_with_bindings(
			"SELECT slot_id, scene_name, dialogue_index, reputation, saved_at FROM save_slots WHERE slot_id = ?;",
			[slot_id]
		)
		if db.query_result.size() > 0:
			var row = db.query_result[0]
			return {
				"slot_id": slot_id,
				"empty": false,
				"scene_name": row.get("scene_name", ""),
				"dialogue_index": row.get("dialogue_index", 0),
				"reputation": row.get("reputation", 0),
				"saved_at": row.get("saved_at", ""),
			}
	# Fallback to ConfigFile
	var config = ConfigFile.new()
	if config.load("user://save_slots.cfg") == OK:
		var section = "slot_" + str(slot_id)
		if config.has_section(section):
			return {
				"slot_id": slot_id,
				"empty": false,
				"scene_name": config.get_value(section, "scene_name", ""),
				"dialogue_index": config.get_value(section, "dialogue_index", 0),
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


# ===========================================
#  QUICK SAVE (auto-save to slot 0)
# ===========================================
func save_game() -> void:
	save_to_slot(0)


func load_game() -> bool:
	return load_from_slot(0)


func has_save() -> bool:
	return not get_slot_info(0)["empty"]


# ===========================================
#  SETTINGS
# ===========================================
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
