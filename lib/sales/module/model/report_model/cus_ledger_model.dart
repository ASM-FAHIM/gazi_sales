// To parse this JSON data, do
//
//     final cusLedgerListModel = cusLedgerListModelFromJson(jsonString);

import 'dart:convert';

List<CusLedgerListModel> cusLedgerListModelFromJson(String str) =>
    List<CusLedgerListModel>.from(
        json.decode(str).map((x) => CusLedgerListModel.fromJson(x)));

String cusLedgerListModelToJson(List<CusLedgerListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CusLedgerListModel {
  int zid;
  String xcus;
  String dealerName;
  String xpnature;
  String xbalance;

  CusLedgerListModel({
    required this.zid,
    required this.xcus,
    required this.dealerName,
    required this.xpnature,
    required this.xbalance,
  });

  factory CusLedgerListModel.fromJson(Map<String, dynamic> json) =>
      CusLedgerListModel(
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
