import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';


class SecPage extends StatefulWidget {
  const SecPage({super.key, required this.lang, required this.id});
  final String lang;
  final String id;

  @override
  State<SecPage> createState() => _SecPageState();
}

// class _SecPageState extends State<SecPage> {
//   StreamController<int?> _spo2StreamController =
//       StreamController<int?>.broadcast();
//   Stream<int?> get spo2Stream => _spo2StreamController.stream;
//   DatabaseReference dbRef = FirebaseDatabase.instance.ref('app');

//   List<int> spo2Values = [];
//   late Timer _timer; // Declare the timer variable

//   @override
//   void initState() {
//     super.initState();
//     startTimer();
//   }

//   void startTimer() {
//     _timer = Timer.periodic(Duration(milliseconds: 200), (timer) {
//       readData(); // Read data from Firebase every 200 milliseconds
//     });

//     // Stop the timer after 5 seconds
//     Timer(Duration(seconds: 5), () {
//       _timer.cancel();
//       calculateMean();
//     });
//   }

//   void readData() {
//     dbRef.child('spo2').onValue.listen((event) {
//       if (event.snapshot.exists) {
//         int? spo2 = event.snapshot.value as int?;
//         _spo2StreamController.add(spo2);
//         spo2Values.add(spo2 ?? 0); // Add Spo2 value to the list
//       } else {
//         print('No data available.');
//       }
//     });
//   }

//   void calculateMean() {
//     if (spo2Values.isNotEmpty) {
//       double mean = spo2Values.reduce((a, b) => a + b) / spo2Values.length;
//       print('Mean Spo2 value: $mean');
//       // Add your further processing or UI updates with the mean value here
//     } else {
//       print('No Spo2 values recorded.');
//     }
//   }

//   @override
//   void dispose() {
//     _spo2StreamController.close(); // Close the stream controller
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var size, height, width;
//     size = MediaQuery.of(context).size;
//     height = size.height;
//     width = size.width;

//     return Scaffold(
//       appBar: AppBar(title: Text(widget.lang)),
//       // body: Container(
//       //   decoration: BoxDecoration(
//       //       gradient: LinearGradient(
//       //           colors: [Colors.white, Colors.greenAccent],
//       //           begin: Alignment.topCenter,
//       //           end: Alignment.bottomCenter)),
//       //   child: Center(
//       //     child: Column(
//       //       mainAxisAlignment: MainAxisAlignment.center,
//       //       crossAxisAlignment: CrossAxisAlignment.center,
//       //       children: [
//       //         Row(
//       //           mainAxisAlignment: MainAxisAlignment.center,
//       //           crossAxisAlignment: CrossAxisAlignment.end,
//       //           children: [
//       //             Text(
//       //               "${spo_2 ?? 'Loading...'} %",
//       //               style: TextStyle(fontSize: 50),
//       //             ),
//       //           ],
//       //         ),
//       //         // Text(
//       //         //   getRes(spo_2),
//       //         //   style: TextStyle(fontSize: 50),
//       //         // ),
//       //         TextButton.icon(
//       //             onPressed: () {
//       //               _Modelsheet(context);
//       //             },
//       //             icon: Icon(Icons.forward),
//       //             label: Text(getConseil()))
//       //       ],
//       //     ),
//       //   ),
//       // ),
//       body: StreamBuilder<int?>(
//         stream: spo2Stream,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             int? spo2 = snapshot.data;
//             // Update the background color based on real-time data

//             return Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     Colors.white,
//                     Colors.green.shade300
//                   ], // Initial colors
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                 ),
//               ),
//               child: Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     SizedBox(
//                       height: 100,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: [
//                         Text(
//                           '${spo2}',
//                           style: TextStyle(fontSize: 50),
//                         ),
//                         Text(
//                           "%",
//                           style: TextStyle(fontSize: 20),
//                         ),
//                       ],
//                     ),
//                     // Text(
//                     //   getRes(freq),
//                     //   style: TextStyle(fontSize: 40),
//                     // ),
//                     TextButton.icon(
//                       onPressed: () {
//                         _Modelsheet(context);
//                       },
//                       icon: Icon(Icons.forward),
//                       label: Text(getConseil()),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           } else if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           } else {
//             return Center(child: Text('Loading...'));
//           }
//         },
//       ),
//     );
//   }

