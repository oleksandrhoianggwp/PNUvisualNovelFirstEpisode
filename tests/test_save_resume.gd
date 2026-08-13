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
	await _test_current_line_autosave()
	await _test_page_resume()
	await _test_choice_resumes_at_target()
	await _test_manual_slot_restores_full_state()
	await _test_chapter_transition_resume()
	if failures.is_empty():
		print("PASS test_save_resume: 5 progress scenarios restored exactly")
		quit(0)
	else:
		print("FAIL test_save_resume: ", failures.size(), " failure(s)")
		quit(1)


func _open_scene(scene_id: String, frames: int = 10) -> Control:
	manager.reset_progress()
	manager.jump_to_scene(scene_id)
	manager.settings["text_speed"] = 0.0
	change_scene_to_file("res://scenes/game/game.tscn")
	for frame in range(frames):
		await process_frame
	return current_scene


func _test_current_line_autosave() -> void:
	await _open_scene("ch1_050")
	manager.reset_progress()
	_assert_equal(manager.load_game(), true, "Current-line autosave could not be loaded")
	_assert_equal(manager.current_dialogue_id, "ch1_050", "Continue did not restore the latest displayed line")


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
	await _open_scene(str(choice_entry["id"]), 8)
	current_scene.call("_select_choice", choice)
	for frame in range(4):
		await process_frame
	_assert_equal(manager.current_dialogue_id, target_id, "Choice did not advance to its target before saving")
	manager.reset_progress()
	_assert_equal(manager.load_game(), true, "Post-choice autosave could not be loaded")
	_assert_equal(manager.current_dialogue_id, target_id, "Continue returned to the choice instead of its target")


func _test_manual_slot_restores_full_state() -> void:
	manager.reset_progress()
	manager.jump_to_scene("ch2_100")
	var entry: Dictionary = DialogueData.DIALOGUES[manager.current_dialogue_index]
	manager.update_current_entry(entry, manager.current_dialogue_index, 0)
	manager.choices_made = {"ch1_017": "ch1_019"}
	manager.flags = {"choice_ch1_017": true, "effect_ch2_100": true}
	manager.reputation = 7
	manager.relationships["maria"] = 3
	manager.save_to_slot(3)

	manager.reset_progress()
	_assert_equal(manager.load_from_slot(3), true, "Manual slot could not be loaded")
	_assert_equal(manager.current_dialogue_id, "ch2_100", "Manual slot restored the wrong dialogue")
	_assert_equal(manager.current_background, str(entry["bg"]), "Manual slot restored the wrong background")
	_assert_equal(manager.choices_made, {"ch1_017": "ch1_019"}, "Manual slot lost branch choices")
	_assert_equal(manager.flags, {"choice_ch1_017": true, "effect_ch2_100": true}, "Manual slot lost progress flags")
	_assert_equal(manager.reputation, 7, "Manual slot lost reputation")
	_assert_equal(manager.relationships["maria"], 3, "Manual slot lost relationship values")


func _test_chapter_transition_resume() -> void:
	var game := await _open_scene("ch1_summary")
	game.call("_go_to_target", "ch2_001")
	for frame in range(10):
		await process_frame
	_assert_equal(manager.current_dialogue_id, "ch2_001", "Chapter 1 continuation did not open chapter 2")
	_assert_equal(manager.current_chapter, 2, "Chapter transition kept the old chapter number")
	manager.reset_progress()
	_assert_equal(manager.load_game(), true, "Chapter-transition autosave could not be loaded")
	_assert_equal(manager.current_dialogue_id, "ch2_001", "Continue did not restore chapter 2 after the transition")
