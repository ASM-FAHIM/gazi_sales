// To parse this JSON data, do
//
//     final bankBalanceModel = bankBalanceModelFromJson(jsonString);

import 'dart:convert';

BankBalanceModel bankBalanceModelFromJson(String str) => BankBalanceModel.fromJson(json.decode(str));

String bankBalanceModelToJson(BankBalanceModel data) => json.encode(data.toJson());

class BankBalanceModel {
  String gcashinhand;
  String gcashatbank;
  String gbankloan;
  String gpayable;
  String greceivable;

  BankBalanceModel({
    required this.gcashinhand,
    required this.gcashatbank,
    required this.gbankloan,
    required this.gpayable,
    required this.greceivable,
  });

  factory BankBalanceModel.fromJson(Map<String, dynamic> json) => BankBalanceModel(
    gcashinhand: json["gcashinhand"],
    gcashatbank: json["gcashatbank"],
    gbankloan: json["gbankloan"],
    gpayable: json["gpayable"],
    greceivable: json["greceivable"],
  );

  Map<String, dynamic> toJson() => {
    "gcashinhand": gcashinhand,
    "gcashatbank": gcashatbank,
    "gbankloan": gbankloan,
    "gpayable": gpayable,
    "greceivable": greceivable,
  };
}
