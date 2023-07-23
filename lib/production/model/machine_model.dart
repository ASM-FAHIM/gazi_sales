// To parse this JSON data, do
//
//     final machineModel = machineModelFromJson(jsonString);

import 'dart:convert';

List<MachineModel> machineModelFromJson(String str) => List<MachineModel>.from(json.decode(str).map((x) => MachineModel.fromJson(x)));

String machineModelToJson(List<MachineModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MachineModel {
  String xcode;
  String xlong;

  MachineModel({
    required this.xcode,
    required this.xlong,
  });

  factory MachineModel.fromJson(Map<String, dynamic> json) => MachineModel(
    xcode: json["xcode"],
    xlong: json["xlong"],
  );

  Map<String, dynamic> toJson() => {
    "xcode": xcode,
    "xlong": xlong,
  };
}
