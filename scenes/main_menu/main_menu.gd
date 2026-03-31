extends Control

@onready var btn_new_game: Button = %BtnNewGame
@onready var btn_continue: Button = %BtnContinue
@onready var btn_settings: Button = %BtnSettings
@onready var btn_exit: Button = %BtnExit
@onready var title_container: VBoxContainer = $TitleContainer
@onready var buttons_container: VBoxContainer = $ButtonsContainer

var _showing_slots: bool = false


func _ready() -> void:
	GameManager.play_music("res://music/main menu/main_menu.mp3")
	btn_continue.visible = GameManager.has_any_save()
	btn_continue.text = "Завантажити"

	btn_new_game.pressed.connect(_on_new_game)
	btn_continue.pressed.connect(_on_load_slots)
	btn_settings.pressed.connect(_on_settings)
	btn_exit.pressed.connect(_on_exit)

	_setup_button_style(btn_new_game)
	_setup_button_style(btn_continue)
	_setup_button_style(btn_settings)
	_setup_button_style(btn_exit)

	_play_fade_in()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel") and _showing_slots:
		_hide_slots()


func _setup_button_style(button: Button) -> void:
	button.add_theme_font_size_override("font_size", 22)
	button.add_theme_color_override("font_color", Color(0.88, 0.9, 0.95, 1))
	button.add_theme_color_override("font_hover_color", Color(1, 1, 1, 1))
	button.add_theme_color_override("font_pressed_color", Color(0.75, 0.8, 0.9, 1))

	var normal_style = StyleBoxFlat.new()
	normal_style.bg_color = Color(0.1, 0.1, 0.15, 0.75)
	normal_style.border_color = Color(0.35, 0.38, 0.5, 0.6)
	normal_style.set_border_width_all(1)
	normal_style.set_corner_radius_all(10)
	normal_style.set_content_margin_all(14)
	button.add_theme_stylebox_override("normal", normal_style)

	var hover_style = StyleBoxFlat.new()
	hover_style.bg_color = Color(0.15, 0.15, 0.22, 0.9)
	hover_style.border_color = Color(0.5, 0.55, 0.75, 0.9)
	hover_style.set_border_width_all(2)
	hover_style.set_corner_radius_all(10)
	hover_style.set_content_margin_all(14)
	button.add_theme_stylebox_override("hover", hover_style)

	var pressed_style = StyleBoxFlat.new()
	pressed_style.bg_color = Color(0.08, 0.08, 0.12, 0.95)
	pressed_style.border_color = Color(0.55, 0.6, 0.8, 1.0)
	pressed_style.set_border_width_all(2)
	pressed_style.set_corner_radius_all(10)
	pressed_style.set_content_margin_all(14)
	button.add_theme_stylebox_override("pressed", pressed_style)


func _play_fade_in() -> void:
	title_container.modulate = Color(1, 1, 1, 0)
	buttons_container.modulate = Color(1, 1, 1, 0)

	for i in range(buttons_container.get_child_count()):
		var btn = buttons_container.get_child(i)
		btn.modulate = Color(1, 1, 1, 0)

	var tween = create_tween()
	tween.tween_property(title_container, "modulate:a", 1.0, 0.7).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(buttons_container, "modulate:a", 1.0, 0.1).set_delay(0.3)

	for i in range(buttons_container.get_child_count()):
		var btn = buttons_container.get_child(i)
		tween.parallel().tween_property(btn, "modulate:a", 1.0, 0.4).set_delay(0.4 + i * 0.12).set_ease(Tween.EASE_OUT)


func _on_new_game() -> void:
	GameManager.reset_progress()
	get_tree().change_scene_to_file("res://scenes/game/game.tscn")


func _on_load_slots() -> void:
	_showing_slots = true
	# Hide main buttons
	btn_new_game.visible = false
	btn_continue.visible = false
	btn_settings.visible = false
	btn_exit.visible = false

	var slots = GameManager.get_all_slots()
	for i in range(slots.size()):
		var info = slots[i]
		var btn = Button.new()
		btn.name = "Slot" + str(i)

		if info["empty"]:
			btn.text = "○ Слот " + str(i + 1) + " — Порожній"
			btn.disabled = true
		else:
			var scene = info.get("scene_name", "?")
			var saved_at = str(info.get("saved_at", ""))
			if saved_at.length() > 16:
				saved_at = saved_at.substr(0, 16)
			var rep = info.get("reputation", 0)
			btn.text = "◉ Слот " + str(i + 1) + " — " + scene + "  [★ " + str(rep) + "]\n" + saved_at

		btn.custom_minimum_size = Vector2(300, 55)
		btn.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		_setup_button_style(btn)

		var slot_id = i
		if not info["empty"]:
			btn.pressed.connect(func():
				GameManager.load_from_slot(slot_id)
				get_tree().change_scene_to_file("res://scenes/game/game.tscn")
			)

		buttons_container.add_child(btn)

	# Back button
	var back = Button.new()
	back.name = "SlotBack"
	back.text = "Назад"
	back.custom_minimum_size = Vector2(300, 48)
	_setup_button_style(back)
	back.pressed.connect(_hide_slots)
	buttons_container.add_child(back)


func _hide_slots() -> void:
	_showing_slots = false
	for child in buttons_container.get_children():
		if child.name.begins_with("Slot"):
			child.queue_free()
	btn_new_game.visible = true
	btn_continue.visible = GameManager.has_any_save()
	btn_settings.visible = true
	btn_exit.visible = true


func _on_settings() -> void:
	get_tree().change_scene_to_file("res://scenes/settings/settings.tscn")


func _on_exit() -> void:
	get_tree().quit()
