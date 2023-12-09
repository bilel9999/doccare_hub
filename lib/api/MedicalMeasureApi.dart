import 'dart:convert';

import 'package:doccare_hub/Model/MedicalMeasure.dart';
import 'package:http/http.dart' as http_library;
import 'package:http/http.dart' as http;

class MedicalMeasureApi {
  static String path = 'https://f90f-196-203-24-105.ngrok-free.app';
  static Future<List<MedicalMeasure>> fetchHistory(String id) async {
    final http_library.Client client = http_library.Client();
    final response =
        // ignore: unnecessary_this
        await client.get(Uri.parse('$path/api/patient/history/code/$id'));
    List<MedicalMeasure> activities = [];
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      for (var i = 0; i < jsonData.length; i++) {
        activities.add(MedicalMeasure.fromJson(jsonData[i]));
      }

      return activities;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  static Future<Map<String, dynamic>?> signin(
      Map<String, dynamic> measurements) async {
    final Uri uri =
        Uri.parse('$path/api/patient/'); // Replace with your API endpoint

    try {
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(measurements),
      );

      if (response.statusCode == 200) {
        print('signin sent successfully');
        print(response.body);
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
        // print(response.body[0].toString());
        // MedicalMeasure data =
        //     MedicalMeasure.fromJson(response.body as Map<String, dynamic>);
      } else {
        print('Failed to send signin. Status code: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (error) {
      print('Error sending signin: $error');
      return null;
    }
    return null;
  }

  static Future<void> sendMedicalMeasurements(
      Map<String, dynamic> measurements) async {
    print(measurements);
    final Uri uri = Uri.parse(
        '$path/api/patient/measure'); // Replace with your API endpoint

    try {
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(measurements),
      );

      if (response.statusCode == 200) {
        print('Measurement sent successfully');
      } else {
        print(
            'Failed to send measurement. Status code: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (error) {
      print('Error sending measurement: $error');
    }
  }
}
