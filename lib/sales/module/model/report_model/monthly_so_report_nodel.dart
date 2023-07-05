// To parse this JSON data, do
//
//     final monthlySoModel = monthlySoModelFromJson(jsonString);

import 'dart:convert';

List<MonthlySoModel> monthlySoModelFromJson(String str) =>
    List<MonthlySoModel>.from(
        json.decode(str).map((x) => MonthlySoModel.fromJson(x)));

String monthlySoModelToJson(List<MonthlySoModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MonthlySoModel {
  String xsonumber;
  String xdate;

  MonthlySoModel({
    required this.xsonumber,
    required this.xdate,
  });

  factory MonthlySoModel.fromJson(Map<String, dynamic> json) => MonthlySoModel(
        xsonumber: json["xsonumber"],
        xdate: json["xdate"],
      );

  Map<String, dynamic> toJson() => {
        "xsonumber": xsonumber,
        "xdate": xdate,
      };
}
