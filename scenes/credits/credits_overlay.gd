class_name CreditsOverlay
extends Control

const WarmUI = preload("res://scripts/ui/warm_ui.gd")

const CREDIT_BLOCKS := [
	{"kind": "title", "text": "ТИТРИ"},
	{"kind": "role", "text": "СЦЕНАРИСТКА\nСірадчук Яна Василівна"},
	{"kind": "role", "text": "РОЗРОБНИК\nГоян Олександр Васильович"},
	{"kind": "heading", "text": "СТВОРЕНО ЗА ДОПОМОГОЮ"},
	{"kind": "body", "text": "Godot Engine — рушій із відкритим кодом\nGodot SQLite та його учасники\nSQLite — суспільне надбання"},
	{"kind": "heading", "text": "МУЗИКА"},
	{"kind": "body", "text": "Forget Me Not — Kistol\nCC0 1.0 · OpenGameArt"},
	{"kind": "heading", "text": "ПОДЯКИ"},
	{"kind": "body", "text": "Спільноті Godot, авторам бібліотек,\nбезплатних і відкритих ресурсів,\nвикористаних відповідно до їхніх ліцензій."},
	{"kind": "thanks", "text": "ДЯКУЄМО ЗА ГРУ!"},
	{"kind": "spacer", "text": ""},
	{"kind": "title", "text": "CREDITS"},
	{"kind": "role", "text": "SCREENWRITER\nYana Vasylivna Siradchuk"},
	{"kind": "role", "text": "DEVELOPER\nOleksandr Vasylovych Hoian"},
	{"kind": "heading", "text": "CREATED WITH"},
	{"kind": "body", "text": "Godot Engine — open-source game engine\nGodot SQLite and its contributors\nSQLite — public domain"},
	{"kind": "heading", "text": "MUSIC"},
	{"kind": "body", "text": "Forget Me Not — Kistol\nCC0 1.0 · OpenGameArt"},
	{"kind": "heading", "text": "SPECIAL THANKS"},
	{"kind": "body", "text": "To the Godot community and the authors of libraries,\nfree and open resources used in accordance\nwith their respective licenses."},
	{"kind": "thanks", "text": "THANK YOU FOR PLAYING!"},
]

var _scroll: VBoxContainer
var _animation: Tween
var _menu_button: Button
var _skip_button: Button
var _finished := false


func _ready() -> void:
	set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	process_mode = Node.PROCESS_MODE_ALWAYS
	_build_background()
	_build_scroll()
	_build_controls()
	modulate.a = 0.0
	var fade := create_tween()
	fade.tween_property(self, "modulate:a", 1.0, 1.0)
	_start_scroll.call_deferred()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel") or event.is_action_pressed("ui_accept"):
		_finish_scroll()
		get_viewport().set_input_as_handled()


func _build_background() -> void:
	var image := TextureRect.new()
	image.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	image.texture = load("res://Picture/background/02_04_library.png")
	image.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	image.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED
	image.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(image)

	var shade := ColorRect.new()
	shade.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	shade.color = Color(0.035, 0.022, 0.018, 0.88)
	shade.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(shade)


func _build_scroll() -> void:
	var clip := Control.new()
	clip.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	clip.clip_contents = true
	clip.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(clip)

	_scroll = VBoxContainer.new()
	_scroll.name = "CreditsScroll"
	_scroll.set_anchors_preset(Control.PRESET_TOP_WIDE)
	_scroll.offset_left = 170.0
	_scroll.offset_right = -170.0
	_scroll.add_theme_constant_override("separation", 46)
	_scroll.mouse_filter = Control.MOUSE_FILTER_IGNORE
	clip.add_child(_scroll)

	for block in CREDIT_BLOCKS:
		if block["kind"] == "spacer":
			var spacer := Control.new()
			spacer.custom_minimum_size.y = 150
			_scroll.add_child(spacer)
			continue
		var label := Label.new()
		label.text = str(block["text"])
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		label.add_theme_color_override("font_color", _color_for(str(block["kind"])))
		label.add_theme_font_size_override("font_size", _size_for(str(block["kind"])))
		label.add_theme_constant_override("line_spacing", 10)
		_scroll.add_child(label)


func _build_controls() -> void:
	_skip_button = Button.new()
	_skip_button.text = "Пропустити / Skip"
	_skip_button.set_anchors_preset(Control.PRESET_TOP_RIGHT)
	_skip_button.position = Vector2(-258, 28)
	_skip_button.size = Vector2(226, 48)
	WarmUI.style_button(_skip_button, false, 16)
	_skip_button.pressed.connect(_finish_scroll)
	add_child(_skip_button)

	_menu_button = Button.new()
	_menu_button.text = "У меню / Main Menu"
	_menu_button.set_anchors_preset(Control.PRESET_BOTTOM_WIDE)
	_menu_button.offset_left = 585
	_menu_button.offset_right = -585
	_menu_button.offset_top = -94
	_menu_button.offset_bottom = -36
	_menu_button.visible = false
	WarmUI.style_button(_menu_button, true, 18)
	_menu_button.pressed.connect(_go_to_menu)
	add_child(_menu_button)


func _start_scroll() -> void:
	await get_tree().process_frame
	await get_tree().process_frame
	_scroll.position.y = size.y + 80.0
	var distance := size.y + _scroll.size.y + 160.0
	var duration := maxf(42.0, distance / 58.0)
	_animation = create_tween()
	_animation.tween_property(_scroll, "position:y", -_scroll.size.y - 80.0, duration)
	_animation.finished.connect(_finish_scroll)


func _finish_scroll() -> void:
	if _finished:
		return
	_finished = true
	if _animation and _animation.is_valid():
		_animation.kill()
	_scroll.visible = false
	_skip_button.visible = false
	var final_label := Label.new()
	final_label.text = "ДЯКУЄМО ЗА ГРУ!\n\nTHANK YOU FOR PLAYING!"
	final_label.set_anchors_and_offsets_preset(Control.PRESET_CENTER)
	final_label.position = Vector2(-390, -120)
	final_label.size = Vector2(780, 240)
	final_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	final_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	final_label.add_theme_color_override("font_color", Color(1.0, 0.85, 0.58, 1))
	final_label.add_theme_font_size_override("font_size", 36)
	final_label.modulate.a = 0.0
	add_child(final_label)
	_menu_button.visible = true
	_menu_button.modulate.a = 0.0
	var reveal := create_tween().set_parallel(true)
	reveal.tween_property(final_label, "modulate:a", 1.0, 0.8)
	reveal.tween_property(_menu_button, "modulate:a", 1.0, 0.8).set_delay(0.25)


func _go_to_menu() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn")


func _size_for(kind: String) -> int:
	match kind:
		"title": return 52
		"role": return 31
		"heading": return 24
		"thanks": return 38
		_: return 21


func _color_for(kind: String) -> Color:
	match kind:
		"title", "thanks": return Color(1.0, 0.82, 0.48, 1)
		"heading": return Color(0.95, 0.67, 0.42, 1)
		_: return Color(0.96, 0.92, 0.84, 1)
