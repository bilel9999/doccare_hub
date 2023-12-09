import 'package:doccare_hub/Views/HR/hr.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PageChoix extends StatefulWidget {
  const PageChoix(
      {Key? key, required this.lang, required this.id, required this.age})
      : super(key: key);
  final String lang;
  final String id;
  final int age;

  @override
  State<PageChoix> createState() => _PageChoixState();
}

class _PageChoixState extends State<PageChoix> {
  double opacite = 1.0;

  @override
  Widget build(BuildContext context) {
    var size, height, width;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back),
        backgroundColor: Colors.transparent,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.red.shade100, Colors.blue.shade100],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(),
              InkResponse(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EcgPage(
                          lang: widget.lang,
                          id: widget.id,
                          refactor: 0,
                          age: widget.age),
                    ),
                  );
                },
                child: Opacity(
                  opacity: opacite,
                  child: Image.asset(
                    imgHB(),
                    width: 300,
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.1,
              ),
              InkResponse(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EcgPage(
                          lang: widget.lang,
                          id: widget.id,
                          refactor: 1,
                          age: widget.age),
                    ),
                  );
                },
                child: Opacity(
                  opacity: opacite,
                  child: Image.asset(
                    imgSP(),
                    width: 300,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String imgHB() {
    switch (widget.lang) {
      case 'fr':
        return 'assets/images/Français/HeartbeatMonitor.png';
      case 'en':
        return 'assets/images/English/HeartbeatMonitor.png';
      case 'ar':
        return 'assets/images/Arabic/HeartbeatMonitor.png';

      default:
        return 'assets/images/Arabic/HeartbeatMonitor.png';
    }
  }

  String imgSP() {
    switch (widget.lang) {
      case 'fr':
        return 'assets/images/Français/SO2.png';
      case 'en':
        return 'assets/images/English/SO2.png';
      case 'ar':
        return 'assets/images/Arabic/SO2.png';

      default:
        return 'assets/images/Arabic/SO2.png';
    }
  }
}
