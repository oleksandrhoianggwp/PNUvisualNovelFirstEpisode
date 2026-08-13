extends RefCounted

const START_ID := "ch2_001"

const CHAPTER_2_DIALOGUES: Array = [
	{
		"id": "ch2_001",
		"chapter": 2,
		"bg": "01_09_room_morning",
		"speaker": "Дарія",
		"type": "thought",
		"text": "Проспала.",
		"center": "daria_main/daria_neutral",
		"transition": "fade"
	},
	{
		"id": "ch2_002",
		"chapter": 2,
		"bg": "01_09_room_morning",
		"speaker": "",
		"type": "narrator",
		"text": "Подумала Дарія і миттю вилізла з-під теплої ковдрі. Ранок наступного дня почався не так як хотілось. Ймовірно через те, що вчора вдалось отримати море емоцій, її сон був міцним. Вона не почула мелодії першого будильника, тож зараз стурбовано поспішала на пари. На ходу, одночасно допиваючи чашку ароматної кави, Дарія попрощалась з сусідками в думках гадаючи чи зможуть вони колись змусити її прокинутися, якщо вона не почує жоден з дзвінків."
	},
	{
		"id": "ch2_003",
		"chapter": 2,
		"bg": "01_09_room_morning",
		"speaker": "Дарія",
		"type": "thought",
		"text": "Хотілося б вірити, що так.",
		"center": "daria_main/daria_neutral"
	},
	{
		"id": "ch2_004",
		"chapter": 2,
		"bg": "01_09_room_morning",
		"speaker": "",
		"type": "narrator",
		"text": "Принаймні вона сама була готова надати їм свій голос допомоги замість будильника, якщо знадобиться. Втім краще було все ж не допускати таких ситуацій."
	},
	{
		"id": "ch2_005",
		"chapter": 2,
		"bg": "02_01_university_corridor",
		"speaker": "",
		"type": "narrator",
		"text": "Біля корпусу її зустріла чимала черга до входу і Дарія одразу збагнула всі мінуси пізнього приходу до університету.",
		"transition": "fade"
	},
	{
		"id": "ch2_006",
		"chapter": 2,
		"bg": "02_01_university_corridor",
		"speaker": "Дарія",
		"type": "thought",
		"text": "Хто рано встає, той проходить двері без бою.",
		"center": "daria_main/daria_neutral"
	},
	{
		"id": "ch2_007",
		"chapter": 2,
		"bg": "02_01_university_corridor",
		"speaker": "",
		"type": "narrator",
		"text": "Нарешті вдалось зайти і дівчина засмучено глянула на стрілки годинника, які підказували їй, що врешті-решт вона таки неминуче спізниться. Залишилось сподіватись, що викладач спізниться теж. Все ж, Дарії це страшенно не подобалось."
	},
	{
		"id": "ch2_008",
		"chapter": 2,
		"bg": "02_01_university_corridor",
		"speaker": "Дарія",
		"type": "thought",
		"text": "Перша пара і така лажа!",
		"center": "daria_main/daria_neutral"
	},
	{
		"id": "ch2_009",
		"chapter": 2,
		"bg": "02_01_university_corridor",
		"speaker": "",
		"type": "narrator",
		"text": "Вона неслась сходами, картаючи себе за цю невеличку невдачу. Серце шалено билося в грудях, подих перехоплювало, а Дарія змагалась з часом, вперто продовжувала рухатися далі. Аж тут хтось вигукнув її ім'я.",
		"transition": "fade"
	},
	{
		"id": "ch2_010",
		"chapter": 2,
		"bg": "02_01_university_corridor",
		"speaker": "Дарія",
		"type": "thought",
		"text": "Можливо, почулось.",
		"center": "daria_main/daria_neutral"
	},
	{
		"id": "ch2_011",
		"chapter": 2,
		"bg": "02_01_university_corridor",
		"speaker": "",
		"type": "narrator",
		"text": "Та це повторилось і, повернувшись, Дарія побачила почервонілу Меланію, що летіла стрімголов до неї."
	},
	{
		"id": "ch2_012",
		"chapter": 2,
		"bg": "02_01_university_corridor",
		"speaker": "Меланія",
		"type": "dialogue",
		"text": "Яке щастя, сьогодні я не одна така.",
		"left": "daria_main/daria_neutral",
		"right": "melania/melania_smile"
	},
	{
		"id": "ch2_013",
		"chapter": 2,
		"bg": "02_01_university_corridor",
		"speaker": "",
		"type": "narrator",
		"text": "Вона посміхнулась, продовжуючи важко дихати."
	},
	{
		"id": "ch2_014",
		"chapter": 2,
		"bg": "02_01_university_corridor",
		"speaker": "Дарія",
		"type": "dialogue",
		"text": "Гадаю, запізнення стане твоєю традицією?",
		"center": "daria_main/daria_smile"
	},
	{
		"id": "ch2_015",
		"chapter": 2,
		"bg": "02_01_university_corridor",
		"speaker": "",
		"type": "narrator",
		"text": "Меланія зробила серйозний вираз обличчя, дещо припідняла голову."
	},
	{
		"id": "ch2_016",
		"chapter": 2,
		"bg": "02_01_university_corridor",
		"speaker": "Меланія",
		"type": "dialogue",
		"text": "Таке більше не повториться, Дарія Батьківна.",
		"left": "daria_main/daria_neutral",
		"right": "melania/melania_smile"
	},
	{
		"id": "ch2_017",
		"chapter": 2,
		"bg": "02_01_university_corridor",
		"speaker": "",
		"type": "narrator",
		"text": "Дарію повеселила відповідь."
	},
	{
		"id": "ch2_018",
		"chapter": 2,
		"bg": "02_01_university_corridor",
		"speaker": "Дарія",
		"type": "dialogue",
		"text": "О, я покладаю на Вас надії, Меланіє.",
		"center": "daria_main/daria_smile"
	},
	{
		"id": "ch2_019",
		"chapter": 2,
		"bg": "02_01_university_corridor",
		"speaker": "Меланія",
		"type": "dialogue",
		"text": "Не думаю, що нас вб’ють одразу. Пізніше, звісно, цілком можливо.",
		"left": "daria_main/daria_neutral",
		"right": "melania/melania_smile"
	},
	{
		"id": "ch2_020",
		"chapter": 2,
		"bg": "02_01_university_corridor",
		"speaker": "Дарія",
		"type": "dialogue",
		"text": "Ти дуже оптимістична.",
		"center": "daria_main/daria_smile"
	},
	{
		"id": "ch2_021",
		"chapter": 2,
		"bg": "02_01_university_corridor",
		"speaker": "Меланія",
		"type": "dialogue",
		"text": "Реалістична.",
		"left": "daria_main/daria_neutral",
		"right": "melania/melania_smile"
	},
	{
		"id": "ch2_022",
		"chapter": 2,
		"bg": "02_01_university_corridor",
		"speaker": "",
		"type": "narrator",
		"text": "Дівчата нарешті знайшли потрібну аудиторію. Наважилась зайти першою, вже звично, Меланія."
	},
	{
		"id": "ch2_023",
		"chapter": 2,
		"bg": "02_02_classroom_02",
		"speaker": "",
		"type": "narrator",
		"text": "Вона зібралась з духом, вдихнула та видихнула, перш, ніж постукати. Відчинивши двері, вони обидві побачили те, що сподівались не бачити в ту хвилину: Олена Сергіївна дивилася просто їм у вічі.",
		"transition": "fade"
	},
	{
		"id": "ch2_024",
		"chapter": 2,
		"bg": "02_02_classroom_02",
		"speaker": "",
		"type": "narrator",
		"text": "Меланія пошепки звернулась до Дарії."
	},
	{
		"id": "ch2_025",
		"chapter": 2,
		"bg": "02_02_classroom_02",
		"speaker": "Меланія",
		"type": "dialogue",
		"text": "Що ж, не пощастило. Може хоч вільні місця знайдуться..",
		"left": "daria_main/daria_neutral",
		"right": "melania/melania_serious"
	},
	{
		"id": "ch2_026",
		"chapter": 2,
		"bg": "02_02_classroom_02",
		"speaker": "",
		"type": "narrator",
		"text": "Дарія відверто боялась наступних слів викладачки, невідомо як вона ставиться до запізнень. Та Меланія уже переступила поріг аудиторії, тому"
	},
	{
		"id": "ch2_027",
		"chapter": 2,
		"bg": "02_02_classroom_02",
		"speaker": "",
		"type": "narrator",
		"text": "довелось тільки покладатись таки на те, що першого разу вони можуть обійтись меншим «виговором»."
	},
	{
		"id": "ch2_028",
		"chapter": 2,
		"bg": "02_02_classroom_02",
		"speaker": "Меланія",
		"type": "dialogue",
		"text": "Вибачте, будь ласка, за спізнення.",
		"left": "daria_main/daria_neutral",
		"right": "melania/melania_serious"
	},
	{
		"id": "ch2_029",
		"chapter": 2,
		"bg": "02_02_classroom_02",
		"speaker": "Олена Сергіївна",
		"type": "dialogue",
		"text": "Нічого, мої хороші, знайдіть вільні місця і розпочнемо.",
		"left": "daria_main/daria_neutral",
		"right": "olena_serhiivna/olena_serhiivna_smile"
	},
	{
		"id": "ch2_030",
		"chapter": 2,
		"bg": "02_02_classroom_02",
		"speaker": "",
		"type": "narrator",
		"text": "Дівчата вже полегшено видихнули."
	},
	{
		"id": "ch2_031",
		"chapter": 2,
		"bg": "02_02_classroom_02",
		"speaker": "Олена Сергіївна",
		"type": "dialogue",
		"text": "Bude čeština.",
		"left": "daria_main/daria_neutral",
		"right": "olena_serhiivna/olena_serhiivna_neutral"
	},
	{
		"id": "ch2_032",
		"chapter": 2,
		"bg": "02_02_classroom_02",
		"speaker": "",
		"type": "narrator",
		"text": "Спокій як рукою зняло. Що тільки що було сказано? Невже вони помилились аудиторією?"
	},
	{
		"id": "ch2_033",
		"chapter": 2,
		"bg": "02_02_classroom_02",
		"speaker": "Дарія",
		"type": "thought",
		"text": "Я ж перевірила перед виходом розклад.. Боже, як соромно!",
		"center": "daria_main/daria_neutral"
	},
	{
		"id": "ch2_034",
		"chapter": 2,
		"bg": "02_02_classroom_02",
		"speaker": "",
		"type": "narrator",
		"text": "Дарію покрив непроханий рум’янець. Вона мовчки опустила погляд додолу. Меланія навпаки ж побіжно оглянула студентів, що сиділи в аудиторії. Серед них частина були незнайомцями."
	},
	{
		"id": "ch2_035",
		"chapter": 2,
		"bg": "02_02_classroom_02",
		"speaker": "Меланія",
		"type": "dialogue",
		"text": "Вибачте ще раз, ми, напевно, поми..",
		"left": "daria_main/daria_neutral",
		"right": "melania/melania_serious"
	},
	{
		"id": "ch2_036",
		"chapter": 2,
		"bg": "02_02_classroom_02",
		"speaker": "",
		"type": "narrator",
		"text": "Упізнавши одногрупницю, а потім знайшовши поглядом усю свою групу, Меланія зупинилась, глянувши на викладачку з відвертим нерозумінням того, що відбувається."
	},
	{
		"id": "ch2_037",
		"chapter": 2,
		"bg": "02_02_classroom_02",
		"speaker": "Олена Сергіївна",
		"type": "dialogue",
		"text": "А тепер вибачте ви мене, бо я пожартувала. Проте ваша реакція цього вартувала.",
		"left": "daria_main/daria_neutral",
		"right": "olena_serhiivna/olena_serhiivna_smile"
	},
	{
		"id": "ch2_038",
		"chapter": 2,
		"bg": "02_02_classroom_02",
		"speaker": "",
		"type": "narrator",
		"text": "Дарія зі своєю тривожністю неймовірних масштабів пережила усі можливі спектри негативних емоцій всього лише за хвилину. Меланія здавалась здивованою, але не наляканою. Тож і швидко оговталась навіть жартуючи."
	},
	{
		"id": "ch2_039",
		"chapter": 2,
		"bg": "02_02_classroom_02",
		"speaker": "Меланія",
		"type": "dialogue",
		"text": "Та я залюбки і чеську послухала б.",
		"left": "daria_main/daria_neutral",
		"right": "melania/melania_serious"
	},
	{
		"id": "ch2_040",
		"chapter": 2,
		"bg": "02_02_classroom_02",
		"speaker": "Олена Сергіївна",
		"type": "dialogue",
		"text": "У Вас ще буде можливість це зробити на старших курсах.",
		"left": "daria_main/daria_neutral",
		"right": "olena_serhiivna/olena_serhiivna_neutral"
	},
	{
		"id": "ch2_041",
		"chapter": 2,
		"bg": "02_02_classroom_02",
		"speaker": "",
		"type": "narrator",
		"text": "Місць залишилось небагато, проте їх наявність уже змушували радіти. Дисципліна, з якою вони сьогодні познайомилися, називалась «Вступ до слов’янської філології». Сама назва абсолютно нічого не говорила більшості студентів. Вступна лекція прояснила все, хоч натомість і збільшила кількість питань. Дарія відмітила для себе, що найбільш вірогідно, їй буде складно, оскільки цей предмет був пов'язаний з іншими слов'янськими мовами. Незнайомці на лекції виявились студентами, що вивчали ці мови. Для українських філологів ж це видавалось, принаймні зараз, важко. Ускладнювалося все тим, що предмет торкався мов не безпосередньо в сучасному вигляді, а пояснював цей сучасний вигляд законами з минулого. Дарія навіть не уявляла скільки всього сталось, щоб слова стали такими. Це викликало величезний інтерес. Звісно, першокурсниця вирішила зробити все можливе, аби дійсно добре вчити такі складні теми."
	},
	{
		"id": "ch2_042",
		"chapter": 2,
		"bg": "02_02_classroom_02",
		"speaker": "Дарія",
		"type": "thought",
		"text": "А хто сказав, що мова це легко.",
		"center": "daria_main/daria_neutral"
	},
	{
		"id": "ch2_043",
		"chapter": 2,
		"bg": "02_02_classroom_02",
		"speaker": "",
		"type": "narrator",
		"text": "Меланії найбільше запам'ятались слова викладачки."
	},
	{
		"id": "ch2_044",
		"chapter": 2,
		"bg": "02_02_classroom_02",
		"speaker": "Меланія",
		"type": "dialogue",
		"text": "Мова така ж точна наука як і математика. Можна вважати, що ми проміняли шило на мило?",
		"left": "daria_main/daria_neutral",
		"right": "melania/melania_serious"
	},
	{
		"id": "ch2_045",
		"chapter": 2,
		"bg": "02_02_classroom_02",
		"speaker": "Дарія",
		"type": "dialogue",
		"text": "Мел, хаха, для мене це однозначно найкращий варіант.",
		"center": "daria_main/daria_smile"
	},
	{
		"id": "ch2_046",
		"chapter": 2,
		"bg": "02_02_classroom_02",
		"speaker": "",
		"type": "narrator",
		"text": "Наступною парою була дисципліна «Вступ до літературознавства». Можливо, хтось і гадав, що це буде звичайна література, але певна річ, це виявилось хибним уявленням. Дарія перебувала у приємному враженні від прослуханої лекції. Вона завжди любила книги, шукала для себе сенси в текстах та не могла уявити скільки їх насправді: прихованих і явних. Символи, структури, контексти.. Читати поміж рядків, проживати."
	},
	{
		"id": "ch2_047",
		"chapter": 2,
		"bg": "02_02_classroom_02",
		"speaker": "Дарія",
		"type": "thought",
		"text": "Тепер я бачитиму перед собою не просто історію, а пульс епохи, сліди почуттів, шифр реальності у нереальному. Кожне речення – ключ. Моментами звучить страшно, так глибоко замислюватись. Та я навчуся тут не тільки читати текст, а й чути його.",
		"center": "daria_main/daria_neutral"
	},
	{
		"id": "ch2_048",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "",
		"type": "narrator",
		"text": "Після пар студентів-першокурсників очікувала екскурсія. Марта повідомила завчасно місце для зібрання: спочатку в холі, потім мали разом попрямувати в актовий зал. Було трохи хвилююче, але цікавість перемагала в цьому випадку будь-яку тривогу. Дарія йшла поруч з Меланією.",
		"transition": "fade"
	},
	{
		"id": "ch2_049",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "",
		"type": "narrator",
		"text": "Коли група увійшла до залу, вони були не одні. Він виявився доволі великим, з оксамитовими сидіннями, обладнений потрібним для проведення тут заходів світлом і неймовірно просторою сценою."
	},
	{
		"id": "ch2_050",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "Меланія",
		"type": "dialogue",
		"text": "Масштабно..",
		"left": "daria_main/daria_neutral",
		"right": "melania/melania_serious"
	},
	{
		"id": "ch2_051",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "Оксана",
		"type": "dialogue",
		"text": "Вражаюче, еге ж? Не терпиться тут виступити!",
		"left": "daria_main/daria_neutral",
		"right": "oksana/oksana_emotional"
	},
	{
		"id": "ch2_052",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "",
		"type": "narrator",
		"text": "Повітря пахло сотнями історій. Уявлялись вечори, де хтось вперше декламував вірші, хтось переборював їдкий страх сцени. Їх обов'язково підтримували посмішки з-за куліс або турботливі захопливі погляди з залу. На сцені в кутку стояло елегантне фортепіано. Скільки нервових репетицій, неочікуваних імпровізацій торкалось його струн. Здавалось, саме в цьому актовому залі живе добрий дух університету – той, що зберігає найтепліші моменти: гучні овації, щирі привітання, перші спроби заявити про себе, говорити щось справжнє вголос."
	},
	{
		"id": "ch2_053",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "",
		"type": "narrator",
		"text": "До зали продовжували приходити студенти."
	},
	{
		"id": "ch2_054",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "Дарія",
		"type": "dialogue",
		"text": "Не думала, що нас так багато.",
		"center": "daria_main/daria_smile"
	},
	{
		"id": "ch2_055",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "Марта",
		"type": "dialogue",
		"text": "Впевнена, що це ще не всі.",
		"left": "daria_main/daria_neutral",
		"right": "marta/marta_smile"
	},
	{
		"id": "ch2_056",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "",
		"type": "narrator",
		"text": "Деяких студентів вони вже знали, адже мали спільну лекцію. Проте більшість залишались незнайомими. У приміщення ввійшла група попереду якої прямував високий чорнявий хлопець. В ходí простежувалась рішуча впевненість. Та не тільки він привертав увагу. Збоку бадьоро крокувала рудоволоса дівчина, чия харизма відчувалась навіть за таку відстань. Вони зайняли місця в ряду вище."
	},
	{
		"id": "ch2_057",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "Меланія",
		"type": "dialogue",
		"text": "Хто це?",
		"left": "daria_main/daria_neutral",
		"right": "melania/melania_serious"
	},
	{
		"id": "ch2_058",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "Дарія",
		"type": "dialogue",
		"text": "Люди.",
		"center": "daria_main/daria_smile"
	},
	{
		"id": "ch2_059",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "Меланія",
		"type": "dialogue",
		"text": "Дотепно, Даріє.",
		"left": "daria_main/daria_neutral",
		"right": "melania/melania_playful"
	},
	{
		"id": "ch2_060",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "Марта",
		"type": "dialogue",
		"text": "Журналісти. Цей хлопець їхній староста.",
		"left": "daria_main/daria_neutral",
		"right": "marta/marta_neutral"
	},
	{
		"id": "ch2_061",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "",
		"type": "narrator",
		"text": "Меланія не приховуючи цікавості повернулась, щоб глянути які місця вони зайняли."
	},
	{
		"id": "ch2_062",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "Меланія",
		"type": "dialogue",
		"text": "А можна якось перевестись до журналістів?",
		"left": "daria_main/daria_neutral",
		"right": "melania/melania_playful"
	},
	{
		"id": "ch2_063",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "Марта",
		"type": "dialogue",
		"text": "Ти можеш бути журналістом, маючи освіту філолога.",
		"left": "daria_main/daria_neutral",
		"right": "marta/marta_smile"
	},
	{
		"id": "ch2_064",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "",
		"type": "narrator",
		"text": "Дарія з Оксаною переглянулись ледь стримуючи сміх."
	},
	{
		"id": "ch2_065",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "Оксана",
		"type": "dialogue",
		"text": "Марто, здається, ти не зрозуміла..",
		"left": "daria_main/daria_neutral",
		"right": "oksana/oksana_emotional"
	},
	{
		"id": "ch2_066",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "Марта",
		"type": "dialogue",
		"text": "Що?..",
		"left": "daria_main/daria_neutral",
		"right": "marta/marta_neutral"
	},
	{
		"id": "ch2_067",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "",
		"type": "narrator",
		"text": "Дівчина здогадалась не одразу."
	},
	{
		"id": "ch2_068",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "Марта",
		"type": "dialogue",
		"text": "Треба перестати бути такою серйозною.",
		"left": "daria_main/daria_neutral",
		"right": "marta/marta_smile"
	},
	{
		"id": "ch2_069",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "Меланія",
		"type": "dialogue",
		"text": "Так, однозначно.",
		"left": "daria_main/daria_neutral",
		"right": "melania/melania_playful"
	},
	{
		"id": "ch2_070",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "",
		"type": "narrator",
		"text": "В приміщенні стало доволі гучно. Багато студентів знайомились, інші продовжували розмови з уже знайомими їм людьми."
	},
	{
		"id": "ch2_071",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "",
		"type": "narrator",
		"text": "Нарешті на сцену вийшли куратори, які сьогодні слугували екскурсоводами."
	},
	{
		"id": "ch2_072",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "Лідія Іванівна",
		"type": "dialogue",
		"text": "Ми раді вітати вас всіх у стінах нашого університету і вдячні вам за цей вибір. Сьогодні ви познайомитесь більше з корпусом в якому проведете чудових як мінімум чотири роки. Але спочатку звернемось до історії закладу.",
		"left": "daria_main/daria_neutral",
		"right": "lidiya_ivanivna/LydiaIvanovna_Smile"
	},
	{
		"id": "ch2_073",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "",
		"type": "system",
		"text": "Більшість інформації, що міститься в цьому розділі є правдивою. Перевірити її можете за допомогою джерел в інтернеті або відвідавши наш університет."
	},
	{
		"id": "ch2_074",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "",
		"type": "narrator",
		"text": "Вступна частина була захопливою. Першокурсники дізнались багато нової інформації. Меланія твердила, що пишається мати можливість навчатись у одному з найкращих університетів України, це підтверджували офіційні рейтинги, Оксану привабив дендропарк і вона поставила собі за мету відвідати його, Дарію ж вразила обсерваторія на горі Піп Іван."
	},
	{
		"id": "ch2_075",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "",
		"type": "narrator",
		"text": "Коли з теоретичною частиною було покінчено, усіх першокурсників розділили на підгрупи, змішуючи різні спеціальності. Така пропозиція видалась дійсно оригінальною, адже дозволить познайомитись більшій частині студентів. У одну з таких підгруп потрапили Дарія, Меланія і Оксана зі сторони філологів. До них доєднались двоє студентів зі спеціальності «Середня освіта. Українська мова та література»."
	},
	{
		"id": "ch2_076",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "",
		"type": "narrator",
		"text": "Цікаво те, що обоє були дуже схожі між собою. Дівчина мала волосся кольору світлої пшениці, що обрамлювало обличчя ніжними пасмами. Ідеальна симетрія, небесно-сірі з блакитним відблиском очі. Все в ній говорило про витонченість і спокій. Вона представилась."
	},
	{
		"id": "ch2_077",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "Віра",
		"type": "dialogue",
		"text": "Привіт, я Віра.",
		"left": "daria_main/daria_neutral",
		"right": "vira/vira_shy"
	},
	{
		"id": "ch2_078",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "",
		"type": "narrator",
		"text": "За нею слідом так само вчинив і її одногрупник."
	},
	{
		"id": "ch2_079",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "Лука",
		"type": "dialogue",
		"text": "А я Лука.",
		"left": "daria_main/daria_neutral",
		"right": "luka/luka_smile"
	},
	{
		"id": "ch2_080",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "",
		"type": "narrator",
		"text": "Його обличчя одразу прикрасила сяйлива посмішка. Він впевнено, але ненав’язливо, простягнув руку для рукостискання. Волосся золотисто-попелястого відтінку незграбно спадало на лоба. Його погляд – чиста відкритість без граму страху."
	},
	{
		"id": "ch2_081",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "",
		"type": "narrator",
		"text": "Як привітатись із Вірою та Лукою?",
		"choices": [
			{
				"text": "Привітатись більш стримано",
				"target": "ch2_084",
				"effects": {
					"vira": -1,
					"luka": -1
				}
			},
			{
				"text": "Привітатись більш емоційно",
				"target": "ch2_087",
				"effects": {
					"vira": 1,
					"luka": 1
				}
			}
		]
	},
	{
		"id": "ch2_084",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "",
		"type": "narrator",
		"text": "Дарія стримано потиснула руку, кивнула головою і представилась. Судячи з реакцій, Віра та Лука очікували чогось більш емоційно відкритого через що стали відчувати себе помітно скуто. Їхні постаті зіщулились, плечі підтягнулись вгору, ніби захищаючись від невидимого тиску. Здавалось, тепер вони будуть стежити за кожним своїм рухом та словом, бо це може виявитись зайвим. Всередині щось замкнулось."
	},
	{
		"id": "ch2_085",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "",
		"type": "system",
		"text": "Зроблений вибір вплинув на поведінку Віри і Луки з Дарією в майбутньому.",
		"target": "ch2_092"
	},
	{
		"id": "ch2_087",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "",
		"type": "narrator",
		"text": "Дарія простягнула руку з якоюсь дитячою радістю, що не вимагала жодних слів."
	},
	{
		"id": "ch2_088",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "Дарія",
		"type": "dialogue",
		"text": "А мене звати Дарія.",
		"center": "daria_main/daria_smile"
	},
	{
		"id": "ch2_089",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "",
		"type": "narrator",
		"text": "Віра з Лукою переглянулись з посмішкою, що певно, означало щось на кшталт «ми щойно заручились ще одним класним знайомством, круто ж?». Мовчання видалось навіть повнішим, ніби сходинкою, яку вони подолають от-от, відкривши для себе горизонти секретів нових особистостей."
	},
	{
		"id": "ch2_090",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "",
		"type": "system",
		"text": "Зроблений вибір вплинув на поведінку Віри і Луки з Дарією в майбутньому.",
		"target": "ch2_092"
	},
	{
		"id": "ch2_092",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "",
		"type": "narrator",
		"text": "Неочікувано до групи доєднались ті ж самі журналісти, на яких дівчата звернули увагу на початку зустрічі. Меланія встигла прошепотіти Дарії.."
	},
	{
		"id": "ch2_093",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "Меланія",
		"type": "dialogue",
		"text": "Може б це сьогодні купити лотерейний квиток? Несподівано щастить.",
		"left": "daria_main/daria_neutral",
		"right": "melania/melania_playful"
	},
	{
		"id": "ch2_094",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "",
		"type": "narrator",
		"text": "Як уже було відомо, староста підійшов першим, але представлятись не поспішав. Очікував на свою одногрупницю чи подальші вказівки"
	},
	{
		"id": "ch2_095",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "",
		"type": "narrator",
		"text": "кураторів? Точно сказати було неможливо. Його обличчя не видавало жодних емоцій. Дарія в будь-якій іншій ситуації назвала б це нічим іншим як байдужість. Та хіба можна було бути байдужим зараз? Можливо, потім. А зараз в це складно вірити. Темне волосся обрамлювало бліде обличчя з чітко окресленими вилицями. За певний час стало зрозуміло: хлопець був надто зосередженим, тому здавався холодним та відстороненим. Дарія зробила висновок, що ймовірно він належить до тієї категорії людей, які багато мовчать, бо спостерігають і бачать більше, ніж інші. Хай там як, а впевнено заявляти про це було рано."
	},
	{
		"id": "ch2_096",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "Дарія",
		"type": "thought",
		"text": "Пізніше стане зрозуміліше.",
		"center": "daria_main/daria_neutral"
	},
	{
		"id": "ch2_097",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "Але Дарія не могла заперечувати",
		"type": "dialogue",
		"text": "було щось в цьому хлопцеві, що чіпляло. Хотілось дізнатись про нього більше."
	},
	{
		"id": "ch2_098",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "Дарія",
		"type": "thought",
		"text": "Для початку хоча б ім'я. Чи він збирається залишатись Пан Староста Журналістів?",
		"center": "daria_main/daria_neutral"
	},
	{
		"id": "ch2_099",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "",
		"type": "narrator",
		"text": "В цей момент з'явилась остання учасниця групи. Дівчина, чиє волосся здавалося полум'ям на блідім тлі. Висока, з гарною поставою та граційними рухами кішки."
	},
	{
		"id": "ch2_100",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "Роксолана",
		"type": "dialogue",
		"text": "Привіт, вибачте, що затрималась, потрібно було дещо віддати одногрупниці. Певно, після екскурсії всі вже розійдемось по домівках. Я Роксолана.",
		"left": "daria_main/daria_neutral",
		"right": "roksolana/roksolana_smile"
	},
	{
		"id": "ch2_101",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "",
		"type": "narrator",
		"text": "Дівчата і Лука привітались навзаєм, запевнивши її, що невелике очікування їм не зашкодило. Всі якось дивно глянули на студента, який досі не назвав бодай своє ім'я. Роксолана здогадалась в чому справа."
	},
	{
		"id": "ch2_102",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "Роксолана",
		"type": "dialogue",
		"text": "Він, гадаю, ще не представився?",
		"left": "daria_main/daria_neutral",
		"right": "roksolana/roksolana_smile"
	},
	{
		"id": "ch2_103",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "",
		"type": "narrator",
		"text": "Вона незадоволено глянула на нього. Той натомість дивився кудись в сторону кураторів, але відчувши колючий погляд одногрупниці, повернувся до компанії."
	},
	{
		"id": "ch2_104",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "Дем'ян",
		"type": "dialogue",
		"text": "Мене звати Дем’ян.",
		"left": "daria_main/daria_neutral",
		"right": "demyan/demyan_neutral"
	},
	{
		"id": "ch2_105",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "Меланія",
		"type": "dialogue",
		"text": "Яке гарне ім'я.",
		"left": "daria_main/daria_neutral",
		"right": "melania/melania_smile"
	},
	{
		"id": "ch2_106",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "",
		"type": "narrator",
		"text": "Та він, здається, не почув. Або вже і не хотів чути. Його погляд знову зосередився на викладачах."
	},
	{
		"id": "ch2_107",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "Роксолана",
		"type": "dialogue",
		"text": "Дем’яне, тобі щойно зробили комплімент, може подякуєш? Добре, скажу за нього. Дякую, гадаю Дем’яну приємно. Він не злий, якщо що.",
		"left": "daria_main/daria_neutral",
		"right": "roksolana/roksolana_smile"
	},
	{
		"id": "ch2_108",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "",
		"type": "narrator",
		"text": "Сцена нагадувала діалог турботливої матусі та дещо пасивного сина, який все ніяк не хотів “повернутися” у реальний світ."
	},
	{
		"id": "ch2_109",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "Дем’ян",
		"type": "dialogue",
		"text": "Не знаю, хто це сказав, але я збирався подякувати зараз, бо насправді слухав маршрут нашої підгрупи і спочатку ми попрямуємо в бібліотеку.",
		"left": "daria_main/daria_neutral",
		"right": "demyan/demyan_neutral"
	},
	{
		"id": "ch2_110",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "",
		"type": "narrator",
		"text": "Всі мовчки стали переглядатись між собою. Дійсно ніхто, окрім Дем’яна цього не почув. Тож така зосередженість і відповідальність заслуговувала поваги, замість засудження так званої байдужості. Роксолана озвалась перша. Воно й було не дивно, адже вони були однозначно ближчими, це здавалось доречним."
	},
	{
		"id": "ch2_111",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "Роксолана",
		"type": "dialogue",
		"text": "Ціную твою уважність. Ти просто неймовірний в цьому. Тільки за два дні встигла стільки разів переконатись. Нам пощастило з старостою.",
		"left": "daria_main/daria_neutral",
		"right": "roksolana/roksolana_smile"
	},
	{
		"id": "ch2_112",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "Дем'ян",
		"type": "dialogue",
		"text": "Звісно, але відмазувати вас все одно не буду.",
		"left": "daria_main/daria_neutral",
		"right": "demyan/demyan_neutral"
	},
	{
		"id": "ch2_113",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "",
		"type": "narrator",
		"text": "Роксолана засміялась."
	},
	{
		"id": "ch2_114",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "Роксолана",
		"type": "dialogue",
		"text": "Ще й як будеш.",
		"left": "daria_main/daria_neutral",
		"right": "roksolana/roksolana_smile"
	},
	{
		"id": "ch2_115",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "Дем'ян",
		"type": "dialogue",
		"text": "Це ми ще подивимось.",
		"left": "daria_main/daria_neutral",
		"right": "demyan/demyan_neutral"
	},
	{
		"id": "ch2_116",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "",
		"type": "narrator",
		"text": "Дівчина стишила голос."
	},
	{
		"id": "ch2_117",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "Роксолана",
		"type": "dialogue",
		"text": "Ну, Дем’яне-е.. А якщо шоколадка?",
		"left": "daria_main/daria_neutral",
		"right": "roksolana/roksolana_smile"
	},
	{
		"id": "ch2_118",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "Дем'ян",
		"type": "dialogue",
		"text": "Приймаю тільки протеїнові батончики.",
		"left": "daria_main/daria_neutral",
		"right": "demyan/demyan_neutral"
	},
	{
		"id": "ch2_119",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "Роксолана",
		"type": "dialogue",
		"text": "Два і розходимось.",
		"left": "daria_main/daria_neutral",
		"right": "roksolana/roksolana_smile"
	},
	{
		"id": "ch2_120",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "Дем'ян",
		"type": "dialogue",
		"text": "Три і не частіше, ніж раз на місяць.",
		"left": "daria_main/daria_neutral",
		"right": "demyan/demyan_neutral"
	},
	{
		"id": "ch2_121",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "Роксолана",
		"type": "dialogue",
		"text": "Чотири і можна деколи запізнюватись на пари.",
		"left": "daria_main/daria_neutral",
		"right": "roksolana/roksolana_smile"
	},
	{
		"id": "ch2_122",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "Дем'ян",
		"type": "dialogue",
		"text": "Пропозиція стає вкрай невигідною для мене. Не наглій.",
		"left": "daria_main/daria_neutral",
		"right": "demyan/demyan_neutral"
	},
	{
		"id": "ch2_123",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "",
		"type": "narrator",
		"text": "Роксолана лукаво підморгнула."
	},
	{
		"id": "ch2_124",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "Роксолана",
		"type": "dialogue",
		"text": "П’ять?",
		"left": "daria_main/daria_neutral",
		"right": "roksolana/roksolana_smile"
	},
	{
		"id": "ch2_125",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "",
		"type": "narrator",
		"text": "Дем'ян награно видихнув, ніби втомився від суперечки."
	},
	{
		"id": "ch2_126",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "Дем'ян",
		"type": "dialogue",
		"text": "Подивимось.",
		"left": "daria_main/daria_neutral",
		"right": "demyan/demyan_neutral"
	},
	{
		"id": "ch2_127",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "Роксолана",
		"type": "dialogue",
		"text": "О Боже, не думала, що ти здатен на таку типово чоловічу відповідь.",
		"left": "daria_main/daria_neutral",
		"right": "roksolana/roksolana_smile"
	},
	{
		"id": "ch2_128",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "",
		"type": "narrator",
		"text": "Вперше кутики губ Дем’яна потягнулись вверх. Вмить його постать видалась не такою вже й відстороненою."
	},
	{
		"id": "ch2_129",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "Роксолана",
		"type": "dialogue",
		"text": "До речі, комплімент зробила Меланія.",
		"left": "daria_main/daria_neutral",
		"right": "roksolana/roksolana_smile"
	},
	{
		"id": "ch2_130",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "",
		"type": "narrator",
		"text": "Погляд Меланії і Дем’яна перетнувся. Дарія вперше побачила як дівчина в певному розумінні розгубилась. Її очі з дещо іронією, його - спокійні. Вона дивилась на нього з тихим викликом. А він і не збирався змагатись. Погляд тривав секунду, можливо, дві. Але цього вистачило, щоб запам'ятати."
	},
	{
		"id": "ch2_131",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "Дем'ян",
		"type": "dialogue",
		"text": "Меланія теж дуже красиве ім'я. Не чув його раніше.",
		"left": "daria_main/daria_neutral",
		"right": "demyan/demyan_neutral"
	},
	{
		"id": "ch2_132",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "",
		"type": "narrator",
		"text": "Меланія у відповідь тільки посміхнулась. Звичайний привітний жест. І нічого більше."
	},
	{
		"id": "ch2_133",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "Дем'ян",
		"type": "dialogue",
		"text": "Нам пора. Кураторка чекає.",
		"left": "daria_main/daria_neutral",
		"right": "demyan/demyan_neutral"
	},
	{
		"id": "ch2_134",
		"chapter": 2,
		"bg": "02_03_assembly hall",
		"speaker": "",
		"type": "narrator",
		"text": "Всі мовчки рушили за хлопцем."
	},
	{
		"id": "ch2_135",
		"chapter": 2,
		"bg": "02_04_library",
		"speaker": "",
		"type": "narrator",
		"text": "Приміщення бібліотеки знаходилось майже поруч. Дем'ян ввічливо притримував двері, доки дівчата проходили всередину. Бібліотека зустріла тишею. Не мертвою, а живою. Це була тиша, в якій чутно, як перегортаються сторінки, як скрипить підлога під чиїмись обережними кроками.",
		"transition": "fade"
	},
	{
		"id": "ch2_136",
		"chapter": 2,
		"bg": "02_04_library",
		"speaker": "",
		"type": "narrator",
		"text": "Світло проникало через високі вікна м'якими променями, застеляючи полиці золотавим пилом. У повітрі відчувався добре знайомий запах старого паперу. Полиці височіли до самої стелі. Здавалось, на них не кілька сотень, а кілька тисяч книг. Деякі були затерті до невпізнання, з пошарпаними палітурками й імена давно забутих авторів. Та це не робило їх менш цінними."
	},
	{
		"id": "ch2_137",
		"chapter": 2,
		"bg": "02_04_library",
		"speaker": "",
		"type": "narrator",
		"text": "Далі студенти мали можливість побачити читацький зал. Ряди масивних дубових столів за якими сиділи ті, хто тут хвилювався перед сесією і ті, хто писав закохано вірші."
	},
	{
		"id": "ch2_138",
		"chapter": 2,
		"bg": "02_04_library",
		"speaker": "Лідія Іванівна",
		"type": "dialogue",
		"text": "Для філологів немає більш священного місця, ніж бібліотека. Тому екскурсія для вашої підгрупи розпочинається цілком символічно.",
		"left": "daria_main/daria_neutral",
		"right": "lidiya_ivanivna/LydiaIvanovna_Smile"
	},
	{
		"id": "ch2_139",
		"chapter": 2,
		"bg": "02_04_library",
		"speaker": "",
		"type": "narrator",
		"text": "Дарія як ніколи була згідна зі сказаним. Завжди у бібліотеці вона відчувала себе неначе в храмі. Повітря там завжди було густішим, не від пилу, в від історій. Дарія вдихала їх на повні груди і на обличчі з'являлась справжня посмішка."
	},
	{
		"id": "ch2_140",
		"chapter": 2,
		"bg": "02_04_library",
		"speaker": "",
		"type": "narrator",
		"text": "Кураторка повідомила правила користування університетською бібліотекою. Опісля настала черга запитань."
	},
	{
		"id": "ch2_141",
		"chapter": 2,
		"bg": "02_04_library",
		"speaker": "Дем'ян",
		"type": "dialogue",
		"text": "Ми могли б сьогодні оформити читацький квиток? Чи потрібно звернутись в інший день?",
		"left": "daria_main/daria_neutral",
		"right": "demyan/demyan_neutral"
	},
	{
		"id": "ch2_142",
		"chapter": 2,
		"bg": "02_04_library",
		"speaker": "Лідія Іванівна",
		"type": "dialogue",
		"text": "Як на мене, чудова ідея для охочих. Це не займе багато часу, в інші дні тут може бути людно.",
		"left": "daria_main/daria_neutral",
		"right": "lidiya_ivanivna/LydiaIvanovna_Smile"
	},
	{
		"id": "ch2_143",
		"chapter": 2,
		"bg": "02_04_library",
		"speaker": "",
		"type": "narrator",
		"text": "Всім сподобалась пропозиція і вони залюбки її підтримали. На столі з'явились потрібні формуляри для заповнення. Незабаром студенти вже могли офіційно назвати себе користувачами університетської бібліотеки."
	},
	{
		"id": "ch2_144",
		"chapter": 2,
		"bg": "02_05_inner_courtyard_day",
		"speaker": "",
		"type": "narrator",
		"text": "Закінчивши в бібліотеці, першокурсники познайомились з улюбленим місцем студентів, що не люблять надмірний шум, – внутрішній двір. Він здавався окремим світом відокремленим від метушливого Івано-Франківська і гомінкого корпусу. Уздовж алеї розташовувались з десяток лавочок на яких Дарія вже запланувала проводити більшість часу на перервах у погожі дні. Деякі під ялинками, деякі просто на сонці – ідеальне місце для відпочинку після довгої пари. Як було сказано кураторкою, внутрішній дворик ніколи не пустував і підтвердження цих слів відбулось одразу за хвилину. Лука дочекався моменту, коли викладачка буде достатньо далеко, аби повідомити свої спостереження.",
		"transition": "fade"
	},
	{
		"id": "ch2_145",
		"chapter": 2,
		"bg": "02_05_inner_courtyard_day",
		"speaker": "Лука",
		"type": "dialogue",
		"text": "Авжеж нам цього не скажуть, але найчастіше потаємно палять цигарки саме тут.",
		"left": "daria_main/daria_neutral",
		"right": "luka/luka"
	},
	{
		"id": "ch2_146",
		"chapter": 2,
		"bg": "02_05_inner_courtyard_day",
		"speaker": "",
		"type": "narrator",
		"text": "Дівчата покосились на хлопця, не знаючи, що сказати. Особисто для Дарії та й після проведеного дня разом з Меланією вона була впевнена, що і для неї, ця інформація здавалась просто.. непотрібною. Настала незручна мовчанка. Лука глянув на Дем’яна з невимовленим проханням врятувати його з такого незручного становища, підтримати розмову. Той не поспішав, але все ж вирішив додати коментар."
	},
	{
		"id": "ch2_147",
		"chapter": 2,
		"bg": "02_05_inner_courtyard_day",
		"speaker": "Дем'ян",
		"type": "dialogue",
		"text": "То ти, певно, мене вчора бачив.",
		"left": "daria_main/daria_neutral",
		"right": "demyan/demyan_neutral"
	},
	{
		"id": "ch2_148",
		"chapter": 2,
		"bg": "02_05_inner_courtyard_day",
		"speaker": "",
		"type": "narrator",
		"text": "Кутики його губ лукаво піднялись вверх. Лука дещо стурбувався ніби дійсно пригадував неіснуючий спогад."
	},
	{
		"id": "ch2_149",
		"chapter": 2,
		"bg": "02_05_inner_courtyard_day",
		"speaker": "Дем'ян",
		"type": "dialogue",
		"text": "Жартую.",
		"left": "daria_main/daria_neutral",
		"right": "demyan/demyan_neutral"
	},
	{
		"id": "ch2_150",
		"chapter": 2,
		"bg": "02_05_inner_courtyard_day",
		"speaker": "",
		"type": "narrator",
		"text": "Розмову підхопила Меланія."
	},
	{
		"id": "ch2_151",
		"chapter": 2,
		"bg": "02_05_inner_courtyard_day",
		"speaker": "Меланія",
		"type": "dialogue",
		"text": "Не знаю як ви, а я планую випити тут банку валер’янки перед екзаменом.",
		"left": "daria_main/daria_neutral",
		"right": "melania/melania_serious"
	},
	{
		"id": "ch2_152",
		"chapter": 2,
		"bg": "02_05_inner_courtyard_day",
		"speaker": "",
		"type": "narrator",
		"text": "Роксолана посміхнулась, весело додавши.."
	},
	{
		"id": "ch2_153",
		"chapter": 2,
		"bg": "02_05_inner_courtyard_day",
		"speaker": "Роксолана",
		"type": "dialogue",
		"text": "Покличеш мене теж, будь ласка?",
		"left": "daria_main/daria_neutral",
		"right": "roksolana/roksolana_smile"
	},
	{
		"id": "ch2_154",
		"chapter": 2,
		"bg": "02_05_inner_courtyard_day",
		"speaker": "Меланія",
		"type": "dialogue",
		"text": "О, без проблем, але вхід тільки зі своїми заспокійливими.",
		"left": "daria_main/daria_neutral",
		"right": "melania/melania_playful"
	},
	{
		"id": "ch2_155",
		"chapter": 2,
		"bg": "02_05_inner_courtyard_day",
		"speaker": "",
		"type": "narrator",
		"text": "За розмовами студенти і не помітили як дійшли до основної прикраси алеї – величного пам’ятника Василю Стефанику. Здається, він мовчки спостерігає за юнацтвом, суворий і мудрий як професор.",
		"transition": "fade"
	},
	{
		"id": "ch2_156",
		"chapter": 2,
		"bg": "02_05_inner_courtyard_day",
		"speaker": "Лідія Іванівна",
		"type": "dialogue",
		"text": "Гадаю, вам не потрібно пояснювати хто це. Натомість я хотіла б почути факти про нашого патрона від вас! І поки ви не оговтались, серед нас є один староста.. скажи, будь ласка, коли день народження Василя Семеновича?",
		"left": "daria_main/daria_neutral",
		"right": "lidiya_ivanivna/LydiaIvanovna_Smile"
	},
	{
		"id": "ch2_157",
		"chapter": 2,
		"bg": "02_05_inner_courtyard_day",
		"speaker": "",
		"type": "narrator",
		"text": "Дем'яна не здивувало запитання."
	},
	{
		"id": "ch2_158",
		"chapter": 2,
		"bg": "02_05_inner_courtyard_day",
		"speaker": "Дем'ян",
		"type": "dialogue",
		"text": "Чотирнадцятого травня.",
		"left": "daria_main/daria_neutral",
		"right": "demyan/demyan_neutral"
	},
	{
		"id": "ch2_159",
		"chapter": 2,
		"bg": "02_05_inner_courtyard_day",
		"speaker": "Лідія Іванівна",
		"type": "dialogue",
		"text": "Чудово! Маємо для вас хорошу новину. Саме тоді наш університет святкує свій день. Це масштабна подія з багатьма заходами. І найголовніше – жодних пар.",
		"left": "daria_main/daria_neutral",
		"right": "lidiya_ivanivna/LydiaIvanovna_Smile"
	},
	{
		"id": "ch2_160",
		"chapter": 2,
		"bg": "02_05_inner_courtyard_day",
		"speaker": "",
		"type": "narrator",
		"text": "Першокурсники зраділи цій новині. Особливо цікаво було відвідати заходи. Саме в такі моменти студенти відчували себе частиною великої дружньої спільноти."
	},
	{
		"id": "ch2_161",
		"chapter": 2,
		"bg": "02_05_inner_courtyard_day",
		"speaker": "Лідія Іванівна",
		"type": "dialogue",
		"text": "Вибачте, Дем'яне, що потрапили під приціл першим. Така вже ваша доля старости. Але тепер питання до решти. Що Ви можете розказати про Стефаника?",
		"left": "daria_main/daria_neutral",
		"right": "lidiya_ivanivna/LydiaIvanovna_Smile"
	},
	{
		"id": "ch2_162",
		"chapter": 2,
		"bg": "02_05_inner_courtyard_day",
		"speaker": "Роксолана",
		"type": "dialogue",
		"text": "Мене приваблює концепція «коротко, сильно і страшно». Мрію писати так само.",
		"left": "daria_main/daria_neutral",
		"right": "roksolana/roksolana_smile"
	},
	{
		"id": "ch2_163",
		"chapter": 2,
		"bg": "02_05_inner_courtyard_day",
		"speaker": "Лідія Іванівна",
		"type": "dialogue",
		"text": "Це справжнє мистецтво письма. Потрібно багато працювати над текстами, щоб досягнути схожого результату.",
		"left": "daria_main/daria_neutral",
		"right": "lidiya_ivanivna/LydiaIvanovna_Smile"
	},
	{
		"id": "ch2_164",
		"chapter": 2,
		"bg": "02_05_inner_courtyard_day",
		"speaker": "Роксолана",
		"type": "dialogue",
		"text": "Саме для цього я тут.",
		"left": "daria_main/daria_neutral",
		"right": "roksolana/roksolana_smile"
	},
	{
		"id": "ch2_165",
		"chapter": 2,
		"bg": "02_05_inner_courtyard_day",
		"speaker": "Меланія",
		"type": "dialogue",
		"text": "Мені дуже імпонують його новели. Свого часу «Мати» допомогла мені зробити важливий вибір. Точніше наважитись його зробити.",
		"left": "daria_main/daria_neutral",
		"right": "melania/melania_serious"
	},
	{
		"id": "ch2_166",
		"chapter": 2,
		"bg": "02_05_inner_courtyard_day",
		"speaker": "Лідія Іванівна",
		"type": "dialogue",
		"text": "Це непростий твір, втім як і всі твори цього неймовірного письменника. Його тексти живі і підтвердженням цього слугують ваші думки, що невпинно породжуються в голові після прочитання.",
		"left": "daria_main/daria_neutral",
		"right": "lidiya_ivanivna/LydiaIvanovna_Smile"
	},
	{
		"id": "ch2_167",
		"chapter": 2,
		"bg": "02_05_inner_courtyard_day",
		"speaker": "Віра",
		"type": "dialogue",
		"text": "Так, його новели торкаються душі. У мене вони викликають емоції такі глибинні, несхожі на інші..  «Новина» була для мене шокуючою в школі.",
		"left": "daria_main/daria_neutral",
		"right": "vira/vira_warm"
	},
	{
		"id": "ch2_168",
		"chapter": 2,
		"bg": "02_05_inner_courtyard_day",
		"speaker": "Лука",
		"type": "dialogue",
		"text": "Ти помилилась кількома літерами у слові, бо однозначно хотіла сказати «це моя травма».",
		"left": "daria_main/daria_neutral",
		"right": "luka/luka_smile"
	},
	{
		"id": "ch2_169",
		"chapter": 2,
		"bg": "02_05_inner_courtyard_day",
		"speaker": "",
		"type": "narrator",
		"text": "В групі пролунав смішок."
	},
	{
		"id": "ch2_170",
		"chapter": 2,
		"bg": "02_05_inner_courtyard_day",
		"speaker": "Лука",
		"type": "dialogue",
		"text": "І не кажіть, що для вас ні. Ви хіба такі ж кам’яні як той хрест, якщо це було ще «нічогенько».",
		"left": "daria_main/daria_neutral",
		"right": "luka/luka_smile"
	},
	{
		"id": "ch2_171",
		"chapter": 2,
		"bg": "02_05_inner_courtyard_day",
		"speaker": "Дарія",
		"type": "dialogue",
		"text": "Важко читати саме тому, що місця для байдужості там немає.",
		"center": "daria_main/daria_smile"
	},
	{
		"id": "ch2_172",
		"chapter": 2,
		"bg": "02_05_inner_courtyard_day",
		"speaker": "Оксана",
		"type": "dialogue",
		"text": "Він геній. Хто ж зміг би ще так написати про людей?",
		"left": "daria_main/daria_neutral",
		"right": "oksana/oksana_emotional"
	},
	{
		"id": "ch2_173",
		"chapter": 2,
		"bg": "02_05_inner_courtyard_day",
		"speaker": "",
		"type": "narrator",
		"text": "Усі відповіді першокурсників і навіть невелике обговорення потішили кураторку. Вона розповіла ще про важливі місця для студентів, що пригодяться під час навчального процесу. Після низки запитань, екскурсія офіційно була завершена. Кураторка побажала успіхів та перед тим як піти повідомила, що зовсім недалеко розташований молодіжний центр в якому сьогодні теж проводять екскурсії для новачків і порадила обов'язково туди піти, адже студентство – найкращий час для розвитку себе як особистості у різних сферах діяльності. Тож всі рушили за вказаним словами"
	},
	{
		"id": "ch2_174",
		"chapter": 2,
		"bg": "02_05_inner_courtyard_day",
		"speaker": "",
		"type": "narrator",
		"text": "маршрутом. Шукати майже не довелось. Заклад дійсно розташовувався неподалік."
	},
	{
		"id": "ch2_175",
		"chapter": 2,
		"bg": "02_06_youth_center (1)",
		"speaker": "",
		"type": "narrator",
		"text": "Всередині було багато молодих людей і компанія приєдналась до екскурсії. Їм вдалось дізнатись, що центр заснований студентами Карпатського університету. А також про неймовірну кількість клубів та дозвілля. Стало зрозуміло – це не просто місце для відпочинку, а середовище для творчості, розвитку і соціалізації молоді.",
		"transition": "fade"
	},
	{
		"id": "ch2_176",
		"chapter": 2,
		"bg": "02_06_youth_center (1)",
		"speaker": "",
		"type": "narrator",
		"text": "Кожен зацікавився чимось для себе. Дем'ян, як виявилось, непогано грає в шахи, тому задумався чи не відвідати шаховий клуб. Роксолану привабили вечори з настільними іграми, Дарія проявила інтерес до письменницького клубу. Меланія і Віра розділили його до кіновечорів. Лука поки що залишився у невизначеності."
	},
	{
		"id": "ch2_177",
		"chapter": 2,
		"bg": "02_06_youth_center (1)",
		"speaker": "Роксолана",
		"type": "dialogue",
		"text": "Дивовижне місце, наповнене творчістю. Мене такі завжди надихають.",
		"left": "daria_main/daria_neutral",
		"right": "roksolana/roksolana_smile"
	},
	{
		"id": "ch2_178",
		"chapter": 2,
		"bg": "02_06_youth_center (1)",
		"speaker": "",
		"type": "narrator",
		"text": "Дарія вийшла дещо спантеличезною від кількості інформації отриманої за увесь день. Їй подобались активності, але обіцяти собі, що вони будуть обов'язковою частиною її житті вона не могла. Дарії дуже хотілось знайти час для них в навчальний період. Вона сподівалась, що зможе."
	},
	{
		"id": "ch2_179",
		"chapter": 2,
		"bg": "02_06_youth_center (1)",
		"speaker": "",
		"type": "narrator",
		"text": "Раптом дівчина звернула увагу на те, що не почула ще жодних коментарів від Оксани, а вона здавалась їй неординарною особистістю, якій мали б сподобатись подібні заходи. Дарія обернулась в пошуках одногрупниці. І не побачила її."
	},
	{
		"id": "ch2_180",
		"chapter": 2,
		"bg": "02_06_youth_center (1)",
		"speaker": "",
		"type": "narrator",
		"text": "Вона різко зупинилась, поки компанія про щось розмовляла."
	},
	{
		"id": "ch2_181",
		"chapter": 2,
		"bg": "02_06_youth_center (1)",
		"speaker": "Дарія",
		"type": "dialogue",
		"text": "О Боже, невже сир?",
		"center": "daria_main/daria_smile"
	},
	{
		"id": "ch2_182",
		"chapter": 2,
		"bg": "02_06_youth_center (1)",
		"speaker": "",
		"type": "narrator",
		"text": "Всі інші теж зупинились. У їхніх поглядах простежувалось нерозуміння і занепокоєння."
	},
	{
		"id": "ch2_183",
		"chapter": 2,
		"bg": "02_06_youth_center (1)",
		"speaker": "Меланія",
		"type": "dialogue",
		"text": "Що сталось, Даріє?",
		"left": "daria_main/daria_neutral",
		"right": "melania/melania_serious"
	},
	{
		"id": "ch2_184",
		"chapter": 2,
		"bg": "02_06_youth_center (1)",
		"speaker": "Лука",
		"type": "dialogue",
		"text": "Це щось на кшталт «Еврика»?",
		"left": "daria_main/daria_neutral",
		"right": "luka/luka_awkward"
	},
	{
		"id": "ch2_185",
		"chapter": 2,
		"bg": "02_06_youth_center (1)",
		"speaker": "Дарія",
		"type": "dialogue",
		"text": "Як давно ви бачили Оксану?",
		"center": "daria_main/daria_smile"
	},
	{
		"id": "ch2_186",
		"chapter": 2,
		"bg": "02_06_youth_center (1)",
		"speaker": "Дем'ян",
		"type": "dialogue",
		"text": "Складне запитання.",
		"left": "daria_main/daria_neutral",
		"right": "demyan/demyan_neutral"
	},
	{
		"id": "ch2_187",
		"chapter": 2,
		"bg": "02_06_youth_center (1)",
		"speaker": "Роксолана",
		"type": "dialogue",
		"text": "Може вона затрималась в центрі?",
		"left": "daria_main/daria_neutral",
		"right": "roksolana/roksolana_smile"
	},
	{
		"id": "ch2_188",
		"chapter": 2,
		"bg": "02_06_youth_center (1)",
		"speaker": "Меланія",
		"type": "dialogue",
		"text": "Я не пам'ятаю її поруч з нами в центрі..",
		"left": "daria_main/daria_neutral",
		"right": "melania/melania_serious"
	},
	{
		"id": "ch2_189",
		"chapter": 2,
		"bg": "02_06_youth_center (1)",
		"speaker": "Лука",
		"type": "dialogue",
		"text": "Так що все-таки означає сир?",
		"left": "daria_main/daria_neutral",
		"right": "luka/luka_awkward"
	},
	{
		"id": "ch2_190",
		"chapter": 2,
		"bg": "02_06_youth_center (1)",
		"speaker": "",
		"type": "narrator",
		"text": "Тепер всі незадоволено дивились на Луку."
	},
	{
		"id": "ch2_191",
		"chapter": 2,
		"bg": "02_06_youth_center (1)",
		"speaker": "Дем'ян",
		"type": "dialogue",
		"text": "Окей, вона місцева?",
		"left": "daria_main/daria_neutral",
		"right": "demyan/demyan_neutral"
	},
	{
		"id": "ch2_192",
		"chapter": 2,
		"bg": "02_06_youth_center (1)",
		"speaker": "Меланія",
		"type": "dialogue",
		"text": "Як глянути. З області, теоретично - так, але не з ІФ, тож практично - ні.",
		"left": "daria_main/daria_neutral",
		"right": "melania/melania_serious"
	},
	{
		"id": "ch2_193",
		"chapter": 2,
		"bg": "02_06_youth_center (1)",
		"speaker": "Дем'ян",
		"type": "dialogue",
		"text": "Добре, ми відійшли не так далеко. Варто перевірити центр. Піду туди, а ти, Даріє, зателефонуй їй.",
		"left": "daria_main/daria_neutral",
		"right": "demyan/demyan_neutral"
	},
	{
		"id": "ch2_194",
		"chapter": 2,
		"bg": "02_06_youth_center (1)",
		"speaker": "",
		"type": "narrator",
		"text": "Лука виглядав не надто зацікавленим. Віра помітила це."
	},
	{
		"id": "ch2_195",
		"chapter": 2,
		"bg": "02_06_youth_center (1)",
		"speaker": "Віра",
		"type": "dialogue",
		"text": "Щось не так?",
		"left": "daria_main/daria_neutral",
		"right": "vira/vira_neutral"
	},
	{
		"id": "ch2_196",
		"chapter": 2,
		"bg": "02_06_youth_center (1)",
		"speaker": "Лука",
		"type": "dialogue",
		"text": "Просто думав потрапити додому раніше.",
		"left": "daria_main/daria_neutral",
		"right": "luka/luka_awkward"
	},
	{
		"id": "ch2_197",
		"chapter": 2,
		"bg": "02_06_youth_center (1)",
		"speaker": "Дарія",
		"type": "dialogue",
		"text": "Ви можете йти, адже не зобов'язані тут залишатись.",
		"center": "daria_main/daria_smile"
	},
	{
		"id": "ch2_198",
		"chapter": 2,
		"bg": "02_06_youth_center (1)",
		"speaker": "Віра",
		"type": "dialogue",
		"text": "Ні, я хотіла б допомогти.",
		"left": "daria_main/daria_neutral",
		"right": "vira/vira_warm"
	},
	{
		"id": "ch2_199",
		"chapter": 2,
		"bg": "02_06_youth_center (1)",
		"speaker": "Роксолана",
		"type": "dialogue",
		"text": "Ми з Дем'яном допоможемо. Вам залишатись дійсно немає потреби.",
		"left": "daria_main/daria_neutral",
		"right": "roksolana/roksolana_smile"
	},
	{
		"id": "ch2_200",
		"chapter": 2,
		"bg": "02_06_youth_center (1)",
		"speaker": "",
		"type": "narrator",
		"text": "Віра все ще трохи сумнівалась та зрештою здалась."
	},
	{
		"id": "ch2_201",
		"chapter": 2,
		"bg": "02_06_youth_center (1)",
		"speaker": "Віра",
		"type": "dialogue",
		"text": "Добре, була дуже рада з вами познайомитись.",
		"left": "daria_main/daria_neutral",
		"right": "vira/vira_warm"
	},
	{
		"id": "ch2_202",
		"chapter": 2,
		"bg": "02_06_youth_center (1)",
		"speaker": "Роксолана",
		"type": "dialogue",
		"text": "Навзаєм.",
		"left": "daria_main/daria_neutral",
		"right": "roksolana/roksolana_smile"
	},
	{
		"id": "ch2_203",
		"chapter": 2,
		"bg": "02_06_youth_center (1)",
		"speaker": "Віра",
		"type": "dialogue",
		"text": "Напишіть як знайдете її.",
		"left": "daria_main/daria_neutral",
		"right": "vira/vira_neutral"
	},
	{
		"id": "ch2_204",
		"chapter": 2,
		"bg": "02_06_youth_center (1)",
		"speaker": "Дарія",
		"type": "dialogue",
		"text": "О, і поки Лука не пішов. Втамую твою цікавість. Оксана попереджала про те, що може загубитись і казала кричати в такому разі «сир».",
		"center": "daria_main/daria_smile"
	},
	{
		"id": "ch2_205",
		"chapter": 2,
		"bg": "02_06_youth_center (1)",
		"speaker": "",
		"type": "narrator",
		"text": "Оскільки Меланія запізнилась вчора, то ця інформація була новою для неї теж."
	},
	{
		"id": "ch2_206",
		"chapter": 2,
		"bg": "02_06_youth_center (1)",
		"speaker": "Лука",
		"type": "dialogue",
		"text": "Оригінально. Ну, успіхів у пошуках. Хоча вона, певно, вже пішла додому. Не змарнуйте свій час.",
		"left": "daria_main/daria_neutral",
		"right": "luka/luka"
	},
	{
		"id": "ch2_207",
		"chapter": 2,
		"bg": "02_06_youth_center (1)",
		"speaker": "",
		"type": "narrator",
		"text": "Попрощавшись, двоє студентів вирушили по домівках в той час як ще четверо залишились у пошуках “згуби”."
	},
	{
		"id": "ch2_208",
		"chapter": 2,
		"bg": "02_06_youth_center (1)",
		"speaker": "",
		"type": "narrator",
		"text": "Дем'ян повернувся, сказавши, що в центрі її немає і найімовірніше не було, адже її червоне волосся не запам’ятав жоден працівник. Дарія зателефонувала, а Меланія відправила кілька повідомлень. П'ять хвилин вони очікували відповіді. Роксолана встигла переказати і Дем'яну розгадану загадку вигуку. Коли час пройшов, а відповідь так і не з’явилась, Дем’ян підвівся, проговорюючи.."
	},
	{
		"id": "ch2_209",
		"chapter": 2,
		"bg": "02_06_youth_center (1)",
		"speaker": "Дем'ян",
		"type": "dialogue",
		"text": "Гадаю, з нею все добре. Судячи з того, що вона повідомила вам, це далеко не перша схожа ситуація. Проте в нас залишається єдина неперевірена локація, де Оксана точно була в складі підгрупи. Питання тільки чи не покинула вона її вже до цього часу. Отже, я все-таки піду у внутрішній двір, а ви як бажаєте. В будь-якому випадку, я повідомлю вам.",
		"left": "daria_main/daria_neutral",
		"right": "demyan/demyan_neutral"
	},
	{
		"id": "ch2_210",
		"chapter": 2,
		"bg": "02_06_youth_center (1)",
		"speaker": "Дарія",
		"type": "dialogue",
		"text": "Можна запитання?",
		"center": "daria_main/daria_smile"
	},
	{
		"id": "ch2_211",
		"chapter": 2,
		"bg": "02_06_youth_center (1)",
		"speaker": "Дем'ян",
		"type": "dialogue",
		"text": "Так.",
		"left": "daria_main/daria_neutral",
		"right": "demyan/demyan_neutral"
	},
	{
		"id": "ch2_212",
		"chapter": 2,
		"bg": "02_06_youth_center (1)",
		"speaker": "Дарія",
		"type": "dialogue",
		"text": "Чому ти допомагаєш? Ти і Роксолана. Ви ж зовсім не знаєте її.",
		"center": "daria_main/daria_smile"
	},
	{
		"id": "ch2_213",
		"chapter": 2,
		"bg": "02_06_youth_center (1)",
		"speaker": "",
		"type": "narrator",
		"text": "Дем'ян знизив плечима."
	},
	{
		"id": "ch2_214",
		"chapter": 2,
		"bg": "02_06_youth_center (1)",
		"speaker": "Дем'ян",
		"type": "dialogue",
		"text": "Ви насправді теж. А якщо чесно, не знаю. Напевно, тому що відчуваю відповідальність за всіх учасників підгрупи.",
		"left": "daria_main/daria_neutral",
		"right": "demyan/demyan_neutral"
	},
	{
		"id": "ch2_215",
		"chapter": 2,
		"bg": "02_06_youth_center (1)",
		"speaker": "Роксолана",
		"type": "dialogue",
		"text": "Особисто я звикла допомагати, якщо можу.",
		"left": "daria_main/daria_neutral",
		"right": "roksolana/roksolana_smile"
	},
	{
		"id": "ch2_216",
		"chapter": 2,
		"bg": "02_06_youth_center (1)",
		"speaker": "Дем'ян",
		"type": "dialogue",
		"text": "А взагалі некоректне питання для журналістів. У нас професійний нюх. Хтось сказав “людина зникла”? Ми тут як тут. Непоганий матеріал, до речі. Не думаю, що в корпусі так часто реально губляться люди. Використаємо історію для нашого факультетного радіо. Перетворимо Оксану на справжню зірку-привида, яка досі блукає десь біля університету.",
		"left": "daria_main/daria_neutral",
		"right": "demyan/demyan_neutral"
	},
	{
		"id": "ch2_217",
		"chapter": 2,
		"bg": "02_06_youth_center (1)",
		"speaker": "",
		"type": "narrator",
		"text": "Роксолана показово закотила очі перед тим голосно цокнувши губами. Побачене дещо звеселило Дем’яна."
	},
	{
		"id": "ch2_218",
		"chapter": 2,
		"bg": "02_06_youth_center (1)",
		"speaker": "Дем'ян",
		"type": "dialogue",
		"text": "Ну, гайда шукати вашу Мишку. Ви йдете зі мною?",
		"left": "daria_main/daria_neutral",
		"right": "demyan/demyan_neutral"
	},
	{
		"id": "ch2_219",
		"chapter": 2,
		"bg": "02_06_youth_center (1)",
		"speaker": "Дарія",
		"type": "dialogue",
		"text": "Так, звичайно.",
		"center": "daria_main/daria_smile"
	},
	{
		"id": "ch2_220",
		"chapter": 2,
		"bg": "02_06_youth_center (1)",
		"speaker": "",
		"type": "narrator",
		"text": "Дарія була вдячна Дем'яну за те, що допомагає. Його спокій багато значив у таких тривожних ситуаціях. Сама вона, певно, надумала б зараз найгірші сценарії розвитку подій, якби не його холодні логічні коментарі. «Друзі пізнаються в біді». Та Дем’ян не був навіть другом для неї. І все ж ця ситуація багато чого говорила про нього як про людину."
	},
	{
		"id": "ch2_221",
		"chapter": 2,
		"bg": "02_06_youth_center (1)",
		"speaker": "Дарія",
		"type": "thought",
		"text": "На яку беззаперечно можна покластись.",
		"center": "daria_main/daria_neutral"
	},
	{
		"id": "ch2_222",
		"chapter": 2,
		"bg": "02_06_youth_center (1)",
		"speaker": "",
		"type": "narrator",
		"text": "Коли вони майже дійшли до входу, Роксолана раптом промовила Дем'яну просто в спину."
	},
	{
		"id": "ch2_223",
		"chapter": 2,
		"bg": "02_06_youth_center (1)",
		"speaker": "Роксолана",
		"type": "dialogue",
		"text": "До речі, миші не люблять сир. Це все маркетинговий стереотип. Гадаю, якщо будеш робити репортаж, варто знати про такі речі.",
		"left": "daria_main/daria_neutral",
		"right": "roksolana/roksolana_smile"
	},
	{
		"id": "ch2_224",
		"chapter": 2,
		"bg": "02_06_youth_center (1)",
		"speaker": "",
		"type": "narrator",
		"text": "Дем'яна, здається, це повеселило тільки більше."
	},
	{
		"id": "ch2_225",
		"chapter": 2,
		"bg": "02_06_youth_center (1)",
		"speaker": "Дем'ян",
		"type": "dialogue",
		"text": "Хороша помста, тільки чому так пізно?",
		"left": "daria_main/daria_neutral",
		"right": "demyan/demyan_neutral"
	},
	{
		"id": "ch2_226",
		"chapter": 2,
		"bg": "02_06_youth_center (1)",
		"speaker": "Роксолана",
		"type": "dialogue",
		"text": "Зважувала наскільки розумно мати конфлікт зі старостою з першого ж тижня навчання.",
		"left": "daria_main/daria_neutral",
		"right": "roksolana/roksolana_neutral"
	},
	{
		"id": "ch2_227",
		"chapter": 2,
		"bg": "02_06_youth_center (1)",
		"speaker": "Дем'ян",
		"type": "dialogue",
		"text": "Не розумно, тобі пощастило, що всього за один батончик, моя пам’ять стирає певні моменти..",
		"left": "daria_main/daria_neutral",
		"right": "demyan/demyan_neutral"
	},
	{
		"id": "ch2_228",
		"chapter": 2,
		"bg": "02_06_youth_center (1)",
		"speaker": "Роксолана",
		"type": "dialogue",
		"text": "Я так і знала! Ти збираєшся користуватись своєю посадою. Ще й корупція. Це низько, Дем'яне.",
		"left": "daria_main/daria_neutral",
		"right": "roksolana/roksolana_neutral"
	},
	{
		"id": "ch2_229",
		"chapter": 2,
		"bg": "02_06_youth_center (1)",
		"speaker": "Дем'ян",
		"type": "dialogue",
		"text": "Ну, конфлікт, то конфлікт.",
		"left": "daria_main/daria_neutral",
		"right": "demyan/demyan_neutral"
	},
	{
		"id": "ch2_230",
		"chapter": 2,
		"bg": "02_06_youth_center (1)",
		"speaker": "",
		"type": "narrator",
		"text": "Цього було достатньо, щоб засміятись. Та й не тільки їм, Дарію з Меланією забавляли ці словесні перепалки і вони жодну не сприймали серйозно. Як і учасники «сутичок». Це добре зняло напругу ситуації."
	},
	{
		"id": "ch2_231",
		"chapter": 2,
		"bg": "02_06_youth_center (1)",
		"speaker": "Меланія",
		"type": "dialogue",
		"text": "А хіба не ти перша пропонувала йому ще недавно їх в обмін на позитивне ставлення старости?",
		"left": "daria_main/daria_neutral",
		"right": "melania/melania_serious"
	},
	{
		"id": "ch2_232",
		"chapter": 2,
		"bg": "02_06_youth_center (1)",
		"speaker": "Дем'ян",
		"type": "dialogue",
		"text": "Слушне зауваження. Бачиш, Рокса, ти припустилась фатальної помилки. Всюди були свідки.",
		"left": "daria_main/daria_neutral",
		"right": "demyan/demyan_neutral"
	},
	{
		"id": "ch2_233",
		"chapter": 2,
		"bg": "02_06_youth_center (1)",
		"speaker": "Роксолана",
		"type": "dialogue",
		"text": "Ох, буде мені наукою. А тебе я ще запам'ятаю.",
		"left": "daria_main/daria_neutral",
		"right": "roksolana/roksolana_neutral"
	},
	{
		"id": "ch2_234",
		"chapter": 2,
		"bg": "02_06_youth_center (1)",
		"speaker": "Меланія",
		"type": "dialogue",
		"text": "Я, напевно, дарма це сказала..",
		"left": "daria_main/daria_neutral",
		"right": "melania/melania_serious"
	},
	{
		"id": "ch2_235",
		"chapter": 2,
		"bg": "02_06_youth_center (1)",
		"speaker": "",
		"type": "narrator",
		"text": "Нова хвиля сміху. Дарія навіть задумалась про те чи не піде ця «пригода» на користь їхнім стосункам."
	},
	{
		"id": "ch2_236",
		"chapter": 2,
		"bg": "02_06_youth_center (1)",
		"speaker": "Дарія",
		"type": "thought",
		"text": "Ми непогано зблизились з Роксоланою і Дем’яном. Якщо, звісно, вони вважають так само.",
		"center": "daria_main/daria_neutral"
	},
	{
		"id": "ch2_237",
		"chapter": 2,
		"bg": "02_06_youth_center (1)",
		"speaker": "",
		"type": "narrator",
		"text": "Атмосфера в компанії створилась неймовірно комфортна. Складалось враження, що вони знайомі не один день і не два."
	},
	{
		"id": "ch2_238",
		"chapter": 2,
		"bg": "02_05_inner_courtyard_day",
		"speaker": "",
		"type": "narrator",
		"text": "В кінці алеї стало виднітись щось червоняве.",
		"transition": "fade"
	},
	{
		"id": "ch2_239",
		"chapter": 2,
		"bg": "02_05_inner_courtyard_day",
		"speaker": "Дем’ян",
		"type": "dialogue",
		"text": "А ось і вона.",
		"left": "daria_main/daria_neutral",
		"right": "demyan/demyan_smirk"
	},
	{
		"id": "ch2_240",
		"chapter": 2,
		"bg": "02_05_inner_courtyard_day",
		"speaker": "",
		"type": "narrator",
		"text": "Оксана сиділа біля пам'ятника, усердно виводячи щось у своєму блокноті. Дарія відгукнула дівчину і та підняла голову. Оксана була здивована бачити їх."
	},
	{
		"id": "ch2_241",
		"chapter": 2,
		"bg": "02_05_inner_courtyard_day",
		"speaker": "Оксана",
		"type": "dialogue",
		"text": "Щось сталось?",
		"left": "daria_main/daria_neutral",
		"right": "oksana/oksana_sad"
	},
	{
		"id": "ch2_242",
		"chapter": 2,
		"bg": "02_05_inner_courtyard_day",
		"speaker": "Дарія",
		"type": "dialogue",
		"text": "Сир.",
		"center": "daria_main/daria_smile"
	},
	{
		"id": "ch2_243",
		"chapter": 2,
		"bg": "02_05_inner_courtyard_day",
		"speaker": "Оксана",
		"type": "dialogue",
		"text": "Боги.. То я загубилась?",
		"left": "daria_main/daria_neutral",
		"right": "oksana/oksana_sad"
	},
	{
		"id": "ch2_244",
		"chapter": 2,
		"bg": "02_05_inner_courtyard_day",
		"speaker": "Роксолана",
		"type": "dialogue",
		"text": "Уже знайшлась.",
		"left": "daria_main/daria_neutral",
		"right": "roksolana/roksolana_smile"
	},
	{
		"id": "ch2_245",
		"chapter": 2,
		"bg": "02_05_inner_courtyard_day",
		"speaker": "Оксана",
		"type": "dialogue",
		"text": "Ви справді повернулись по мене?",
		"left": "daria_main/daria_neutral",
		"right": "oksana/oksana_grateful"
	},
	{
		"id": "ch2_246",
		"chapter": 2,
		"bg": "02_05_inner_courtyard_day",
		"speaker": "",
		"type": "narrator",
		"text": "У її зелених очах заблищали барви вдячності. Вона обійняла всіх по черзі."
	},
	{
		"id": "ch2_247",
		"chapter": 2,
		"bg": "02_05_inner_courtyard_day",
		"speaker": "Оксана",
		"type": "dialogue",
		"text": "Дякую. Я просто засиділась. Сьогоднішній день був таким цікавим, що надихнув мене. І я вирішила, що просто “накину” скетч. Кілька хвилин і дожену вас.",
		"left": "daria_main/daria_neutral",
		"right": "oksana/oksana_grateful"
	},
	{
		"id": "ch2_248",
		"chapter": 2,
		"bg": "02_05_inner_courtyard_day",
		"speaker": "Дарія",
		"type": "dialogue",
		"text": "Попереджай наступного разуч або хоча б відповідай на дзвінок.",
		"center": "daria_main/daria_smile"
	},
	{
		"id": "ch2_249",
		"chapter": 2,
		"bg": "02_05_inner_courtyard_day",
		"speaker": "Оксана",
		"type": "dialogue",
		"text": "Добре. А про дзвінок, о, то мій телефон завжди на беззвучному режимі.",
		"left": "daria_main/daria_neutral",
		"right": "oksana/oksana_grateful"
	},
	{
		"id": "ch2_250",
		"chapter": 2,
		"bg": "02_05_inner_courtyard_day",
		"speaker": "Меланія",
		"type": "dialogue",
		"text": "Чудове комбо разом з умінням губитися.",
		"left": "daria_main/daria_neutral",
		"right": "melania/melania_playful"
	},
	{
		"id": "ch2_251",
		"chapter": 2,
		"bg": "02_05_inner_courtyard_day",
		"speaker": "",
		"type": "narrator",
		"text": "Оксана якось сумно посміхнулась."
	},
	{
		"id": "ch2_252",
		"chapter": 2,
		"bg": "02_05_inner_courtyard_day",
		"speaker": "Оксана",
		"type": "dialogue",
		"text": "Буду виправлятись. Все ж, ще раз дякую!",
		"left": "daria_main/daria_neutral",
		"right": "oksana/oksana_grateful"
	},
	{
		"id": "ch2_253",
		"chapter": 2,
		"bg": "02_05_inner_courtyard_day",
		"speaker": "",
		"type": "narrator",
		"text": "Всі поволі розходилися додому.",
		"transition": "fade"
	},
	{
		"id": "ch2_254",
		"chapter": 2,
		"bg": "02_05_inner_courtyard_day",
		"speaker": "Меланія",
		"type": "dialogue",
		"text": "Насичений день вийшов..",
		"left": "daria_main/daria_neutral",
		"right": "melania/melania_serious"
	},
	{
		"id": "ch2_255",
		"chapter": 2,
		"bg": "02_05_inner_courtyard_day",
		"speaker": "Роксолана",
		"type": "dialogue",
		"text": "Так, зате точно будемо мати що згадати.",
		"left": "daria_main/daria_neutral",
		"right": "roksolana/roksolana_smile"
	},
	{
		"id": "ch2_256",
		"chapter": 2,
		"bg": "02_05_inner_courtyard_day",
		"speaker": "",
		"type": "narrator",
		"text": "Біля воріт всі зупинились, щоб попрощатись. На небі привітно світило сонце. День був ясний і теплий. Жодної хмаринки на небі, тепер жодної тривоги на душі. Дарія повна світлих почуттів поверталась до свого нового дому."
	},
	{
		"id": "ch2_summary",
		"chapter": 2,
		"bg": "02_05_inner_courtyard_day",
		"type": "summary",
		"summary_title": "Розділ 2 завершено",
		"summary_lines": [
			"Дарія пережила другий насичений день і повну екскурсію університетом.",
			"Вона познайомилась із Вірою, Лукою, Роксоланою та Дем'яном.",
			"Оксану знайшли біля пам'ятника, а день завершився теплим відчуттям спільності."
		],
		"continue_label": "Титри",
		"continue_target": "ch2_credits",
		"save_label": "Зберегти"
	},
	{
		"id": "ch2_credits",
		"chapter": 2,
		"bg": "02_05_inner_courtyard_day",
		"type": "credits",
		"summary_title": "Титри",
		"summary_lines": [
			"Сценаристка: Сірадчук Яна Василівна",
			"Розробник: Гоян Олександр Васильович"
		],
		"continue_label": "У головне меню",
		"continue_target": "main_menu",
		"save_label": "Зберегти"
	}
]
