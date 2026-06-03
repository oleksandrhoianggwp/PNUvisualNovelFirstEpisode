extends Control

@onready var background: TextureRect = $Background
@onready var background_next: TextureRect = $BackgroundNext
@onready var character_left: TextureRect = $CharacterLeft
@onready var character_center: TextureRect = $CharacterCenter
@onready var character_right: TextureRect = $CharacterRight
@onready var dialogue_box: PanelContainer = $DialogueBox
@onready var speaker_name: Label = $DialogueBox/MarginContainer/VBoxContainer/SpeakerName
@onready var dialogue_text: RichTextLabel = $DialogueBox/MarginContainer/VBoxContainer/DialogueText
@onready var choice_container: VBoxContainer = $ChoiceContainer
@onready var screen_flash: ColorRect = $ScreenFlash
@onready var system_plaque: PanelContainer = $SystemPlaque
@onready var plaque_text: Label = $SystemPlaque/MarginContainer/HBoxContainer/PlaqueText
@onready var notification_container: VBoxContainer = $NotificationContainer
@onready var pause_overlay: ColorRect = $PauseOverlay
@onready var choice_timer_label: Label = $ChoiceTimerLabel
@onready var summary_overlay: ColorRect = $SummaryOverlay
@onready var summary_box: VBoxContainer = $SummaryOverlay/SummaryBox
@onready var btn_resume: Button = %BtnResume
@onready var btn_save: Button = %BtnSave
@onready var btn_load: Button = %BtnLoad
@onready var btn_auto: Button = %BtnAuto
@onready var btn_skip: Button = %BtnSkip
@onready var btn_main_menu: Button = %BtnMainMenu

const DialogueData = preload("res://scripts/dialogue/dialogue_data.gd")

const SPEAKER_FOLDERS := {
	"Дарія": ["daria_main"],
	"Марія": ["maria"],
	"Анна": ["anna"],
	"Меланія": ["melania"],
	"Марта": ["marta"],
	"Оксана": ["oksana"],
	"Лідія Іванівна": ["lidiya_ivanivna", "Lydia_Ivanovna"],
	"Вахтерка": ["watchwoman"],
	"Хлопець": ["dorm_boy_silhouette", "strangerNearTheHostel"],
	"Віра": ["vira"],
	"Лука": ["luka"],
	"Дем'ян": ["demyan"],
	"Роксолана": ["roksolana"],
	"Олена Сергіївна": ["olena_serhiivna"],
	"Кураторка": ["curator"],
}

var dialogue_data: Array = []
var id_to_index: Dictionary = {}
var current_index: int = 0
var is_typing: bool = false
var full_text: String = ""
var current_bg: String = ""
var choices_made: Dictionary = {}
var is_paused: bool = false
var _choice_time_left: float = 0.0
var _slot_mode: String = ""
var _loaded_textures: Dictionary = {}
var _prev_chars: Dictionary = {"left": "", "center": "", "right": ""}
var _auto_mode: bool = false
var _skip_mode: bool = false
var _auto_elapsed: float = 0.0
var _skip_elapsed: float = 0.0


func _ready() -> void:
	dialogue_data = DialogueData.DIALOGUES
	_build_id_map()
	_apply_runtime_layout()

	current_index = clampi(GameManager.current_dialogue_index, 0, max(dialogue_data.size() - 1, 0))
	if GameManager.current_dialogue_id != "":
		current_index = _target_to_index(GameManager.current_dialogue_id, current_index)
	choices_made = GameManager.choices_made.duplicate()

	choice_container.visible = false
	system_plaque.visible = false
	pause_overlay.visible = false
	summary_overlay.visible = false
	choice_timer_label.visible = false
	dialogue_box.modulate = Color(1, 1, 1, 0)
	background_next.modulate = Color(1, 1, 1, 0)
	for node in _character_nodes():
		node.modulate = Color(1, 1, 1, 0)
		node.visible = false

	_setup_pause_button(btn_resume)
	_setup_pause_button(btn_save)
	_setup_pause_button(btn_load)
	_setup_pause_button(btn_auto)
	_setup_pause_button(btn_skip)
	_setup_pause_button(btn_main_menu)
	btn_resume.pressed.connect(_on_resume)
	btn_save.pressed.connect(_on_save)
	btn_load.pressed.connect(_on_load)
	btn_auto.pressed.connect(_on_auto)
	btn_skip.pressed.connect(_on_skip)
	btn_main_menu.pressed.connect(_on_main_menu)

	_show_dialogue()


