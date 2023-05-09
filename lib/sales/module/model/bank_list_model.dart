// To parse this JSON data, do
//
//     final bankListModel = bankListModelFromJson(jsonString);

import 'dart:convert';

List<BankListModel> bankListModelFromJson(String str) => List<BankListModel>.from(json.decode(str).map((x) => BankListModel.fromJson(x)));

String bankListModelToJson(List<BankListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BankListModel {
  String xbank;
  String xname;

  BankListModel({
    required this.xbank,
    required this.xname,
  });

  factory BankListModel.fromJson(Map<String, dynamic> json) => BankListModel(
    xbank: json["xbank"],
    xname: json["xname"],
  );

  Map<String, dynamic> toJson() => {
    "xbank": xbank,
    "xname": xname,
  };
}
