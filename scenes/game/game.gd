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
@onready var system_label: Label = $SystemLabel

var dialogue_data: Array = []
var current_index: int = 0
var is_typing: bool = false
var full_text: String = ""
var current_bg: String = ""
var choices_made: Dictionary = {}

var _loaded_textures: Dictionary = {}
var _prev_left: String = ""
var _prev_right: String = ""


func _ready() -> void:
	dialogue_data = preload("res://scripts/dialogue/dialogue_data.gd").DIALOGUES
	current_index = GameManager.current_dialogue_index
	choices_made = GameManager.choices_made.duplicate()
	choice_container.visible = false
	system_label.visible = false
	dialogue_box.modulate = Color(1, 1, 1, 0)
	character_left.modulate = Color(1, 1, 1, 0)
	character_right.modulate = Color(1, 1, 1, 0)
	background_next.modulate = Color(1, 1, 1, 0)
	_show_dialogue()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") or (event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT):
		if choice_container.visible:
			return
		if system_label.visible:
			system_label.visible = false
			_advance_dialogue()
			return
		if is_typing:
			dialogue_text.visible_ratio = 1.0
			is_typing = false
		else:
			_advance_dialogue()


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
	var next_entry = dialogue_data[current_index]
	if next_entry.get("text", "") == "" and not next_entry.has("choices"):
		if next_entry.has("target"):
			current_index = next_entry["target"]
			GameManager.current_dialogue_index = current_index
		else:
			current_index += 1
			GameManager.current_dialogue_index = current_index

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

	# --- System messages ---
	if entry_type == "system":
		dialogue_box.visible = false
		_show_system_message(entry.get("text", ""))
		if entry.has("choices"):
			_show_choices(entry["choices"])
		return

	# --- Dialogue box ---
	system_label.visible = false
	var has_text = entry.get("text", "") != ""

	if has_text:
		_setup_text_style(entry_type, entry.get("speaker", ""))

		if entry.get("speaker", "") != "":
			speaker_name.text = entry["speaker"]
			speaker_name.visible = true
		else:
			speaker_name.text = ""
			speaker_name.visible = false

		full_text = entry["text"]

		# Apply italic for narrator and thought
		if entry_type == "narrator":
			dialogue_text.text = "[i]" + full_text + "[/i]"
		elif entry_type == "thought":
			dialogue_text.text = "[i]«" + full_text + "»[/i]"
		else:
			dialogue_text.text = full_text

		dialogue_text.visible_ratio = 0.0
		is_typing = true

		# Slide up dialogue box
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

	# --- Choices ---
	if entry.has("choices"):
		_show_choices(entry["choices"])


func _setup_text_style(entry_type: String, speaker: String) -> void:
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
			# Fade out
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
		# Fade in / change
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


func _show_system_message(text: String) -> void:
	if text == "":
		system_label.visible = false
		return
	system_label.text = text
	system_label.visible = true
	system_label.modulate = Color(1, 1, 1, 0)
	var tween = create_tween()
	tween.tween_property(system_label, "modulate:a", 1.0, 0.4).set_ease(Tween.EASE_OUT)


func _show_choices(choices: Array) -> void:
	for child in choice_container.get_children():
		child.queue_free()
	choice_container.visible = true
	dialogue_box.visible = false

	for i in range(choices.size()):
		var choice = choices[i]
		var btn = Button.new()
		btn.text = choice["text"]
		btn.custom_minimum_size = Vector2(440, 50)
		btn.add_theme_font_size_override("font_size", 20)
		btn.add_theme_color_override("font_color", Color(0.9, 0.92, 0.95, 1))
		btn.add_theme_color_override("font_hover_color", Color(1, 1, 1, 1))

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
		btn.pressed.connect(func():
			choices_made[str(choice_id)] = target_index
			GameManager.choices_made = choices_made.duplicate()
			GameManager.save_game()
			choice_container.visible = false
			current_index = target_index - 1
			_advance_dialogue()
		)

		# Staggered fade-in animation
		btn.modulate = Color(1, 1, 1, 0)
		choice_container.add_child(btn)
		var tween = create_tween()
		tween.tween_property(btn, "modulate:a", 1.0, 0.3).set_delay(i * 0.15).set_ease(Tween.EASE_OUT)
