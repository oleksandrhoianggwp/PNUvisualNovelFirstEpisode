extends Control

const WarmUI = preload("res://scripts/ui/warm_ui.gd")
const DialoguePaginator = preload("res://scripts/dialogue/dialogue_paginator.gd")
const CharacterPresentation = preload("res://scripts/characters/character_presentation.gd")
const STAT_CHANGE_CARD = preload("res://scenes/components/stat_change_card.tscn")
const CREDITS_OVERLAY = preload("res://scenes/credits/credits_overlay.tscn")

@onready var background: TextureRect = $Background
@onready var background_next: TextureRect = $BackgroundNext
@onready var character_left: TextureRect = $CharacterLeft
@onready var character_center: TextureRect = $CharacterCenter
@onready var character_right: TextureRect = $CharacterRight
@onready var dialogue_box: PanelContainer = $DialogueBox
@onready var speaker_badge: PanelContainer = $DialogueBox/MarginContainer/VBoxContainer/Header/SpeakerBadge
@onready var speaker_name: Label = $DialogueBox/MarginContainer/VBoxContainer/Header/SpeakerBadge/Margin/SpeakerName
@onready var advance_hint: Label = $DialogueBox/MarginContainer/VBoxContainer/Header/AdvanceHint
@onready var dialogue_text: RichTextLabel = $DialogueBox/MarginContainer/VBoxContainer/DialogueText
@onready var choice_container: VBoxContainer = $ChoiceContainer
@onready var screen_flash: ColorRect = $ScreenFlash
@onready var system_plaque: PanelContainer = $SystemPlaque
@onready var plaque_text: Label = $SystemPlaque/MarginContainer/HBoxContainer/PlaqueText
@onready var notification_container: VBoxContainer = $NotificationContainer
@onready var pause_overlay: ColorRect = $PauseOverlay
@onready var pause_card: PanelContainer = $PauseOverlay/PauseCenter/PauseCard
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
const BACKGROUND_ROOT := "res://Picture/background/"
const CHARACTER_ROOT := "res://Picture/character/"
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
	"Кураторка": ["lidiya_ivanivna"],
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
var _dialogue_was_visible_before_pause: bool = false
var _text_pages: PackedStringArray = PackedStringArray()
var _text_page_index: int = 0
var _typing_tween: Tween


func _ready() -> void:
	dialogue_data = Localization.localize_dialogues(DialogueData.DIALOGUES)
	_build_id_map()
	_apply_runtime_layout()
	_apply_localized_ui()

	current_index = clampi(GameManager.current_dialogue_index, 0, max(dialogue_data.size() - 1, 0))
	if GameManager.current_dialogue_id != "":
		current_index = _target_to_index(GameManager.current_dialogue_id, current_index)
	_text_page_index = maxi(GameManager.current_dialogue_page, 0)
	choices_made = GameManager.choices_made.duplicate()

	choice_container.visible = false
	system_plaque.visible = false
	pause_overlay.visible = false
	summary_overlay.visible = false
	choice_timer_label.visible = false
	dialogue_box.modulate = Color(1, 1, 1, 0)
	advance_hint.modulate.a = 0.0
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
			if _typing_tween and _typing_tween.is_valid():
				_typing_tween.kill()
			dialogue_text.visible_ratio = 1.0
			is_typing = false
			_show_advance_hint()
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
	var selected_font = _selected_ui_font()

	var dialogue_style = StyleBoxFlat.new()
	var opacity_setting = clampf(float(GameManager.settings.get("textbox_opacity", 0.72)), 0.55, 0.95)
	var panel_opacity = lerpf(0.48, 0.78, inverse_lerp(0.55, 0.95, opacity_setting))
	dialogue_style.bg_color = Color(0.115, 0.072, 0.052, panel_opacity)
	dialogue_style.border_color = Color(0.93, 0.72, 0.47, 0.44)
	dialogue_style.set_border_width_all(1)
	dialogue_style.set_corner_radius_all(20)
	dialogue_style.set_content_margin_all(0)
	dialogue_style.shadow_color = Color(0.045, 0.025, 0.016, 0.28)
	dialogue_style.shadow_size = 14
	dialogue_style.shadow_offset = Vector2(0, 5)
	dialogue_box.add_theme_stylebox_override("panel", dialogue_style)
	dialogue_box.scale = Vector2(ui_scale, ui_scale)
	choice_container.scale = Vector2(ui_scale, ui_scale)

	dialogue_text.add_theme_color_override("default_color", Color(1.0, 0.965, 0.9, 1))
	dialogue_text.add_theme_font_size_override("normal_font_size", dialogue_font_size)
	if selected_font:
		dialogue_text.add_theme_font_override("normal_font", selected_font)
	dialogue_text.add_theme_constant_override("line_separation", 6)
	dialogue_text.fit_content = false
	speaker_name.add_theme_font_size_override("font_size", maxi(20, dialogue_font_size - 7))
	speaker_name.add_theme_color_override("font_color", WarmUI.CREAM)
	if selected_font:
		speaker_name.add_theme_font_override("font", selected_font)


