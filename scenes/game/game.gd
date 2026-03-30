extends Control

@onready var background: TextureRect = $Background
@onready var background_next: TextureRect = $BackgroundNext
@onready var character_left: TextureRect = $CharacterLeft
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
@onready var btn_resume: Button = %BtnResume
@onready var btn_save: Button = %BtnSave
@onready var btn_load: Button = %BtnLoad
@onready var btn_main_menu: Button = %BtnMainMenu

var dialogue_data: Array = []
var current_index: int = 0
var is_typing: bool = false
var full_text: String = ""
var current_bg: String = ""
var choices_made: Dictionary = {}
var is_paused: bool = false

var _loaded_textures: Dictionary = {}
var _prev_left: String = ""
var _prev_right: String = ""


func _ready() -> void:
	dialogue_data = preload("res://scripts/dialogue/dialogue_data.gd").DIALOGUES
	current_index = GameManager.current_dialogue_index
	choices_made = GameManager.choices_made.duplicate()
	choice_container.visible = false
	system_plaque.visible = false
	pause_overlay.visible = false
	dialogue_box.modulate = Color(1, 1, 1, 0)
	character_left.modulate = Color(1, 1, 1, 0)
	character_right.modulate = Color(1, 1, 1, 0)
	background_next.modulate = Color(1, 1, 1, 0)

	# Pause menu buttons
	_setup_pause_button(btn_resume)
	_setup_pause_button(btn_save)
	_setup_pause_button(btn_load)
	_setup_pause_button(btn_main_menu)
	btn_resume.pressed.connect(_on_resume)
	btn_save.pressed.connect(_on_save)
	btn_load.pressed.connect(_on_load)
	btn_main_menu.pressed.connect(_on_main_menu)

	_show_dialogue()


func _input(event: InputEvent) -> void:
	# Escape — toggle pause
	if event.is_action_pressed("ui_cancel"):
		_toggle_pause()
		return

	if is_paused:
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


# ===========================================
#  PAUSE MENU
# ===========================================
var _slot_mode: String = ""  # "save" or "load"

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


func _on_main_menu() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn")


func _show_slot_panel(mode: String) -> void:
	_slot_mode = mode
	# Clear previous slot buttons
	for child in _get_pause_menu().get_children():
		if child.name.begins_with("Slot"):
			child.queue_free()

	# Hide pause buttons
	btn_resume.visible = false
	btn_save.visible = false
	btn_load.visible = false
	btn_main_menu.visible = false

	# Title
	var title = _get_pause_menu().get_node("PauseTitle")
	title.text = "ЗБЕРЕГТИ" if mode == "save" else "ЗАВАНТАЖИТИ"

	# Build slot buttons
	var slots = GameManager.get_all_slots()
	for i in range(slots.size()):
		var info = slots[i]
		var btn = Button.new()
		btn.name = "Slot" + str(i)

		if info["empty"]:
			btn.text = "Слот " + str(i + 1) + " — Порожній"
		else:
			var scene = info.get("scene_name", "?")
			var saved_at = info.get("saved_at", "")
			# Show only date+time part
			if saved_at.length() > 16:
				saved_at = saved_at.substr(0, 16)
			btn.text = "Слот " + str(i + 1) + " — " + scene + "\n" + saved_at

		btn.custom_minimum_size = Vector2(300, 55)
		btn.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		_setup_pause_button(btn)

		if mode == "save":
			var slot_id = i
			btn.pressed.connect(func():
				GameManager.save_to_slot(slot_id)
				btn.text = "Збережено!"
				var tw = create_tween()
				tw.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
				tw.tween_interval(0.8)
				tw.tween_callback(func(): _hide_slot_panel())
			)
		else:  # load
			if info["empty"]:
				btn.disabled = true
			else:
				var slot_id = i
				btn.pressed.connect(func():
					GameManager.load_from_slot(slot_id)
					get_tree().paused = false
					is_paused = false
					_slot_mode = ""
					get_tree().change_scene_to_file("res://scenes/game/game.tscn")
				)

		_get_pause_menu().add_child(btn)

	# Back button
	var back_btn = Button.new()
	back_btn.name = "SlotBack"
	back_btn.text = "Назад"
	back_btn.custom_minimum_size = Vector2(300, 48)
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
	btn_main_menu.visible = true
	_get_pause_menu().get_node("PauseTitle").text = "ПАУЗА"