func _process(delta: float) -> void:
	if _choice_time_left > 0 and choice_container.visible:
		_choice_time_left -= delta
		choice_timer_label.text = str(ceili(_choice_time_left))
		if _choice_time_left <= 0:
			_choice_time_expired()

	if is_paused or summary_overlay.visible or choice_container.visible or system_plaque.visible:
		return
	if _auto_mode and not is_typing:
		_auto_elapsed += delta
		if _auto_elapsed >= float(GameManager.settings.get("auto_delay", 1.35)):
			_auto_elapsed = 0.0
			_advance_dialogue()
	if _skip_mode and not is_typing:
		_skip_elapsed += delta
		if _skip_elapsed >= 0.12:
			_skip_elapsed = 0.0
			_advance_dialogue()


func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_F1:
			GameManager.start_chapter_1()
			get_tree().change_scene_to_file("res://scenes/game/game.tscn")
			return
		elif event.keycode == KEY_F2:
			GameManager.start_chapter_2()
			get_tree().change_scene_to_file("res://scenes/game/game.tscn")
			return
		elif event.keycode == KEY_F9:
			print("Relationships: ", GameManager.relationships)
			return
	if event.is_action_pressed("ui_cancel"):
		_toggle_pause()
		return
	if is_paused or summary_overlay.visible:
		return
	if event.is_action_pressed("ui_accept") or (event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT):
		if choice_container.visible:
			return
		if system_plaque.visible:
			system_plaque.visible = false
			_advance_dialogue()
			return
		if is_typing:
			dialogue_text.visible_ratio = 1.0
			is_typing = false
		else:
			_advance_dialogue()


func _build_id_map() -> void:
	id_to_index.clear()
	for i in range(dialogue_data.size()):
		var entry = dialogue_data[i]
		var entry_id = str(entry.get("id", ""))
		if entry_id != "":
			id_to_index[entry_id] = i


func _apply_runtime_layout() -> void:
	var ui_scale = clampf(float(GameManager.settings.get("ui_scale", 1.0)), 0.85, 1.2)
	var dialogue_font_size = int(GameManager.settings.get("dialogue_font_size", 30))

	var dialogue_style = StyleBoxFlat.new()
	dialogue_style.bg_color = Color(0.059, 0.051, 0.086, float(GameManager.settings.get("textbox_opacity", 0.84)))
	dialogue_style.border_color = Color(0.44, 0.55, 0.68, 0.45)
	dialogue_style.set_border_width_all(1)
	dialogue_style.set_corner_radius_all(22)
	dialogue_style.set_content_margin_all(0)
	dialogue_box.add_theme_stylebox_override("panel", dialogue_style)
	dialogue_box.scale = Vector2(ui_scale, ui_scale)
	choice_container.scale = Vector2(ui_scale, ui_scale)

	dialogue_text.add_theme_color_override("default_color", Color(0.95, 0.93, 0.97, 1))
	dialogue_text.add_theme_font_size_override("normal_font_size", dialogue_font_size)
	dialogue_text.add_theme_constant_override("line_separation", 8)
	dialogue_text.fit_content = true
	speaker_name.add_theme_font_size_override("font_size", dialogue_font_size)
	speaker_name.add_theme_color_override("font_color", Color(0.72, 0.84, 1.0, 1))


func _advance_dialogue() -> void:
	if current_index < 0 or current_index >= dialogue_data.size():
		_go_to_main_menu()
		return
	var entry = dialogue_data[current_index]
	_go_to_target(entry.get("target", entry.get("next", current_index + 1)))


func _go_to_target(target) -> void:
	if str(target) == "main_menu":
		GameManager.save_game()
		_go_to_main_menu()
		return
	var next_index = _target_to_index(target, current_index + 1)
	_go_to_index(next_index)


func _go_to_index(next_index: int) -> void:
	current_index = next_index
	if current_index >= dialogue_data.size():
		GameManager.save_game()
		_go_to_main_menu()
		return
	_show_dialogue()


