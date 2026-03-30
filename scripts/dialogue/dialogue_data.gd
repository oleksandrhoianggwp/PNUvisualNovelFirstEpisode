extends RefCounted

# Format:
#   bg         - filename from Picture/background/ (without .png)
#   left       - "folder/filename" from Picture/character/ (without .png), or "" for none
#   right      - same as left
#   speaker    - character name displayed in dialogue box, or "" for narration
#   text       - dialogue text
#   type       - "narrator", "dialogue", "thought", "system"
#   choices    - optional array of {"text": "...", "target": index}
#   transition - optional: "crossfade", "flash", "none"

const DIALOGUES: Array = [
	# ===================================================================
	#  SCENE 1: TRAIN  (ID 0-5)
	#  bg: 01_train_evening
	# ===================================================================
	{ # 0
		"bg": "01_train_evening",
		"left": "", "right": "",
		"speaker": "", "type": "narrator",
		"text": "Зовсім скоро розпочнеться Ваша подорож у світі філології. Готові?"
	},
	{ # 1
		"bg": "01_train_evening",
		"left": "daria_main/daria_neutral", "right": "",
		"speaker": "", "type": "narrator",
		"text": "За вікном потроху згущувалися сутінки. Потяг мчав все швидше, віддаляючи Дарію від рідної домівки. Дівчина обводила поглядом розлогий краєвид, шукаючи відповідь на власні запитання."
	},
	{ # 2
		"bg": "01_train_evening",
		"left": "daria_main/daria_neutral", "right": "",
		"speaker": "Дарія", "type": "dialogue",
		"text": "Вже завтра розпочнеться моя нова сторінка життя. Неймовірно захопливо і.. страшенно хвилююче!"
	},
	{ # 3
		"bg": "01_train_evening",
		"left": "daria_main/daria_anxious", "right": "",
		"speaker": "Дарія", "type": "dialogue",
		"text": "Чи буде моє студентське життя таким прекрасним як всі розповідають?"
	},
	{ # 4
		"bg": "01_train_evening",
		"left": "daria_main/daria_anxious", "right": "",
		"speaker": "", "type": "narrator",
		"text": "На серці дівчини було неспокійно та поряд з тим в нім жевріла надія. І якесь нове абсолютно невідоме їй відчуття — щемка невідомість."
	},
	{ # 5
		"bg": "01_train_evening",
		"left": "daria_main/daria_smile", "right": "",
		"speaker": "Дарія", "type": "thought",
		"text": "Я обов'язково зроблю його незабутнім."
	},

	# ===================================================================
	#  SCENE 2: STATION + BUS RIDE  (ID 6-12)
	#  bg: 02_station_platform_sunset
	# ===================================================================
	{ # 6
		"bg": "02_station_platform_sunset",
		"left": "daria_main/daria_neutral", "right": "",
		"speaker": "", "type": "narrator",
		"text": "Дарія несміливо ступила на перон, зливаючись з потоком людей. Зупинилася на мить, вдихаючи аромат теплого вечора в ще чужому місті, яке згодом стане рідним і їй.",
		"transition": "crossfade"
	},
	{ # 7
		"bg": "02_station_platform_sunset",
		"left": "daria_main/daria_anxious", "right": "",
		"speaker": "", "type": "narrator",
		"text": "Всю дорогу до гуртожитку дівчина панікувала і якомога сильніше вдивлялася у темні обриси будинків. Пропустити зупинку для неї зараз може стати просто катастрофою."
	},
	{ # 8
		"bg": "02_station_platform_sunset",
		"left": "daria_main/daria_anxious", "right": "",
		"speaker": "", "type": "narrator",
		"text": "Та й хто допоможе? Немає друзів і рідних. Вона знову згадала, що абсолютно самотня у цьому великому незнайомому місті."
	},
	{ # 9
		"bg": "02_station_platform_sunset",
		"left": "daria_main/daria_neutral", "right": "",
		"speaker": "Дарія", "type": "thought",
		"text": "Це ненадовго."
	},
	{ # 10
		"bg": "02_station_platform_sunset",
		"left": "daria_main/daria_neutral", "right": "",
		"speaker": "", "type": "narrator",
		"text": "Мимоволі їй пригадався твір Валер'яна Підмогильного, що дуже захопив її в школі."
	},
	{ # 11
		"bg": "02_station_platform_sunset",
		"left": "daria_main/daria_smile", "right": "",
		"speaker": "Дарія", "type": "thought",
		"text": "Підкорю місто як Степан Радченко! Хоча.. напевно, саме як Радченко не хотілося б.."
	},
	{ # 12
		"bg": "02_station_platform_sunset",
		"left": "daria_main/daria_smile", "right": "",
		"speaker": "", "type": "narrator",
		"text": "Дівчина посміхнулася про себе і це дозволило їй трохи розслабитись."
	},

	# ===================================================================
	#  SCENE 3: DORM EXTERIOR  (ID 13-24)  + CHOICE 1
	#  bg: 03_dorm_exterior_evening
	# ===================================================================
	{ # 13
		"bg": "03_dorm_exterior_evening",
		"left": "daria_main/daria_neutral", "right": "",
		"speaker": "", "type": "narrator",
		"text": "Та ненадовго. Адже автобус вже зупиняється і ось — її новий дім!",
		"transition": "crossfade"
	},
	{ # 14
		"bg": "03_dorm_exterior_evening",
		"left": "daria_main/daria_anxious", "right": "",
		"speaker": "", "type": "narrator",
		"text": "Гуртожиток налякав Дарію ще більше. І річ не в тарганах, яких вона ще навіть не встигла побачити. Увесь страх невідомості виріс в ній і постав перед очима образом цієї будівлі: величезної, темної.."
	},
	{ # 15
		"bg": "03_dorm_exterior_evening",
		"left": "daria_main/daria_anxious", "right": "",
		"speaker": "", "type": "narrator",
		"text": "Дівчина ніколи не була надто хороброю та вдома це не було проблемою. В дорослому житті доведеться трохи над собою попрацювати."
	},
	{ # 16
		"bg": "03_dorm_exterior_evening",
		"left": "daria_main/daria_anxious", "right": "",
		"speaker": "Дарія", "type": "thought",
		"text": "Здається, не трохи.."
	},
	{ # 17
		"bg": "03_dorm_exterior_evening",
		"left": "daria_main/daria_neutral", "right": "",
		"speaker": "", "type": "narrator",
		"text": "Та все ж виходу немає і вона так мріяла бути студенткою. Там всередині її очікують такі самі люди. Немає чого боятись, вона з кимось подружиться. Вона — не одна."
	},
	{ # 18
		"bg": "03_dorm_exterior_evening",
		"left": "daria_main/daria_anxious", "right": "strangerNearTheHostel/strangerNearTheHostel_Neural",
		"speaker": "", "type": "narrator",
		"text": "Зібравшись духом дівчина рушила подвір'ям. Піднімаючись сходами Дарія випадково зачепила своєю величезною сумкою хлопця, що проходив поруч."
	},
	{ # 19 — CHOICE 1
		"bg": "03_dorm_exterior_evening",
		"left": "daria_main/daria_anxious", "right": "strangerNearTheHostel/strangerNearTheHostel_Neural",
		"speaker": "Дарія", "type": "dialogue",
		"text": "Боже, як незручно! Я стаю надто незграбною з таким великим багажем..",
		"choices": [
			{"text": "Попросити вибачення", "target": 20, "effects": {"reputation": 1}},
			{"text": "Мовчки пройти повз", "target": 25, "effects": {"reputation": -1}}
		]
	},

	# --- Choice 1, Branch A: Apologize (ID 20-24) ---
	{ # 20
		"bg": "03_dorm_exterior_evening",
		"left": "daria_main/daria_anxious", "right": "strangerNearTheHostel/strangerNearTheHostel_Neural",
		"speaker": "Дарія", "type": "dialogue",
		"text": "Пробачте, будь ласка. Я випадково.."
	},
	{ # 21
		"bg": "03_dorm_exterior_evening",
		"left": "daria_main/daria_anxious", "right": "strangerNearTheHostel/strangerNearTheHostel_Neural",
		"speaker": "", "type": "narrator",
		"text": "На обличчі заграли сором'язливі барви. Та незважаючи на це, вибачення здалось їй обов'язковим вчинком."
	},
	{ # 22
		"bg": "03_dorm_exterior_evening",
		"left": "daria_main/daria_neutral", "right": "strangerNearTheHostel/strangerNearTheHostel_Neural",
		"speaker": "Дарія", "type": "thought",
		"text": "Потрібно проявляти ввічливість до людей навколо. І починати забувати про сором! З усіма таке трапляється. Правда ж?.."
	},
	{ # 23
		"bg": "03_dorm_exterior_evening",
		"left": "daria_main/daria_neutral", "right": "strangerNearTheHostel/strangerNearTheHostel_Neural",
		"speaker": "", "type": "narrator",
		"text": "Хлопець ледь помітно посміхнувся і продовжив ходу."
	},
	{ # 24
		"bg": "03_dorm_exterior_evening",
		"left": "daria_main/daria_neutral", "right": "",
		"speaker": "", "type": "system",
		"text": "Зроблений вибір вплине на майбутнє!",
		"target": 28
	},

	# --- Choice 1, Branch B: Walk past silently (ID 25-27) ---
	{ # 25
		"bg": "03_dorm_exterior_evening",
		"left": "daria_main/daria_anxious", "right": "strangerNearTheHostel/strangerNearTheHostel_Neural",
		"speaker": "", "type": "narrator",
		"text": "Дарія покрилася рум'янцем не в силах сказати хоч щось. Їй хотілось пошвидше дійти до, напевно, затишної кімнати і забути про цей вечірній сором. Кепський початок."
	},
	{ # 26
		"bg": "03_dorm_exterior_evening",
		"left": "daria_main/daria_anxious", "right": "",
		"speaker": "Дарія", "type": "thought",
		"text": "Наступного разу буду обережнішою.."
	},
	{ # 27 — hidden jump to merge
		"bg": "03_dorm_exterior_evening",
		"left": "daria_main/daria_neutral", "right": "",
		"speaker": "", "type": "narrator",
		"text": "",
		"target": 28
	},

	# ===================================================================
	#  SCENE 4: DORM LOBBY  (ID 28-36)
	#  bg: 04_dorm_lobby_reception
	# ===================================================================
	{ # 28
		"bg": "04_dorm_lobby_reception",
		"left": "daria_main/daria_neutral", "right": "watchwoman/watchwoman_neutral",
		"speaker": "", "type": "narrator",
		"text": "Відчинивши величезні і важкі двері, студентка привіталася з вахтою, показавши яскраво рожеву перепустку.",
		"transition": "crossfade"
	},
	{ # 29
		"bg": "04_dorm_lobby_reception",
		"left": "daria_main/daria_neutral", "right": "watchwoman/watchwoman_neutral",
		"speaker": "Вахтерка", "type": "dialogue",
		"text": "До якої кімнати Ви поселені?"
	},
	{ # 30
		"bg": "04_dorm_lobby_reception",
		"left": "daria_main/daria_neutral", "right": "watchwoman/watchwoman_neutral",
		"speaker": "Дарія", "type": "dialogue",
		"text": "Дев'яносто друга."
	},
	{ # 31
		"bg": "04_dorm_lobby_reception",
		"left": "daria_main/daria_neutral", "right": "watchwoman/watchwoman_neutral",
		"speaker": "Вахтерка", "type": "dialogue",
		"text": "Вам потрібно повернути наліво, дійти до п'ятого поверху, а опісля повернути направо."
	},
	{ # 32
		"bg": "04_dorm_lobby_reception",
		"left": "daria_main/daria_smile", "right": "watchwoman/watchwoman_neutral",
		"speaker": "Дарія", "type": "dialogue",
		"text": "Дякую."
	},
	{ # 33
		"bg": "04_dorm_lobby_reception",
		"left": "daria_main/daria_smile", "right": "watchwoman/watchwoman_neutral",
		"speaker": "Вахтерка", "type": "dialogue",
		"text": "Щасти."
	},
	{ # 34
		"bg": "04_dorm_lobby_reception",
		"left": "daria_main/daria_smile", "right": "",
		"speaker": "", "type": "narrator",
		"text": "Що ж.. Не все так погано. Навіть страшна вахта, що сниться студентам в кошмарах, не така вже й страшна. Чи вона мила тільки сьогодні?"
	},
	{ # 35
		"bg": "04_dorm_lobby_reception",
		"left": "daria_main/daria_smile", "right": "",
		"speaker": "Дарія", "type": "thought",
		"text": "Акція чи на мені є невидима таблиця з надписом «Обережно, першокурсниця!»?"
	},
	{ # 36
		"bg": "04_dorm_lobby_reception",
		"left": "daria_main/daria_neutral", "right": "",
		"speaker": "", "type": "narrator",
		"text": "Внутрішня напруга, що була як тягар, і без того нелегкої ноші, потрохи проходила. Всередині з'явилося світле почуття надії, що і в кімнаті зараз все складеться найкращим чином."
	},

	# ===================================================================
	#  SCENE 5: 5TH FLOOR CORRIDOR  (ID 37-43)  + CHOICE 2
	#  bg: 05_dorm_5th_floor_corridor_room_92
	# ===================================================================
	{ # 37
		"bg": "05_dorm_5th_floor_corridor_room_92",
		"left": "daria_main/daria_neutral", "right": "",
		"speaker": "", "type": "narrator",
		"text": "Дарія зупинилася біля входу на п'ятий поверх.",
		"transition": "crossfade"
	},
	{ # 38 — CHOICE 2
		"bg": "05_dorm_5th_floor_corridor_room_92",
		"left": "daria_main/daria_anxious", "right": "",
		"speaker": "Дарія", "type": "thought",
		"text": "Ой, і куди там далі?..",
		"choices": [
			{"text": "Наліво", "target": 39},
			{"text": "Направо", "target": 43}
		]
	},

	# --- Choice 2, Branch A: Left (ID 39-42) ---
	{ # 39
		"bg": "05_dorm_5th_floor_corridor_room_92",
		"left": "daria_main/daria_neutral", "right": "",
		"speaker": "", "type": "narrator",
		"text": "Юначка сміливо рушила до дверей кімнати, проте вчасно помітила номер."
	},
	{ # 40
		"bg": "05_dorm_5th_floor_corridor_room_92",
		"left": "daria_main/daria_anxious", "right": "",
		"speaker": "Дарія", "type": "thought",
		"text": "Ні, це дев'яносто четверта. Помилилась. Завчасно познайомилася б з іншими студентами."
	},
	{ # 41
		"bg": "05_dorm_5th_floor_corridor_room_92",
		"left": "daria_main/daria_neutral", "right": "",
		"speaker": "", "type": "narrator",
		"text": "Їй довелося повернутися, але віднайти потрібну кімнату не стало проблемою. Виявляється, вона була сусідньою.",
		"target": 45
	},
	{ # 42 — spacer, not used
		"bg": "05_dorm_5th_floor_corridor_room_92",
		"left": "", "right": "",
		"speaker": "", "type": "narrator",
		"text": "",
		"target": 45
	},

	# --- Choice 2, Branch B: Right (ID 43-44) ---
	{ # 43
		"bg": "05_dorm_5th_floor_corridor_room_92",
		"left": "daria_main/daria_neutral", "right": "",
		"speaker": "", "type": "narrator",
		"text": "Студентка попрямувала до дверей, вишукуючи очима номер."
	},
	{ # 44
		"bg": "05_dorm_5th_floor_corridor_room_92",
		"left": "daria_main/daria_smile", "right": "",
		"speaker": "Дарія", "type": "thought",
		"text": "Дійсно дев'яносто друга.",
		"target": 45
	},

	# ===================================================================
	#  SCENE 6: DARK ROOM  (ID 45-59)  + CHOICE 3
	#  bg: 06a_dorm_room_92_dark → 06b_dorm_room_92_light
	# ===================================================================
	{ # 45
		"bg": "06a_dorm_room_92_dark",
		"left": "daria_main/daria_neutral", "right": "",
		"speaker": "Дарія", "type": "thought",
		"text": "Ну, що ж..",
		"transition": "crossfade"
	},
	{ # 46
		"bg": "06a_dorm_room_92_dark",
		"left": "daria_main/daria_anxious", "right": "",
		"speaker": "", "type": "narrator",
		"text": "Глибоко вдихнувши, дівчина натиснула на дверну ручку. Погляд, повний приємного піднесення, зустріла тиха темнота.. Дикий контраст між очікуваннями і реальністю."
	},
	{ # 47
		"bg": "06a_dorm_room_92_dark",
		"left": "daria_main/daria_anxious", "right": "",
		"speaker": "", "type": "narrator",
		"text": "Дарії пригадався безглуздий страх з дитинства, а уява почала малювати колючих монстрів, що от-от вистрибнуть з кутка. Вона з непевністю зробила крок уперед."
	},
	{ # 48
		"bg": "06a_dorm_room_92_dark",
		"left": "daria_main/daria_anxious", "right": "",
		"speaker": "Дарія", "type": "thought",
		"text": "Повинен же хтось тут.."
	},
	{ # 49
		"bg": "06a_dorm_room_92_dark",
		"left": "daria_main/daria_anxious", "right": "",
		"speaker": "", "type": "narrator",
		"text": "Не закінчивши думку, Дарія почула шурхіт позаду себе. Здається, треба менше хвилюватися, бо не вистачало ще і галюцинацій. Чи це було насправді?"
	},
	{ # 50
		"bg": "06a_dorm_room_92_dark",
		"left": "daria_main/daria_anxious", "right": "",
		"speaker": "Невідомий", "type": "dialogue",
		"text": "Бу!"
	},
	{ # 51
		"bg": "06a_dorm_room_92_dark",
		"left": "daria_main/daria_anxious", "right": "",
		"speaker": "", "type": "narrator",
		"text": "Серце почало шалено битись, тіло вмить скував страх. У голові навіть не встигла зародитись жодна твереза думка, яка сказала б це не робити, а тому.."
	},
	{ # 52
		"bg": "06a_dorm_room_92_dark",
		"left": "daria_main/daria_anxious", "right": "",
		"speaker": "", "type": "narrator",
		"text": "Дарія закричала щосили."
	},
	{ # 53
		"bg": "06a_dorm_room_92_dark",
		"left": "daria_main/daria_anxious", "right": "",
		"speaker": "", "type": "narrator",
		"text": "Інстинктивно вона повернулася, щоб вибігти з цієї зловісної темної студентської кімнати. Гуртожиток вмить здався їй печерою повною небезпек."
	},
	{ # 54
		"bg": "06a_dorm_room_92_dark",
		"left": "daria_main/daria_anxious", "right": "",
		"speaker": "", "type": "narrator",
		"text": "Дарія нагадувала сама собі крота, який відчайдушно рукою намагається наосліп щось знайти. В цьому випадку це була дверна ручка, цілий портал, що відділить її від кошмару.."
	},
	{ # 55
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_anxious", "right": "maria/maria_smile",
		"speaker": "", "type": "narrator",
		"text": "Та раптом яскраве світло заливає приміщення, боляче вдаряючи в очі.",
		"transition": "flash"
	},
	{ # 56
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_anxious", "right": "maria/maria_smile",
		"speaker": "Марія", "type": "dialogue",
		"text": "Вибач, налякала тебе?"
	},
	{ # 57
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_neutral", "right": "maria/maria_smile",
		"speaker": "", "type": "narrator",
		"text": "Перед Дарією постала невисока постать темноволосої дівчини, що тримала руку на вимикачі поруч з дверима. Вона щиро усміхнулася, ймовірно, вважаючи жарт дотепним."
	},
	{ # 58
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_neutral", "right": "maria/maria_smile",
		"speaker": "Дарія", "type": "thought",
		"text": "Гадаю, це одна з моїх сусідок. Не думаю, що комусь захотілося налякати невідому ще нікому студентку. Чи ні?.. Все ж, це не змінює її вчинку. Що робити?"
	},
	{ # 59 — CHOICE 3
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_neutral", "right": "maria/maria_smile",
		"speaker": "", "type": "narrator",
		"text": "",
		"choices": [
			{"text": "Усміхнутись та підтримати жарт", "target": 60, "effects": {"maria": 1}},
			{"text": "Сказати, що жарт виявився недоречним", "target": 64, "effects": {"maria": -1}}
		]
	},

	# --- Choice 3, Branch A: Smile (ID 60-63) ---
	{ # 60
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_smile", "right": "maria/maria_smile",
		"speaker": "", "type": "narrator",
		"text": "Дарія видихнула, вона помітно розслабилася, а маску страху замінила іронічна усмішка."
	},
	{ # 61
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_smile", "right": "maria/maria_funny",
		"speaker": "Дарія", "type": "dialogue",
		"text": "Ти так налякала мене. Здавалося, от-от серце вистрибне з грудей!"
	},
	{ # 62
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_smile", "right": "maria/maria_funny",
		"speaker": "", "type": "narrator",
		"text": "Почувши це, на обличчі дівчини почала красуватись задоволеність власним витвором. Вона втамувала свою спрагу до здійснення фантазії. Напевно, перед нею стоїть ще та любителька пригод.",
		"target": 68
	},
	{ # 63 — spacer
		"bg": "06b_dorm_room_92_light",
		"left": "", "right": "",
		"speaker": "", "type": "narrator",
		"text": "",
		"target": 68
	},

	# --- Choice 3, Branch B: Say inappropriate (ID 64-67) ---
	{ # 64
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_anxious", "right": "maria/maria_smile",
		"speaker": "Дарія", "type": "dialogue",
		"text": "Насправді я увесь вечір у напрузі, тож це було дуже неочікувано. Дібравшись до кімнати, я мріяла нарешті про спокій після дороги."
	},
	{ # 65
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_anxious", "right": "maria/maria_smile",
		"speaker": "", "type": "narrator",
		"text": "Постава Дарії видавала скутість, тіло напряглось ще більше, очі боязко гляділи кудись униз."
	},
	{ # 66
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_anxious", "right": "maria/maria_smile",
		"speaker": "Марія", "type": "dialogue",
		"text": "Вибач, не думала, що це так сильно засмутить тебе."
	},
	{ # 67
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_neutral", "right": "maria/maria_smile",
		"speaker": "", "type": "narrator",
		"text": "Проте інтонація дівчини говорила про те, що це зовсім не те, чого вона очікувала. Між ними залишилася кількахвилинна незручна пауза.",
		"target": 68
	},

	# ===================================================================
	#  SCENE 7: ROOM — MEETING MARIA & ANNA  (ID 68-97)
	#  bg: 06b_dorm_room_92_light
	# ===================================================================
	{ # 68
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_neutral", "right": "maria/maria_smile",
		"speaker": "Марія", "type": "dialogue",
		"text": "Мене звати Марія. Я, як ти вже зрозуміла, твоя сусідка."
	},
	{ # 69
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_smile", "right": "maria/maria_smile",
		"speaker": "Дарія", "type": "dialogue",
		"text": "Приємно познайомитися, я Дарія."
	},
	{ # 70
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_neutral", "right": "maria/maria_smile",
		"speaker": "Марія", "type": "dialogue",
		"text": "Втомилась? І, напевно, страшенно хвилюєшся перед початком навчального року."
	},
	{ # 71
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_neutral", "right": "maria/maria_smile",
		"speaker": "Дарія", "type": "dialogue",
		"text": "Так, є такий момент.."
	},
	{ # 72
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_neutral", "right": "maria/maria_smile",
		"speaker": "Марія", "type": "dialogue",
		"text": "Тільки не хвилюйся за життя в гуртожитку, тут чудово і ми тебе не образимо."
	},
	{ # 73
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_neutral", "right": "maria/maria_funny",
		"speaker": "", "type": "narrator",
		"text": "Пам'ять сама вирішила нагадати ситуацію, що трапилася нещодавно. Ніби прочитавши думки, Марія голосно засміялась і сказала.."
	},
	{ # 74
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_smile", "right": "maria/maria_funny",
		"speaker": "Марія", "type": "dialogue",
		"text": "Налякати не береться до уваги!"
	},
	{ # 75
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_neutral", "right": "maria/maria_smile",
		"speaker": "", "type": "narrator",
		"text": "В двері наполегливо постукали."
	},
	{ # 76
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_neutral", "right": "maria/maria_funny",
		"speaker": "Марія", "type": "dialogue",
		"text": "Вона знову забула ключі."
	},
	{ # 77
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_neutral", "right": "maria/maria_funny",
		"speaker": "", "type": "narrator",
		"text": "Закотивши очі і зробивши незадоволено-саркастичну гримасу, Марія посунула відчиняти."
	},
	{ # 78
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_neutral", "right": "maria/maria_funny",
		"speaker": "Марія", "type": "dialogue",
		"text": "Знаєш, якщо тобі не допоміг навіть величезний брелок, то все ж ідея з ключами на мотузці як прикраса на шию, здається не такою поганою."
	},
	{ # 79
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_neutral", "right": "anna/anna_neutral",
		"speaker": "", "type": "narrator",
		"text": "Хтось по той бік незадоволено плямкнув губами. У кімнату ввійшла висока, струнка та неймовірно красива дівчина. Її русяве волосся було зібране в незграбний пучок."
	},
	{ # 80
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_neutral", "right": "anna/anna_neutral",
		"speaker": "Анна", "type": "dialogue",
		"text": "О, ти вже тут. Ну, привіт."
	},
	{ # 81
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_smile", "right": "anna/anna_neutral",
		"speaker": "", "type": "narrator",
		"text": "Дарія постаралась якомога миліше посміхатися, що тренувала кілька днів підряд дома, адже доброзичливість здавалась їй запорукою успіху."
	},
	{ # 82
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_smile", "right": "anna/anna_neutral",
		"speaker": "Анна", "type": "dialogue",
		"text": "Я Анна."
	},
	{ # 83
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_smile", "right": "anna/anna_neutral",
		"speaker": "", "type": "narrator",
		"text": "Анна впевнено протягнула худорляву руку, яку у відповідь стиснула новенька сусідка."
	},
	{ # 84
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_neutral", "right": "anna/anna_neutral",
		"speaker": "Анна", "type": "dialogue",
		"text": "Вибач, напевно, було б правильно поговорити для початку, проте я надто втомлена після вирішення питань з роботою. Четвертий курс вже ось-ось розпочнеться.."
	},
	{ # 85
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_neutral", "right": "anna/anna_neutral",
		"speaker": "", "type": "narrator",
		"text": "Дарія була здивована, вважаючи сусідку молодшою, але мати знайому старшокласницю дуже навіть круто."
	},
	{ # 86
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_neutral", "right": "anna/anna_neutral",
		"speaker": "Дарія", "type": "thought",
		"text": "Четвертий курс надзвичайно складний, особливо морально. Багато справ потребують саме твоєї уваги.. А ти зрештою може і не впевнений чого дійсно хочеш."
	},
	{ # 87
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_smile", "right": "anna/anna_neutral",
		"speaker": "Дарія", "type": "dialogue",
		"text": "Не переймайся, все гаразд. Я розумію, що насправді ми обоє сьогодні потребуємо відпочинку. Якось іншим разом обов'язково!"
	},
	{ # 88
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_smile", "right": "anna/anna_neutral",
		"speaker": "", "type": "system",
		"text": "Анна рада побачити розуміння з Вашого боку.",
		"effects": {"anna": 1}
	},
	{ # 89
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_smile", "right": "anna/anna_irony",
		"speaker": "Анна", "type": "dialogue",
		"text": "Так, звісно. А сьогодні тобі все покаже і розкаже Пані Непосидючість."
	},
	{ # 90
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_smile", "right": "anna/anna_irony",
		"speaker": "", "type": "narrator",
		"text": "Дарія мимоволі посміхнулась такому цікавому прізвиську."
	},
	{ # 91
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_smile", "right": "maria/maria_funny",
		"speaker": "Дарія", "type": "dialogue",
		"text": "Прізвисько мають усі в кімнаті?"
	},
	{ # 92
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_smile", "right": "maria/maria_funny",
		"speaker": "Марія", "type": "dialogue",
		"text": "А що? Боїшся, що станеш Пані Дуже Гучний Крик?"
	},
	{ # 93
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_neutral", "right": "anna/anna_neutral",
		"speaker": "", "type": "narrator",
		"text": "Анна незадоволено глянула на Марію. Вона зрозуміла, що сталося, знаючи характер Марії, навіть не бувши свідком події."
	},
	{ # 94
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_neutral", "right": "anna/anna_irony",
		"speaker": "Анна", "type": "dialogue",
		"text": "Ти її таки налякала? Не змінюєшся зовсім.. Втім, Даріє, якщо цікаво, то ні, не у всіх. Марія у нас особлива."
	},
	{ # 95
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_neutral", "right": "maria/maria_funny",
		"speaker": "Марія", "type": "dialogue",
		"text": "Так, але можемо тобі придумати теж. Як щодо Пані Нудило, наприклад?"
	},
	{ # 96
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_neutral", "right": "anna/anna_neutral",
		"speaker": "", "type": "narrator",
		"text": "Анна зморено зітхнула."
	},
	{ # 97
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_neutral", "right": "anna/anna_irony",
		"speaker": "Анна", "type": "dialogue",
		"text": "Чарівно."
	},
	{ # 98
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_smile", "right": "",
		"speaker": "", "type": "narrator",
		"text": "Сусідки обмінялись жестом, висинувши язики і щосили зажмуривши очі. Незважаючи на їхні словесні перепалки, між ними відчувалась не ворожнеча, а доволі специфічна та все ж дружба."
	},

	# ===================================================================
	#  SCENE 8: EVENING — PREPARING & REFLECTIONS  (ID 99-119)
	#  bg: 06b_dorm_room_92_light
	# ===================================================================
	{ # 99
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_neutral", "right": "maria/maria_smile",
		"speaker": "Марія", "type": "dialogue",
		"text": "Гайда, Даріє. Тобі ще треба підготуватись до завтрашнього дня і як слід відпочити."
	},
	{ # 100
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_neutral", "right": "maria/maria_smile",
		"speaker": "", "type": "narrator",
		"text": "Дарія попленталася за Марією, очікуючи надзвичайно важливих інструкцій з виживання у цих саванах студентства. Виявилось, що все не так важко."
	},
	{ # 101
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_smile", "right": "",
		"speaker": "Дарія", "type": "thought",
		"text": "Окей, я таки добряче себе накрутила."
	},
	{ # 102
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_neutral", "right": "",
		"speaker": "", "type": "narrator",
		"text": "Змиритись поки що було важко тільки з розміром маленьких кімнат. У неї самої була невеличка кімната вдома, розташована на горищі. Вона неймовірно сильно любила її, а особливо крихітне вікно у даху, крізь яке в теплу пору року можна було завжди спостерігати за зорями."
	},
	{ # 103
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_smile", "right": "",
		"speaker": "Дарія", "type": "thought",
		"text": "Per astra ad astra. Книги залишаються і завжди будуть зі мною, я прийшла, щоб знайти свою зірку в житті."
	},
	{ # 104
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_neutral", "right": "",
		"speaker": "", "type": "narrator",
		"text": "Дві години промайнули майже непомітно. Марія встигла показати та розказати найважливіше, іншу частину часу Дарія розкладала речі. Про себе відмітила — тривога майже зникла."
	},
	{ # 105
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_neutral", "right": "",
		"speaker": "", "type": "narrator",
		"text": "У коридорі чулись дзвінкі переливчасті веселі голоси."
	},
	{ # 106
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_neutral", "right": "",
		"speaker": "Дарія", "type": "thought",
		"text": "Вони не вперше тут. Вони повернулись до друзів, до звичного ритму життя. І в мене таке буде, обов'язково.."
	},
	{ # 107
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_neutral", "right": "",
		"speaker": "", "type": "narrator",
		"text": "Дарія приділяла пухнастим мріям багато часу. Дівчина найбільше мріяла про ту саму подругу, якої не було поруч всі шкільні роки. Вона була зобов'язана з'явитися зараз."
	},
	{ # 108
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_smile", "right": "",
		"speaker": "Дарія", "type": "thought",
		"text": "Дорослішати разом, хіба це ж не прекрасно?"
	},
	{ # 109
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_neutral", "right": "anna/anna_supportive",
		"speaker": "", "type": "narrator",
		"text": "Анна майже одразу почала готуватися до сну. Та все ж перед сном, четвертокурсниця відкликнула її."
	},
	{ # 110
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_neutral", "right": "anna/anna_supportive",
		"speaker": "Анна", "type": "dialogue",
		"text": "Хей, хвилюєшся?"
	},
	{ # 111
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_anxious", "right": "anna/anna_supportive",
		"speaker": "Дарія", "type": "dialogue",
		"text": "Так, трохи."
	},
	{ # 112
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_neutral", "right": "anna/anna_supportive",
		"speaker": "Анна", "type": "dialogue",
		"text": "Знаю, що це прозвучить банально та повір, все пройде найкращим чином."
	},
	{ # 113
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_smile", "right": "anna/anna_supportive",
		"speaker": "Дарія", "type": "dialogue",
		"text": "Дякую, в глибині душі я насправді це розумію та серце, здається, таки не хоче заспокоїтись."
	},
	{ # 114
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_neutral", "right": "anna/anna_supportive",
		"speaker": "Анна", "type": "dialogue",
		"text": "Я розумію твою тривогу. Це нормально. І в мене таке було. Направду, я сумую за тим часом, коли сама була першокурсницею."
	},
	{ # 115
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_neutral", "right": "anna/anna_neutral",
		"speaker": "", "type": "narrator",
		"text": "Її накрила пелена ностальгічного смутку."
	},
	{ # 116
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_anxious", "right": "",
		"speaker": "Дарія", "type": "thought",
		"text": "Можливо, колись. А зараз відчуваю себе так, ніби мене викинули у величезне бурхливе незнайоме мені море, сказавши перед цим навчитись плавати."
	},
	{ # 117
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_neutral", "right": "anna/anna_supportive",
		"speaker": "Анна", "type": "dialogue",
		"text": "Страх — це нормально. Проте постарайся сфокусуватися на хорошому. Починається нова сторінка твого життя. Якщо буде потрібно, ти завжди можеш звернутися до мене."
	},
	{ # 118
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_smile", "right": "anna/anna_supportive",
		"speaker": "", "type": "narrator",
		"text": "Дарію розчулили ці слова. Ось, яка чудесна мить! Вона вперше заручилася чиєюсь підтримкою. Тепер таки не одна!"
	},
	{ # 119
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_neutral", "right": "",
		"speaker": "", "type": "narrator",
		"text": "Ніч пройшла безсонно. Не можна сказати, що юначці завадив саме страх."
	},

	# ===================================================================
	#  SCENE 9: MORNING  (ID 120-133)
	#  bg: 06b_dorm_room_92_light
	# ===================================================================
	{ # 120
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_neutral", "right": "maria/maria_smile",
		"speaker": "Марія", "type": "dialogue",
		"text": "Доброго раночку!"
	},
	{ # 121
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_neutral", "right": "maria/maria_smile",
		"speaker": "", "type": "narrator",
		"text": "Її бадьоре обличчя сяяло від кількості щойно використаних кремів. Кімнату наповнив аромат пряної кави, що вже стояла на столі."
	},
	{ # 122
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_neutral", "right": "maria/maria_smile",
		"speaker": "Дарія", "type": "dialogue",
		"text": "Доброго."
	},
	{ # 123
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_neutral", "right": "maria/maria_smile",
		"speaker": "", "type": "narrator",
		"text": "Сонно потягуючись, Дарія встала з ліжка. Як тільки дівчина повернулась з ванни, Марія вирішила терміново розпитати про самопочуття новенької сусідки."
	},
	{ # 124
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_neutral", "right": "maria/maria_smile",
		"speaker": "Марія", "type": "dialogue",
		"text": "Ти виспалась? Як почуваєшся?"
	},
	{ # 125
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_neutral", "right": "maria/maria_smile",
		"speaker": "Дарія", "type": "dialogue",
		"text": "Чомусь не дуже. Напевно, треба звикнути до нового місця."
	},
	{ # 126
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_neutral", "right": "maria/maria_funny",
		"speaker": "Марія", "type": "dialogue",
		"text": "О, до цих пружинних ліжок зокрема!"
	},
	{ # 127
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_smile", "right": "maria/maria_funny",
		"speaker": "Марія", "type": "dialogue",
		"text": "А може ти не виспалась через Анну? Вона вміє давати сплячий стендап-концерт!"
	},
	{ # 128
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_smile", "right": "anna/anna_irony",
		"speaker": "Анна", "type": "dialogue",
		"text": "Ну, звісно. Сьогодні я була тиха. Дала можливість тобі побути зіркою спочатку."
	},
	{ # 129
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_neutral", "right": "anna/anna_neutral",
		"speaker": "Анна", "type": "dialogue",
		"text": "Ти рідко під час семестру так квапишся до універу."
	},
	{ # 130
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_neutral", "right": "maria/maria_smile",
		"speaker": "Марія", "type": "dialogue",
		"text": "Сьогодні особливий випадок. Вперше за два місяці побачусь з подругами. Стільки всього треба обговорити!"
	},
	{ # 131
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_neutral", "right": "",
		"speaker": "", "type": "narrator",
		"text": "Обидві обмінялись тихим смішком з їхнім авторським жестом. Дарія тим часом зібралась, встигнувши прочитати повідомлення у новоствореному чаті."
	},
	{ # 132
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_neutral", "right": "",
		"speaker": "Дарія", "type": "thought",
		"text": "Вже зовсім скоро.."
	},
	{ # 133
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_smile", "right": "anna/anna_supportive",
		"speaker": "", "type": "narrator",
		"text": "Марія покинула кімнату першою. Анна ще раз щиро побажала успіхів Дарії, і та рушила університетським подвір'ям на зустріч своєму майбутньому."
	},

	# ===================================================================
	#  SCENE 10: UNIVERSITY YARD  (ID 134-150)
	#  bg: 08_university_yard_morning
	# ===================================================================
	{ # 134
		"bg": "08_university_yard_morning",
		"left": "daria_main/daria_neutral", "right": "",
		"speaker": "", "type": "narrator",
		"text": "Все подвір'я гомоніло. Першокурсниця, напевно, ще ніколи не бачила стільки юних дійсно щасливих лиць.",
		"transition": "crossfade"
	},
	{ # 135
		"bg": "08_university_yard_morning",
		"left": "daria_main/daria_smile", "right": "",
		"speaker": "Дарія", "type": "thought",
		"text": "«Від сесії до сесії живуть студенти весело» — правда."
	},
	{ # 136
		"bg": "08_university_yard_morning",
		"left": "daria_main/daria_smile", "right": "",
		"speaker": "", "type": "narrator",
		"text": "На душі стало радісно. Цей новий гул викликав спектр найкращих емоцій і серце видало заспокійливе «маємо велику світлу надію!»."
	},
	{ # 137
		"bg": "08_university_yard_morning",
		"left": "daria_main/daria_anxious", "right": "",
		"speaker": "", "type": "narrator",
		"text": "Дарія наближалась, бачачи перед гуманітарним корпусом кілька груп. Як знайти потрібних невідомих тобі ще людей?"
	},
	{ # 138
		"bg": "08_university_yard_morning",
		"left": "daria_main/daria_neutral", "right": "",
		"speaker": "", "type": "narrator",
		"text": "Її погляд вчасно зупинився на одній з груп, де чиєсь лице здалося знайомим.."
	},
	{ # 139
		"bg": "08_university_yard_morning",
		"left": "daria_main/daria_neutral", "right": "",
		"speaker": "Марта", "type": "dialogue",
		"text": "Ти, певно, Дарія?"
	},
	{ # 140
		"bg": "08_university_yard_morning",
		"left": "daria_main/daria_smile", "right": "",
		"speaker": "", "type": "narrator",
		"text": "Не могло бути щасливішого моменту зараз, ніж почути це. З відчутним полегшенням вона рушила до цієї групи."
	},
	{ # 141
		"bg": "08_university_yard_morning",
		"left": "daria_main/daria_smile", "right": "",
		"speaker": "Марта", "type": "dialogue",
		"text": "Привіт, мене звати Марта. Я староста групи."
	},
	{ # 142
		"bg": "08_university_yard_morning",
		"left": "daria_main/daria_smile", "right": "",
		"speaker": "", "type": "narrator",
		"text": "Марта протягнула руку для привітання. Дівчина здавалась Дарії милою, привітною. Слідом за Мартою привітались і інші."
	},
	{ # 143
		"bg": "08_university_yard_morning",
		"left": "daria_main/daria_neutral", "right": "",
		"speaker": "Марта", "type": "dialogue",
		"text": "Чого ви очікуєте від першого дня в університеті?"
	},
	{ # 144
		"bg": "08_university_yard_morning",
		"left": "daria_main/daria_neutral", "right": "",
		"speaker": "", "type": "narrator",
		"text": "Всі поринули у роздуми. Насмілилась відповісти одногрупниця, що стояла справа. Дарії надзвичайно сподобались її розкішні червоняві кучерики."
	},
	{ # 145
		"bg": "08_university_yard_morning",
		"left": "daria_main/daria_neutral", "right": "",
		"speaker": "Оксана", "type": "dialogue",
		"text": "Не знаю як ви, а я сподіваюсь, хоча б не загубитися першого ж дня. Я серйозно. Якщо не побачите мене поруч, кричіть «Сир!», бо моя цікавість в сумісності з поганою орієнтацією в просторі колись таки мені зашкодить."
	},
	{ # 146
		"bg": "08_university_yard_morning",
		"left": "daria_main/daria_smile", "right": "",
		"speaker": "Дарія", "type": "dialogue",
		"text": "Чому саме сир?"
	},
	{ # 147
		"bg": "08_university_yard_morning",
		"left": "daria_main/daria_smile", "right": "",
		"speaker": "Оксана", "type": "dialogue",
		"text": "Просто люблю і ні за що в світі не пробачу вас, якщо з'їсте його без мене."
	},
	{ # 148
		"bg": "08_university_yard_morning",
		"left": "daria_main/daria_smile", "right": "",
		"speaker": "", "type": "narrator",
		"text": "Оксана сподобалась Дарії своєю енергетикою: доброю і ніби вільною від усіх людських турбот."
	},
	{ # 149
		"bg": "08_university_yard_morning",
		"left": "daria_main/daria_neutral", "right": "",
		"speaker": "Марта", "type": "dialogue",
		"text": "Не всі є, але вже зовсім скоро розпочнуться пари. Можливо, пошукаємо аудиторію?"
	},
	{ # 150
		"bg": "08_university_yard_morning",
		"left": "daria_main/daria_smile", "right": "",
		"speaker": "", "type": "narrator",
		"text": "Група погодилась. До аудиторії, на диво, дібрались без пригод. Дехто встиг пожартувати про ідею створення карти корпусу."
	},

	# ===================================================================
	#  SCENE 11: CLASSROOM — MELANIA + CHOICE 4  (ID 151-168)
	#  bg: 09_classroom_cozy_day
	# ===================================================================
	{ # 151
		"bg": "09_classroom_cozy_day",
		"left": "daria_main/daria_smile", "right": "",
		"speaker": "", "type": "narrator",
		"text": "Студенти зайняли свої місця у аудиторії. Вона виявилась дуже просторою, світлою і неймовірно затишною. Одразу захотілось з головою поринути у навчання.",
		"transition": "crossfade"
	},
	{ # 152
		"bg": "09_classroom_cozy_day",
		"left": "daria_main/daria_neutral", "right": "",
		"speaker": "", "type": "narrator",
		"text": "Годинник показував пів на дев'яту. Всі мовчки приготувались до священного моменту: ось-ось і сюди зайде архіваріус мудрості, магістр заліків, покровитель конспектів! Ну, або просто викладач."
	},
	{ # 153
		"bg": "09_classroom_cozy_day",
		"left": "daria_main/daria_neutral", "right": "melania/melania_serious",
		"speaker": "", "type": "narrator",
		"text": "Двері відчинилися. Не було чутно ані звуку. У приміщення ввійшла юначка. Почулось тихе «фух» з задніх рядів."
	},
	{ # 154
		"bg": "09_classroom_cozy_day",
		"left": "daria_main/daria_neutral", "right": "melania/melania_serious",
		"speaker": "Меланія", "type": "dialogue",
		"text": "Вибачте, це ж українські філологи перший курс?"
	},
	{ # 155
		"bg": "09_classroom_cozy_day",
		"left": "daria_main/daria_neutral", "right": "melania/melania_serious",
		"speaker": "", "type": "narrator",
		"text": "Дівчина переводила подих, очима шукаючи вільне місце. Біля Дарії якраз знаходилось одне з них."
	},
	{ # 156
		"bg": "09_classroom_cozy_day",
		"left": "daria_main/daria_neutral", "right": "melania/melania_serious",
		"speaker": "Дарія", "type": "thought",
		"text": "Я можу допомогти їй. Вона виглядає втомленою. Ймовірно, дуже поспішала."
	},
	{ # 157 — CHOICE 4
		"bg": "09_classroom_cozy_day",
		"left": "daria_main/daria_neutral", "right": "melania/melania_serious",
		"speaker": "", "type": "narrator",
		"text": "",
		"choices": [
			{"text": "Підняти руку, щоб привернути увагу", "target": 158, "effects": {"melania": 1, "reputation": 1}},
			{"text": "Мовчки спостерігати", "target": 162}
		]
	},

	# --- Choice 4, Branch A: Raise hand (ID 158-161) ---
	{ # 158
		"bg": "09_classroom_cozy_day",
		"left": "daria_main/daria_neutral", "right": "melania/melania_serious",
		"speaker": "", "type": "narrator",
		"text": "Дарія підняла ліву руку, тим самим привертаючи увагу дівчини, що досі стовбичилась біля дверей. Вона помітила майже одразу. Задоволено кивнула головою та рушила до місця."
	},
	{ # 159
		"bg": "09_classroom_cozy_day",
		"left": "daria_main/daria_smile", "right": "melania/melania_serious",
		"speaker": "Меланія", "type": "dialogue",
		"text": "Дякую."
	},
	{ # 160
		"bg": "09_classroom_cozy_day",
		"left": "daria_main/daria_smile", "right": "melania/melania_serious",
		"speaker": "", "type": "narrator",
		"text": "Її очі вдячливо глянули на сусідку по парті."
	},
	{ # 161
		"bg": "09_classroom_cozy_day",
		"left": "daria_main/daria_smile", "right": "melania/melania_serious",
		"speaker": "", "type": "system",
		"text": "Вибір вплинув на стосунки з одногрупницею в майбутньому.",
		"target": 165
	},

	# --- Choice 4, Branch B: Observe silently (ID 162-164) ---
	{ # 162
		"bg": "09_classroom_cozy_day",
		"left": "daria_main/daria_neutral", "right": "melania/melania_serious",
		"speaker": "", "type": "narrator",
		"text": "Дарія вирішила не втручатися. В багатьох ситуаціях їй було комфортніше перебувати у позиції спостерігача."
	},
	{ # 163
		"bg": "09_classroom_cozy_day",
		"left": "daria_main/daria_neutral", "right": "melania/melania_serious",
		"speaker": "", "type": "narrator",
		"text": "Дівчина через кілька секунд сама знайшла поглядом та присіла поруч."
	},
	{ # 164
		"bg": "09_classroom_cozy_day",
		"left": "daria_main/daria_neutral", "right": "melania/melania_serious",
		"speaker": "", "type": "system",
		"text": "Вибір вплинув на стосунки з одногрупницею в майбутньому.",
		"target": 165
	},

	# --- Melania introduction + Lydia (ID 165-185) ---
	{ # 165
		"bg": "09_classroom_cozy_day",
		"left": "daria_main/daria_neutral", "right": "melania/melania_serious",
		"speaker": "Меланія", "type": "dialogue",
		"text": "Мене звати Меланія."
	},
	{ # 166
		"bg": "09_classroom_cozy_day",
		"left": "daria_main/daria_neutral", "right": "melania/melania_serious",
		"speaker": "", "type": "narrator",
		"text": "Меланія дружно посміхнулась. Хоч її погляд говорив про твердість характеру, обличчя з усіх сил старалось бути милим."
	},
	{ # 167
		"bg": "09_classroom_cozy_day",
		"left": "daria_main/daria_smile", "right": "melania/melania_serious",
		"speaker": "Дарія", "type": "dialogue",
		"text": "Я Дарія. Приємно познайомитись. У тебе таке красиве ім'я."
	},
	{ # 168
		"bg": "09_classroom_cozy_day",
		"left": "daria_main/daria_smile", "right": "melania/melania_serious",
		"speaker": "Меланія", "type": "dialogue",
		"text": "Дякую, у тебе теж."
	},
	{ # 169
		"bg": "09_classroom_cozy_day",
		"left": "daria_main/daria_neutral", "right": "Lydia_Ivanovna/LydiaIvanovna_Smile",
		"speaker": "", "type": "narrator",
		"text": "Здавалось, Меланія хотіла сказати ще щось та її перервали. В аудиторію зайшла довгоочікувана викладачка."
	},
	{ # 170
		"bg": "09_classroom_cozy_day",
		"left": "daria_main/daria_neutral", "right": "Lydia_Ivanovna/LydiaIvanovna_Smile",
		"speaker": "", "type": "narrator",
		"text": "Проте неймовірно пощастило! Перша в житті пара розпочинається не зі строгості."
	},
	{ # 171
		"bg": "09_classroom_cozy_day",
		"left": "daria_main/daria_smile", "right": "Lydia_Ivanovna/LydiaIvanovna_Smile",
		"speaker": "Лідія Іванівна", "type": "dialogue",
		"text": "Добрий день, мене звати Лідія Іванівна і я ваша викладачка з курсу «Дитячої літератури». До речі, не підкажете в котрій годині з'явиться кат? Судячи з ваших лиць, тут от-от відбудеться масова страта."
	},
	{ # 172
		"bg": "09_classroom_cozy_day",
		"left": "daria_main/daria_smile", "right": "Lydia_Ivanovna/LydiaIvanovna_Smile",
		"speaker": "", "type": "narrator",
		"text": "Аудиторію заполонив сміх. Студенти переглядались, намагаючись зрозуміти чи дійсно це виглядало так жахливо?"
	},
	{ # 173
		"bg": "09_classroom_cozy_day",
		"left": "daria_main/daria_neutral", "right": "Lydia_Ivanovna/LydiaIvanovna_Smile",
		"speaker": "Лідія Іванівна", "type": "dialogue",
		"text": "Перш за все хочу привітати вас всіх зі вступом до нашого університету. Ви обрали складну, але дуже важливу професію, особливо в наш час. Хто як не ми дбатиме про українську культуру?"
	},
	{ # 174
		"bg": "09_classroom_cozy_day",
		"left": "daria_main/daria_smile", "right": "Lydia_Ivanovna/LydiaIvanovna_Smile",
		"speaker": "", "type": "narrator",
		"text": "Ці слова гріли душу. З'являлась якась щира гордість за пройдені випробування. Саме зараз були лише вони і надія. Лише вони і ціль."
	},
	{ # 175
		"bg": "09_classroom_cozy_day",
		"left": "daria_main/daria_neutral", "right": "Lydia_Ivanovna/LydiaIvanovna_Smile",
		"speaker": "Лідія Іванівна", "type": "dialogue",
		"text": "Ще зовсім недавно ви й самі читали дитячу літературу, а тепер стикнетеся з її аналізом. Дитяча література — це фундамент майбутнього свідомого читача всієї літератури."
	},
	{ # 176
		"bg": "09_classroom_cozy_day",
		"left": "daria_main/daria_neutral", "right": "Lydia_Ivanovna/LydiaIvanovna_Smile",
		"speaker": "Лідія Іванівна", "type": "dialogue",
		"text": "Маленькому читачеві не так просто догодити. Ну, можете розкривати свої неймовірно красиві зошити та записати тему лекції."
	},

	# ===================================================================
	#  SCENE 12: FLASHBACK — ATTIC  (ID 177-179)
	#  bg: 06b_dorm_room_92_light (fallback, no attic bg)
	# ===================================================================
	{ # 177
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_neutral", "right": "",
		"speaker": "", "type": "narrator",
		"text": "Її віднесло вітром спогадів у дитинство. Дарія сидить у своїй кімнаті на горищі. У руках тримає книжку, яку кілька днів тому взяла з бібліотеки.",
		"transition": "crossfade"
	},
	{ # 178
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_neutral", "right": "",
		"speaker": "", "type": "narrator",
		"text": "Вона без обкладинки, сторінки пожовклі. Дівчинка знає, що до книг треба ставитися з шанобливістю та все ж їй подобається запах старих книг і думка про те, скільки людей тримало їх в своїх руках."
	},
	{ # 179
		"bg": "06b_dorm_room_92_light",
		"left": "daria_main/daria_anxious", "right": "",
		"speaker": "", "type": "narrator",
		"text": "На сторінку впав яскравий сонячний промінь, що пробивається крізь маленьке віконце. А згодом за ним на неї падає дитяча сльоза. Дарія закриває книжку. На столі самотньо залишився «Федько Халамидник».."
	},

	# ===================================================================
	#  SCENE 13: BACK TO CLASSROOM — POST-LECTURE  (ID 180-188)
	#  bg: 09_classroom_cozy_day
	# ===================================================================
	{ # 180
		"bg": "09_classroom_cozy_day",
		"left": "daria_main/daria_neutral", "right": "melania/melania_serious",
		"speaker": "", "type": "narrator",
		"text": "Зі спогадів дівчину вирвав лагідний шепіт Меланії, що схилилась до її вуха.",
		"transition": "crossfade"
	},
	{ # 181
		"bg": "09_classroom_cozy_day",
		"left": "daria_main/daria_neutral", "right": "melania/melania_serious",
		"speaker": "Меланія", "type": "dialogue",
		"text": "Не знаю як ти, а я не хочу «проживати» Халамидника знову."
	},
	{ # 182
		"bg": "09_classroom_cozy_day",
		"left": "daria_main/daria_smile", "right": "melania/melania_serious",
		"speaker": "Дарія", "type": "dialogue",
		"text": "О так, здається, це той самий випадок про який говорила викладачка: торкнеться і дорослого."
	},
	{ # 183
		"bg": "09_classroom_cozy_day",
		"left": "daria_main/daria_smile", "right": "melania/melania_serious",
		"speaker": "", "type": "narrator",
		"text": "Дарія зрозуміла, що цей курс точно сподобається. І, здається, з Меланією в Дарії є дещо спільне."
	},
	{ # 184
		"bg": "09_classroom_cozy_day",
		"left": "daria_main/daria_smile", "right": "Lydia_Ivanovna/LydiaIvanovna_Smile",
		"speaker": "Лідія Іванівна", "type": "dialogue",
		"text": "Поспішаю вас засмутити, адже ті, хто плакали над Федьком, ймовірно, ще не раз заплачуть, готуючись до семінарів. Але нічого, головне, щоб не на заліку."
	},
	{ # 185
		"bg": "09_classroom_cozy_day",
		"left": "daria_main/daria_neutral", "right": "",
		"speaker": "", "type": "narrator",
		"text": "Аудиторія знову сміється. Решта пари пройшла досить швидко. Наступною парою була лекція з предмету «Вступ до мовознавства»."
	},
	{ # 186
		"bg": "09_classroom_cozy_day",
		"left": "daria_main/daria_smile", "right": "melania/melania_serious",
		"speaker": "", "type": "narrator",
		"text": "Меланія запитала чи можна сісти поряд з Дарією знову. Дівчина погодилась і обидві зрозуміли, що вклали угоду на цілий семестр."
	},
	{ # 187
		"bg": "09_classroom_cozy_day",
		"left": "daria_main/daria_neutral", "right": "",
		"speaker": "", "type": "narrator",
		"text": "Студенти виходили повільно. В голові досі крутились нові терміни: «фонема», «морфема». Це все здавалось таким важким.."
	},
	{ # 188
		"bg": "09_classroom_cozy_day",
		"left": "daria_main/daria_neutral", "right": "",
		"speaker": "Дарія", "type": "thought",
		"text": "Мова — це система, а ми самі поки що в хаосі."
	},

	# ===================================================================
	#  SCENE 14: RESTAURANT  (ID 189-208)
	#  bg: 11_restaurant_evening
	# ===================================================================
	{ # 189
		"bg": "11_restaurant_evening",
		"left": "daria_main/daria_smile", "right": "",
		"speaker": "", "type": "narrator",
		"text": "Надворі вся група зібралась знову. Ще раніше вирішили відсвяткувати початок навчання у найближчому ресторані.",
		"transition": "crossfade"
	},
	{ # 190
		"bg": "11_restaurant_evening",
		"left": "daria_main/daria_neutral", "right": "",
		"speaker": "Марта", "type": "dialogue",
		"text": "Можливо, хтось знає якийсь заклад поруч?"
	},
	{ # 191
		"bg": "11_restaurant_evening",
		"left": "daria_main/daria_neutral", "right": "",
		"speaker": "Оксана", "type": "dialogue",
		"text": "Гугл карти в допомогу?"
	},
	{ # 192
		"bg": "11_restaurant_evening",
		"left": "daria_main/daria_smile", "right": "melania/melania_serious",
		"speaker": "Меланія", "type": "dialogue",
		"text": "Здається, я бачила дорогою сюди поблизу піцерію. Ніхто не проти піци? Це ж пі-іца."
	},
	{ # 193
		"bg": "11_restaurant_evening",
		"left": "daria_main/daria_smile", "right": "melania/melania_serious",
		"speaker": "", "type": "narrator",
		"text": "Меланія розтягувала остання слово, ніби смакувала його самого. Всі, звичайно ж погодилися."
	},
	{ # 194
		"bg": "11_restaurant_evening",
		"left": "daria_main/daria_neutral", "right": "",
		"speaker": "", "type": "narrator",
		"text": "Коли група зручно розмістилась в закладі та зробила замовлення, настала черга справжніх знайомств."
	},
	{ # 195
		"bg": "11_restaurant_evening",
		"left": "daria_main/daria_neutral", "right": "melania/melania_serious",
		"speaker": "", "type": "narrator",
		"text": "Дарія дізналася, що Меланія не місцева, родом дівчина з Рівного. Наступне запитання: чому саме філологія?"
	},
	{ # 196
		"bg": "11_restaurant_evening",
		"left": "daria_main/daria_smile", "right": "",
		"speaker": "Дарія", "type": "dialogue",
		"text": "Я тут, бо дуже люблю українську літературу. Бо відчуваю зв'язок з предками, спілкуючись рідною мовою. Я маю мету зберегти традиції і примножити здобутки культури."
	},
	{ # 197
		"bg": "11_restaurant_evening",
		"left": "daria_main/daria_neutral", "right": "",
		"speaker": "", "type": "narrator",
		"text": "Після слів Дарії за столом зависла кількасекундна, проте дуже помітна, тиша."
	},
	{ # 198
		"bg": "11_restaurant_evening",
		"left": "daria_main/daria_neutral", "right": "",
		"speaker": "Оксана", "type": "dialogue",
		"text": "Ого, вау.."
	},
	{ # 199
		"bg": "11_restaurant_evening",
		"left": "daria_main/daria_smile", "right": "",
		"speaker": "Марта", "type": "dialogue",
		"text": "Неймовірно гарно сказано. Я впевнена, що в тебе все вийде."
	},
	{ # 200
		"bg": "11_restaurant_evening",
		"left": "daria_main/daria_smile", "right": "",
		"speaker": "", "type": "narrator",
		"text": "Вона не хотіла приголомшити всіх. Та всі зрозуміли. І це було приємно."
	},
	{ # 201
		"bg": "11_restaurant_evening",
		"left": "daria_main/daria_smile", "right": "",
		"speaker": "", "type": "narrator",
		"text": "За цей час встигли принести замовлення. Запах свіжого тіста, розплавленого сиру і базиліку донісся навіть раніше за подачу."
	},
	{ # 202
		"bg": "11_restaurant_evening",
		"left": "daria_main/daria_neutral", "right": "melania/melania_serious",
		"speaker": "", "type": "narrator",
		"text": "Пізніше студенти продовжили незавершену тему. Настала черга Меланії."
	},
	{ # 203
		"bg": "11_restaurant_evening",
		"left": "daria_main/daria_neutral", "right": "melania/melania_serious",
		"speaker": "Меланія", "type": "dialogue",
		"text": "Я завжди любила літературу. Мистецтво слова для мене це щось особливе, рідне моєму серцю і душі. Вибір філології дався мені непросто та я впевнена, що не пошкодую."
	},
	{ # 204
		"bg": "11_restaurant_evening",
		"left": "daria_main/daria_neutral", "right": "melania/melania_serious",
		"speaker": "", "type": "narrator",
		"text": "Останні слова були сказані трохи голосніше. В них відчувалась сталева рішучість."
	},
	{ # 205
		"bg": "11_restaurant_evening",
		"left": "daria_main/daria_neutral", "right": "melania/melania_serious",
		"speaker": "Дарія", "type": "thought",
		"text": "Здається, вона говорить таке не вперше. І що означає «вибір дався важко?». Можливо, Меланія сумнівалася між певними спеціальностями."
	},
	{ # 206
		"bg": "11_restaurant_evening",
		"left": "", "right": "",
		"speaker": "", "type": "system",
		"text": "Згодом Ви зможете дізнатися більше про минуле Меланії."
	},
	{ # 207
		"bg": "11_restaurant_evening",
		"left": "daria_main/daria_neutral", "right": "melania/melania_serious",
		"speaker": "", "type": "narrator",
		"text": "Дарія не знала чому, але її зачепила така яскрава особистість. Сусідка по парті мала вольову енергетику. Їй подобались схожі люди, адже вони мали те, чого бракувало їй самій."
	},
	{ # 208
		"bg": "11_restaurant_evening",
		"left": "daria_main/daria_smile", "right": "",
		"speaker": "", "type": "narrator",
		"text": "Залишок святкування пройшов за теплими розмовами. Стало по-домашньому затишно. Вони були ще незнайомі та тепер знали одне про одного бодай щось."
	},

	# ===================================================================
	#  SCENE 15: WALK HOME — FINALE  (ID 209-218)
	#  bg: 03_dorm_exterior_evening
	# ===================================================================
	{ # 209
		"bg": "03_dorm_exterior_evening",
		"left": "daria_main/daria_smile", "right": "melania/melania_serious",
		"speaker": "", "type": "narrator",
		"text": "Виявилось, що Меланії та Дарії потрібно прямувати в одному і тому ж напрямку, тому дівчата рушили додому разом.",
		"transition": "crossfade"
	},
	{ # 210
		"bg": "03_dorm_exterior_evening",
		"left": "daria_main/daria_neutral", "right": "melania/melania_serious",
		"speaker": "", "type": "narrator",
		"text": "Вони йшли не поспішаючи, смакуючи момент, ніби розтягували мить, коли доведеться прощатись. Меланія порушила мовчанку."
	},
	{ # 211
		"bg": "03_dorm_exterior_evening",
		"left": "daria_main/daria_neutral", "right": "melania/melania_serious",
		"speaker": "Меланія", "type": "dialogue",
		"text": "Як тобі наш перший день?"
	},
	{ # 212
		"bg": "03_dorm_exterior_evening",
		"left": "daria_main/daria_smile", "right": "melania/melania_serious",
		"speaker": "Дарія", "type": "dialogue",
		"text": "Я гадала, буде гірше."
	},
	{ # 213
		"bg": "03_dorm_exterior_evening",
		"left": "daria_main/daria_smile", "right": "melania/melania_serious",
		"speaker": "Меланія", "type": "dialogue",
		"text": "І я, мало статись щось страшне."
	},
	{ # 214
		"bg": "03_dorm_exterior_evening",
		"left": "daria_main/daria_smile", "right": "melania/melania_serious",
		"speaker": "", "type": "narrator",
		"text": "Обидві тихо засміялись."
	},
	{ # 215
		"bg": "03_dorm_exterior_evening",
		"left": "daria_main/daria_neutral", "right": "melania/melania_serious",
		"speaker": "Меланія", "type": "dialogue",
		"text": "Знаєш, сказане тобою сьогодні зачепило мене. Не в поганому сенсі. Мова, культура, предки. Це так важливо. І я бачу, що ти це справді відчуваєш."
	},
	{ # 216
		"bg": "03_dorm_exterior_evening",
		"left": "daria_main/daria_smile", "right": "melania/melania_serious",
		"speaker": "", "type": "narrator",
		"text": "Дарія мовчить, бо не знаходить правильних слів. Вона чує в цьому повагу. В полі зору з'явилась химерна будівля гуртожитку. Вони зупинились."
	},
	{ # 217
		"bg": "03_dorm_exterior_evening",
		"left": "daria_main/daria_smile", "right": "melania/melania_serious",
		"speaker": "Дарія", "type": "dialogue",
		"text": "То до завтра?"
	},
	{ # 218
		"bg": "03_dorm_exterior_evening",
		"left": "daria_main/daria_smile", "right": "melania/melania_serious",
		"speaker": "Меланія", "type": "dialogue",
		"text": "Так, до завтра."
	},
	{ # 219
		"bg": "03_dorm_exterior_evening",
		"left": "daria_main/daria_smile", "right": "melania/melania_serious",
		"speaker": "Дарія", "type": "dialogue",
		"text": "Дякую за чудовий день."
	},
	{ # 220
		"bg": "03_dorm_exterior_evening",
		"left": "daria_main/daria_smile", "right": "melania/melania_serious",
		"speaker": "Меланія", "type": "dialogue",
		"text": "І тобі. Сподіваюся, завтрашній буде не менш захопливим."
	},
	{ # 221
		"bg": "03_dorm_exterior_evening",
		"left": "", "right": "",
		"speaker": "", "type": "narrator",
		"text": "Перший день Дарії в університеті добіг кінця. Нові знайомства, нові емоції, нові страхи та надії — все це лише початок великої історії."
	},
	{ # 222
		"bg": "03_dorm_exterior_evening",
		"left": "", "right": "",
		"speaker": "", "type": "system",
		"text": "Епізод 1 завершено. Ваші вибори вплинуть на подальший розвиток подій."
	},
	{ # 223
		"bg": "03_dorm_exterior_evening",
		"left": "", "right": "",
		"speaker": "", "type": "narrator",
		"text": "Далі буде..."
	},
]
