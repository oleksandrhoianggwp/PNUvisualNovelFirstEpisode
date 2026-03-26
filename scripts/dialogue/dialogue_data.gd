extends RefCounted

# Format:
#   bg       - filename from Picture/background/ (without .png)
#   left     - "folder/filename" from Picture/character/ (without .png), or "" for none
#   right    - same as left
#   speaker  - character name displayed in dialogue box, or "" for narration
#   text     - dialogue text
#   choices  - optional array of {"text": "...", "target": index}

const DIALOGUES: Array = [
	# --- Scene 1: Train ---
	{
		"bg": "01_train_evening",
		"left": "", "right": "",
		"speaker": "",
		"text": "Потяг м'яко гойдається. За вiкном пролiтають поля, залитi вечiрнiм сонцем."
	},
	{
		"bg": "01_train_evening",
		"left": "daria_main/daria_neutral", "right": "",
		"speaker": "Дарiя",
		"text": "Ще трохи... i я нарештi буду там. Новий унiверситет, нове мiсто, нове життя."
	},
	{
		"bg": "01_train_evening",
		"left": "daria_main/daria_anxious", "right": "",
		"speaker": "Дарiя",
		"text": "Хоча... трохи страшно, якщо чесно."
	},

	# --- Scene 2: Station ---
	{
		"bg": "02_station_platform_sunset",
		"left": "daria_main/daria_neutral", "right": "",
		"speaker": "",
		"text": "Потяг зупиняється. Дарiя виходить на перон з валiзою."
	},
	{
		"bg": "02_station_platform_sunset",
		"left": "daria_main/daria_smile", "right": "",
		"speaker": "Дарiя",
		"text": "Ось i Iвано-Франкiвськ. Тепер треба знайти гуртожиток."
	},

	# --- Scene 3: Dorm exterior ---
	{
		"bg": "03_dorm_exterior_evening",
		"left": "daria_main/daria_neutral", "right": "strangerNearTheHostel/strangerNearTheHostel_Neural",
		"speaker": "",
		"text": "Бiля входу до гуртожитку стоїть хтось."
	},
	{
		"bg": "03_dorm_exterior_evening",
		"left": "daria_main/daria_neutral", "right": "strangerNearTheHostel/strangerNearTheHostel_Neural",
		"speaker": "Незнайомець",
		"text": "Привiт! Ти теж першокурсниця?"
	},

	# --- Scene 4: Dorm lobby ---
	{
		"bg": "04_dorm_lobby_reception",
		"left": "daria_main/daria_neutral", "right": "watchwoman/watchwoman_neutral",
		"speaker": "Вахтерка",
		"text": "Документи, будь ласка. Кiмната 92, п'ятий поверх."
	},
	{
		"bg": "04_dorm_lobby_reception",
		"left": "daria_main/daria_smile", "right": "watchwoman/watchwoman_neutral",
		"speaker": "Дарiя",
		"text": "Дякую!"
	},

	# --- Scene 5: Corridor ---
	{
		"bg": "05_dorm_5th_floor_corridor_room_92",
		"left": "daria_main/daria_neutral", "right": "",
		"speaker": "",
		"text": "Довгий коридор п'ятого поверху. Двері з номером 92."
	},

	# --- Scene 6: Room (dark) ---
	{
		"bg": "06a_dorm_room_92_dark",
		"left": "daria_main/daria_anxious", "right": "",
		"speaker": "Дарiя",
		"text": "Темно... Де тут вимикач?"
	},

	# --- Scene 6b: Room (light) ---
	{
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_smile", "right": "maria/maria_smile",
		"speaker": "Марiя",
		"text": "О, привiт! Ти моя нова сусiдка? Я Марiя!"
	},
	{
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_smile", "right": "maria/maria_playful",
		"speaker": "Марiя",
		"text": "Будемо найкращими подругами, ось побачиш!"
	},

	# --- Scene 7: University yard ---
	{
		"bg": "08_university_yard_morning",
		"left": "daria_main/daria_neutral", "right": "",
		"speaker": "",
		"text": "Наступного ранку. Подвiр'я унiверситету повне студентiв."
	},
	{
		"bg": "08_university_yard_morning",
		"left": "daria_main/daria_neutral", "right": "anna/anna_neutral",
		"speaker": "Анна",
		"text": "Привiт, ти теж шукаєш аудиторiю 301?"
	},
	{
		"bg": "08_university_yard_morning",
		"left": "daria_main/daria_smile", "right": "anna/anna_supportive",
		"speaker": "Дарiя",
		"text": "Так! Пiдемо разом?"
	},

	# --- Scene 8: Classroom ---
	{
		"bg": "09_classroom_cozy_day",
		"left": "daria_main/daria_neutral", "right": "Lydia_Ivanovna/LydiaIvanovna_Smile",
		"speaker": "Лiдiя Iванiвна",
		"text": "Доброго ранку, студенти! Ласкаво прошу на перше заняття."
	},
	{
		"bg": "09_classroom_cozy_day",
		"left": "daria_main/daria_neutral", "right": "melania/melania_serious",
		"speaker": "Меланiя",
		"text": "Цiкаво, що нас тут чекає..."
	},

	# --- Scene 9: Restaurant ---
	{
		"bg": "11_restaurant_evening",
		"left": "daria_main/daria_smile", "right": "maria/maria_funny",
		"speaker": "Марiя",
		"text": "За нове життя! За нових друзiв!"
	},
	{
		"bg": "11_restaurant_evening",
		"left": "daria_main/daria_smile", "right": "anna/anna_irony",
		"speaker": "Анна",
		"text": "I за те, щоб завтра не проспати першу пару."
	},
	{
		"bg": "11_restaurant_evening",
		"left": "daria_main/daria_smile", "right": "",
		"speaker": "",
		"text": "Кiнець Епiзоду 1."
	},
]
