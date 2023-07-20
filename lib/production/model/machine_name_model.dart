// To parse this JSON data, do
//
//     final machineNameModel = machineNameModelFromJson(jsonString);

import 'dart:convert';

List<MachineNameModel> machineNameModelFromJson(String str) => List<MachineNameModel>.from(json.decode(str).map((x) => MachineNameModel.fromJson(x)));

String machineNameModelToJson(List<MachineNameModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MachineNameModel {
  String xcode;
  String xlong;

  MachineNameModel({
    required this.xcode,
    required this.xlong,
  });

  factory MachineNameModel.fromJson(Map<String, dynamic> json) => MachineNameModel(
    xcode: json["xcode"],
    xlong: json["xlong"],
  );

  Map<String, dynamic> toJson() => {
    "xcode": xcode,
    "xlong": xlong,
  };
}
