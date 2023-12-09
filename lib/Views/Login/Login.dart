import 'package:doccare_hub/Views/Login/id.dart';
import 'package:doccare_hub/api/MedicalMeasureApi.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key, required this.lang}) : super(key: key);
  final String lang;
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController _idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size, height, width;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    return Scaffold(
      body: Column(
        children: [
          Spacer(), // Ajouter de l'espace en haut
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  Profile(),
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage("assets/images/profile.png"),
                ),
                SizedBox(height: 25.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.0),
                  child: TextField(
                    controller: _idController,
                    decoration: InputDecoration(
                      labelText: EnterId(),
                      prefixIcon: Container(
                        width: 16.0,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    String id = _idController.text;
                    print("id    " + _idController.text.toString());
                    // final Future<Map<String, dynamic>>  data =
                    // await    MedicalMeasureApi.signin({"code": _idController.text})
                    //         as Future<Map<String, dynamic>>;

                    final Map<String, dynamic>? data =
                        await MedicalMeasureApi.signin(
                            {"code": _idController.text});

                    int age = data?["age"];
                    print(age);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            IDPage(enteredID: id, lang: widget.lang, age: age),
                      ),
                    );
                  },
                  child: Container(
                    width: 100.0,
                    child: Center(
                      child: Text(Signin()),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
              ],
            ),
          ),
          Spacer(), // Ajouter de l'espace en bas
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
    );
  }

  String Profile() {
    switch (widget.lang) {
      case 'fr':
        return Intl.message('Profil', name: 'clickMeText', locale: 'fr');
      case 'en':
        return Intl.message('Profile', name: 'clickMeText', locale: 'en');
      case 'ar':
        return Intl.message('حساب', name: 'clickMeText', locale: 'ar');
      default:
        return Intl.message('حساب', name: 'clickMeText', locale: 'en');
    }
  }

  String EnterId() {
    switch (widget.lang) {
      case 'fr':
        return Intl.message('Entrez votre ID',
            name: 'clickMeText', locale: 'fr');
      case 'en':
        return Intl.message('Enter your ID', name: 'clickMeText', locale: 'en');
      case 'ar':
        return Intl.message('أدخل المعرف', name: 'clickMeText', locale: 'ar');
      default:
        return Intl.message('أدخل المعرف', name: 'clickMeText', locale: 'en');
    }
  }

  String Signin() {
    switch (widget.lang) {
      case 'fr':
        return Intl.message('Se connecter', name: 'clickMeText', locale: 'fr');
      case 'en':
        return Intl.message('Sign In', name: 'clickMeText', locale: 'en');
      case 'ar':
        return Intl.message('تسجيل الدخول', name: 'clickMeText', locale: 'ar');
      default:
        return Intl.message('تسجيل الدخول', name: 'clickMeText', locale: 'en');
    }
  }
}