//   void _Modelsheet(context) {
//     showModalBottomSheet<void>(
//       shape: RoundedRectangleBorder(
//         //the rounded corner is created here
//         borderRadius: BorderRadius.circular(10.0),
//       ),
//       context: context,
//       builder: (BuildContext context) {
//         //return MyCustomForm();

//         return Container(
//             height: 600, child: PageConseil(lang: widget.lang, spo2: 10));
//       },
//     );
//   }

//   // Color changeColor(spo2) {
//   //   if (spo2 <= 120) {
//   //     return Colors.green.shade300;
//   //   } else if (120 <= spo2 && spo2 <= 129) {
//   //     return Colors.green;
//   //   } else if (130 <= spo2 && spo2 <= 139) {
//   //     return Colors.yellow.shade300;
//   //   } else if (140 <= spo2 && spo2 <= 159) {
//   //     return Colors.red.shade300;
//   //   } else if (160 <= spo2 && spo2 <= 179) {
//   //     return Colors.red;
//   //   } else if (180 <= spo2) {
//   //     return Colors.red.shade900;
//   //   }
//   //   return Colors.transparent;
//   // }

//   String getConseil() {
//     switch (widget.lang) {
//       case 'fr':
//         return Intl.message('Conseil', name: 'clickMeText', locale: 'fr');
//       case 'en':
//         return Intl.message('Advise', name: 'clickMeText', locale: 'en');
//       case 'ar':
//         return Intl.message('نصيحة', name: 'clickMeText', locale: 'ar');
//       default:
//         return Intl.message('Conseil', name: 'clickMeText', locale: 'en');
//     }
//   }

//   String getResult1() {
//     switch (widget.lang) {
//       case 'fr':
//         return Intl.message('Optimale', name: 'clickMeText', locale: 'fr');
//       case 'en':
//         return Intl.message('Optimal', name: 'clickMeText', locale: 'en');
//       case 'ar':
//         return Intl.message('الأمثل', name: 'clickMeText', locale: 'ar');
//       default:
//         return Intl.message('Optimal', name: 'clickMeText', locale: 'en');
//     }
//   }

//   String getResult2() {
//     switch (widget.lang) {
//       case 'fr':
//         return Intl.message('Normale', name: 'clickMeText', locale: 'fr');
//       case 'en':
//         return Intl.message('Normal', name: 'clickMeText', locale: 'en');
//       case 'ar':
//         return Intl.message('طبيعي', name: 'clickMeText', locale: 'ar');
//       default:
//         return Intl.message('Normal', name: 'clickMeText', locale: 'en');
//     }
//   }

//   String getResult3() {
//     switch (widget.lang) {
//       case 'fr':
//         return Intl.message('Normale Haute', name: 'clickMeText', locale: 'fr');
//       case 'en':
//         return Intl.message('Haut Normal', name: 'clickMeText', locale: 'en');
//       case 'ar':
//         return Intl.message('ارتفاع طبيعي', name: 'clickMeText', locale: 'ar');
//       default:
//         return Intl.message('Normale Haute', name: 'clickMeText', locale: 'en');
//     }
//   }

//   String getResult4() {
//     switch (widget.lang) {
//       case 'fr':
//         return Intl.message('Hyperspo2 grade 1',
//             name: 'clickMeText', locale: 'fr');
//       case 'en':
//         return Intl.message('Hyperspo2 grade 1',
//             name: 'clickMeText', locale: 'en');
//       case 'ar':
//         return Intl.message('ارتفاع ضغط الدم الصنف 1',
//             name: 'clickMeText', locale: 'ar');
//       default:
//         return Intl.message('Hyperspo2 grade 1',
//             name: 'clickMeText', locale: 'en');
//     }
//   }

