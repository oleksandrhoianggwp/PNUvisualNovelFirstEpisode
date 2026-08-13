extends Control

const WarmUI = preload("res://scripts/ui/warm_ui.gd")

@onready var btn_new_game: Button = %BtnNewGame
@onready var btn_continue: Button = %BtnContinue
@onready var btn_load: Button = %BtnLoad
@onready var btn_choices: Button = %BtnChoices
@onready var btn_settings: Button = %BtnSettings
@onready var btn_exit: Button = %BtnExit
@onready var title_container: VBoxContainer = $TitleContainer
@onready var buttons_container: VBoxContainer = $ButtonsContainer
@onready var menu_card: PanelContainer = $MenuCard
@onready var mode_backdrop: PanelContainer = $ModeBackdrop
@onready var background: TextureRect = $Background
@onready var sun_wash: ColorRect = $SunWash

var _ambient_started := false

var _showing_slots: bool = false
var _showing_choices: bool = false

const BACKGROUND_ROOT := "res://Picture/background/"
const LEGACY_BACKGROUND_ALIASES := {
	"01_train_evening": "01_01_train",
	"02_station_platform_evening": "01_02_station_platform_sunset",
	"03_dormitory_exterior_evening": "01_04_dorm_evening",
	"04_dormitory_lobby": "01_05_dorm_reception",
	"05_dormitory_corridor_5f": "01_06_dorm_corridor",
	"06a_room_92_dark": "01_07_room_evening",
	"06b_room_92_light": "01_07_room_evening",
	"07_university_courtyard": "01_10_university_courtyard_day",
	"08_classroom": "01_11_classroom_01",
	"09_attic": "01_08_attic_room",
	"11_restaurant_evening": "01_12_restaurant",
	"01_room_92_morning": "01_09_room_morning",
	"02_university_entrance_area": "02_01_university_corridor",
	"03_staircase_corridor": "02_01_university_corridor",
	"04_classroom_first_lecture": "02_02_classroom_02",
	"05_assembly_hall": "02_03_assembly hall",
	"06_library": "02_04_library",
	"07_inner_courtyard": "02_05_inner_courtyard_day",
	"08_monument_alley": "02_05_inner_courtyard_day",
	"09_youth_center": "02_06_youth_center (1)",
	"10_university_front_gate": "02_05_inner_courtyard_day",
}


func _ready() -> void:
	GameManager.play_music("res://music/main menu/forget_me_not_looped.ogg")
	_apply_localized_ui()
	_create_language_switcher()
	btn_continue.visible = GameManager.has_save()
	btn_load.visible = GameManager.has_any_save()

	btn_new_game.pressed.connect(_on_new_game)
	btn_continue.pressed.connect(_on_continue)
	btn_load.pressed.connect(_on_load_slots)
	btn_choices.pressed.connect(_on_choice_flow)
	btn_settings.pressed.connect(_on_settings)
	btn_exit.pressed.connect(_on_exit)

	for button in [btn_new_game, btn_continue, btn_load, btn_choices, btn_settings, btn_exit]:
		_setup_button_style(button)

	_play_fade_in()


func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_F1:
			GameManager.start_chapter_1()
			get_tree().change_scene_to_file("res://scenes/game/game.tscn")
		elif event.keycode == KEY_F2:
			GameManager.start_chapter_2()
			get_tree().change_scene_to_file("res://scenes/game/game.tscn")
	if event.is_action_pressed("ui_cancel"):
		if _showing_slots:
			_hide_slots()
		elif _showing_choices:
			_hide_choice_flow()


func _setup_button_style(button: Button) -> void:
	WarmUI.style_button(button, button == btn_new_game, 20)


