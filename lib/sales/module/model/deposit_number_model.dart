// To parse this JSON data, do
//
//     final depositNumModel = depositNumModelFromJson(jsonString);

import 'dart:convert';

DepositNumModel depositNumModelFromJson(String str) => DepositNumModel.fromJson(json.decode(str));

String depositNumModelToJson(DepositNumModel data) => json.encode(data.toJson());

class DepositNumModel {
  String dPnum;

  DepositNumModel({
    required this.dPnum,
  });

  factory DepositNumModel.fromJson(Map<String, dynamic> json) => DepositNumModel(
    dPnum: json["DPnum"],
  );

  Map<String, dynamic> toJson() => {
    "DPnum": dPnum,
  };
}
