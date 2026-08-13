extends SceneTree

var failures: Array[String] = []
var manager: Node


func _init() -> void:
	call_deferred("_run")


func _assert_equal(actual, expected, message: String) -> void:
	if actual != expected:
		failures.append(message)
		push_error(message + " (expected " + str(expected) + ", got " + str(actual) + ")")


func _run() -> void:
	manager = root.get_node("GameManager")
	root.get_node("Localization").set_language("uk")
	manager.reset_progress()

	manager.jump_to_scene("ch1_017")
	var dorm_notifications: Array[Dictionary] = manager.apply_effects({"reputation": 1, "silhouette_boy": 1})
	_assert_equal(manager.reputation, 1, "Global reputation did not change immediately")
	_assert_equal(manager.relationships["silhouette_boy"], 1, "Unknown character relationship did not accumulate")
	_assert_equal(dorm_notifications[1]["text"], "Незнайомець", "Unknown male relationship exposes the placeholder name")

	manager.jump_to_scene("ch1_060")
	var maria_notifications: Array[Dictionary] = manager.apply_effects({"maria": 1})
	_assert_equal(maria_notifications[0]["text"], "Незнайомка", "Unknown female relationship exposes her name too early")
	manager.jump_to_scene("ch1_071")
	_assert_equal(manager.relationship_display_name("maria"), "Марія", "Relationship label did not update after the introduction")
	_assert_equal(manager.relationships["maria"], 1, "Relationship value was reset when the name became known")

	manager.reveal_character("silhouette_boy")
	_assert_equal(manager.relationship_display_name("silhouette_boy"), "Хлопець", "Explicit future name reveal is ignored")
	_assert_equal(manager.relationships["silhouette_boy"], 1, "Explicit name reveal reset the accumulated relationship")

	if failures.is_empty():
		print("PASS test_relationship_identity: unknown labels, reveal state, and accumulated values")
		quit(0)
	else:
		print("FAIL test_relationship_identity: ", failures.size(), " failure(s)")
		quit(1)
