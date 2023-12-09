import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageConseilHR extends StatefulWidget {
  const PageConseilHR({super.key, required this.lang, required this.state});
  final String lang;
  final String state;
  @override
  State<PageConseilHR> createState() => _PageConseilHRState();
}

class _PageConseilHRState extends State<PageConseilHR> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: resConseil()[widget.state].length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.white70, changeColor(widget.state)]),
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 24,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            resConseil()[widget.state][index],
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Color changeColor(String val) {
    switch (val) {
      case "2":
        return Colors.red.shade300;

      case "1":
        return Colors.yellow.shade300;

      case "0":
        return Colors.green.shade300;

      default:
        Colors.transparent;
    }

    return Colors.transparent;
  }

  resConseil() {
    switch (widget.lang) {
      case 'fr':
        return content["fr"];
      case 'en':
        return content["en"];
      case 'ar':
        return content["ar"];
      default:
        return content["ar"];
    }
  }

  final Map<String, Map<String, List<String>>> content = {
    'fr': {
      "2": [
        "Le premier réflexe est de se reposer et de se calmer. Le stress et l'anxiété peuvent contribuer à augmenter le rythme cardiaque.",
        "S'allonger ou s'asseoir confortablement peut aider à réduire le rythme cardiaque.",
        "Pratiquer des techniques de respiration profonde et lente peut aider à réguler le rythme cardiaque.",
        "Assurez-vous de rester hydraté, car la déshydratation peut affecter le rythme cardiaque.",
        "Limitez la consommation de caféine, de nicotine et d'autres stimulants qui peuvent augmenter le rythme cardiaque."
      ],
      "1": [
        "Prenez des mesures régulières de votre rythme cardiaque pour suivre sa progression.",
        "Essayez d'identifier les facteurs qui pourraient déclencher cette augmentation du rythme cardiaque, comme le stress, l'exercice intense etc.",
        "Limitez la consommation de substances comme la caféine, la nicotine et l'alcool.",
        "Les techniques de gestion du stress, telles que la méditation, le yoga, ou simplement la pratique d'activités relaxantes, peuvent contribuer à maintenir un rythme cardiaque régulier."
      ],
      "0": [
        "Adoptez une routine d'exercice modérée régulière, adaptée à votre condition physique. L'exercice peut renforcer le cœur et maintenir un rythme cardiaque stable.",
        "Une alimentation saine et équilibrée, riche en fruits, légumes, grains entiers, protéines maigres et graisses saines, peut soutenir la santé cardiaque.",
        "Assurez-vous de dormir suffisamment. Le manque de sommeil peut perturber le rythme cardiaque. Essayez de maintenir des habitudes de sommeil saines."
      ],
    },
    'en': {
      "2": [
        "The first reflex is to rest and calm down. Stress and anxiety can increase heart rate.",
        "Lying down or sitting comfortably can help reduce heart rate.",
        "Practicing slow, deep breathing techniques can help regulate heart rate.",
        "Make sure you stay hydrated, as dehydration can affect heart rate.",
        "Limit consumption of caffeine, nicotine and other stimulants that can increase heart rate."
      ],
      "1": [
        "Take regular measurements of your heart rate to monitor its progression.",
        "Try to identify factors that could trigger this increase in heart rate, such as stress, intense exercise, etc.",
        "Limit consumption of substances such as caffeine, nicotine and alcohol.",
        "Stress management techniques, such as meditation, yoga, or simply practicing relaxing activities, can help maintain a regular heart rate."
      ],
      "0": [
        "Adopt a regular moderate exercise routine, adapted to your physical condition. Exercise can strengthen the heart and maintain a stable heart rate.",
        "A healthy, balanced diet rich in fruits, vegetables, whole grains, lean proteins and healthy fats can support heart health.",
        "Make sure you get enough sleep. Lack of sleep can disrupt heart rhythm. Try to maintain healthy sleep habits."
      ],
    },
    'ar': {
      "2": [
        "الاستلقاء أو الجلوس بشكل مريح يمكن أن يساعد في تقليل معدل ضربات القلب.",
        "ممارسة تقنيات التنفس العميقة والبطيئة يمكن أن تساعد في تنظيم معدل ضربات القلب.",
        "تأكد من البقاء رطبًا لأن الجفاف يمكن أن يؤثر على معدل ضربات القلب.",
        "الحد من الكافيين والنيكوتين والمنشطات الأخرى التي يمكن أن تزيد من معدل ضربات القلب."
      ],
      "1": [
        "خذ قياسات معدل ضربات القلب بانتظام لتتبع معدل ضربات قلبك",
        "حاول تحديد العوامل التي يمكن أن تؤدي إلى زيادة معدل ضربات القلب، مثل التوتر والتمارين الشاقة وما إلى ذلك",
        "الحد من استهلاك مواد مثل الكافيين والنيكوتين والكحول."
      ],
      "0": [
        "اعتمد روتينًا معتدلًا منتظمًا للتمارين الرياضية، يتكيف مع حالتك البدنية. يمكن أن تقوي التمارين القلب وتحافظ على استقرار معدل ضربات القلب.",
        "يمكن لنظام غذائي صحي ومتوازن، غني بالفواكه والخضروات والحبوب الكاملة والبروتين الخالي من الدهون والدهون الصحية، أن يدعم صحة القلب.",
        "تأكد من حصولك على قسط كافٍ من النوم. قلة النوم يمكن أن تعطل معدل ضربات قلبك. حاول الحفاظ على عادات نوم صحية."
      ],
    },
  };
}
