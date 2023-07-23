// To parse this JSON data, do
//
//     final lreNotificationModel = lreNotificationModelFromJson(jsonString);

import 'dart:convert';

List<LreNotificationModel> lreNotificationModelFromJson(String str) =>
    List<LreNotificationModel>.from(
        json.decode(str).map((x) => LreNotificationModel.fromJson(x)));

String lreNotificationModelToJson(List<LreNotificationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LreNotificationModel {
  LreNotificationModel({
    required this.xtornum,
    required this.xdate,
    required this.xdaterec,
    required this.xfwh,
    required this.twhdesc,
    required this.xref,
    required this.xacc,
    required this.xaccdesc,
    required this.xloannum,
    required this.xtwh,
    required this.xregi,
    required this.xshift,
    required this.xstatustor,
    required this.xloanature,
    required this.xlong,
    required this.preparerName,
    required this.preparerXdesignation,
    required this.preparerXdeptname,
    required this.reviewer1Name,
    required this.reviewer1Designation,
    required this.reviewer2Xdeptname,
    required this.reviewer2Name,
    required this.reviewer2Designation,
  });

  String xtornum;
  String xdate;
  String xdaterec;
  String xfwh;
  String twhdesc;
  String xref;
  String xacc;
  String xaccdesc;
  String xloannum;
  String xtwh;
  String xregi;
  String xshift;
  String xstatustor;
  String xloanature;
  String xlong;
  String preparerName;
  String preparerXdesignation;
  String preparerXdeptname;
  String reviewer1Name;
  String reviewer1Designation;
  String reviewer2Xdeptname;
  String reviewer2Name;
  String reviewer2Designation;

  factory LreNotificationModel.fromJson(Map<String, dynamic> json) =>
      LreNotificationModel(
        xtornum: json["xtornum"] ?? ' ',
        xdate: json["xdate"] ?? ' ',
        xdaterec: json["xdaterec"] ?? ' ',
        xfwh: json["xfwh"] ?? ' ',
        twhdesc: json["twhdesc"] ?? ' ',
        xref: json["xref"] ?? ' ',
        xacc: json["xacc"] ?? ' ',
        xaccdesc: json["xaccdesc"] ?? ' ',
        xloannum: json["xloannum"] ?? ' ',
        xtwh: json["xtwh"] ?? ' ',
        xregi: json["xregi"] ?? ' ',
        xshift: json["xshift"] ?? ' ',
        xstatustor: json["xstatustor"] ?? ' ',
        xloanature: json["xloanature"] ?? ' ',
        xlong: json["xlong"] ?? ' ',
        preparerName: json["preparer_name"] ?? ' ',
        preparerXdesignation: json["preparer_xdesignation"] ?? ' ',
        preparerXdeptname: json["preparer_xdeptname"] ?? ' ',
        reviewer1Name: json["reviewer1_name"] ?? ' ',
        reviewer1Designation: json["reviewer1_designation"] ?? ' ',
        reviewer2Xdeptname: json["reviewer2_xdeptname"] ?? ' ',
        reviewer2Name: json["reviewer2_name"] ?? ' ',
        reviewer2Designation: json["reviewer2_designation"] ?? ' ',
      );

  Map<String, dynamic> toJson() => {
        "xtornum": xtornum,
        "xdate": xdate,
        "xdaterec": xdaterec,
        "xfwh": xfwh,
        "twhdesc": twhdesc,
        "xref": xref,
        "xacc": xacc,
        "xaccdesc": xaccdesc,
        "xloannum": xloannum,
        "xtwh": xtwh,
        "xregi": xregi,
        "xshift": xshift,
        "xstatustor": xstatustor,
        "xloanature": xloanature,
        "xlong": xlong,
        "preparer_name": preparerName,
        "preparer_xdesignation": preparerXdesignation,
        "preparer_xdeptname": preparerXdeptname,
        "reviewer1_name": reviewer1Name,
        "reviewer1_designation": reviewer1Designation,
        "reviewer2_xdeptname": reviewer2Xdeptname,
        "reviewer2_name": reviewer2Name,
        "reviewer2_designation": reviewer2Designation,
      };
}