func _play_fade_in() -> void:
	background.scale = Vector2(1.045, 1.045)
	background.pivot_offset = background.size * 0.5
	menu_card.modulate = Color(1, 1, 1, 0)
	title_container.modulate = Color(1, 1, 1, 0)
	for btn in buttons_container.get_children():
		btn.modulate = Color(1, 1, 1, 0)
		btn.scale = Vector2(0.97, 0.97)

	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(background, "scale", Vector2.ONE, 5.0).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	tween.tween_property(menu_card, "modulate:a", 1.0, 0.55).set_delay(0.08).set_ease(Tween.EASE_OUT)
	tween.tween_property(title_container, "modulate:a", 1.0, 0.55).set_delay(0.18).set_ease(Tween.EASE_OUT)
	for i in range(buttons_container.get_child_count()):
		var btn = buttons_container.get_child(i)
		tween.tween_property(btn, "modulate:a", 1.0, 0.32).set_delay(0.34 + i * 0.055).set_ease(Tween.EASE_OUT)
		tween.tween_property(btn, "scale", Vector2.ONE, 0.38).set_delay(0.34 + i * 0.055).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	tween.finished.connect(_start_ambient_motion)


func _start_ambient_motion() -> void:
	if _ambient_started:
		return
	_ambient_started = true

	var background_tween := create_tween().set_loops()
	background_tween.tween_property(background, "scale", Vector2(1.02, 1.02), 12.0).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	background_tween.tween_property(background, "scale", Vector2.ONE, 12.0).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)

	var light_tween := create_tween().set_loops()
	light_tween.tween_property(sun_wash, "color:a", 0.13, 4.6).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	light_tween.tween_property(sun_wash, "color:a", 0.075, 4.6).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)

	var card_tween := create_tween().set_loops()
	card_tween.tween_property(menu_card, "modulate", Color(1.0, 0.985, 0.965, 0.975), 5.8).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	card_tween.tween_property(menu_card, "modulate", Color.WHITE, 5.8).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)


func _on_new_game() -> void:
	GameManager.start_chapter_1()
	get_tree().change_scene_to_file("res://scenes/game/game.tscn")


func _on_continue() -> void:
	if GameManager.load_game():
		get_tree().change_scene_to_file("res://scenes/game/game.tscn")


func _on_load_slots() -> void:
	_showing_slots = true
	_show_modal_layout()
	buttons_container.add_theme_constant_override("separation", 8)
	btn_new_game.visible = false
	btn_continue.visible = false
	btn_load.visible = false
	btn_choices.visible = false
	btn_settings.visible = false
	btn_exit.visible = false

	var slots = GameManager.get_all_slots()
	for i in range(slots.size()):
		var info = slots[i]
		var btn = _create_slot_button(info, i)
		var slot_id = i
		if not info["empty"]:
			btn.pressed.connect(func():
				GameManager.load_from_slot(slot_id)
				get_tree().change_scene_to_file("res://scenes/game/game.tscn")
			)
		buttons_container.add_child(btn)

	var back = Button.new()
	back.name = "SlotBack"
	back.text = Localization.t("common.back")
	back.custom_minimum_size = Vector2(330, 54)
	_setup_button_style(back)
	back.pressed.connect(_hide_slots)
	buttons_container.add_child(back)


