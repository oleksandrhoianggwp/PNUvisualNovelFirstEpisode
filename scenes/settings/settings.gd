extends Control

const WarmUI = preload("res://scripts/ui/warm_ui.gd")

@onready var music_slider: HSlider = %MusicSlider
@onready var sfx_slider: HSlider = %SfxSlider
@onready var text_speed_slider: HSlider = %TextSpeedSlider
@onready var auto_delay_slider: HSlider = %AutoDelaySlider
@onready var textbox_opacity_slider: HSlider = %TextboxOpacitySlider
@onready var dialogue_font_size_slider: HSlider = %DialogueFontSizeSlider
@onready var font_family_option: OptionButton = %FontFamilyOption
@onready var ui_scale_slider: HSlider = %UiScaleSlider
@onready var inactive_alpha_slider: HSlider = %InactiveAlphaSlider
@onready var display_mode_option: OptionButton = %DisplayModeOption
@onready var display_hint: Label = %DisplayHint
@onready var resolution_option: OptionButton = %ResolutionOption
@onready var btn_back: Button = %BtnBack
@onready var shell: PanelContainer = $CenterContainer/Shell
@onready var background: TextureRect = $Background
@onready var page_host: HBoxContainer = $CenterContainer/Shell/OuterMargin/Root/Columns
@onready var left_column: VBoxContainer = $CenterContainer/Shell/OuterMargin/Root/Columns/LeftColumn
@onready var right_column: VBoxContainer = $CenterContainer/Shell/OuterMargin/Root/Columns/RightColumn
@onready var header_mark: Label = $CenterContainer/Shell/OuterMargin/Root/Header/HeaderMark
@onready var tab_audio: Button = %TabAudio
@onready var tab_text: Button = %TabText
@onready var tab_visual: Button = %TabVisual
@onready var tab_display: Button = %TabDisplay

var _tab_pages: Array[PanelContainer] = []
var _tab_buttons: Array[Button] = []
var _active_tab := -1
var _ambient_started := false

const DISPLAY_MODE_NAMES = ["У вікні", "Повний екран", "Без рамки"]
const DISPLAY_MODE_HINTS = [
	"Звичайне вікно Windows. Зручно, якщо треба швидко перемикатись між програмами.",
	"Exclusive fullscreen. Гра займає весь екран і може перемкнути режим дисплея.",
	"Вікно без рамки на весь екран. Виглядає як fullscreen, але Alt+Tab зазвичай м'якший.",
]
const FONT_FAMILY_NAMES = [
	"Default",
	"Segoe UI",
	"Arial",
	"Verdana",
	"Tahoma",
	"Georgia",
	"Times New Roman",
	"Consolas",
]


func _ready() -> void:
	display_mode_option.clear()
	for mode_name in DISPLAY_MODE_NAMES:
		display_mode_option.add_item(mode_name)

	font_family_option.clear()
	for font_name in FONT_FAMILY_NAMES:
		font_family_option.add_item(font_name)

	resolution_option.clear()
	for res in GameManager.RESOLUTIONS:
		resolution_option.add_item(str(res.x) + "x" + str(res.y))

	music_slider.value = GameManager.settings["music_volume"]
	sfx_slider.value = GameManager.settings["sfx_volume"]
	text_speed_slider.value = GameManager.settings["text_speed"]
	auto_delay_slider.value = GameManager.settings.get("auto_delay", 1.35)
	textbox_opacity_slider.value = GameManager.settings.get("textbox_opacity", 0.84)
	dialogue_font_size_slider.value = GameManager.settings.get("dialogue_font_size", 30)
	_select_current_font_family()
	ui_scale_slider.value = GameManager.settings.get("ui_scale", 1.0)
	inactive_alpha_slider.value = GameManager.settings.get("inactive_character_alpha", 0.82)
	display_mode_option.selected = int(GameManager.settings["display_mode"])
	_select_current_resolution()
	_update_resolution_visibility()
	_update_display_hint()

	music_slider.value_changed.connect(_on_music_changed)
	sfx_slider.value_changed.connect(_on_sfx_changed)
	text_speed_slider.value_changed.connect(_on_text_speed_changed)
	auto_delay_slider.value_changed.connect(_on_auto_delay_changed)
	textbox_opacity_slider.value_changed.connect(_on_textbox_opacity_changed)
	dialogue_font_size_slider.value_changed.connect(_on_dialogue_font_size_changed)
	font_family_option.item_selected.connect(_on_font_family_changed)
	ui_scale_slider.value_changed.connect(_on_ui_scale_changed)
	inactive_alpha_slider.value_changed.connect(_on_inactive_alpha_changed)
	display_mode_option.item_selected.connect(_on_display_mode_changed)
	resolution_option.item_selected.connect(_on_resolution_changed)
	btn_back.pressed.connect(_on_back)

	_setup_dark_button(btn_back)
	_setup_dark_option_button(display_mode_option)
	_setup_dark_option_button(font_family_option)
	_setup_dark_option_button(resolution_option)
	_style_settings_screen()
	_setup_tabs()
	_play_entrance()


