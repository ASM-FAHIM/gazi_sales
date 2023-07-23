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
  RrNotificationModel({
    required this.xtornum,
    required this.xstatustor,
    required this.xdate,
    required this.twhdesc,
    required this.xtwh,
    required this.xregi,
    required this.xshift,
    required this.xlong,
    required this.preparerName,
    required this.preparerDesignation,
    required this.preparerXdeptname,
  });

  String xtornum;
  String xstatustor;
  String xdate;
  String twhdesc;
  String xtwh;
  String xregi;
  String xshift;
  String xlong;
  String preparerName;
  String preparerDesignation;
  String preparerXdeptname;

  factory RrNotificationModel.fromJson(Map<String, dynamic> json) =>
      RrNotificationModel(
        xtornum: json["xtornum"] ?? ' ',
        xstatustor: json["xstatustor"] ?? ' ',
        xdate: json["xdate"] ?? ' ',
        twhdesc: json["twhdesc"] ?? ' ',
        xtwh: json["xtwh"] ?? ' ',
        xregi: json["xregi"] ?? ' ',
        xshift: json["xshift"] ?? ' ',
        xlong: json["xlong"] ?? ' ',
        preparerName: json["preparer_name"] ?? ' ',
        preparerDesignation: json["preparer_designation"] ?? ' ',
        preparerXdeptname: json["preparer_xdeptname"] ?? ' ',
      );

  Map<String, dynamic> toJson() => {
        "xtornum": xtornum,
        "xstatustor": xstatustor,
        "xdate": xdate,
        "twhdesc": twhdesc,
        "xtwh": xtwh,
        "xregi": xregi,
        "xshift": xshift,
        "xlong": xlong,
        "preparer_name": preparerName,
        "preparer_designation": preparerDesignation,
        "preparer_xdeptname": preparerXdeptname,
      };
}