func _selected_ui_font() -> Font:
	var font_name = str(GameManager.settings.get("dialogue_font_family", "Default"))
	if font_name == "" or font_name == "Default":
		return null
	var font = SystemFont.new()
	font.font_names = PackedStringArray([font_name])
	return font


func _apply_selected_font(control: Control) -> void:
	var font = _selected_ui_font()
	if not font:
		return
	if control is RichTextLabel:
		control.add_theme_font_override("normal_font", font)
	elif control is Label or control is Button or control is OptionButton:
		control.add_theme_font_override("font", font)


func _advance_dialogue() -> void:
	if current_index < 0 or current_index >= dialogue_data.size():
		_go_to_main_menu()
		return
	var entry = dialogue_data[current_index]
	if dialogue_box.visible and _text_page_index + 1 < _text_pages.size():
		_text_page_index += 1
		GameManager.current_dialogue_page = _text_page_index
		_render_text_page(entry)
		GameManager.save_game()
		return
	if entry.has("choices") and not choice_container.visible:
		_show_choices(entry["choices"])
		return
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

	var entry_id := str(entry.get("id", ""))
	if entry_id != GameManager.current_dialogue_id:
		_text_page_index = 0
	GameManager.update_current_entry(entry, current_index, _text_page_index)
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
		GameManager.save_game()
		return
	if entry_type == "credits":
		dialogue_box.visible = false
		system_plaque.visible = false
		choice_container.visible = false
		_show_credits()
		GameManager.save_game()
		return

	summary_overlay.visible = false
	if entry_type == "system":
		dialogue_box.visible = false
		_show_system_plaque(str(entry.get("text", "")))
		if entry.has("choices"):
			_show_choices(entry["choices"])
		GameManager.save_game()
		return

	system_plaque.visible = false
	choice_container.visible = false
	choice_timer_label.visible = false
	_setup_text_style(entry_type)
	_show_text_entry(entry)
	GameManager.save_game()


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
	var chars := CharacterPresentation.normalize_slots(entry)
	var targets := _character_targets(str(entry.get("_source_speaker", entry.get("speaker", ""))), chars, entry)
	_animate_character(character_left, chars["left"], _prev_chars["left"], targets["left"])
	_animate_character(character_center, chars["center"], _prev_chars["center"], targets["center"])
	_animate_character(character_right, chars["right"], _prev_chars["right"], targets["right"])
	_prev_chars = chars
	GameManager.visible_characters = chars.duplicate()


