extends Node

var current_dialogue_index: int = 0
var settings: Dictionary = {
	"music_volume": 0.8,
	"sfx_volume": 0.8,
	"text_speed": 0.03,
	"fullscreen": false
}

const SAVE_PATH = "user://save_data.cfg"
const SETTINGS_PATH = "user://settings.cfg"


func _ready() -> void:
	load_settings()
	apply_settings()


func save_game() -> void:
	var config = ConfigFile.new()
	config.set_value("progress", "dialogue_index", current_dialogue_index)
	config.save(SAVE_PATH)


func load_game() -> bool:
	var config = ConfigFile.new()
	if config.load(SAVE_PATH) != OK:
		return false
	current_dialogue_index = config.get_value("progress", "dialogue_index", 0)
	return true


func has_save() -> bool:
	return FileAccess.file_exists(SAVE_PATH)


func save_settings() -> void:
	var config = ConfigFile.new()
	for key in settings:
		config.set_value("settings", key, settings[key])
	config.save(SETTINGS_PATH)


func load_settings() -> void:
	var config = ConfigFile.new()
	if config.load(SETTINGS_PATH) != OK:
		return
	for key in settings:
		settings[key] = config.get_value("settings", key, settings[key])


func apply_settings() -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(settings["music_volume"]))
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN and not settings["fullscreen"]:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	elif settings["fullscreen"] and DisplayServer.window_get_mode() != DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
