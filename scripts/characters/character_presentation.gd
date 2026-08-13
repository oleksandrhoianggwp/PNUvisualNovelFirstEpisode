class_name CharacterPresentation
extends RefCounted

const CHARACTER_SCALES := {
	"strangerNearTheHostel": 1.26,
}


static func normalize_slots(entry: Dictionary) -> Dictionary:
	var slots := {
		"left": str(entry.get("left", "")),
		"center": str(entry.get("center", "")),
		"right": str(entry.get("right", "")),
	}
	var center_folder := folder_for(str(slots["center"]))
	var entry_type := str(entry.get("type", "dialogue"))
	if center_folder == "daria_main" and entry_type in ["dialogue", "thought"]:
		if str(slots["left"]) == "":
			slots["left"] = slots["center"]
			slots["center"] = ""
		elif str(slots["right"]) == "":
			slots["right"] = slots["center"]
			slots["center"] = ""
	return slots


static func folder_for(character_key: String) -> String:
	if character_key == "":
		return ""
	if character_key.begins_with("res://"):
		var marker := "/character/"
		var marker_index := character_key.find(marker)
		if marker_index >= 0:
			return character_key.substr(marker_index + marker.length()).get_slice("/", 0)
	return character_key.get_slice("/", 0)


static func scale_for(character_key: String) -> float:
	return float(CHARACTER_SCALES.get(folder_for(character_key), 1.0))


static func concealed_slots(entry: Dictionary) -> Array:
	var result: Array = []
	for slot in entry.get("concealed_slots", []):
		result.append(str(slot))
	return result