func _show_text_entry(entry: Dictionary) -> void:
	var has_text = str(entry.get("text", "")) != ""
	dialogue_box.visible = has_text
	if not has_text:
		if entry.has("choices"):
			_show_choices(entry["choices"])
		return

	var speaker = str(entry.get("speaker", ""))
	speaker_name.text = speaker
	speaker_badge.visible = speaker != ""
	advance_hint.modulate.a = 0.0
	_text_pages = DialoguePaginator.paginate(str(entry["text"]), _dialogue_page_limit())
	_text_page_index = clampi(_text_page_index, 0, maxi(_text_pages.size() - 1, 0))
	GameManager.current_dialogue_page = _text_page_index
	_auto_elapsed = 0.0
	_skip_elapsed = 0.0

	# Replace the content immediately. Replaying a fade/scale tween for every
	# line briefly showed the previous text and made the whole panel jump.
	dialogue_box.modulate.a = 1.0
	dialogue_box.scale = Vector2.ONE * clampf(float(GameManager.settings.get("ui_scale", 1.0)), 0.85, 1.2)
	_render_text_page(entry)

	if entry.has("choices"):
		await get_tree().process_frame
		await _wait_for_text_entry_finished()
		_show_choices(entry["choices"])


func _wait_for_text_entry_finished() -> void:
	while is_typing or _text_page_index + 1 < _text_pages.size():
		await get_tree().process_frame


func _dialogue_page_limit() -> int:
	var font_size := maxi(int(GameManager.settings.get("dialogue_font_size", 28)), 18)
	var ui_scale := clampf(float(GameManager.settings.get("ui_scale", 1.0)), 0.85, 1.2)
	return maxi(180, roundi(420.0 * 28.0 / float(font_size) / ui_scale))


func _render_text_page(entry: Dictionary) -> void:
	if _text_pages.is_empty():
		return
	if _typing_tween and _typing_tween.is_valid():
		_typing_tween.kill()
	full_text = _text_pages[_text_page_index]
	var entry_type = str(entry.get("type", "dialogue"))
	if entry_type == "narrator":
		dialogue_text.text = "[i]" + full_text + "[/i]"
	elif entry_type == "thought":
		dialogue_text.text = ("[i]“" + full_text + "”[/i]") if Localization.current_language == "en" else ("[i]«" + full_text + "»[/i]")
	else:
		dialogue_text.text = full_text
	dialogue_text.visible_ratio = 0.0
	is_typing = true
	advance_hint.text = (str(_text_page_index + 1) + "/" + str(_text_pages.size()) + "  ⌄") if _text_pages.size() > 1 else "⌄"
	_type_text()


