// To parse this JSON data, do
//
//     final pendingSoModel = pendingSoModelFromJson(jsonString);

import 'dart:convert';

List<PendingSoModel> pendingSoModelFromJson(String str) =>
    List<PendingSoModel>.from(
        json.decode(str).map((x) => PendingSoModel.fromJson(x)));

String pendingSoModelToJson(List<PendingSoModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PendingSoModel {
  String xsonumber;
  String xdate;

  PendingSoModel({
    required this.xsonumber,
    required this.xdate,
  });

  factory PendingSoModel.fromJson(Map<String, dynamic> json) => PendingSoModel(
        xsonumber: json["xsonumber"],
        xdate: json["xdate"],
      );

  Map<String, dynamic> toJson() => {
        "xsonumber": xsonumber,
        "xdate": xdate,
      };
}
