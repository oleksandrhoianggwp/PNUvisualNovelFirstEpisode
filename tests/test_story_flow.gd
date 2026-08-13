extends SceneTree

const DialogueData = preload("res://scripts/dialogue/dialogue_data.gd")

var failures: Array[String] = []


func _init() -> void:
	call_deferred("_run")


func _assert_equal(actual, expected, message: String) -> void:
	if actual != expected:
		failures.append(message)
		push_error(message + " (expected " + str(expected) + ", got " + str(actual) + ")")


func _entry(scene_id: String) -> Dictionary:
	for entry in DialogueData.DIALOGUES:
		if str(entry.get("id", "")) == scene_id:
			return entry
	return {}


func _run() -> void:
	_assert_equal(_entry("ch1_124").get("bg", ""), "01_07_room_evening", "Evening conversation switches to morning too early")
	_assert_equal(_entry("ch1_125").get("bg", ""), "01_07_room_evening", "Final night narration uses a morning background")
	_assert_equal(_entry("ch1_126").get("bg", ""), "01_09_room_morning", "Morning background does not start at 'Ніч пройшла…'")
	_assert_equal(_entry("ch1_126").get("transition", ""), "fade", "Night-to-morning transition is missing")
	_assert_equal(_entry("ch1_summary").get("continue_target", ""), "ch2_001", "Chapter 1 does not continue into chapter 2")
	_assert_equal(_entry("ch2_256").get("next", ""), "ch2_summary", "Chapter 2 ending does not open the summary immediately")
	_assert_equal(_entry("ch2_summary").get("continue_target", ""), "ch2_credits", "Chapter 2 summary does not continue directly into the credits")
	_assert_equal(
		FileAccess.get_sha256("res://Picture/background/01_07_room_evening.png").to_upper(),
		"971BD3E9DA6D0A94B59869A42AC237EC10608941092F4832E9AE7B0FF76B1963",
		"Evening dorm background is not the user-provided image"
	)
	_assert_equal(
		FileAccess.get_sha256("res://Picture/background/02_04_library.png").to_upper(),
		"914095B0705975E29D45D4EFEFC3CED90382F27F15488F23E31E696B35CA0531",
		"Library background is not the user-provided image"
	)
	var credits_text := "\n".join(_entry("ch2_credits").get("summary_lines", []))
	_assert_equal(credits_text.contains("Сірадчук Яна Василівна"), true, "Credits omit the screenwriter's full name")
	_assert_equal(credits_text.contains("Гоян Олександр Васильович"), true, "Credits omit the developer's full name")
	if failures.is_empty():
		print("PASS test_story_flow: night-to-morning and chapter transition order")
		quit(0)
	else:
		print("FAIL test_story_flow: ", failures.size(), " failure(s)")
		quit(1)
