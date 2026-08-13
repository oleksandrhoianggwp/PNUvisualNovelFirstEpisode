extends SceneTree

const DialogueData = preload("res://scripts/dialogue/dialogue_data.gd")

var failures: Array[String] = []
var manager: Node


func _init() -> void:
	call_deferred("_run")


func _assert_equal(actual, expected, message: String) -> void:
	if actual != expected:
		var detail := message + " (expected " + str(expected) + ", got " + str(actual) + ")"
		failures.append(detail)
		push_error(detail)


func _run() -> void:
	manager = root.get_node("GameManager")
	await _test_page_resume()
	await _test_choice_resumes_at_target()
	if failures.is_empty():
		print("PASS test_save_resume: page and post-choice progress restored exactly")
		quit(0)
	else:
		print("FAIL test_save_resume: ", failures.size(), " failure(s)")
		quit(1)


func _test_page_resume() -> void:
	manager.reset_progress()
	manager.jump_to_scene("ch2_041")
	var entry: Dictionary = DialogueData.DIALOGUES[manager.current_dialogue_index]
	manager.update_current_entry(entry, manager.current_dialogue_index, 1)
	manager.save_game()
	manager.reset_progress()
	_assert_equal(manager.load_game(), true, "Autosave could not be loaded")
	_assert_equal(manager.current_dialogue_id, "ch2_041", "Loaded the wrong dialogue")
	_assert_equal(manager.current_dialogue_page, 1, "Loaded the wrong dialogue page")


func _test_choice_resumes_at_target() -> void:
	var choice_entry: Dictionary = {}
	for entry in DialogueData.DIALOGUES:
		if entry.has("choices") and not entry["choices"].is_empty():
			choice_entry = entry
			break
	var choice: Dictionary = choice_entry["choices"][0]
	var target_id := str(choice["target"])
	manager.reset_progress()
	manager.jump_to_scene(str(choice_entry["id"]))
	manager.settings["text_speed"] = 0.0
	change_scene_to_file("res://scenes/game/game.tscn")
	for frame in range(8):
		await process_frame
	current_scene.call("_select_choice", choice)
	for frame in range(4):
		await process_frame
	_assert_equal(manager.current_dialogue_id, target_id, "Choice did not advance to its target before saving")
	manager.reset_progress()
	_assert_equal(manager.load_game(), true, "Post-choice autosave could not be loaded")
	_assert_equal(manager.current_dialogue_id, target_id, "Continue returned to the choice instead of its target")