func _setup_text_style(entry_type: String) -> void:
	match entry_type:
		"narrator":
			dialogue_text.add_theme_color_override("default_color", Color(0.95, 0.9, 0.82, 1))
			speaker_name.add_theme_color_override("font_color", WarmUI.CREAM)
		"thought":
			dialogue_text.add_theme_color_override("default_color", Color(0.94, 0.87, 0.74, 1))
			speaker_name.add_theme_color_override("font_color", WarmUI.CREAM)
		_:
			dialogue_text.add_theme_color_override("default_color", Color(1.0, 0.965, 0.9, 1))
			speaker_name.add_theme_color_override("font_color", WarmUI.CREAM)


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
		_show_notification(n["text"], n["value"], n["current"])
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
	title.text = str(entry.get("summary_title", Localization.t("game.summary_default")))
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title.add_theme_font_size_override("font_size", 34)
	title.add_theme_color_override("font_color", Color(0.92, 0.78, 0.42, 1))
	_apply_selected_font(title)
	summary_box.add_child(title)

	for line in entry.get("summary_lines", []):
		var label = Label.new()
		label.text = "• " + str(line)
		label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		label.add_theme_font_size_override("font_size", 21)
		label.add_theme_color_override("font_color", Color(0.9, 0.9, 0.96, 1))
		_apply_selected_font(label)
		summary_box.add_child(label)

	var rel_title = Label.new()
	rel_title.text = Localization.t("game.relationships")
	rel_title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	rel_title.add_theme_font_size_override("font_size", 24)
	rel_title.add_theme_color_override("font_color", Color(0.72, 0.84, 1.0, 1))
	_apply_selected_font(rel_title)
	summary_box.add_child(rel_title)

	var rel_lines = _relationship_summary_lines()
	if rel_lines.is_empty():
		var empty = Label.new()
		empty.text = Localization.t("game.no_changes")
		empty.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		empty.add_theme_font_size_override("font_size", 19)
		empty.add_theme_color_override("font_color", Color(0.72, 0.72, 0.8, 1))
		_apply_selected_font(empty)
		summary_box.add_child(empty)
	else:
		for line in rel_lines:
			var rel = Label.new()
			rel.text = line
			rel.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
			rel.add_theme_font_size_override("font_size", 19)
			rel.add_theme_color_override("font_color", Color(0.76, 0.9, 0.98, 1))
			_apply_selected_font(rel)
			summary_box.add_child(rel)

	var actions = HBoxContainer.new()
	actions.alignment = BoxContainer.ALIGNMENT_CENTER
	actions.add_theme_constant_override("separation", 14)
	summary_box.add_child(actions)

	var save_btn = Button.new()
	save_btn.text = str(entry.get("save_label", Localization.t("common.save")))
	save_btn.custom_minimum_size = Vector2(220, 56)
	save_btn.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	_setup_pause_button(save_btn)
	_apply_selected_font(save_btn)
	save_btn.pressed.connect(func():
		GameManager.save_game()
		save_btn.text = Localization.t("common.saved")
	)
	actions.add_child(save_btn)

	var continue_btn = Button.new()
	continue_btn.text = str(entry.get("continue_label", Localization.t("common.continue")))
	continue_btn.custom_minimum_size = Vector2(260, 56)
	continue_btn.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	_setup_pause_button(continue_btn)
	_apply_selected_font(continue_btn)
	continue_btn.pressed.connect(func():
		GameManager.save_game()
		_close_summary_overlay()
		_go_to_target(entry.get("continue_target", "main_menu"))
	)
	actions.add_child(continue_btn)

	if str(entry.get("continue_target", "main_menu")) != "main_menu":
		var menu_btn = Button.new()
		menu_btn.text = Localization.t("common.main_menu")
		menu_btn.custom_minimum_size = Vector2(240, 56)
		menu_btn.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
		_setup_pause_button(menu_btn)
		_apply_selected_font(menu_btn)
		menu_btn.pressed.connect(func():
			GameManager.save_game()
			_close_summary_overlay()
			_go_to_main_menu()
		)
		actions.add_child(menu_btn)

	summary_overlay.visible = true
	summary_overlay.modulate = Color(1, 1, 1, 0)
	var tween = create_tween()
	tween.tween_property(summary_overlay, "modulate:a", 1.0, 0.45).set_ease(Tween.EASE_OUT)


func _close_summary_overlay() -> void:
	summary_overlay.visible = false
	summary_overlay.modulate = Color(1, 1, 1, 0)
	for child in summary_box.get_children():
		summary_box.remove_child(child)
		child.queue_free()


func _show_credits() -> void:
	var credits := CREDITS_OVERLAY.instantiate()
	add_child(credits)


func _relationship_summary_lines() -> Array[String]:
	var lines: Array[String] = []
	for key in GameManager.relationships:
		var value = int(GameManager.relationships[key])
		if value == 0:
			continue
		var sign = "+" if value > 0 else ""
		lines.append(GameManager.relationship_display_name(key) + ": " + sign + str(value))
	return lines


func _choice_time_expired() -> void:
	_choice_time_left = 0
	choice_timer_label.visible = false
	if not choice_container.visible:
		return
	var entry = dialogue_data[current_index]
	if entry.has("choices") and entry["choices"].size() > 0:
		_select_choice(entry["choices"][0])


