extends SceneTree

const DialogueData = preload("res://scripts/dialogue/dialogue_data.gd")
const CreditsOverlay = preload("res://scenes/credits/credits_overlay.gd")
const LocalizationScript = preload("res://scripts/localization/localization.gd")
const DialoguePaginator = preload("res://scripts/dialogue/dialogue_paginator.gd")

var failures: Array[String] = []
var localization


func _init() -> void:
	call_deferred("_run")


func _run() -> void:
	localization = LocalizationScript.new()
	get_root().add_child(localization)
	await process_frame
	_assert_equal(DialogueData.DIALOGUES.size(), 485, "Unexpected source dialogue count")
	_assert_equal(localization.english_translation_count(), DialogueData.DIALOGUES.size(), "English translation coverage is incomplete")
	for key in localization.UI:
		var values: Dictionary = localization.UI[key]
		_assert_true(str(values.get("uk", "")) != "", "Missing Ukrainian UI text: " + str(key))
		_assert_true(str(values.get("en", "")) != "", "Missing English UI text: " + str(key))

	localization.set_language("en")
	for source in DialogueData.DIALOGUES:
		var entry: Dictionary = localization.localize_entry(source)
		var entry_id := str(source.get("id", ""))
		_assert_true(localization.has_english_translation(entry_id), "Missing English entry: " + entry_id)
		_assert_equal(str(entry.get("_source_speaker", "")), str(source.get("speaker", "")), "Speaker identity changed: " + entry_id)
		for field in ["speaker", "text", "summary_title", "continue_label", "save_label"]:
			if source.has(field) and str(source[field]) != "":
				_assert_localized(str(entry.get(field, "")), entry_id + ":" + field)
		if str(entry.get("text", "")) != "":
			var english_text := str(entry["text"])
			var pages := DialoguePaginator.paginate(english_text, 420)
			_assert_equal(" ".join(pages), english_text, "English pagination changed content: " + entry_id)
		if source.has("summary_lines"):
			_assert_equal(entry.get("summary_lines", []).size(), source["summary_lines"].size(), "Summary lines mismatch: " + entry_id)
			for line in entry.get("summary_lines", []):
				_assert_localized(str(line), entry_id + ":summary")
		if source.has("choices"):
			_assert_equal(entry.get("choices", []).size(), source["choices"].size(), "Choice count mismatch: " + entry_id)
			for i in range(source["choices"].size()):
				_assert_equal(str(entry["choices"][i].get("target", "")), str(source["choices"][i].get("target", "")), "Choice target changed: " + entry_id)
				_assert_localized(str(entry["choices"][i].get("text", "")), entry_id + ":choice")

	var credits := _entry("ch2_credits")
	_assert_equal(str(credits.get("type", "")), "credits", "Final credits do not use the animated credits scene")
	var credit_text := "\n".join(CreditsOverlay.CREDIT_BLOCKS.map(func(block): return str(block.get("text", ""))))
	_assert_true(credit_text.find("Сірадчук Яна Василівна") < credit_text.find("Yana Vasylivna Siradchuk"), "Ukrainian credits must precede English credits")
	for required in ["Гоян Олександр Васильович", "Oleksandr Vasylovych Hoian", "Godot Engine", "Godot SQLite", "SQLite", "Kistol", "CC0"]:
		_assert_true(credit_text.contains(required), "Credits omit required attribution: " + required)

	localization.set_language("uk")
	if failures.is_empty():
		print("PASS test_localization_and_credits: 485/485 entries, bilingual UI, credits and attribution")
		quit(0)
	else:
		for failure in failures:
			push_error(failure)
		quit(1)


func _assert_localized(value: String, context: String) -> void:
	_assert_true(value != "", "Empty English text: " + context)
	var cyrillic := RegEx.new()
	cyrillic.compile("[А-Яа-яІіЇїЄєҐґ]")
	_assert_true(cyrillic.search(value) == null, "Cyrillic remains in English text: " + context)


func _entry(entry_id: String) -> Dictionary:
	for entry in DialogueData.DIALOGUES:
		if str(entry.get("id", "")) == entry_id:
			return entry
	return {}


func _assert_true(value: bool, message: String) -> void:
	if not value:
		failures.append(message)


func _assert_equal(actual, expected, message: String) -> void:
	if actual != expected:
		failures.append("%s (actual=%s expected=%s)" % [message, str(actual), str(expected)])