func _select_current_resolution() -> void:
	var current_res = GameManager.settings["resolution"]
	for i in range(GameManager.RESOLUTIONS.size()):
		var res = GameManager.RESOLUTIONS[i]
		if str(res.x) + "x" + str(res.y) == current_res:
			resolution_option.selected = i
			return
	resolution_option.selected = 0


func _select_current_font_family() -> void:
	var current_font = str(GameManager.settings.get("dialogue_font_family", "Default"))
	for i in range(FONT_FAMILY_NAMES.size()):
		if FONT_FAMILY_NAMES[i] == current_font:
			font_family_option.selected = i
			return
	font_family_option.selected = 0


func _update_resolution_visibility() -> void:
	resolution_option.get_parent().visible = display_mode_option.selected == 0


func _update_display_hint() -> void:
	var index = clampi(display_mode_option.selected, 0, DISPLAY_MODE_HINTS.size() - 1)
	display_hint.text = DISPLAY_MODE_HINTS[index]


func _setup_dark_button(button: Button) -> void:
	WarmUI.style_button(button, true, 18)


func _setup_dark_option_button(opt: OptionButton) -> void:
	WarmUI.style_option(opt)


func _style_settings_screen() -> void:
	var panels = [
		%AudioPanel,
		%TextPanel,
		%VisualPanel,
		%DisplayPanel,
		%SettingsNote,
	]
	for panel in panels:
		_setup_section_panel(panel)
		_style_section_children(panel)

	for slider in [
		music_slider,
		sfx_slider,
		text_speed_slider,
		auto_delay_slider,
		textbox_opacity_slider,
		dialogue_font_size_slider,
		ui_scale_slider,
		inactive_alpha_slider,
	]:
		_setup_slider_style(slider)


func _setup_section_panel(panel: PanelContainer) -> void:
	var style := WarmUI.panel_style(0.56, 18, false)
	style.bg_color = Color(1.0, 0.985, 0.94, 0.56)
	panel.add_theme_stylebox_override("panel", style)


func _style_section_children(root: Node) -> void:
	for child in root.get_children():
		if child is Label:
			var label := child as Label
			if label.name.ends_with("Title"):
				label.add_theme_font_size_override("font_size", 22)
				label.add_theme_color_override("font_color", WarmUI.TERRACOTTA_DARK)
			else:
				label.add_theme_font_size_override("font_size", 16)
				label.add_theme_color_override("font_color", WarmUI.INK_SOFT)
		_style_section_children(child)


func _setup_slider_style(slider: HSlider) -> void:
	WarmUI.style_slider(slider)