func _get_pause_menu() -> VBoxContainer:
	return pause_overlay.get_node("PauseMenu")


func _setup_pause_button(button: Button) -> void:
	button.add_theme_font_size_override("font_size", 22)
	button.add_theme_color_override("font_color", Color(0.88, 0.9, 0.95, 1))
	button.add_theme_color_override("font_hover_color", Color(1, 1, 1, 1))

	var style = StyleBoxFlat.new()
	style.bg_color = Color(0.1, 0.1, 0.15, 0.8)
	style.border_color = Color(0.35, 0.38, 0.5, 0.6)
	style.set_border_width_all(1)
	style.set_corner_radius_all(10)
	style.set_content_margin_all(12)
	button.add_theme_stylebox_override("normal", style)

	var hover = StyleBoxFlat.new()
	hover.bg_color = Color(0.15, 0.15, 0.22, 0.9)
	hover.border_color = Color(0.5, 0.55, 0.75, 0.9)
	hover.set_border_width_all(2)
	hover.set_corner_radius_all(10)
	hover.set_content_margin_all(12)
	button.add_theme_stylebox_override("hover", hover)

	var pressed = StyleBoxFlat.new()
	pressed.bg_color = Color(0.08, 0.08, 0.12, 0.95)
	pressed.border_color = Color(0.55, 0.6, 0.8, 1.0)
	pressed.set_border_width_all(2)
	pressed.set_corner_radius_all(10)
	pressed.set_content_margin_all(12)
	button.add_theme_stylebox_override("pressed", pressed)


# ===========================================
#  DIALOGUE FLOW
# ===========================================
func _advance_dialogue() -> void:
	var entry = dialogue_data[current_index]
	if entry.has("target"):
		current_index = entry["target"]
	else:
		current_index += 1

	GameManager.current_dialogue_index = current_index
	GameManager.choices_made = choices_made.duplicate()

	if current_index >= dialogue_data.size():
		GameManager.save_game()
		get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn")
		return

	# Skip empty text entries (spacers/jumps)
	while current_index < dialogue_data.size():
		var next_entry = dialogue_data[current_index]
		if next_entry.get("text", "") == "" and not next_entry.has("choices"):
			if next_entry.has("target"):
				current_index = next_entry["target"]
			else:
				current_index += 1
			GameManager.current_dialogue_index = current_index
		else:
			break

	if current_index >= dialogue_data.size():
		GameManager.save_game()
		get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn")
		return

	_show_dialogue()


func _show_dialogue() -> void:
	var entry = dialogue_data[current_index]
	var entry_type = entry.get("type", "dialogue")
	var transition = entry.get("transition", "none")

	# --- Background ---
	var new_bg = entry.get("bg", "")
	if new_bg != "" and new_bg != current_bg:
		var bg_path = "res://Picture/background/" + new_bg + ".png"
		var tex = _get_texture(bg_path)
		if tex:
			if transition == "crossfade" and current_bg != "":
				_crossfade_bg(tex)
			elif transition == "flash":
				_flash_and_set_bg(tex)
			else:
				background.texture = tex
		current_bg = new_bg

	# --- Characters ---
	var left_key = entry.get("left", "")
	var right_key = entry.get("right", "")
	_animate_character(character_left, left_key, _prev_left)
	_animate_character(character_right, right_key, _prev_right)
	_prev_left = left_key
	_prev_right = right_key

	# --- Apply effects if entry has them ---
	if entry.has("effects"):
		var notifs = GameManager.apply_effects(entry["effects"])
		for n in notifs:
			_show_notification(n["text"], n["value"])

	# --- System messages (plaque style) ---
	if entry_type == "system":
		dialogue_box.visible = false
		_show_system_plaque(entry.get("text", ""))
		if entry.has("choices"):
			_show_choices(entry["choices"])
		return

	# --- Dialogue box ---
	system_plaque.visible = false
	var has_text = entry.get("text", "") != ""

	if has_text:
		_setup_text_style(entry_type)

		if entry.get("speaker", "") != "":
			speaker_name.text = entry["speaker"]
			speaker_name.visible = true
		else:
			speaker_name.text = ""
			speaker_name.visible = false

		full_text = entry["text"]

		if entry_type == "narrator":
			dialogue_text.text = "[i]" + full_text + "[/i]"
		elif entry_type == "thought":
			dialogue_text.text = "[i]«" + full_text + "»[/i]"
		else:
			dialogue_text.text = full_text

		dialogue_text.visible_ratio = 0.0
		is_typing = true

		if not dialogue_box.visible:
			dialogue_box.visible = true
			dialogue_box.modulate = Color(1, 1, 1, 0)
			var tween = create_tween()
			tween.tween_property(dialogue_box, "modulate:a", 1.0, 0.25).set_ease(Tween.EASE_OUT)
			tween.finished.connect(_type_text)
		else:
			dialogue_box.modulate = Color(1, 1, 1, 1)
			_type_text()
	else:
		dialogue_box.visible = has_text

	if entry.has("choices"):
		_show_choices(entry["choices"])


