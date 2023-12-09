import 'package:doccare_hub/Views/Login/Login.dart';
import 'package:doccare_hub/Views/Pagechoix.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class FrontPage extends StatefulWidget {
  const FrontPage({Key? key}) : super(key: key);

  @override
  _FrontPageState createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {
  String _selectedLanguage = 'ar';

  void _changeLanguage(String languageCode) {
    setState(() {
      _selectedLanguage = languageCode;
    });
  }

  @override
  Widget build(BuildContext context) {
    DatabaseReference dbRef = FirebaseDatabase.instance.ref('app');

    @override
    initState() {
      super.initState();
      dbRef.child('watchState').set(1);
    }

    var size, height, width;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Language selection row (1/10 of the page)
            Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: DropdownButton<String>(
                        value: _selectedLanguage,
                        underline: Container(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedLanguage = newValue!;
                          });
                        },
                        style: TextStyle(
                          fontSize: 20,
                          color:
                              Colors.grey, // Choisissez votre couleur préférée
                        ),
                        items: [
                          DropdownMenuItem<String>(
                            value: 'fr',
                            child: Row(
                              children: [
                                SizedBox(width: 10),
                                Image.asset(
                                  'assets/images/flags/frflag.png',
                                )
                              ],
                            ),
                          ),
                          DropdownMenuItem<String>(
                            value: 'en',
                            child: Row(
                              children: [
                                SizedBox(width: 10),
                                ClipOval(
                                  child: Image.asset(
                                    'assets/images/flags/ukflag.png',
                                  ),
                                )
                              ],
                            ),
                          ),
                          DropdownMenuItem<String>(
                            value: 'ar',
                            child: Row(
                              children: [
                                SizedBox(width: 10),
                                ClipOval(
                                  child: Image.asset(
                                    'assets/images/flags/tnflag.png',
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Image display
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 10,
                      blurRadius: 19,
                      offset: Offset(0, 10),
                    ),
                  ],
                  shape: BoxShape.circle, // Forme de cercle pour l'image
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/embsimg.png',
                    fit: BoxFit
                        .cover, // Assurez-vous que l'image couvre complètement le cercle
                    // Réglez la hauteur selon votre conception
                  ),
                ),
              ),
            ),

            SizedBox(
              height: height * 0.05,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
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
                      SizedBox(
                        height: height * 0.01,
                      ),
                      // Elevated Button (Center of the page)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
                        child: Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              // Navigate to MyHomePage when the button is clicked
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        SignInPage(lang: _selectedLanguage)),
                              );
                            },
                            child: Text(
                              getButtonText(),
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              // Navigate to MyHomePage when the button is clicked
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PageChoix(
                                          lang: _selectedLanguage,
                                          id: '0', age : 35
                                        )),
                              );
                            },
                            child: Text(
                              getButtonText1(),
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                        ),
                      ),
                    ]),
              ),
            ),

            // Additional text (Bottom of the page)
            Container(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: Text("#Team_Builds_Dreams"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Build flag button
  Widget _buildFlagButton(String path, String languageCode) {
    return GestureDetector(
      onTap: () => _changeLanguage(languageCode),
      child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: _selectedLanguage == languageCode
                ? Border.all(color: Colors.blue, width: 2)
                : null,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Image.asset(
            path,
            width: 20,
          )),
    );
  }

  // Get button text based on selected language
  String getButtonText() {
    switch (_selectedLanguage) {
      case 'fr':
        return Intl.message('se connecter', name: 'clickMeText', locale: 'fr');
      case 'en':
        return Intl.message('sign in', name: 'clickMeText', locale: 'en');
      case 'ar':
        return Intl.message('تسجيل الدخول', name: 'clickMeText', locale: 'ar');
      default:
        return Intl.message('تسجيل الدخول', name: 'clickMeText', locale: 'en');
    }
  }

  String getButtonText1() {
    switch (_selectedLanguage) {
      case 'fr':
        return Intl.message('Cliquez ici', name: 'clickMeText', locale: 'fr');
      case 'en':
        return Intl.message('Click here', name: 'clickMeText', locale: 'en');
      case 'ar':
        return Intl.message('انقر هنا', name: 'clickMeText', locale: 'ar');
      default:
        return Intl.message('انقر هنا', name: 'clickMeText', locale: 'en');
    }
  }
}
//i18n
