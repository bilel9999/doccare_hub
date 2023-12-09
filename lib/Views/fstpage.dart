import 'package:doccare_hub/Views/FrontPage.dart';
import 'package:flutter/material.dart';


// Importez vos autres fichiers nécessaires ici

class DelayPage extends StatefulWidget {
  const DelayPage({super.key});

  @override
  State<DelayPage> createState() => _DelayPageState();
}

class _DelayPageState extends State<DelayPage> {
  void initState() {
    super.initState();

    // Set the duration of the splash screen
    const splashDuration = Duration(seconds: 2);

    // Use Future.delayed to wait for the specified duration
    Future.delayed(splashDuration, () {
      // Navigate to the next page after the splash screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => FrontPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var size, height, width;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            // Naviguer vers une autre interface
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FrontPage(),
              ),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Image.asset(
                  'assets/images/embsimg.png',
                  width: width * 0.9,
                  // Set the height as per your design
                ),
              ),
              Text(
                'IEEE',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFFD33D3D)),
              ),
              Text(
                'HEALTHCARE',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFFD33D3D)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
