import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PageConseil extends StatefulWidget {
  const PageConseil({super.key, required this.lang, required this.spo2});
  final String lang;
  final int spo2;
  @override
  State<PageConseil> createState() => _PageConseilState();
}

class _PageConseilState extends State<PageConseil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.spo2.toString() + " " + widget.lang),
      ),
      body: Container(
        child: Text(getResult()),
      ),
    );
  }

  String getResult() {
    switch (widget.lang) {
      case 'fr':
        {
          if (widget.spo2 <= 120) { 
            return " ";
          } else if (120 <= widget.spo2 && widget.spo2 <= 129) {
            return " ";
          } else if (130 <= widget.spo2 && widget.spo2 <= 139) {
            return " ";
          } else if (140 <= widget.spo2 && widget.spo2 <= 159) {
            return " ";
          } else if (160 <= widget.spo2 && widget.spo2 <= 179) {
            return " ";
          } else if (180 <= widget.spo2) {
            return " ";
          }
          return " ";
        }
      case 'en':
        {
          if (widget.spo2 <= 120) {
            return " ";
          } else if (120 <= widget.spo2 && widget.spo2 <= 129) {
            return " ";
          } else if (130 <= widget.spo2 && widget.spo2 <= 139) {
            return " ";
          } else if (140 <= widget.spo2 && widget.spo2 <= 159) {
            return " ";
          } else if (160 <= widget.spo2 && widget.spo2 <= 179) {
            return " ";
          } else if (180 <= widget.spo2) {
            return " ";
          }
          return " ";
        }
      case 'ar':
        {
          if (widget.spo2 <= 120) {
            return " ";
          } else if (120 <= widget.spo2 && widget.spo2 <= 129) {
            return " ";
          } else if (130 <= widget.spo2 && widget.spo2 <= 139) {
            return " ";
          } else if (140 <= widget.spo2 && widget.spo2 <= 159) {
            return " ";
          } else if (160 <= widget.spo2 && widget.spo2 <= 179) {
            return " ";
          } else if (180 <= widget.spo2) {
            return " ";
          }
          return " ";
        }
      default:
        {
          if (widget.spo2 <= 120) {
            return " ";
          } else if (120 <= widget.spo2 && widget.spo2 <= 129) {
            return " ";
          } else if (130 <= widget.spo2 && widget.spo2 <= 139) {
            return " ";
          } else if (140 <= widget.spo2 && widget.spo2 <= 159) {
            return " ";
          } else if (160 <= widget.spo2 && widget.spo2 <= 179) {
            return " ";
          } else if (180 <= widget.spo2) {
            return " ";
          }
          return " ";
        }
    }
  }
}
