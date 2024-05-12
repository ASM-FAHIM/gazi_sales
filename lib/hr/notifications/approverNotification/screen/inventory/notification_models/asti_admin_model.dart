// To parse this JSON data, do
//
//     final astiNotificationModel = astiNotificationModelFromJson(jsonString);

import 'dart:convert';

List<AstiNotificationModel> astiNotificationModelFromJson(String str) =>
    List<AstiNotificationModel>.from(
        json.decode(str).map((x) => AstiNotificationModel.fromJson(x)));

String astiNotificationModelToJson(List<AstiNotificationModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AstiNotificationModel {
  AstiNotificationModel({
    required this.zid,
    required this.xidsup,
    required this.xsuperior2,
    required this.xsuperior3,
    required this.xtornum,
    required this.xstatustor,
    required this.xdate,
    required this.xdatereq,
    required this.xfwh,
    required this.xfbrname,
    required this.twhdesc,
    required this.xref,
    required this.xproject,
    required this.xprojectdesc,
    required this.xregi,
    required this.xshift,
    required this.xlong,
    required this.preparerName,
  });

  int zid;
  String xidsup;
  String xsuperior2;
  String xsuperior3;
  String xtornum;
  String xstatustor;
  String xdate;
  String xdatereq;
  String xfwh;
  String xfbrname;
  String twhdesc;
  String xref;
  dynamic xproject;
  dynamic xprojectdesc;
  String xregi;
  String xshift;
  String xlong;
  String preparerName;

  factory AstiNotificationModel.fromJson(Map<String, dynamic> json) =>
      AstiNotificationModel(
        zid: json["zid"] ?? ' ',
        xidsup: json["xidsup"] ?? ' ',
        xsuperior2: json["xsuperior2"] ?? ' ',
        xsuperior3: json["xsuperior3"] ?? ' ',
        xtornum: json["xtornum"] ?? ' ',
        xstatustor: json["xstatustor"] ?? ' ',
        xdate: json["xdate"] ?? ' ',
        xdatereq: json["xdatereq"] ?? ' ',
        xfwh: json["xfwh"] ?? ' ',
        xfbrname: json["xfbrname"] ?? ' ',
        twhdesc: json["twhdesc"] ?? ' ',
        xref: json["xref"] ?? ' ',
        xproject: json["xproject"] ?? ' ',
        xprojectdesc: json["xprojectdesc"] ?? ' ',
        xregi: json["xregi"] ?? ' ',
        xshift: json["xshift"] ?? ' ',
        xlong: json["xlong"] ?? ' ',
        preparerName: json["preparer_name"] ?? ' ',
      );

  Map<String, dynamic> toJson() => {
        "zid": zid,
        "xidsup": xidsup,
        "xsuperior2": xsuperior2,
        "xsuperior3": xsuperior3,
        "xtornum": xtornum,
        "xstatustor": xstatustor,
        "xdate": xdate,
        "xdatereq": xdatereq,
        "xfwh": xfwh,
        "xfbrname": xfbrname,
        "twhdesc": twhdesc,
        "xref": xref,
        "xproject": xproject,
        "xprojectdesc": xprojectdesc,
        "xregi": xregi,
        "xshift": xshift,
        "xlong": xlong,
        "preparer_name": preparerName,
      };
}
