extends RefCounted

const START_ID := "ch1_001"

const CHAPTER_1_DIALOGUES: Array = [
	{
		"id": "ch1_001",
		"chapter": 1,
		"bg": "01_train_evening",
		"speaker": "",
		"type": "narrator",
		"text": "Зовсім скоро розпочнеться Ваша подорож у світі філології. Готові?",
		"transition": "fade"
	},
	{
		"id": "ch1_002",
		"chapter": 1,
		"bg": "01_train_evening",
		"speaker": "",
		"type": "narrator",
		"text": "За вікном потроху згущувалися сутінки. Потяг мчав все швидше, віддаляючи Дарію від рідної домівки. Дівчина обводила поглядом розлогий краєвид, шукаючи відповідь на власні запитання."
	},
	{
		"id": "ch1_003",
		"chapter": 1,
		"bg": "01_train_evening",
		"speaker": "Дарія",
		"type": "dialogue",
		"text": "Вже завтра розпочнеться моя нова сторінка життя. Неймовірно захопливо і.. страшенно хвилююче! Чи буде моє студентське життя таким прекрасним як всі розповідають?",
		"center": "daria_main/daria_smile"
	},
	{
		"id": "ch1_004",
		"chapter": 1,
		"bg": "01_train_evening",
		"speaker": "",
		"type": "narrator",
		"text": "На серці дівчини було неспокійно та поряд з тим в нім жевріла надія. І якесь нове абсолютно невідоме їй відчуття – щемка невідомість."
	},
	{
		"id": "ch1_005",
		"chapter": 1,
		"bg": "01_train_evening",
		"speaker": "Дарія",
		"type": "dialogue",
		"text": "Я обов'язково зроблю його незабутнім.",
		"center": "daria_main/daria_smile"
	},
	{
		"id": "ch1_006",
		"chapter": 1,
		"bg": "02_station_platform_evening",
		"speaker": "",
		"type": "narrator",
		"text": "Дарія несміливо ступила на перон, зливаючись з потоком людей. Зупинилася на мить, вдихаючи аромат теплого вечора в ще чужому місті, яке згодом стане рідним і їй. Вже завтра..",
		"transition": "fade"
	},
	{
		"id": "ch1_007",
		"chapter": 1,
		"bg": "02_station_platform_evening",
		"speaker": "",
		"type": "narrator",
		"text": "Всю дорогу до гуртожитку дівчина панікувала і якомога сильніше вдивлялася у темні обриси будинків. Пропустити зупинку для неї зараз може стати просто катастрофою. Та й хто допоможе? Немає друзів і рідних. Вона знову згадала, що абсолютно самотня у цьому великому незнайомому місті."
	},
	{
		"id": "ch1_008",
		"chapter": 1,
		"bg": "02_station_platform_evening",
		"speaker": "Дарія",
		"type": "thought",
		"text": "Це ненадовго.",
		"center": "daria_main/daria_neutral"
	},
	{
		"id": "ch1_009",
		"chapter": 1,
		"bg": "02_station_platform_evening",
		"speaker": "",
		"type": "narrator",
		"text": "Мимоволі їй пригадався твір Валер’яна Підмогильного, що дуже захопив її в школі."
	},
	{
		"id": "ch1_010",
		"chapter": 1,
		"bg": "02_station_platform_evening",
		"speaker": "Дарія",
		"type": "thought",
		"text": "Підкорю місто як Степан Радченко! Хоча.. напевно, саме як Радченко не хотілося б..",
		"center": "daria_main/daria_neutral"
	},
	{
		"id": "ch1_011",
		"chapter": 1,
		"bg": "02_station_platform_evening",
		"speaker": "",
		"type": "narrator",
		"text": "Дівчина посміхнулася про себе і це дозволило їй трохи розслабитись."
	},
	{
		"id": "ch1_012",
		"chapter": 1,
		"bg": "03_dormitory_exterior_evening",
		"speaker": "",
		"type": "narrator",
		"text": "Та ненадовго. Адже автобус вже зупиняється і ось – її новий дім! Гуртожиток налякав Дарію ще більше. І річ не в тарганах, яких вона ще навіть не встигла побачити. Увесь страх невідомості виріс в ній і постав перед очима образом цієї будівлі: величезної, темної.. Дівчина ніколи не була надто хороброю та вдома це не було проблемою. В дорослому житті доведеться трохи над собою попрацювати. Дарія ще раз глянула на гуртожиток.",
		"transition": "fade"
	},
	{
		"id": "ch1_013",
		"chapter": 1,
		"bg": "03_dormitory_exterior_evening",
		"speaker": "Дарія",
		"type": "thought",
		"text": "Здається, не трохи..",
		"center": "daria_main/daria_neutral"
	},
	{
		"id": "ch1_014",
		"chapter": 1,
		"bg": "03_dormitory_exterior_evening",
		"speaker": "",
		"type": "narrator",
		"text": "Та все ж виходу немає і вона так мріяла бути студенткою. Там всередині її очікують такі самі люди. Немає чого боятись, вона з кимось подружиться. Вона - не одна."
	},
	{
		"id": "ch1_015",
		"chapter": 1,
		"bg": "03_dormitory_exterior_evening",
		"speaker": "",
		"type": "narrator",
		"text": "Зібравшись духом дівчина рушила подвір'ям. Піднімаючись сходами Дарія випадково зачепила своєю величезною сумкою хлопця, що проходив поруч."
	},
	{
		"id": "ch1_016",
		"chapter": 1,
		"bg": "03_dormitory_exterior_evening",
		"speaker": "Дарія",
		"type": "dialogue",
		"text": "Боже, як незручно! Я стаю надто незграбною з таким великим багажем..",
		"center": "daria_main/daria_smile"
	},
	{
		"id": "ch1_017",
		"chapter": 1,
		"bg": "03_dormitory_exterior_evening",
		"speaker": "",
		"type": "narrator",
		"text": "Що зробить Дарія?",
		"choices": [
			{
				"text": "Попросити вибачення",
				"target": "ch1_019",
				"effects": {
					"reputation": 1,
					"silhouette_boy": 1
				}
			},
			{
				"text": "Мовчки пройти повз",
				"target": "ch1_025",
				"effects": {
					"reputation": -1,
					"silhouette_boy": -1
				}
			}
		]
	},
	{
		"id": "ch1_019",
		"chapter": 1,
		"bg": "03_dormitory_exterior_evening",
		"speaker": "Дарія",
		"type": "dialogue",
		"text": "Пробачте, будь ласка. Я випадково..",
		"center": "daria_main/daria_smile"
	},
	{
		"id": "ch1_020",
		"chapter": 1,
		"bg": "03_dormitory_exterior_evening",
		"speaker": "",
		"type": "narrator",
		"text": "На обличчі заграли сором’язливі барви. Та незважаючи на це, вибачення здалось їй обов'язковим вчинком."
	},
	{
		"id": "ch1_021",
		"chapter": 1,
		"bg": "03_dormitory_exterior_evening",
		"speaker": "Дарія",
		"type": "thought",
		"text": "Потрібно проявляти ввічливість до людей навколо. І починати забувати про сором! З усіма таке трапляється. Правда ж?..",
		"center": "daria_main/daria_neutral"
	},
	{
		"id": "ch1_022",
		"chapter": 1,
		"bg": "03_dormitory_exterior_evening",
		"speaker": "",
		"type": "narrator",
		"text": "Хлопець ледь помітно посміхнувся і продовжив ходу."
	},
	{
		"id": "ch1_023",
		"chapter": 1,
		"bg": "03_dormitory_exterior_evening",
		"speaker": "",
		"type": "system",
		"text": "Зроблений вибір вплине на майбутнє!",
		"target": "ch1_027"
	},
	{
		"id": "ch1_025",
		"chapter": 1,
		"bg": "03_dormitory_exterior_evening",
		"speaker": "Дарія",
		"type": "thought",
		"text": "Наступного разу буду обережнішою..",
		"center": "daria_main/daria_neutral",
		"target": "ch1_027"
	},
	{
		"id": "ch1_027",
		"chapter": 1,
		"bg": "04_dormitory_lobby",
		"speaker": "",
		"type": "narrator",
		"text": "Відчинивши величезні і важкі двері, студентка привіталася з вахтою, показавши яскраво рожеву перепустку.",
		"transition": "fade"
	},
	{
		"id": "ch1_028",
		"chapter": 1,
		"bg": "04_dormitory_lobby",
		"speaker": "Вахтерка",
		"type": "dialogue",
		"text": "До якої кімнати Ви поселені?",
		"left": "daria_main/daria_neutral",
		"right": "watchwoman/watchwoman_neutral"
	},
	{
		"id": "ch1_029",
		"chapter": 1,
		"bg": "04_dormitory_lobby",
		"speaker": "Дарія",
		"type": "dialogue",
		"text": "Дев’яносто друга.",
		"center": "daria_main/daria_smile"
	},
	{
		"id": "ch1_030",
		"chapter": 1,
		"bg": "04_dormitory_lobby",
		"speaker": "Вахтерка",
		"type": "dialogue",
		"text": "Вам потрібно повернути наліво, дійти до п’ятого поверху, а опісля повернути направо.",
		"left": "daria_main/daria_neutral",
		"right": "watchwoman/watchwoman_neutral"
	},
	{
		"id": "ch1_031",
		"chapter": 1,
		"bg": "04_dormitory_lobby",
		"speaker": "Дарія",
		"type": "dialogue",
		"text": "Дякую.",
		"center": "daria_main/daria_smile"
	},
	{
		"id": "ch1_032",
		"chapter": 1,
		"bg": "04_dormitory_lobby",
		"speaker": "Вахтерка",
		"type": "dialogue",
		"text": "Щасти.",
		"left": "daria_main/daria_neutral",
		"right": "watchwoman/watchwoman_neutral"
	},
	{
		"id": "ch1_033",
		"chapter": 1,
		"bg": "04_dormitory_lobby",
		"speaker": "",
		"type": "narrator",
		"text": "Що ж.. Не все так погано. Навіть страшна вахта, що сниться студентам в кошмарах, не така вже й страшна. Чи вона мила тільки сьогодні?"
	},
	{
		"id": "ch1_034",
		"chapter": 1,
		"bg": "04_dormitory_lobby",
		"speaker": "Дарія",
		"type": "thought",
		"text": "Акція чи на мені є невидима таблиця з надписом «Обережно, першокурсниця!»?",
		"center": "daria_main/daria_neutral"
	},
	{
		"id": "ch1_035",
		"chapter": 1,
		"bg": "04_dormitory_lobby",
		"speaker": "",
		"type": "narrator",
		"text": "Внутрішня напруга, що була як тягар, і без того нелегкої ноші, потрохи проходила. Всередині з’явилося світле почуття надії, що і в кімнаті зараз все складеться найкращим чином."
	},
	{
		"id": "ch1_036",
		"chapter": 1,
		"bg": "04_dormitory_lobby",
		"speaker": "",
		"type": "narrator",
		"text": "Дарія зупинилася біля входу на п’ятий поверх."
	},
	{
		"id": "ch1_037",
		"chapter": 1,
		"bg": "05_dormitory_corridor_5f",
		"speaker": "Дарія",
		"type": "thought",
		"text": "Ой, і куди там далі?..",
		"center": "daria_main/daria_neutral",
		"transition": "fade"
	},
	{
		"id": "ch1_038",
		"chapter": 1,
		"bg": "05_dormitory_corridor_5f",
		"speaker": "",
		"type": "narrator",
		"text": "Куди повернути?",
		"choices": [
			{
				"text": "Наліво",
				"target": "ch1_040"
			},
			{
				"text": "Направо",
				"target": "ch1_044"
			}
		]
	},
	{
		"id": "ch1_040",
		"chapter": 1,
		"bg": "05_dormitory_corridor_5f",
		"speaker": "",
		"type": "narrator",
		"text": "Юначка сміливо рушила до дверей кімнати, проте вчасно помітила номер."
	},
	{
		"id": "ch1_041",
		"chapter": 1,
		"bg": "05_dormitory_corridor_5f",
		"speaker": "Дарія",
		"type": "thought",
		"text": "Ні, це дев’яносто четверта. Помилилась. Завчасно познайомилася б з іншими студентами.",
		"center": "daria_main/daria_neutral"
	},
	{
		"id": "ch1_042",
		"chapter": 1,
		"bg": "05_dormitory_corridor_5f",
		"speaker": "",
		"type": "narrator",
		"text": "Їй довелося повернутися, але віднайти потрібну кімнату не стало проблемою. Виявляється, вона була сусідньою.",
		"target": "ch1_047"
	},
	{
		"id": "ch1_044",
		"chapter": 1,
		"bg": "05_dormitory_corridor_5f",
		"speaker": "",
		"type": "narrator",
		"text": "Студентка попрямувала до дверей, вишукуючи очима номер."
	},
	{
		"id": "ch1_045",
		"chapter": 1,
		"bg": "05_dormitory_corridor_5f",
		"speaker": "Дарія",
		"type": "thought",
		"text": "Дійсно дев'яносто друга.",
		"center": "daria_main/daria_neutral",
		"target": "ch1_047"
	},
	{
		"id": "ch1_047",
		"chapter": 1,
		"bg": "05_dormitory_corridor_5f",
		"speaker": "Дарія",
		"type": "thought",
		"text": "Ну, що ж..",
		"center": "daria_main/daria_neutral"
	},
	{
		"id": "ch1_048",
		"chapter": 1,
		"bg": "06a_room_92_dark",
		"speaker": "",
		"type": "narrator",
		"text": "Глибоко вдихнувши, дівчина натиснула на дверну ручку. Погляд, повний приємного піднесення, зустріла тиха темнота.. Дикий контраст між очікуваннями і реальністю. Дарії пригадався безглуздий страх з дитинства, а уява почала малювати колючих монстрів, що от-от вистрибнуть з кутка. Вона з непевністю зробила крок уперед. Діватись все одно нікуди.",
		"transition": "fade"
	},
	{
		"id": "ch1_049",
		"chapter": 1,
		"bg": "06a_room_92_dark",
		"speaker": "Дарія",
		"type": "thought",
		"text": "Повинен же хтось тут..",
		"center": "daria_main/daria_neutral"
	},
	{
		"id": "ch1_050",
		"chapter": 1,
		"bg": "06a_room_92_dark",
		"speaker": "",
		"type": "narrator",
		"text": "Не закінчивши думку, Дарія почула шурхіт позаду себе. Здається, треба менше хвилюватися, бо не вистачало ще і галюцинацій. Чи це було насправді?"
	},
	{
		"id": "ch1_051",
		"chapter": 1,
		"bg": "06a_room_92_dark",
		"speaker": "Невідомий",
		"type": "dialogue",
		"text": "Бу!",
		"left": "daria_main/daria_neutral",
		"right": "maria/maria_playful"
	},
	{
		"id": "ch1_052",
		"chapter": 1,
		"bg": "06a_room_92_dark",
		"speaker": "",
		"type": "narrator",
		"text": "Серце почало шалено битись, тіло вмить скував страх. У голові навіть не встигла зародитись жодна твереза думка, яка сказала б це не робити, а тому.."
	},
	{
		"id": "ch1_053",
		"chapter": 1,
		"bg": "06a_room_92_dark",
		"speaker": "",
		"type": "narrator",
		"text": "Дарія закричала щосили."
	},
	{
		"id": "ch1_054",
		"chapter": 1,
		"bg": "06a_room_92_dark",
		"speaker": "",
		"type": "narrator",
		"text": "Інстинктивно вона повернулася, щоб вибігти з цієї зловісної темної студентської кімнати. Гуртожиток вмить здався їй печерою повною небезпек, але аж ніяк не затишним місцем за яким будеш сумувати всі наступні роки."
	},
	{
		"id": "ch1_055",
		"chapter": 1,
		"bg": "06a_room_92_dark",
		"speaker": "",
		"type": "narrator",
		"text": "Дарія нагадувала сама собі крота, який відчайдушно рукою намагається наосліп щось знайти. В цьому випадку це була дверна ручка, цілий портал, що відділить її від кошмару.."
	},
	{
		"id": "ch1_056",
		"chapter": 1,
		"bg": "06a_room_92_dark",
		"speaker": "",
		"type": "narrator",
		"text": "Та раптом яскраве світло заливає приміщення,, боляче вдаряючи в очі."
	},
	{
		"id": "ch1_057",
		"chapter": 1,
		"bg": "06a_room_92_dark",
		"speaker": "Дівчина",
		"type": "dialogue",
		"text": "Вибач, налякала тебе?",
		"left": "daria_main/daria_neutral",
		"right": "maria/maria_playful"
	},
	{
		"id": "ch1_058",
		"chapter": 1,
		"bg": "06a_room_92_dark",
		"speaker": "",
		"type": "narrator",
		"text": "Перед Дарією постала невисока постать темноволосої дівчини, що тримала руку на вимикачі поруч з дверима. Вона щиро усміхнулася, ймовірно, вважаючи жарт дотепним."
	},
	{
		"id": "ch1_059",
		"chapter": 1,
		"bg": "06a_room_92_dark",
		"speaker": "Дарія",
		"type": "thought",
		"text": "Гадаю, це одна з моїх сусідок. Не думаю, що комусь захотілося налякати невідому ще нікому студентку. Чи ні?.. Все ж, це не змінює її вчинку. Що робити?",
		"center": "daria_main/daria_neutral"
	},
	{
		"id": "ch1_060",
		"chapter": 1,
		"bg": "06a_room_92_dark",
		"speaker": "",
		"type": "narrator",
		"text": "Як відповісти на жарт?",
		"choices": [
			{
				"text": "Усміхнутись та підтримати жарт",
				"target": "ch1_062",
				"effects": {
					"maria": 1
				}
			},
			{
				"text": "Сказати, що жарт недоречний",
				"target": "ch1_066",
				"effects": {
					"maria": -1
				}
			}
		]
	},
	{
		"id": "ch1_062",
		"chapter": 1,
		"bg": "06a_room_92_dark",
		"speaker": "",
		"type": "narrator",
		"text": "Дарія видихнула, вона помітно розслабилася, а маску страху замінила іронічна усмішка."
	},
	{
		"id": "ch1_063",
		"chapter": 1,
		"bg": "06a_room_92_dark",
		"speaker": "Дарія",
		"type": "dialogue",
		"text": "Ти так налякала мене. Здавалося, от-от серце вистрибне з грудей!",
		"center": "daria_main/daria_smile"
	},
	{
		"id": "ch1_064",
		"chapter": 1,
		"bg": "06a_room_92_dark",
		"speaker": "",
		"type": "narrator",
		"text": "Почувши це, на обличчі дівчини почала красуватись задоволеність власним витвором. Вона втамувала свою спрагу до здійснення фантазії. Напевно, перед нею стоїть ще та любителька пригод.",
		"target": "ch1_071"
	},
	{
		"id": "ch1_066",
		"chapter": 1,
		"bg": "06a_room_92_dark",
		"speaker": "Дарія",
		"type": "dialogue",
		"text": "Насправді я увесь вечір у напрузі, тож це було дуже неочікувано. Дібравшись до кімнати, я мріяла нарешті про спокій після дороги.",
		"center": "daria_main/daria_smile"
	},
	{
		"id": "ch1_067",
		"chapter": 1,
		"bg": "06a_room_92_dark",
		"speaker": "",
		"type": "narrator",
		"text": "Постава Дарії видавала скутість, тіло напряглось ще більше, очі боязко гляділи кудись униз."
	},
	{
		"id": "ch1_068",
		"chapter": 1,
		"bg": "06a_room_92_dark",
		"speaker": "Дівчина",
		"type": "dialogue",
		"text": "Вибач, не думала, що це так сильно засмутить тебе.",
		"left": "daria_main/daria_neutral",
		"right": "maria/maria_playful"
	},
	{
		"id": "ch1_069",
		"chapter": 1,
		"bg": "06a_room_92_dark",
		"speaker": "",
		"type": "narrator",
		"text": "Проте інтонація дівчини говорила про те, що це зовсім не те, чого вона очікувала. Між ними залишилася кількахвилинна незручна пауза.",
		"target": "ch1_071"
	},
	{
		"id": "ch1_071",
		"chapter": 1,
		"bg": "06b_room_92_light",
		"speaker": "Дівчина",
		"type": "dialogue",
		"text": "Мене звати Марія. Я, як ти вже зрозуміла, твоя сусідка.",
		"left": "daria_main/daria_neutral",
		"right": "maria/maria_playful"
	},
	{
		"id": "ch1_072",
		"chapter": 1,
		"bg": "06b_room_92_light",
		"speaker": "Дарія",
		"type": "dialogue",
		"text": "Приємно познайомитися, я Дарія.",
		"center": "daria_main/daria_smile"
	},
	{
		"id": "ch1_073",
		"chapter": 1,
		"bg": "06b_room_92_light",
		"speaker": "Марія",
		"type": "dialogue",
		"text": "Втомилась? І, напевно, страшенно хвилюєшся перед початком навчального року.",
		"left": "daria_main/daria_neutral",
		"right": "maria/maria_playful"
	},
	{
		"id": "ch1_074",
		"chapter": 1,
		"bg": "06b_room_92_light",
		"speaker": "Дарія",
		"type": "dialogue",
		"text": "Так, є такий момент..",
		"center": "daria_main/daria_smile"
	},
	{
		"id": "ch1_075",
		"chapter": 1,
		"bg": "06b_room_92_light",
		"speaker": "Марія",
		"type": "dialogue",
		"text": "Тільки не хвилюйся за життя в гуртожитку, тут чудово і ми тебе не образимо.",
		"left": "daria_main/daria_neutral",
		"right": "maria/maria_playful"
	},
	{
		"id": "ch1_076",
		"chapter": 1,
		"bg": "06b_room_92_light",
		"speaker": "",
		"type": "narrator",
		"text": "Пам’ять сама вирішила нагадати ситуацію, що трапилася нещодавно. Ніби прочитавши думки, Марія, голосно засміялась і сказала.."
	},
	{
		"id": "ch1_077",
		"chapter": 1,
		"bg": "06b_room_92_light",
		"speaker": "Марія",
		"type": "dialogue",
		"text": "Налякати не береться до уваги!",
		"left": "daria_main/daria_neutral",
		"right": "maria/maria_playful"
	},
	{
		"id": "ch1_078",
		"chapter": 1,
		"bg": "06b_room_92_light",
		"speaker": "",
		"type": "narrator",
		"text": "В двері наполегливо постукали."
	},
	{
		"id": "ch1_079",
		"chapter": 1,
		"bg": "06b_room_92_light",
		"speaker": "Марія",
		"type": "dialogue",
		"text": "Вона знову забула ключі.",
		"left": "daria_main/daria_neutral",
		"right": "maria/maria_playful"
	},
	{
		"id": "ch1_080",
		"chapter": 1,
		"bg": "06b_room_92_light",
		"speaker": "",
		"type": "narrator",
		"text": "Закотивши очі і зробивши незадоволено-саркастичну гримасу, Марія посунула відчиняти."
	},
	{
		"id": "ch1_081",
		"chapter": 1,
		"bg": "06b_room_92_light",
		"speaker": "Марія",
		"type": "dialogue",
		"text": "Знаєш, якщо тобі не допоміг навіть величезний брелок, то все ж ідея з ключами на мотузці як прикраса на шию, здається не такою поганою.",
		"left": "daria_main/daria_neutral",
		"right": "maria/maria_playful"
	},
	{
		"id": "ch1_082",
		"chapter": 1,
		"bg": "06b_room_92_light",
		"speaker": "",
		"type": "narrator",
		"text": "Хтось по той бік незадоволено плямкнув губами."
	},
	{
		"id": "ch1_083",
		"chapter": 1,
		"bg": "06b_room_92_light",
		"speaker": "",
		"type": "narrator",
		"text": "У кімнату ввійшла висока, струнка та неймовірно красива дівчина. Її русяве волосся було зібране в незграбний пучок. На вигляд їй було років дев’ятнадцять. У світло-фіолетовому топі та вузькуватих джинсах, вона стояла втомлено, явно не зацікавлена в діалозі."
	},
	{
		"id": "ch1_084",
		"chapter": 1,
		"bg": "06b_room_92_light",
		"speaker": "Анна",
		"type": "dialogue",
		"text": "О, ти вже тут. Ну, привіт.",
		"left": "daria_main/daria_neutral",
		"right": "anna/anna_supportive"
	},
	{
		"id": "ch1_085",
		"chapter": 1,
		"bg": "06b_room_92_light",
		"speaker": "",
		"type": "narrator",
		"text": "Дарія постаралась якомога миліше посміхатися, що тренувала кілька днів підряд дома, адже доброзичливість здавалась їй запорукою успіху."
	},
	{
		"id": "ch1_086",
		"chapter": 1,
		"bg": "06b_room_92_light",
		"speaker": "Анна",
		"type": "dialogue",
		"text": "Я Анна.",
		"left": "daria_main/daria_neutral",
		"right": "anna/anna_supportive"
	},
	{
		"id": "ch1_087",
		"chapter": 1,
		"bg": "06b_room_92_light",
		"speaker": "",
		"type": "narrator",
		"text": "Анна впевнено протягнула худорляву руку, яку у відповідь стиснула новенька сусідка."
	},
	{
		"id": "ch1_088",
		"chapter": 1,
		"bg": "06b_room_92_light",
		"speaker": "Анна",
		"type": "dialogue",
		"text": "Вибач, напевно, було б правильно поговорити для початку, проте я надто втомлена після вирішення питань з роботою. Четвертий курс вже ось-ось розпочнеться..",
		"left": "daria_main/daria_neutral",
		"right": "anna/anna_supportive"
	},
	{
		"id": "ch1_089",
		"chapter": 1,
		"bg": "06b_room_92_light",
		"speaker": "",
		"type": "narrator",
		"text": "Дарія була здивована, вважаючи сусідку молодшою, але мати знайому старшокласницю дуже навіть круто. Вона не думала про свій четвертий курс, він здавався їй надто далеким. Та все ж першокурсниця розуміла.."
	},
	{
		"id": "ch1_090",
		"chapter": 1,
		"bg": "06b_room_92_light",
		"speaker": "Дарія",
		"type": "thought",
		"text": "Четвертий курс надзвичайно складний, особливо морально. Багато справ потребують саме твоєї уваги.. А ти зрештою може і не впевнений чого дійсно хочеш.",
		"center": "daria_main/daria_neutral"
	},
	{
		"id": "ch1_091",
		"chapter": 1,
		"bg": "06b_room_92_light",
		"speaker": "Дарія",
		"type": "dialogue",
		"text": "Не переймайся, все гаразд. Я розумію, що насправді ми обоє сьогодні потребуємо відпочинку. Якось іншим разом обов'язково!",
		"center": "daria_main/daria_smile"
	},
	{
		"id": "ch1_092",
		"chapter": 1,
		"bg": "06b_room_92_light",
		"speaker": "",
		"type": "system",
		"text": "Анна рада побачити розуміння з Вашого боку."
	},
	{
		"id": "ch1_093",
		"chapter": 1,
		"bg": "06b_room_92_light",
		"speaker": "Анна",
		"type": "dialogue",
		"text": "Так, звісно. А сьогодні тобі все покаже і розкаже Пані Непосидючість.",
		"left": "daria_main/daria_neutral",
		"right": "anna/anna_supportive"
	},
	{
		"id": "ch1_094",
		"chapter": 1,
		"bg": "06b_room_92_light",
		"speaker": "",
		"type": "narrator",
		"text": "Дарія мимоволі посміхнулась такому цікавому прізвиську. Цікаво, у неї теж буде таке? Їй захотілось поцікавитись."
	},
	{
		"id": "ch1_095",
		"chapter": 1,
		"bg": "06b_room_92_light",
		"speaker": "Дарія",
		"type": "dialogue",
		"text": "Прізвисько мають усі в кімнаті?",
		"center": "daria_main/daria_smile"
	},
	{
		"id": "ch1_096",
		"chapter": 1,
		"bg": "06b_room_92_light",
		"speaker": "Марія",
		"type": "dialogue",
		"text": "А що? Боїшся, що станеш Пані Дуже Гучний Крик?",
		"left": "daria_main/daria_neutral",
		"right": "maria/maria_playful"
	},
	{
		"id": "ch1_097",
		"chapter": 1,
		"bg": "06b_room_92_light",
		"speaker": "",
		"type": "narrator",
		"text": "Анна незадоволено глянула на Марію. Вона зрозуміла, що сталося, знаючи характер Марії, навіть не бувши свідком події."
	},
	{
		"id": "ch1_098",
		"chapter": 1,
		"bg": "06b_room_92_light",
		"speaker": "Анна",
		"type": "dialogue",
		"text": "Ти її таки налякала? Не змінюєшся зовсім.. Втім, Даріє, якщо цікаво, то ні, не у всіх. Марія у нас особлива.",
		"left": "daria_main/daria_neutral",
		"right": "anna/anna_supportive"
	},
	{
		"id": "ch1_099",
		"chapter": 1,
		"bg": "06b_room_92_light",
		"speaker": "",
		"type": "narrator",
		"text": "Останнє слово було сказане з іншою інтонацією, протяжно і саркастично."
	},
	{
		"id": "ch1_100",
		"chapter": 1,
		"bg": "06b_room_92_light",
		"speaker": "Марія",
		"type": "dialogue",
		"text": "Так, але можемо тобі придумати теж. Як щодо Пані Нудило, наприклад?",
		"left": "daria_main/daria_neutral",
		"right": "maria/maria_playful"
	},
	{
		"id": "ch1_101",
		"chapter": 1,
		"bg": "06b_room_92_light",
		"speaker": "",
		"type": "narrator",
		"text": "Анна зморено зітхнула."
	},
	{
		"id": "ch1_102",
		"chapter": 1,
		"bg": "06b_room_92_light",
		"speaker": "Анна",
		"type": "dialogue",
		"text": "Чарівно.",
		"left": "daria_main/daria_neutral",
		"right": "anna/anna_supportive"
	},
	{
		"id": "ch1_103",
		"chapter": 1,
		"bg": "06b_room_92_light",
		"speaker": "",
		"type": "narrator",
		"text": "Сусідки обмінялись жестом, висинувши язики і щосили зажмуривши очі. Незважаючи на їхні словесні перепалки, між ними відчувалась не ворожнеча, а доволі специфічна та все ж дружба."
	},
	{
		"id": "ch1_104",
		"chapter": 1,
		"bg": "06b_room_92_light",
		"speaker": "Марія",
		"type": "dialogue",
		"text": "Гайда, Даріє. Тобі ще треба підготуватись до завтрашнього дня і як слід відпочити.",
		"left": "daria_main/daria_neutral",
		"right": "maria/maria_playful"
	},
	{
		"id": "ch1_105",
		"chapter": 1,
		"bg": "06b_room_92_light",
		"speaker": "",
		"type": "narrator",
		"text": "Дарія попленталася за Марією, очікуючи надзвичайно важливих інструкцій з виживання у цих саванах студентства."
	},
	{
		"id": "ch1_106",
		"chapter": 1,
		"bg": "06b_room_92_light",
		"speaker": "",
		"type": "narrator",
		"text": "Виявилось, що все не так важко."
	},
	{
		"id": "ch1_107",
		"chapter": 1,
		"bg": "06b_room_92_light",
		"speaker": "Дарія",
		"type": "thought",
		"text": "Окей, я таки добряче себе накрутила.",
		"center": "daria_main/daria_neutral"
	},
	{
		"id": "ch1_108",
		"chapter": 1,
		"bg": "09_attic",
		"speaker": "",
		"type": "narrator",
		"text": "Змиритись поки що було важко тільки з розміром маленьких кімнат. Не те, щоб Дарія звикла жити у великих будинках. У неї самої була невеличка кімната вдома, розташована на горищі. Вона неймовірно сильно любила її, а особливо крихітне вікно у даху, крізь яке в теплу пору року можна було завжди спостерігати за зорями. Засинаючи після прочитання чергової книги, дівчина дивилась і мріяла…",
		"transition": "fade"
	},
	{
		"id": "ch1_109",
		"chapter": 1,
		"bg": "09_attic",
		"speaker": "Дарія",
		"type": "dialogue",
		"text": "«Per astra ad astra. Книги залишаться і завжди будуть зі мною, я прийшла, щоб знайти свою зірку в житті».",
		"center": "daria_main/daria_smile"
	},
	{
		"id": "ch1_110",
		"chapter": 1,
		"bg": "06b_room_92_light",
		"speaker": "",
		"type": "narrator",
		"text": "Дві години промайнули майже непомітно. Марія встигла показати та розказати найважливіше, іншу частину часу Дарія розкладала речі. Про себе відмітила – тривога майже зникла. У коридорі чулись дзвінкі переливчасті веселі голоси.",
		"transition": "fade"
	},
	{
		"id": "ch1_111",
		"chapter": 1,
		"bg": "06b_room_92_light",
		"speaker": "Дарія",
		"type": "thought",
		"text": "Вони не вперше тут. Вони повернулись до друзів, до звичного ритму життя. І в мене таке буде, обов'язково..",
		"center": "daria_main/daria_neutral"
	},
	{
		"id": "ch1_112",
		"chapter": 1,
		"bg": "06b_room_92_light",
		"speaker": "",
		"type": "narrator",
		"text": "Дарія приділяла пухнастим мріям багато часу. Вони м’яко огортали її і закривали від непростого життя навколо. Дівчина найбільше мріяла про ту саму подругу, якої не було поруч всі шкільні роки. Вона була зобов'язана з’явитися зараз. Бо, як відомо, саме студентська дружба є найміцнішим зв’язком в житті!"
	},
	{
		"id": "ch1_113",
		"chapter": 1,
		"bg": "06b_room_92_light",
		"speaker": "Дарія",
		"type": "thought",
		"text": "Дорослішати разом, хіба це ж не прекрасно?",
		"center": "daria_main/daria_neutral"
	},
	{
		"id": "ch1_114",
		"chapter": 1,
		"bg": "06b_room_92_light",
		"speaker": "",
		"type": "narrator",
		"text": "Анна майже одразу почала готуватися до сну. Дарія не була на неї ображена за це. Не хотіла, щоб її особистість викликала надто багато уваги. А особливо, щоб не порушувала їхнього звичного повсякдення. Тож це не створювало дискомфорту. Та все ж перед сном, четвертокурсниця відкликнула її."
	},
	{
		"id": "ch1_115",
		"chapter": 1,
		"bg": "06b_room_92_light",
		"speaker": "Анна",
		"type": "dialogue",
		"text": "Хей, хвилюєшся?",
		"left": "daria_main/daria_neutral",
		"right": "anna/anna_supportive"
	},
	{
		"id": "ch1_116",
		"chapter": 1,
		"bg": "06b_room_92_light",
		"speaker": "Дарія",
		"type": "dialogue",
		"text": "Так, трохи.",
		"center": "daria_main/daria_smile"
	},
	{
		"id": "ch1_117",
		"chapter": 1,
		"bg": "06b_room_92_light",
		"speaker": "Анна",
		"type": "dialogue",
		"text": "Знаю, що це прозвучить банально та повір, все пройде найкращим чином.",
		"left": "daria_main/daria_neutral",
		"right": "anna/anna_supportive"
	},
	{
		"id": "ch1_118",
		"chapter": 1,
		"bg": "06b_room_92_light",
		"speaker": "Дарія",
		"type": "dialogue",
		"text": "Дякую, в глибині душі я насправді це розумію та серце, здається, таки не хоче заспокоїтись.",
		"center": "daria_main/daria_smile"
	},
	{
		"id": "ch1_119",
		"chapter": 1,
		"bg": "06b_room_92_light",
		"speaker": "",
		"type": "narrator",
		"text": "Дівчина посміхнулась."
	},
	{
		"id": "ch1_120",
		"chapter": 1,
		"bg": "06b_room_92_light",
		"speaker": "Анна",
		"type": "dialogue",
		"text": "Я розумію твою тривогу. Це нормально. І в мене таке було. Направду, я сумую за тим часом, коли сама була першокурсницею.",
		"left": "daria_main/daria_neutral",
		"right": "anna/anna_supportive"
	},
	{
		"id": "ch1_121",
		"chapter": 1,
		"bg": "06b_room_92_light",
		"speaker": "",
		"type": "narrator",
		"text": "Її накрила пелена ностальгічного смутку. Дарія, звісно, не могла уявити, що відчуває сусідка, бо сама відчувала ностальгію не так часто. За школою сумувати ще не приходилось. Але не вже дійсно можна сумувати за першим курсом? За цим страхом до всього, що навколо тебе?"
	},
	{
		"id": "ch1_122",
		"chapter": 1,
		"bg": "06b_room_92_light",
		"speaker": "Дарія",
		"type": "dialogue",
		"text": "«Можливо, колись. А зараз відчуваю себе так, ніби мене викинули у величезне бурхливе незнайоме мені море, сказавши перед цим навчитись плавати. Я хочу кричати їм «як?» та майже впевнена, що у відповідь почула б «якось. Не має правил. Кожен вчиться плавати як вміє і припливає куди хоче.».",
		"center": "daria_main/daria_smile"
	},
	{
		"id": "ch1_123",
		"chapter": 1,
		"bg": "06b_room_92_light",
		"speaker": "",
		"type": "narrator",
		"text": "Припинив цей глибинний потік думок, який насправді часто з'являвся в голові першокурсниці, м'який голос сусідки, що продовжила."
	},
	{
		"id": "ch1_124",
		"chapter": 1,
		"bg": "07_university_courtyard",
		"speaker": "Анна",
		"type": "dialogue",
		"text": "Страх - це нормально. Проте постарайся сфокусуватися на хорошому. Починається нова сторінка твого життя. Якщо буде потрібно, ти завжди можеш звернутися до мене.",
		"left": "daria_main/daria_neutral",
		"right": "anna/anna_supportive",
		"transition": "fade"
	},
	{
		"id": "ch1_125",
		"chapter": 1,
		"bg": "07_university_courtyard",
		"speaker": "",
		"type": "narrator",
		"text": "Дарію розчулили ці слова. Ось, яка чудесна мить! Вона вперше заручилася чиєюсь підтримкою. Тепер таки не одна!"
	},
	{
		"id": "ch1_126",
		"chapter": 1,
		"bg": "07_university_courtyard",
		"speaker": "",
		"type": "narrator",
		"text": "Ніч пройшла безсонно. Не можна сказати, що юначці завадив саме страх."
	},
	{
		"id": "ch1_127",
		"chapter": 1,
		"bg": "07_university_courtyard",
		"speaker": "Марія",
		"type": "dialogue",
		"text": "Доброго раночку!",
		"left": "daria_main/daria_neutral",
		"right": "maria/maria_playful"
	},
	{
		"id": "ch1_128",
		"chapter": 1,
		"bg": "07_university_courtyard",
		"speaker": "",
		"type": "narrator",
		"text": "Її бадьоре обличчя сяяло від кількості щойно використаних кремів. Кімнату наповнив аромат пряної кави, що вже стояла на столі. Анна теж прокинулася та не квапилась."
	},
	{
		"id": "ch1_129",
		"chapter": 1,
		"bg": "07_university_courtyard",
		"speaker": "Дарія",
		"type": "dialogue",
		"text": "Доброго.",
		"center": "daria_main/daria_smile"
	},
	{
		"id": "ch1_130",
		"chapter": 1,
		"bg": "07_university_courtyard",
		"speaker": "",
		"type": "narrator",
		"text": "Сонно потягуючись, Дарія встала з ліжка, прямуючи до шафки з баночками для ранкової рутини. Як тільки дівчина повернулась з ванни, Марія вирішила терміново розпитати про самопочуття новенької сусідки."
	},
	{
		"id": "ch1_131",
		"chapter": 1,
		"bg": "07_university_courtyard",
		"speaker": "Марія",
		"type": "dialogue",
		"text": "Ти виспалась? Як почуваєшся?",
		"left": "daria_main/daria_neutral",
		"right": "maria/maria_playful"
	},
	{
		"id": "ch1_132",
		"chapter": 1,
		"bg": "07_university_courtyard",
		"speaker": "Дарія",
		"type": "dialogue",
		"text": "Чомусь не дуже. Напевно, треба звикнути до нового місця.",
		"center": "daria_main/daria_smile"
	},
	{
		"id": "ch1_133",
		"chapter": 1,
		"bg": "07_university_courtyard",
		"speaker": "Марія",
		"type": "dialogue",
		"text": "О, до цих пружинних ліжок зокрема!",
		"left": "daria_main/daria_neutral",
		"right": "maria/maria_playful"
	},
	{
		"id": "ch1_134",
		"chapter": 1,
		"bg": "07_university_courtyard",
		"speaker": "",
		"type": "narrator",
		"text": "Вона, підморгнувши, продовжувала швидко збиратись. Її настрій навіть частково передався сонним."
	},
	{
		"id": "ch1_135",
		"chapter": 1,
		"bg": "07_university_courtyard",
		"speaker": "Марія",
		"type": "dialogue",
		"text": "А може ти не виспалась через Анну? Вона вміє давати сплячий стендап-концерт!",
		"left": "daria_main/daria_neutral",
		"right": "maria/maria_playful"
	},
	{
		"id": "ch1_136",
		"chapter": 1,
		"bg": "07_university_courtyard",
		"speaker": "",
		"type": "narrator",
		"text": "Анна ошелешено глянула на сусідку, що все з посмішкою продовжувала наряджатись."
	},
	{
		"id": "ch1_137",
		"chapter": 1,
		"bg": "07_university_courtyard",
		"speaker": "Анна",
		"type": "dialogue",
		"text": "Ну, звісно. Сьогодні я була тиха. Дала можливість тобі побути зіркою спочатку.",
		"left": "daria_main/daria_neutral",
		"right": "anna/anna_supportive"
	},
	{
		"id": "ch1_138",
		"chapter": 1,
		"bg": "07_university_courtyard",
		"speaker": "",
		"type": "narrator",
		"text": "Русявка демонстративно закотила очі. А серце Дарії гріла тепла радість."
	},
	{
		"id": "ch1_139",
		"chapter": 1,
		"bg": "07_university_courtyard",
		"speaker": "Анна",
		"type": "dialogue",
		"text": "Ти рідко під час семестру так квапишся до універу.",
		"left": "daria_main/daria_neutral",
		"right": "anna/anna_supportive"
	},
	{
		"id": "ch1_140",
		"chapter": 1,
		"bg": "07_university_courtyard",
		"speaker": "Марія",
		"type": "dialogue",
		"text": "Сьогодні особливий випадок. Вперше за два місяці побачусь з подругами. Стільки всього треба обговорити!",
		"left": "daria_main/daria_neutral",
		"right": "maria/maria_playful"
	},
	{
		"id": "ch1_141",
		"chapter": 1,
		"bg": "07_university_courtyard",
		"speaker": "Анна",
		"type": "dialogue",
		"text": "Ну, в такому разі..",
		"left": "daria_main/daria_neutral",
		"right": "anna/anna_supportive"
	},
	{
		"id": "ch1_142",
		"chapter": 1,
		"bg": "07_university_courtyard",
		"speaker": "",
		"type": "narrator",
		"text": "Обидві обмінялись тихим смішком з їхнім авторським жестом. Дарія тим часом зібралась, встигнувши прочитати повідомлення у новоствореному чаті з учасниками їхньої групи. В ньому йшлось про те, що староста буде очікувати всіх надворі, щоб разом дібратись до аудиторії."
	},
	{
		"id": "ch1_143",
		"chapter": 1,
		"bg": "07_university_courtyard",
		"speaker": "Дарія",
		"type": "thought",
		"text": "Вже зовсім скоро..",
		"center": "daria_main/daria_neutral"
	},
	{
		"id": "ch1_144",
		"chapter": 1,
		"bg": "07_university_courtyard",
		"speaker": "",
		"type": "narrator",
		"text": "Марія покинула кімнату першою, тому перед її виходом залишилась тільки Анна, якій виявляється, сьогодні пощастило: в неї за розкладом пари починаються з другої. Четвертокурсниця ще раз щиро побажала успіхів Дарії і та рушила університетським подвір'ям на зустріч своєму майбутньому."
	},
	{
		"id": "ch1_145",
		"chapter": 1,
		"bg": "07_university_courtyard",
		"speaker": "",
		"type": "narrator",
		"text": "Все подвір'я гомоніло. Першокурсниця, напевно, ще ніколи не бачила стільки юних дійсно щасливих лиць. Здавалося б, чому радіти? Знову кілька місяців нелегкого навчання, ймовірно, складна сесія і аж тоді студенти знову зможуть відчути хоч краплю духу свободи. Радіти могли хіба «першачки», для них ще була невідома та солодка наука. Проте, звичайно ж, на подвір'ї перебували не лише вони. А значить.."
	},
	{
		"id": "ch1_146",
		"chapter": 1,
		"bg": "07_university_courtyard",
		"speaker": "Дарія",
		"type": "thought",
		"text": "”Від сесії до сесії живуть студенти весело” - правда.",
		"center": "daria_main/daria_neutral"
	},
	{
		"id": "ch1_147",
		"chapter": 1,
		"bg": "07_university_courtyard",
		"speaker": "",
		"type": "narrator",
		"text": "На душі стало радісно. Цей новий гул викликав спектр найкращих емоцій і серце видало заспокійливе «маємо велику світлу надію!»."
	},
	{
		"id": "ch1_148",
		"chapter": 1,
		"bg": "07_university_courtyard",
		"speaker": "",
		"type": "narrator",
		"text": "Дарія наближалась, бачачи перед гуманітарним корпусом кілька груп. Цього вона і боялась. Як знайти потрібних невідомих тобі ще людей? Кричати назву своєї групи дуже не хотілось. Вона ніколи не любила зайвої уваги. Та й це надто дивно. Фото в чаті були, але в житті часто трапляються випадки, коли вони не зовсім відповідають дійсності. А, можливо, хтось вирішив перед початком навчання кардинально змінити імідж і не змінити фото аватарки. Дівчина встигла серйозно замислить що ж робити далі, проте її погляд вчасно зупинився на одній з груп, де чиєсь лице здалося знайомим.. Обличчя за кілька секунд глянуло в екран телефону, назад і раптом промовило її ім’я."
	},
	{
		"id": "ch1_149",
		"chapter": 1,
		"bg": "07_university_courtyard",
		"speaker": "Незнайомка",
		"type": "dialogue",
		"text": "Ти, певно, Дарія?",
		"left": "daria_main/daria_neutral",
		"right": "melania/melania_calm"
	},
	{
		"id": "ch1_150",
		"chapter": 1,
		"bg": "07_university_courtyard",
		"speaker": "",
		"type": "narrator",
		"text": "Не могло бути щасливішого моменту зараз, ніж почути це. З відчутним полегшенням вона рушила до цієї групи. Натовпом не назвеш, надто мало людей. Отже, прийшли ще не всі. То й на краще. Запізнюватися чи бути останньою теж належало до списку не улюблених речей Дарії."
	},
	{
		"id": "ch1_151",
		"chapter": 1,
		"bg": "07_university_courtyard",
		"speaker": "Незнайомка",
		"type": "dialogue",
		"text": "Привіт, мене звати Марта. Я староста групи.",
		"left": "daria_main/daria_neutral",
		"right": "melania/melania_calm"
	},
	{
		"id": "ch1_152",
		"chapter": 1,
		"bg": "07_university_courtyard",
		"speaker": "",
		"type": "narrator",
		"text": "Марта протягнула руку для привітання. Дівчина здавалась Дарії милою, привітною. Ще один хороший знак, адже староста в університеті як друга мама. Слідом за Мартою привітались і інші, кожен по черзі назвав своє ім'я. Стало комфортно, але й водночас хвилююче цікаво за прийдешні дні, що вони мали провести поруч одне з одним. Потрохи невелика компанія розросталась."
	},
	{
		"id": "ch1_153",
		"chapter": 1,
		"bg": "07_university_courtyard",
		"speaker": "Марта",
		"type": "dialogue",
		"text": "Чого ви очікуєте від першого дня в університеті?",
		"right": "marta/marta_smile"
	},
	{
		"id": "ch1_154",
		"chapter": 1,
		"bg": "07_university_courtyard",
		"speaker": "",
		"type": "narrator",
		"text": "Всі поринули у роздуми. У кожного було щось в уяві та конкретного нічого. Насмілилась відповісти одногрупниця, що стояла справа. Дарії надзвичайно сподобались її розкішні червоняві кучерики. Носик вкривало ластовиння. Мимоволі, дивлячись на неї, уявлялось ласкаве сонце. Дівчина представилась раніше."
	},
	{
		"id": "ch1_155",
		"chapter": 1,
		"bg": "07_university_courtyard",
		"speaker": "Оксана",
		"type": "dialogue",
		"text": "Не знаю як ви, а я сподіваюсь, хоча б не загубитися першого ж дня. Я серйозно. Якщо не побачите мене поруч, кричіть «Сир!», бо моя цікавість до всього навколо в сумісності з поганою орієнтацією в просторі колись таки мені зашкодить.",
		"right": "oksana/oksana_smile"
	},
	{
		"id": "ch1_156",
		"chapter": 1,
		"bg": "07_university_courtyard",
		"speaker": "",
		"type": "narrator",
		"text": "Одногрупники вважали це жартом, а втім про Оксану з обережності таки варто було не забути. Дарія насмілилась запитати."
	},
	{
		"id": "ch1_157",
		"chapter": 1,
		"bg": "07_university_courtyard",
		"speaker": "Дарія",
		"type": "dialogue",
		"text": "Чому саме сир?",
		"center": "daria_main/daria_smile"
	},
	{
		"id": "ch1_158",
		"chapter": 1,
		"bg": "07_university_courtyard",
		"speaker": "Оксана",
		"type": "dialogue",
		"text": "Просто люблю і ні за що в світі не пробачу вас, якщо з’їсте його без мене.",
		"right": "oksana/oksana_smile"
	},
	{
		"id": "ch1_159",
		"chapter": 1,
		"bg": "07_university_courtyard",
		"speaker": "",
		"type": "narrator",
		"text": "Оксана сподобалась Дарії своєю енергетикою: доброю і ніби вільною від усіх людських турбот. Вона була впевнена, що обов'язково побачить згодом її активною учасницею гуртків чи чогось схожого, по-іншому, здається, бути не могло."
	},
	{
		"id": "ch1_160",
		"chapter": 1,
		"bg": "07_university_courtyard",
		"speaker": "Марта",
		"type": "dialogue",
		"text": "Не всі є, але вже зовсім скоро розпочнуться пари. Можливо, пошукаємо аудиторію, а іншим допоможемо і направимо їх текстовими повідомленнями?",
		"right": "marta/marta_smile"
	},
	{
		"id": "ch1_161",
		"chapter": 1,
		"bg": "07_university_courtyard",
		"speaker": "",
		"type": "narrator",
		"text": "Група погодилась. Рушивши до входу, Дарія мимоволі оглянула присутніх. Кожен здався їй крутою особистістю, ще незнайомою, але це легко виправити."
	},
	{
		"id": "ch1_162",
		"chapter": 1,
		"bg": "08_classroom",
		"speaker": "",
		"type": "narrator",
		"text": "До аудиторії, на диво, дібрались без пригод. Не блукали, як очікувалось, дехто встиг пожартувати про ідею створення карти корпусу.",
		"transition": "fade"
	},
	{
		"id": "ch1_163",
		"chapter": 1,
		"bg": "08_classroom",
		"speaker": "",
		"type": "narrator",
		"text": "Студенти зайняли свої місця у аудиторії. Вона виявилась дуже просторою, світлою і неймовірно затишною. Одразу захотілось з головою поринути у навчання. Дарія вже уявила ці неймовірні дні. А, можливо, вони будуть надто складними? Якщо вона не впорається.."
	},
	{
		"id": "ch1_164",
		"chapter": 1,
		"bg": "08_classroom",
		"speaker": "",
		"type": "narrator",
		"text": "Годинник показував пів на дев'яту. Всі мовчки приготувались до священного моменту: ось-ось і сюди зайде архіваріус мудрості, магістр"
	},
	{
		"id": "ch1_165",
		"chapter": 1,
		"bg": "08_classroom",
		"speaker": "",
		"type": "narrator",
		"text": "заліків, покровитель конспектів! Ну, або як в народі кажуть, просто викладач."
	},
	{
		"id": "ch1_166",
		"chapter": 1,
		"bg": "08_classroom",
		"speaker": "",
		"type": "narrator",
		"text": "Двері відчинилися. Не було чутно ані звуку, певно, багато хто затамував подих. У приміщення ввійшла юначка. Почулось тихе “фух” з задніх рядів. Колектив помітно розслабився."
	},
	{
		"id": "ch1_167",
		"chapter": 1,
		"bg": "08_classroom",
		"speaker": "Незнайомка",
		"type": "dialogue",
		"text": "Вибачте, це ж українські філологи перший курс?",
		"left": "daria_main/daria_neutral",
		"right": "melania/melania_calm"
	},
	{
		"id": "ch1_168",
		"chapter": 1,
		"bg": "08_classroom",
		"speaker": "",
		"type": "narrator",
		"text": "Дівчина переводила подих, очима шукаючи вільне місце. Біля Дарії якраз знаходилось одне з них."
	},
	{
		"id": "ch1_169",
		"chapter": 1,
		"bg": "08_classroom",
		"speaker": "Дарія",
		"type": "thought",
		"text": "Я можу допомогти їй. Вона виглядає втомленою. Ймовірно, дуже поспішала.",
		"center": "daria_main/daria_neutral"
	},
	{
		"id": "ch1_170",
		"chapter": 1,
		"bg": "08_classroom",
		"speaker": "",
		"type": "narrator",
		"text": "Допомогти Меланії?",
		"choices": [
			{
				"text": "Підняти руку, щоб привернути увагу",
				"target": "ch1_172",
				"effects": {
					"melania": 1,
					"reputation": 1
				}
			},
			{
				"text": "Мовчки спостерігати",
				"target": "ch1_177"
			}
		]
	},
	{
		"id": "ch1_172",
		"chapter": 1,
		"bg": "08_classroom",
		"speaker": "",
		"type": "narrator",
		"text": "Дарія підняла ліву руку, тим самим привертаючи увагу дівчини, що досі стовбичилась біля дверей. Вона помітила майже одразу. Задоволено кивнула головою та рушила до місця."
	},
	{
		"id": "ch1_173",
		"chapter": 1,
		"bg": "08_classroom",
		"speaker": "Незнайомка",
		"type": "dialogue",
		"text": "Дякую.",
		"left": "daria_main/daria_neutral",
		"right": "melania/melania_calm"
	},
	{
		"id": "ch1_174",
		"chapter": 1,
		"bg": "08_classroom",
		"speaker": "",
		"type": "narrator",
		"text": "Її очі вдячливо глянули на сусідку по парті."
	},
	{
		"id": "ch1_175",
		"chapter": 1,
		"bg": "08_classroom",
		"speaker": "",
		"type": "system",
		"text": "Вибір вплинув на стосунки з одногрупницею в майбутньому.",
		"target": "ch1_181"
	},
	{
		"id": "ch1_177",
		"chapter": 1,
		"bg": "08_classroom",
		"speaker": "",
		"type": "narrator",
		"text": "Дарія вирішила не втручатися. В багатьох ситуаціях їй було комфортніше перебувати у позиції спостерігача. Нерідко вона картала себе за це та сьогодні нічого змінювати не хотілось."
	},
	{
		"id": "ch1_178",
		"chapter": 1,
		"bg": "08_classroom",
		"speaker": "",
		"type": "narrator",
		"text": "Дівчина через кілька секунд сама знайшла поглядом та присіла поруч."
	},
	{
		"id": "ch1_179",
		"chapter": 1,
		"bg": "08_classroom",
		"speaker": "",
		"type": "system",
		"text": "Вибір вплинув на стосунки з одногрупницею в майбутньому.",
		"target": "ch1_181"
	},
	{
		"id": "ch1_181",
		"chapter": 1,
		"bg": "08_classroom",
		"speaker": "",
		"type": "narrator",
		"text": "Незнайомка вирішила представитись Дарії, оскільки не знати ім’я своєї сусідки, доволі незручно."
	},
	{
		"id": "ch1_182",
		"chapter": 1,
		"bg": "08_classroom",
		"speaker": "Незнайомка",
		"type": "dialogue",
		"text": "Мене звати Меланія.",
		"left": "daria_main/daria_neutral",
		"right": "melania/melania_calm"
	},
	{
		"id": "ch1_183",
		"chapter": 1,
		"bg": "08_classroom",
		"speaker": "",
		"type": "narrator",
		"text": "Меланія дружно посміхнулась. Хоч її погляд говорив про твердість характеру, обличчя з усіх сил старалось бути милим."
	},
	{
		"id": "ch1_184",
		"chapter": 1,
		"bg": "08_classroom",
		"speaker": "Дарія",
		"type": "dialogue",
		"text": "Я Дарія. Приємно познайомитись. У тебе таке красиве ім'я.",
		"center": "daria_main/daria_smile"
	},
	{
		"id": "ch1_185",
		"chapter": 1,
		"bg": "08_classroom",
		"speaker": "",
		"type": "narrator",
		"text": "Радість від почутого простежувалась на тепер трохи ширше розтягнутих пухких губах."
	},
	{
		"id": "ch1_186",
		"chapter": 1,
		"bg": "08_classroom",
		"speaker": "Меланія",
		"type": "dialogue",
		"text": "Дякую, у тебе теж.",
		"left": "daria_main/daria_neutral",
		"right": "melania/melania_calm"
	},
	{
		"id": "ch1_187",
		"chapter": 1,
		"bg": "08_classroom",
		"speaker": "",
		"type": "narrator",
		"text": "Здавалось, Меланія хотіла сказати ще щось та її перервали. В аудиторію зайшла довгоочікувана викладачка."
	},
	{
		"id": "ch1_188",
		"chapter": 1,
		"bg": "08_classroom",
		"speaker": "",
		"type": "narrator",
		"text": "Напруга таки літала в повітрі. Напевно, якби зараз можна було доторкнутись до повітря руками, вдарило б струмом. Що ж тоді буде відбуватись на екзаменах? Всередині здавалось натягнулась тятива.."
	},
	{
		"id": "ch1_189",
		"chapter": 1,
		"bg": "08_classroom",
		"speaker": "",
		"type": "narrator",
		"text": "Проте неймовірно пощастило! Перша в житті пара розпочинається не зі строгості."
	},
	{
		"id": "ch1_190",
		"chapter": 1,
		"bg": "08_classroom",
		"speaker": "",
		"type": "narrator",
		"text": "Викладачка зайняла своє місце біля величезної кафедри до якої доведеться звикати першокурсникам. Новий атрибут в новій локації."
	},
	{
		"id": "ch1_191",
		"chapter": 1,
		"bg": "08_classroom",
		"speaker": "Лідія Іванівна",
		"type": "dialogue",
		"text": "Добрий день, мене звати Лідія Іванівна і я ваша викладачка з курсу «Дитячої літератури». До речі, не підкажете в котрій годині з'явиться кат? Судячи з ваших лиць, тут от-от відбудеться масова страта.",
		"left": "daria_main/daria_neutral",
		"right": "lidiya_ivanivna/lidiya_ivanivna_neutral"
	},
	{
		"id": "ch1_192",
		"chapter": 1,
		"bg": "08_classroom",
		"speaker": "",
		"type": "narrator",
		"text": "Аудиторію заполонив сміх. Студенти переглядались, намагаючись зрозуміти чи дійсно це виглядало так жахливо?"
	},
	{
		"id": "ch1_193",
		"chapter": 1,
		"bg": "08_classroom",
		"speaker": "Лідія Іванівна",
		"type": "dialogue",
		"text": "Перш за все хочу привітати вас всіх зі вступом до нашого університету. Ви обрали складну, але дуже важливу професію, особливо в наш час. Хто як не ми дбатиме про українську культуру? Бажаю, щоб ваша реалізація була успішною. Сподіваюся, допоможу з цим.",
		"left": "daria_main/daria_neutral",
		"right": "lidiya_ivanivna/lidiya_ivanivna_neutral"
	},
	{
		"id": "ch1_194",
		"chapter": 1,
		"bg": "08_classroom",
		"speaker": "",
		"type": "narrator",
		"text": "Ці слова гріли душу. З'являлась якась щира гордість за пройдені випробування. І ще скільки їх треба буде пройти! Та саме зараз, в цей момент, були лише вони і надія. Лише вони і ціль. Нічого зайвого. Кожен так ясно бачив свій шлях, не знаючи, що когось на ньому чекають спокуси залишити почате, труднощі, що виникають, здається, ні звідки. Це благословенна найсвітліша мить. Мить віри, яка закарбовується в пам'яті, недаючи впасти в скрутний час."
	},
	{
		"id": "ch1_195",
		"chapter": 1,
		"bg": "08_classroom",
		"speaker": "Лідія Іванівна",
		"type": "dialogue",
		"text": "Ще зовсім недавно ви й самі читали дитячу літературу, а тепер стикнетеся з її аналізом. Що ж, перш за все, хочу сказати, що ми з вами говоритимемо про тексти, які здаються на перший погляд простими. Їх часто вважають несерйозними, але в них криється величезна глибина, здатна торкнутись струн серця і дорослого. Пам’ятайте, що дитяча література – це фундамент майбутнього свідомого читача всієї літератури.",
		"left": "daria_main/daria_neutral",
		"right": "lidiya_ivanivna/lidiya_ivanivna_neutral"
	},
	{
		"id": "ch1_196",
		"chapter": 1,
		"bg": "08_classroom",
		"speaker": "",
		"type": "narrator",
		"text": "Викладачка витримала паузу, вдивляючись в лиця студентів. Потім продовжила більш звичним тоном."
	},
	{
		"id": "ch1_197",
		"chapter": 1,
		"bg": "08_classroom",
		"speaker": "Лідія Іванівна",
		"type": "dialogue",
		"text": "Маленькому читачеві не так просто догодити. Ну, можете розкривати свої неймовірно красиві зошити, які ціле літо чекали цього моменту та записати тему лекції.",
		"left": "daria_main/daria_neutral",
		"right": "lidiya_ivanivna/lidiya_ivanivna_neutral"
	},
	{
		"id": "ch1_198",
		"chapter": 1,
		"bg": "08_classroom",
		"speaker": "",
		"type": "narrator",
		"text": "Опісля Лідія Іванівна проговорила ще кілька зовсім незрозумілих для першокурсників робочих моментів. Вони старанно записували все, намагаючись розгадати, що ж таке криється під тими страшними словами як «семінар». Викладачка встигла сказати кілька назв творів, які їм необхідно буде аналізувати. І одна з них Дарії дуже не сподобалась.."
	},
	{
		"id": "ch1_199",
		"chapter": 1,
		"bg": "09_attic",
		"speaker": "",
		"type": "narrator",
		"text": "Її віднесло вітром спогадів у дитинство.",
		"transition": "fade"
	},
	{
		"id": "ch1_200",
		"chapter": 1,
		"bg": "09_attic",
		"speaker": "",
		"type": "narrator",
		"text": "Дарія сидить у своїй кімнаті на горищі. У руках тримає книжку, яку кілька днів тому взяла з бібліотеки. Вона без обкладинки, сторінки пожовклі, а кутики ледь зігнуті. Дівчинка знає, що до книг треба ставитися з шанобливістю та все ж їй подобається запах старих книг і думка про те, скільки людей з різними історіями тримало їх в своїх руках. На сторінку впав яскравий сонячний промінь, що пробивається крізь маленьке віконце. А згодом за ним на неї падає дитяча сльоза. Дарія закриває книжку, щоб не пошкодити текст. А опісля продовжує плакати. На столі самотньо залишився «Федько Халамидник».."
	},
	{
		"id": "ch1_201",
		"chapter": 1,
		"bg": "08_classroom",
		"speaker": "",
		"type": "narrator",
		"text": "Зі спогадів дівчину вирвав лагідний шепіт Меланії, що схилилась до її вуха.",
		"transition": "fade"
	},
	{
		"id": "ch1_202",
		"chapter": 1,
		"bg": "08_classroom",
		"speaker": "Меланія",
		"type": "dialogue",
		"text": "Не знаю як ти, а я не хочу «проживати» Халамидника знову.",
		"left": "daria_main/daria_neutral",
		"right": "melania/melania_calm"
	},
	{
		"id": "ch1_203",
		"chapter": 1,
		"bg": "08_classroom",
		"speaker": "Дарія",
		"type": "dialogue",
		"text": "О так, здається, це той самий випадок про який говорила викладачка: торкнеться і дорослого.",
		"center": "daria_main/daria_smile"
	},
	{
		"id": "ch1_204",
		"chapter": 1,
		"bg": "08_classroom",
		"speaker": "",
		"type": "narrator",
		"text": "Дарія зрозуміла, що цей курс точно сподобається. По-перше, за можливість повернутись до творів дитинства. Здається, ностальгія тепер буде частішим відчуттям. По-друге, аналізувати дитячу літературу їй видалось цікавим заняттям. Шукати приховані сенси там, де інші і не подумають. І, здається, з Меланією в Дарії є дещо спільне."
	},
	{
		"id": "ch1_205",
		"chapter": 1,
		"bg": "08_classroom",
		"speaker": "",
		"type": "narrator",
		"text": "Лідія Іванівна звернула увагу на реакцію студентів після почутої назви."
	},
	{
		"id": "ch1_206",
		"chapter": 1,
		"bg": "08_classroom",
		"speaker": "Лідія Іванівна",
		"type": "dialogue",
		"text": "Поспішаю вас засмутити, адже ті, хто плакали над Федьком, ймовірно, ще не раз заплачуть, готуючись до семінарів. Тобто під час прочитання інших схожих за темою творів. Але нічого, головне, щоб не на заліку.",
		"left": "daria_main/daria_neutral",
		"right": "lidiya_ivanivna/lidiya_ivanivna_neutral"
	},
	{
		"id": "ch1_207",
		"chapter": 1,
		"bg": "08_classroom",
		"speaker": "",
		"type": "narrator",
		"text": "Аудиторія знову сміється. Решта пари пройшла досить швидко за відчуттями, хоч Дарія і сподівалась на те, що спочатку буде досить важко звикнути до вдвічі довших “уроків”."
	},
	{
		"id": "ch1_208",
		"chapter": 1,
		"bg": "08_classroom",
		"speaker": "",
		"type": "narrator",
		"text": "Наступною парою була лекція з предмету «Вступ до мовознавства». Меланія запитала чи можна сісти поряд з Дарією знову. Дівчина"
	},
	{
		"id": "ch1_209",
		"chapter": 1,
		"bg": "08_classroom",
		"speaker": "",
		"type": "narrator",
		"text": "погодилась і обидві зрозуміли, що вклали угоду на цілий семестр. Лекція теж пройшла добре, але викликала легке приголомшення. Студенти виходили повільно, хоч і були раді, що навчання на сьогодні завершилось. Дарія виходила однією з останніх. В голові досі крутились якісь нові терміни: «фонема», «морфема». Це все здавалось таким важким.. Вона не знала, що буде робити, але була впевнена, що буде робити щось велике."
	},
	{
		"id": "ch1_210",
		"chapter": 1,
		"bg": "08_classroom",
		"speaker": "Дарія",
		"type": "thought",
		"text": "Мова – це система, а ми самі поки що в хаосі.",
		"center": "daria_main/daria_neutral"
	},
	{
		"id": "ch1_211",
		"chapter": 1,
		"bg": "11_restaurant_evening",
		"speaker": "",
		"type": "narrator",
		"text": "Надворі вся група зібралась знову. Ще раніше вирішили відсвяткувати початок навчання у найближчому ресторані.",
		"transition": "fade"
	},
	{
		"id": "ch1_212",
		"chapter": 1,
		"bg": "11_restaurant_evening",
		"speaker": "Марта",
		"type": "dialogue",
		"text": "Можливо, хтось знає якийсь заклад поруч?",
		"right": "marta/marta_smile"
	},
	{
		"id": "ch1_213",
		"chapter": 1,
		"bg": "11_restaurant_evening",
		"speaker": "Оксана",
		"type": "dialogue",
		"text": "Гугл карти в допомогу?",
		"right": "oksana/oksana_smile"
	},
	{
		"id": "ch1_214",
		"chapter": 1,
		"bg": "11_restaurant_evening",
		"speaker": "Меланія",
		"type": "dialogue",
		"text": "Здається, я бачила дорогою сюди поблизу піцерію. Ніхто не проти піци? Це ж пі-іца.",
		"left": "daria_main/daria_neutral",
		"right": "melania/melania_calm"
	},
	{
		"id": "ch1_215",
		"chapter": 1,
		"bg": "11_restaurant_evening",
		"speaker": "",
		"type": "narrator",
		"text": "Меланія розтягувала остання слово, ніби смакувала його самого. Всі, звичайно ж погодилися. Йти довелось недовго."
	},
	{
		"id": "ch1_216",
		"chapter": 1,
		"bg": "11_restaurant_evening",
		"speaker": "",
		"type": "narrator",
		"text": "Коли група зручно розмістилась в закладі та зробила замовлення, настала черга справжніх знайомств. Майже неформальних, більш відвертих, з можливістю поставити інтригуючі запитання. Першим, звісно, кортіло запитати звідки родом одногрупники. Таким чином Дарія дізналася, що Меланія не місцева, родом дівчина з Рівного. Наступне запитання було не менш стандартним, але важливим для того, щоб дізнатись більше одне про одного: чому саме філологія?"
	},
	{
		"id": "ch1_217",
		"chapter": 1,
		"bg": "11_restaurant_evening",
		"speaker": "",
		"type": "narrator",
		"text": "Дарія зверталась до цієї теми не вперше. Коли настала її черга для відповіді, вона впевнено сказала те, що знала давно."
	},
	{
		"id": "ch1_218",
		"chapter": 1,
		"bg": "11_restaurant_evening",
		"speaker": "Дарія",
		"type": "dialogue",
		"text": "Я тут, бо дуже люблю українську літературу. Бо відчуваю зв’язок з предками, спілкуючись рідною мовою. Я маю мету зберегти традиції і примножити здобутки культури.",
		"center": "daria_main/daria_smile"
	},
	{
		"id": "ch1_219",
		"chapter": 1,
		"bg": "11_restaurant_evening",
		"speaker": "",
		"type": "narrator",
		"text": "Після слів Дарії за столом зависла кількасекундна, проте дуже помітна, тиша."
	},
	{
		"id": "ch1_220",
		"chapter": 1,
		"bg": "11_restaurant_evening",
		"speaker": "Оксана",
		"type": "dialogue",
		"text": "Ого, вау..",
		"right": "oksana/oksana_smile"
	},
	{
		"id": "ch1_221",
		"chapter": 1,
		"bg": "11_restaurant_evening",
		"speaker": "Марта",
		"type": "dialogue",
		"text": "Неймовірно гарно сказано. Я впевнена, що в тебе все вийде.",
		"right": "marta/marta_smile"
	},
	{
		"id": "ch1_222",
		"chapter": 1,
		"bg": "11_restaurant_evening",
		"speaker": "",
		"type": "narrator",
		"text": "Вона не хотіла приголомшити всіх. Не хотіла пафосних промов. Боялась, що скаже щось надто гучне. Та всі зрозуміли. І це було приємно."
	},
	{
		"id": "ch1_223",
		"chapter": 1,
		"bg": "11_restaurant_evening",
		"speaker": "",
		"type": "narrator",
		"text": "За цей час встигли принести замовлення. Запах свіжого тіста, розплавленого сиру і базиліку донісся навіть раніше за подачу. Хтось взявся одразу фотографувати: таке треба зберегти напам'ять. Хтось просто мовчки чекав, коли ж можна буде взяти. Згодом всі дружно жували і розмови трохи припинились. Пізніше студенти продовжили незавершену тему. Настала черга Меланії."
	},
	{
		"id": "ch1_224",
		"chapter": 1,
		"bg": "11_restaurant_evening",
		"speaker": "Меланія",
		"type": "dialogue",
		"text": "Я завжди любила літературу. Мистецтво слова для мене це щось особливе, рідне моєму серцю і душі. Вибір філології дався мені непросто та я впевнена, що не пошкодую.",
		"left": "daria_main/daria_neutral",
		"right": "melania/melania_calm"
	},
	{
		"id": "ch1_225",
		"chapter": 1,
		"bg": "11_restaurant_evening",
		"speaker": "",
		"type": "narrator",
		"text": "Останні слова були сказані трохи голосніше. В них відчувалась сталева рішучість, що не змогла б когось залишити без переконання."
	},
	{
		"id": "ch1_226",
		"chapter": 1,
		"bg": "11_restaurant_evening",
		"speaker": "Дарія",
		"type": "thought",
		"text": "Здається, вона говорить таке не вперше. І що означає «вибір дався важко?». Можливо, Меланія сумнівалася між певними спеціальностями.",
		"center": "daria_main/daria_neutral"
	},
	{
		"id": "ch1_227",
		"chapter": 1,
		"bg": "11_restaurant_evening",
		"speaker": "",
		"type": "system",
		"text": "Згодом Ви зможете дізнатися більше про минуле Меланії."
	},
	{
		"id": "ch1_228",
		"chapter": 1,
		"bg": "11_restaurant_evening",
		"speaker": "",
		"type": "narrator",
		"text": "Дарія не знала чому, але її зачепила така яскрава особистість. Сусідка по парті мала вольову енергетику. Судячи з того, як вільно зараз почувалася Меланія серед незнайомих людей, як легко висловлювала свою думку, була впевненою. Дарія не сумнівалася, що дівчина виявить такі риси характеру як стійкість і цілеспрямованість. Їй подобались схожі люди, адже вони мали те, чого бракувало їй самій."
	},
	{
		"id": "ch1_229",
		"chapter": 1,
		"bg": "11_restaurant_evening",
		"speaker": "",
		"type": "narrator",
		"text": "Залишок святкування пройшов за теплими розмовами про своє життя до університету та планами на найближче майбутнє. Теми змінювались досить часто: від «як важко в школі було вчити напам'ять «Енеїду»» до «я встигла загубитись в місті першого ж дня». Стало по-домашньому затишно. Вони були ще незнайомі та тепер знали одне про одного бодай щось. А отже були не чужі. Їм ще прийдеться навчитись бути справжньою командою. За вікном поволі згасали барви яскравого дня, а з тарілок давно зникла їжа."
	},
	{
		"id": "ch1_230",
		"chapter": 1,
		"bg": "03_dormitory_exterior_evening",
		"speaker": "",
		"type": "narrator",
		"text": "Виявилось, що Меланії та Дарії потрібно прямувати в одному і тому ж напрямку, тому дівчата рушили додому разом.",
		"transition": "fade"
	},
	{
		"id": "ch1_231",
		"chapter": 1,
		"bg": "03_dormitory_exterior_evening",
		"speaker": "",
		"type": "narrator",
		"text": "Вони йшли не поспішаючи, смакуючи момент, ніби розтягували мить, коли доведеться прощатись. Меланія порушила мовчанку."
	},
	{
		"id": "ch1_232",
		"chapter": 1,
		"bg": "03_dormitory_exterior_evening",
		"speaker": "Меланія",
		"type": "dialogue",
		"text": "Як тобі наш перший день?",
		"left": "daria_main/daria_neutral",
		"right": "melania/melania_calm"
	},
	{
		"id": "ch1_233",
		"chapter": 1,
		"bg": "03_dormitory_exterior_evening",
		"speaker": "Дарія",
		"type": "dialogue",
		"text": "Я гадала, буде гірше.",
		"center": "daria_main/daria_smile"
	},
	{
		"id": "ch1_234",
		"chapter": 1,
		"bg": "03_dormitory_exterior_evening",
		"speaker": "Меланія",
		"type": "dialogue",
		"text": "І я, мало статись щось страшне.",
		"left": "daria_main/daria_neutral",
		"right": "melania/melania_calm"
	},
	{
		"id": "ch1_235",
		"chapter": 1,
		"bg": "03_dormitory_exterior_evening",
		"speaker": "",
		"type": "narrator",
		"text": "Обидві тихо засміялись."
	},
	{
		"id": "ch1_236",
		"chapter": 1,
		"bg": "03_dormitory_exterior_evening",
		"speaker": "Меланія",
		"type": "dialogue",
		"text": "Знаєш, сказане тобою сьогодні зачепило мене. Не в поганому сенсі. Мова, культура, предки. Це так важливо. І я бачу, що ти це справді відчуваєш.",
		"left": "daria_main/daria_neutral",
		"right": "melania/melania_calm"
	},
	{
		"id": "ch1_237",
		"chapter": 1,
		"bg": "03_dormitory_exterior_evening",
		"speaker": "",
		"type": "narrator",
		"text": "Дарія мовчить, бо не знаходить правильних слів. Вона чує в цьому повагу, а не насмішку чи можливість просто зблизитись. Дівчина знала співрозмовницю лише один неповний день та десь в глибині душі відчувала, що Меланія не часто таке каже. Вона була їй вдячна."
	},
	{
		"id": "ch1_238",
		"chapter": 1,
		"bg": "03_dormitory_exterior_evening",
		"speaker": "",
		"type": "narrator",
		"text": "В полі зору з’явилась химерна будівля гуртожитку. Вони зупинились. З’явилась тиша, яка не була дискомфортною. Навпаки – хотілось простояти так довше, ніж потрібно. Врешті-решт, Дарія промовила."
	},
	{
		"id": "ch1_239",
		"chapter": 1,
		"bg": "03_dormitory_exterior_evening",
		"speaker": "Дарія",
		"type": "dialogue",
		"text": "То до завтра?",
		"center": "daria_main/daria_smile"
	},
	{
		"id": "ch1_240",
		"chapter": 1,
		"bg": "03_dormitory_exterior_evening",
		"speaker": "Меланія",
		"type": "dialogue",
		"text": "Так, до завтра.",
		"left": "daria_main/daria_neutral",
		"right": "melania/melania_calm"
	},
	{
		"id": "ch1_241",
		"chapter": 1,
		"bg": "03_dormitory_exterior_evening",
		"speaker": "Дарія",
		"type": "dialogue",
		"text": "Дякую за чудовий день.",
		"center": "daria_main/daria_smile"
	},
	{
		"id": "ch1_242",
		"chapter": 1,
		"bg": "03_dormitory_exterior_evening",
		"speaker": "Меланія",
		"type": "dialogue",
		"text": "І тобі. Сподіваюся, завтрашній буде не менш захопливим.",
		"left": "daria_main/daria_neutral",
		"right": "melania/melania_calm"
	},
	{
		"id": "ch1_summary",
		"chapter": 1,
		"bg": "03_dormitory_exterior_evening",
		"type": "summary",
		"summary_title": "Розділ 1 завершено",
		"summary_lines": [
			"Дарія приїхала до гуртожитку, познайомилась із сусідками та групою.",
			"Перший день приніс нові знайомства, перші вибори й розмову з Меланією."
		],
		"continue_label": "Продовжити розділ 2",
		"continue_target": "ch2_001",
		"save_label": "Зберегти"
	}
]
