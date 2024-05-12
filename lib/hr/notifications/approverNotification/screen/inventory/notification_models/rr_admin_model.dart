// To parse this JSON data, do
//
//     final rrNotificationModel = rrNotificationModelFromJson(jsonString);

import 'dart:convert';

List<RrNotificationModel> rrNotificationModelFromJson(String str) =>
    List<RrNotificationModel>.from(
        json.decode(str).map((x) => RrNotificationModel.fromJson(x)));

String rrNotificationModelToJson(List<RrNotificationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RrNotificationModel {
  String xtornum;
  String xdate;
  String twhdesc;
  String xtwh;
  String regidesc;
  String xshift;
  String xlong;
  String xstatustor;
  String statustordesc;
  String preparerName;
  String preparerXdesignation;
  String preparerXdeptname;

  RrNotificationModel({
    required this.xtornum,
    required this.xdate,
    required this.twhdesc,
    required this.xtwh,
    required this.regidesc,
    required this.xshift,
    required this.xlong,
    required this.xstatustor,
    required this.statustordesc,
    required this.preparerName,
    required this.preparerXdesignation,
    required this.preparerXdeptname,
  });

  factory RrNotificationModel.fromJson(Map<String, dynamic> json) =>
      RrNotificationModel(
        xtornum: json["xtornum"],
        xdate: json["xdate"],
        twhdesc: json["twhdesc"],
        xtwh: json["xtwh"],
        regidesc: json["regidesc"],
        xshift: json["xshift"],
        xlong: json["xlong"],
        xstatustor: json["xstatustor"],
        statustordesc: json["statustordesc"],
        preparerName: json["preparer_name"],
        preparerXdesignation: json["preparer_xdesignation"],
        preparerXdeptname: json["preparer_xdeptname"],
      );

  Map<String, dynamic> toJson() => {
        "xtornum": xtornum,
        "xdate": xdate,
        "twhdesc": twhdesc,
        "xtwh": xtwh,
        "regidesc": regidesc,
        "xshift": xshift,
        "xlong": xlong,
        "xstatustor": xstatustor,
        "statustordesc": statustordesc,
        "preparer_name": preparerName,
        "preparer_xdesignation": preparerXdesignation,
        "preparer_xdeptname": preparerXdeptname,
      };
}
