extends SceneTree

const DialogueData = preload("res://scripts/dialogue/dialogue_data.gd")
const CharacterPresentation = preload("res://scripts/characters/character_presentation.gd")

var manager: Node
var failures: Array[String] = []


func _init() -> void:
	call_deferred("_run")


func _assert_true(condition: bool, message: String) -> void:
	if not condition:
		failures.append(message)
		push_error(message)


func _entry(scene_id: String) -> Dictionary:
	for entry in DialogueData.DIALOGUES:
		if str(entry.get("id", "")) == scene_id:
			return entry
	return {}


func _run() -> void:
	manager = root.get_node("GameManager")
	_test_data_bindings_and_resources()
	await _test_side_slot_and_active_speaker()
	await _test_stranger_scale()
	await _test_concealed_reveal()
	if failures.is_empty():
		print("PASS test_character_presentation: bindings, focus, scale, slots, and silhouette")
		quit(0)
	else:
		print("FAIL test_character_presentation: ", failures.size(), " failure(s)")
		quit(1)


func _test_data_bindings_and_resources() -> void:
	_assert_true(str(_entry("ch1_149").get("right", "")).begins_with("marta/"), "Marta introduction still uses another character")
	_assert_true(str(_entry("ch1_151").get("right", "")).begins_with("marta/"), "Marta name reveal still uses another character")
	var normalized := CharacterPresentation.normalize_slots(_entry("ch1_029"))
	_assert_true(str(normalized["left"]).begins_with("daria_main/"), "Daria was not moved to a side slot")
	_assert_true(str(normalized["center"]) == "", "Daria remains in the center during dialogue")
	for entry in DialogueData.DIALOGUES:
		for position in ["left", "center", "right"]:
			var character := str(entry.get(position, ""))
			if character != "":
				_assert_true(ResourceLoader.exists("res://Picture/character/" + character + ".png"), str(entry.get("id", "?")) + " references a missing character asset")
			if character.begins_with("luka/"):
				_assert_true(character == "luka/luka", str(entry.get("id", "?")) + " references a removed Luka expression")
	_assert_true(not ResourceLoader.exists("res://Picture/character/luka/luka_smile.png"), "Removed Luka smile asset is still imported")
	_assert_true(not ResourceLoader.exists("res://Picture/character/luka/luka_awkward.png"), "Removed Luka awkward asset is still imported")


func _open_scene(scene_id: String) -> Control:
	manager.reset_progress()
	manager.jump_to_scene(scene_id)
	manager.settings["text_speed"] = 0.0
	change_scene_to_file("res://scenes/game/game.tscn")
	for frame in range(35):
		await process_frame
	return current_scene


func _test_side_slot_and_active_speaker() -> void:
	var game := await _open_scene("ch1_028")
	var left: TextureRect = game.get_node("CharacterLeft")
	var right: TextureRect = game.get_node("CharacterRight")
	_assert_true(left.modulate.a < 0.05, "Inactive Daria remains visible while the watchwoman speaks")
	_assert_true(right.modulate.a > 0.95, "Active watchwoman is not fully visible")

	game = await _open_scene("ch1_029")
	left = game.get_node("CharacterLeft")
	var center: TextureRect = game.get_node("CharacterCenter")
	_assert_true(left.visible and left.texture != null and left.modulate.a > 0.95, "Speaking Daria is not visible in the side slot")
	_assert_true(not center.visible or center.texture == null, "Center slot is still occupied by Daria")


func _test_stranger_scale() -> void:
	var game := await _open_scene("ch1_015")
	var left: TextureRect = game.get_node("CharacterLeft")
	var right: TextureRect = game.get_node("CharacterRight")
	_assert_true(absf(left.scale.x - 1.0) < 0.03, "Daria base scale changed unexpectedly")
	_assert_true(absf(right.scale.x - 1.0) < 0.03, "Stranger presentation scale is not normalized")
	_assert_true(maxf(right.modulate.r, maxf(right.modulate.g, right.modulate.b)) < 0.06, "Unknown dorm character is not concealed on first appearance")
	_assert_true(right.texture.get_size().y > 3000.0, "Dorm silhouette no longer preserves the source character dimensions")


func _test_concealed_reveal() -> void:
	var game := await _open_scene("ch1_051")
	var left: TextureRect = game.get_node("CharacterLeft")
	var right: TextureRect = game.get_node("CharacterRight")
	_assert_true(left.modulate.a < 0.05, "Inactive protagonist remains visible in the scare reveal")
	_assert_true(right.modulate.a > 0.9, "Mystery silhouette is hidden instead of presented")
	_assert_true(maxf(right.modulate.r, maxf(right.modulate.g, right.modulate.b)) < 0.06, "Mystery character identity is still visually revealed")
