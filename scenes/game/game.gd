extends Control

@onready var background: TextureRect = $Background
@onready var character_left: TextureRect = $CharacterLeft
@onready var character_right: TextureRect = $CharacterRight
@onready var dialogue_box: PanelContainer = $DialogueBox
@onready var speaker_name: Label = $DialogueBox/MarginContainer/VBoxContainer/SpeakerName
@onready var dialogue_text: RichTextLabel = $DialogueBox/MarginContainer/VBoxContainer/DialogueText
@onready var choice_container: VBoxContainer = $ChoiceContainer

var dialogue_data: Array = []
var current_index: int = 0
var is_typing: bool = false
var full_text: String = ""

const TEXT_SPEED = 0.03

var _loaded_textures: Dictionary = {}


func _ready() -> void:
	dialogue_data = preload("res://scripts/dialogue/dialogue_data.gd").DIALOGUES
	current_index = GameManager.current_dialogue_index
	choice_container.visible = false
	_show_dialogue()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") or (event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT):
		if choice_container.visible:
			return
		if is_typing:
			dialogue_text.visible_ratio = 1.0
			is_typing = false
		else:
			_advance_dialogue()


func _advance_dialogue() -> void:
	current_index += 1
	GameManager.current_dialogue_index = current_index
	if current_index >= dialogue_data.size():
		GameManager.save_game()
		get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn")
		return
	_show_dialogue()


func _show_dialogue() -> void:
	var entry = dialogue_data[current_index]

	if entry.has("bg") and entry["bg"] != "":
		var bg_path = "res://Picture/background/" + entry["bg"] + ".png"
		background.texture = _get_texture(bg_path)

	_set_character(character_left, entry.get("left", ""))
	_set_character(character_right, entry.get("right", ""))

	if entry.get("speaker", "") != "":
		speaker_name.text = entry["speaker"]
		speaker_name.visible = true
	else:
		speaker_name.text = ""
		speaker_name.visible = false

	dialogue_box.visible = entry.get("text", "") != ""
	if dialogue_box.visible:
		full_text = entry["text"]
		dialogue_text.text = full_text
		dialogue_text.visible_ratio = 0.0
		is_typing = true
		_type_text()

	if entry.has("choices"):
		_show_choices(entry["choices"])


func _set_character(node: TextureRect, char_key: String) -> void:
	if char_key == "":
		node.texture = null
		node.visible = false
		return

	var parts = char_key.split("/")
	var path = "res://Picture/character/" + parts[0] + "/" + parts[1] + ".png"
	node.texture = _get_texture(path)
	node.visible = true


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
	var tween = create_tween()
	var char_count = full_text.length()
	tween.tween_property(dialogue_text, "visible_ratio", 1.0, char_count * speed)
	tween.finished.connect(func(): is_typing = false)


func _show_choices(choices: Array) -> void:
	for child in choice_container.get_children():
		child.queue_free()
	choice_container.visible = true

	for choice in choices:
		var btn = Button.new()
		btn.text = choice["text"]
		btn.custom_minimum_size = Vector2(400, 45)
		btn.add_theme_font_size_override("font_size", 20)

		var style = StyleBoxFlat.new()
		style.bg_color = Color(1, 1, 1, 0.85)
		style.border_color = Color(0.6, 0.6, 0.65, 1)
		style.set_border_width_all(1)
		style.set_corner_radius_all(6)
		style.set_content_margin_all(10)
		btn.add_theme_stylebox_override("normal", style)

		var target_index = choice["target"]
		btn.pressed.connect(func():
			choice_container.visible = false
			current_index = target_index - 1
			_advance_dialogue()
		)
		choice_container.add_child(btn)