func _show_notification(stat_name: String, value: int, current_value: int) -> void:
	var card: StatChangeCard = STAT_CHANGE_CARD.instantiate()
	notification_container.add_child(card)
	card.setup(stat_name, current_value, value, _selected_ui_font())
	card.modulate = Color(1, 1, 1, 0)
	card.position.x = 24.0

	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(card, "modulate:a", 1.0, 0.24).set_ease(Tween.EASE_OUT)
	tween.tween_property(card, "position:x", 0.0, 0.28).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	tween.set_parallel(false)
	# Keep choice feedback readable long enough to notice without interrupting play.
	tween.tween_interval(3.0)
	tween.set_parallel(true)
	tween.tween_property(card, "modulate:a", 0.0, 0.3).set_ease(Tween.EASE_IN)
	tween.tween_property(card, "position:x", 16.0, 0.3).set_ease(Tween.EASE_IN)
	tween.set_parallel(false)
	tween.tween_callback(card.queue_free)


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


func _animate_character(node: TextureRect, char_key: String, prev_key: String, target: Dictionary) -> void:
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

	# Conceal the exact source sprite so its pose and dimensions do not change.
	node.texture = tex
	node.visible = true
	node.z_index = int(target.get("z_index", 1))
	node.pivot_offset = Vector2(node.size.x * 0.5, node.size.y)
	var target_color: Color = target.get("color", Color.WHITE)
	var target_scale: Vector2 = target.get("scale", Vector2.ONE)
	if prev_key != char_key:
		var target_position := node.position
		var enter_offset := -34.0 if node == character_left else 34.0
		if node == character_center:
			enter_offset = 0.0
		node.position = target_position + Vector2(enter_offset, 10.0)
		node.scale = target_scale * 0.975
		node.modulate = Color(target_color.r, target_color.g, target_color.b, 0)
		var tween = create_tween()
		tween.set_parallel(true)
		tween.tween_property(node, "position", target_position, 0.34).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
		tween.tween_property(node, "scale", target_scale, 0.38).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
		tween.tween_property(node, "modulate", target_color, 0.3).set_ease(Tween.EASE_OUT)
	else:
		var focus_tween = create_tween()
		focus_tween.set_parallel(true)
		focus_tween.tween_property(node, "modulate", target_color, 0.24).set_ease(Tween.EASE_OUT)
		focus_tween.tween_property(node, "scale", target_scale, 0.26).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)


func _character_targets(speaker: String, chars: Dictionary, entry: Dictionary) -> Dictionary:
	var active_folders: Array = SPEAKER_FOLDERS.get(speaker, [])
	var has_direct_match := false
	for pos in chars:
		if active_folders.has(CharacterPresentation.folder_for(str(chars[pos]))):
			has_direct_match = true
			break
	if not has_direct_match:
		active_folders = []

	var show_all := speaker == "" or bool(entry.get("show_all_characters", false))
	if not show_all and active_folders.is_empty():
		for pos in ["left", "center", "right"]:
			var inferred_folder := CharacterPresentation.folder_for(str(chars[pos]))
			if inferred_folder != "" and inferred_folder != "daria_main":
				active_folders.append(inferred_folder)
				break
		if active_folders.is_empty():
			for pos in ["left", "center", "right"]:
				var only_folder := CharacterPresentation.folder_for(str(chars[pos]))
				if only_folder != "":
					active_folders.append(only_folder)
					break

	var hidden_slots := CharacterPresentation.concealed_slots(entry)
	var targets := {}
	for pos in chars:
		var char_key = str(chars[pos])
		var folder := CharacterPresentation.folder_for(char_key)
		var active := show_all or active_folders.has(folder)
		var base_scale := CharacterPresentation.scale_for(char_key)
		var relationship_key := CharacterPresentation.relationship_key_for(char_key)
		var concealed := hidden_slots.has(pos) or (relationship_key != "" and not GameManager.is_character_known(relationship_key))
		var color := Color.WHITE if active else Color(0.24, 0.22, 0.2, 0)
		if active and concealed:
			color = Color(0.0, 0.0, 0.0, 0.98)
		targets[pos] = {
			"color": color,
			"scale": Vector2.ONE * base_scale * (1.0 if active else 0.965),
			"z_index": 2 if active else 1,
			"concealed": active and concealed,
		}
	return targets


