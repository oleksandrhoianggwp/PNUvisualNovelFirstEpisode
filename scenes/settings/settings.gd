extends Control

@onready var music_slider: HSlider = %MusicSlider
@onready var sfx_slider: HSlider = %SfxSlider
@onready var text_speed_slider: HSlider = %TextSpeedSlider
@onready var display_mode_option: OptionButton = %DisplayModeOption
@onready var resolution_option: OptionButton = %ResolutionOption
@onready var btn_back: Button = %BtnBack

const DISPLAY_MODE_NAMES = ["Віконний", "Повний екран", "Безрамковий"]


func _ready() -> void:
	# Populate display mode dropdown
	display_mode_option.clear()
	for mode_name in DISPLAY_MODE_NAMES:
		display_mode_option.add_item(mode_name)

	# Populate resolution dropdown
	resolution_option.clear()
	for res in GameManager.RESOLUTIONS:
		resolution_option.add_item(str(res.x) + "x" + str(res.y))

	# Set current values
	music_slider.value = GameManager.settings["music_volume"]
	sfx_slider.value = GameManager.settings["sfx_volume"]
	text_speed_slider.value = GameManager.settings["text_speed"]
	display_mode_option.selected = GameManager.settings["display_mode"]
	_select_current_resolution()
	_update_resolution_visibility()

	# Connect signals
	music_slider.value_changed.connect(_on_music_changed)
	sfx_slider.value_changed.connect(_on_sfx_changed)
	text_speed_slider.value_changed.connect(_on_text_speed_changed)
	display_mode_option.item_selected.connect(_on_display_mode_changed)
	resolution_option.item_selected.connect(_on_resolution_changed)
	btn_back.pressed.connect(_on_back)

	# Styling
	_setup_dark_button(btn_back)
	_setup_dark_option_button(display_mode_option)
	_setup_dark_option_button(resolution_option)


func _select_current_resolution() -> void:
	var current_res = GameManager.settings["resolution"]
	for i in range(GameManager.RESOLUTIONS.size()):
		var res = GameManager.RESOLUTIONS[i]
		if str(res.x) + "x" + str(res.y) == current_res:
			resolution_option.selected = i
			return
	resolution_option.selected = 0


func _update_resolution_visibility() -> void:
	# Resolution only matters in windowed mode
	var is_windowed = display_mode_option.selected == 0
	resolution_option.get_parent().visible = is_windowed


func _setup_dark_button(button: Button) -> void:
	button.add_theme_font_size_override("font_size", 20)
	button.add_theme_color_override("font_color", Color(0.88, 0.9, 0.95, 1))
	button.add_theme_color_override("font_hover_color", Color(1, 1, 1, 1))

	var normal_style = StyleBoxFlat.new()
	normal_style.bg_color = Color(0.1, 0.1, 0.15, 0.75)
	normal_style.border_color = Color(0.35, 0.38, 0.5, 0.6)
	normal_style.set_border_width_all(1)
	normal_style.set_corner_radius_all(10)
	normal_style.set_content_margin_all(12)
	button.add_theme_stylebox_override("normal", normal_style)

	var hover_style = StyleBoxFlat.new()
	hover_style.bg_color = Color(0.15, 0.15, 0.22, 0.9)
	hover_style.border_color = Color(0.5, 0.55, 0.75, 0.9)
	hover_style.set_border_width_all(2)
	hover_style.set_corner_radius_all(10)
	hover_style.set_content_margin_all(12)
	button.add_theme_stylebox_override("hover", hover_style)

	var pressed_style = StyleBoxFlat.new()
	pressed_style.bg_color = Color(0.08, 0.08, 0.12, 0.95)
	pressed_style.border_color = Color(0.55, 0.6, 0.8, 1.0)
	pressed_style.set_border_width_all(2)
	pressed_style.set_corner_radius_all(10)
	pressed_style.set_content_margin_all(12)
	button.add_theme_stylebox_override("pressed", pressed_style)


func _setup_dark_option_button(opt: OptionButton) -> void:
	opt.add_theme_color_override("font_color", Color(0.88, 0.9, 0.95, 1))
	opt.add_theme_color_override("font_hover_color", Color(1, 1, 1, 1))

	var style = StyleBoxFlat.new()
	style.bg_color = Color(0.12, 0.12, 0.18, 0.9)
	style.border_color = Color(0.35, 0.38, 0.5, 0.6)
	style.set_border_width_all(1)
	style.set_corner_radius_all(8)
	style.set_content_margin_all(10)
	opt.add_theme_stylebox_override("normal", style)

	var hover_style = StyleBoxFlat.new()
	hover_style.bg_color = Color(0.15, 0.15, 0.22, 0.95)
	hover_style.border_color = Color(0.5, 0.55, 0.75, 0.9)
	hover_style.set_border_width_all(1)
	hover_style.set_corner_radius_all(8)
	hover_style.set_content_margin_all(10)
	opt.add_theme_stylebox_override("hover", hover_style)


func _on_music_changed(value: float) -> void:
	GameManager.settings["music_volume"] = value
	GameManager.apply_settings()


func _on_sfx_changed(value: float) -> void:
	GameManager.settings["sfx_volume"] = value


func _on_text_speed_changed(value: float) -> void:
	GameManager.settings["text_speed"] = value


func _on_display_mode_changed(index: int) -> void:
	GameManager.settings["display_mode"] = index
	_update_resolution_visibility()
	GameManager.apply_settings()


func _on_resolution_changed(index: int) -> void:
	if index >= 0 and index < GameManager.RESOLUTIONS.size():
		var res = GameManager.RESOLUTIONS[index]
		GameManager.settings["resolution"] = str(res.x) + "x" + str(res.y)
		GameManager.apply_settings()


func _on_back() -> void:
	GameManager.save_settings()
	get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn")
