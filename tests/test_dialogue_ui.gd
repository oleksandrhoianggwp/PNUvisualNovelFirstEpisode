extends SceneTree

const DialogueData = preload("res://scripts/dialogue/dialogue_data.gd")
const DialoguePaginator = preload("res://scripts/dialogue/dialogue_paginator.gd")

var failures: Array[String] = []
var manager: Node


func _init() -> void:
	call_deferred("_run")


func _assert_true(condition: bool, message: String) -> void:
	if not condition:
		failures.append(message)
		push_error(message)


func _normalized(text: String) -> String:
	return " ".join(text.strip_edges().split(" ", false))


func _run() -> void:
	manager = root.get_node("GameManager")
	_test_paginator_preserves_all_dialogue_text()
	_test_speaker_badges_contain_names()
	await _test_long_dialogue_layout()
	await _test_choice_layout()
	await _test_text_transition_is_stable()
	await _test_speaker_badge_and_reputation_card()
	if failures.is_empty():
		print("PASS test_dialogue_ui: all dialogue pages and choice buttons fit")
		quit(0)
	else:
		print("FAIL test_dialogue_ui: ", failures.size(), " failure(s)")
		quit(1)


func _test_paginator_preserves_all_dialogue_text() -> void:
	for entry in DialogueData.DIALOGUES:
		var source := str(entry.get("text", ""))
		if source.is_empty():
			continue
		var pages := DialoguePaginator.paginate(source, 320)
		_assert_true(not pages.is_empty(), str(entry.get("id", "?")) + " produced no text pages")
		for page in pages:
			_assert_true(not page.is_empty(), str(entry.get("id", "?")) + " produced an empty page")
			_assert_true(page.length() <= 320, str(entry.get("id", "?")) + " page exceeds the requested limit")
		_assert_true(_normalized(" ".join(pages)) == _normalized(source), str(entry.get("id", "?")) + " lost text while paginating")


func _test_speaker_badges_contain_names() -> void:
	for entry in DialogueData.DIALOGUES:
		var speaker := str(entry.get("speaker", ""))
		_assert_true(speaker.length() <= 22, str(entry.get("id", "?")) + " contains prose in the speaker badge: " + speaker)


func _open_dialogue(scene_id: String) -> Control:
	manager.reset_progress()
	manager.jump_to_scene(scene_id)
	manager.settings["text_speed"] = 0.0
	change_scene_to_file("res://scenes/game/game.tscn")
	for frame in range(12):
		await process_frame
	return current_scene


func _test_long_dialogue_layout() -> void:
	var game := await _open_dialogue("ch2_041")
	_assert_true(game != null, "Long-dialogue game scene did not load")
	if game == null:
		return
	var pages: PackedStringArray = game.get("_text_pages")
	var label: RichTextLabel = game.get_node("DialogueBox/MarginContainer/VBoxContainer/DialogueText")
	_assert_true(pages.size() > 1, "Known 897-character dialogue was not paginated")
	_assert_true(label.get_content_height() <= label.size.y + 2.0, "Paginated dialogue content is still clipped")


func _test_choice_layout() -> void:
	var game := await _open_dialogue("ch2_081")
	_assert_true(game != null, "Choice game scene did not load")
	if game == null:
		return
	var regression_choice := "Це навмисно дуже довгий варіант відповіді для регресійної перевірки: він має переноситися на кілька рядків, залишатися всередині панелі та повністю читатися на екрані без обрізання правого краю."
	game.call("_show_choices", [
		{"text": regression_choice, "target": "ch2_082"},
		{"text": "Короткий контрольний варіант", "target": "ch2_082"},
	])
	await process_frame
	var container: VBoxContainer = game.get_node("ChoiceContainer")
	_assert_true(container.visible, "Choice container is not visible")
	for child in container.get_children():
		if child is Button:
			_assert_true(child.autowrap_mode == TextServer.AUTOWRAP_WORD_SMART, "Choice button does not wrap text")
			_assert_true(not child.clip_text, "Choice button clips text")
			_assert_true(child.size.x <= container.size.x + 2.0, "Choice button extends past its container")
			_assert_true(child.get_minimum_size().y <= child.size.y + 2.0, "Choice button is not tall enough for its wrapped text")


func _test_text_transition_is_stable() -> void:
	var game := await _open_dialogue("ch1_015")
	var box: PanelContainer = game.get_node("DialogueBox")
	var label: RichTextLabel = game.get_node("DialogueBox/MarginContainer/VBoxContainer/DialogueText")
	var previous_text := label.get_parsed_text()
	var previous_scale := box.scale
	game.call("_advance_dialogue")
	await process_frame
	_assert_true(label.get_parsed_text() != previous_text, "Previous dialogue text remains visible during the next entry")
	_assert_true(box.modulate.a > 0.99, "Dialogue panel flashes while moving to the next entry")
	_assert_true(box.scale.is_equal_approx(previous_scale), "Dialogue panel jumps in scale between entries")


func _test_speaker_badge_and_reputation_card() -> void:
	var game := await _open_dialogue("ch2_097")
	var speaker: Label = game.get_node("DialogueBox/MarginContainer/VBoxContainer/Header/SpeakerBadge/Margin/SpeakerName")
	_assert_true(speaker.text == "Дарія", "Narration fragment is still rendered as a speaker name")
	var localization := root.get_node("Localization")
	game.call("_show_notification", localization.t("common.reputation"), 1, 1)
	await create_timer(0.4).timeout
	var container: VBoxContainer = game.get_node("NotificationContainer")
	_assert_true(container.get_child_count() == 1, "Reputation feedback card was not shown")
	if container.get_child_count() == 1:
		var card := container.get_child(0)
		_assert_true(card.get_node("Margin/Row/Copy/ChangeLabel").text == localization.t("game.reputation_improved"), "Reputation card exposes raw numbers instead of atmospheric feedback")
		_assert_true(card.modulate.a > 0.95, "Reputation feedback starts fading before its hold period")
	game.call("_advance_dialogue")
	await create_timer(0.7).timeout
	_assert_true(container.get_child_count() == 1, "Reputation feedback disappears when the next dialogue starts")
	if container.get_child_count() == 1:
		_assert_true(container.get_child(0).modulate.a > 0.95, "Reputation feedback fades while the next dialogue is shown")
