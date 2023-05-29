// To parse this JSON data, do
//
//     final bankListModel = bankListModelFromJson(jsonString);

import 'dart:convert';

List<BankListModel> bankListModelFromJson(String str) =>
    List<BankListModel>.from(
        json.decode(str).map((x) => BankListModel.fromJson(x)));

String bankListModelToJson(List<BankListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BankListModel {
  int id;
  int zid;
  String xbank;
  String xname;
  String xbranch;
  String xbacc;
  String xacc;

  BankListModel({
    required this.id,
    required this.zid,
    required this.xbank,
    required this.xname,
    required this.xbranch,
    required this.xbacc,
    required this.xacc,
  });

  factory BankListModel.fromJson(Map<String, dynamic> json) => BankListModel(
        id: json["id"],
        zid: json["zid"],
        xbank: json["xbank"],
        xname: json["xname"],
        xbranch: json["xbranch"],
        xbacc: json["xbacc"],
        xacc: json["xacc"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "zid": zid,
        "xbank": xbank,
        "xname": xname,
        "xbranch": xbranch,
        "xbacc": xbacc,
        "xacc": xacc,
      };
}