func _show_dialogue() -> void:
	if current_index < 0 or current_index >= dialogue_data.size():
		_go_to_main_menu()
		return

	var entry = dialogue_data[current_index]
	if entry.has("condition") and not _condition_met(entry["condition"]):
		_go_to_target(entry.get("next", current_index + 1))
		return

	GameManager.update_current_entry(entry, current_index)
	GameManager.choices_made = choices_made.duplicate()

	var entry_type = entry.get("type", "dialogue")
	var transition = entry.get("transition", "none")
	_apply_background(str(entry.get("bg", "")), transition)
	_apply_characters(entry)

	if entry.has("effects") and not _entry_effect_already_applied(entry):
		_apply_entry_effects(entry)

	if entry_type == "summary":
		dialogue_box.visible = false
		system_plaque.visible = false
		choice_container.visible = false
		_show_summary(entry)
		return

	if entry_type == "system":
		dialogue_box.visible = false
		_show_system_plaque(str(entry.get("text", "")))
		if entry.has("choices"):
			_show_choices(entry["choices"])
		return

	system_plaque.visible = false
	choice_container.visible = false
	choice_timer_label.visible = false
	_setup_text_style(entry_type)
	_show_text_entry(entry)


func _apply_background(bg_key: String, transition: String) -> void:
	if bg_key == "" or bg_key == current_bg:
		return
	var bg_path = _resolve_background_path(bg_key)
	var tex = _get_texture(bg_path)
	if tex:
		if (transition == "fade" or transition == "crossfade") and current_bg != "":
			_crossfade_bg(tex)
		elif transition == "flash":
			_flash_and_set_bg(tex)
		else:
			background.texture = tex
	current_bg = bg_key


func _apply_characters(entry: Dictionary) -> void:
	var chars = {
		"left": str(entry.get("left", "")),
		"center": str(entry.get("center", "")),
		"right": str(entry.get("right", "")),
	}
	_animate_character(character_left, chars["left"], _prev_chars["left"])
	_animate_character(character_center, chars["center"], _prev_chars["center"])
	_animate_character(character_right, chars["right"], _prev_chars["right"])
	_prev_chars = chars
	_apply_speaker_focus(str(entry.get("speaker", "")), chars)


func _show_text_entry(entry: Dictionary) -> void:
	var has_text = str(entry.get("text", "")) != ""
	dialogue_box.visible = has_text
	if not has_text:
		if entry.has("choices"):
			_show_choices(entry["choices"])
		return

	var speaker = str(entry.get("speaker", ""))
	speaker_name.text = speaker
	speaker_name.visible = speaker != ""
	full_text = str(entry["text"])
	var entry_type = str(entry.get("type", "dialogue"))
	if entry_type == "narrator":
		dialogue_text.text = "[i]" + full_text + "[/i]"
	elif entry_type == "thought":
		dialogue_text.text = "[i]«" + full_text + "»[/i]"
	else:
		dialogue_text.text = full_text

	dialogue_text.visible_ratio = 0.0
	is_typing = true
	_auto_elapsed = 0.0
	_skip_elapsed = 0.0

	if dialogue_box.modulate.a < 0.99:
		dialogue_box.modulate = Color(1, 1, 1, 0)
		var tween = create_tween()
		tween.tween_property(dialogue_box, "modulate:a", 1.0, 0.22).set_ease(Tween.EASE_OUT)
		tween.finished.connect(_type_text)
	else:
		_type_text()

	if entry.has("choices"):
		await get_tree().process_frame
		await _wait_for_typing_finished()
		_show_choices(entry["choices"])


func _wait_for_typing_finished() -> void:
	while is_typing:
		await get_tree().process_frame


func _setup_text_style(entry_type: String) -> void:
	match entry_type:
		"narrator":
			dialogue_text.add_theme_color_override("default_color", Color(0.82, 0.84, 0.9, 1))
			speaker_name.add_theme_color_override("font_color", Color(0.72, 0.78, 0.9, 1))
		"thought":
			dialogue_text.add_theme_color_override("default_color", Color(0.78, 0.86, 0.96, 1))
			speaker_name.add_theme_color_override("font_color", Color(0.72, 0.84, 1.0, 1))
		_:
			dialogue_text.add_theme_color_override("default_color", Color(0.95, 0.93, 0.97, 1))
			speaker_name.add_theme_color_override("font_color", Color(0.72, 0.84, 1.0, 1))


func _condition_met(condition: Dictionary) -> bool:
	if condition.has("relationship"):
		var key = str(condition["relationship"])
		var value = int(GameManager.relationships.get(key, 0))
		if condition.has("gte") and value < int(condition["gte"]):
			return false
		if condition.has("lte") and value > int(condition["lte"]):
			return false
		if condition.has("eq") and value != int(condition["eq"]):
			return false
	if condition.has("flag"):
		var flag_key = str(condition["flag"])
		var expected = condition.get("equals", true)
		if GameManager.flags.get(flag_key, false) != expected:
			return false
	return true