func _create_slot_button(info: Dictionary, slot_id: int) -> Button:
	var btn = Button.new()
	btn.name = "Slot" + str(slot_id)
	btn.text = ""
	btn.custom_minimum_size = Vector2(540, 96)
	btn.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	btn.disabled = bool(info.get("empty", true))
	_setup_slot_button_style(btn)

	var margin = MarginContainer.new()
	margin.mouse_filter = Control.MOUSE_FILTER_IGNORE
	margin.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	margin.add_theme_constant_override("margin_left", 10)
	margin.add_theme_constant_override("margin_top", 10)
	margin.add_theme_constant_override("margin_right", 12)
	margin.add_theme_constant_override("margin_bottom", 10)
	btn.add_child(margin)

	var row = HBoxContainer.new()
	row.mouse_filter = Control.MOUSE_FILTER_IGNORE
	row.add_theme_constant_override("separation", 14)
	margin.add_child(row)

	var preview = TextureRect.new()
	preview.mouse_filter = Control.MOUSE_FILTER_IGNORE
	preview.custom_minimum_size = Vector2(168, 76)
	preview.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	preview.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED
	preview.texture = _slot_preview_texture(info)
	preview.modulate = Color(1, 1, 1, 0.42) if btn.disabled else Color(1, 1, 1, 0.92)
	row.add_child(preview)

	var text_box = VBoxContainer.new()
	text_box.mouse_filter = Control.MOUSE_FILTER_IGNORE
	text_box.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	text_box.alignment = BoxContainer.ALIGNMENT_CENTER
	text_box.add_theme_constant_override("separation", 4)
	row.add_child(text_box)

	var title = Label.new()
	title.mouse_filter = Control.MOUSE_FILTER_IGNORE
	title.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	title.add_theme_font_size_override("font_size", 19)
	title.add_theme_color_override("font_color", WarmUI.INK if not btn.disabled else Color(0.35, 0.3, 0.27, 0.5))
	text_box.add_child(title)

	var meta = Label.new()
	meta.mouse_filter = Control.MOUSE_FILTER_IGNORE
	meta.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	meta.add_theme_font_size_override("font_size", 14)
	meta.add_theme_color_override("font_color", WarmUI.INK_SOFT if not btn.disabled else Color(0.35, 0.3, 0.27, 0.42))
	text_box.add_child(meta)

	if btn.disabled:
		title.text = Localization.t("common.slot") % (slot_id + 1)
		meta.text = Localization.t("common.empty")
	else:
		var scene = str(info.get("scene_name", "?"))
		var saved_at = _format_saved_at(str(info.get("saved_at", "")))
		var chapter = int(info.get("chapter", 1))
		var rep = int(info.get("reputation", 0))
		title.text = Localization.t("common.slot_scene") % [slot_id + 1, scene]
		meta.text = Localization.t("common.slot_meta") % [chapter, rep, saved_at]

	return btn


func _setup_slot_button_style(button: Button) -> void:
	button.flat = false
	button.focus_mode = Control.FOCUS_ALL
	button.add_theme_color_override("font_color", Color(1, 1, 1, 0))
	button.add_theme_color_override("font_disabled_color", Color(1, 1, 1, 0))

	var normal = StyleBoxFlat.new()
	normal.bg_color = Color(1.0, 0.965, 0.88, 0.78)
	normal.border_color = Color(0.53, 0.27, 0.19, 0.34)
	normal.set_border_width_all(1)
	normal.set_corner_radius_all(14)
	button.add_theme_stylebox_override("normal", normal)

	var hover = normal.duplicate()
	hover.bg_color = Color(1.0, 0.985, 0.94, 0.96)
	hover.border_color = WarmUI.TERRACOTTA
	hover.set_border_width_all(2)
	button.add_theme_stylebox_override("hover", hover)

	var pressed = normal.duplicate()
	pressed.bg_color = WarmUI.PAPER
	pressed.border_color = WarmUI.TERRACOTTA_DARK
	pressed.set_border_width_all(2)
	button.add_theme_stylebox_override("pressed", pressed)

	var disabled = normal.duplicate()
	disabled.bg_color = Color(0.82, 0.76, 0.67, 0.32)
	disabled.border_color = Color(0.35, 0.28, 0.22, 0.2)
	button.add_theme_stylebox_override("disabled", disabled)


func _slot_preview_texture(info: Dictionary) -> Texture2D:
	if info.get("empty", true):
		return null
	var bg = str(info.get("background", ""))
	if bg == "":
		return null
	var normalized_bg = str(LEGACY_BACKGROUND_ALIASES.get(bg.trim_suffix(".png"), bg.trim_suffix(".png")))
	var path = bg if bg.begins_with("res://") else BACKGROUND_ROOT + normalized_bg + ".png"
	if ResourceLoader.exists(path):
		return load(path)
	return null


