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
	if failures.is_empty():
		print("PASS test_story_flow: night-to-morning and chapter transition order")
		quit(0)
	else:
		print("FAIL test_story_flow: ", failures.size(), " failure(s)")
		quit(1)