func _entry_effect_already_applied(entry: Dictionary) -> bool:
	var entry_id = str(entry.get("id", str(current_index)))
	return GameManager.flags.get("effect_" + entry_id, false)


func _apply_entry_effects(entry: Dictionary) -> void:
	var notifs = GameManager.apply_effects(entry["effects"])
	for n in notifs:
		_show_notification(n["text"], n["value"])
	var entry_id = str(entry.get("id", str(current_index)))
	GameManager.flags["effect_" + entry_id] = true


func _show_system_plaque(text: String) -> void:
	if text == "":
		system_plaque.visible = false
		return
	plaque_text.text = text
	system_plaque.visible = true
	system_plaque.modulate = Color(1, 1, 1, 0)
	var tween = create_tween()
	tween.tween_property(system_plaque, "modulate:a", 1.0, 0.3).set_ease(Tween.EASE_OUT)


func _show_summary(entry: Dictionary) -> void:
	for child in summary_box.get_children():
		child.queue_free()

	var title = Label.new()
	title.text = str(entry.get("summary_title", "Розділ завершено"))
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title.add_theme_font_size_override("font_size", 34)
	title.add_theme_color_override("font_color", Color(0.92, 0.78, 0.42, 1))
	summary_box.add_child(title)

	for line in entry.get("summary_lines", []):
		var label = Label.new()
		label.text = "• " + str(line)
		label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		label.add_theme_font_size_override("font_size", 21)
		label.add_theme_color_override("font_color", Color(0.9, 0.9, 0.96, 1))
		summary_box.add_child(label)

	var rel_title = Label.new()
	rel_title.text = "Стосунки"
	rel_title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	rel_title.add_theme_font_size_override("font_size", 24)
	rel_title.add_theme_color_override("font_color", Color(0.72, 0.84, 1.0, 1))
	summary_box.add_child(rel_title)

	var rel_lines = _relationship_summary_lines()
	if rel_lines.is_empty():
		var empty = Label.new()
		empty.text = "Поки без помітних змін."
		empty.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		empty.add_theme_font_size_override("font_size", 19)
		empty.add_theme_color_override("font_color", Color(0.72, 0.72, 0.8, 1))
		summary_box.add_child(empty)
	else:
		for line in rel_lines:
			var rel = Label.new()
			rel.text = line
			rel.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
			rel.add_theme_font_size_override("font_size", 19)
			rel.add_theme_color_override("font_color", Color(0.76, 0.9, 0.98, 1))
			summary_box.add_child(rel)

	var save_btn = Button.new()
	save_btn.text = str(entry.get("save_label", "Зберегти"))
	save_btn.custom_minimum_size = Vector2(280, 56)
	save_btn.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	_setup_pause_button(save_btn)
	save_btn.pressed.connect(func():
		GameManager.save_game()
		save_btn.text = "Збережено"
	)
	summary_box.add_child(save_btn)

	var continue_btn = Button.new()
	continue_btn.text = str(entry.get("continue_label", "Продовжити"))
	continue_btn.custom_minimum_size = Vector2(280, 56)
	continue_btn.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	_setup_pause_button(continue_btn)
	continue_btn.pressed.connect(func():
		GameManager.save_game()
		_go_to_target(entry.get("continue_target", "main_menu"))
	)
	summary_box.add_child(continue_btn)

	summary_overlay.visible = true
	summary_overlay.modulate = Color(1, 1, 1, 0)
	var tween = create_tween()
	tween.tween_property(summary_overlay, "modulate:a", 1.0, 0.45).set_ease(Tween.EASE_OUT)


func _relationship_summary_lines() -> Array[String]:
	var lines: Array[String] = []
	for key in GameManager.relationships:
		var value = int(GameManager.relationships[key])
		if value == 0:
			continue
		var sign = "+" if value > 0 else ""
		lines.append(GameManager.RELATIONSHIP_NAMES.get(key, key) + ": " + sign + str(value))
	return lines


func _choice_time_expired() -> void:
	_choice_time_left = 0
	choice_timer_label.visible = false
	if not choice_container.visible:
		return
	var entry = dialogue_data[current_index]
	if entry.has("choices") and entry["choices"].size() > 0:
		_select_choice(entry["choices"][0])


