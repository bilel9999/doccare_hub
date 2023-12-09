import 'package:doccare_hub/Model/MedicalMeasure.dart';
import 'package:doccare_hub/api/MedicalMeasureApi.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CheckHistory extends StatefulWidget {
  CheckHistory({super.key, required this.id});
  String id;
  @override
  State<CheckHistory> createState() => _CheckHistoryState();
}

class _CheckHistoryState extends State<CheckHistory> {
  late Future<List<MedicalMeasure>> list;

  @override
  void initState() {
    super.initState();
    list = MedicalMeasureApi.fetchHistory(widget.id);
    print(list.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<MedicalMeasure>>(
        future: list,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text('No data available'),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                MedicalMeasure test = snapshot.data![index];
                // return ListTile(
                //   title: Text(test.id.toString() ?? ''),
                //   subtitle: Text("oxygenSaturation = " +
                //           test.oxygenSaturation.toString() +
                //           "\ncardiacFrequency = " +
                //           test.cardiacFrequency.toString() ??
                //       ''),
                // );
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.white70, bgstate(test.state)]),
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
                          Text(
                            DateFormat.yMMMEd().add_jm().format(test.getDate),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(
                                Icons.favorite,
                                color: Colors.red,
                                size: 24,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "Oxygen Saturation: " +
                                        test.oxygenSaturation.toString() ??
                                    '',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(
                                Icons.favorite_border,
                                color: Colors.red,
                                size: 24,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "Cardiac Frequency: " +
                                        test.cardiacFrequency.toString() ??
                                    '',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                
                );
              },
            );
          }
        },
      ),
    );
  }

  Color bgstate(state) {
    switch (state) {
      case 0:
        return Colors.green.shade300;
      case 1:
        return Colors.yellow.shade300;
      case 2:
        return Colors.red.shade300;
    }
    return Colors.green.shade300;
  }
}