func _setup_tabs() -> void:
	_tab_pages = [%AudioPanel, %TextPanel, %VisualPanel, %DisplayPanel]
	_tab_buttons = [tab_audio, tab_text, tab_visual, tab_display]
	var descriptions := [
		"Збалансуй фонову музику та звуки інтерфейсу.",
		"Налаштуй темп і читабельність діалогів.",
		"Зміни прозорість, масштаб і фокус персонажів.",
		"Обери зручний режим вікна та роздільність.",
	]
	var content_boxes := [
		%AudioPanel.get_node("Margin/AudioBox"),
		%TextPanel.get_node("Margin/TextBox"),
		%VisualPanel.get_node("Margin/VisualBox"),
		%DisplayPanel.get_node("Margin/DisplayBox"),
	]

	for i in range(_tab_pages.size()):
		var page := _tab_pages[i]
		page.reparent(page_host)
		page.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		page.size_flags_vertical = Control.SIZE_EXPAND_FILL
		page.visible = false

		var description := Label.new()
		description.text = descriptions[i]
		description.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		description.add_theme_font_size_override("font_size", 16)
		description.add_theme_color_override("font_color", Color(0.37, 0.29, 0.24, 0.72))
		content_boxes[i].add_child(description)
		content_boxes[i].move_child(description, 1)
		content_boxes[i].add_theme_constant_override("separation", 18)

		_tab_buttons[i].pressed.connect(_switch_tab.bind(i))

	left_column.visible = false
	right_column.visible = false
	_switch_tab(0, false)


func _switch_tab(index: int, animated := true) -> void:
	if index < 0 or index >= _tab_pages.size() or index == _active_tab:
		return
	_active_tab = index
	for i in range(_tab_pages.size()):
		var selected := i == index
		_tab_pages[i].visible = selected
		WarmUI.style_button(_tab_buttons[i], selected, 17)

	if animated:
		var page := _tab_pages[index]
		page.modulate = Color(1, 1, 1, 0)
		page.scale = Vector2(0.992, 0.992)
		page.pivot_offset = page.size * 0.5
		var tween := create_tween().set_parallel(true)
		tween.tween_property(page, "modulate:a", 1.0, 0.24).set_ease(Tween.EASE_OUT)
		tween.tween_property(page, "scale", Vector2.ONE, 0.32).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)


func _play_entrance() -> void:
	background.scale = Vector2(1.035, 1.035)
	background.pivot_offset = background.size * 0.5
	WarmUI.animate_in(shell, 0.08, 0.42, 0.985)
	var tween := create_tween()
	tween.tween_property(background, "scale", Vector2.ONE, 4.5).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	tween.finished.connect(_start_ambient_animation)


func _start_ambient_animation() -> void:
	if _ambient_started:
		return
	_ambient_started = true

	var background_tween := create_tween().set_loops()
	background_tween.tween_property(background, "scale", Vector2(1.018, 1.018), 11.0).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	background_tween.tween_property(background, "scale", Vector2.ONE, 11.0).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)

	var sparkle_tween := create_tween().set_loops()
	sparkle_tween.tween_property(header_mark, "modulate:a", 0.42, 1.8).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	sparkle_tween.tween_property(header_mark, "modulate:a", 1.0, 1.8).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)


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


func _on_font_family_changed(index: int) -> void:
	if index >= 0 and index < FONT_FAMILY_NAMES.size():
		GameManager.settings["dialogue_font_family"] = FONT_FAMILY_NAMES[index]


func _on_ui_scale_changed(value: float) -> void:
	GameManager.settings["ui_scale"] = value


func _on_inactive_alpha_changed(value: float) -> void:
	GameManager.settings["inactive_character_alpha"] = value


func _on_display_mode_changed(index: int) -> void:
	GameManager.settings["display_mode"] = index
	_update_resolution_visibility()
	_update_display_hint()
	GameManager.apply_settings()


func _on_resolution_changed(index: int) -> void:
	if index >= 0 and index < GameManager.RESOLUTIONS.size():
		var res = GameManager.RESOLUTIONS[index]
		GameManager.settings["resolution"] = str(res.x) + "x" + str(res.y)
		GameManager.apply_settings()


func _on_back() -> void:
	GameManager.save_settings()
	get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn")
