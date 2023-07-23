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
  ToNotificationModel({
    required this.zid,
    required this.xidsup,
    required this.xsuperior2,
    required this.xsuperior3,
    required this.xtornum,
    required this.xstatustor,
    required this.twhdesc,
    required this.xdate,
    required this.xfwh,
    required this.xtwh,
    required this.xfbrname,
    required this.xregi,
    required this.xshift,
    required this.xlong,
    required this.xnote,
    required this.preparerName,
    required this.preparerXdesignation,
    required this.preparerXdeptname,
  });

  int zid;
  String xidsup;
  String xsuperior2;
  String xsuperior3;
  String xtornum;
  String xstatustor;
  String twhdesc;
  String xdate;
  String xfwh;
  String xtwh;
  String xfbrname;
  String xregi;
  String xshift;
  String xlong;
  String xnote;
  String preparerName;
  String preparerXdesignation;
  String preparerXdeptname;

  factory ToNotificationModel.fromJson(Map<String, dynamic> json) =>
      ToNotificationModel(
        zid: json["zid"] ?? ' ',
        xidsup: json["xidsup"] ?? ' ',
        xsuperior2: json["xsuperior2"] ?? ' ',
        xsuperior3: json["xsuperior3"] ?? ' ',
        xtornum: json["xtornum"] ?? ' ',
        xstatustor: json["xstatustor"] ?? ' ',
        twhdesc: json["twhdesc"] ?? ' ',
        xdate: json["xdate"] ?? ' ',
        xfwh: json["xfwh"] ?? ' ',
        xtwh: json["xtwh"] ?? ' ',
        xfbrname: json["xfbrname"] ?? ' ',
        xregi: json["xregi"] ?? ' ',
        xshift: json["xshift"] ?? ' ',
        xlong: json["xlong"] ?? ' ',
        xnote: json["xnote"] ?? ' ',
        preparerName: json["preparer_name"] ?? ' ',
        preparerXdesignation: json["preparer_xdesignation"] ?? ' ',
        preparerXdeptname: json["preparer_xdeptname"] ?? ' ',
      );

  Map<String, dynamic> toJson() => {
        "zid": zid,
        "xidsup": xidsup,
        "xsuperior2": xsuperior2,
        "xsuperior3": xsuperior3,
        "xtornum": xtornum,
        "xstatustor": xstatustor,
        "twhdesc": twhdesc,
        "xdate": xdate,
        "xfwh": xfwh,
        "xtwh": xtwh,
        "xfbrname": xfbrname,
        "xregi": xregi,
        "xshift": xshift,
        "xlong": xlong,
        "xnote": xnote,
        "preparer_name": preparerName,
        "preparer_xdesignation": preparerXdesignation,
        "preparer_xdeptname": preparerXdeptname,
      };
}
