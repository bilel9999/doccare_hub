import 'dart:math';
import 'dart:async';
import 'package:animator/animator.dart';
import 'package:doccare_hub/Views/HR/pageconseihr.dart';
import 'package:doccare_hub/api/MedicalMeasureApi.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EcgPage extends StatefulWidget {
  EcgPage(
      {super.key,
      required this.lang,
      required this.id,
      required this.refactor,
      required this.age});
  final String lang;
  final String id;
  final int refactor;
  final int age;

  @override
  _EcgPageState createState() => _EcgPageState();
}

class _EcgPageState extends State<EcgPage> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  var predValue = "";
  StreamController<int?> _freqStreamController = StreamController<int?>();
  Stream<int?> get freqStream => _freqStreamController.stream;
  StreamController<int?> _spo2StreamController =
      StreamController<int?>.broadcast();
  Stream<int?> get spo2Stream => _spo2StreamController.stream;
  List<int> freqValues = [];
  List<int> spo2Values = [];
  late Timer _timer;
  bool showButton = false;
  @override
  void initState() {
    super.initState();
    startTimer();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
      ),
    );

    _animationController.repeat(reverse: true);

    Timer.periodic(Duration(seconds: 1), (timer) {
      if (_animationController != null && _animationController.isAnimating) {
        _animationController.forward(from: 0);
      }
    });
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(milliseconds: 200), (timer) {
      // Read data from Firebase every 200 milliseconds
      readDataF();
      readDataS();
    });

    // Stop the timer after 5 seconds
    Timer(Duration(seconds: 5), () {
      _timer.cancel();
      calculateMean();
    });

    // Delay the appearance of the button by 5.1 seconds
    Future.delayed(Duration(seconds: 5, milliseconds: 100), () {
      setState(() {
        showButton = true;
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _freqStreamController.close();
    super.dispose();
  }

  DatabaseReference dbRef = FirebaseDatabase.instance.ref('app');

  void readDataF() {
    dbRef.child('freq').onValue.listen((event) {
      if (event.snapshot.exists) {
        int? freq = event.snapshot.value as int?;
        _freqStreamController.add(freq);
        freqValues.add(freq ?? 0);
        print(freqValues);
        print(freqValues.length);
      } else {
        print('No data available.');
      }
    });
  }

  void readDataS() {
    dbRef.child('spo2').onValue.listen((event) {
      if (event.snapshot.exists) {
        int? spo2 = event.snapshot.value as int?;
        _spo2StreamController.add(spo2);
        spo2Values.add(spo2 ?? 0);
        print(spo2Values);
        print(spo2Values.length);
      } else {
        print('No data available.');
      }
    });
  }

  void calculateMean() {
    if (freqValues.isNotEmpty) {
      double meanS = 0;
      for (int i = 0; i < spo2Values.length; i++) meanS += spo2Values[i];
      meanS /= spo2Values.length;

      double meanF = 0;
      for (int i = 0; i < freqValues.length; i++) meanF += freqValues[i];
      meanF /= freqValues.length;

      predData(meanF, meanS);
      // double mean = freqValues.reduce((a, b) => a + b) / freqValues.length;
      print('Mean freq value: $meanF Mean spo2 value: $meanS');
      // Add your further processing or UI updates with the mean value here
    } else {
      print('No freq values recorded.');
    }
  }

  Future<void> predData(double meanF, double meanS) async {
    final interpreter =
        await Interpreter.fromAsset('assets/model-2eme-essai.tflite');

    var input = [
      [widget.age, meanF.round(), meanS.round()]
    ];
    print(input);
    var output = List.filled(3, 0).reshape([1, 3]);
    interpreter.run(input, output);
    print(output[0]);
    int maxIndex = findMaxIndex(output[0]);
    print("maxIndex  " + maxIndex.toString());
    if (widget.id != "0") {
      MedicalMeasureApi.sendMedicalMeasurements({
        "cardiacFrequency": meanF.round(),
        "oxygenSaturation": meanS.round(),
        "state": maxIndex,
        "date": null,
        "patientId": 1
      });
    }
    this.setState(() {
      predValue = maxIndex.toString();
    });
  }

  int findMaxIndex(List<double> list) {
    double max = list[0];
    int maxIndex = 0;

    for (int i = 1; i < list.length; i++) {
      if (list[i] > max) {
        max = list[i];
        maxIndex = i;
      }
    }

    return maxIndex;
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: StreamBuilder<int?>(
        stream: freqStream,
        builder: (context, freqSnapshot) {
          if (freqSnapshot.hasData) {
            int? freq = freqSnapshot.data;
            // Color bgColor = changeColor(freq);

            return StreamBuilder<int?>(
              stream: spo2Stream,
              builder: (context, spo2Snapshot) {
                int? spo2 = spo2Snapshot.data;

                return Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.white, changeColor(predValue)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(child: freqAnimation(ref: widget.refactor)),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${freq}',
                            style: TextStyle(
                                fontSize: widget.refactor == 0 ? 50 : 30),
                          ),
                          Text(
                            "bpm",
                            style: TextStyle(
                                fontSize: widget.refactor == 0 ? 20 : 10),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      SizedBox(height: 20),
                      if (spo2Snapshot.hasData)
                        Text(
                          '$spo2 %',
                          style: TextStyle(
                              fontSize: widget.refactor == 1 ? 50 : 30),
                        ),
                      SizedBox(height: 20),
                      Text(
                        state(),
                        style: TextStyle(fontSize: 40),
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: showButton
                            ? ElevatedButton(
                                onPressed: () {
                                  _Modelsheet(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Color.fromARGB(255, 218, 228, 227),
                                ),
                                child: Text(
                                  getConseil(),
                                  style: TextStyle(fontSize: 25),
                                ),
                              )
                            : CircularProgressIndicator(), // Display a loading indicator while waiting
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (freqSnapshot.hasError) {
            return Text('Error: ${freqSnapshot.error}');
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  void _Modelsheet(context) {
    showModalBottomSheet<void>(
      shape: RoundedRectangleBorder(
        //the rounded corner is created here
        borderRadius: BorderRadius.circular(10.0),
      ),
      context: context,
      builder: (BuildContext context) {
        //return MyCustomForm();

        return Container(
            height: 600,
            child: PageConseilHR(lang: widget.lang, state: predValue));
      },
    );
  }

  // Color changeColor(int? hb) {
  //   if (hb == null) {
  //     // Handle the case where freq is null, e.g., return a default color.
  //     return Colors.transparent;
  //   }

  //   if (hb < 80) {
  //     return Colors.green.shade300;
  //   } else if (80 <= hb && hb <= 84) {
  //     return Colors.green;
  //   } else if (85 <= hb && hb <= 89) {
  //     return Colors.yellow.shade300;
  //   } else if (90 <= hb && hb <= 99) {
  //     return Colors.red.shade300;
  //   } else if (100 <= hb && hb <= 109) {
  //     return Colors.red;
  //   } else if (110 <= hb) {
  //     return Colors.red.shade900;
  //   }

  //   return Colors.transparent;
  // }
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

  String getConseil() {
    switch (widget.lang) {
      case 'fr':
        return Intl.message('Conseil', name: 'clickMeText', locale: 'fr');
      case 'en':
        return Intl.message('Advise', name: 'clickMeText', locale: 'en');
      case 'ar':
        return Intl.message('نصيحة', name: 'clickMeText', locale: 'ar');
      default:
        return Intl.message('نصيحة', name: 'clickMeText', locale: 'en');
    }
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
  String state0() {
    switch (widget.lang) {
      case 'fr':
        return "état stable";
      case 'en':
        return "stable condition";
      case 'ar':
        return "حالة مستقرة";
      default:
        return "حالة مستقرة";
    }
  }

  String state1() {
    switch (widget.lang) {
      case 'fr':
        return "état instable";
      case 'en':
        return "unstable condition";
      case 'ar':
        return "حالة غير مستقرة";
      default:
        return "حالة غير مستقرة";
    }
  }

  String state2() {
    switch (widget.lang) {
      case 'fr':
        return "état grave";
      case 'en':
        return "serious condition";
      case 'ar':
        return "حالة خطيرة";
      default:
        return "حالة خطيرة";
    }
  }

  String state() {
    switch (predValue) {
      case '0':
        return state0();
      case '1':
        return state1();
      case '2':
        return state2();
      default:
        return "";
    }
  }
}

// freqAnimation class as provided earlier
class freqAnimation extends StatefulWidget {
  freqAnimation({super.key, required this.ref});
  final int ref;
  @override
  _freqAnimationState createState() => _freqAnimationState();
}

class _freqAnimationState extends State<freqAnimation>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _animation = Tween<double>(begin: 20.0, end: 30.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.repeat(reverse: true);

    // Simulate a normal freq rhythm with a delay
    Timer.periodic(Duration(seconds: 1000), (timer) {
      if (_controller != null && _controller.isAnimating) {
        _controller.forward(from: 0);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Container(
                  height: _width / 2,
                  width: _width,
                  child: widget.ref == 0
                      ? Icon(
                          Icons.favorite,
                          size: _animation.value * 7,
                          color: Color(0xFFFF5757),
                        )
                      : Image.asset("assets/images/oxygensaturation.png"));
            },
          ),
        ],
      ),
    );
  }
}

// EcgPainter class remains unchanged
class EcgPainter extends CustomPainter {
  final double animationValue;

  EcgPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    // ECG drawing logic remains unchanged
    // ...
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
  // String getResult1() {
  //   switch (widget.lang) {
  //     case 'fr':
  //       return Intl.message('Optimale', name: 'clickMeText', locale: 'fr');
  //     case 'en':
  //       return Intl.message('Optimal', name: 'clickMeText', locale: 'en');
  //     case 'ar':
  //       return Intl.message('الأمثل', name: 'clickMeText', locale: 'ar');
  //     default:
  //       return Intl.message('Optimal', name: 'clickMeText', locale: 'en');
  //   }
  // }

  // String getResult2() {
  //   switch (widget.lang) {
  //     case 'fr':
  //       return Intl.message('Normale', name: 'clickMeText', locale: 'fr');
  //     case 'en':
  //       return Intl.message('Normal', name: 'clickMeText', locale: 'en');
  //     case 'ar':
  //       return Intl.message('طبيعي', name: 'clickMeText', locale: 'ar');
  //     default:
  //       return Intl.message('Normal', name: 'clickMeText', locale: 'en');
  //   }
  // }

  // String getResult3() {
  //   switch (widget.lang) {
  //     case 'fr':
  //       return Intl.message('Normale Haute', name: 'clickMeText', locale: 'fr');
  //     case 'en':
  //       return Intl.message('Haut Normal', name: 'clickMeText', locale: 'en');
  //     case 'ar':
  //       return Intl.message('ارتفاع طبيعي', name: 'clickMeText', locale: 'ar');
  //     default:
  //       return Intl.message('Normale Haute', name: 'clickMeText', locale: 'en');
  //   }
  // }

  // String getResult4() {
  //   switch (widget.lang) {
  //     case 'fr':
  //       return Intl.message('Hypertension grade 1',
  //           name: 'clickMeText', locale: 'fr');
  //     case 'en':
  //       return Intl.message('Hypertension grade 1',
  //           name: 'clickMeText', locale: 'en');
  //     case 'ar':
  //       return Intl.message('ارتفاع ضغط الدم الصنف 1',
  //           name: 'clickMeText', locale: 'ar');
  //     default:
  //       return Intl.message('Hypertension grade 1',
  //           name: 'clickMeText', locale: 'en');
  //   }
  // }

  // String getResult5() {
  //   switch (widget.lang) {
  //     case 'fr':
  //       return Intl.message('Hypertension grade 2',
  //           name: 'clickMeText', locale: 'fr');
  //     case 'en':
  //       return Intl.message('Hypertension grade 2',
  //           name: 'clickMeText', locale: 'en');
  //     case 'ar':
  //       return Intl.message('ارتفاع ضغط الدم الصنف 2',
  //           name: 'clickMeText', locale: 'ar');
  //     default:
  //       return Intl.message('Hypertension grade 2',
  //           name: 'clickMeText', locale: 'en');
  //   }
  // }

  // String getResult6() {
  //   switch (widget.lang) {
  //     case 'fr':
  //       return Intl.message('Hypertension grade 3',
  //           name: 'clickMeText', locale: 'fr');
  //     case 'en':
  //       return Intl.message('Hypertension grade 3',
  //           name: 'clickMeText', locale: 'en');
  //     case 'ar':
  //       return Intl.message('ارتفاع ضغط الدم الصنف 3',
  //           name: 'clickMeText', locale: 'ar');
  //     default:
  //       return Intl.message('Hypertension grade 3',
  //           name: 'clickMeText', locale: 'en');
  //   }
  // }

  // String getRes(int? hb) {
  //   if (hb == null) {
  //     // Handle the case where freq is null, e.g., return a default color.
  //     return "loading...";
  //   }
  //   if (hb < 80) {
  //     return getResult1();
  //   } else if (80 <= hb && hb <= 84) {
  //     return getResult2();
  //   } else if (85 <= hb && hb <= 89) {
  //     return getResult3();
  //   } else if (90 <= hb && hb <= 99) {
  //     return getResult4();
  //   } else if (100 <= hb && hb <= 109) {
  //     return getResult5();
  //   } else if (110 <= hb) {
  //     return getResult6();
  //   }
  //   return getResult1();
  // }