//   String getResult5() {
//     switch (widget.lang) {
//       case 'fr':
//         return Intl.message('Hyperspo2 grade 2',
//             name: 'clickMeText', locale: 'fr');
//       case 'en':
//         return Intl.message('Hyperspo2 grade 2',
//             name: 'clickMeText', locale: 'en');
//       case 'ar':
//         return Intl.message('ارتفاع ضغط الدم الصنف 2',
//             name: 'clickMeText', locale: 'ar');
//       default:
//         return Intl.message('Hyperspo2 grade 2',
//             name: 'clickMeText', locale: 'en');
//     }
//   }

//   String getResult6() {
//     switch (widget.lang) {
//       case 'fr':
//         return Intl.message('Hyperspo2 grade 3',
//             name: 'clickMeText', locale: 'fr');
//       case 'en':
//         return Intl.message('Hyperspo2 grade 3',
//             name: 'clickMeText', locale: 'en');
//       case 'ar':
//         return Intl.message('ارتفاع ضغط الدم الصنف 3',
//             name: 'clickMeText', locale: 'ar');
//       default:
//         return Intl.message('Hyperspo2 grade 3',
//             name: 'clickMeText', locale: 'en');
//     }
//   }

// //   String getRes(spo2) {
// //     if (spo2 <= 120) {
// //       return getResult1();
// //     } else if (120 <= spo2 && spo2 <= 129) {
// //       return getResult2();
// //     } else if (130 <= spo2 && spo2 <= 139) {
// //       return getResult3();
// //     } else if (140 <= spo2 && spo2 <= 159) {
// //       return getResult4();
// //     } else if (160 <= spo2 && spo2 <= 179) {
// //       return getResult5();
// //     } else if (180 <= spo2) {
// //       return getResult6();
// //     }
// //     return getResult1();
// //   }
// }

class _SecPageState extends State<SecPage> {
  StreamController<int?> _spo2StreamController =
      StreamController<int?>.broadcast();
  Stream<int?> get spo2Stream => _spo2StreamController.stream;
  DatabaseReference dbRef = FirebaseDatabase.instance.ref('app');

  List<int> spo2Values = [];
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(milliseconds: 200), (timer) {
      // Read data from Firebase every 200 milliseconds
      readData();
    });

    // Stop the timer after 5 seconds
    Timer(Duration(seconds: 5), () {
      _timer.cancel();
      calculateMean();
    });
  }

  void readData() {
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
    if (spo2Values.isNotEmpty) {
      double mean = 0;
      for (int i = 0; i < spo2Values.length; i++) mean += spo2Values[i];
      mean /= spo2Values.length;
      // double mean = spo2Values.reduce((a, b) => a + b) / spo2Values.length;
      print('Mean Spo2 value: $mean');
      // Add your further processing or UI updates with the mean value here
    } else {
      print('No Spo2 values recorded.');
    }
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    _spo2StreamController.close(); // Close the stream controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.lang)),
      body: StreamBuilder<int?>(
        stream: spo2Stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            int? spo2 = snapshot.data;
            // Update the background color based on real-time data

            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white,
                    Colors.green.shade300
                  ], // Initial colors
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${spo2 ?? 'loading...'}%',
                          style: TextStyle(fontSize: 50),
                        ),
                      ],
                    ),
                    // Text(
                    //   getRes(freq),
                    //   style: TextStyle(fontSize: 40),
                    // ),
                    // TextButton.icon(
                    //   onPressed: () {
                    //     _Modelsheet(context);
                    //   },
                    //   icon: Icon(Icons.forward),
                    //   label: Text(getConseil()),
                    // ),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Center(child: Text('Loading...'));
          }
        },
      ),
    );
  }
}
