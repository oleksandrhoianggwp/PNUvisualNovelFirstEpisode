extends RefCounted

const Chapter1 = preload("res://scripts/dialogues/dialogue_chapter_1.gd")
const Chapter2 = preload("res://scripts/dialogues/dialogue_chapter_2.gd")

# Dev jump points:
# - start_chapter_1: GameManager.start_chapter_1()
# - start_chapter_2: GameManager.start_chapter_2()
# - jump_to_scene("ch2_001"): GameManager.jump_to_scene("ch2_001")
# - relationship values: GameManager.relationships

const CHAPTER_1_DIALOGUES: Array = Chapter1.CHAPTER_1_DIALOGUES
const CHAPTER_2_DIALOGUES: Array = Chapter2.CHAPTER_2_DIALOGUES
const DIALOGUES: Array = CHAPTER_1_DIALOGUES + CHAPTER_2_DIALOGUES

static func get_start_id(chapter: int = 1) -> String:
	return Chapter2.START_ID if chapter == 2 else Chapter1.START_ID
