// To parse this JSON data, do
//
//     final shiftModel = shiftModelFromJson(jsonString);

import 'dart:convert';

List<ShiftModel> shiftModelFromJson(String str) => List<ShiftModel>.from(json.decode(str).map((x) => ShiftModel.fromJson(x)));

String shiftModelToJson(List<ShiftModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ShiftModel {
  String xcode;
  String xlong;

  ShiftModel({
    required this.xcode,
    required this.xlong,
  });

  factory ShiftModel.fromJson(Map<String, dynamic> json) => ShiftModel(
    xcode: json["xcode"],
    xlong: json["xlong"],
  );

  Map<String, dynamic> toJson() => {
    "xcode": xcode,
    "xlong": xlong,
  };
}
