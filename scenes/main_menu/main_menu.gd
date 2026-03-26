extends Control

@onready var btn_new_game: Button = %BtnNewGame
@onready var btn_continue: Button = %BtnContinue
@onready var btn_settings: Button = %BtnSettings
@onready var btn_exit: Button = %BtnExit
@onready var title_container: VBoxContainer = $TitleContainer
@onready var buttons_container: VBoxContainer = $ButtonsContainer


func _ready() -> void:
	btn_continue.visible = GameManager.has_save()

	btn_new_game.pressed.connect(_on_new_game)
	btn_continue.pressed.connect(_on_continue)
	btn_settings.pressed.connect(_on_settings)
	btn_exit.pressed.connect(_on_exit)

	_setup_button_style(btn_new_game)
	_setup_button_style(btn_continue)
	_setup_button_style(btn_settings)
	_setup_button_style(btn_exit)

	_play_fade_in()


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

	# Stagger each button
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
	GameManager.current_dialogue_index = 0
	GameManager.choices_made = {}
	get_tree().change_scene_to_file("res://scenes/game/game.tscn")


func _on_continue() -> void:
	GameManager.load_game()
	get_tree().change_scene_to_file("res://scenes/game/game.tscn")


func _on_settings() -> void:
	get_tree().change_scene_to_file("res://scenes/settings/settings.tscn")


func _on_exit() -> void:
	get_tree().quit()
