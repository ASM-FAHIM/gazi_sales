// To parse this JSON data, do
//
//     final damageNotificationModel = damageNotificationModelFromJson(jsonString);

import 'dart:convert';

List<DamageNotificationModel> damageNotificationModelFromJson(String str) =>
    List<DamageNotificationModel>.from(
        json.decode(str).map((x) => DamageNotificationModel.fromJson(x)));

String damageNotificationModelToJson(List<DamageNotificationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DamageNotificationModel {
  String xtornum;
  String xdate;
  String twhdesc;
  String xfwh;
  String xfbrname;
  String xref;
  String xtwh;
  String xtbrname;
  String regidesc;
  String xlong;
  String xnote;
  String xstatustor;
  String statustordesc;
  String preparerName;
  String preparerXdesignation;
  String preparerXdeptname;
  String reviewer1Name;
  String reviewer1Designation;
  String reviewer2Xdeptname;

  DamageNotificationModel({
    required this.xtornum,
    required this.xdate,
    required this.twhdesc,
    required this.xfwh,
    required this.xfbrname,
    required this.xref,
    required this.xtwh,
    required this.xtbrname,
    required this.regidesc,
    required this.xlong,
    required this.xnote,
    required this.xstatustor,
    required this.statustordesc,
    required this.preparerName,
    required this.preparerXdesignation,
    required this.preparerXdeptname,
    required this.reviewer1Name,
    required this.reviewer1Designation,
    required this.reviewer2Xdeptname,
  });

  factory DamageNotificationModel.fromJson(Map<String, dynamic> json) =>
      DamageNotificationModel(
        xtornum: json["xtornum"],
        xdate: json["xdate"],
        twhdesc: json["twhdesc"],
        xfwh: json["xfwh"],
        xfbrname: json["xfbrname"],
        xref: json["xref"],
        xtwh: json["xtwh"],
        xtbrname: json["xtbrname"],
        regidesc: json["regidesc"],
        xlong: json["xlong"],
        xnote: json["xnote"],
        xstatustor: json["xstatustor"],
        statustordesc: json["statustordesc"],
        preparerName: json["preparer_name"],
        preparerXdesignation: json["preparer_xdesignation"],
        preparerXdeptname: json["preparer_xdeptname"],
        reviewer1Name: json["reviewer1_name"],
        reviewer1Designation: json["reviewer1_designation"],
        reviewer2Xdeptname: json["reviewer2_xdeptname"],
      );

  Map<String, dynamic> toJson() => {
        "xtornum": xtornum,
        "xdate": xdate,
        "twhdesc": twhdesc,
        "xfwh": xfwh,
        "xfbrname": xfbrname,
        "xref": xref,
        "xtwh": xtwh,
        "xtbrname": xtbrname,
        "regidesc": regidesc,
        "xlong": xlong,
        "xnote": xnote,
        "xstatustor": xstatustor,
        "statustordesc": statustordesc,
        "preparer_name": preparerName,
        "preparer_xdesignation": preparerXdesignation,
        "preparer_xdeptname": preparerXdeptname,
        "reviewer1_name": reviewer1Name,
        "reviewer1_designation": reviewer1Designation,
        "reviewer2_xdeptname": reviewer2Xdeptname,
      };
}