func _get_texture(path: String) -> Texture2D:
	if _loaded_textures.has(path):
		return _loaded_textures[path]
	var texture: Texture2D = null
	if ResourceLoader.exists(path):
		texture = load(path)
	elif FileAccess.file_exists(path):
		var image = Image.new()
		var err = image.load(path)
		if err == OK:
			texture = ImageTexture.create_from_image(image)
	if texture:
		if _is_character_texture(path):
			texture = _trim_character_texture(texture)
		_loaded_textures[path] = texture
		return texture
	push_warning("Missing texture: " + path)
	return null


func _is_character_texture(path: String) -> bool:
	return path.begins_with(CHARACTER_ROOT)


func _trim_character_texture(texture: Texture2D) -> Texture2D:
	var image = texture.get_image()
	if image == null or image.is_empty():
		return texture
	var used_rect = image.get_used_rect()
	var full_rect = Rect2i(Vector2i.ZERO, image.get_size())
	if used_rect.size == Vector2i.ZERO or used_rect == full_rect:
		return texture
	var padding = maxi(8, roundi(maxf(used_rect.size.x, used_rect.size.y) * 0.025))
	used_rect = used_rect.grow(padding).intersection(full_rect)
	var trimmed = image.get_region(used_rect)
	return ImageTexture.create_from_image(trimmed)


func _type_text() -> void:
	var speed = float(GameManager.settings["text_speed"])
	var duration = max(0.08, full_text.length() * speed)
	_typing_tween = create_tween()
	_typing_tween.tween_property(dialogue_text, "visible_ratio", 1.0, duration)
	_typing_tween.finished.connect(func():
		is_typing = false
		_show_advance_hint()
	)


func _show_advance_hint() -> void:
	if not dialogue_box.visible:
		return
	advance_hint.modulate.a = 0.35
	advance_hint.position.y = 0.0
	var tween := create_tween()
	tween.set_loops(2)
	tween.tween_property(advance_hint, "modulate:a", 0.95, 0.42).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(advance_hint, "position:y", 4.0, 0.42).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(advance_hint, "modulate:a", 0.45, 0.42).set_ease(Tween.EASE_IN)
	tween.parallel().tween_property(advance_hint, "position:y", 0.0, 0.42).set_ease(Tween.EASE_IN_OUT)


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
		var estimated_lines := maxi(1, ceili(float(btn.text.length()) / 54.0))
		btn.custom_minimum_size = Vector2(0, 58 + (estimated_lines - 1) * 28)
		btn.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		btn.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		btn.text_overrun_behavior = TextServer.OVERRUN_NO_TRIMMING
		btn.clip_text = false
		WarmUI.style_button(btn, false, 21)
		_apply_selected_font(btn)
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
			_show_notification(n["text"], n["value"], n["current"])
	GameManager.choices_made = choices_made.duplicate()
	GameManager.flags["choice_" + choice_id] = true
	choice_container.visible = false
	_go_to_target(choice["target"])


func _apply_choice_style(button: Button) -> void:
	var normal = WarmUI.dark_glass_style(0.9, 15)
	normal.bg_color = Color(0.12, 0.075, 0.055, 0.9)
	normal.border_color = Color(0.93, 0.72, 0.47, 0.56)
	normal.set_border_width_all(1)
	normal.set_corner_radius_all(14)
	normal.set_content_margin_all(18)
	button.add_theme_stylebox_override("normal", normal)

	var hover = normal.duplicate()
	hover.bg_color = Color(0.25, 0.12, 0.075, 0.96)
	hover.border_color = WarmUI.GOLD
	hover.set_border_width_all(2)
	button.add_theme_stylebox_override("hover", hover)

	var pressed = normal.duplicate()
	pressed.bg_color = Color(0.16, 0.075, 0.052, 0.98)
	pressed.border_color = WarmUI.TERRACOTTA
	pressed.set_border_width_all(2)
	button.add_theme_stylebox_override("pressed", pressed)
	button.add_theme_color_override("font_color", WarmUI.CREAM)
	button.add_theme_color_override("font_hover_color", Color.WHITE)


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
	var normalized_key = bg_key.trim_suffix(".png")
	normalized_key = str(LEGACY_BACKGROUND_ALIASES.get(normalized_key, normalized_key))
	return BACKGROUND_ROOT + normalized_key + ".png"


