// To parse this JSON data, do
//
//     final cashAdvDetailsNotificationModel = cashAdvDetailsNotificationModelFromJson(jsonString);

import 'dart:convert';

List<CashAdvDetailsNotificationModel> cashAdvDetailsNotificationModelFromJson(String str) => List<CashAdvDetailsNotificationModel>.from(json.decode(str).map((x) => CashAdvDetailsNotificationModel.fromJson(x)));

String cashAdvDetailsNotificationModelToJson(List<CashAdvDetailsNotificationModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CashAdvDetailsNotificationModel {
  String? xrow;
  String? xitem;
  String? xdesc;
  String? xqtyreq;
  String? xqtyapv;
  String? xunitpur;
  String? xrate;
  String? xlineamt;
  String? xspecification;

  CashAdvDetailsNotificationModel({
    this.xrow,
    this.xitem,
    this.xdesc,
    this.xqtyreq,
    this.xqtyapv,
    this.xunitpur,
    this.xrate,
    this.xlineamt,
    this.xspecification,
  });

  factory CashAdvDetailsNotificationModel.fromJson(Map<String, dynamic> json) => CashAdvDetailsNotificationModel(
    xrow: json["xrow"],
    xitem: json["xitem"],
    xdesc: json["xdesc"],
    xqtyreq: json["xqtyreq"],
    xqtyapv: json["xqtyapv"],
    xunitpur: json["xunitpur"],
    xrate: json["xrate"],
    xlineamt: json["xlineamt"],
    xspecification: json["xspecification"],
  );

  Map<String, dynamic> toJson() => {
    "xrow": xrow,
    "xitem": xitem,
    "xdesc": xdesc,
    "xqtyreq": xqtyreq,
    "xqtyapv": xqtyapv,
    "xunitpur": xunitpur,
    "xrate": xrate,
    "xlineamt": xlineamt,
    "xspecification": xspecification,
  };
}
