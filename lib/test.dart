import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  DatabaseReference dbRef = FirebaseDatabase.instance.ref('app');
  int? freq;
  int? spo2;
  @override
  void initState() {
    super.initState();
    readData();
  }

  void readData() async {
    DataSnapshot snapshot = await dbRef.get();
    if (snapshot.exists) {
      setState(() {
        freq = snapshot.child('freq').value as int?;
        spo2 = snapshot.child('spo2').value as int?;
      });
    } else {
      print('No data available.');
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Database Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Frequency: ${freq ?? 'Not available'}'),
            Text('SpO2: ${spo2 ?? 'Not available'}'),
          ],
        ),
      ),
    );
  }
}
