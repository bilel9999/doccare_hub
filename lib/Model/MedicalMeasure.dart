import 'package:intl/intl.dart';

class MedicalMeasure {
  int? id;
  int? cardiacFrequency;
  int? oxygenSaturation;
  int? patientId;
  int? state;
  DateTime? date;

  MedicalMeasure({
    this.id,
    this.cardiacFrequency,
    this.oxygenSaturation,
    this.patientId,
    this.state,
    this.date,
  });
  factory MedicalMeasure.fromJson(Map<String, dynamic> json) => MedicalMeasure(
        id: json["id"],
        cardiacFrequency: json["cardiacFrequency"],
        oxygenSaturation: json["oxygenSaturation"],
        patientId: json["patientId"],
        state: json["state"],
        date: DateTime.parse(json["date"]),
      );
  get getId => this.id;

  set setId(id) => this.id = id;

  get getCardiacFrequency => this.cardiacFrequency;

  set setCardiacFrequency(cardiacFrequency) =>
      this.cardiacFrequency = cardiacFrequency;

  get getOxygenSaturation => this.oxygenSaturation;

  set setOxygenSaturation(oxygenSaturation) =>
      this.oxygenSaturation = oxygenSaturation;

  get getPatientId => this.patientId;

  set setPatientId(patientId) => this.patientId = patientId;

  get getState => this.state;

  set setState(state) => this.state = state;

  get getDate => this.date;

  set setDate(date) => this.date = date;
}