func _show_notification(stat_name: String, value: int) -> void:
	var label = Label.new()
	var sign = "+" if value > 0 else ""
	label.text = sign + str(value) + " " + stat_name
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	label.add_theme_font_size_override("font_size", 20)
	label.add_theme_color_override("font_color", Color(0.45, 0.9, 0.58, 1) if value > 0 else Color(0.95, 0.45, 0.45, 1))
	label.modulate = Color(1, 1, 1, 0)
	notification_container.add_child(label)

	var tween = create_tween()
	tween.tween_property(label, "modulate:a", 1.0, 0.25).set_ease(Tween.EASE_OUT)
	tween.tween_interval(2.0)
	tween.tween_property(label, "modulate:a", 0.0, 0.45).set_ease(Tween.EASE_IN)
	tween.tween_callback(label.queue_free)


func _crossfade_bg(new_tex: Texture2D) -> void:
	background_next.texture = new_tex
	background_next.modulate = Color(1, 1, 1, 0)
	var tween = create_tween()
	tween.tween_property(background_next, "modulate:a", 1.0, 0.45).set_ease(Tween.EASE_IN_OUT)
	tween.finished.connect(func():
		background.texture = new_tex
		background_next.modulate = Color(1, 1, 1, 0)
	)


func _flash_and_set_bg(new_tex: Texture2D) -> void:
	screen_flash.visible = true
	screen_flash.modulate = Color(1, 1, 1, 1)
	background.texture = new_tex
	var tween = create_tween()
	tween.tween_property(screen_flash, "modulate:a", 0.0, 0.65).set_ease(Tween.EASE_OUT)
	tween.finished.connect(func(): screen_flash.visible = false)


func _animate_character(node: TextureRect, char_key: String, prev_key: String) -> void:
	if char_key == "":
		if prev_key != "":
			var fade_out = create_tween()
			fade_out.tween_property(node, "modulate:a", 0.0, 0.22).set_ease(Tween.EASE_OUT)
			fade_out.finished.connect(func():
				node.texture = null
				node.visible = false
			)
		else:
			node.texture = null
			node.visible = false
		return

	var tex = _get_texture(_resolve_character_path(char_key))
	if not tex:
		push_warning("Missing character texture: " + char_key)
		node.texture = null
		node.visible = false
		return

	node.texture = tex
	node.visible = true
	node.scale = Vector2.ONE
	if prev_key != char_key:
		node.modulate = Color(1, 1, 1, 0)
		var tween = create_tween()
		tween.tween_property(node, "modulate:a", 1.0, 0.25).set_ease(Tween.EASE_OUT)
	else:
		node.modulate.a = 1.0


func _apply_speaker_focus(speaker: String, chars: Dictionary) -> void:
	var active_folders: Array = SPEAKER_FOLDERS.get(speaker, [])
	for pos in chars:
		var node = _node_for_position(pos)
		if not node.visible:
			continue
		var char_key = str(chars[pos])
		var folder = char_key.get_slice("/", 0)
		var active = active_folders.is_empty() or active_folders.has(folder)
		var inactive_alpha = clampf(float(GameManager.settings.get("inactive_character_alpha", 0.82)), 0.65, 0.95)
		var target = Color(1, 1, 1, 1) if active else Color(inactive_alpha, inactive_alpha, min(inactive_alpha + 0.06, 1.0), inactive_alpha)
		var tween = create_tween()
		tween.tween_property(node, "modulate", target, 0.18).set_ease(Tween.EASE_OUT)


func _get_texture(path: String) -> Texture2D:
	if _loaded_textures.has(path):
		return _loaded_textures[path]
	if ResourceLoader.exists(path):
		var tex = load(path)
		_loaded_textures[path] = tex
		return tex
	push_warning("Missing texture: " + path)
	return null


func _type_text() -> void:
	var speed = float(GameManager.settings["text_speed"])
	var duration = max(0.08, full_text.length() * speed)
	var tween = create_tween()
	tween.tween_property(dialogue_text, "visible_ratio", 1.0, duration)
	tween.finished.connect(func(): is_typing = false)


