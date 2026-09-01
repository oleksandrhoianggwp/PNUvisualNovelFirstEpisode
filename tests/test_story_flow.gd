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


func _joined_text(ids: Array[String]) -> String:
	var parts: Array[String] = []
	for scene_id in ids:
		parts.append(str(_entry(scene_id).get("text", "")))
	return " ".join(parts)


func _run() -> void:
	_assert_equal(_entry("ch1_124").get("bg", ""), "01_07_room_evening", "Evening conversation switches to morning too early")
	_assert_equal(_entry("ch1_125").get("bg", ""), "01_07_room_evening", "Final night narration uses a morning background")
	_assert_equal(_entry("ch1_126").get("bg", ""), "01_09_room_morning", "Morning background does not start at 'Ніч пройшла…'")
	_assert_equal(_entry("ch1_126").get("transition", ""), "fade", "Night-to-morning transition is missing")
	_assert_equal(_entry("ch1_summary").get("continue_target", ""), "ch2_001", "Chapter 1 does not continue into chapter 2")
	_assert_equal(_entry("ch2_256").get("next", ""), "ch2_summary", "Chapter 2 ending does not open the summary immediately")
	_assert_equal(_entry("ch2_summary").get("continue_target", ""), "ch2_credits", "Chapter 2 summary does not continue directly into the credits")
	_assert_equal(
		_joined_text(["ch2_026", "ch2_027"]),
		"Дарія відверто боялась наступних слів викладачки, невідомо як вона ставиться до запізнень. Та Меланія уже переступила поріг аудиторії, тому довелось тільки покладатись таки на те, що першого разу вони можуть обійтись меншим «виговором».",
		"R-2 fragment 1 text does not match the specification"
	)
	_assert_equal(
		_joined_text(["ch2_094", "ch2_095"]),
		"Як уже було відомо, староста підійшов першим, але представлятись не поспішав. Очікував на свою одногрупницю чи подальші вказівки кураторів? Точно сказати було неможливо. Його обличчя не видавало жодних емоцій. Дарія в будь-якій іншій ситуації назвала б це нічим іншим як байдужість. Та хіба можна було бути байдужим зараз? Можливо, потім. А зараз в це складно вірити. Темне волосся обрамлювало бліде обличчя з чітко окресленими вилицями. За певний час стало зрозуміло: хлопець був надто зосередженим, тому здавався холодним та відстороненим. Дарія зробила висновок, що ймовірно він належить до тієї категорії людей, які багато мовчать, бо спостерігають і бачать більше, ніж інші. Хай там як, а впевнено заявляти про це було рано.",
		"R-2 fragment 2 text does not match the specification"
	)
	_assert_equal(
		_joined_text(["ch2_173", "ch2_174", "ch2_174_2"]),
		"Усі відповіді першокурсників і навіть невелике обговорення потішили кураторку. Вона розповіла ще про важливі місця для студентів, що пригодяться під час навчального процесу. Після низки запитань, екскурсія офіційно була завершена. Кураторка побажала успіхів та перед тим як піти повідомила, що зовсім недалеко розташований молодіжний центр в якому сьогодні теж проводять екскурсії для новачків і порадила обов'язково туди піти, адже студентство – найкращий час для розвитку себе як особистості у різних сферах діяльності. Тож всі рушили за вказаним словами маршрутом. Шукати майже не довелось. Заклад дійсно розташовувався неподалік.",
		"R-2 fragment 3 text does not match the specification"
	)
	_assert_equal(_entry("ch2_174_2").get("type", ""), "narrator", "R-2 fragment 3 continuation is not a dialogue screen")
	_assert_equal(
		_joined_text(["ch1_208", "ch1_209"]),
		"Наступною парою була лекція з предмету «Вступ до мовознавства». Меланія запитала чи можна сісти поряд з Дарією знову. Дівчина погодилась і обидві зрозуміли, що вклали угоду на цілий семестр. Лекція теж пройшла добре, але викликала легке приголомшення. Студенти виходили повільно, хоч і були раді, що навчання на сьогодні завершилось. Дарія виходила однією з останніх. В голові досі крутились якісь нові терміни: «фонема», «морфема». Це все здавалось таким важким.. Вона не знала, що буде робити, але була впевнена, що буде робити щось велике.",
		"R-1 fragment 4 text does not match the specification"
	)
	_assert_equal(_entry("ch2_026").get("text", "").contains("тут розрив"), false, "R-2 split marker leaked into visible text")
	_assert_equal(_entry("ch2_173").get("text", "").contains("тут розрив"), false, "R-2 screen marker leaked into visible text")
	_assert_equal(_entry("ch2_022").get("text", "").contains("ковдрі"), false, "R-2 orthographic correction for ковдри is missing")
	_assert_equal(_entry("ch2_252").get("text", "").contains("разуч"), false, "R-2 orthographic correction for разу is missing")
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
