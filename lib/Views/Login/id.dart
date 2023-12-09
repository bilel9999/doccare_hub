import 'package:doccare_hub/Views/Pagechoix.dart';
import 'package:doccare_hub/Views/checkhistory.dart';
import 'package:doccare_hub/api/MedicalMeasureApi.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class IDPage extends StatelessWidget {
  IDPage({required this.enteredID, required this.lang, required this.age});
  String enteredID;
  String lang;
  int age;

  @override
  Widget build(BuildContext context) {
    var size, height, width;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage('assets/images/profile.png'),
            ),
            SizedBox(height: 16.0),
            Text(
              lang == "ar" ? ' $enteredID : ' + ID() : ID() + ': $enteredID',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 90),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 10,
                          offset: Offset(0, 10),
                        ),
                      ],
                      // Forme de cercle pour l'image
                    ),
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.grey[200], // Set light gray background color
                      ),
                      onPressed: () {
                        // Navigate to PageChoix when the button is clicked
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PageChoix(
                                  lang: lang, id: enteredID, age: age)),
                        );
                      },
                      child: Text(
                        Record(),
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 18,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 90),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 10,
                          offset: Offset(0, 10),
                        ),
                      ],
                      // Forme de cercle pour l'image
                    ),
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.grey[200], // Set light gray background color
                      ),
                      onPressed: () {
                        // Navigate to PageChoix when the button is clicked
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CheckHistory(id: enteredID)),
                        );
                      },
                      child: Text(
                        C_hist(),
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 90),
            //   child: Container(
            //     decoration: BoxDecoration(
            //       boxShadow: [
            //         BoxShadow(
            //           color: Colors.grey.withOpacity(0.3),
            //           spreadRadius: 1,
            //           blurRadius: 10,
            //           offset: Offset(0, 10),
            //         ),
            //       ],
            //       // Forme de cercle pour l'image
            //     ),
            //     width: double.infinity,
            //     child: ElevatedButton(
            //       style: ElevatedButton.styleFrom(
            //         backgroundColor:
            //             Colors.grey[200], // Set light gray background color
            //       ),
            //       onPressed: () {
            //         // Navigate to PageChoix when the button is clicked
            //         // MedicalMeasureApi.sendMedicalMeasurements({
            //         //   "cardiacFrequency": 100,
            //         //   "oxygenSaturation": 10,
            //         //   "patientId": 1,
            //         //   "state": 1
            //         // });
            //       },
            //       child: Text(
            //         'send',
            //         style: TextStyle(
            //           fontSize: 18.0,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),

            Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      'IEEE',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFFD33D3D)),
                    ),
                    SizedBox(
                      width: width * 0.02,
                    ),
                    const Text(
                      'HEALTHCARE',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFFD33D3D)),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  String ID() {
    switch (lang) {
      case 'fr':
        return Intl.message('ID', name: 'clickMeText', locale: 'fr');
      case 'en':
        return Intl.message('ID', name: 'clickMeText', locale: 'en');
      case 'ar':
        return Intl.message("الهوية", name: 'clickMeText', locale: 'ar');
      default:
        return Intl.message("الهوية", name: 'clickMeText', locale: 'en');
      // return Intl.message('المعرف', name: 'clickMeText', locale: 'en');
    }
  }

  String C_hist() {
    switch (lang) {
      case 'fr':
        return Intl.message("Vérifier l'historique des enregistrements",
            name: 'clickMeText', locale: 'fr');
      case 'en':
        return Intl.message('Check Record History',
            name: 'clickMeText', locale: 'en');
      case 'ar':
        return Intl.message("التحقق من تاريخ السجل",
            name: 'clickMeText', locale: 'ar');
      default:
        return Intl.message("التحقق من تاريخ السجل",
            name: 'clickMeText', locale: 'en');
      // return Intl.message('المعرف', name: 'clickMeText', locale: 'en');
    }
  }

  String Record() {
    switch (lang) {
      case 'fr':
        return Intl.message('Enregistrement',
            name: 'clickMeText', locale: 'fr');
      case 'en':
        return Intl.message('Record', name: 'clickMeText', locale: 'en');
      case 'ar':
        return Intl.message('تسجيل', name: 'clickMeText', locale: 'ar');
      default:
        return Intl.message('تسجيل', name: 'clickMeText', locale: 'en');
    }
  }
}
