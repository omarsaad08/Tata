class FollowUp {
  late List<Map<String, dynamic>> motorMilestones;
  late List<Map<String, dynamic>> feedingMilestones;
  late List<Map<String, dynamic>> communicationMilestones;
  late List<Map<String, dynamic>> sensoryMilestones;
  List motorValues = [];
  List feedingValues = [];
  List communicationValues = [];
  List sensoryValues = [];
  int motorCounter = 0;
  int feedingCounter = 0;
  int communicationCounter = 0;
  int sensoryCounter = 0;
  bool healthy = true;
  int counter = 0;
  int age = 0;
  FollowUp(this.age) {
    setup(age);
  }
  void setup(int age) {
    switch (age) {
      case 3:
        motorMilestones = [
          {"label": "القدرة على الرضاعة الطبيعية", "isChecked": false},
          {"label": "القدرة على وضع اليدين في الفم", "isChecked": false},
          {"label": "القدرة على فتح وإغلاق قبضات ايده", "isChecked": false},
          {
            "label": "تحريك الذراعين والساقين عند الشعور بالحماس",
            "isChecked": false
          },
          {"label": "رفع الرأس عند الاستلقاء على البطن", "isChecked": false},
          {
            "label": "الدفع بالذراعين عند الاستلقاء على البطن",
            "isChecked": false
          },
        ];
        sensoryMilestones = [
          {
            "label": "القدرة على الهدوء مع الهز واللمس والأصوات الهادئة",
            "isChecked": false
          },
          {"label": "الاستمتاع بحركات متنوعة", "isChecked": false},
          {
            "label": "محاولة الوصول إلى لعبة عند الاستلقاء على الظهر",
            "isChecked": false
          },
          {
            "label":
                "إبقاء الرأس مركزًا لمشاهدة الوجوه أو الألعاب عند الاستلقاء على الظهر",
            "isChecked": false
          },
          {
            "label":
                "متابعة لعبة متحركة من جانب إلى جانب عند الاستلقاء على الظهر",
            "isChecked": false
          },
        ];
        communicationMilestones = [
          {"label": "إصدار أصوات ابتسامة", "isChecked": false},
          {
            "label": "البكاء بطرق مختلفة للاحتياجات المختلفة (جوع، تعب)",
            "isChecked": false
          },
          {"label": "التواصل البصري", "isChecked": false},
          {
            "label": "الهدوء أو الابتسام استجابة للأصوات أو الأصوات",
            "isChecked": false
          },
          {"label": "إظهار الاهتمام بالوجوه", "isChecked": false},
          {"label": "دوران الرأس تجاه الأصوات أو الأصوات", "isChecked": false},
        ];
        feedingMilestones = [
          {
            "label":
                'شرب من 59 الي 172ملليليتر من السوائل لكل وجبة، 6 مرات في اليوم "على الاقل"',
            "isChecked": false
          },
          {
            "label": "التعلق بالحلمة أو الزجاجة ويسعى براسه للرضاعة",
            "isChecked": false
          },
          {
            "label": "الامتصاص والبلع بشكل جيد أثناء الرضاعة",
            "isChecked": false
          },
          {"label": "تحريك اللسان للأمام والخلف للامتصاص", "isChecked": false},
        ];

        break;
      case 6:
        motorMilestones = [
          {"label": "يصل إلى الألعاب وهو على بطنه", "isChecked": false},
          {
            "label": "يتدحرج من الظهر إلى البطن ومن البطن إلى الظهر",
            "isChecked": false
          },
          {"label": "يستخدم يديه لدعم نفسه أثناء الجلوس", "isChecked": false},
          {
            "label": "بينما هو نائم على ظهره، يصل بيديه إلى قدميه للعب بهما",
            "isChecked": false
          },
          {
            "label": "بينما هو مستلق على ظهره، ينقل الأشياء من يد إلى أخرى",
            "isChecked": false
          },
          {
            "label": "بينما يقف بدعم، يقبل وزنه بالكامل على قدميه",
            "isChecked": false
          },
        ];
        sensoryMilestones = [
          {
            "label": "يستطيع الهدوء بالهز، اللمس، والأصوات اللطيفة",
            "isChecked": false
          },
          {"label": "يجلب يديه والأشياء إلى فمه", "isChecked": false},
          {"label": "يستمتع بتنوع الحركات", "isChecked": false},
          {
            "label": "عادةً ما يكون سعيدًا عندما لا يكون جائعًا أو متعبًا",
            "isChecked": false
          },
          {"label": "لا ينزعج من الأصوات اليومية", "isChecked": false},
          {"label": "يستخدم كلا اليدين لاستكشاف الألعاب", "isChecked": false},
        ];
        communicationMilestones = [
          {
            "label":
                "يبدأ في استخدام أصوات الحروف الساكنة في المناغاة (دا-دا-دا)",
            "isChecked": false
          },
          {"label": "يستمع ويرد عندما يتم التحدث إليه", "isChecked": false},
          {
            "label": "يصدر أنواعًا مختلفة من الأصوات للتعبير عن المشاعر",
            "isChecked": false
          },
          {"label": "يلاحظ الألعاب التي تصدر أصواتًا", "isChecked": false},
          {
            "label": "يتفاعل مع الضوضاء أو الأصوات المفاجئة",
            "isChecked": false
          },
          {"label": "يستخدم المناغاة لجذب الانتباه", "isChecked": false},
        ];
        feedingMilestones = [
          {
            "label": "يبدأ في تناول الحبوب والأطعمة المهروسة",
            "isChecked": false
          },
          {
            "label": "ينقل الطعام المهروس من مقدمة الفم إلى الخلف",
            "isChecked": false
          },
          {"label": "يفتح فمه عند اقتراب الملعقة", "isChecked": false},
          {"label": "يُظهر اهتمامًا بالطعام", "isChecked": false},
        ];
        break;
      case 9:
        motorMilestones = [
          {"label": "يبدأ في اللعب البسيط بمفرده", "isChecked": false},
          {
            "label": "يتحرك من البطن أو الظهر إلى وضعية الجلوس",
            "isChecked": false
          },
          {
            "label": "يرفع رأسه ويدفع بمرفقيه أثناء وقت البطن",
            "isChecked": false
          },
          {
            "label": "يلتقط الأشياء الصغيرة بإبهامه وأصابعه",
            "isChecked": false
          },
          {
            "label": "يظهر تحكمًا أكبر أثناء التدحرج والجلوس",
            "isChecked": false
          },
          {
            "label": "يجلس ويمد يديه للوصول للألعاب دون أن يقع",
            "isChecked": false
          },
          {
            "label":
                "يبدأ في التحرك باستخدام حركة متبادلة بين الساقين والذراعين مثل الزحف",
            "isChecked": false
          },
          {
            "label": "يدير رأسه لتتبع الأشياء بصريًا أثناء الجلوس",
            "isChecked": false
          },
        ];
        sensoryMilestones = [
          {
            "label": "يستكشف الأشكال والأحجام والقوام للألعاب والبيئة المحيطة",
            "isChecked": false
          },
          {
            "label":
                "يراقب البيئة من عدة وضعيات أثناء الاستلقاء على الظهر أو البطن، الجلوس، الزحف والوقوف بمساعدة",
            "isChecked": false
          },
          {
            "label": "يستكشف ويفحص الأشياء باستخدام يديه وفمه",
            "isChecked": false
          },
          {"label": "يركز على الأشياء القريبة والبعيدة", "isChecked": false},
          {
            "label":
                "يستمتع بحركات متنوعة مثل القفز إلى أعلى وأسفل والنظر للخلف وللأمام",
            "isChecked": false
          },
          {
            "label": "يجرب كمية القوة اللازمة لالتقاط الأشياء المختلفة",
            "isChecked": false
          },
          {
            "label": "يقلب عدة صفحات من كتاب سميك في آن واحد",
            "isChecked": false
          },
        ];
        feedingMilestones = [
          {"label": "يبدأ في استخدام الكوب المفتوح", "isChecked": false},
          {"label": "يتناول مجموعة متزايدة من الأطعمة", "isChecked": false},
          {
            "label": "يستمتع بتنوع أكبر من الروائح والأذواق",
            "isChecked": false
          },
          {"label": "يتناول الطعام بأصابعه بنفسه", "isChecked": false},
          {
            "label": "قد يكون مستعدًا لبدء التغذية الذاتية باستخدام الأدوات",
            "isChecked": false
          },
          {
            "label":
                "جاهز لتجربة الخضروات المطبوخة اللينة، الفواكه الطرية، والأطعمة التي يمكن تناولها بالأصابع مثل شرائح الموز والمعكرونة المطبوخة",
            "isChecked": false
          },
        ];
        communicationMilestones = [
          {"label": "يتعرف على صوت اسمه", "isChecked": false},
          {
            "label": "يظهر اعترافًا بالكلمات الشائعة المستخدمة",
            "isChecked": false
          },
          {
            "label": "ينظر إلى الأشياء والأشخاص المألوفين عند تسميتهم",
            "isChecked": false
          },
          {"label": "يشارك في التواصل الثنائي", "isChecked": false},
          {
            "label": "يتبع بعض الأوامر الروتينية عندما تقترن بالإيماءات",
            "isChecked": false
          },
          {"label": "يصدر أصواتًا محدودة", "isChecked": false},
          {
            "label":
                "يستخدم مجموعة متنوعة ومتزايدة من الأصوات والمقاطع الصوتية في الثرثرة",
            "isChecked": false
          },
          {
            "label": 'يستخدم إيماءات بسيطة مثل هز الرأس لقول "لا"',
            "isChecked": false
          },
        ];
        break;
      case 12:
        motorMilestones = [
          {"label": "يصفق بيديه", "isChecked": false},
          {
            "label": "يحافظ على توازنه أثناء الجلوس عند رمي الأشياء",
            "isChecked": false
          },
          {
            "label":
                "يتحرك داخل وخارج الوضعيات المختلفة لاستكشاف البيئة والحصول على الألعاب المرغوبة",
            "isChecked": false
          },
          {
            "label": "يرفع نفسه للوقوف ويزحف على طول الأثاث",
            "isChecked": false
          },
          {"label": "يضع الأشياء في حاوية ذات فتحة كبيرة", "isChecked": false},
          {"label": "يقف وحده ويأخذ عدة خطوات مستقلة", "isChecked": false},
          {
            "label": "يستخدم الإبهام والسبابة لالتقاط الأشياء الصغيرة",
            "isChecked": false
          },
        ];
        sensoryMilestones = [
          {
            "label": "يزحف نحو أو بعيدًا عن الأشياء التي يراها من مسافة",
            "isChecked": false
          },
          {"label": "يستمتع بالاستماع إلى الأغاني", "isChecked": false},
          {"label": "يستكشف الألعاب بأصابعه وفمه", "isChecked": false},
        ];
        communicationMilestones = [
          {
            "label": "يتضمن الثرثرة أصواتًا وإيقاعًا يشبه الكلام",
            "isChecked": false
          },
          {
            "label": "يبدأ في استخدام حركات اليد للتعبير عن رغباته",
            "isChecked": false
          },
          {"label": "يقلد أصوات الكلام", "isChecked": false},
          {"label": 'يستخدم "ماما" أو "دادا" بمعنى', "isChecked": false},
          {
            "label": "ينتبه إلى المكان الذي تنظرين إليه وتشيرين إليه",
            "isChecked": false
          },
          {
            "label": "ينتج سلاسل طويلة من الكلام غير المفهوم",
            "isChecked": false
          },
          {"label": 'يستجيب لكلمة "لا" والتعليمات البسيطة', "isChecked": false},
          {"label": "يقول كلمة أو كلمتين", "isChecked": false},
        ];
        feedingMilestones = [
          {"label": "يبدأ في استخدام الكوب المفتوح", "isChecked": false},
          {"label": "يتناول مجموعة متزايدة من الأطعمة", "isChecked": false},
          {
            "label": "يستمتع بتنوع أكبر من الروائح والأذواق",
            "isChecked": false
          },
          {"label": "يتناول الطعام بأصابعه بنفسه", "isChecked": false},
        ];
        break;
      case 18:
        motorMilestones = [
          {"label": "يمشي بدون دعم", "isChecked": false},
          {"label": "يحاول صعود السلم مستندًا", "isChecked": false},
          {"label": "يدفع أو يسحب ألعاب", "isChecked": false},
          {"label": "يبدأ في الجري بخطوات غير متزنة", "isChecked": false},
        ];
        sensoryMilestones = [
          {"label": "يستجيب للأصوات المألوفة", "isChecked": false},
          {"label": "يلتفت عند مناداته", "isChecked": false},
          {"label": "يلمس الأشياء ويستكشفها بفمه", "isChecked": false},
          {"label": "يُظهر تفاعلًا مع الموسيقى", "isChecked": false},
        ];
        communicationMilestones = [
          {"label": "ينطق أولى كلماته (زي بابا، ماما)", "isChecked": false},
          {"label": "يشير لطلب شيء", "isChecked": false},
          {"label": "يستخدم الإشارات (زي التلويح)", "isChecked": false},
          {
            "label": "يستخدم الإبهام والسبابة لالتقاط الأشياء الصغيرة",
            "isChecked": false
          },
        ];
        feedingMilestones = [
          {
            "label": "يزحف نحو أو بعيدًا عن الأشياء التي يراها من مسافة",
            "isChecked": false
          },
          {"label": "يستمتع بالاستماع إلى الأغاني", "isChecked": false},
          {"label": "يستكشف الألعاب بأصابعه وفمه", "isChecked": false},
        ];
        break;
      case 24:
        motorMilestones = [
          {"label": "يجري بثبات أكبر", "isChecked": false},
          {"label": "يصعد السلم بمساعدة", "isChecked": false},
          {"label": "يبدأ في القفز في مكانه", "isChecked": false},
          {"label": "يحمل أشياء أثناء المشي", "isChecked": false},
        ];
        sensoryMilestones = [
          {"label": "يستمتع بالموسيقى", "isChecked": false},
          {"label": "يتبع الأشياء بعينيه بدقة", "isChecked": false},
          {"label": "يُظهر تفضيلًا لألعاب معينة", "isChecked": false},
          {"label": "يلاحظ الأصوات المختلفة", "isChecked": false},
        ];
        communicationMilestones = [
          {"label": "يستخدم من 10 لـ 20 كلمة", "isChecked": false},
          {"label": "يبدأ تكوين جمل بسيطة من كلمتين", "isChecked": false},
          {"label": "يقلد كلمات جديدة", "isChecked": false},
          {"label": "يفهم أوامر مكونة من خطوتين", "isChecked": false},
        ];
        break;
      case 36:
        motorMilestones = [
          {"label": "يجري بسهولة", "isChecked": false},
          {"label": "يقفز بكلتا القدمين", "isChecked": false},
          {"label": "يصعد السلم خطوة بخطوة", "isChecked": false},
          {"label": "يركب الدراجة ذات الثلاث عجلات", "isChecked": false},
        ];
        sensoryMilestones = [
          {"label": "يميز بين الأصوات", "isChecked": false},
          {"label": "يختار لعبته المفضلة", "isChecked": false},
          {"label": "يستجيب لاسمه باستمرار", "isChecked": false},
          {"label": "يُظهر اهتمامًا بالتفاصيل", "isChecked": false},
        ];
        communicationMilestones = [
          {"label": "يقول جمل من كلمتين إلى ثلاث", "isChecked": false},
          {"label": "يسمي أعضاء الجسم", "isChecked": false},
          {"label": "يسأل “دي إيه؟” أو “فين؟”", "isChecked": false},
          {"label": "يعرف أسماء الأشخاص المقربين", "isChecked": false},
        ];
        break;
      case 48:
        motorMilestones = [
          {"label": "يقفز على قدم واحدة", "isChecked": false},
          {"label": "يرمي ويمسك الكرة", "isChecked": false},
          {"label": "يغير الاتجاه أثناء الجري", "isChecked": false},
          {"label": "يتسلق بسهولة", "isChecked": false},
        ];
        sensoryMilestones = [
          {"label": "يلاحظ تفاصيل الصور", "isChecked": false},
          {"label": "يقلد الحركات اللي يشوفها", "isChecked": false},
          {"label": "يتحمّل الأصوات العالية لفترة أطول", "isChecked": false},
          {"label": "يتعرف على اختلاف الملامس", "isChecked": false},
        ];
        communicationMilestones = [
          {"label": "يستخدم جمل من 3–5 كلمات", "isChecked": false},
          {"label": "يحكي عن موقف بسيط حصل له", "isChecked": false},
          {"label": "يسأل أسئلة زي “ليه؟”", "isChecked": false},
          {"label": "يبدأ يستخدم الضمائر بشكل صحيح", "isChecked": false},
        ];
        break;
      case 60:
        motorMilestones = [
          {"label": "يقفز من ارتفاع بسيط", "isChecked": false},
          {"label": "يمسك الكرة بدقة", "isChecked": false},
          {"label": "يركب دراجة بعجلتين بمساعدة", "isChecked": false},
          {"label": "يستخدم أدوات بسيطة في اللعب", "isChecked": false},
        ];
        sensoryMilestones = [
          {"label": "يفرّق بين الملامس المختلفة", "isChecked": false},
          {"label": "يُظهر انزعاجه من أصوات أو ملمس معين", "isChecked": false},
          {"label": "يبدأ يعبّر عن تفضيلاته الحسية", "isChecked": false},
          {"label": "يتفاعل مع الأصوات بشكل أكثر دقة", "isChecked": false},
        ];
        communicationMilestones = [
          {"label": "يحكي قصة قصيرة", "isChecked": false},
          {"label": "يستخدم زمن الماضي", "isChecked": false},
          {"label": "يسأل “إزاي؟” و”ليه؟” بشكل متكرر", "isChecked": false},
          {"label": "يشرح أفكاره بجمل طويلة", "isChecked": false},
        ];
        break;
      case 72:
        motorMilestones = [
          {"label": "يتحرك بثقة ورشاقة", "isChecked": false},
          {"label": "يركب الدراجة بدون مساعدات", "isChecked": false},
          {
            "label": "يلعب ألعاب تعتمد على التوازن (زي الحبل)",
            "isChecked": false
          },
          {"label": "يتحكم في جسمه بدقة اثناء اللعب", "isChecked": false},
        ];
        sensoryMilestones = [
          {"label": "يتحمل المحفزات الحسية بشكل افضل", "isChecked": false},
          {
            "label": "يعبّر عن انزعاجه من الاصوات او الروائح",
            "isChecked": false
          },
          {"label": "يختار الألعاب حسب تفضيلاته الحسية", "isChecked": false},
          {"label": "يميز بين الاصوات بدقة", "isChecked": false},
        ];
        communicationMilestones = [
          {"label": "يتحدث بجمل واضحة ومنظمة", "isChecked": false},
          {"label": "يستخدم القواعد اللغوية بشكل صحيح", "isChecked": false},
          {"label": "يصف الصور والمواقف بالتفصيل", "isChecked": false},
          {"label": "يشارك في حوارات مع الكبار", "isChecked": false},
        ];
        break;
      default:
    }
  }

  List generateValues() {
    motorValues = [];
    feedingValues = [];
    communicationValues = [];
    sensoryValues = [];
    motorCounter = 0;
    feedingCounter = 0;
    communicationCounter = 0;
    sensoryCounter = 0;
    for (var milestone in motorMilestones) {
      motorValues.add(milestone['isChecked']);
      milestone['isChecked'] ? null : motorCounter++;
    }
    for (var milestone in feedingMilestones) {
      feedingValues.add(milestone['isChecked']);
      milestone['isChecked'] ? null : feedingCounter++;
    }
    for (var milestone in communicationMilestones) {
      communicationValues.add(milestone['isChecked']);
      milestone['isChecked'] ? null : communicationCounter++;
    }
    for (var milestone in sensoryMilestones) {
      sensoryValues.add(milestone['isChecked']);
      milestone['isChecked'] ? null : sensoryCounter++;
    }
    print("age: $age");
    if (age >= 18) {
      if (motorCounter > 2 || communicationCounter > 1 || sensoryCounter > 1) {
        healthy = false;
      }
    } else {
      if (motorCounter > 2 ||
          feedingCounter > 1 ||
          communicationCounter > 1 ||
          sensoryCounter > 1) {
        healthy = false;
      }
    }
    // print([motorCounter, feedingCounter, communicationCounter, sensoryCounter]);
    return [motorValues, feedingValues, communicationValues, sensoryValues];
  }

  double generateScore() {
    for (var val in motorValues) {
      val ? counter++ : null;
    }
    for (var val in communicationValues) {
      val ? counter++ : null;
    }
    for (var val in sensoryValues) {
      val ? counter++ : null;
    }
    for (var val in feedingValues) {
      val ? counter++ : null;
    }
    return counter /
        (motorValues.length +
            communicationValues.length +
            sensoryValues.length +
            feedingValues.length);
  }
}