func _show_choices(choices: Array) -> void:
	for child in choice_container.get_children():
		child.queue_free()
	choice_container.visible = true
	dialogue_box.visible = false
	system_plaque.visible = false
	_auto_mode = false
	_skip_mode = false
	_update_pause_toggles()

	var entry = dialogue_data[current_index]
	var timer_seconds = int(entry.get("timer", 0))
	if timer_seconds > 0:
		_choice_time_left = float(timer_seconds)
		choice_timer_label.text = str(timer_seconds)
		choice_timer_label.visible = true
	else:
		_choice_time_left = 0
		choice_timer_label.visible = false

	for i in range(choices.size()):
		var choice = choices[i]
		var btn = Button.new()
		btn.text = str(choice["text"])
		btn.custom_minimum_size = Vector2(560, 64)
		btn.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		btn.add_theme_font_size_override("font_size", 23)
		btn.add_theme_color_override("font_color", Color(0.93, 0.94, 0.98, 1))
		btn.add_theme_color_override("font_hover_color", Color(1, 1, 1, 1))
		btn.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		_apply_choice_style(btn)
		btn.pressed.connect(func(): _select_choice(choice))
		btn.modulate = Color(1, 1, 1, 0)
		choice_container.add_child(btn)
		var tween = create_tween()
		tween.tween_property(btn, "modulate:a", 1.0, 0.25).set_delay(i * 0.08).set_ease(Tween.EASE_OUT)


func _select_choice(choice: Dictionary) -> void:
	_choice_time_left = 0
	choice_timer_label.visible = false
	var choice_id = str(dialogue_data[current_index].get("id", str(current_index)))
	choices_made[choice_id] = choice.get("target", "")
	if choice.has("effects"):
		var notifs = GameManager.apply_effects(choice["effects"])
		for n in notifs:
			_show_notification(n["text"], n["value"])
	GameManager.choices_made = choices_made.duplicate()
	GameManager.flags["choice_" + choice_id] = true
	choice_container.visible = false
	GameManager.save_game()
	_go_to_target(choice["target"])


func _apply_choice_style(button: Button) -> void:
	var normal = StyleBoxFlat.new()
	normal.bg_color = Color(0.055, 0.058, 0.09, 0.88)
	normal.border_color = Color(0.46, 0.56, 0.75, 0.62)
	normal.set_border_width_all(1)
	normal.set_corner_radius_all(14)
	normal.set_content_margin_all(18)
	button.add_theme_stylebox_override("normal", normal)

	var hover = normal.duplicate()
	hover.bg_color = Color(0.1, 0.11, 0.16, 0.96)
	hover.border_color = Color(0.72, 0.84, 1.0, 0.9)
	hover.set_border_width_all(2)
	button.add_theme_stylebox_override("hover", hover)

	var pressed = normal.duplicate()
	pressed.bg_color = Color(0.04, 0.045, 0.07, 0.98)
	pressed.border_color = Color(0.92, 0.78, 0.42, 0.95)
	pressed.set_border_width_all(2)
	button.add_theme_stylebox_override("pressed", pressed)


func _target_to_index(target, fallback: int) -> int:
	if target is int:
		return int(target)
	var target_id = str(target)
	if id_to_index.has(target_id):
		return int(id_to_index[target_id])
	if target_id.is_valid_int():
		return int(target_id)
	return fallback


func _resolve_background_path(bg_key: String) -> String:
	if bg_key.begins_with("res://"):
		return bg_key
	return "res://Picture/background/" + bg_key.trim_suffix(".png") + ".png"


func _resolve_character_path(char_key: String) -> String:
	if char_key.begins_with("res://"):
		return char_key
	return "res://Picture/character/" + char_key.trim_suffix(".png") + ".png"


func _node_for_position(position: String) -> TextureRect:
	match position:
		"left":
			return character_left
		"center":
			return character_center
		"right":
			return character_right
	return character_center


func _character_nodes() -> Array[TextureRect]:
	return [character_left, character_center, character_right]


func _toggle_pause() -> void:
	if _slot_mode != "":
		_hide_slot_panel()
		return
	is_paused = not is_paused
	pause_overlay.visible = is_paused
	get_tree().paused = is_paused


func _on_resume() -> void:
	_toggle_pause()


func _on_save() -> void:
	_show_slot_panel("save")


func _on_load() -> void:
	_show_slot_panel("load")


func _on_auto() -> void:
	_auto_mode = not _auto_mode
	if _auto_mode:
		_skip_mode = false
	_update_pause_toggles()


func _on_skip() -> void:
	_skip_mode = not _skip_mode
	if _skip_mode:
		_auto_mode = false
	_update_pause_toggles()