func _setup_text_style(entry_type: String) -> void:
	match entry_type:
		"narrator":
			dialogue_text.add_theme_color_override("default_color", Color(0.78, 0.8, 0.85, 1))
			speaker_name.add_theme_color_override("font_color", Color(0.5, 0.6, 0.7, 1))
		"thought":
			dialogue_text.add_theme_color_override("default_color", Color(0.7, 0.78, 0.9, 1))
			speaker_name.add_theme_color_override("font_color", Color(0.55, 0.65, 0.85, 1))
		_:
			dialogue_text.add_theme_color_override("default_color", Color(0.92, 0.92, 0.95, 1))
			speaker_name.add_theme_color_override("font_color", Color(0.65, 0.8, 1.0, 1))


# ===========================================
#  SYSTEM PLAQUE (stylized tablet)
# ===========================================
func _show_system_plaque(text: String) -> void:
	if text == "":
		system_plaque.visible = false
		return
	plaque_text.text = text
	system_plaque.visible = true
	system_plaque.modulate = Color(1, 1, 1, 0)
	system_plaque.position.y += 20
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(system_plaque, "modulate:a", 1.0, 0.4).set_ease(Tween.EASE_OUT)
	tween.tween_property(system_plaque, "position:y", system_plaque.position.y - 20, 0.4).set_ease(Tween.EASE_OUT)


# ===========================================
#  FLOAT NOTIFICATIONS (+1 Reputation etc)
# ===========================================
func _show_notification(stat_name: String, value: int) -> void:
	var label = Label.new()
	var sign = "+" if value > 0 else ""
	label.text = sign + str(value) + " " + stat_name
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	label.add_theme_font_size_override("font_size", 20)

	if value > 0:
		label.add_theme_color_override("font_color", Color(0.4, 0.9, 0.5, 1))
	else:
		label.add_theme_color_override("font_color", Color(0.95, 0.4, 0.4, 1))

	label.modulate = Color(1, 1, 1, 0)
	notification_container.add_child(label)

	var tween = create_tween()
	tween.tween_property(label, "modulate:a", 1.0, 0.3).set_ease(Tween.EASE_OUT)
	tween.tween_interval(2.0)
	tween.tween_property(label, "modulate:a", 0.0, 0.5).set_ease(Tween.EASE_IN)
	tween.tween_callback(label.queue_free)


# ===========================================
#  TRANSITIONS
# ===========================================
func _crossfade_bg(new_tex: Texture2D) -> void:
	background_next.texture = new_tex
	background_next.modulate = Color(1, 1, 1, 0)
	var tween = create_tween()
	tween.tween_property(background_next, "modulate:a", 1.0, 0.6).set_ease(Tween.EASE_IN_OUT)
	tween.finished.connect(func():
		background.texture = new_tex
		background_next.modulate = Color(1, 1, 1, 0)
	)


func _flash_and_set_bg(new_tex: Texture2D) -> void:
	screen_flash.visible = true
	screen_flash.modulate = Color(1, 1, 1, 1)
	background.texture = new_tex
	var tween = create_tween()
	tween.tween_property(screen_flash, "modulate:a", 0.0, 0.8).set_ease(Tween.EASE_OUT)
	tween.finished.connect(func(): screen_flash.visible = false)


