extends Control

@onready var music_slider: HSlider = %MusicSlider
@onready var sfx_slider: HSlider = %SfxSlider
@onready var text_speed_slider: HSlider = %TextSpeedSlider
@onready var auto_delay_slider: HSlider = %AutoDelaySlider
@onready var textbox_opacity_slider: HSlider = %TextboxOpacitySlider
@onready var dialogue_font_size_slider: HSlider = %DialogueFontSizeSlider
@onready var ui_scale_slider: HSlider = %UiScaleSlider
@onready var inactive_alpha_slider: HSlider = %InactiveAlphaSlider
@onready var display_mode_option: OptionButton = %DisplayModeOption
@onready var resolution_option: OptionButton = %ResolutionOption
@onready var btn_back: Button = %BtnBack

const DISPLAY_MODE_NAMES = ["Віконний", "Повний екран", "Безрамковий"]


func _ready() -> void:
	display_mode_option.clear()
	for mode_name in DISPLAY_MODE_NAMES:
		display_mode_option.add_item(mode_name)

	resolution_option.clear()
	for res in GameManager.RESOLUTIONS:
		resolution_option.add_item(str(res.x) + "x" + str(res.y))

	music_slider.value = GameManager.settings["music_volume"]
	sfx_slider.value = GameManager.settings["sfx_volume"]
	text_speed_slider.value = GameManager.settings["text_speed"]
	auto_delay_slider.value = GameManager.settings.get("auto_delay", 1.35)
	textbox_opacity_slider.value = GameManager.settings.get("textbox_opacity", 0.84)
	dialogue_font_size_slider.value = GameManager.settings.get("dialogue_font_size", 30)
	ui_scale_slider.value = GameManager.settings.get("ui_scale", 1.0)
	inactive_alpha_slider.value = GameManager.settings.get("inactive_character_alpha", 0.82)
	display_mode_option.selected = int(GameManager.settings["display_mode"])
	_select_current_resolution()
	_update_resolution_visibility()

	music_slider.value_changed.connect(_on_music_changed)
	sfx_slider.value_changed.connect(_on_sfx_changed)
	text_speed_slider.value_changed.connect(_on_text_speed_changed)
	auto_delay_slider.value_changed.connect(_on_auto_delay_changed)
	textbox_opacity_slider.value_changed.connect(_on_textbox_opacity_changed)
	dialogue_font_size_slider.value_changed.connect(_on_dialogue_font_size_changed)
	ui_scale_slider.value_changed.connect(_on_ui_scale_changed)
	inactive_alpha_slider.value_changed.connect(_on_inactive_alpha_changed)
	display_mode_option.item_selected.connect(_on_display_mode_changed)
	resolution_option.item_selected.connect(_on_resolution_changed)
	btn_back.pressed.connect(_on_back)

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
	resolution_option.get_parent().visible = display_mode_option.selected == 0


func _setup_dark_button(button: Button) -> void:
	button.add_theme_font_size_override("font_size", 20)
	button.add_theme_color_override("font_color", Color(0.9, 0.91, 0.96, 1))
	button.add_theme_color_override("font_hover_color", Color(1, 1, 1, 1))

	var normal_style = StyleBoxFlat.new()
	normal_style.bg_color = Color(0.055, 0.058, 0.09, 0.86)
	normal_style.border_color = Color(0.42, 0.5, 0.68, 0.58)
	normal_style.set_border_width_all(1)
	normal_style.set_corner_radius_all(12)
	normal_style.set_content_margin_all(12)
	button.add_theme_stylebox_override("normal", normal_style)

	var hover_style = normal_style.duplicate()
	hover_style.bg_color = Color(0.105, 0.11, 0.16, 0.96)
	hover_style.border_color = Color(0.72, 0.84, 1.0, 0.9)
	hover_style.set_border_width_all(2)
	button.add_theme_stylebox_override("hover", hover_style)

	var pressed_style = normal_style.duplicate()
	pressed_style.bg_color = Color(0.045, 0.05, 0.075, 0.98)
	pressed_style.border_color = Color(0.92, 0.78, 0.42, 0.95)
	pressed_style.set_border_width_all(2)
	button.add_theme_stylebox_override("pressed", pressed_style)


func _setup_dark_option_button(opt: OptionButton) -> void:
	opt.add_theme_color_override("font_color", Color(0.9, 0.91, 0.96, 1))
	opt.add_theme_color_override("font_hover_color", Color(1, 1, 1, 1))

	var style = StyleBoxFlat.new()
	style.bg_color = Color(0.07, 0.075, 0.11, 0.92)
	style.border_color = Color(0.42, 0.5, 0.68, 0.58)
	style.set_border_width_all(1)
	style.set_corner_radius_all(10)
	style.set_content_margin_all(10)
	opt.add_theme_stylebox_override("normal", style)

	var hover_style = style.duplicate()
	hover_style.bg_color = Color(0.105, 0.11, 0.16, 0.96)
	hover_style.border_color = Color(0.72, 0.84, 1.0, 0.9)
	opt.add_theme_stylebox_override("hover", hover_style)


func _on_music_changed(value: float) -> void:
	GameManager.settings["music_volume"] = value
	GameManager.apply_settings()


func _on_sfx_changed(value: float) -> void:
	GameManager.settings["sfx_volume"] = value


func _on_text_speed_changed(value: float) -> void:
	GameManager.settings["text_speed"] = value


func _on_auto_delay_changed(value: float) -> void:
	GameManager.settings["auto_delay"] = value


func _on_textbox_opacity_changed(value: float) -> void:
	GameManager.settings["textbox_opacity"] = value


func _on_dialogue_font_size_changed(value: float) -> void:
	GameManager.settings["dialogue_font_size"] = int(value)


func _on_ui_scale_changed(value: float) -> void:
	GameManager.settings["ui_scale"] = value


func _on_inactive_alpha_changed(value: float) -> void:
	GameManager.settings["inactive_character_alpha"] = value


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
