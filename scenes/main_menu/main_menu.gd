extends Control

@onready var btn_new_game: Button = %BtnNewGame
@onready var btn_continue: Button = %BtnContinue
@onready var btn_load: Button = %BtnLoad
@onready var btn_choices: Button = %BtnChoices
@onready var btn_settings: Button = %BtnSettings
@onready var btn_exit: Button = %BtnExit
@onready var title_container: VBoxContainer = $TitleContainer
@onready var buttons_container: VBoxContainer = $ButtonsContainer

var _showing_slots: bool = false
var _showing_choices: bool = false


func _ready() -> void:
	GameManager.play_music("res://music/main menu/main_menu.mp3")
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
	button.add_theme_font_size_override("font_size", 22)
	button.add_theme_color_override("font_color", Color(0.9, 0.91, 0.96, 1))
	button.add_theme_color_override("font_hover_color", Color(1, 1, 1, 1))
	button.add_theme_color_override("font_pressed_color", Color(0.86, 0.8, 0.64, 1))
	button.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART

	var normal_style = StyleBoxFlat.new()
	normal_style.bg_color = Color(0.055, 0.058, 0.09, 0.82)
	normal_style.border_color = Color(0.42, 0.5, 0.68, 0.58)
	normal_style.set_border_width_all(1)
	normal_style.set_corner_radius_all(12)
	normal_style.set_content_margin_all(14)
	button.add_theme_stylebox_override("normal", normal_style)

	var hover_style = normal_style.duplicate()
	hover_style.bg_color = Color(0.105, 0.11, 0.16, 0.94)
	hover_style.border_color = Color(0.72, 0.84, 1.0, 0.9)
	hover_style.set_border_width_all(2)
	button.add_theme_stylebox_override("hover", hover_style)

	var pressed_style = normal_style.duplicate()
	pressed_style.bg_color = Color(0.045, 0.05, 0.075, 0.98)
	pressed_style.border_color = Color(0.92, 0.78, 0.42, 0.95)
	pressed_style.set_border_width_all(2)
	button.add_theme_stylebox_override("pressed", pressed_style)


func _play_fade_in() -> void:
	title_container.modulate = Color(1, 1, 1, 0)
	buttons_container.modulate = Color(1, 1, 1, 0)
	for btn in buttons_container.get_children():
		btn.modulate = Color(1, 1, 1, 0)

	var tween = create_tween()
	tween.tween_property(title_container, "modulate:a", 1.0, 0.65).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(buttons_container, "modulate:a", 1.0, 0.15).set_delay(0.25)
	for i in range(buttons_container.get_child_count()):
		var btn = buttons_container.get_child(i)
		tween.parallel().tween_property(btn, "modulate:a", 1.0, 0.35).set_delay(0.35 + i * 0.08).set_ease(Tween.EASE_OUT)


func _on_new_game() -> void:
	GameManager.start_chapter_1()
	get_tree().change_scene_to_file("res://scenes/game/game.tscn")


func _on_continue() -> void:
	if GameManager.load_game():
		get_tree().change_scene_to_file("res://scenes/game/game.tscn")


func _on_load_slots() -> void:
	_showing_slots = true
	buttons_container.offset_left = -270.0
	buttons_container.offset_right = 270.0
	buttons_container.offset_top = -670.0
	buttons_container.offset_bottom = -32.0
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
	back.text = "Назад"
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
	title.add_theme_color_override("font_color", Color(0.94, 0.94, 0.98, 1) if not btn.disabled else Color(0.62, 0.62, 0.66, 1))
	text_box.add_child(title)

	var meta = Label.new()
	meta.mouse_filter = Control.MOUSE_FILTER_IGNORE
	meta.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	meta.add_theme_font_size_override("font_size", 14)
	meta.add_theme_color_override("font_color", Color(0.72, 0.8, 0.94, 1) if not btn.disabled else Color(0.48, 0.48, 0.52, 1))
	text_box.add_child(meta)

	if btn.disabled:
		title.text = "Слот " + str(slot_id + 1)
		meta.text = "Порожній"
	else:
		var scene = str(info.get("scene_name", "?"))
		var saved_at = _format_saved_at(str(info.get("saved_at", "")))
		var chapter = int(info.get("chapter", 1))
		var rep = int(info.get("reputation", 0))
		title.text = "Слот " + str(slot_id + 1) + " - " + scene
		meta.text = "Розділ " + str(chapter) + "   реп. " + str(rep) + "   " + saved_at

	return btn


