// To parse this JSON data, do
//
//     final toNotificationModel = toNotificationModelFromJson(jsonString);

import 'dart:convert';

List<ToNotificationModel> toNotificationModelFromJson(String str) =>
    List<ToNotificationModel>.from(
        json.decode(str).map((x) => ToNotificationModel.fromJson(x)));

String toNotificationModelToJson(List<ToNotificationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ToNotificationModel {
  String xtornum;
  String xdate;
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
  String reviewer1Xdeptname;
  String reviewer2Name;
  String reviewer2Designation;
  String reviewer2Xdeptname;
  String signrejectName;
  String signrejectDesignation;
  String signrejectXdeptname;

  ToNotificationModel({
    required this.xtornum,
    required this.xdate,
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
    required this.reviewer1Xdeptname,
    required this.reviewer2Name,
    required this.reviewer2Designation,
    required this.reviewer2Xdeptname,
    required this.signrejectName,
    required this.signrejectDesignation,
    required this.signrejectXdeptname,
  });

  factory ToNotificationModel.fromJson(Map<String, dynamic> json) =>
      ToNotificationModel(
        xtornum: json["xtornum"],
        xdate: json["xdate"],
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
        reviewer1Xdeptname: json["reviewer1_xdeptname"],
        reviewer2Name: json["reviewer2_name"],
        reviewer2Designation: json["reviewer2_designation"],
        reviewer2Xdeptname: json["reviewer2_xdeptname"],
        signrejectName: json["signreject_name"],
        signrejectDesignation: json["signreject_designation"],
        signrejectXdeptname: json["signreject_xdeptname"],
      );

  Map<String, dynamic> toJson() => {
        "xtornum": xtornum,
        "xdate": xdate,
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
        "reviewer1_xdeptname": reviewer1Xdeptname,
        "reviewer2_name": reviewer2Name,
        "reviewer2_designation": reviewer2Designation,
        "reviewer2_xdeptname": reviewer2Xdeptname,
        "signreject_name": signrejectName,
        "signreject_designation": signrejectDesignation,
        "signreject_xdeptname": signrejectXdeptname,
      };
}