func _on_main_menu() -> void:
	get_tree().paused = false
	_go_to_main_menu()


func _go_to_main_menu() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn")


func _show_slot_panel(mode: String) -> void:
	_slot_mode = mode
	for child in _get_pause_menu().get_children():
		if child.name.begins_with("Slot"):
			child.queue_free()

	btn_resume.visible = false
	btn_save.visible = false
	btn_load.visible = false
	btn_auto.visible = false
	btn_skip.visible = false
	btn_main_menu.visible = false
	_get_pause_menu().get_node("PauseTitle").text = "Зберегти" if mode == "save" else "Завантажити"

	var slots = GameManager.get_all_slots()
	for i in range(slots.size()):
		var info = slots[i]
		var btn = Button.new()
		btn.name = "Slot" + str(i)
		if info["empty"]:
			btn.text = "Слот " + str(i + 1) + " - порожній"
		else:
			var scene = info.get("scene_name", "?")
			var saved_at = str(info.get("saved_at", ""))
			if saved_at.length() > 16:
				saved_at = saved_at.substr(0, 16)
			btn.text = "Слот " + str(i + 1) + " - " + scene + "\n" + saved_at
		btn.custom_minimum_size = Vector2(320, 58)
		btn.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		_setup_pause_button(btn)
		var slot_id = i
		if mode == "save":
			btn.pressed.connect(func():
				GameManager.save_to_slot(slot_id)
				btn.text = "Збережено"
				var tw = create_tween()
				tw.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
				tw.tween_interval(0.55)
				tw.tween_callback(func(): _hide_slot_panel())
			)
		elif info["empty"]:
			btn.disabled = true
		else:
			btn.pressed.connect(func():
				GameManager.load_from_slot(slot_id)
				get_tree().paused = false
				is_paused = false
				_slot_mode = ""
				get_tree().change_scene_to_file("res://scenes/game/game.tscn")
			)
		_get_pause_menu().add_child(btn)

	var back_btn = Button.new()
	back_btn.name = "SlotBack"
	back_btn.text = "Назад"
	back_btn.custom_minimum_size = Vector2(320, 54)
	_setup_pause_button(back_btn)
	back_btn.pressed.connect(_hide_slot_panel)
	_get_pause_menu().add_child(back_btn)


func _hide_slot_panel() -> void:
	_slot_mode = ""
	for child in _get_pause_menu().get_children():
		if child.name.begins_with("Slot"):
			child.queue_free()
	btn_resume.visible = true
	btn_save.visible = true
	btn_load.visible = true
	btn_auto.visible = true
	btn_skip.visible = true
	btn_main_menu.visible = true
	_get_pause_menu().get_node("PauseTitle").text = "Пауза"
	_update_pause_toggles()


func _get_pause_menu() -> VBoxContainer:
	return pause_overlay.get_node("PauseMenu")


func _setup_pause_button(button: Button) -> void:
	button.add_theme_font_size_override("font_size", 22)
	button.add_theme_color_override("font_color", Color(0.9, 0.91, 0.96, 1))
	button.add_theme_color_override("font_hover_color", Color(1, 1, 1, 1))
	button.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART

	var style = StyleBoxFlat.new()
	style.bg_color = Color(0.06, 0.065, 0.1, 0.88)
	style.border_color = Color(0.42, 0.5, 0.68, 0.6)
	style.set_border_width_all(1)
	style.set_corner_radius_all(12)
	style.set_content_margin_all(14)
	button.add_theme_stylebox_override("normal", style)

	var hover = style.duplicate()
	hover.bg_color = Color(0.105, 0.11, 0.16, 0.96)
	hover.border_color = Color(0.72, 0.84, 1.0, 0.9)
	hover.set_border_width_all(2)
	button.add_theme_stylebox_override("hover", hover)

	var pressed = style.duplicate()
	pressed.bg_color = Color(0.045, 0.05, 0.075, 0.98)
	pressed.border_color = Color(0.92, 0.78, 0.42, 0.95)
	pressed.set_border_width_all(2)
	button.add_theme_stylebox_override("pressed", pressed)


func _update_pause_toggles() -> void:
	if is_instance_valid(btn_auto):
		btn_auto.text = "Авто: увімкнено" if _auto_mode else "Авто"
	if is_instance_valid(btn_skip):
		btn_skip.text = "Пропуск: увімкнено" if _skip_mode else "Пропуск"