func _setup_slot_button_style(button: Button) -> void:
	button.flat = false
	button.focus_mode = Control.FOCUS_ALL
	button.add_theme_color_override("font_color", Color(1, 1, 1, 0))
	button.add_theme_color_override("font_disabled_color", Color(1, 1, 1, 0))

	var normal = StyleBoxFlat.new()
	normal.bg_color = Color(0.045, 0.05, 0.075, 0.78)
	normal.border_color = Color(0.45, 0.55, 0.74, 0.52)
	normal.set_border_width_all(1)
	normal.set_corner_radius_all(14)
	button.add_theme_stylebox_override("normal", normal)

	var hover = normal.duplicate()
	hover.bg_color = Color(0.085, 0.095, 0.135, 0.92)
	hover.border_color = Color(0.78, 0.86, 1.0, 0.92)
	hover.set_border_width_all(2)
	button.add_theme_stylebox_override("hover", hover)

	var pressed = normal.duplicate()
	pressed.bg_color = Color(0.035, 0.04, 0.065, 0.98)
	pressed.border_color = Color(0.92, 0.78, 0.42, 0.95)
	pressed.set_border_width_all(2)
	button.add_theme_stylebox_override("pressed", pressed)

	var disabled = normal.duplicate()
	disabled.bg_color = Color(0.05, 0.05, 0.058, 0.46)
	disabled.border_color = Color(0.35, 0.36, 0.42, 0.34)
	button.add_theme_stylebox_override("disabled", disabled)


func _slot_preview_texture(info: Dictionary) -> Texture2D:
	if info.get("empty", true):
		return null
	var bg = str(info.get("background", ""))
	if bg == "":
		return null
	var path = bg if bg.begins_with("res://") else "res://Picture/background/" + bg.trim_suffix(".png") + ".png"
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
	buttons_container.offset_left = -170.0
	buttons_container.offset_right = 170.0
	buttons_container.offset_top = -420.0
	buttons_container.offset_bottom = -76.0
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
	buttons_container.offset_left = -390.0
	buttons_container.offset_right = 390.0
	buttons_container.offset_top = -640.0
	buttons_container.offset_bottom = -36.0
	buttons_container.add_theme_constant_override("separation", 8)
	btn_new_game.visible = false
	btn_continue.visible = false
	btn_load.visible = false
	btn_choices.visible = false
	btn_settings.visible = false
	btn_exit.visible = false

	var header = Label.new()
	header.name = "ChoiceHeader"
	header.text = "Зроблені вибори"
	header.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	header.add_theme_font_size_override("font_size", 30)
	header.add_theme_color_override("font_color", Color(0.92, 0.78, 0.42, 1))
	buttons_container.add_child(header)

	var flow = GameManager.get_choice_flow()
	for i in range(flow.size()):
		var card = _create_choice_card(flow[i], i)
		buttons_container.add_child(card)

	var back = Button.new()
	back.name = "ChoiceBack"
	back.text = "Назад"
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
	node_label.text = "Вузол\n" + str(index + 1)
	node_label.add_theme_font_size_override("font_size", 15)
	node_label.add_theme_color_override("font_color", Color(0.92, 0.78, 0.42, 1) if not btn.disabled else Color(0.52, 0.52, 0.56, 1))
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
	title.add_theme_color_override("font_color", Color(0.94, 0.94, 0.98, 1) if not btn.disabled else Color(0.58, 0.58, 0.62, 1))
	title.text = "Розділ " + str(int(info.get("chapter", 1))) + " - " + str(info.get("question", "Вибір"))
	text_box.add_child(title)

	var selected = Label.new()
	selected.mouse_filter = Control.MOUSE_FILTER_IGNORE
	selected.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	selected.add_theme_font_size_override("font_size", 15)
	selected.add_theme_color_override("font_color", Color(0.72, 0.84, 1.0, 1) if not btn.disabled else Color(0.48, 0.48, 0.52, 1))
	selected.text = "Обрано: " + str(info.get("selected_text", "")) if not btn.disabled else "Ще не відкрито в поточному проходженні"
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
	buttons_container.offset_left = -170.0
	buttons_container.offset_right = 170.0
	buttons_container.offset_top = -420.0
	buttons_container.offset_bottom = -76.0
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


func _on_settings() -> void:
	get_tree().change_scene_to_file("res://scenes/settings/settings.tscn")


func _on_exit() -> void:
	get_tree().quit()
