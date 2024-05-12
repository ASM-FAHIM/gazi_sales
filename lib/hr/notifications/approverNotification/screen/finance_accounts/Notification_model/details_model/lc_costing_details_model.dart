// To parse this JSON data, do
//
//     final lcCostingDetailsModel = lcCostingDetailsModelFromJson(jsonString);

import 'dart:convert';

List<LcCostingDetailsModel> lcCostingDetailsModelFromJson(String str) => List<LcCostingDetailsModel>.from(json.decode(str).map((x) => LcCostingDetailsModel.fromJson(x)));

String lcCostingDetailsModelToJson(List<LcCostingDetailsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LcCostingDetailsModel {
  String? xrow;
  String? xtrn;
  String? xaccdr;
  String? descdr;
  String? xacccr;
  String? desccdr;
  String? xprime;
  String? xstatusapdesc;
  String? xreqnum;

  LcCostingDetailsModel({
    this.xrow,
    this.xtrn,
    this.xaccdr,
    this.descdr,
    this.xacccr,
    this.desccdr,
    this.xprime,
    this.xstatusapdesc,
    this.xreqnum,
  });

  factory LcCostingDetailsModel.fromJson(Map<String, dynamic> json) => LcCostingDetailsModel(
    xrow: json["xrow"],
    xtrn: json["xtrn"],
    xaccdr: json["xaccdr"],
    descdr: json["descdr"],
    xacccr: json["xacccr"],
    desccdr: json["desccdr"],
    xprime: json["xprime"],
    xstatusapdesc: json["xstatusapdesc"],
    xreqnum: json["xreqnum"],
  );

  Map<String, dynamic> toJson() => {
    "xrow": xrow,
    "xtrn": xtrn,
    "xaccdr": xaccdr,
    "descdr": descdr,
    "xacccr": xacccr,
    "desccdr": desccdr,
    "xprime": xprime,
    "xstatusapdesc": xstatusapdesc,
    "xreqnum": xreqnum,
  };
}