func _format_saved_at(value: String) -> String:
	var result = value.replace("T", " ")
	if result.length() > 16:
		result = result.substr(0, 16)
	return result


func _hide_slots() -> void:
	_showing_slots = false
	_restore_menu_layout()
	buttons_container.add_theme_constant_override("separation", 14)
	for child in buttons_container.get_children():
		if child.name.begins_with("Slot"):
			child.queue_free()
	btn_new_game.visible = true
	btn_continue.visible = GameManager.has_save()
	btn_load.visible = GameManager.has_any_save()
	btn_choices.visible = true
	btn_settings.visible = true
	btn_exit.visible = true


func _on_choice_flow() -> void:
	_showing_choices = true
	_show_modal_layout()
	buttons_container.add_theme_constant_override("separation", 8)
	btn_new_game.visible = false
	btn_continue.visible = false
	btn_load.visible = false
	btn_choices.visible = false
	btn_settings.visible = false
	btn_exit.visible = false

	var header = Label.new()
	header.name = "ChoiceHeader"
	header.text = Localization.t("main.choice_history")
	header.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	header.add_theme_font_size_override("font_size", 30)
	header.add_theme_color_override("font_color", WarmUI.TERRACOTTA_DARK)
	buttons_container.add_child(header)

	var flow = GameManager.get_choice_flow()
	for i in range(flow.size()):
		var card = _create_choice_card(flow[i], i)
		buttons_container.add_child(card)

	var back = Button.new()
	back.name = "ChoiceBack"
	back.text = Localization.t("common.back")
	back.custom_minimum_size = Vector2(340, 52)
	_setup_button_style(back)
	back.pressed.connect(_hide_choice_flow)
	buttons_container.add_child(back)


func _create_choice_card(info: Dictionary, index: int) -> Button:
	var btn = Button.new()
	btn.name = "Choice" + str(index)
	btn.text = ""
	btn.custom_minimum_size = Vector2(780, 86)
	btn.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	btn.disabled = not bool(info.get("unlocked", false))
	_setup_slot_button_style(btn)

	var margin = MarginContainer.new()
	margin.mouse_filter = Control.MOUSE_FILTER_IGNORE
	margin.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	margin.add_theme_constant_override("margin_left", 16)
	margin.add_theme_constant_override("margin_top", 10)
	margin.add_theme_constant_override("margin_right", 16)
	margin.add_theme_constant_override("margin_bottom", 10)
	btn.add_child(margin)

	var row = HBoxContainer.new()
	row.mouse_filter = Control.MOUSE_FILTER_IGNORE
	row.add_theme_constant_override("separation", 16)
	margin.add_child(row)

	var node_label = Label.new()
	node_label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	node_label.custom_minimum_size = Vector2(74, 0)
	node_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	node_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	node_label.text = Localization.t("main.node") % (index + 1)
	node_label.add_theme_font_size_override("font_size", 15)
	node_label.add_theme_color_override("font_color", WarmUI.TERRACOTTA_DARK if not btn.disabled else Color(0.35, 0.3, 0.27, 0.46))
	row.add_child(node_label)

	var text_box = VBoxContainer.new()
	text_box.mouse_filter = Control.MOUSE_FILTER_IGNORE
	text_box.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	text_box.alignment = BoxContainer.ALIGNMENT_CENTER
	text_box.add_theme_constant_override("separation", 4)
	row.add_child(text_box)

	var title = Label.new()
	title.mouse_filter = Control.MOUSE_FILTER_IGNORE
	title.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	title.add_theme_font_size_override("font_size", 18)
	title.add_theme_color_override("font_color", WarmUI.INK if not btn.disabled else Color(0.35, 0.3, 0.27, 0.46))
	title.text = Localization.t("main.choice_title") % [int(info.get("chapter", 1)), str(info.get("question", Localization.t("common.choice")))]
	text_box.add_child(title)

	var selected = Label.new()
	selected.mouse_filter = Control.MOUSE_FILTER_IGNORE
	selected.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	selected.add_theme_font_size_override("font_size", 15)
	selected.add_theme_color_override("font_color", WarmUI.SAGE if not btn.disabled else Color(0.35, 0.3, 0.27, 0.4))
	selected.text = (Localization.t("main.selected") % str(info.get("selected_text", ""))) if not btn.disabled else Localization.t("main.not_unlocked")
	text_box.add_child(selected)

	var choice_id = str(info.get("id", ""))
	if not btn.disabled:
		btn.pressed.connect(func():
			if GameManager.replay_from_choice(choice_id):
				get_tree().change_scene_to_file("res://scenes/game/game.tscn")
		)
	return btn