func _animate_character(node: TextureRect, char_key: String, prev_key: String) -> void:
	if char_key == "":
		if prev_key != "":
			var tween = create_tween()
			tween.tween_property(node, "modulate:a", 0.0, 0.3).set_ease(Tween.EASE_OUT)
			tween.finished.connect(func():
				node.texture = null
				node.visible = false
			)
		else:
			node.texture = null
			node.visible = false
		return

	var parts = char_key.split("/")
	var path = "res://Picture/character/" + parts[0] + "/" + parts[1] + ".png"
	var tex = _get_texture(path)
	if not tex:
		node.texture = null
		node.visible = false
		return

	node.texture = tex
	node.visible = true

	if prev_key != char_key:
		node.modulate = Color(1, 1, 1, 0)
		var tween = create_tween()
		tween.tween_property(node, "modulate:a", 1.0, 0.3).set_ease(Tween.EASE_OUT)
	else:
		node.modulate = Color(1, 1, 1, 1)


func _get_texture(path: String) -> Texture2D:
	if _loaded_textures.has(path):
		return _loaded_textures[path]
	if ResourceLoader.exists(path):
		var tex = load(path)
		_loaded_textures[path] = tex
		return tex
	return null


func _type_text() -> void:
	var speed = GameManager.settings["text_speed"]
	var char_count = full_text.length()
	var tween = create_tween()
	tween.tween_property(dialogue_text, "visible_ratio", 1.0, char_count * speed)
	tween.finished.connect(func(): is_typing = false)


# ===========================================
#  CHOICES (responsive buttons)
# ===========================================
func _show_choices(choices: Array) -> void:
	for child in choice_container.get_children():
		child.queue_free()
	choice_container.visible = true
	dialogue_box.visible = false

	for i in range(choices.size()):
		var choice = choices[i]
		var btn = Button.new()
		btn.text = choice["text"]
		btn.custom_minimum_size = Vector2(350, 45)
		btn.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		btn.add_theme_font_size_override("font_size", 20)
		btn.add_theme_color_override("font_color", Color(0.9, 0.92, 0.95, 1))
		btn.add_theme_color_override("font_hover_color", Color(1, 1, 1, 1))
		btn.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		btn.text_overrun_behavior = TextServer.OVERRUN_NO_TRIMMING

		var style = StyleBoxFlat.new()
		style.bg_color = Color(0.1, 0.1, 0.16, 0.85)
		style.border_color = Color(0.4, 0.45, 0.6, 0.7)
		style.set_border_width_all(1)
		style.set_corner_radius_all(8)
		style.set_content_margin_all(12)
		btn.add_theme_stylebox_override("normal", style)

		var hover_style = StyleBoxFlat.new()
		hover_style.bg_color = Color(0.15, 0.15, 0.24, 0.95)
		hover_style.border_color = Color(0.5, 0.55, 0.75, 1.0)
		hover_style.set_border_width_all(2)
		hover_style.set_corner_radius_all(8)
		hover_style.set_content_margin_all(12)
		btn.add_theme_stylebox_override("hover", hover_style)

		var pressed_style = StyleBoxFlat.new()
		pressed_style.bg_color = Color(0.08, 0.08, 0.12, 0.95)
		pressed_style.border_color = Color(0.55, 0.6, 0.8, 1.0)
		pressed_style.set_border_width_all(2)
		pressed_style.set_corner_radius_all(8)
		pressed_style.set_content_margin_all(12)
		btn.add_theme_stylebox_override("pressed", pressed_style)

		var target_index = choice["target"]
		var choice_id = current_index
		var choice_effects = choice.get("effects", {})
		btn.pressed.connect(func():
			choices_made[str(choice_id)] = target_index
			# Apply choice effects
			if not choice_effects.is_empty():
				var notifs = GameManager.apply_effects(choice_effects)
				for n in notifs:
					_show_notification(n["text"], n["value"])
			GameManager.choices_made = choices_made.duplicate()
			choice_container.visible = false
			current_index = target_index
			GameManager.current_dialogue_index = current_index
			GameManager.save_game()
			_show_dialogue()
		)

		btn.modulate = Color(1, 1, 1, 0)
		choice_container.add_child(btn)
		var tween = create_tween()
		tween.tween_property(btn, "modulate:a", 1.0, 0.3).set_delay(i * 0.15).set_ease(Tween.EASE_OUT)
