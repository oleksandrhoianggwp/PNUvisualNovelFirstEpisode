class_name DialoguePaginator
extends RefCounted

const MIN_PAGE_LENGTH := 120
const PREFERRED_BREAK_CHARS := ".!?…;:"


static func paginate(source_text: String, requested_limit: int) -> PackedStringArray:
	var pages := PackedStringArray()
	var remaining := source_text.strip_edges()
	var page_limit := maxi(requested_limit, MIN_PAGE_LENGTH)

	if remaining.is_empty():
		return pages

	while remaining.length() > page_limit:
		var cut := _find_break_position(remaining, page_limit)
		var page := remaining.substr(0, cut).strip_edges()
		if page.is_empty():
			cut = mini(page_limit, remaining.length())
			page = remaining.substr(0, cut).strip_edges()
		pages.append(page)
		remaining = remaining.substr(cut).strip_edges()

	if not remaining.is_empty():
		pages.append(remaining)
	return pages


static func _find_break_position(text: String, page_limit: int) -> int:
	var preferred_floor := maxi(MIN_PAGE_LENGTH, int(page_limit * 0.58))
	for index in range(page_limit - 1, preferred_floor - 1, -1):
		var character := text.substr(index, 1)
		if PREFERRED_BREAK_CHARS.contains(character):
			return index + 1

	for index in range(page_limit - 1, MIN_PAGE_LENGTH - 1, -1):
		if text.substr(index, 1) == " ":
			return index

	return page_limit
