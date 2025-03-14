class Warnings {
  late List motorSigns;
  late List feedingSigns;
  late List communicationSigns;
  late List sensorySigns;
  late List reflexes;
  Warnings(int age) {
    setup(age);
  }
  void setup(int age) {
    switch (age) {
      case 3:
        motorSigns = [
          "صعوبة في رفع الرأس",
          "تيبس في الساقين مع قلة الحركة",
          "اليدين تظل مقبوضتين مع قلة حركة الذراعين",
          "إرجاع الرأس للخلف عند الاستلقاء"
        ];
        sensorySigns = [
          "عدم تتبع الأشياء بالعينين",
          "الرفض المتكرر للعناق",
          "اليدين تظل مقبوضتين معظم الوقت",
          "عدم التفاعل مع أنواع مختلفة من الحركة",
        ];
        communicationSigns = [
          "عدم البكاء عند الجوع أو عدم الراحة",
          "لا يستجيب للأصوات العالية",
          "لا يتواصل بصريًا أو يبتسم"
        ];
        feedingSigns = [
          "صعوبة في الالتقام أثناء الرضاعة",
          "فقدان الكثير من الحليب من جانبي الفم أثناء الرضاعة"
        ];
        reflexes = [
          {
            "name": "المورو",
            "steps": [
              "حطي الطفل على ضهره واسندي رأسه بيدك",
              "نزلي دعم رأسه بهدوء بحيث يحس بفقدان توازن لحظي",
              "الطفل لو مد دراعاته ورجليه لبرا ورجعهم تاني يبقى طبيعي"
            ],
            "worry": "لو استمر الرفلكس ده بعد 6 شهور، استشيري طبيب"
          },
          {
            "name": "الامساك",
            "steps": [
              "حطي صباعك في كف إيده",
              "لو الطفل مسك صباعك تلقائيًا، يبقى طبيعي",
            ],
            "worry":
                "لو استمر بعد 6 شهور، أو لو الطفل مش بيفتح إيده أو يمسك حاجات"
          }
        ];
        break;
      case 6:
        motorSigns = [
          "عدم القدرة على التدحرج",
          "صعوبة في تثبيت الرأس عند الجلوس",
          "تيبس الذراعين والساقين مع قلة الحركة",
          "لا يحاول الوصول إلى الأشياء",
        ];
        sensorySigns = [
          "عدم الالتفات للأصوات أو الأشخاص حوله",
          "لا يتابع الأشياء بعينيه",
          "عدم التفاعل مع الحركة المختلفة",
          "حساسية مفرطة تجاه الضوء أو الأصوات العالية",
        ];
        communicationSigns = [
          "عدم إصدار أصوات",
          "لا يتواصل بصريًا مع الأشخاص",
          "لا يضحك أو يظهر تفاعلًا اجتماعيًا"
        ];
        feedingSigns = [
          "صعوبة في الرضاعة بسبب التنفس غير المنتظم",
          "عدم القدرة على بلع الأطعمة الصلبة"
        ];
        reflexes = [
          {
            "name": "بابنسكي",
            "steps": [
              "مرري صباعك برفق على باطن رجل الطفل من الكعب لحد الأصابع",
              "لو صوابعه فتحت وطلعت لفوق، يبقى طبيعي"
            ],
            "worry": "لو استمر هذا الرفلكس بعد عمر 9 شهور، ممكن استشارة الطبيب"
          },
        ];
        break;
      case 9:
        motorSigns = [
          "لا يجلس دون دعم",
          "صعوبة في نقل الأشياء من يد إلى أخرى",
          "عدم استخدام اليدين لاستكشاف الأشياء"
        ];
        sensorySigns = [
          "لا يستجيب للأصوات المحيطة",
          "لا ينظر نحو الأشخاص أو الألعاب المتحركة",
          "لا يهتم بتجربة قوامات مختلفة عند اللمس"
        ];
        communicationSigns = [
          "لا يقلد الأصوات أو الإيماءات",
          "لا يستجيب عند سماع اسمه",
          "لا يظهر تعابير وجه واضحة"
        ];
        feedingSigns = ["صعوبة في تناول الطعام باليد", "عدم الاهتمام بالطعام"];
        reflexes = [
          {
            "name": "بابنسكي",
            "steps": [
              "مرري صباعك برفق على باطن رجل الطفل من الكعب لحد الأصابع",
              "لو صوابعه فتحت وطلعت لفوق، يبقى طبيعي"
            ],
            "worry": "إذا استمر بعد عمر السنة، الأفضل استشارة طبيب"
          },
        ];
        break;
      case 12:
        motorSigns = [
          "لا يقف بمساعدة",
          "لا يحبو أو يزحف للأمام",
          "لا يضع وزناً على ساقيه"
        ];
        sensorySigns = [
          "لا يستجيب للأشخاص أو الأصوات المألوفة",
          "يتجنب الألعاب الحركية",
          "لا يتفاعل مع الأصوات أو الروائح المختلفة"
        ];
        communicationSigns = [
          'لا يقول كلمات مثل "ماما" أو "بابا"',
          "لا يستخدم الإشارات مثل التلويح",
          "لا يستجيب للأوامر البسيطة"
        ];
        feedingSigns = [
          "صعوبة في المضغ أو البلع",
          "رفض أنواع جديدة من الطعام",
          "لا يستطيع الشرب من الكوب بمفرده"
        ];
        reflexes = [
          {
            "name": "التوتر",
            "steps": ["صفيق بهدوء على مسافة آمنة من الطفل"],
            "worry":
                "إذا مازال يستجيب بتوتر مفرط بعد السنة، الأفضل متابعة مع طبيب"
          }
        ];
      default:
    }
  }
}
