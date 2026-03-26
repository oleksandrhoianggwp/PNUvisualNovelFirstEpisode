extends Node

var current_dialogue_index: int = 0
var choices_made: Dictionary = {}
var player_name: String = "Player"

var settings: Dictionary = {
	"music_volume": 0.8,
	"sfx_volume": 0.8,
	"text_speed": 0.03,
	"display_mode": 0,
	"resolution": "1536x1024"
}

const SAVE_PATH = "user://save_data.cfg"
const SETTINGS_PATH = "user://settings.cfg"
const DB_PATH = "user://between_classes.db"

const DISPLAY_MODES = [
	Window.MODE_WINDOWED,
	Window.MODE_EXCLUSIVE_FULLSCREEN,
	Window.MODE_FULLSCREEN,
]

const RESOLUTIONS = [
	Vector2i(1920, 1080),
	Vector2i(1600, 900),
	Vector2i(1536, 1024),
	Vector2i(1366, 768),
	Vector2i(1280, 720),
	Vector2i(1024, 576),
]

var db = null


func _ready() -> void:
	_init_db()
	load_settings()
	# Delay apply_settings to next frame so window is fully ready
	call_deferred("apply_settings")


# ===========================================
#  DATABASE (optional — works without addon)
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
		CREATE TABLE IF NOT EXISTS game_saves (
			player_name TEXT PRIMARY KEY DEFAULT 'Player',
			dialogue_index INTEGER DEFAULT 0,
			chapter INTEGER DEFAULT 1,
			choices_made TEXT DEFAULT '{}',
			created_at TEXT DEFAULT (datetime('now')),
			updated_at TEXT DEFAULT (datetime('now'))
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
#  SAVE GAME
# ===========================================
func save_game() -> void:
	_save_local()
	_save_to_db()


func _save_local() -> void:
	var config = ConfigFile.new()
	config.set_value("progress", "dialogue_index", current_dialogue_index)
	config.set_value("progress", "choices_made", choices_made)
	config.save(SAVE_PATH)


func _save_to_db() -> void:
	if not db:
		return
	db.query_with_bindings("""
		INSERT OR REPLACE INTO game_saves (player_name, dialogue_index, chapter, choices_made, updated_at)
		VALUES (?, ?, 1, ?, datetime('now'));
	""", [player_name, current_dialogue_index, JSON.stringify(choices_made)])


# ===========================================
#  LOAD GAME
# ===========================================
func load_game() -> bool:
	if _load_from_db():
		return true
	return _load_local()


func _load_local() -> bool:
	var config = ConfigFile.new()
	if config.load(SAVE_PATH) != OK:
		return false
	current_dialogue_index = config.get_value("progress", "dialogue_index", 0)
	choices_made = config.get_value("progress", "choices_made", {})
	return true


func _load_from_db() -> bool:
	if not db:
		return false
	db.query_with_bindings(
		"SELECT dialogue_index, choices_made FROM game_saves WHERE player_name = ?;",
		[player_name]
	)
	if db.query_result.size() == 0:
		return false
	var row = db.query_result[0]
	current_dialogue_index = row.get("dialogue_index", 0)
	var choices_str = row.get("choices_made", "{}")
	var json = JSON.new()
	if json.parse(choices_str) == OK and json.data is Dictionary:
		choices_made = json.data
	return true


# ===========================================
#  HAS SAVE
# ===========================================
func has_save() -> bool:
	if db:
		db.query_with_bindings(
			"SELECT COUNT(*) as cnt FROM game_saves WHERE player_name = ?;",
			[player_name]
		)
		if db.query_result.size() > 0 and db.query_result[0].get("cnt", 0) > 0:
			return true
	return FileAccess.file_exists(SAVE_PATH)


# ===========================================
#  SETTINGS
# ===========================================
func save_settings() -> void:
	_save_settings_local()
	_save_settings_to_db()


func _save_settings_local() -> void:
	var config = ConfigFile.new()
	for key in settings:
		config.set_value("settings", key, settings[key])
	config.save(SETTINGS_PATH)


func _save_settings_to_db() -> void:
	if not db:
		return
	db.query_with_bindings("""
		INSERT OR REPLACE INTO game_settings
			(player_name, music_volume, sfx_volume, text_speed, display_mode, resolution, updated_at)
		VALUES (?, ?, ?, ?, ?, ?, datetime('now'));
	""", [
		player_name,
		settings["music_volume"],
		settings["sfx_volume"],
		settings["text_speed"],
		settings["display_mode"],
		settings["resolution"]
	])


func load_settings() -> void:
	_load_settings_local()
	_load_settings_from_db()


func _load_settings_local() -> void:
	var config = ConfigFile.new()
	if config.load(SETTINGS_PATH) != OK:
		return
	for key in settings:
		settings[key] = config.get_value("settings", key, settings[key])
	# Migrate old "fullscreen" boolean to new "display_mode" int
	if config.has_section_key("settings", "fullscreen") and not config.has_section_key("settings", "display_mode"):
		var was_fullscreen = config.get_value("settings", "fullscreen", false)
		settings["display_mode"] = 1 if was_fullscreen else 0


func _load_settings_from_db() -> void:
	if not db:
		return
	db.query_with_bindings(
		"SELECT * FROM game_settings WHERE player_name = ?;",
		[player_name]
	)
	if db.query_result.size() == 0:
		return
	var row = db.query_result[0]
	for key in settings:
		if row.has(key):
			settings[key] = row[key]


func apply_settings() -> void:
	# Audio
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("Master"),
		linear_to_db(settings["music_volume"])
	)

	# Display mode
	var mode_index = int(settings["display_mode"])
	if mode_index >= 0 and mode_index < DISPLAY_MODES.size():
		var target_mode = DISPLAY_MODES[mode_index]
		var current_mode = DisplayServer.window_get_mode()
		if current_mode != target_mode:
			DisplayServer.window_set_mode(target_mode)

	# Resolution (only in windowed mode)
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
		var res_str: String = str(settings["resolution"])
		var parts = res_str.split("x")
		if parts.size() == 2:
			var w = int(parts[0])
			var h = int(parts[1])
			if w > 0 and h > 0:
				DisplayServer.window_set_size(Vector2i(w, h))
				# Center window
				var screen_size = DisplayServer.screen_get_size()
				DisplayServer.window_set_position(Vector2i(
					(screen_size.x - w) / 2,
					(screen_size.y - h) / 2
				))