func _resolve_character_path(char_key: String) -> String:
	if char_key.begins_with("res://"):
		return char_key
	return CHARACTER_ROOT + char_key.trim_suffix(".png") + ".png"


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
	if is_paused:
		_dialogue_was_visible_before_pause = dialogue_box.visible
		dialogue_box.visible = false
		pause_overlay.modulate.a = 0.0
		pause_card.scale = Vector2(0.96, 0.96)
		pause_card.pivot_offset = pause_card.size * 0.5
		var tween := create_tween()
		tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
		tween.set_parallel(true)
		tween.tween_property(pause_overlay, "modulate:a", 1.0, 0.2).set_ease(Tween.EASE_OUT)
		tween.tween_property(pause_card, "scale", Vector2.ONE, 0.3).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	else:
		dialogue_box.visible = _dialogue_was_visible_before_pause


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
	_get_pause_menu().get_node("ActionGrid").visible = false
	_get_pause_menu().get_node("PauseSubtitle").visible = false
	_get_pause_menu().get_node("PauseTitle").text = Localization.t("common.save") if mode == "save" else Localization.t("common.load")

	var slots = GameManager.get_all_slots()
	for i in range(slots.size()):
		var info = slots[i]
		var btn = _create_pause_slot_button(info, i)
		if mode == "save":
			btn.disabled = false
		var slot_id = i
		if mode == "save":
			btn.pressed.connect(func():
				GameManager.save_to_slot(slot_id)
				_refresh_pause_slot_button(btn, GameManager.get_slot_info(slot_id), slot_id, Localization.t("common.saved"))
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
	back_btn.text = Localization.t("common.back")
	back_btn.custom_minimum_size = Vector2(320, 54)
	_setup_pause_button(back_btn)
	back_btn.pressed.connect(_hide_slot_panel)
	_get_pause_menu().add_child(back_btn)


func _create_pause_slot_button(info: Dictionary, slot_id: int) -> Button:
	var btn = Button.new()
	btn.name = "Slot" + str(slot_id)
	btn.text = ""
	btn.custom_minimum_size = Vector2(470, 104)
	btn.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	btn.disabled = bool(info.get("empty", true))
	_setup_slot_card_style(btn)
	_build_pause_slot_content(btn, info, slot_id, "")
	return btn


func _refresh_pause_slot_button(btn: Button, info: Dictionary, slot_id: int, status: String) -> void:
	for child in btn.get_children():
		btn.remove_child(child)
		child.queue_free()
	btn.disabled = false
	_build_pause_slot_content(btn, info, slot_id, status)


func _build_pause_slot_content(btn: Button, info: Dictionary, slot_id: int, status: String) -> void:
	var margin = MarginContainer.new()
	margin.mouse_filter = Control.MOUSE_FILTER_IGNORE
	margin.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	margin.add_theme_constant_override("margin_left", 9)
	margin.add_theme_constant_override("margin_top", 9)
	margin.add_theme_constant_override("margin_right", 10)
	margin.add_theme_constant_override("margin_bottom", 9)
	btn.add_child(margin)

	var row = HBoxContainer.new()
	row.mouse_filter = Control.MOUSE_FILTER_IGNORE
	row.add_theme_constant_override("separation", 12)
	margin.add_child(row)

	var preview = TextureRect.new()
	preview.mouse_filter = Control.MOUSE_FILTER_IGNORE
	preview.custom_minimum_size = Vector2(150, 84)
	preview.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	preview.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_COVERED
	preview.texture = _slot_preview_texture(info)
	preview.modulate = Color(1, 1, 1, 0.4) if bool(info.get("empty", true)) else Color(1, 1, 1, 0.9)
	row.add_child(preview)

	var text_box = VBoxContainer.new()
	text_box.mouse_filter = Control.MOUSE_FILTER_IGNORE
	text_box.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	text_box.alignment = BoxContainer.ALIGNMENT_CENTER
	text_box.add_theme_constant_override("separation", 3)
	row.add_child(text_box)

	var title = Label.new()
	title.mouse_filter = Control.MOUSE_FILTER_IGNORE
	title.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	title.add_theme_font_size_override("font_size", 18)
	title.add_theme_color_override("font_color", WarmUI.INK if not bool(info.get("empty", true)) else Color(0.35, 0.3, 0.27, 0.46))
	text_box.add_child(title)

	var meta = Label.new()
	meta.mouse_filter = Control.MOUSE_FILTER_IGNORE
	meta.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	meta.add_theme_font_size_override("font_size", 14)
	meta.add_theme_color_override("font_color", WarmUI.INK_SOFT if not bool(info.get("empty", true)) else Color(0.35, 0.3, 0.27, 0.4))
	text_box.add_child(meta)

	if bool(info.get("empty", true)):
		title.text = Localization.t("common.slot") % (slot_id + 1)
		meta.text = Localization.t("common.empty")
	else:
		title.text = Localization.t("common.slot_scene") % [slot_id + 1, str(info.get("scene_name", "?"))]
		var saved_at = _format_saved_at(str(info.get("saved_at", "")))
		meta.text = status if status != "" else (Localization.t("common.chapter") % int(info.get("chapter", 1))) + "   " + saved_at


func _setup_slot_card_style(button: Button) -> void:
	button.flat = false
	button.add_theme_color_override("font_color", Color(1, 1, 1, 0))
	button.add_theme_color_override("font_disabled_color", Color(1, 1, 1, 0))

	var normal = StyleBoxFlat.new()
	normal.bg_color = Color(1.0, 0.97, 0.9, 0.8)
	normal.border_color = Color(0.55, 0.31, 0.22, 0.32)
	normal.set_border_width_all(1)
	normal.set_corner_radius_all(12)
	button.add_theme_stylebox_override("normal", normal)

	var hover = normal.duplicate()
	hover.bg_color = Color(1.0, 0.99, 0.95, 0.98)
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
	var path = _resolve_background_path(bg)
	if ResourceLoader.exists(path):
		return load(path)
	return null


func _format_saved_at(value: String) -> String:
	var result = value.replace("T", " ")
	if result.length() > 16:
		result = result.substr(0, 16)
	return result


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
	_get_pause_menu().get_node("ActionGrid").visible = true
	_get_pause_menu().get_node("PauseSubtitle").visible = true
	_get_pause_menu().get_node("PauseTitle").text = Localization.t("game.pause")
	_update_pause_toggles()


func _get_pause_menu() -> VBoxContainer:
	return pause_overlay.get_node("PauseCenter/PauseCard/Margin/PauseMenu")


func _setup_pause_button(button: Button) -> void:
	WarmUI.style_button(button, button == btn_resume, 19)
	_apply_selected_font(button)


func _update_pause_toggles() -> void:
	if is_instance_valid(btn_auto):
		btn_auto.text = Localization.t("game.auto_on") if _auto_mode else Localization.t("game.auto")
	if is_instance_valid(btn_skip):
		btn_skip.text = Localization.t("game.skip_on") if _skip_mode else Localization.t("game.skip")


func _apply_localized_ui() -> void:
	_get_pause_menu().get_node("PauseTitle").text = Localization.t("game.pause")
	_get_pause_menu().get_node("PauseSubtitle").text = Localization.t("game.pause_subtitle")
	btn_resume.text = Localization.t("game.resume")
	btn_save.text = Localization.t("common.save")
	btn_load.text = Localization.t("common.load")
	btn_auto.text = Localization.t("game.auto")
	btn_skip.text = Localization.t("game.skip")
	btn_main_menu.text = Localization.t("game.menu")
