// To parse this JSON data, do
//
//     final inspectionNotificationModel = inspectionNotificationModelFromJson(jsonString);

import 'dart:convert';

List<InspectionNotificationModel> inspectionNotificationModelFromJson(
        String str) =>
    List<InspectionNotificationModel>.from(
        json.decode(str).map((x) => InspectionNotificationModel.fromJson(x)));

String inspectionNotificationModelToJson(
        List<InspectionNotificationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InspectionNotificationModel {
  InspectionNotificationModel({
    required this.xtornum,
    required this.xdate,
    required this.xfwh,
    required this.xfbrname,
    required this.xref,
    required this.xtwh,
    required this.xtbrname,
    required this.xshift,
    required this.xstatustor,
    required this.xlong,
    required this.preparerName,
    required this.preparerXdesignation,
    required this.preparerXdeptname,
  });

  String xtornum;
  String xdate;
  String xfwh;
  String xfbrname;
  String xref;
  String xtwh;
  String xtbrname;
  dynamic xshift;
  String xstatustor;
  String xlong;
  String preparerName;
  String preparerXdesignation;
  String preparerXdeptname;

  factory InspectionNotificationModel.fromJson(Map<String, dynamic> json) =>
      InspectionNotificationModel(
        xtornum: json["xtornum"] ?? " ",
        xdate: json["xdate"] ?? " ",
        xfwh: json["xfwh"] ?? " ",
        xfbrname: json["xfbrname"] ?? " ",
        xref: json["xref"] ?? " ",
        xtwh: json["xtwh"] ?? " ",
        xtbrname: json["xtbrname"] ?? " ",
        xshift: json["xshift"] ?? " ",
        xstatustor: json["xstatustor"] ?? " ",
        xlong: json["xlong"] ?? " ",
        preparerName: json["preparer_name"] ?? " ",
        preparerXdesignation: json["preparer_xdesignation"] ?? " ",
        preparerXdeptname: json["preparer_xdeptname"] ?? " ",
      );

  Map<String, dynamic> toJson() => {
        "xtornum": xtornum,
        "xdate": xdate,
        "xfwh": xfwh,
        "xfbrname": xfbrname,
        "xref": xref,
        "xtwh": xtwh,
        "xtbrname": xtbrname,
        "xshift": xshift,
        "xstatustor": xstatustor,
        "xlong": xlong,
        "preparer_name": preparerName,
        "preparer_xdesignation": preparerXdesignation,
        "preparer_xdeptname": preparerXdeptname,
      };
}
