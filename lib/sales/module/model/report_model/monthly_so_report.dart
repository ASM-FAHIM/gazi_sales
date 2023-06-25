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
  int zid;
  String xcus;
  String dealerName;
  String xpnature;
  String xbalance;

  MonthlySoModel({
    required this.zid,
    required this.xcus,
    required this.dealerName,
    required this.xpnature,
    required this.xbalance,
  });

  factory MonthlySoModel.fromJson(Map<String, dynamic> json) => MonthlySoModel(
        zid: json["zid"],
        xcus: json["xcus"],
        dealerName: json["dealerName"],
        xpnature: json["xpnature"],
        xbalance: json["xbalance"],
      );

  Map<String, dynamic> toJson() => {
        "zid": zid,
        "xcus": xcus,
        "dealerName": dealerName,
        "xpnature": xpnature,
        "xbalance": xbalance,
      };
}