func _hide_choice_flow() -> void:
	_showing_choices = false
	_restore_menu_layout()
	buttons_container.add_theme_constant_override("separation", 14)
	for child in buttons_container.get_children():
		if child.name.begins_with("Choice"):
			child.queue_free()
	btn_new_game.visible = true
	btn_continue.visible = GameManager.has_save()
	btn_load.visible = GameManager.has_any_save()
	btn_choices.visible = true
	btn_settings.visible = true
	btn_exit.visible = true


func _show_modal_layout() -> void:
	title_container.visible = false
	menu_card.visible = false
	mode_backdrop.visible = true
	buttons_container.anchor_left = 0.5
	buttons_container.anchor_top = 0.5
	buttons_container.anchor_right = 0.5
	buttons_container.anchor_bottom = 0.5
	buttons_container.offset_left = -390.0
	buttons_container.offset_top = -390.0
	buttons_container.offset_right = 390.0
	buttons_container.offset_bottom = 390.0
	WarmUI.animate_in(mode_backdrop, 0.0, 0.24, 0.985)


func _restore_menu_layout() -> void:
	title_container.visible = true
	menu_card.visible = true
	mode_backdrop.visible = false
	buttons_container.anchor_left = 0.085
	buttons_container.anchor_top = 0.425
	buttons_container.anchor_right = 0.365
	buttons_container.anchor_bottom = 0.865
	buttons_container.offset_left = 0.0
	buttons_container.offset_top = 0.0
	buttons_container.offset_right = 0.0
	buttons_container.offset_bottom = 0.0


func _on_settings() -> void:
	get_tree().change_scene_to_file("res://scenes/settings/settings.tscn")


func _on_exit() -> void:
	get_tree().quit()


func _apply_localized_ui() -> void:
	$TitleContainer/Eyebrow.text = Localization.t("main.eyebrow")
	$TitleContainer/Title.text = Localization.t("main.title")
	$TitleContainer/Subtitle.text = Localization.t("main.subtitle")
	btn_new_game.text = Localization.t("main.new_game")
	btn_continue.text = Localization.t("main.continue")
	btn_load.text = Localization.t("main.load")
	btn_choices.text = Localization.t("main.choices")
	btn_settings.text = Localization.t("main.settings")
	btn_exit.text = Localization.t("main.exit")


func _create_language_switcher() -> void:
	var row := HBoxContainer.new()
	row.name = "LanguageSwitcher"
	row.set_anchors_preset(Control.PRESET_TOP_RIGHT)
	row.position = Vector2(-242, 28)
	row.size = Vector2(210, 48)
	row.add_theme_constant_override("separation", 8)
	add_child(row)
	for code in ["uk", "en"]:
		var button := Button.new()
		button.text = Localization.t("language.short_uk" if code == "uk" else "language.short_en")
		button.custom_minimum_size = Vector2(96, 44)
		button.disabled = Localization.current_language == code
		WarmUI.style_button(button, Localization.current_language == code, 16)
		button.pressed.connect(_change_language.bind(code))
		row.add_child(button)


func _change_language(code: String) -> void:
	GameManager.settings["language"] = code
	Localization.set_language(code)
	GameManager.save_settings()
	get_tree().reload_current_scene()
